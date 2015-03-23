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
#
# $B4ZCOMPY - year of collection of biomarker data

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
ageAtBloodDraw[outliers(ageAtBloodDraw,3)]<-NA
B1SOPEN[outliers(B1SOPEN,3)]<-NA
B1SAGREE[outliers(B1SAGREE,3)]<-NA
B1SCONS2[outliers(B1SCONS2,3)]<-NA
B1SNEURO[outliers(B1SNEURO,3)]<-NA
B1SEXTRA[outliers(B1SEXTRA,3)]<-NA
B4PBMI[outliers(B4PBMI,3)]<-NA
B4BCHOL[outliers(B4BCHOL,3)]<-NA
B4BTRIGL[outliers(B4BTRIGL,3)]<-NA
B4BSCREA[outliers(B4BSCREA,3)]<-NA
B4BSBAP[outliers(B4BSBAP,3)]<-NA
B4BGLUC[outliers(B4BGLUC,3)]<-NA
B4P1GS[outliers(B4P1GS,3)]<-NA
B4P1GD[outliers(B4P1GD,3)]<-NA

detach(midus_c)


midus_cs <- with(midus_c,data.frame(M2ID,B1PRSEX, age=s(ageAtBloodDraw),
                               open=s(B1SOPEN),agree=s(B1SAGREE),cons=s(B1SCONS2),
                               neuro=s(B1SNEURO),extra=s(B1SEXTRA),bmi=s(B4PBMI),
                               chol=s(B4BCHOL),trig=s(B4BTRIGL),creat=s(B4BSCREA),
                               alp=s(B4BSBAP),glucose=s(B4BGLUC),
                               sys=s(B4P1GS),dias=s(B4P1GD)))



m.sys <- lm(sys ~ age + B1PRSEX + bmi
            + open + agree + cons + neuro + extra, data = midus_cs)

m.dias <- lm(dias ~ age + B1PRSEX + bmi
             + open + agree + cons + neuro + extra, data = midus_cs)

m.chol <- lm(chol ~ age + B1PRSEX + bmi
             + open + agree + cons + neuro + extra, data = midus_cs)
# see m_2a

#m.trig <- lm(trig ~ age + B1PRSEX + bmi
#             + open + agree + cons + neuro + extra, data = midus_cs)
# see m_2b
#leave out?

m.creat <- lm(creat ~ age + B1PRSEX + bmi 
              + open + agree + cons + neuro + extra, data = midus_cs)
# see m2u

m.alp <- lm(chol ~ age + B1PRSEX + bmi
              + open + agree + cons + neuro + extra, data = midus_cs)
# see m2w

m.gluc <- lm(glucose ~ age + B1PRSEX + bmi
              + open + agree + cons + neuro + extra, data = midus_cs)
# see m_2c ++


### chol on BP?

cor.BPfromChol <- cor(midus_cs$sys,midus_cs$chol)
