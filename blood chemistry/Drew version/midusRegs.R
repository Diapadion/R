### take the MIDUS combined file and analyze it

#midus_c <- read.table()

# vars of interest
# $M2ID
# $B1PBYEAR
# $B1PRSEX
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
# $B4P1GS - average sitting systolic
# $B4P1GD - average sitting diastolic

midus_c$ageAtBloodDraw <- midus_c$B4ZCOMPY - midus_c$B1PBYEAR

# cleaning & scaling

attach(midus_c)
ageAtBloodDraw[outliers(ageAtBloodDraw,3.5)]<-NA
#B1SOPEN[outliers(B1SOPEN,3.5)]<-NA
#B1SAGREE[outliers(B1SAGREE,3.5)]<-NA
#B1SCONS2[outliers(B1SCONS2,3.5)]<-NA
#B1SNEURO[outliers(B1SNEURO,3.5)]<-NA
#B1SEXTRA[outliers(B1SEXTRA,3.5)]<-NA
B4PBMI[outliers(B4PBMI,3.5)]<-NA
B4BCHOL[outliers(B4BCHOL,3.5)]<-NA
B4BTRIGL[outliers(B4BTRIGL,3.5)]<-NA
B4BSCREA[outliers(B4BSCREA,3.5)]<-NA
B4BSBAP[outliers(B4BSBAP,3.5)]<-NA
B4BGLUC[outliers(B4BGLUC,3.5)]<-NA
B4P1GS[outliers(B4P1GS,3.5)]<-NA
B4P1GD[outliers(B4P1GD,3.5)]<-NA
#B1SAGENC[outliers(B1SAGENC,3.5)]<-NA
detach(midus_c)
ageAtBloodDraw[outliers(ageAtBloodDraw,3.5)]<-NA
midus_c$B1SOPEN[midus_c$B1SOPEN==8]<-NA
midus_c$B1SAGREE[midus_c$B1SAGREE==8]<-NA
midus_c$B1SCONS2[midus_c$B1SCONS2==8]<-NA
midus_c$B1SNEURO[midus_c$B1SNEURO==8]<-NA
midus_c$B1SEXTRA[midus_c$B1SEXTRA==8]<-NA
midus_c$B1SAGENC[midus_c$B1SAGENC==8]<-NA
midus_c$B4BTRIGL[outliers(midus_c$B4BTRIGL,3.5)]<-NA


midus_cs <- with(midus_c,data.frame(M2ID,sex=B1PRSEX, age=s(ageAtBloodDraw),
                                    Dominance=s(B1SAGENC),Extraversion=s(B1SEXTRA),Openness=s(B1SOPEN),
                                    Conscientiousness=s(B1SCONS2),Agreeableness=s(B1SAGREE),Neuroticism=s(B1SNEURO),                               
                                    BMI=s(B4PBMI),chol=s(B4BCHOL),creat=s(B4BSCREA),trig=s(B4BTRIGL),
                                    sys=s(B4P1GS),dias=s(B4P1GD),
                                    alp=s(B4BSBAP),glucose=s(B4BGLUC)))


### models
### add Agency personality (24/03/15)

m.sys <- lm(sys ~ age + sex + BMI
            + dom + open + agree + cons + neuro + extra, data = midus_cs)
# see m_1

m.dias <- lm(dias ~ age +sex + BMI
             + dom + open + agree + cons + neuro + extra, data = midus_cs)

m.chol <- lm(chol ~ age +sex + BMI
             + dom + open + agree + cons + neuro + extra, data = midus_cs)
# see m_2a

m.trig <- lm(trig ~ age +sex + BMI
             + dom + open + agree + cons + neuro + extra, data = midus_cs)
# see m_2b
#leave out?

m.creat <- lm(creat ~ age +sex + BMI 
              + dom + open + agree + cons + neuro + extra, data = midus_cs)
# see m2u

m.alp <- lm(chol ~ age +sex + BMI
            + dom + open + agree + cons + neuro + extra, data = midus_cs)
# see m2w

m.gluc <- lm(glucose ~ age +sex + BMI
             + dom + open + agree + cons + neuro + extra, data = midus_cs)
# see m_2c ++


### chol on BP?

cor.BPfromChol <- cor(midus_cs$sys,midus_cs$chol)




### plots (24/03/25)
#library(stargazer)
#stargazer()

