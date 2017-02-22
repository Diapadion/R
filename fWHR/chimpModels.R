### Models of Chimpanzee facial characteristics, age, sex, and personality

library(lme4)
library(car)
library(corrplot)


corrplot(cor(chFP[,c(3,4,5,79,80,81,82,83,84),]),  method = 'number')




m1 <- lmer(fHWR ~ s(Age) + s(I(Age^2)) + s(I(Age^3)) +
             (1 | location) #+ (1 | ID)
           ,data = chFP)

summary(m1)
# No age effects. Oversampling of older individuals?



m2 <- lmer(fHWR ~ Age*Sex +
             (1 | location) #+ (1 | ID)
           ,data = chFP)

summary(m2)
confint(m2)



### Personality

mp1 <- lmer(fHWR ~ Age*Sex + Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ +
              (1 | location) #+ (1 | ID)
            ,data = chFP)

summary(mp1)
confint(mp1)



mp2 <- lmer(fHWR ~ Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ +
              (1 | location) #+ (1 | ID)
            ,data = chFP)

summary(mp2)
confint(mp2)

anova(mp1,mp2)
