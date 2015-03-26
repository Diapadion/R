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
m1a <- lmer(sys ~ Dominance + Extraversion + Neuroticism + Conscientiousness + Openness + Agreeableness + age + BMI + sex + (1 | chimp), 
            data = scoutput,REML=FALSE)
m1b <- lmer(dias ~ Dominance + Extraversion + Neuroticism + Conscientiousness + Openness + Agreeableness + age + BMI + sex + (1 | chimp), 
            data = scoutput,REML=FALSE)

m2.trig <- lmer(trig ~ Dominance + Extraversion + Neuroticism + Conscientiousness + Openness + Agreeableness + age + BMI + sex + (1 | chimp), 
                data = scoutput,REML=FALSE)

m2.chol <- lmer(chol ~ Dominance + Extraversion + Neuroticism + Conscientiousness + Openness + Agreeableness + age + BMI + sex + (1 | chimp), 
                data = scoutput,REML=FALSE)

m2.creat <- lmer(creatinine ~ Dominance + Extraversion + Neuroticism + Conscientiousness + Openness + Agreeableness + age + BMI + sex + (1 | chimp), 
                 data = scoutput,REML=FALSE)
