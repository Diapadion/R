### Parametric frailty models





library(survival)
library(parfm)
library(frailtypack)
library(bbmle)
# strata won't really work with these

fpack.u = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + #strata(strt)
                         as.factor(sex) + as.factor(origin) +  
                         Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ,
                       data = datX, hazard =  'Piecewise-equi' , nb.int = 1
                       #, n.knots = 4, kappa =1
)
fpack.u.15 = update(fpack.u, nb.int=15)
fpack.u.10 = update(fpack.u, nb.int=10)
fpack.u.9 = update(fpack.u, nb.int=9)
fpack.u.8 = update(fpack.u, nb.int=8)
fpack.u.7 = update(fpack.u, nb.int=7)
fpack.u.6 = update(fpack.u, nb.int=6)
fpack.u.5 = update(fpack.u, nb.int=5)
fpack.u.4 = update(fpack.u, nb.int=4)
fpack.u.3 = update(fpack.u, nb.int=3)
fpack.u.2 = update(fpack.u, nb.int=2)

fpfLL=NULL

fpfLL[20] = update(fpack.u, nb.int=20)$logLik
fpfLL[19] = update(fpack.u, nb.int=19)$logLik
fpfLL[18] = update(fpack.u, nb.int=18)$logLik
fpfLL[17] = update(fpack.u, nb.int=17)$logLik
fpfLL[16] = update(fpack.u, nb.int=16)$logLik
fpfLL[15] = fpack.u.15$logLik
fpfLL[14] = update(fpack.u, nb.int=14)$logLik
fpfLL[13] = update(fpack.u, nb.int=13)$logLik
fpfLL[12] = update(fpack.u, nb.int=12)$logLik
fpfLL[11] = update(fpack.u, nb.int=11)$logLik
fpfLL[10] = fpack.u.10$logLik
fpfLL[9] = fpack.u.9$logLik
fpfLL[8] = fpack.u.8$logLik
fpfLL[7] = fpack.u.7$logLik
fpfLL[6] = fpack.u.6$logLik
fpfLL[5] = fpack.u.5$logLik
fpfLL[4] = fpack.u.4$logLik
fpfLL[3] = fpack.u.3$logLik
fpfLL[2] = fpack.u.2$logLik
fpfLL[1] = fpack.u$logLik


pchisq(2*(fpack.u.9$logLik-fpack.u$logLik), df=9-1, lower.tail = F)
summary(fpack.u.9)

#fpack.u.10$AIC


fpack.r = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + #strata(strt)
                         as.factor(sex) + as.factor(origin) +  
                         D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB,
                       data = datX, hazard =  'Piecewise-equi' , nb.int = 1
                       #, n.knots = 4, kappa =1
)

fpfLLr = NULL
fpfLLr[20] = update(fpack.r, nb.int=20)$logLik
fpfLLr[19] = update(fpack.r, nb.int=19)$logLik
fpfLLr[18] = update(fpack.r, nb.int=18)$logLik
fpfLLr[17] = update(fpack.r, nb.int=17)$logLik
fpfLLr[16] = update(fpack.r, nb.int=16)$logLik
fpfLLr[15] = update(fpack.r, nb.int=15)$logLik
fpfLLr[14] = update(fpack.r, nb.int=14)$logLik
fpfLLr[13] = update(fpack.r, nb.int=13)$logLik
fpfLLr[12] = update(fpack.r, nb.int=12)$logLik
fpfLLr[11] = update(fpack.r, nb.int=11)$logLik
fpfLLr[10] = update(fpack.r, nb.int=10)$logLik
fpfLLr[9] = update(fpack.r, nb.int=9)$logLik
fpfLLr[8] = update(fpack.r, nb.int=8)$logLik
fpfLLr[7] = update(fpack.r, nb.int=7)$logLik
fpfLLr[6] = update(fpack.r, nb.int=6)$logLik
fpfLLr[5] = update(fpack.r, nb.int=5)$logLik
fpfLLr[4] = update(fpack.r, nb.int=4)$logLik
fpfLLr[3] = update(fpack.r, nb.int=3)$logLik
fpfLLr[2] = update(fpack.r, nb.int=2)$logLik
fpfLLr[1] = fpack.r$logLik

plot(fpfLLr)

fpack.r.9 = update(fpack.r, nb.int=9)

summary(fpack.r.9)
plot(fpack)

# AICtab(fpack.u, fpack.r,
#        logLik=T, sort=T, delta=T, base=T,weights=T)

fpack.u$AIC
fpack.u.10$AIC
fpack.r$AIC



# Specifications of interest

fpack.u.0f = frailtyPenal(Surv(age_pr, age, status) ~ #cluster(sample) + 
                         as.factor(sex) + as.factor(origin) +  
                         Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ,
                       data = datX, hazard =  'Piecewise-equi' , nb.int = 9
                       #, n.knots = 4, kappa =1
)

fpack.r.0f = frailtyPenal(Surv(age_pr, age, status) ~ #cluster(sample) + 
                            as.factor(sex) + as.factor(origin) +  
                            D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB,
                          data = datX, hazard =  'Piecewise-equi' , nb.int = 9
                          #, n.knots = 4, kappa =1
)

fpack.u.x = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                            as.factor(sex) + #as.factor(origin) +  
                            Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ,
                          data = datX, hazard =  'Piecewise-equi' , nb.int = 9
                          #, n.knots = 4, kappa =1
)

fpack.r.x = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                            as.factor(sex) + #as.factor(origin) +  
                            D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB,
                          data = datX, hazard =  'Piecewise-equi' , nb.int = 9
                          #, n.knots = 4, kappa =1
)

fpack.u.x.sx = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                           #as.factor(sex) + #as.factor(origin) +  
                           Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ,
                         data = datX, hazard =  'Piecewise-equi' , nb.int = 9
                         #, n.knots = 4, kappa =1
)

fpack.r.x.sx = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                           #as.factor(sex) + #as.factor(origin) +  
                           D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB,
                         data = datX, hazard =  'Piecewise-equi' , nb.int = 9
                         #, n.knots = 4, kappa =1
)


fpack.r.x.sx.D = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                              #as.factor(sex) + #as.factor(origin) +  
                              D.r2.DoB,
                            data = datX, hazard =  'Piecewise-equi' , nb.int = 9
                            #, n.knots = 4, kappa =1
)
fpack.r.x.sx.E = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                                #as.factor(sex) + #as.factor(origin) +  
                                E.r2.DoB,
                              data = datX, hazard =  'Piecewise-equi' , nb.int = 9
                              #, n.knots = 4, kappa =1
)



### these won't converge

fpack.u.i.M = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                             as.factor(sex) + as.factor(origin) +  
                             Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ,
                           data = datX[datX$sex=='Female',], hazard =  'Piecewise-equi' , nb.int = 9
                           #, n.knots = 4, kappa =1
                           , maxit = 3000
)

fpack.r.i.M = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                             as.factor(sex) + as.factor(origin) +  
                             D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB,
                           data = datX[datX$sex=='Female',], hazard =  'Piecewise-equi' , nb.int = 9
                           #, n.knots = 4, kappa =1
                           , maxit = 2000
)

### nor does this

fpack.u.i.w = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                                         as.factor(sex) + as.factor(origin) +  
                                         Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ,
                                       data = datX, hazard =  'Weibull' 
                                       , n.knots = 2, kappa =1
)
                           








pfm.u.i.g.6 = parfm(Surv(age_pr, age, status) ~ 
                      as.factor(sex) + as.factor(origin) +  
                      Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ,
                    cluster="sample" #strata = "strt"
                    , frailty = 'gamma'
                    , data=datX, dist='gompertz', method ='nlminb')
pfm.r.i.g.6 = parfm(Surv(age_pr, age, status) ~ 
                      as.factor(sex) + as.factor(origin) +  
                      D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB,
                    cluster="sample" #strata = "strt"
                    , frailty = 'gamma'
                    , data=datX, dist='gompertz', method ='nlminb')
print(pfm.u.i.g.6)
print(pfm.r.i.g.6)
# pfm.s.i.g.6 = parfm(Surv(age_pr, age, status) ~ 
#                       as.factor(sex) + as.factor(origin) +  
#                       Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ,
#                     cluster="sample" ,strata = "strt"
#                     , frailty = 'gamma'
#                     , data=datX, dist='gompertz', method ='nlminb')


pfm.u.x.g.6 = parfm(Surv(age_pr, age, status) ~ 
                      as.factor(sex) +# as.factor(origin) +  
                      Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ,
                    cluster="sample" #strata = "strt"
                    , frailty = 'gamma'
                    , data=datX, dist='gompertz', method ='nlminb')

pfm.r.x.g.6 = parfm(Surv(age_pr, age, status) ~ 
                      as.factor(sex) +# as.factor(origin) +  
                      D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB,
                    cluster="sample" #strata = "strt"
                    , frailty = 'gamma'
                    , data=datX, dist='gompertz', method ='ucminf')

print(pfm.u.x.g.6)

pfm.u.i.g.D = parfm(Surv(age_pr, age, status) ~ 
                      as.factor(sex) + as.factor(origin) +  
                      Dom_CZ,
                    cluster="sample" #strata = "strt"
                    , frailty = 'gamma'
                    , data=datX, dist='gompertz', method ='ucminf')
pfm.u.i.g.E = parfm(Surv(age_pr, age, status) ~ 
                      as.factor(sex) + as.factor(origin) +  
                      Ext_CZ,
                    cluster="sample" #strata = "strt"
                    , frailty = 'gamma'
                    , data=datX, dist='gompertz', method ='ucminf')
pfm.u.i.g.C = parfm(Surv(age_pr, age, status) ~ 
                      as.factor(sex) + as.factor(origin) +  
                      Con_CZ,
                    cluster="sample" #strata = "strt"
                    , frailty = 'gamma'
                    , data=datX, dist='gompertz', method ='ucminf')
pfm.u.i.g.A = parfm(Surv(age_pr, age, status) ~ 
                      as.factor(sex) + as.factor(origin) +  
                      Agr_CZ,
                    cluster="sample" #strata = "strt"
                    , frailty = 'gamma'
                    , data=datX, dist='gompertz', method ='ucminf')
pfm.u.i.g.N = parfm(Surv(age_pr, age, status) ~ 
                      as.factor(sex) + as.factor(origin) +  
                      Neu_CZ,
                    cluster="sample" #strata = "strt"
                    , frailty = 'gamma'
                    , data=datX, dist='gompertz', method ='ucminf')
pfm.u.i.g.O = parfm(Surv(age_pr, age, status) ~ 
                      as.factor(sex) + as.factor(origin) +  
                      Opn_CZ,
                    cluster="sample" #strata = "strt"
                    , frailty = 'gamma'
                    , data=datX, dist='gompertz', method ='ucminf')

print(pfm.u.i.g.6)
print(pfm.r.i.g.6)







# is this the same as AFT?

library(eha)

aft.parfm.eq1 = parfm(Surv(age_pr, age, status) ~ 
                        as.factor(sex) + as.factor(origin) +  
                        Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ,
                      #cluster="sample" #strata = "strt"
                      , frailty = 'none'
                      , data=datX, dist='gompertz', method ='nlminb')

aft.parfm.eq2 = aftreg(Surv(age_pr, age, status) ~ 
                     as.factor(sex) + as.factor(origin) +  
                     Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ,
                   data = datX, param = 'lifeAcc',
                   dist = 'gompertz')

print(aft.parfm.eq1)
summary(aft.parfm.eq2)
