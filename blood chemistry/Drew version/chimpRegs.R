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
m1a <- lmer(sys ~ dom + extra + neuro + cons + open + agree + age + BMI + sex + (1 | chimp), 
            data = scoutput,REML=FALSE)

m2.trig <- lmer(trig ~ dom + extra + neuro + cons + open + agree + age + BMI + sex + (1 | chimp), 
                data = scoutput,REML=FALSE)

m2.chol <- lmer(chol ~ dom + extra + neuro + cons + open + agree + age + BMI + sex + (1 | chimp), 
                data = scoutput,REML=FALSE)

m2.creat <- lmer(creatinine ~ dom + extra + neuro + cons + open + agree + age + BMI + sex + (1 | chimp), 
                 data = scoutput,REML=FALSE)
