### chimp models

# with mean data... big problem is missing BMI data
mmc.sys <- lm(sys ~ age + dom + extra + cons + agree + neuro + open + sex + BMI,
              data=meandat,na.action = na.exclude)

mmc.chol <- lm(chol ~ age + dom + extra + cons + agree + neuro + open + sex + BMI,
              data=meandat,na.action = na.exclude)

mmc.trig <- lm(trig ~ age + dom + extra + cons + agree + neuro + open + sex + BMI,
              data=meandat,na.action = na.exclude)
# above not worth the attempt


### lmer's, with ML
m1a <- lmer(sys ~ Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion + age + BMI + sex + (1 | chimp), 
            data = scoutput,REML=FALSE)
m1b <- lmer(dias ~ Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion + age + BMI + sex + (1 | chimp), 
            data = scoutput,REML=FALSE)

m2.trig <- lmer(trig ~ Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion + age + BMI + sex + (1 | chimp), 
                data = scoutput,REML=FALSE)

m2.chol <- lmer(chol ~ Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion + age + BMI + sex + (1 | chimp), 
                data = scoutput,REML=FALSE)

m2.creat <- lmer(creatinine ~ Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion + age + BMI + sex + (1 | chimp), 
                 data = scoutput,REML=FALSE)


m2.gluc <- lmer(glucose ~ Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion + age + BMI + sex + (1 | chimp), 
                 data = scoutput,REML=FALSE)


# check convergence issues on this one, BMI unscaled?
m3.BMI <- lmer(BMI ~ Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion + age + sex + (1 | chimp), 
               data = scoutput, REML=FALSE)




##### imputation

testimp = imp_mean$imputations$imp2

im.chol = lm(chol ~ Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion + age + BMI + sex, 
                             data = testimp)
