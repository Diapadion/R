# 3 group SEMs
# MiDUS, MIDJA, Yerkes



### Standardization:
# Pers - across all groups
#      > within groups may be the  better option
# Age - chimps * 1.5
# BMs - across all groups
# BMI - within species
#       - make a model with, and without

### Medication adjustment:
# (before standardization)
# Blood Pressure
table(midja_c$J2MBPD)
table(midus_c$B4XBPD)
# 1 is Yes, 2 is No
# for 1, add 10 mmHg and 5 mmHg to Sys and Dias, respectively
#
# Cholesterol
table(midus_c$B4XCHD)
table(midja_c$J2MCHD)
# for 1, add 21.24 mg/dL to Chol


all1 <- with(midja_c,data.frame(MIDJA_IDS, sex=J1SQ1, age=J2CAGE, age2=J2CAGE2,
                                    # Dominance=J1SAGENC,Extraversion=J1SEXTRA,Openness=J1SOPEN,
                                    # Conscientiousness=J1SCONS2,Agreeableness=J1SAGREE,Neuroticism=J1SNEURO,
                                # this needs to be tried with within sample standardization
                                Dominance=s(J1SAGENC),Extraversion=s(J1SEXTRA),Openness=s(J1SOPEN),
                                Conscientiousness=s(J1SCONS2),Agreeableness=s(J1SAGREE),Neuroticism=s(J1SNEURO),
                                    BMI=J2CBMI,chol=J2BCHOL,creat=J2BSCREA,trig=J2CTRIG,#gluc=NA,
                                    sys=J2CBPS23,dias=J2CBPD23
                                ))
colnames(all1)[1] <- 'M2ID'
all1 <- cbind(all1,'Japanese')
colnames(all1)[17] <- 'country'
all1 <- cbind(all1,'Human')
colnames(all1)[18] <- 'species'
all1 <- cbind(all1,'MIDJA')
colnames(all1)[19] <- 'sample'

all1$dias = all1$dias + 5*(midja_c$J2MBPD==1)
all1$sys = all1$sys + 10*(midja_c$J2MBPD==1)
all1$chol = all1$chol + 21.24*(midja_c$J2MCHD==1)


all2 <- with(midus_c,data.frame(M2ID,sex=B1PRSEX, age=B4ZAGE, age2=B4ZAGE2,
                        # Dominance=B1SAGENC,Extraversion=B1SEXTRA,Openness=B1SOPEN,
                        # Conscientiousness=B1SCONS2,Agreeableness=B1SAGREE,Neuroticism=B1SNEURO,   
                        # this needs to be tried with within sample standardization
                        Dominance=s(B1SAGENC),Extraversion=s(B1SEXTRA),Openness=s(B1SOPEN),
                        Conscientiousness=s(B1SCONS2),Agreeableness=s(B1SAGREE),Neuroticism=s(B1SNEURO),
                        BMI=B4PBMI,chol=B4BCHOL,creat=B4BSCREA,trig=B4BTRIGL,#gluc=B4BGLUC
                        sys=B4P1GS23,dias=B4P1GD23))
all2 <- cbind(all2[,c(1:16)],'American')
colnames(all2)[17] <- 'country'
all2 <- cbind(all2,'Human')
colnames(all2)[18] <- 'species'
all2 <- cbind(all2,'MIDUS')
colnames(all2)[19] <- 'sample'

all2$dias = all2$dias + 5*(midus_c$B4XBPD==1)
all2$sys = all2$sys + 10*(midus_c$B4XBPD==1)
all2$chol = all2$chol + 21.24*(midus_c$B4XCHD==1)


# fixing the damn age
smeandat = meandat
smeandat$age <- 1.5*as.numeric(as.Date('01/01/2007', format = "%m/%d/%Y")-DoB)/365
colnames(smeandat)[4] <- 'age2'
smeandat$age2 <- as.numeric(smeandat$age2)
smeandat$age2 <- smeandat$age^2


smeandat <- with(smeandat,data.frame(Chimp,sex=sex, age=age, age2=age2,
                        # Dominance=(((Dominance - 1) / 2) + 1),
                        # Extraversion=(((Extraversion - 1) / 2) + 1),
                        # Openness=(((Openness - 1) / 2) + 1),
                        # Conscientiousness=(((Conscientiousness - 1) / 2) + 1),
                        # Agreeableness=(((Agreeableness - 1) / 2) + 1),
                        # Neuroticism=(((Neuroticism - 1) / 2) + 1),         
                        Dominance=s(Dominance),
                        Extraversion=s(Extraversion),
                        Openness=s(Openness),
                        Conscientiousness=s(Conscientiousness),
                        Agreeableness=s(Agreeableness),
                        Neuroticism=s(Neuroticism), 
                        BMI=s(BMI),chol=chol,creat=creat,trig=trig,#gluc=glucose
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



### Data suitability

library(psych)

cortest.bartlett(all3[all3$sample=='MIDUS',3:16])
cortest.bartlett(all3[all3$sample=='MIDJA',3:16])
cortest.bartlett(all3[all3$sample=='YNPRC',3:16])

#KMO(all3[all3$sample=='MIDJA',3:16])


### SEM

library(lavaan)
library(semPlot)
library(semTools)
library(blavaan)


sem.0 <- '

AL =~ 1*chol + 1*trig + 1*sys + 1*dias + 1*BMI
#AL =~ chol + trig + sys + dias + BMI

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


# Constrain negative variances to 0

# separately for pers variables?



f3.0 <- lavaan(sem.0, data = all3, missing="ML", model.type='sem',
               std.lv = F, int.ov.free = TRUE, int.lv.free = FALSE, auto.fix.first = TRUE,
               auto.fix.single = TRUE, auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE,
               auto.cov.y = TRUE
)
f3.0b <- lavaan(sem.0, data = all3, missing="ML", model.type='sem',
               group.equal = c("regressions"),
               group.partial = c("AL ~ sex","AL ~ age","AL ~ age2"),
               int.ov.free = TRUE, int.lv.free = FALSE, auto.fix.first = TRUE,
               auto.fix.single = TRUE, auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE,
               auto.cov.y = TRUE
)
semPaths(f3.0, what='mod', whatLabels = 'par')
fitMeasures(f3.0, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr",'AIC','BIC'))
fitMeasures(f3.0b, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr",'AIC','BIC'))
# Neither of the above models are useful because they don't allow sex, age, and age^2 to vary by group


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




### Contraints by group

# The order of samples is 
# 1. Japanese
# 2. Americans
# 3. Chimps

# *** should std.lv = FALSE?

sem.0.ALov0 <- '

AL =~ 1*chol + 1*trig + 1*sys + 1*dias + 1*BMI

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

## across sample, these variances tend to go negative with f3.3b, so we set them = to 0
trig ~~ c(vTrigJ,vTrigA,vTrigC)*trig
BMI ~~ c(vBMIJ,vBMIA,vBMIC)*BMI

vTrigC > 0
vBMIJ > 0
vChol > 0

'

# Pers regs jointly estimated across groups (null model)
# (variance of Trig and BMI adjusted)
f3.3b <- lavaan(sem.0.ALov0, data = all3, missing="ML", group = 'sample', 
                group.equal = c("regressions"),
                group.partial = c("AL ~ sex","AL ~ age","AL ~ age2")
                ,model.type='sem', std.lv=T,int.ov.free = TRUE, int.lv.free = FALSE, auto.fix.first = F,
                auto.fix.single = TRUE, auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE,
                auto.cov.y = TRUE#, se = "boot", bootstrap = 100
                , estimator = 'MLR'
)


# All parameters freely estimated within groups
# (this model has the same variance issues as f3.3b)
f3.3 <- lavaan(sem.0.ALov0, data = all3, missing="ML", model.type='sem', group = 'sample',
               std.lv=T,int.ov.free = TRUE, int.lv.free = FALSE, auto.fix.first = F, 
               auto.fix.single = TRUE, auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
               auto.cov.y = TRUE
)




sem.1 <- ' # model 1 groups the sample by species

AL =~ 1*chol + 1*trig + 1*sys + 1*dias + 1*BMI
#AL =~ chol + trig + sys + dias + BMI

AL ~ sex + age + age2 + c(d1,d1,d2)*Dominance + c(e1,e1,e2)* Extraversion + c(o1,o1,o2)*Openness + 
c(c1,c1,c2)*Conscientiousness + c(a1,a1,a2)*Agreeableness + c(n1,n1,n2)*Neuroticism

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

# within particular samples these variances tend to go negative with f3.3b, so we set them = to 0
trig ~~ c(vTrigJ,vTrigA,vTrigC)*trig
BMI ~~ c(vBMIJ,vBMIA,vBMIC)*BMI

vTrigC > 0
vBMIJ > 0

'

f3.1x <- lavaan(sem.1, data = all3, missing="ML", model.type='sem', group = 'sample',
                #                group.equal = c("regressions"),
                #                group.partial = c("AL ~ sex","AL ~ age","AL ~ age2"),
                std.lv = T, int.ov.free = TRUE, int.lv.free = FALSE, auto.fix.first = F, 
                auto.fix.single = TRUE, auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
                auto.cov.y = TRUE
)



sem.2 <- ' # model 2 groups the sample by country

AL =~ 1*chol + 1*trig + 1*sys + 1*dias + 1*BMI
#AL =~ chol + trig + sys + dias + BMI

AL ~ sex + age + age2 + c(d1,d2,d2)*Dominance + c(e1,e2,e2)* Extraversion + c(o1,o2,o2)*Openness + 
c(c1,c2,c2)*Conscientiousness + c(a1,a2,a2)*Agreeableness + c(n1,n2,n2)*Neuroticism

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

# within particular samples these variances tend to go negative with f3.3b, so we set them = to 0
trig ~~ c(vTrigJ,vTrigA,vTrigC)*trig
BMI ~~ c(vBMIJ,vBMIA,vBMIC)*BMI

vTrigC > 0
vBMIJ > 0

'

f3.2x <- lavaan(sem.2, data = all3, missing="ML", model.type='sem', group = 'sample',
#                group.equal = c("regressions"),
#                group.partial = c("AL ~ sex","AL ~ age","AL ~ age2"),
                std.lv = T, int.ov.free = TRUE, int.lv.free = FALSE, auto.fix.first = F, 
                auto.fix.single = TRUE, auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
                auto.cov.y = TRUE
)

semPaths(f3.2x, what='mod', whatLabels = 'par')
summary(f3.2x)
fitMeasures(f3.2x, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr",'AIC','BIC')) # country

fitMeasures(f3.1x, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr",'AIC','BIC')) # species

fitMeasures(f3.3, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr",'AIC','BIC')) # sample
fitMeasures(f3.3b, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr",'AIC','BIC')) # all as one

compareFit(f3.2x,f3.1x,f3.3,f3.3b))



### What if we do this the other remaining, unexpected way?

sem.4 <- ' # model 4 groups the samples by Japanese & Chimps

AL =~ 1*chol + 1*trig + 1*sys + 1*dias + 1*BMI

AL ~ sex + age + age2 + c(d2,d1,d2)*Dominance + c(e2,e1,e2)* Extraversion + c(o2,o1,o2)*Openness + 
c(c2,c1,c2)*Conscientiousness + c(a2,a1,a2)*Agreeableness + c(n2,n1,n2)*Neuroticism

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

# within particular samples these variances tend to go negative with f3.3b, so we set them = to 0
trig ~~ c(vTrigJ,vTrigA,vTrigC)*trig
BMI ~~ c(vBMIJ,vBMIA,vBMIC)*BMI

vTrigC > 0
vBMIJ > 0

'

f3.4 <- lavaan(sem.4, data = all3, missing="ML", model.type='sem', group = 'sample',
                #                group.equal = c("regressions"),
                #                group.partial = c("AL ~ sex","AL ~ age","AL ~ age2"),
                std.lv = F, int.ov.free = TRUE, int.lv.free = FALSE, auto.fix.first = TRUE, 
                auto.fix.single = TRUE, auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
                auto.cov.y = TRUE
)

fitMeasures(f3.4, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr",'AIC','BIC')) # 



sem.5 <- ' # group based on where personality is similar

AL =~ 1*chol + 1*trig + 1*sys + 1*dias + 1*BMI

AL ~ sex + age + age2 + c(dJ,dAC,dAC)*Dominance + c(eJC,eA,eJC)* Extraversion + c(oJC,oA,oJC)*Openness + 
c(cJC,cA,cJC)*Conscientiousness + c(aJC,aA,aJC)*Agreeableness + c(nJA,nJA,nC)*Neuroticism

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

# within particular samples these variances tend to go negative with f3.3b, so we set them = to 0
trig ~~ c(vTrigJ,vTrigA,vTrigC)*trig
BMI ~~ c(vBMIJ,vBMIA,vBMIC)*BMI

vTrigC > 0
vBMIJ > 0

'

f3.5 <- lavaan(sem.5, data = all3, missing="ML", model.type='sem', group = 'sample',
               #                group.equal = c("regressions"),
               #                group.partial = c("AL ~ sex","AL ~ age","AL ~ age2"),
               std.lv = F, int.ov.free = TRUE, int.lv.free = FALSE, auto.fix.first = TRUE, 
               auto.fix.single = TRUE, auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
               auto.cov.y = TRUE
)

fitMeasures(f3.5, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr",'AIC','BIC')) # 




### Freeing the LV loadings ###
# (but, keeping them the same across groups)

sem.1.free <- ' # model 1 groups the sample by species

AL =~ chol + trig + sys + dias + BMI

AL ~ sex + age + age2 + c(d1,d1,d2)*Dominance + c(e1,e1,e2)* Extraversion + c(o1,o1,o2)*Openness + 
c(c1,c1,c2)*Conscientiousness + c(a1,a1,a2)*Agreeableness + c(n1,n1,n2)*Neuroticism

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

# within particular samples these variances tend to go negative with f3.3b, so we set them = to 0
# trig ~~ c(vTrigJ,vTrigA,vTrigC)*trig
# BMI ~~ c(vBMIJ,vBMIA,vBMIC)*BMI
# 
# vTrigC > 0
# vBMIJ > 0

'

sem.2.free <- ' # model 2 groups the sample by country

AL =~ chol + trig + sys + dias + BMI

AL ~ sex + age + age2 + c(d1,d2,d2)*Dominance + c(e1,e2,e2)* Extraversion + c(o1,o2,o2)*Openness + 
c(c1,c2,c2)*Conscientiousness + c(a1,a2,a2)*Agreeableness + c(n1,n2,n2)*Neuroticism

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

# within particular samples these variances tend to go negative with f3.3b, so we set them = to 0
trig ~~ c(vTrigJ,vTrigA,vTrigC)*trig
BMI ~~ c(vBMIJ,vBMIA,vBMIC)*BMI

vTrigC > 0
vBMIJ > 0

'

sem.0.free <- '

AL =~ chol + trig + sys + dias + BMI

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

## across sample, these variances tend to go negative with f3.3b, so we set them = to 0
# trig ~~ c(vTrigJ,vTrigA,vTrigC)*trig
# BMI ~~ c(vBMIJ,vBMIA,vBMIC)*BMI
# chol ~~ vChol*chol
# sys ~~ vSys*sys
#dias ~~ vDias*dias

# vTrigC > 0
# vBMIJ > 0
# vChol > 0
# vSys > 0
# vDias > 0

'


f3.3b.free <- lavaan(sem.0.free, data = all3, missing="ML", group = 'sample', 
                group.equal = c("regressions","loadings")
                group.partial = c("AL ~ sex","AL ~ age","AL ~ age2")
                ,model.type='sem', std.lv=T,int.ov.free = TRUE, int.lv.free = FALSE, auto.fix.first = F,
                auto.fix.single = TRUE, auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE,
                auto.cov.y = TRUE#, se = "boot", bootstrap = 100
                , estimator = 'MLR')

f3.3.free <- lavaan(sem.0.free, data = all3, missing="ML", group = 'sample', 
                     group.equal = c("loadings")
                     ,model.type='sem', std.lv=T,int.ov.free = TRUE, int.lv.free = FALSE, auto.fix.first = F,
                     auto.fix.single = TRUE, auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE,
                     auto.cov.y = TRUE#, se = "boot", bootstrap = 100
                     , estimator = 'MLR')

f3.1.free <- lavaan(sem.1.free, data = all3, missing="ML", group = 'sample', 
                     group.equal = c("loadings")
                     ,model.type='sem', std.lv=T,int.ov.free = TRUE, int.lv.free = FALSE, auto.fix.first = F,
                     auto.fix.single = TRUE, auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE,
                     auto.cov.y = TRUE#, se = "boot", bootstrap = 100
                     , estimator = 'MLR')

f3.2.free <- lavaan(sem.2.free, data = all3, missing="ML", group = 'sample', 
                    group.equal = c("loadings")
                    ,model.type='sem', std.lv=T,int.ov.free = TRUE, int.lv.free = FALSE, auto.fix.first = F,
                    auto.fix.single = TRUE, auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE,
                    auto.cov.y = TRUE#, se = "boot", bootstrap = 100
                    , estimator = 'MLR')

fitMeasures(f3.1.free, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr",'AIC','BIC')) #
fitMeasures(f3.2.free, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr",'AIC','BIC')) #
fitMeasures(f3.3b.free, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr",'AIC','BIC')) #
fitMeasures(f3.3.free, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr",'AIC','BIC')) #

summary(f3.1.free)
