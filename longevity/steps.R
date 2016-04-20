library(coxme)
library(survival)
library(bbmle)

####### Forward Selection

attr(yLt, 'type') <- 'mcounting'


### Unadjusted
aft.s0 <- survreg(yLt ~ as.factor(sex)
                  + frailty.gaussian(sample)
                  , data=datX, dist = 'logistic')

aft.s1 <- survreg(yLt ~ as.factor(sex) + 
                    Opn_CZ
                          + frailty.gaussian(sample)
                          , data=datX, dist = 'logistic')
summary(aft.s1)
AICtab(aft.s0, aft.s1,
       logLik=T, sort=T, delta=T, base=T,weights=T)
anova(aft.s0, aft.s1)


aft.s2 <- survreg(yLt ~ as.factor(sex)
                  + Opn_CZ + Agr_CZ
                  + frailty.gaussian(sample)
                  , data=datX, dist = 'logistic')
summary(aft.s2)
AICtab(aft.s1, aft.s2,
       logLik=T, sort=T, delta=T, base=T,weights=T)


aft.s3 <- survreg(yLt ~ as.factor(sex)
                  + Opn_CZ + Agr_CZ + Dom_CZ
                  + frailty.gaussian(sample)
                  , data=datX, dist = 'logistic')
summary(aft.s3)
AICtab(aft.s2, aft.s3,
       logLik=T, sort=T, delta=T, base=T,weights=T)


aft.s4 <- survreg(yLt ~ as.factor(sex)
                  + Opn_CZ + Agr_CZ + Dom_CZ
                  + as.factor(origin)
                  + frailty.gaussian(sample)
                  , data=datX, dist = 'logistic')
summary(aft.s4)
AICtab(aft.s3, aft.s4,
       logLik=T, sort=T, delta=T, base=T,weights=T)


aft.s5 <- survreg(yLt ~ as.factor(sex)
                  + Opn_CZ + Agr_CZ + Dom_CZ + Neu_CZ
                  + as.factor(origin)
                  + frailty.gaussian(sample)
                  , data=datX, dist = 'logistic')
summary(aft.s5)
AICtab(aft.s4, aft.s5,
       logLik=T, sort=T, delta=T, base=T,weights=T)
# STOP: s4



### CV adjusted


aft.s1.cv <- survreg(yLt ~ as.factor(sex)
                     + O.cv.r
                  + frailty.gaussian(sample)
                  , data=datX, dist = 'logistic')
summary(aft.s1.cv)
AICtab(aft.s0, aft.s1.cv,
       logLik=T, sort=T, delta=T, base=T,weights=T)
testSurvDist(truncdistributions, (yLt ~ as.factor(datX$sex)
                                  + datX$O.cv.r
                                  + frailty.gaussian(datX$sample)))
# stop here I guess: s0



### stab adjusted

aft.s1.sr <- survreg(yLt ~ as.factor(sex)
                     #+ O.r1.DoB
                     + Agr_CZ
                     + frailty.gaussian(sample)
                     , data=datX, dist = 'logistic')
summary(aft.s1.sr)
AICtab(aft.s0, aft.s1.sr,
       logLik=T, sort=T, delta=T, base=T,weights=T)


aft.s2.sr <- survreg(yLt ~ as.factor(sex)
                     + O.r1.DoB
                     + Agr_CZ
                     + frailty.gaussian(sample)
                     , data=datX, dist = 'logistic')
summary(aft.s2.sr)
AICtab(aft.s1.sr, aft.s2.sr,
       logLik=T, sort=T, delta=T, base=T,weights=T)

# stop here again: s1



###############################
attr(yLt, 'type') <- 'counting'

cox.s0 <- coxme(yLt ~ as.factor(sex)
                + (1 | sample)
                , data=datX)

cox.s1 <- coxme(yLt ~ as.factor(sex) + 
                   as.factor(origin)  
                 + (1 | sample)
                 , data=datX)
summary(cox.s1)

AICtab(cox.s0, cox.s1,
       logLik=T, sort=T, delta=T, base=T,weights=T)
anova(cox.s0, cox.s1) # no go


cox.s2 <- coxme(yLt ~ as.factor(sex) + 
                  Opn_CZ +  as.factor(origin)
                + (1 | sample)
                , data=datX)

AICtab(cox.s1, cox.s2,
       logLik=T, sort=T, delta=T, base=T,weights=T)
anova(cox.s1, cox.s2) # no go

# This doesn't really seem to be working
# the Cox model is very resistant to entry


# Dom_CZ + Ext_CZ + Con_CZ +
#   Agr_CZ + Neu_CZ + Opn_CZ



####### Backwards Selection

# remove the weakest variable according to the stability selection


# CV LASSO'd R's
summary(f.ENr.2.l)

aft.b1.cv <- survreg(yLt ~ as.factor(datX$sex) + as.factor(datX$origin) + #as.factor(LvZ) + 
                       datX$D.cv.r + datX$C.cv.r + datX$A.cv.r 
                     + datX$N.cv.r + datX$O.cv.r
                     + frailty.gaussian(datX$sample), dist = 'logistic'
)

summary(aft.b1.cv)
AICtab(f.ENr.2.l, aft.b1.cv,
       logLik=T, sort=T, delta=T, base=T,weights=T)
# Stop here


# Stab selected R's
summary(f.stab.2.gauss.l)

aft.b1.sr <- survreg(yLt ~ as.factor(sex) + as.factor(origin) + #as.factor(LvZ) + 
                       D.r2.DoB + C.r.DoB + A.r.DoB 
                     + N.r1.DoB + O.r1.DoB
                     + frailty.gaussian(datX$sample), dist = 'logistic', data=datX
)

summary(aft.b1.sr)
AICtab(f.ENr.2.l, aft.b1.cv,
       logLik=T, sort=T, delta=T, base=T,weights=T)
# Stop again

