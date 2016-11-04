### Frailty ###

### this script includes the most advanced, up-to-date models
  # ... or should


### Current flow

# 1+2. unadjusted models with & without Origin 
#
# 3+4. models adjusted with LASSO'd residuals



library(bbmle)


attr(yLt, 'type') <- 'mcounting'

attr(y.ahaz, 'type') <- 'mcounting'


model.Ltrunc.spec = (yLt ~ as.factor(datX$sex) + #as.factor(datX$origin) + #as.factor(LvZ) + 
                       datX$Dom_CZ + datX$Con_CZ + datX$Agr_CZ + datX$Neu_CZ 
                     #+ datX$O.r1.DoB + datX$E.r2.DoB
                     + datX$Opn_CZ + datX$Ext_CZ
                     + frailty.gaussian(datX$sample)
                     + strata(datX$strt))
testSurvDist(truncdistributions, model.Ltrunc.spec)
 # so it sure looks like log



frail.AFT <- survreg(yLt ~ as.factor(sex) +                       
                       Dom_CZ + Ext_CZ + Con_CZ +
                       Agr_CZ + Neu_CZ + Opn_CZ
                     + frailty.gaussian(sample) # should be gaussian
                     + strata(strt)
                     , data=datX, dist='logistic') # this model is NOT informed by LASSO

# this is the model to end all models
frail.AFT.wild <- survreg(yLt ~ as.factor(sex) + 
                       as.factor(origin) +  
                       Dom_CZ + Ext_CZ + Con_CZ +
                       Agr_CZ + Neu_CZ + Opn_CZ
                     + frailty.gaussian(sample)
                     + strata(strt)
                     , data=datX, dist='logistic') # this model is NOT informed by LASSO
summary(frail.AFT)
confint(frail.AFT.wild)


# Scale:
#   strt=1 strt=2 strt=3 strt=4 strt=5 
# 4.30   5.36   3.67   2.46   8.32 


HazRat = exp(frail.AFT.wild$coefficients * -1 * 1/8.32)
HazRat

r.sq.M(frail.AFT.wild, datX)

frail.AFT.unstrat <- survreg(yLt ~ as.factor(sex) + 
                            as.factor(origin) +  
                            Dom_CZ + Ext_CZ + Con_CZ +
                            Agr_CZ + Neu_CZ + Opn_CZ
                          + frailty.gaussian(sample)
                          , data=datX, dist='logistic') # this model is NOT informed by LASSO


# O and E residulized

frail.A.EOr2 <- survreg(y.ahaz ~ as.factor(sex) + # this model is informed by LASSO
                       as.factor(origin) +  
                       Dom_CZ + E.r2.DoB + Con_CZ + 
                       Agr_CZ + Neu_CZ + O.r2.DoB
                       + frailty(sample)
                     , data=datX, dist='logistic')  # 'logistic' , 'extreme' , 't'

# FT... also means FALSE/TRUE, as in the input given to the Surv object
frail.AFT.EAD <- survreg(yLt ~ as.factor(sex) + # this model is informed by LASSO(s)
                            as.factor(origin) +  
                            Dom_CZ + E.r2.DoB + Agr_CZ
                          + frailty(sample)
                          , data=datX, dist='logistic') 

frail.AFT.ECAN <- survreg(yLt ~ as.factor(sex) + # this model is informed by LASSO(s)
                           as.factor(origin) +  
                           E.r2.DoB + Agr_CZ + Neu_CZ + Con_CZ
                         + frailty(sample)
                         , data=datX, dist='extreme') 


frail.AFT.EOr2 <- survreg(yLt ~ as.factor(sex) + # this model is informed by LASSO
                            Dom_CZ + E.r2.DoB + Con_CZ + 
                            Agr_CZ + Neu_CZ + O.r2.DoB
                          + frailty.gaussian(sample)
                          , data=datX, dist='logistic')  # 'logistic' , 'extreme' , 't'
summary(frail.AFT.EOr2)
frail.AFT.EOr2.wild <- survreg(yLt ~ as.factor(sex) + # this model is informed by LASSO
                            as.factor(origin) +  
                            Dom_CZ + E.r2.DoB + Con_CZ + 
                            Agr_CZ + Neu_CZ + O.r2.DoB
                          + frailty.gaussian(sample)
                          , data=datX, dist='logistic')  # 'logistic' , 'extreme' , 't'
summary(frail.AFT.EOr2.wild)


frail.AFT.Er2Or1.g <- survreg(yLt ~ as.factor(sex) + # this model is informed by LASSO
                            as.factor(origin) +  
                            Dom_CZ + E.r2.DoB + Con_CZ + 
                            Agr_CZ + Neu_CZ + O.r1.DoB
                          + frailty.gamma(sample)
                          , data=datX, dist='logistic')  # 'logistic' , '*extreme' , 't'
frail.AFT.Er2Or1 <- survreg(yLt ~ as.factor(sex) + # this model is informed by LASSO
                              Dom_CZ + E.r2.DoB + Con_CZ + 
                              Agr_CZ + Neu_CZ + O.r1.DoB # is the O effect real?
                            + frailty.gaussian(sample)
                            , data=datX, dist='logistic')  # 'logistic' , '*extreme' , 't'
summary(frail.AFT.Er2Or1)
frail.AFT.Er2Or1.wild <- survreg(yLt ~ as.factor(sex) + # this model is informed by LASSO
                              as.factor(origin) +  
                              Dom_CZ + E.r2.DoB + Con_CZ + 
                              Agr_CZ + Neu_CZ + O.r1.DoB # is the O effect real?
                            + frailty.gaussian(sample)
                            , data=datX, dist='logistic')  # 'logistic' , '*extreme' , 't'
summary(frail.AFT.Er2Or1.wild)

confint(frail.AFT.Er2Or1.g)

# http://rstudio-pubs-static.s3.amazonaws.com/5564_bc9e2d9a458c4660aa82882df90b7a6b.html

interp = exp(frail.AFT.Er2Or1.g$coefficients)
shape = 1/frail.AFT.Er2Or1.g$scale

HazRat = exp(frail.AFT.Er2Or1.g$coefficients * -1 * shape)

r.sq.M <- function(model, data){
  1-exp((2/length(data[,1]))*(model$loglik[1] - model$loglik[2]))
}

r.square <- r.sq.M(frail.AFT.Er2Or1, datX)
1-exp((2/length(datX[,1]))*(frail.AFT.Er2Or1.g$loglik[1] - frail.AFT.Er2Or1.g$loglik[2]))
r.square

shape = 1/frail.AFT$scale
HazRat = exp(frail.AFT$coefficients * -1 * shape)

r.square <- 1-exp((2/length(datX[,1]))*(frail.AFT$loglik[1] - frail.AFT$loglik[2]))
r.square


### whhaa?

fit.km = survfit(y ~ 1#, data=datX#, type='fleming'
)

quantile(fit.km)
plot(fit.km)


ggsurv(fit.km) + theme_bw()


f.EOr.km = npsurv(yLt ~ as.factor(sex), data=datX)

#plot.flexsurvreg(frail.AFT.Er2Or1)
                    
                     as.factor(origin) +  
                     Dom_CZ + E.r2.DoB + Con_CZ + 
                     Agr_CZ + Neu_CZ + O.r1.DoB, data=datX)



plot(f.EOr.km)

library(Design)
## Plot KM curves
survplot(mod.EOr)
         conf = c("none","bands","bars")[1],
         xlab = "", ylab = "Survival",
         label.curves = TRUE,                     # label curves directly
         time.inc = 100,                          # time increment
         n.risk   = TRUE,                         # show number at risk
)






### No left truncation, but intervalized stuff instead

f.10.DoB <-  survreg(y ~ as.factor(sex) + 
                         as.factor(origin) + DoB +
                         Dom_CZ + Ext_CZ + Con_CZ +
                         Agr_CZ + Neu_CZ + Opn_CZ
                       + frailty(sample), data=Dataset,
                       dist = 'weibull')
                         
                         

f.10.age_pr <-  survreg(y ~ as.factor(sex) + 
                       as.factor(origin) + age_pr +
                     Dom_CZ + Ext_CZ + Con_CZ +
                       Agr_CZ + Neu_CZ + Opn_CZ
                     + frailty(sample), data=Dataset,
                     dist = 'weibull')

f.10.age <-  survreg(y ~ as.factor(sex) + 
                                as.factor(origin) + age +
                              Dom_CZ + Ext_CZ + Con_CZ +
                                Agr_CZ + Neu_CZ + Opn_CZ
                              + frailty(sample), data=Dataset,
                              dist = 'weibull')



### Residualized from optimally tuned Elastic Net models

model.Ltrunc.ENr = (yLt ~ as.factor(datX$sex) + #as.factor(datX$origin) + #as.factor(LvZ) + 
                       datX$D.cv.r + datX$C.cv.r + datX$A.cv.r 
                    + datX$N.cv.r + datX$O.cv.r + datX$E.cv.r
                     + frailty.gaussian(datX$sample))
testSurvDist(truncdistributions, model.Ltrunc.ENr)


f.ENr.1.l <- survreg(yLt ~ as.factor(datX$sex) + #as.factor(datX$origin) + #as.factor(LvZ) + 
                     datX$D.cv.r + datX$C.cv.r + datX$A.cv.r 
                   + datX$N.cv.r + datX$O.cv.r + datX$E.cv.r
                   + frailty.gaussian(datX$sample), dist = 'logistic'
                   )

f.ENr.1.e <- survreg(yLt ~ as.factor(datX$sex) + #as.factor(datX$origin) + #as.factor(LvZ) + 
                     datX$D.cv.r + datX$C.cv.r + datX$A.cv.r 
                   + datX$N.cv.r + datX$O.cv.r + datX$E.cv.r
                   + frailty.gaussian(datX$sample), dist = 'extreme'
)

f.ENr.2.l <- survreg(yLt ~ as.factor(datX$sex) + as.factor(datX$origin) + #as.factor(LvZ) + 
                       datX$D.cv.r + datX$C.cv.r + datX$A.cv.r 
                     + datX$N.cv.r + datX$O.cv.r + datX$E.cv.r
                     + frailty.gaussian(datX$sample), dist = 'logistic'
)

f.ENr.2.e <- survreg(yLt ~ as.factor(datX$sex) + as.factor(datX$origin) + #as.factor(LvZ) + 
                       datX$D.cv.r + datX$C.cv.r + datX$A.cv.r 
                     + datX$N.cv.r + datX$O.cv.r + datX$E.cv.r
                     + frailty.gaussian(datX$sample), dist = 'extreme'
)
AICtab(f.ENr.1.e, f.ENr.1.l, f.ENr.2.e, f.ENr.2.l,
  f.stab.1.gamma.e,f.stab.1.gauss.e,f.stab.1.gamma.l,f.stab.1.gauss.l,
  f.stab.2.gamma.e,f.stab.2.gauss.e,f.stab.2.gamma.l,f.stab.2.gauss.l,
  frail.AFT, frail.AFT.wild, frail.AFT.unstrat,
       logLik=T, sort=T, delta=T, base=T,weights=T)

r.sq.M(f.ENr.1.l, datX)
# [1] 0.1654328 # l.min
# 0.19
r.sq.M(f.ENr.2.l, datX)
# [1] 0.2151364 # l.min
# 0.228

summary(f.ENr.2.l) # seems like this is the best model out of all (?)

AICtab(f.ENr.2.l, f.ENr.1.l, mod.ENr.2, f.stab.1.gauss.l, f.stab.2.gauss.l,
       logLik=T, sort=T, delta=T, base=T,weights=T)



### Residualized from lm's, chosen by stability selection

r.sq.M(f.stab.2.gauss.l, datX)


model.Ltrunc.stab = (yLt ~ as.factor(datX$sex) + #as.factor(datX$origin) + #as.factor(LvZ) + 
                      datX$D.r2.DoB + datX$C.r.DoB + datX$A.r.DoB 
                    + datX$N.r1.DoB + datX$O.r1.DoB + datX$E.r2.DoB
                    + frailty.gaussian(datX$sample))
testSurvDist(truncdistributions, model.Ltrunc.stab)

f.stab.1.gauss.l <- survreg(yLt ~ as.factor(sex) + #as.factor(origin) + #as.factor(LvZ) + 
                      D.r2.DoB + C.r.DoB + A.r.DoB 
                    + N.r1.DoB + O.r1.DoB + E.r2.DoB
                    + frailty.gaussian(sample), data=datX,
                    dist='logistic')

f.stab.1.gamma.l <- survreg(yLt ~ as.factor(sex) + #as.factor(origin) + #as.factor(LvZ) + 
                      D.r2.DoB + C.r.DoB + A.r.DoB 
                    + N.r1.DoB + O.r1.DoB + E.r2.DoB
                    + frailty.gamma(sample), data=datX,
                    dist='logistic')


f.stab.1.gauss.e <- survreg(yLt ~ as.factor(sex) + #as.factor(origin) + #as.factor(LvZ) + 
                      D.r2.DoB + C.r.DoB + A.r.DoB 
                    + N.r1.DoB + O.r1.DoB + E.r2.DoB
                    + frailty.gaussian(sample), data=datX,
                    dist='extreme')

f.stab.1.gamma.e <- survreg(yLt ~ as.factor(sex) + #as.factor(origin) + #as.factor(LvZ) + 
                      D.r2.DoB + C.r.DoB + A.r.DoB 
                    + N.r1.DoB + O.r1.DoB + E.r2.DoB
                    + frailty.gamma(sample), data=datX,
                    dist='extreme')

AICtab(f.stab.1.gamma.e,f.stab.1.gauss.e,f.stab.1.gamma.l,f.stab.1.gauss.l,
       logLik=T, sort=T, delta=T, base=T,weights=T)


f.stab.2.gauss.l <- survreg(yLt ~ as.factor(sex) + as.factor(origin) + #as.factor(LvZ) + 
                              D.r2.DoB + C.r.DoB + A.r.DoB 
                            + N.r1.DoB + O.r1.DoB + E.r2.DoB
                            + frailty.gaussian(sample), data=datX,
                            dist='logistic')

f.stab.2.gamma.l <- survreg(yLt ~ as.factor(sex) + as.factor(origin) + #as.factor(LvZ) + 
                              D.r2.DoB + C.r.DoB + A.r.DoB 
                            + N.r1.DoB + O.r1.DoB + E.r2.DoB
                            + frailty.gamma(sample), data=datX,
                            dist='logistic')


f.stab.2.gauss.e <- survreg(yLt ~ as.factor(sex) + as.factor(origin) + #as.factor(LvZ) + 
                              D.r2.DoB + C.r.DoB + A.r.DoB 
                            + N.r1.DoB + O.r1.DoB + E.r2.DoB
                            + frailty.gaussian(sample), data=datX,
                            dist='extreme')

f.stab.2.gamma.e <- survreg(yLt ~ as.factor(sex) + as.factor(origin) + #as.factor(LvZ) + 
                              D.r2.DoB + C.r.DoB + A.r.DoB 
                            + N.r1.DoB + O.r1.DoB + E.r2.DoB
                            + frailty.gamma(sample), data=datX,
                            dist='extreme')

AICtab(f.stab.2.gamma.e,f.stab.2.gauss.e,f.stab.2.gamma.l,f.stab.2.gauss.l,
       logLik=T, sort=T, delta=T, base=T,weights=T)
summary(f.stab.2.gauss.l)
summary(f.stab.1.gauss.l)
confint(f.stab.2.gauss.l)

r.sq.M(f.stab.2.gauss.l, data = datX)
r.sq.M(f.stab.1.gauss.l, data = datX)


# Cox is basically useless for all this
frail.cox.EOr2 <- coxph(yLt ~ as.factor(sex) + 
                          as.factor(origin) +  
                          Dom_CZ + E.r2.DoB + Con_CZ + #E.resid3 +
                          Agr_CZ + Neu_CZ + O.r2.DoB
                        + frailty(sample)
                        , data=datX) # this model is informed by LASSO

require(coxme)

attr(yLt, 'type') <- 'counting'
#attr(yLt, 'type') <- 'mcounting'

coxme.1 <- coxme(yLt ~ as.factor(sex) + 
                       as.factor(origin) +  
                       Dom_CZ + Ext_CZ + Con_CZ +
                       Agr_CZ + Neu_CZ + Opn_CZ
                     + (1 | sample)
                     , data=datX)

coxme.2 <- coxme(yLt ~ as.factor(sex) + 
                   as.factor(origin) +  
                   Dom_CZ + E.r2.DoB + Con_CZ + 
                   Agr_CZ + Neu_CZ + O.r2.DoB
                 + (1 | sample)
                 , data=datX)

coxme.2.1 <- coxme(yLt ~ as.factor(sex) + 
                   as.factor(origin) +  
                   Dom_CZ + E.r2.DoB + Con_CZ + 
                   Agr_CZ + Neu_CZ + O.r1.DoB
                 + (1 | sample)
                 , data=datX)

coxme.3 <- coxme(yLt ~ as.factor(sex) + 
                   as.factor(origin) +  
                   Dom_CZ + E.r2.DoB + Agr_CZ + 
                 + (1 | sample)
                 , data=datX)



coxme.4 <- coxme(y.ahaz ~ as.factor(sex) + 
                   as.factor(origin) +  
                   Dom_CZ + E.r2.DoB + Con_CZ + 
                   Agr_CZ + Neu_CZ + O.r2.DoB
                   + (1 | sample)
                 , data=datX)



coxme.5 = coxme(yLt ~ as.factor(sex) + as.factor(origin) + #as.factor(LvZ) + 
                               D.cv.r + C.cv.r + A.cv.r 
                             + N.cv.r + O.cv.r + E.cv.r
                             + (1 | sample), data=datX)


coxme.6 = coxme(yLt ~ as.factor(sex) + 
                  as.factor(origin) +  
                  Dom_CZ + Ext_CZ + Con_CZ +
                  Agr_CZ + Neu_CZ + Opn_CZ
                + (1 | sample) + strata(strt)
                , data=datX)


AICtab(coxme.1, coxme.6, coxme.5,
       logLik=T, sort=T, delta=T, base=T,weights=T)
