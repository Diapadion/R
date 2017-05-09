### take the MIDJA combined file and analyze it

#midja_c <- read.table()

# vars of interest
# MIDJA_IDS
# J2CAGE - Age at clinic visit
# J1SQ1 - "gender" (1 = male, 2 = female)
# 
# J1SAGENC
# J1SEXTRA
# J1SCONS2
# J1SOPEN
# J1SAGREE
# J1SNEURO
#
# J2CBMI

# J2BCHOL
# J2BSCREA
# J2CTRIG
# 
# J2CBPS23
# J2CBPD23
# change these in MIDUS, too

# outliers?
midja_c$J1SAGENC[midja_c$J1SAGENC==8]<-NA
midja_c$J1SEXTRA[midja_c$J1SEXTRA==8]<-NA
midja_c$J1SCONS2[midja_c$J1SCONS2==8]<-NA
midja_c$J1SOPEN[midja_c$J1SOPEN==8]<-NA
midja_c$J1SAGREE[midja_c$J1SAGREE==8]<-NA
midja_c$J1SNEURO[midja_c$J1SNEURO==8]<-NA
midja_c$J2CTRIG[outliers(midja_c$J2CTRIG,3.5)]<-NA

midja_c$J1SG6A[midja_c$J1SG6A==8]<-NA
midja_c$J1SG6B[midja_c$J1SG6B==8]<-NA
midja_c$J1SG6C[midja_c$J1SG6C==8]<-NA
midja_c$J1SG6D[midja_c$J1SG6D==8]<-NA
midja_c$J1SG6E[midja_c$J1SG6E==8]<-NA
midja_c$J1SG6F[midja_c$J1SG6F==8]<-NA
midja_c$J1SG6G[midja_c$J1SG6G==8]<-NA
midja_c$J1SG6H[midja_c$J1SG6H==8]<-NA
midja_c$J1SG6I[midja_c$J1SG6I==8]<-NA
midja_c$J1SG6J[midja_c$J1SG6J==8]<-NA
midja_c$J1SG6K[midja_c$J1SG6K==8]<-NA
midja_c$J1SG6L[midja_c$J1SG6L==8]<-NA
midja_c$J1SG6M[midja_c$J1SG6M==8]<-NA
midja_c$J1SG6N[midja_c$J1SG6N==8]<-NA
midja_c$J1SG6O[midja_c$J1SG6O==8]<-NA
midja_c$J1SG6P[midja_c$J1SG6P==8]<-NA
midja_c$J1SG6Q[midja_c$J1SG6Q==8]<-NA
midja_c$J1SG6R[midja_c$J1SG6R==8]<-NA
midja_c$J1SG6S[midja_c$J1SG6S==8]<-NA
midja_c$J1SG6T[midja_c$J1SG6T==8]<-NA
midja_c$J1SG6U[midja_c$J1SG6U==8]<-NA
midja_c$J1SG6V[midja_c$J1SG6V==8]<-NA
midja_c$J1SG6W[midja_c$J1SG6W==8]<-NA
midja_c$J1SG6X[midja_c$J1SG6X==8]<-NA
midja_c$J1SG6Y[midja_c$J1SG6Y==8]<-NA
midja_c$J1SG6Z[midja_c$J1SG6Z==8]<-NA
midja_c$J1SG6AA[midja_c$J1SG6AA==8]<-NA
midja_c$J1SG6BB[midja_c$J1SG6BB==8]<-NA
midja_c$J1SG6CC[midja_c$J1SG6CC==8]<-NA
midja_c$J1SG6DD[midja_c$J1SG6DD==8]<-NA
midja_c$J1SG6EE[midja_c$J1SG6EE==8]<-NA


midja_c$J2CAGE2 = (midja_c$J2CAGE)^2



midja_cs <- with(midja_c,data.frame(MIDJA_IDS, sex=J1SQ1, age=s(J2CAGE), age2=s(J2CAGE2),
                          Dominance=s(J1SAGENC),Extraversion=s(J1SEXTRA),Openness=s(J1SOPEN),
                          Conscientiousness=s(J1SCONS2),Agreeableness=s(J1SAGREE),Neuroticism=s(J1SNEURO),
                          BMI=s(J2CBMI),chol=s(J2BCHOL),creat=s(J2BSCREA),trig=s(J2CTRIG),
                          sys=s(J2CBPS23),dias=s(J2CBPD23),
                          tokyo_ch=s(J2CTCHOL),   # but also
                          Outgoing=s(J1SG6A),Helpful=s(J1SG6B),Moody=s(J1SG6C),
                          Organized=s(J1SG6D),Selfconfident=s(J1SG6E),Friendly=s(J1SG6F),
                          Warm=s(J1SG6G),Worrying=s(J1SG6H),Responsible=s(J1SG6I),
                          Forceful=s(J1SG6J),Lively=s(J1SG6K),Caring=s(J1SG6L),
                          Nervous=s(J1SG6M),Creative=s(J1SG6N),Assertive=s(J1SG6O),
                          Hardworking=s(J1SG6P),Imaginative=s(J1SG6Q),Softhearted=s(J1SG6R),
                          Calm=s(J1SG6S),Outspoken=s(J1SG6T),Intelligent=s(J1SG6U),
                          Curious=s(J1SG6V),Active=s(J1SG6W),Careless=s(J1SG6X),
                          Broadminded=s(J1SG6Y),Sympathetic=s(J1SG6Z),Talkative=s(J1SG6AA),
                          Sophisticated=s(J1SG6BB),Adventurous=s(J1SG6CC),Dominant=s(J1SG6DD),
                          Thorough=s(J1SG6EE)
                          ))

                          
mj.sys <- lm(sys ~ age + sex + BMI
          + Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion, data = midja_cs)
                          
mj.chol <- lm(chol ~ age + sex + BMI
           + Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion, data = midja_cs)              
mj.to_chol <- lm(tokyo_ch ~ age + sex + BMI
              + Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion, data = midja_cs)   

mj.trig <- lm(trig ~ age + sex + BMI
              + Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion, data = midja_cs)          

mj.creat <- lm(creat ~ age + sex + BMI 
              + Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion, data = midja_cs)          

mj.dias <- lm(dias ~ age + sex + BMI
                     + Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion, data = midja_cs)

mj.BMI <- lm(BMI ~ age + sex
              + Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion, data = midja_cs)


### with age^2

mj.sys.a2 <- lm(sys ~ age + I(age^2) + sex + BMI
             + Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion, data = midja_cs)

mj.chol.a2 <- lm(chol ~ age + I(age^2) + sex + BMI
              + Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion, data = midja_cs)              

mj.trig.a2 <- lm(trig ~ age + I(age^2) +  sex + BMI
              + Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion, data = midja_cs)          

mj.creat.a2 <- lm(creat ~ age + I(age^2) + sex + BMI 
               + Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion, data = midja_cs)          

mj.dias.a2 <- lm(dias ~ age + I(age^2) + sex + BMI
              + Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion, data = midja_cs)

mj.BMI.a2 <- lm(BMI ~ age + I(age^2) + sex
             + Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion, data = midja_cs)



### coming out of SEMs



mjAL.1 <- lm(AL ~ age + age2 + sex
             + Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion,
             data = all3[all3$sample=='MIDJA',])
summary(mjAL.1)


midja_cs$AL = midja_cs$sys + midja_cs$dias + midja_cs$chol + midja_cs$trig + midja_cs$BMI # these need medication adjustment
mjALallItems.1 <- lm(AL ~ age + age2 + sex
                     + Outgoing + Helpful + Moody + Organized + Selfconfident + Friendly + Warm + Worrying
                     + Responsible + Forceful + Lively + Caring + Nervous + Creative + Assertive
                     + Hardworking + Imaginative + Softhearted + Calm + Outspoken + Intelligent + Curious
                     + Active + Careless + Broadminded + Sympathetic + Talkative + Sophisticated + Adventurous
                     + Dominant + Thorough,
                     data = midja_cs)


# LASSOs
library(lasso)



alif = 0.1

netformJ = as.matrix(as.data.frame(lapply(midja_cs[complete.cases(midja_cs),], as.numeric)))

net.J = glmnet(netformJ[,c(2:4,18:48)], netformJ[,c(11,12,14:16)],
               family='mgaussian',standardize=T,
               nlambda=1000, alpha = alif)
cvnet.J = cv.glmnet(netformJ[,c(2:4,18:48)], netformJ[,c(11,12,14:16)],family='mgaussian',nfolds=100,alpha=alif)
plot(cvnet.J)

coef(net.J,s=cvnet.J$lambda.min)

net.J.AL = glmnet(netformJ[,c(2:4,18:48)], netformJ[,c(49)],
               family='gaussian',standardize=T,
               nlambda=1000, alpha = alif)
cvnet.J.AL = cv.glmnet(netformJ[,c(2:4,18:48)], netformJ[,c(49)],family='gaussian',nfolds=100,alpha=alif)
plot(cvnet.J.AL)

coef(net.J.AL,s=cvnet.J.AL$lambda.min)


