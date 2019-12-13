### Exploratory and confirmatory modeling of fWHR, personality, etc.

library(caret)
library(party)
library(rpart)
library(REEMtree)
library(lme4)
library(arm)
library(psych)


s <- function(x) {scale(x)}



### loading in composite sheet

chFP = read.csv('chimpFacesPersDemos.csv')
chFP = chFP[,-1]

# colnames(chFP)
# dim(chFP)
chFP = chFP[!is.na(chFP$fWHR),]
# dim(chFP)



### Descriptive Statistics

#levels(chFP$ID)
table(droplevels(chFP$ID[chFP$location=='Edinburgh'|chFP$location=='Edinburgh.VADW'])) # Number of Edi chimps and images/chimp
sum(table(droplevels(chFP$ID[chFP$location=='Bastrop']))) # Number of Bastrop chimps
table(droplevels(chFP$ID[chFP$location=='Japan'])) # NUmber of Japanese chimps and images/

table(chFP$Sex[!duplicated(chFP$ID)]) # Number of males and females

mean(chFP$Age[!duplicated(chFP$ID)], na.rm=TRUE) # Mean age
sd(chFP$Age[!duplicated(chFP$ID)], na.rm=TRUE) # SD age
min(chFP$Age[!duplicated(chFP$ID)], na.rm=TRUE) # Min age
max(chFP$Age[!duplicated(chFP$ID)], na.rm=TRUE) # Max age

# chFP$Age[chFP$location=='Edinburgh']
# !duplicated(chFP$ID)&chFP$location=='Edinburgh'
# chFP$ID[chFP$location=='Edinburgh']
## What is the below for?
#chFP$Age[!duplicated(chFP$ID[chFP$location=='Edinburgh'])] # WRONG
chFP$Age[!duplicated(chFP$ID)&chFP$location=='Edinburgh']
#chFP$Age[!duplicated(chFP$ID=='Liberius')] # WRONG
chFP$Age[!duplicated(chFP$ID=='Liberius')&chFP$location=='Edinburgh'] # this is just the first observation of Lib...

## Aggregate age across individuals then find the mean and SD for the group
Edi = chFP$location=='Edinburgh'|chFP$location=='Edinburgh.VADW'
aggEdi = aggregate(chFP[Edi,], by=list(chFP$ID[Edi]), FUN=mean)
mean(aggEdi$Age) # Mean age
sd(aggEdi$Age) # SD age

mean(table(chFP$ID)) # Mean number of useable images
sd(table(chFP$ID))   # SD of number of useable images

mean(table(droplevels(chFP$ID[chFP$location=='Edinburgh'|chFP$location=='Edinburgh.VADW'])))
sd(table(droplevels(chFP$ID[chFP$location=='Edinburgh'|chFP$location=='Edinburgh.VADW'])))

mean(table(droplevels(chFP$ID[chFP$location=='Japan'])))
sd(table(droplevels(chFP$ID[chFP$location=='Japan'])))


mean(aggregate(chFP$fWHR, by=list(chFP$ID), FUN=mean)[,'x'], na.rm=TRUE) # Mean fWHR
sd(aggregate(chFP$fWHR, by=list(chFP$ID), FUN=mean)[,'x'], na.rm=TRUE) # SD fWHR



chFP$fWHR[chFP$ID=='Lennon']
(chFP$fWHR[chFP$ID=='Lennon'][1] - mean(chFP$fWHR[!duplicated(chFP$ID)]) ) / sd(chFP$fWHR[!duplicated(chFP$ID)])


table(chFP$location[!duplicated(chFP$ID)])


## Re-coding sex for Alex

table(chFP$Sex)
chFP$Salex = chFP$Sex
chFP$Salex[chFP$Salex==0] = -1



### Zero-order correlation plots

#colnames(chFP)
# corrplot(cor(chFP[,c(8,9,12,13,14,15,16,17,18,19),],use="pairwise.complete.obs")
#          ,  method = 'number')
# 
# corrplot(cor(chFP[chFP$Sex==0,c(8,12,13,14,15,16,17,18,19),],use="pairwise.complete.obs"),  method = 'number')
# corrplot(cor(chFP[chFP$Sex==1,c(8,12,13,14,15,16,17,18,19),],use="pairwise.complete.obs"),  method = 'number')
## Above seems to be outdated syntax.

cor.plot(cor(chFP[,c(8,9,12,13,14,15,16,17,18,19),],use="pairwise.complete.obs")
         ,  method = 'number')

cor.plot(cor(chFP[chFP$Sex==0,c(8,12,13,14,15,16,17,18,19),],use="pairwise.complete.obs"),  method = 'number')
cor.plot(cor(chFP[chFP$Sex==1,c(8,12,13,14,15,16,17,18,19),],use="pairwise.complete.obs"),  method = 'number')





## Collapse subspecies random effects

#levels(chFP$Subspecies)
chFP$Subspecies[chFP$Subspecies=='hybrid'] = 'unknown'
table(chFP$Subspecies[!duplicated(chFP$ID)])

table(chFP$Sex[!duplicated(chFP$ID)&chFP$Subspecies=='verus'])
table(chFP$Sex[!duplicated(chFP$ID)&chFP$Subspecies=='schweinfurthii'])
table(chFP$Sex[!duplicated(chFP$ID)&chFP$Subspecies=='ellioti'])
table(chFP$Sex[!duplicated(chFP$ID)&chFP$Subspecies=='troglodytes'])
table(chFP$Sex[!duplicated(chFP$ID)&chFP$Subspecies=='unknown'])



# basic age,sex index:
adults = (chFP$Sex==0 & chFP$Age>7) | (chFP$Sex==1 & chFP$Age>9)
adults[is.na(adults)] = TRUE
adults = adults & (as.character(chFP$ID) != 'Gage') # 75
adults = adults & (as.character(chFP$ID) != 'Lennon') # This is a good place to pull out Lennon (130, 131)
count(adults)
#View(chFP[adults,])
chFP$ID[!adults]
chFP$Subspecies[!adults & !duplicated(chFP$ID)] # one of these is Lennon, who is verus





### Decision tress


set.seed(1234567890)
tree.p1 = REEMtree(fWHR ~ Sex + Age + I(Age^2) + I(Age^3) + 
                     Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ + 
                     Subspecies,
                   data=chFP[adults,]
                   #data=chFP[chFP$ID!='Lennon',],
                   #random=~1|ID/Subspecies
                   , random = list(location =~ 1, ID =~ 1)#, Subspecies =~ 1)
                   ,cv=TRUE, method='ML'
                   
)
print(tree.p1)
plot(tree.p1)


## Setting up the df with better standardization

chFP.std = chFP [adults,]

chFP.std$Dom_CZ = scale(chFP.std$Dom_CZ)
chFP.std$Dom_CZ = chFP.std$Dom_CZ/2

chFP.std$Ext_CZ = scale(chFP.std$Ext_CZ)
chFP.std$Ext_CZ = chFP.std$Ext_CZ/2

chFP.std$Con_CZ = scale(chFP.std$Con_CZ)
chFP.std$Con_CZ = chFP.std$Con_CZ/2

chFP.std$Agr_CZ = scale(chFP.std$Agr_CZ)
chFP.std$Agr_CZ = chFP.std$Agr_CZ/2

chFP.std$Neu_CZ = scale(chFP.std$Neu_CZ)
chFP.std$Neu_CZ = chFP.std$Neu_CZ/2

chFP.std$Opn_CZ = scale(chFP.std$Opn_CZ)
chFP.std$Opn_CZ = chFP.std$Opn_CZ/2

chFP.std$fWHR = scale(chFP.std$fWHR)
chFP.std$fWHR = chFP.std$fWHR/2

chFP.std$Sex = scale(chFP.std$Sex)
chFP.std$Sex = chFP.std$Sex/2

chFP.std$Salex = scale(chFP.std$Salex)
chFP.std$Salex = chFP.std$Salex/2

chFP.std$Age2 = chFP.std$Age ^ 2
chFP.std$Age3 = chFP.std$Age ^ 3
chFP.std$Age = scale(chFP.std$Age) / 2
chFP.std$Age2 = scale(chFP.std$Age2) / 2
chFP.std$Age3 = scale(chFP.std$Age3) / 2

  
table(chFP.std$Sex)
table(chFP.std$Salex)
describe(chFP.std)



gb.tree.A.1 = lmer(fWHR ~ Agr_CZ +
                   (1 | location) +  (1 | ID),
                 data=chFP.std#[adults,]
                 )
summary(gb.tree.A.1)
confint(gb.tree.A.1, method='profile')

gb.tree.A.2 = lmer(fWHR ~ Agr_CZ +
                   (1 + Agr_CZ | location) +  (1 + Agr_CZ | ID),
                 data=chFP.std#[adults,]
                 )
summary(gb.tree.A.2)
confint(gb.tree.A.2, method='boot')
## Small and insignificant effect.



# gb.tree.vs = lmer(fWHR ~ Dom_CZ * Neu_CZ +
#                        + (1 | location) +  (1 | ID),
#                      data=chFP[adults&(chFP$Subspecies=='verus'|chFP$Subspecies=='schweinfurthii'),]
# )
# summary(gb.tree.vs)
# ## Nothing till we add sex.


gb.tree.all.sx = lmer(fWHR ~ Dom_CZ * Neu_CZ * Sex +
                       + (1 | location) +  (1 | ID),
                     data=chFP.std#[adults,]
)
                     
stdCoef.merMod <- function(object) {
  sdy <- sd(getME(object,"y"))
  sdx <- apply(getME(object,"X"), 2, sd)
  sc <- fixef(object)*sdx/sdy
  se.fixef <- coef(summary(object))[,"Std. Error"]
  se <- se.fixef*sdx/sdy
  return(data.frame(stdcoef=sc, stdse=se))
}
gb.tree.all.sx.std = stdCoef.merMod(gb.tree.all.sx)
gb.tree.all.sx.std
#gb.tree.all.sx = standardize(gb.tree.all.sx, standardize.y=TRUE)

summary(gb.tree.all.sx)
set.seed(123456) #... standard seed has convergence problems
confint(gb.tree.all.sx, method='boot')



gb.tree.v.sx = lmer(fWHR ~ Dom_CZ * Neu_CZ * Sex +
                      + (1 | location) +  (1 | ID),
                    data=chFP.std[(chFP.std$Subspecies=='verus'),]
)
summary(gb.tree.v.sx)
set.seed(1234567)
confint(gb.tree.v.sx, method='boot')



gb.tree.vs.sx = lmer(fWHR ~ Dom_CZ * Neu_CZ * Sex +
                          + (1 | location) +  (1 | ID),
                        data=chFP.std[(chFP.std$Subspecies=='verus'|chFP.std$Subspecies=='schweinfurthii'),]
)
summary(gb.tree.vs.sx)
set.seed(1234567)
confint(gb.tree.vs.sx, method='boot')



gb.tree.vsu.sx = lmer(fWHR ~ Dom_CZ * Neu_CZ * Sex +
                       + (1 | location) +  (1 | ID),
                     data=chFP.std[(chFP.std$Subspecies=='verus'|chFP.std$Subspecies=='schweinfurthii'|chFP.std$Subspecies=='unknown'),]
)
summary(gb.tree.vsu.sx)
set.seed(1234567)
confint(gb.tree.vsu.sx, method='boot')



gb.tree.t.sx = lmer(fWHR ~ Dom_CZ * Neu_CZ * Sex +
                      + (1 | location) +  (1 | ID),
                    data=chFP.std[(chFP.std$Subspecies=='troglodytes'),]
)
summary(gb.tree.t.sx)
set.seed(1234567)
confint(gb.tree.t.sx, method='boot')
## how to figure out these oddities?










### With the juveniles included


chFP.std.full = chFP

chFP.std.full$Dom_CZ = scale(chFP.std.full$Dom_CZ)
chFP.std.full$Dom_CZ = chFP.std.full$Dom_CZ/2

chFP.std.full$Ext_CZ = scale(chFP.std.full$Ext_CZ)
chFP.std.full$Ext_CZ = chFP.std.full$Ext_CZ/2

chFP.std.full$Con_CZ = scale(chFP.std.full$Con_CZ)
chFP.std.full$Con_CZ = chFP.std.full$Con_CZ/2

chFP.std.full$Agr_CZ = scale(chFP.std.full$Agr_CZ)
chFP.std.full$Agr_CZ = chFP.std.full$Agr_CZ/2

chFP.std.full$Neu_CZ = scale(chFP.std.full$Neu_CZ)
chFP.std.full$Neu_CZ = chFP.std.full$Neu_CZ/2

chFP.std.full$Opn_CZ = scale(chFP.std.full$Opn_CZ)
chFP.std.full$Opn_CZ = chFP.std.full$Opn_CZ/2

chFP.std.full$fWHR = scale(chFP.std.full$fWHR)
chFP.std.full$fWHR = chFP.std.full$fWHR/2

chFP.std.full$Sex = scale(chFP.std.full$Sex)
chFP.std.full$Sex = chFP.std.full$Sex/2

table(chFP.std.full$Sex)
describe(chFP.std.full)



gb.full.tree.A.1 = lmer(fWHR ~ Agr_CZ +
                     (1 | location) +  (1 | ID),
                   data=chFP.std.full#[adults,]
)
summary(gb.full.tree.A.1)
confint(gb.full.tree.A.1, method='profile')

gb.full.tree.A.2 = lmer(fWHR ~ Agr_CZ +
                     (1 + Agr_CZ | location) +  (1 + Agr_CZ | ID),
                   data=chFP.std.full#[adults,]
)
summary(gb.full.tree.A.2)
confint(gb.full.tree.A.2, method='boot')
## Small insignificant effect.



gb.full.tree.all.sx = lmer(fWHR ~ Dom_CZ * Neu_CZ * Sex +
                        + (1 | location) +  (1 | ID),
                      data=chFP.std.full#[adults,]
)

stdCoef.merMod <- function(object) {
  sdy <- sd(getME(object,"y"))
  sdx <- apply(getME(object,"X"), 2, sd)
  sc <- fixef(object)*sdx/sdy
  se.fixef <- coef(summary(object))[,"Std. Error"]
  se <- se.fixef*sdx/sdy
  return(data.frame(stdcoef=sc, stdse=se))
}
gb.full.tree.all.sx.std.full = stdCoef.merMod(gb.full.tree.all.sx)
gb.full.tree.all.sx.std.full
#gb.full.tree.all.sx = standardize(gb.full.tree.all.sx, standardize.y=TRUE)

summary(gb.full.tree.all.sx)
set.seed(1234567) #...
confint(gb.full.tree.all.sx, method='boot')



gb.full.tree.v.sx = lmer(fWHR ~ Dom_CZ * Neu_CZ * Sex +
                      + (1 | location) +  (1 | ID),
                    data=chFP.std.full[(chFP.std.full$Subspecies=='verus'),]
)
summary(gb.full.tree.v.sx)
confint(gb.full.tree.v.sx, method='profile')



gb.full.tree.vs.sx = lmer(fWHR ~ Dom_CZ * Neu_CZ * Sex
                            #Dom_CZ * Sex + Neu_CZ * Sex + Dom_CZ * Neu_CZ 
                       + (1 | location) +  (1 | ID),
                     data=chFP.std.full[(chFP.std.full$Subspecies=='verus'|chFP.std.full$Subspecies=='schweinfurthii'),]
)

# gb.full.tree.vs.sx.3way = lmer(fWHR ~ Dom_CZ * Neu_CZ * Sex
#                           + (1 | location) +  (1 | ID),
#                           data=chFP.std.full[(chFP.std.full$Subspecies=='verus'|chFP.std.full$Subspecies=='schweinfurthii'),]
# )
# anova(gb.full.tree.vs.sx, gb.full.tree.vs.sx.3way)

summary(gb.full.tree.vs.sx)
confint(gb.full.tree.vs.sx, method='profile')



gb.full.tree.vsu.sx = lmer(fWHR ~ Dom_CZ * Neu_CZ * Sex +
                        + (1 | location) +  (1 | ID),
                      data=chFP.std.full[(chFP.std.full$Subspecies=='verus'|chFP.std.full$Subspecies=='schweinfurthii'|chFP.std.full$Subspecies=='unknown'),]
)
summary(gb.full.tree.vsu.sx)
confint(gb.full.tree.vsu.sx, method='profile')



gb.full.tree.t.sx = lmer(fWHR ~ Dom_CZ * Neu_CZ * Sex +
                      + (1 | location) +  (1 | ID),
                    data=chFP.std.full[(chFP.std.full$Subspecies=='troglodytes'),]
)
summary(gb.full.tree.t.sx)
confint(gb.full.tree.t.sx, method='profile')



### Interaction plots... 
# TODO: CUT


interact_plot(gb.full.tree.all.sx, pred='Dom_CZ', modx='Neu_CZ', mod2='Sex', plot.points=TRUE)

interact_plot(gb.full.tree.vs.sx, pred='Dom_CZ', modx='Neu_CZ', mod2='Sex', plot.points=TRUE)

interact_plot(gb.full.tree.t.sx, pred='Dom_CZ', modx='Neu_CZ', plot.points=TRUE)



### Figuring out effect sizes...

cor.test(chAgr$fWHR[chAgr$Sex=='Female'], chAgr$Dom[chAgr$Sex=='Female'])
cor.test(chAgr$fWHR[chAgr$Sex=='Male'], chAgr$Dom[chAgr$Sex=='Male'])


EffSz.SxD = lmer(fWHR ~ Dom_CZ * Sex +
                   + (1 | location) +  (1 | ID),
                 data=chFP.std
)
summary(EffSz.SxD)
confint(gb.full.tree.t.sx, method='profile')
