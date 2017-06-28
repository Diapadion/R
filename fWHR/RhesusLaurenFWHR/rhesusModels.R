### Rhesus macaque face analysis

library(lme4)
library(car)
library(ggplot2)
library(glmnet)
library(arm)



mSexbyLoc = glm(Sex ~ Facility.x, family=binomial(link="logit"), na.action=na.pass, data=fWHR)
summary(mSexbyLoc)
# ZX has more females

summary(lm(agenum ~ Facility.x, data=fWHR))
# ZX is older

# (ZX is Davis)


### Optionals

# rm this heinously old male, GT684998, to see if he is biasing results
fWHR$fWHR[fWHR$Rhesus=='GT684998'] <- NA
fWHR$LFFH[fWHR$Rhesus=='GT684998'] <- NA


# ===================================================================
# = untested correlations
# ===================================================================

cor(fWHR[,c(16:17,25,32:34,93:102)],use='pairwise.complete.obs', method='spearman')
corrplot(fWHR[,c(16:17,25,32:34,93:102)])



# ===================================================================
# = Hypothesis testing: Is fWHR sexually dimorphic? Are there age differences?
# ===================================================================

plot(fWHR ~ agenum, data=fWHR)
plot(fWHR ~ Dominance.status, data=fWHR)
plot(fWHR ~ Dominance.bin, data=fWHR)

plot(fWHR ~ agenum, data=fWHR[fWHR$Sex=='M',])
plot(fWHR ~ Dominance.status, data=fWHR[fWHR$Sex=='M',])
plot(fWHR ~ Dominance.bin, data=fWHR[fWHR$Sex=='M',])

plot(fWHR ~ agenum, data=fWHR[fWHR$Sex=='F',])
plot(fWHR ~ Dominance.status, data=fWHR[fWHR$Sex=='F',])
plot(fWHR ~ Dominance.bin, data=fWHR[fWHR$Sex=='F',])


### 1. Test age effects
m1 <- lmer(fWHR ~ Age + Age2 + Age3 + (1|Facility.x/Rhesus)
             , data=fWHR)

summary(m1)
Anova(m1)
# From this it looks like we probably should include all 3,
# but I think we should probably enter these sequentially to more sensitively
# determine if there is major added value of including age vars.

m0 <- lmer(fWHR ~ 1 + (1|Facility.x/Rhesus)
              , data=fWHR)

m1.a1 <- lmer(fWHR ~ Age + (1|Facility.x/Rhesus)
              , data=fWHR)
summary(m1.a1)

m1.a2 <- lmer(fWHR ~ Age + Age2 + (1|Facility.x/Rhesus)
              , data=fWHR)
summary(m1.a2)

m1.a3 <- lmer(fWHR ~ Age + Age2 + Age3 + (1|Facility.x/Rhesus)
              , data=fWHR)
summary(m1.a3)

anova(m0,m1.a1,m1.a2,m1.a3)
# The greatest predictive value *is* from including all 3 of the,
# but it doesn't look like age is very important to rhesus monkeys.



#For now, just to mirror the capuchin results for a reference point, am including up to Age^3

### Test sex, age x sex effects
m2 <- lmer(fWHR ~ Sex * Age + Age2 + Age3 + (1|Facility.x/Rhesus)
           , data=fWHR)

summary(m2)
Anova(m2)
# Sex yes, age x sex, no.



### Test David score inclusiong
m3 <- lmer(fWHR ~ Age + Age2 + Age3 + Sex + Dominance.status
           + (1|Facility.x/Rhesus)
           , data=fWHR)
summary(m3)
Anova(m3)
# David scores don't appear to be implicated.
# Split by sex?
# Let's leave it out for now

## Alternative binary coding
m3.alt <- lmer(fWHR ~ Age + Age2 + Age3 + Sex + Dominance.bin
           + (1|Facility.x/Rhesus)
           , data=fWHR)
summary(m3.alt)
Anova(m3.alt)



### Testing HPQ - 6 dimensions
m4 <- lmer(fWHR ~ Age + Age2 + Age3 + 
             Sex 
           + Confidence + Openness + Dominance + Friendliness + Activity + Anxiety
           + (1|Rhesus), data=fWHR[fWHR$Facility.x=='ZX6012',])
summary(m4)
Anova(m4)

m0.ZX <- lmer(fWHR ~ 1 + (1|Rhesus), data=fWHR[fWHR$Facility.x=='ZX6012',])

anova(m4,m0.ZX)
### ... Activity? Most of the other chi-sq values have been blasted away



### Testing short form personality
m5 <- lmer(fWHR ~ Age + Age2 + Age3 + 
           Sex 
           + Short.con + Short.opn + Short.dom + Short.anx
           + (1|Facility.x/Rhesus)
           , data=fWHR)
summary(m5)
Anova(m5)



### All item modelling - prototype

fWHRmat = as.matrix(as.data.frame(lapply(fWHR
  #aggregate(fWHR,by=list(fWHR$Rhesus),FUN=mean,na.action=na.omit)
                                         , as.numeric)))
#fWHRmat=fWHRmat[,-1]
fWHRmat = cbind(1,fWHRmat)

alp = 0.5

# indices need to be fixed
m6 <- glmnet(fWHRmat[!is.na(fWHRmat[,17]),c(33:35,40:51)],fWHRmat[!is.na(fWHRmat[,17]),17],
             family='gaussian',standardize=T,nlambda=1000,alpha=alp
             )
cv.m6 = cv.glmnet(fWHRmat[!is.na(fWHRmat[,17]),c(33:35,40:51)],fWHRmat[!is.na(fWHRmat[,17]),17],
                  family='gaussian',nfolds=100,alpha=alp)
plot(cv.m6)
coef(m6,s=cv.m6$lambda.min)


# m6 <- lmer(fWHR ~ Sex 
#            + Fearful + Dominant + Cautious + Curious + Innovative + Bullying 
#            + Submissive + Cool + Quitting + Erratic + Anxious + Socially.withdrawn
#            + (1|Facility.x/Rhesus)
#            , data=fWHR)
# summary(m6)
# Anova(m6)


### Testing mixed LASSO

# library(lmmlasso)
# 
# m7 <- lmmlasso(x=fWHRmat[!is.na(fWHRmat[,17]),c(1,25,33:35,40:51)],
#                y=fWHRmat[!is.na(fWHRmat[,17]),17],
#                z=as.matrix(fWHRmat[!is.na(fWHRmat[,17]),c(1)]),
#                grp=fWHRmat[!is.na(fWHRmat[,17]),c(2)], # this is the grouping var, e.g. individual
#                lambda=100
# )
# summary(m7)
# plot(m7)


# library(MMS)
# 
# m7 <- lassop(data=fWHRmat[!is.na(fWHRmat[,17]),c(1,25,33:35,40:51)],
#              Y=fWHRmat[!is.na(fWHRmat[,17]),17],
#              z=fWHRmat[!is.na(fWHRmat[,17]),c(1)],
#              grp=fWHRmat[!is.na(fWHRmat[,17]),c(2)], # this is the grouping var, e.g. individual
#              alpha=alp, D=F, rand=c(1)
#              )
             








### Same stuff for LFFH ###


plot(LFFH ~ agenum, data=fWHR)
plot(LFFH ~ Dominance.status, data=fWHR)

plot(LFFH ~ agenum, data=fWHR[fWHR$Sex=='M',])
plot(LFFH ~ Dominance.status, data=fWHR[fWHR$Sex=='M',])

plot(LFFH ~ agenum, data=fWHR[fWHR$Sex=='F',])
plot(LFFH ~ Dominance.status, data=fWHR[fWHR$Sex=='F',])


### 1. Test age effects
m1.LF <- lmer(LFFH ~  Age + Age2 + Age3 + (1|Facility.x/Rhesus)
           , data=fWHR)

summary(m1.LF)
Anova(m1.LF)
# Again, looks like we probably should include all 3, but effect is driven by that old guy.

m0.LF <- lmer(LFFH ~ 1 + (1|Facility.x/Rhesus)
           , data=fWHR)

m1.a1.LF <- lmer(LFFH ~ Age + (1|Facility.x/Rhesus)
              , data=fWHR)
summary(m1.a1.LF)

m1.a2.LF <- lmer(LFFH ~ Age + Age2 + (1|Facility.x/Rhesus)
              , data=fWHR)
summary(m1.a2.LF)

anova(m0.LF,m1.a1.LF,m1.a2.LF,m1.LF)

# Okay, maybe Age + Age^2 is meaningful to LFFH



### Test sex, age x sex effects
m2.LF <- lmer(LFFH ~  Sex * Age + Age2 + Age3 + (1|Facility.x/Rhesus)
           , data=fWHR)

summary(m2)
Anova(m2)
# Sex yes, age x sex, no.



### Test David score inclusiong
m3.LF <- lmer(LFFH ~  Age + Age2 + Age3 + Sex + Dominance.status
              + (1|Facility.x/Rhesus)
           , data=fWHR)
summary(m3.LF)
Anova(m3.LF)
# David scores again don't appear to be implicated.

## Alternative binary coding
m3.LF.alt <- lmer(LFFH ~  Age + Age2 + Age3 + Sex + Dominance.bin
              + (1|Facility.x/Rhesus)
              , data=fWHR)
summary(m3.LF.alt)
Anova(m3.LF.alt)



### Testing HPQ - 6 dimensions
m4.LF <- lmer(LFFH ~  Age + Age2 + Age3 + Sex 
           + Confidence + Openness + Dominance + Friendliness + Activity + Anxiety
           + (1|Rhesus), data=fWHR[fWHR$Facility.x=='ZX6012',])
summary(m4.LF)
Anova(m4.LF)
### Nothing.



### Testing short form personality
m5.LF <- lmer(LFFH ~  Age + Age2 + Age3 +
           + Sex 
           + Short.con + Short.opn + Short.dom + Short.anx
           + (1|Facility.x/Rhesus)
           , data=fWHR)
summary(m5.LF)
Anova(m5.LF)
### Nothing clear, but maybe Dominance.




### All item modelling - again, not ready

alp = 0.1

m6.LF <- glmnet(fWHRmat[!is.na(fWHRmat[,18]),c(25,33:35,40:51)],fWHRmat[!is.na(fWHRmat[,18]),18],
             family='gaussian',standardize=T,nlambda=1000,alpha=alp
)
cv.m6lf = cv.glmnet(fWHRmat[!is.na(fWHRmat[,18]),c(25,33:35,40:51)],fWHRmat[!is.na(fWHRmat[,18]),18],
                  family='gaussian',nfolds=100,alpha=alp)
plot(cv.m6lf)
coef(m6.LF,s=cv.m6lf$lambda.min)




m6.LF <- lmer(LFFH ~ Age + Age2 + Age3 + Sex 
           + Fearful + Dominant + Cautious + Curious + Innovative + Bullying 
           + Submissive + Cool + Quitting + Erratic + Anxious + Socially.withdrawn
           + (1|Facility.x/Rhesus)
           , data=fWHR)
summary(m6.LF)




### mixed LASSO

# m7.LF <- lmmlasso(x=fWHRmat[!is.na(fWHRmat[,18]),c(1,25,33:35,40:51)],
#                y=fWHRmat[!is.na(fWHRmat[,18]),18],
#                z=as.matrix(fWHRmat[!is.na(fWHRmat[,18]),c(1)]),
#                grp=fWHRmat[!is.na(fWHRmat[,18]),c(2)], # this is the grouping var, e.g. individual
#                lambda=100
# )
# summary(m7.LF)
# plot(m7.LF)
