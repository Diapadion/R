### take the MIDJA combined file and analyze it

#midja_c <- read.table()

# vars of interest
# MIDJA_IDS
# J1SQ2AGE
# J1SQ1 - gender
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



midja_cs <- with(midja_c,data.frame(MIDJA_IDS, sex=J1SQ1, age=s(J1SQ2AGE), 
                          Dominance=s(J1SAGENC),Extraversion=s(J1SEXTRA),Openness=s(J1SOPEN),
                          Conscientiousness=s(J1SCONS2),Agreeableness=s(J1SAGREE),Neuroticism=s(J1SNEURO),
                          BMI=s(J2CBMI),chol=s(J2BCHOL),creat=s(J2BSCREA),trig=s(J2CTRIG),
                          sys=s(J2CBPS23),dias=s(J2CBPD23),
                          tokyo_ch=s(J2CTCHOL)   # but also
                          ))
                          
mj.sys <- lm(sys ~ age + sex + BMI
          + dom + open + agree + cons + neuro + extra, data = midja_cs)
                          
mj.chol <- lm(chol ~ age + sex + BMI
           + dom + open + agree + cons + neuro + extra, data = midja_cs)              
mj.to_chol <- lm(tokyo_ch ~ age + sex + BMI
              + dom + open + agree + cons + neuro + extra, data = midja_cs)   

mj.trig <- lm(trig ~ age + sex + BMI
              + dom + open + agree + cons + neuro + extra, data = midja_cs)          

mj.creat <- lm(creat ~ age + sex + BMI 
              + dom + open + agree + cons + neuro + extra, data = midja_cs)          
