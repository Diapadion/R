### Analysis of Ruth Sonnweber's cognitive data

# 1. Distinguish between Interaction levels
#   a. chimps who did not participate
#   b. chimps who were trained but did not proceed to testing (EM, LB, ED, LO, DA)
#   c. chimps who were tested but did not complete all stages (CI, EV, PA)
#   d. chimps who finished all tasks (FK, KL, PE)
# 2. Model accuracy across all trials
#   - all training trials? (etc...)
# 3. Look at the number of trials taken to complete each stage of training
# 4. Model RT
#   - number of touches

#######

### [1] Interaction levels

# a. HE, LI, RE, Q, KD, LU, SO
# b. EM, LB, ED, LO, DA
# c. CI, EV, PA
# d. FK, KL, PE 

RSpartic = as.ordered(c(2,1,1,1,2,3,0,3,0,0,1,1,0,2,3,0,0,0))
intLvlPers = cbind(aggPers,RSpartic)

RStm <- aggregate(intLvlPers, by=list(intLvlPers$RSpartic), FUN=mean)
RSts <- aggregate(intLvlPers, by=list(intLvlPers$RSpartic), FUN=sd)

mp = barplot(height=as.matrix(RStm[4:9]),beside=TRUE,
             #legend.text=c('Never participated','Incomplete participation','Completed full sessions')
             ,ylim=c(0,7))

segments(c(mp), c(t(t(RStm[4:9] - RSts[4:9]))), c(mp),c(t(t(RStm[4:9] + RSts[4:9]))), lwd=2)

#polr doesn't work for all predictors
library(MASS)
RS.om.lvl.0 <- polr(RSpartic ~ Dominance + Conscientiousness + Openness + Neuroticism +
                      Agreeableness + Extraversion,
                    data = intLvlPers, model = "probit"
                    )

# nor does clm...
library(ordinal)
RS.om.lvl.0 <- clm(RSpartic ~ Dominance + Conscientiousness + Openness + Neuroticism +
       Agreeableness + Extraversion,
     data = intLvlPers , link = "probit"
)

# ... nope
library(rms)
RS.om.lvl.0 <- #orm # is original
  lrm(RSpartic ~ Dominance + Conscientiousness + Openness + Neuroticism +
                     Agreeableness + Extraversion,
                   data = intLvlPers #, model = "probit"
)


# 
library(glmnet)

fit3=glmnet(as.matrix(intLvlPers[,3:8]),
            as.double(intLvlPers$RSpartic)-1,
            #lapply(intLvlPers$RSpartic,as.numeric),
            family="multinomial")


# I have no idea
library(VGAM)
RS.v.0 <- vglm(RSpartic ~ Dominance + Conscientiousness + Openness + Neuroticism +
                 Agreeableness + Extraversion,
               data = intLvlPers,
               family=cumulative(link="multilogit", parallel=TRUE)
)


# let's do this first with the Tukey tests
#library(multcomp)
library(DTK)
RlvlS.dtk.d = DTK.test(intLvlPers$Dominance, intLvlPers$RSpartic)
RlvlS.dtk.c = DTK.test(intLvlPers$Conscientiousness, intLvlPers$RSpartic)
RlvlS.dtk.n = DTK.test(intLvlPers$Neuroticism, intLvlPers$RSpartic)
RlvlS.dtk.o = DTK.test(intLvlPers$Openness, intLvlPers$RSpartic)

library(MASS)
mod.polr.o <- polr(RSpartic ~ Openness + I(Openness^2), data=intLvlPers)
mod.polr.c <- polr(RSpartic ~ Conscientiousness + I(Conscientiousness^2), data=intLvlPers)
mod.polr.d <- polr(RSpartic ~ Dominance + I(Dominance^2), data=intLvlPers) # + I(Dominance^2)
mod.polr.n <- polr(RSpartic ~ Neuroticism + I(Neuroticism^2), data=intLvlPers)

# below is consistent with above
mod.polr.ce <- polr(RSpartic ~ Extraversion + Conscientiousness, data=intLvlPers)
mod.polr.oa <- polr(RSpartic ~ Openness + Agreeableness, data=intLvlPers)


mod.polr.odnc <- polr(RSpartic ~ Openness + Dominance + Neuroticism + Conscientiousness, data=intLvlPers)
mod.polr.all <- polr(RSpartic ~ Extraversion + Openness + Dominance + Neuroticism + Conscientiousness, data=intLvlPers)


### [2] Accuracy

# "simple" GLMM of accuracy predicted by personality
library(lme4)
rs.glm1 <- glmer(Correctness ~ Dominance + Conscientiousness + Openness + Neuroticism +
                   Agreeableness + Extraversion +
                   (1 | chimp) + (1 | stage/TrialType)  #(1 | Section) + (1 | TrialType) + ,
                 , data = temp, family = binomial
)
# library(arm)
# standardize() # converts everything to 2SE coefficients

rs.glm1.0 <- glmer(Correctness ~ Dominance + Conscientiousness + Openness + Neuroticism +
                     Agreeableness + Extraversion + 
                     #Trial +  # adding this does... well, nothing.
                     (1 | chimp) + (1 | stage) + (1 | TrialType) #+ (1 | Section) + (1 | depend)
                                      # last two look degenerate
                   , data = temp, family = binomial
)

confint(rs.glm1.0, method="boot")
rs.accu.ci = confint(rs.glm1.0, method="prof")

# improve grouping with regards to AB,AA and training stages

# what about just at testing
# rs.glm1.tstOnly <- glmer(Correctness ~ Dominance + Conscientiousness + Openness + Neuroticism +
#                        Agreeableness + Extraversion +
#                        (1 | chimp) #+ (1 | TrialType)  #(1 | Section) + (1 | TrialType) + ,
#                      , data = temp[temp$TrialType==' Test',], family = binomial
# )
## there are multicolinearity / rank deficiency issues with the above, so just leave it



### Learning
# after 33/48 trials, chimps progressed to next stage

# how can we get a handle on this?
setwd("training/2-choice AA1 black/")


# [3] Trials to reach criterion 
#     (or prematurely stop?)

#? - Incorrect out of total trials?



TraTri = temp[temp$stage!='test',]
TraTri.1 = TraTri[TraTri$Correctness==' Correct',]

library(plyr)
#TraTri = aggregate(TraTri, by=list('chimp','stage'), FUN=count)

TraTri = count(TraTri, c("chimp","stage"))
TraTri.1 = count(TraTri.1, c("chimp","stage"))
TraTri$correct = TraTri.1$freq

TraTri$prop = TraTri$correct / TraTri$freq

TraTri = merge(TraTri,aggPers, by.x= "chimp", "Chimp")

head(TraTri)


# sketch model

RS.trial.lmm.tot <- lmer(log(freq) ~ Dominance + Conscientiousness + Openness + Neuroticism +
                       Agreeableness + Extraversion +
                       (1 | chimp) + (1 | stage)
                     , data = TraTri)
                       
RS.trial.lmm.prop <- lmer(prop ~ Dominance + Conscientiousness + Openness + Neuroticism +
                       Agreeableness + Extraversion +
                       (1 | chimp) + (1 | stage)
                     , data = TraTri)

# I don't think there is anything here for this kind of model

## Can we model the cumulative functions? Is that what the GLMs do?


# [4] RT

library(car)

rs.rt.lmm.all <- lmer(log(RT) ~ Dominance + Conscientiousness + Openness + Neuroticism +
                   Agreeableness + Extraversion +
                     (1 | chimp) + (1 | stage)+ (1 | TrialType) #+ (1 | Section) + (1 | depend)
                 , data = temp
)

rs.rt.lmm.1 <- lmer(log(RT) ~ Dominance + Conscientiousness + Openness + Neuroticism +
                        Agreeableness + Extraversion +
                        (1 | chimp) + (1 | stage) + (1 | TrialType) #+ (1 | Section) + (1 | depend)
                      , data = temp[temp$Correctness==' Correct',]
)

# No effects.

## Number of touches:


# 738 (?)
# 728

grep("/",as.character(temp$Coordinates[728]))

for (i in 1:dim(temp)[1]){
  temp$touches[i] = countCharOccurrences('/', as.character(temp$Coordinates[i]))
  
}
# okay that function makes it work
#countCharOccurrences('/', as.character(temp$Coordinates[728]))


rs.touch.lmm <- glmer(touches ~ Dominance + Conscientiousness + Openness + Neuroticism +
                      Agreeableness + Extraversion +
                      (1 | chimp) + (1 | stage) + (1 | Section) + (1 | TrialType) + (1 | depend)
                    , data = temp
                    #, data = temp[temp$Correctness==' Correct',]
                    , family = poisson(link = "log")
)
confint(rs.touch.lmm)

rs.touch.lmm.0 <- glmer(touches ~ Dominance + Conscientiousness + Openness + Neuroticism +
                        Agreeableness + Extraversion +
                        (1 | chimp) + (1 | stage) + (1 | Section) + (1 | TrialType) + (1 | depend)
                      #, data = temp
                      , data = temp[temp$Correctness==' Correct',]
                      , family = poisson(link = "log")
)

rs.touch.lmm.1 <- glmer(touches ~ Dominance + Conscientiousness + Openness + Neuroticism +
                        Agreeableness + Extraversion +
                        (1 | chimp) + (1 | stage) + (1 | Section) + (1 | TrialType) + (1 | depend)
                      #, data = temp
                      , data = temp[temp$Correctness==' Incorrect',]
                      , family = poisson(link = "log")
)


countCharOccurrences <- function(char, s) {
  s2 <- gsub(char,"",s)
  return (nchar(s) - nchar(s2))
}
