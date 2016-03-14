require(lme4)
require(metafor)

#H1. # We predict that, if previous responses to the outcomes were based only on the emotional valence of the footage, 
# and not on the continuity of the footage with the prior scenario, then for the current experiment, 
# differences in looking time between the emotional and non-emotional victim outcomes should be consistent with what we found previously.

# H2. # We predict that, if the chimpanzees’ response to the outcomes is based only on the emotional valence of the footage, 
# and is not influenced by prior footage, then differences in both looking time and temperature changes between
# the outcomes should be matched between seeing them with no prior footage, and seeing them with prior, unrelated footage. 


videos.new <- read.csv("Data compiled.csv", header = T, na.strings = "NA")
levels(videos.new$Outcome)


# Pre-model checks:
# where indivs saw scene twice, decide which one to use:
# if they didn't watch scenario or outcome the first time, exclude (see list below)
table(videos.new$Chimp)
videos.new[videos.new$Chimp == ("SO"),]
# ed2 = 2
# ev2 = 2
# lb2 = 1 # drop LB 2
# pa2 = 3 # drop PA2 emotional.novel.horses, PA unemotional.novel.horses
# re2 = 1 # drop RE emotional outcome horses
# so2 = 2 # drop SO unemotional.victim, SO victim.masked

### FOR NOW: include original views unless they are 0
### LATER: CHECK diffs in views with LT > 0
# if they watched the first time but were interrupted, compare LT with second time to check for sign. diffs. in LT

drop1 <- subset(videos.new, Chimp != "LB2")
drop2 <- subset(drop1, Chimp != "ED2")
drop3 <- subset(drop2, Chimp != "EV2")
drop4 <- drop3[-which(drop3$Chimp == "PA" 
                          & drop3$Scenario == "Unemotional.novel.horses"),]
drop5 <- drop4[-which(drop4$Chimp == "PA2" 
                      & drop4$Scenario == "Emotional.novel.horses"),]
drop6 <- drop5[-which(drop5$Chimp == "PA2" 
                      & drop5$Scenario == "Unemotional.victim.horses"),]
drop7 <- drop6[-which(drop6$Chimp == "RE" 
                      & drop6$Scenario == "Emotional.outcome.horses"),]
drop8 <- drop7[-which(drop7$Chimp == "SO" 
                      & drop7$Scenario == "Carlos Unexpected"),]
drop9 <- drop8[-which(drop8$Chimp == "SO" 
                      & drop8$Outcome == "Victim.masked" & drop8$Horses == "N"),]
# 310 rows, removed 11


# change old data names to new data names:
# Carlos unexpected = Unemotional.victim
# Carlos expected = Emotional.victim
# Eric unexpected = Unemotional.outcome
# Eric expected = Emotional.outcome

# subset variables to exclude those with NAs
# # Remove NAs from data for multilevel models
drop10 <- drop9[c(1:3, 5:9, 11)]
vid.full <- na.omit(drop10)
# 273 rows

# proportion data is not normal, arcsine transform it for model
# retain zeros
hist(vid.full$Proportion.LT.Outcome)
hist(transf.arcsin(vid.full$Proportion.LT.Outcome)
, breaks = 20)                       
                       
# LT.Outcome has a lot of zeros which skews data, drop zeros, and log transform
vid.full[vid.full$LT.Outcome == 0,]
vidfulldrop <- vid.full[-which(vid.full$LT.Outcome == 0),]
# 259 rows

### 1. compare LT between old data and new data:
# - does LT to outcomes differ depending on whether they first see (1) chimp conflict(old), (2) horse conflict, or (3) no scenario
# long format
# Proportion LT[outcome lengths differ, proportions needed] to each outcome ~ chimp conflict[saw: Y/N] + horse conflict[saw: Y/N] + no scenario[saw: Y/N]
# repeated measures, run mlm (lmer)
# 4 models, 1 for each outcome type (1. Eric expected, 2. Eric unexpected, 3. Carlos expected, 4. Carlos unexpected)
# subset data to exclude new views of chimp conflict scenes
comp <- vid.full[-which(vid.full$Horses == "N" & vid.full$No.scenario == "N" & vid.full$New == "Y"),]

m1 <- lmer(transf.arcsin(Proportion.LT.Outcome) ~ Scenario
           + (1|Chimp), data = comp[which(comp$Outcome == "Emotional.victim"),])
m2 <- lmer(transf.arcsin(Proportion.LT.Outcome) ~ Scenario
           + (1|Chimp), data = comp[which(comp$Outcome == "Unemotional.victim"),])
comp$Scenario <- relevel(comp$Scenario, ref = "Eric Expected")
m3 <- lmer(transf.arcsin(Proportion.LT.Outcome) ~ Scenario
           + (1|Chimp), data = comp[which(comp$Outcome == "Emotional.outcome"),])
# LT differs between horses & chimps
m4 <- lmer(transf.arcsin(Proportion.LT.Outcome) ~ Scenario
           + (1|Chimp), data = comp[which(comp$Outcome == "Unemotional.outcome"),])
# LT differs between horses & chimps, only

coefs <- data.frame(coef(summary(m1)))
coefs$p.z <- 2 * (1 - pnorm(abs(coefs$t.value)))
coefs


### 2. compare LT within new data
# For *new data*, compare LT (raw, not proportion: outcome lengths are the same) between (2) horse conflict and (3) no scenario
# long format
# Raw LT ~ scene[column that specifices horses or no scenario]
# 8 models, 1 for each scenario (1. Eric expected, 2. Eric unexpected, 3. Victim masked, 4. Bystander masked, 5. Carlos expected, 6. Carlos unexpected, 7. Novel victim, 8. Novel unemotional)
fm1 <- lmer(log(LT.Outcome) ~ Scenario + (1|Chimp), data = vidfulldrop[which(vidfulldrop$Outcome == "Victim.masked"),])
fm2 <- lmer(log(LT.Outcome) ~ Scenario + (1|Chimp), data = vidfulldrop[which(vidfulldrop$Outcome == "Bystander.masked"),])
# LT higher to outcome after no scenario than horses
fm3 <- lmer(log(LT.Outcome) ~ Scenario + (1|Chimp), data = vidfulldrop[which(vidfulldrop$Outcome == "Emotional.novel"),])
fm6 <- lmer(log(LT.Outcome) ~ Scenario + (1|Chimp), data = vidfulldrop[which(vidfulldrop$Outcome == "Unemotional.novel"),])
# this one p ~ .05

## for below models I need to subset Scenario to exclude 'Carlos Expected' or whatever chimp conflict scene
sub1 <- vidfulldrop[-which(vidfulldrop$Scenario == "Eric Unexpected" 
                      | vidfulldrop$Scenario == "Carlos Unexpected" | vidfulldrop$Scenario == "Carlos Expected" 
                      | vidfulldrop$Scenario == "Eric Expected"),]
fm7 <- lmer(log(LT.Outcome) ~ Scenario + (1|Chimp), data = sub1[which(sub1$Outcome == "Unemotional.outcome"),])
# signif
fm8 <- lmer(log(LT.Outcome) ~ Scenario + (1|Chimp), data = sub1[which(sub1$Outcome == "Unemotional.victim"),])
fm4 <- lmer(log(LT.Outcome) ~ Scenario + (1|Chimp), data = sub1[which(sub1$Outcome == "Emotional.victim"),])
fm5 <- lmer(log(LT.Outcome) ~ Scenario + (1|Chimp), data = sub1[which(sub1$Outcome == "Emotional.outcome"),])
# p = 0.05


coefs <- data.frame(coef(summary(fm1)))
coefs$p.z <- 2 * (1 - pnorm(abs(coefs$t.value)))
coefs


### 3. for new data, compare LT between outcomes to examine diffs in response to victim vs. novel
# 2 models (emotional & unemotional) for horses scenario Carlos outcomes (using raw data, outcomes all the same length) including novel scenes
# 2 models for no scenario Carlos outcomes (using raw data, outcomes all the same length) including novel scenes
# LT ~ outcome[factor with 4 levels]

# subset data to include only Carlos emotional outcomes
carlos.em <- vidfulldrop[which(vidfulldrop$Outcome == "Emotional.novel" | vidfulldrop$Outcome == "Emotional.victim"),]
mm1 <- lmer(log(LT.Outcome) ~ Outcome + (1|Chimp), data = carlos.em[carlos.em$Horses == "N",])
# not signif
#mm2 <- lmer(log(LT.Outcome) ~ Outcome + (1|Chimp), data = carlos.em[carlos.em$Horses == "Y"])
# too few cases to run this model; instead run model including horses and no horses
mm2 <- lmer(log(LT.Outcome) ~ Outcome + (1|Chimp), data = carlos.em)

# subset data to include only Carlos unemotional outcomes
carlos.un <- vidfulldrop[which(vidfulldrop$Outcome == "Unemotional.novel" | vidfulldrop$Outcome == "Unemotional.victim"),]
mm3 <- lmer(log(LT.Outcome) ~ Outcome + (1|Chimp), data = carlos.un[carlos.un$Horses == "N",])
# signif
mm4 <- lmer(log(LT.Outcome) ~ Outcome + (1|Chimp), data = carlos.un)
# signif

coefs <- data.frame(coef(summary(mm1)))
coefs$p.z <- 2 * (1 - pnorm(abs(coefs$t.value)))
coefs


### 4. for new data, compare LT between outcomes to examine diffs in response to masked vs. unmasked scenes
# 1 model for horses scenario Eric outcomes (using prop. data, unemotional outcome differs in length) including novel scenes
# 1 model for no scenario Eric outcomes (using prop. data, unemotional outcome differs in length) including novel scenes
# LT ~ outcome[factor with 4 levels]
# subset data to include only Eric emotional outcomes
eric <- vidfulldrop[which(vidfulldrop$Outcome == "Bystander.masked" | vidfulldrop$Outcome == "Emotional.outcome" 
                           | vidfulldrop$Outcome == "Victim.masked"),]
eric$Outcome <- relevel(eric$Outcome, ref = "Emotional.outcome")
# compare emotional masked scenes to unmasked emotional scene
mm5 <- lmer(log(LT.Outcome) ~ Outcome + (1|Chimp), data = eric)

# subset data to include all 4 Eric outcomes
eric2 <- vidfulldrop[which(vidfulldrop$Outcome == "Bystander.masked" | vidfulldrop$Outcome == "Emotional.outcome" 
                          | vidfulldrop$Outcome == "Unemotional.outcome"
                          | vidfulldrop$Outcome == "Victim.masked"),]
# compare emotional scenes to unemotional scene
eric2$Outcome <- relevel(eric2$Outcome, ref = "Unemotional.outcome")
mm6 <- lmer(log(LT.Outcome) ~ Outcome + (1|Chimp), data = eric2)
# LT to victim masked is significantly higher than unemotional

coefs <- data.frame(coef(summary(mm5)))
coefs$p.z <- 2 * (1 - pnorm(abs(coefs$t.value)))
coefs

# compare emotional masked scenes to unmasked emotional scenes for horses only
mm7 <- lmer(log(LT.Outcome) ~ Outcome + (1|Chimp), data = eric[eric$Horses == "Y",])
# LT for bystander masked signif lower than emotional scene

# compare emotional masked scenes to unmasked emotional scenes for no horses 
mm8 <- lmer(log(LT.Outcome) ~ Outcome + (1|Chimp), data = eric[eric$Horses == "N",])
# LT for bystander masked signif higher than emotional scene

# compare emotional scenes to unemotional scene for horses only
mm9 <- lmer(log(LT.Outcome) ~ Outcome + (1|Chimp), data = eric2[eric$Horses == "Y",])

# compare emotional scenes to unemotional scene for horses only
mm10 <- lmer(log(LT.Outcome) ~ Outcome + (1|Chimp), data = eric2[eric$Horses == "N",])
# LT for masked scenes signif higher than umemot outcome 

### 5. For individuals that saw chimp conflict scenes on both occasions (old and new) compare raw LT between outcomes
# long format
# paired t test, 1 for each outcome
# raw LT ~ year[column which specifices when each scene was viewed, ie with 1 or 2]


hist(ar)