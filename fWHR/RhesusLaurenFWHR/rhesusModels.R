### Rhesus macaque face analysis

library(lme4)
library(car)
library(ggplot2)
library(glmnet)



mSexbyLoc = glm(Sex ~ Facility.x, family=binomial(link="logit"), na.action=na.pass, data=fWHR)
summary(mSexbyLoc)
# ZX has more females

summary(lm(agenum ~ Facility.x, data=fWHR))
# ZX is older

# (ZX is Davis)


### Optionals

# rm this heinously old male, GT684998
fWHR$fWHR[fWHR$Rhesus=='GT684998'] = NA
fWHR$LFFH[fWHR$Rhesus=='GT684998'] = NA


# ===================================================================
# = untested correlations
# ===================================================================

library(arm)
cor(fWHR[,c(16:17,32:34,93:102)],use='pairwise.complete.obs')
corrplot(fWHR[,c(16:17,32:34,93:102)])



# ===================================================================
# = Hypothesis testing: Is fWHR sexually dimorphic? Are there age differences?
# ===================================================================

plot(fWHR ~ agenum, data=fWHR)
plot(fWHR ~ Dominance.status, data=fWHR)

plot(fWHR ~ agenum, data=fWHR[fWHR$Sex=='M',])
plot(fWHR ~ Dominance.status, data=fWHR[fWHR$Sex=='M',])

plot(fWHR ~ agenum, data=fWHR[fWHR$Sex=='F',])
plot(fWHR ~ Dominance.status, data=fWHR[fWHR$Sex=='F',])


### 1. Test age effects
m1 <- lmer(fWHR ~ s(agenum) + s(I(agenum^2)) + s(I(agenum^3)) + (1|Facility.x/Rhesus)
             , data=fWHR)

summary(m1)
Anova(m1)
# Looks like we probably should include all 3.



### Test sex, age x sex effects
m2 <- lmer(fWHR ~ s(I(agenum^3)) + s(I(agenum^2)) + s(agenum) * Sex + (1|Facility.x/Rhesus)
           , data=fWHR)

summary(m2)
Anova(m2)
# Sex yes, age x sex, no.



### Test David score inclusiong
m3 <- lmer(fWHR ~ s(I(agenum^3)) + s(I(agenum^2)) + s(agenum) + Sex + Dominance.status
           + (1|Facility.x/Rhesus)
           , data=fWHR)
summary(m3)
Anova(m3)
# David scores don't appear to be implicated.
# Split by sex?
# Let's leave it out for now



### Testing HPQ - 6 dimensions
m4 <- lmer(fWHR ~ s(I(agenum^3)) + s(I(agenum^2)) + s(agenum) + Sex 
           + Confidence + Openness + Dominance + Friendliness + Activity + Anxiety
           + (1|Rhesus), data=fWHR[fWHR$Facility.x=='ZX6012',])
summary(m4)
Anova(m4)
### ... Activity? Most of the other chi-sq values have been blasted away



### Testing short form personality
m5 <- lmer(fWHR ~ s(I(agenum^3)) + s(I(agenum^2)) + 
             s(agenum) + Sex 
           + Short.con + Short.opn + Short.dom + Short.anx
           + (1|Facility.x/Rhesus)
           , data=fWHR)
summary(m5)
Anova(m5)



### All item modelling

fWHRmat = as.matrix(as.data.frame(lapply(fWHR
  #aggregate(fWHR,by=list(fWHR$Rhesus),FUN=mean,na.action=na.omit)
                                         , as.numeric)))
#fWHRmat=fWHRmat[,-1]
fWHRmat = cbind(1,fWHRmat)

alp = 0.5

# indices need to be fixed
m6 <- glmnet(fWHRmat[!is.na(fWHRmat[,16]),c(32:34,39:50)],fWHRmat[!is.na(fWHRmat[,16]),16],
             family='gaussian',standardize=T,nlambda=1000,alpha=alp
             )
cv.m6 = cv.glmnet(fWHRmat[!is.na(fWHRmat[,16]),c(32:34,39:50)],fWHRmat[!is.na(fWHRmat[,16]),16],
                  family='gaussian',nfolds=100,alpha=alp)
plot(cv.m6)
coef(m6,s=cv.m6$lambda.min)


m6 <- lmer(fWHR ~ s(agenum) + s(I(agenum^3)) + s(I(agenum^2)) + Sex 
           + Fearful + Dominant + Cautious + Curious + Innovative + Bullying 
           + Submissive + Cool + Quitting + Erratic + Anxious + Socially.withdrawn
           + (1|Facility.x/Rhesus)
           , data=fWHR)
summary(m6)



### Testing mixed LASSO

library(lmmlasso)

m7 <- lmmlasso(x=fWHRmat[!is.na(fWHRmat[,17]),c(1,25,33:35,40:51)],
               y=fWHRmat[!is.na(fWHRmat[,17]),17],
               z=as.matrix(fWHRmat[!is.na(fWHRmat[,17]),c(1)]),
               grp=fWHRmat[!is.na(fWHRmat[,17]),c(2)], # this is the grouping var, e.g. individual
               lambda=100
)
summary(m7)
plot(m7)


# library(MMS)
# 
# m7 <- lassop(data=fWHRmat[!is.na(fWHRmat[,17]),c(1,25,33:35,40:51)],
#              Y=fWHRmat[!is.na(fWHRmat[,17]),17],
#              z=fWHRmat[!is.na(fWHRmat[,17]),c(1)],
#              grp=fWHRmat[!is.na(fWHRmat[,17]),c(2)], # this is the grouping var, e.g. individual
#              alpha=alp, D=F, rand=c(1)
#              )
             



# m7 <- Pen.LME(y=fWHRmat[!is.na(fWHRmat[,16]),16],
#               X=fWHRmat[!is.na(fWHRmat[,16]),c(24,32:34,39:50)],
#               Z=fWHRmat[!is.na(fWHRmat[,16]),c(26)],
#               subject=fWHRmat[!is.na(fWHRmat[,16]),c(1)]
#               )












### Same stuff for LFFH ###


plot(LFFH ~ agenum, data=fWHR)
plot(LFFH ~ Dominance.status, data=fWHR)

plot(LFFH ~ agenum, data=fWHR[fWHR$Sex=='M',])
plot(LFFH ~ Dominance.status, data=fWHR[fWHR$Sex=='M',])

plot(LFFH ~ agenum, data=fWHR[fWHR$Sex=='F',])
plot(LFFH ~ Dominance.status, data=fWHR[fWHR$Sex=='F',])


### 1. Test age effects
m1.LF <- lmer(LFFH ~ s(agenum) + s(I(agenum^2)) + s(I(agenum^3)) + (1|Facility.x/Rhesus)
           , data=fWHR)

summary(m1.LF)
Anova(m1.LF)
# Again, looks like we probably should include all 3, but effect is driven by that old guy.



### Test sex, age x sex effects
m2.LF <- lmer(LFFH ~ s(I(agenum^3)) + s(I(agenum^2)) + s(agenum) * Sex + (1|Facility.x/Rhesus)
           , data=fWHR)

summary(m2)
Anova(m2)
# Sex yes, age x sex, no.



### Test David score inclusiong
m3.LF <- lmer(LFFH ~ s(I(agenum^3)) + s(I(agenum^2)) + s(agenum) + Sex + Dominance.status
              + (1|Facility.x/Rhesus)
           , data=fWHR)
summary(m3.LF)
Anova(m3.LF)
# David scores again don't appear to be implicated.



### Testing HPQ - 6 dimensions
m4.LF <- lmer(LFFH ~ s(I(agenum^3)) + s(I(agenum^2)) + s(agenum) + Sex 
           + Confidence + Openness + Dominance + Friendliness + Activity + Anxiety
           + (1|Rhesus), data=fWHR[fWHR$Facility.x=='ZX6012',])
summary(m4.LF)
Anova(m4.LF)
### Nothing.



### Testing short form personality
m5.LF <- lmer(LFFH ~ s(I(agenum^3)) + s(I(agenum^2)) + 
             s(agenum) + Sex 
           + Short.con + Short.opn + Short.dom + Short.anx
           + (1|Facility.x/Rhesus)
           , data=fWHR)
summary(m5.LF)
Anova(m5.LF)
### Nothing clear, but maybe Dominance.




### All item modelling

alp = 0.5

m6.LF <- glmnet(fWHRmat[!is.na(fWHRmat[,17]),c(24,32:34,39:50)],fWHRmat[!is.na(fWHRmat[,17]),17],
             family='gaussian',standardize=T,nlambda=1000,alpha=alp
)
cv.m6lf = cv.glmnet(fWHRmat[!is.na(fWHRmat[,17]),c(24,32:34,39:50)],fWHRmat[!is.na(fWHRmat[,17]),17],
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

m7.LF <- lmmlasso(x=fWHRmat[!is.na(fWHRmat[,18]),c(1,25,33:35,40:51)],
               y=fWHRmat[!is.na(fWHRmat[,18]),18],
               z=as.matrix(fWHRmat[!is.na(fWHRmat[,18]),c(1)]),
               grp=fWHRmat[!is.na(fWHRmat[,18]),c(2)], # this is the grouping var, e.g. individual
               lambda=100
)
summary(m7.LF)
plot(m7.LF)
