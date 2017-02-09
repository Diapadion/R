# 3 group SEMs
# MiDUS, MIDJA, Yerkes


### Standardization:
# Pers - across all groups
# Age - chimps * 1.8 (?) *** LOOK INTO
# BMs - across all groups
# BMI - within species
#       - make a model with, and without






all1 <- with(midja_c,data.frame(MIDJA_IDS, sex=J1SQ1, age=J2CAGE, age2=J2CAGE2,
                                    Dominance=J1SAGENC,Extraversion=J1SEXTRA,Openness=J1SOPEN,
                                    Conscientiousness=J1SCONS2,Agreeableness=J1SAGREE,Neuroticism=J1SNEURO,
                                    BMI=J2CBMI,chol=J2BCHOL,creat=J2BSCREA,trig=J2CTRIG,
                                    sys=J2CBPS23,dias=J2CBPD23))
colnames(all1)[1] <- 'M2ID'
all1 <- cbind(all1,'Japanese')
colnames(all1)[17] <- 'country'
all1 <- cbind(all1,'Human')
colnames(all1)[18] <- 'species'
all1 <- cbind(all1,'MIDJA')
colnames(all1)[19] <- 'sample'

all2 <- with(midus_c,data.frame(M2ID,sex=B1PRSEX, age=B4ZAGE, age2=B4ZAGE2,
                        Dominance=B1SAGENC,Extraversion=B1SEXTRA,Openness=B1SOPEN,
                        Conscientiousness=B1SCONS2,Agreeableness=B1SAGREE,Neuroticism=B1SNEURO,                               
                        BMI=B4PBMI,chol=B4BCHOL,creat=B4BSCREA,trig=B4BTRIGL,
                        sys=B4P1GS23,dias=B4P1GD23))
all2 <- cbind(all2[,c(1:16)],'American')
colnames(all2)[17] <- 'country'
all2 <- cbind(all2,'Human')
colnames(all2)[18] <- 'species'
all2 <- cbind(all2,'MIDUS')
colnames(all2)[19] <- 'sample'

# fixing the damn age
smeandat = meandat
smeandat$age <- 1.5*as.numeric(as.Date('01/01/2007', format = "%m/%d/%Y")-DoB)/365
colnames(smeandat)[4] <- 'age2'
smeandat$age2 <- as.numeric(smeandat$age2)
smeandat$age2 <- smeandat$age^2


smeandat <- with(smeandat,data.frame(Chimp,sex=sex, age=age, age2=age2,
                        Dominance=(((Dominance - 1) / 2) + 1),
                        Extraversion=(((Extraversion - 1) / 2) + 1),
                        Openness=(((Openness - 1) / 2) + 1),
                        Conscientiousness=(((Conscientiousness - 1) / 2) + 1),
                        Agreeableness=(((Agreeableness - 1) / 2) + 1),
                        Neuroticism=(((Neuroticism - 1) / 2) + 1),                               
                        BMI=s(BMI),chol=chol,creat=creat,trig=trig,
                        sys=sys,dias=dias
))
                       
colnames(smeandat)[1] <- "M2ID"
smeandat <- cbind(smeandat, 'American')
colnames(smeandat)[17] <- 'country'
smeandat <- cbind(smeandat,'Chimp')
colnames(smeandat)[18] <- 'species'  
smeandat <- cbind(smeandat,'YNPRC')
colnames(smeandat)[19] <- 'sample'

all3 <- rbind(all1,all2)
all3$BMI <- s(all3$BMI) 
              
all3 <- rbind(all3, smeandat)

all3$age <- s(all3$age)
all3$age2 <- s(all3$age2)
all3$Dominance <- s(all3$Dominance)
all3$Extraversion <- s(all3$Extraversion)
all3$Conscientiousness <- s(all3$Conscientiousness)
all3$Openness <- s(all3$Openness)
all3$Neuroticism <- s(all3$Neuroticism)
all3$Agreeableness <- s(all3$Agreeableness)
all3$sys <- s(all3$sys)
all3$dias <- s(all3$dias)
all3$chol <- s(all3$chol)
all3$trig <- s(all3$trig)
all3$creat <- s(all3$creat)

#summary(all3)


s <- function(x) {scale(x)}


library(lavaan)
library(semPlot)
library(semTools)
library(blavaan)


sem.1 <- '

AL =~ 1*chol + 1*trig + 1*sys + 1*dias + 1*BMI
#AL =~ chol + trig + sys + dias + BMI

AL ~ sex + age + age2 + Dominance + Extraversion + Openness + Conscientiousness + Agreeableness + Neuroticism

AL ~ sex + age + age2 + Dominance + Extraversion + Openness + Conscientiousness + Agreeableness + Neuroticism

sys ~~ dias
sys ~~ trig
sys ~~ BMI
sys ~~ chol
dias ~~ trig
dias ~~ BMI
dias ~~ chol
trig ~~ BMI
trig ~~ chol
BMI ~~ chol

'

Regressions:
  Estimate  Std.Err  z-value  P(>|z|)
AL ~                                                
  sex               0.039    0.068    0.568    0.570
age              -0.066    0.187   -0.352    0.725
age2              0.191    0.208    0.917    0.359
Dominance         0.142    0.056    2.524    0.012
Extraversion     -0.029    0.075   -0.380    0.704
Openness         -0.043    0.044   -0.980    0.327
Conscientisnss    0.092    0.055    1.664    0.096
Agreeableness    -0.062    0.064   -0.959    0.337
Neuroticism      -0.079    0.048   -1.658    0.097


# Constain negative variances to 0

# separately for pers variables?



f3.0 <- lavaan(sem.1, data = all3, missing="ML", model.type='sem',
               int.ov.free = TRUE, int.lv.free = FALSE, auto.fix.first = TRUE,
               auto.fix.single = TRUE, auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE,
               auto.cov.y = TRUE
)
f3.0b <- lavaan(sem.1, data = all3, missing="ML", model.type='sem',
               group.equal = c("regressions"),
               group.partial = c("AL ~ sex","AL ~ age","AL ~ age2"),
               int.ov.free = TRUE, int.lv.free = FALSE, auto.fix.first = TRUE,
               auto.fix.single = TRUE, auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE,
               auto.cov.y = TRUE
)
semPaths(f3.0, what='mod', whatLabels = 'par')
fitMeasures(f3.0, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr",'AIC','BIC'))
fitMeasures(f3.0b, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr",'AIC','BIC'))



f3.1b <- lavaan(sem.1, data = all3, missing="ML", model.type='sem', group = 'species',
               group.equal = c("regressions"),
               group.partial = c("AL ~ sex","AL ~ age","AL ~ age2"),
               int.ov.free = TRUE, int.lv.free = FALSE, auto.fix.first = TRUE, 
               auto.fix.single = TRUE, auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
               auto.cov.y = TRUE
               )

semPaths(f3.1, what='mod', whatLabels = 'par')
summary(f3.1)
fitMeasures(f3.1, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr",'AIC','BIC'))

measurementInvariance(sem.1, data = all3, missing="ML", group = 'species')



f3.2b <- lavaan(sem.1, data = all3, missing="ML", model.type='sem', group = 'country',
               group.equal = c("regressions"),
               group.partial = c("AL ~ sex","AL ~ age","AL ~ age2"),
               int.ov.free = TRUE, int.lv.free = FALSE, auto.fix.first = TRUE, 
               auto.fix.single = TRUE, auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
               auto.cov.y = TRUE
)

semPaths(f3.2, what='mod', whatLabels = 'par')
summary(f3.2)
fitMeasures(f3.2, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr",'AIC','BIC'))

measurementInvariance(sem.1, data = all3, missing="ML", group = 'country')



f3.3 <- lavaan(sem.1, data = all3, missing="ML", model.type='sem', group = 'sample',
               int.ov.free = TRUE, int.lv.free = FALSE, auto.fix.first = TRUE, 
               auto.fix.single = TRUE, auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
 
                             auto.cov.y = TRUE
)
f3.3b <- lavaan(sem.1, data = all3, missing="ML", model.type='sem', group = 'sample',
               group.equal = c("regressions"),
               group.partial = c("AL ~ sex","AL ~ age","AL ~ age2"),
               int.ov.free = TRUE, int.lv.free = FALSE, auto.fix.first = TRUE, 
               auto.fix.single = TRUE, auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
               auto.cov.y = TRUE
)

semPaths(f3.3, what='mod', whatLabels = 'par')
summary(f3.3)
fitMeasures(f3.3, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr",'AIC','BIC'))

summary(f3.3b)

measurementInvariance(sem.1, data = all3, missing="ML", group = 'sample')




compareFit(f3.0,f3.1,f3.2,f3.3)




# mod_ind <- modificationindices(f3.1)
# head(mod_ind[order(mod_ind$mi, decreasing=TRUE), ], 10)
# subset(mod_ind[order(mod_ind$mi, decreasing=TRUE), ], mi > 5)


sex              -0.193    0.032   -6.013    0.000
age               0.626    0.104    6.046    0.000
age2             -0.570    0.103   -5.515    0.000
Dominance         0.088    0.021    4.227    0.000
Extraversion     -0.042    0.025   -1.722    0.085
Openness         -0.027    0.023   -1.170    0.242
Conscientisnss    0.003    0.019    0.147    0.883
Agreeableness     0.091    0.024    3.813    0.000
Neuroticism       0.015    0.016    0.944    0.345



