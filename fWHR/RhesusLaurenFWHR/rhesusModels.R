### Rhesus macaque face analysis

library(lme4)
library(car)
library(ggplot2)
#library(aod)



mSexbyLoc = glm(Sex ~ Facility.x, family=binomial(link="logit"), na.action=na.pass, data=fWHR)
summary(mSexbyLoc)
# ZX has more females

summary(lm(agenum ~ Facility.x, data=fWHR))
# ZX is older

# (ZX is Davis)


### Optionals

# rm this heinously old male, GT684998
fWHR$fWHR[fWHR$Rhesus=='GT684998'] = NA



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
m1 <- lmer(fWHR ~ s(agenum) + s(I(agenum^2)) + s(I(agenum^3)) + (1|Rhesus) #+ (1|Facility.x)
             , data=fWHR)

summary(m1)
Anova(m1)
# Looks like we probably should include all 3.



### Test sex, age x sex effects
m2 <- lmer(fWHR ~ s(I(agenum^3)) + s(I(agenum^2)) + s(agenum) * Sex + (1|Rhesus) #+ (1|Facility.x)
           , data=fWHR)

summary(m2)
Anova(m2)
# Sex yes, age x sex, no.



### Test David score inclusiong
m3 <- lmer(fWHR ~ s(I(agenum^3)) + s(I(agenum^2)) + s(agenum) + Sex + Dominance.status
           + (1|Rhesus) + (1|Facility.x), data=fWHR)
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
m5 <- lmer(fWHR ~ #s(I(agenum^3)) + s(I(agenum^2)) + 
             s(agenum) + Sex 
           + Short.con + Short.opn + Short.dom + Short.anx
           + (1|Rhesus) #+ (1|Facility.x)
           , data=fWHR)
summary(m5)
Anova(m5)




### All item modelling
m6 <- lmer(fWHR ~ s(agenum) + s(I(agenum^3)) + s(I(agenum^2)) + Sex 
           + Fearful + Dominant + Cautious + Curious + Innovative + Bullying 
           + Submissive + Cool + Quitting + Erratic + Anxious + Socially.withdrawn
           + (1|Rhesus) + (1|Facility.x)
           , data=fWHR)
summary(m6)


