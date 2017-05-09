### take the MIDUS combined file and analyze it

#midus_c <- read.table()

# vars of interest
# $M2ID
# $B4ZAGE - respondent age at P4 data collection
# $B1PRSEX - "gender" (1 = male, 2 = female)
# 
# $B1SOPEN
# $B1SAGREE
# $B1SCONS2
# $B1SNEURO
# $B1SEXTRA
# $B1SAGENC
#
# $B4ZCOMPY - year of collection of biomarker data
#
# $B4PBMI - BMI
# $B4BCHOL - total cholesterol
# $B4BTRIGL - triglycerides
# $B4BSCREA - creatinine
# $B4BSBAP - alkaline phosphatase
# $B4BGLUC
# $B4P1GS23 - average sitting systolic (2nd + 3rd measures)
# $B4P1GD23 - average sitting diastolic

midus_c$ageAtBloodDraw <- midus_c$B4ZCOMPY - midus_c$B1PBYEAR

### cleaning & scaling

# this is junk
# attach(midus_c)
# ageAtBloodDraw[outliers(ageAtBloodDraw,3.5)]<-NA
# #B1SOPEN[outliers(B1SOPEN,3.5)]<-NA
# #B1SAGREE[outliers(B1SAGREE,3.5)]<-NA
# #B1SCONS2[outliers(B1SCONS2,3.5)]<-NA
# #B1SNEURO[outliers(B1SNEURO,3.5)]<-NA
# #B1SEXTRA[outliers(B1SEXTRA,3.5)]<-NA
# B4PBMI[outliers(B4PBMI,3.5)]<-NA
# B4BCHOL[outliers(B4BCHOL,3.5)]<-NA
# B4BTRIGL[outliers(B4BTRIGL,3.5)]<-NA
# B4BSCREA[outliers(B4BSCREA,3.5)]<-NA
# B4BSBAP[outliers(B4BSBAP,3.5)]<-NA
# B4BGLUC[outliers(B4BGLUC,3.5)]<-NA
# B4P1GS23[outliers(B4P1GS23,3.5)]<-NA
# B4P1GD23[outliers(B4P1GD23,3.5)]<-NA
# #B1SAGENC[outliers(B1SAGENC,3.5)]<-NA
# detach(midus_c)

midus_c$B4ZAGE[outliers(midus_c$B4ZAGE,3.5)]<-NA
midus_c$B4ZAGE2 <- (midus_c$B4ZAGE)^2
midus_c$B1SOPEN[midus_c$B1SOPEN==8]<-NA
midus_c$B1SAGREE[midus_c$B1SAGREE==8]<-NA
midus_c$B1SCONS2[midus_c$B1SCONS2==8]<-NA
midus_c$B1SNEURO[midus_c$B1SNEURO==8]<-NA
midus_c$B1SEXTRA[midus_c$B1SEXTRA==8]<-NA
midus_c$B1SAGENC[midus_c$B1SAGENC==8]<-NA
midus_c$B4BTRIGL[outliers(midus_c$B4BTRIGL,3.5)]<-NA
midus_c$B4PBMI[outliers(midus_c$B4PBMI,3.5)]<-NA
midus_c$B4BCHOL[outliers(midus_c$B4BCHOL,3.5)]<-NA
midus_c$B4BSCREA[outliers(midus_c$B4BSCREA,3.5)]<-NA
midus_c$B4BSBAP[outliers(midus_c$B4BSBAP,3.5)]<-NA
midus_c$B4BGLUC[outliers(midus_c$B4BGLUC,3.5)]<-NA
midus_c$B4P1GS23[outliers(midus_c$B4P1GS23,3.5)]<-NA
midus_c$B4P1GD23[outliers(midus_c$B4P1GD23,3.5)]<-NA

midus_c$B1SE6A[midus_c$B1SE6A==8]<-NA
midus_c$B1SE6B[midus_c$B1SE6B==8]<-NA
midus_c$B1SE6C[midus_c$B1SE6C==8]<-NA
midus_c$B1SE6D[midus_c$B1SE6D==8]<-NA
midus_c$B1SE6E[midus_c$B1SE6E==8]<-NA
midus_c$B1SE6F[midus_c$B1SE6F==8]<-NA
midus_c$B1SE6G[midus_c$B1SE6G==8]<-NA
midus_c$B1SE6H[midus_c$B1SE6H==8]<-NA
midus_c$B1SE6I[midus_c$B1SE6I==8]<-NA
midus_c$B1SE6J[midus_c$B1SE6J==8]<-NA
midus_c$B1SE6K[midus_c$B1SE6K==8]<-NA
midus_c$B1SE6L[midus_c$B1SE6L==8]<-NA
midus_c$B1SE6M[midus_c$B1SE6M==8]<-NA
midus_c$B1SE6N[midus_c$B1SE6N==8]<-NA
midus_c$B1SE6O[midus_c$B1SE6O==8]<-NA
midus_c$B1SE6P[midus_c$B1SE6P==8]<-NA
midus_c$B1SE6Q[midus_c$B1SE6Q==8]<-NA
midus_c$B1SE6R[midus_c$B1SE6R==8]<-NA
midus_c$B1SE6S[midus_c$B1SE6S==8]<-NA
midus_c$B1SE6T[midus_c$B1SE6T==8]<-NA
midus_c$B1SE6U[midus_c$B1SE6U==8]<-NA
midus_c$B1SE6V[midus_c$B1SE6V==8]<-NA
midus_c$B1SE6W[midus_c$B1SE6W==8]<-NA
midus_c$B1SE6X[midus_c$B1SE6X==8]<-NA
midus_c$B1SE6Y[midus_c$B1SE6Y==8]<-NA
midus_c$B1SE6Z[midus_c$B1SE6Z==8]<-NA
midus_c$B1SE6AA[midus_c$B1SE6AA==8]<-NA
midus_c$B1SE6BB[midus_c$B1SE6BB==8]<-NA
midus_c$B1SE6CC[midus_c$B1SE6CC==8]<-NA
midus_c$B1SE6DD[midus_c$B1SE6DD==8]<-NA
midus_c$B1SE6EE[midus_c$B1SE6EE==8]<-NA

midus_cs <- with(midus_c,data.frame(M2ID,sex=B1PRSEX, age=s(B4ZAGE), age2=s(B4ZAGE2),
                                    Dominance=s(B1SAGENC),Extraversion=s(B1SEXTRA),Openness=s(B1SOPEN),
                                    Conscientiousness=s(B1SCONS2),Agreeableness=s(B1SAGREE),Neuroticism=s(B1SNEURO),                               
                                    BMI=s(B4PBMI),chol=s(B4BCHOL),creat=s(B4BSCREA),trig=s(B4BTRIGL),
                                    sys=s(B4P1GS23),dias=s(B4P1GD23),
                                    alp=s(B4BSBAP),glucose=s(B4BGLUC),
                                    sys_all = s(B4P1GS), dias_all = s(B4P1GD),
                                    Outgoing=s(B1SE6A),Helpful=s(B1SE6B),Moody=s(B1SE6C),
                                    Organized=s(B1SE6D),Selfconfident=s(B1SE6E),Friendly=s(B1SE6F),
                                    Warm=s(B1SE6G),Worrying=s(B1SE6H),Responsible=s(B1SE6I),
                                    Forceful=s(B1SE6J),Lively=s(B1SE6K),Caring=s(B1SE6L),
                                    Nervous=s(B1SE6M),Creative=s(B1SE6N),Assertive=s(B1SE6O),
                                    Hardworking=s(B1SE6P),Imaginative=s(B1SE6Q),Softhearted=s(B1SE6R),
                                    Calm=s(B1SE6S),Outspoken=s(B1SE6T),Intelligent=s(B1SE6U),
                                    Curious=s(B1SE6V),Active=s(B1SE6W),Careless=s(B1SE6X),
                                    Broadminded=s(B1SE6Y),Sympathetic=s(B1SE6Z),Talkative=s(B1SE6AA),
                                    Sophisticated=s(B1SE6BB),Adventurous=s(B1SE6CC),Dominant=s(B1SE6DD),
                                    Thorough=s(B1SE6EE)
                                    ))


# implement this across datasets
#sex=s(B1PRSEX,scale=FALSE)

### models
### add Agency personality (24/03/15)

m.sys <- lm(sys ~ age + sex + BMI
            + Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion, data = midus_cs)
# see m_1

m.dias <- lm(dias ~ age +sex + BMI
             + Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion, data = midus_cs)

m.chol <- lm(chol ~ age +sex + BMI
             + Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion, data = midus_cs)
# see m_2a

m.trig <- lm(trig ~ age +sex + BMI
             + Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion, data = midus_cs)
# see m_2b
#leave out?

m.creat <- lm(creat ~ age +sex + BMI 
              + Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion, data = midus_cs)
# see m2u

m.alp <- lm(alp ~ age +sex + BMI
            + Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion, data = midus_cs)
# see m2w

m.gluc <- lm(glucose ~ age +sex + BMI
             + Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion, data = midus_cs)
# see m_2c ++

m.BMI <- lm(BMI ~ age +sex
                      + Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion, data = midus_cs)
# see m3.BMIc


### hmm so does the first BP get thrown by people being nervous?

m.sys.all = lm(sys_all ~ age + sex + BMI
   + Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion, data = midus_cs)

m.dias.all = lm(dias_all ~ age + sex + BMI
              + Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion, data = midus_cs)


### chol on BP?

cor.BPfromChol <- cor(midus_cs$sys,midus_cs$chol)



##### Age^2 examination

m.sys.a2 <- lm(sys ~ age + I(age^2) + sex + BMI
            + Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion, data = midus_cs)
# see m_1

m.dias.a2 <- lm(dias ~ age + I(age^2) + sex + BMI
             + Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion, data = midus_cs)

m.chol.a2 <- lm(chol ~ age + I(age^2) + sex + BMI
             + Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion, data = midus_cs)
# see m_2a

m.trig.a2 <- lm(trig ~ age + I(age^2) + sex + BMI
             + Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion, data = midus_cs)
# see m_2b
#leave out?

m.creat.a2 <- lm(creat ~ age + I(age^2) + sex + BMI 
              + Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion, data = midus_cs)
# see m2u

m.BMI.a2 <- lm(BMI ~ age + I(age^2) + sex
            + Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion, data = midus_cs)
# see m3.BMIc



### coming out of the SEMs

#all2$AL = all2$sys + all2$dias + all2$chol + all2$trig + all2$BMI # these are medication adjusted, too
maAL.1 <- lm(AL ~ age + age2 + sex
            + Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion,
            data = all3[all3$sample=='MIDUS',])
summary(maAL.1)



midus_cs$AL = midus_cs$sys + midus_cs$dias + midus_cs$chol + midus_cs$trig + midus_cs$BMI # these need medication adjustment
maALallItems.1 <- lm(AL ~ age + age2 + sex
             + Outgoing + Helpful + Moody + Organized + Selfconfident + Friendly + Warm + Worrying
             + Responsible + Forceful + Lively + Caring + Nervous + Creative + Assertive
             + Hardworking + Imaginative + Softhearted + Calm + Outspoken + Intelligent + Curious
             + Active + Careless + Broadminded + Sympathetic + Talkative + Sophisticated + Adventurous
             + Dominant + Thorough,
             data = midus_cs)



# LASSO
library(glmnet)

alif = 0.1

netformA = as.matrix(as.data.frame(lapply(midus_cs[complete.cases(midus_cs),], as.numeric)))

net.A = glmnet(netformA[,c(2:4,21:51)], netformA[,c(11,12,14:16)],
               family='mgaussian',standardize=T,
               nlambda=1000, alpha = alif)
cvnet.A = cv.glmnet(netformA[,c(2:4,21:51)], netformA[,c(11,12,14:16)],family='mgaussian',nfolds=100,alpha=alif)
plot(cvnet.A)

coef(net.A,s=cvnet.A$lambda.min)



net.A.AL = glmnet(netformA[,c(2:4,21:51)], netformA[,c(52)],
               family='gaussian',standardize=T,
               nlambda=1000, alpha = alif)
cvnet.A.AL = cv.glmnet(netformA[,c(2:4,21:51)], netformA[,c(52)],family='gaussian',nfolds=100,alpha=alif)
plot(cvnet.A.AL)

coef(net.A.AL,s=cvnet.A.AL$lambda.min)





### EXPERIMENTAL

library(BayesFactor)

BFm.test <- lmBF(sys ~ age, data=midus_cs)

BFm.test <- lmBF(sys ~ age + sex, data=midus_cs)


BFm.sys <- regressionBF(sys ~ age + sex + BMI #+ I(age^2)
                + Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion, 
                data = midus_cs[complete.cases(midus_cs),])

#summary(BFm.sys)
head(BFm.sys)
