### Models to weight and aggregate

library(frailtypack)
library(parfm)

library(AICcmodavg)



### How can the specification vary?


# x2
# In/exclude Origin

# x2
# In/exclude sex

# x2
# Leave confounded
# Residulaize data by DoB

# x3 [ ??]
# Method used
# pwe - piecewise equidistant
# pwp - piecewise percent
# wb - weibull
# 
# x2 
# including Age * Agr interaction



parfm.tst.all = parfm(Surv(age_pr, age, status) ~ 
                        as.factor(sex) + as.factor(origin) +  
                        Agr_CZ + D.r2.DoB + E.r2.DoB + Con_CZ + N.r1.DoB + O.r2.DoB,
                      cluster="sample" #strata = "strt"
                      , frailty = 'gamma'
                      , data=datX, dist='logskewnormal', method ='ucminf')
print(parfm.tst.all)




# pf.u.x.x.pw(e/p)
# pf.r.o.s.wb


### Piecewise
pf.u.o.s.pwe = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                         as.factor(origin) + as.factor(sex) +
                          Agr_CZ + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ,
                       data = datX, hazard =  'Piecewise-equi' , nb.int = 3
)
pf.u.x.x.pwe = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                                Agr_CZ + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ,
                             data = datX, hazard =  'Piecewise-equi' , nb.int = 3
)
pf.u.x.s.pwe = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               as.factor(sex) +  
                                Agr_CZ + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ,
                             data = datX, hazard =  'Piecewise-equi' , nb.int = 3
)
pf.u.o.x.pwe = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               as.factor(origin) +  
                                Agr_CZ + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ,
                             data = datX, hazard =  'Piecewise-equi' , nb.int = 3
)
pf.r.o.s.pwe = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               as.factor(origin) + as.factor(sex) + 
                               Agr_CZ + D.r2.DoB + E.r2.DoB + Con_CZ + N.r1.DoB + O.r2.DoB,
                             data = datX, hazard =  'Piecewise-equi' , nb.int = 3
)
pf.r.x.x.pwe = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               Agr_CZ + D.r2.DoB + E.r2.DoB + Con_CZ + N.r1.DoB + O.r2.DoB,
                             data = datX, hazard =  'Piecewise-equi' , nb.int = 3
)
pf.r.x.s.pwe = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               as.factor(sex) +  
                               Agr_CZ + D.r2.DoB + E.r2.DoB + Con_CZ + N.r1.DoB + O.r2.DoB,
                             data = datX, hazard =  'Piecewise-equi' , nb.int = 3
)
pf.r.o.x.pwe = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               as.factor(origin) +  
                               Agr_CZ + D.r2.DoB + E.r2.DoB + Con_CZ + N.r1.DoB + O.r2.DoB,
                             data = datX, hazard =  'Piecewise-equi' , nb.int = 3
)

pf.u.o.s.pwp = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                              as.factor(origin) + as.factor(sex) +   
                                Agr_CZ + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ,
                             data = datX, hazard =  'Piecewise-per' , nb.int = 3
)
pf.u.x.x.pwp = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                                Agr_CZ + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ,
                             data = datX, hazard =  'Piecewise-per' , nb.int = 3
)
pf.u.x.s.pwp = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               as.factor(sex) +  
                                Agr_CZ + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ,
                             data = datX, hazard =  'Piecewise-per' , nb.int = 3
)
pf.u.o.x.pwp = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               as.factor(origin) +  
                                Agr_CZ + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ,
                             data = datX, hazard =  'Piecewise-per' , nb.int = 3
)
pf.r.o.s.pwp = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                              as.factor(origin) + as.factor(sex) +   
                               Agr_CZ + D.r2.DoB + E.r2.DoB + Con_CZ + N.r1.DoB + O.r2.DoB,
                             data = datX, hazard =  'Piecewise-per' , nb.int = 3
)
pf.r.x.x.pwp = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               Agr_CZ + D.r2.DoB + E.r2.DoB + Con_CZ + N.r1.DoB + O.r2.DoB,
                             data = datX, hazard =  'Piecewise-per' , nb.int = 3
)
pf.r.x.s.pwp = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               as.factor(sex) +  
                               Agr_CZ + D.r2.DoB + E.r2.DoB + Con_CZ + N.r1.DoB + O.r2.DoB,
                             data = datX, hazard =  'Piecewise-per' , nb.int = 3
)
pf.r.o.x.pwp = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               as.factor(origin) +  
                               Agr_CZ + D.r2.DoB + E.r2.DoB + Con_CZ + N.r1.DoB + O.r2.DoB,
                             data = datX, hazard =  'Piecewise-per' , nb.int = 3
)
# Interaction
pf.u.o.s.pwe.int = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                              as.factor(origin) + as.factor(sex) * Agr_CZ 
                            + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ,
                            data = datX, hazard =  'Piecewise-equi' , nb.int = 3
)
pf.u.x.s.pwe.int = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                              as.factor(sex) * Agr_CZ 
                            + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ,
                            data = datX, hazard =  'Piecewise-equi' , nb.int = 3
)
pf.r.o.s.pwe.int = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                              as.factor(origin) + as.factor(sex)* Agr_CZ 
                            + D.r2.DoB + E.r2.DoB + Con_CZ + N.r1.DoB + O.r2.DoB,
                            data = datX, hazard =  'Piecewise-equi' , nb.int = 3
)
pf.r.x.s.pwe.int = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                              as.factor(sex)* Agr_CZ 
                            + D.r2.DoB + E.r2.DoB + Con_CZ + N.r1.DoB + O.r2.DoB,
                            data = datX, hazard =  'Piecewise-equi' , nb.int = 3
)

pf.u.o.s.pwp.int = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                                  as.factor(origin) + as.factor(sex) * Agr_CZ 
                                + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ,
                                data = datX, hazard =  'Piecewise-per' , nb.int = 3
)
pf.u.x.s.pwp.int = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                                  as.factor(sex) * Agr_CZ 
                                + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ,
                                data = datX, hazard =  'Piecewise-per' , nb.int = 3
)
pf.r.o.s.pwp.int = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                              as.factor(origin) + as.factor(sex)* Agr_CZ 
                            + D.r2.DoB + E.r2.DoB + Con_CZ + N.r1.DoB + O.r2.DoB,
                            data = datX, hazard =  'Piecewise-per' , nb.int = 3
)
pf.r.x.s.pwp.int = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                              as.factor(sex)* Agr_CZ 
                            + D.r2.DoB + E.r2.DoB + Con_CZ + N.r1.DoB + O.r2.DoB,
                            data = datX, hazard =  'Piecewise-per' , nb.int = 3
)








summary(pf.r.x.s.pwp.int)



### Weibull

pf.u.o.s.wb = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) +
                             as.factor(origin) + as.factor(sex) + 
                                Agr_CZ + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ,
                             RandDist = 'LogN'
                             ,data = datX, hazard =  'Weibull' 
)
pf.u.x.x.wb = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                                Agr_CZ + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ,
                             RandDist = 'Gamma'
                             ,data = datX, hazard =  'Weibull' 
)
pf.u.x.s.wb = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               as.factor(sex) + #as.factor(origin) +  
                                Agr_CZ + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ,
                             RandDist = 'Gamma'
                             ,data = datX, hazard =  'Weibull' 
)
pf.u.o.x.wb = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               as.factor(origin) +  
                                Agr_CZ + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ,
                             RandDist = 'Gamma'
                             ,data = datX, hazard =  'Weibull' 
)


pf.r.x.s.wb = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                             as.factor(sex) +
                             Agr_CZ + D.r2.DoB + E.r2.DoB + Con_CZ + N.r1.DoB + O.r2.DoB,
                             RandDist = 'LogN'
                             ,data = datX, hazard =  'Weibull' 
)
pf.r.o.x.wb = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                             as.factor(origin) +  
                             Agr_CZ + D.r2.DoB + E.r2.DoB + Con_CZ + N.r1.DoB + O.r2.DoB,
                           RandDist = 'LogN'
                           ,data = datX, hazard =  'Weibull' 
)
pf.r.o.s.wb = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) +
                             as.factor(origin) + as.factor(sex) +
                             Agr_CZ + D.r2.DoB + E.r2.DoB + Con_CZ + N.r1.DoB + O.r2.DoB,
                           RandDist = 'Gamma', maxit = 1000, recurrentAG=F
                           ,data = datX, hazard =  'Weibull'
)  ## won't converge
pf.r.x.x.wb = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                             Agr_CZ + D.r2.DoB + E.r2.DoB + Con_CZ + N.r1.DoB + O.r2.DoB,
                           RandDist = 'Gamma'
                           ,data = datX, hazard =  'Weibull' 
)

pf.u.o.s.wb.int = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                                  as.factor(origin) + as.factor(sex) * Agr_CZ 
                                + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ,
                                data = datX, hazard =  'Weibull'
)
pf.u.x.s.wb.int = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                                  as.factor(sex) * Agr_CZ 
                                + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ,
                                data = datX, hazard =  'Weibull'
)
pf.r.o.s.wb.int = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                                  as.factor(origin) + as.factor(sex) * Agr_CZ 
                                + D.r2.DoB + E.r2.DoB + Con_CZ + N.r1.DoB + O.r2.DoB,
                                data = datX, hazard =  'Weibull'
)
pf.r.x.s.wb.int = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                                  as.factor(sex) * Agr_CZ 
                                + D.r2.DoB + E.r2.DoB + Con_CZ + N.r1.DoB + O.r2.DoB,
                                data = datX, hazard =  'Weibull'
)



### Gompertz via parfm

pf.u.o.s.gm = parfm(Surv(age_pr, age, status) ~ 
                      as.factor(origin) + as.factor(sex) + Agr_CZ
                    + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ
                    ,cluster="sample"
                    , frailty = 'gamma'
                    , data=datX, dist='gompertz', method ='ucminf')
pf.u.x.s.gm = parfm(Surv(age_pr, age, status) ~ 
                      as.factor(sex) + Agr_CZ
                    + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ
                    ,cluster="sample"
                    , frailty = 'gamma'
                    , data=datX, dist='gompertz', method ='ucminf')
pf.u.o.x.gm = parfm(Surv(age_pr, age, status) ~ 
                      as.factor(origin) + Agr_CZ
                    + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ
                    ,cluster="sample" 
                    , frailty = 'gamma'
                    , data=datX, dist='gompertz', method ='ucminf')
pf.u.x.x.gm = parfm(Surv(age_pr, age, status) ~ 
                      Agr_CZ
                    + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ
                    ,cluster="sample" 
                    , frailty = 'gamma'
                    , data=datX, dist='gompertz', method ='ucminf')
pf.r.o.s.gm = parfm(Surv(age_pr, age, status) ~ 
                      as.factor(origin) + as.factor(sex) + Agr_CZ
                    + D.r2.DoB + E.r2.DoB + Con_CZ + N.r1.DoB + O.r2.DoB
                    ,cluster="sample" 
                    , frailty = 'gamma'
                    , data=datX, dist='gompertz', method ='ucminf')
pf.r.x.s.gm = parfm(Surv(age_pr, age, status) ~ 
                      as.factor(sex) + Agr_CZ
                    + D.r2.DoB + E.r2.DoB + Con_CZ + N.r1.DoB + O.r2.DoB
                    ,cluster="sample" 
                    , frailty = 'gamma'
                    , data=datX, dist='gompertz', method ='ucminf')
pf.r.o.x.gm = parfm(Surv(age_pr, age, status) ~ 
                      as.factor(origin) + Agr_CZ
                    + D.r2.DoB + E.r2.DoB + Con_CZ + N.r1.DoB + O.r2.DoB
                    ,cluster="sample" 
                    , frailty = 'gamma'
                    , data=datX, dist='gompertz', method ='ucminf')
pf.r.x.x.gm = parfm(Surv(age_pr, age, status) ~ 
                      Agr_CZ
                    + D.r2.DoB + E.r2.DoB + Con_CZ + N.r1.DoB + O.r2.DoB
                    ,cluster="sample" 
                    , frailty = 'gamma'
                    , data=datX, dist='gompertz', method ='ucminf')

pf.u.o.s.gm.int = parfm(Surv(age_pr, age, status) ~ 
                      as.factor(origin) + as.factor(sex) * Agr_CZ
                    + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ
                    ,cluster="sample"
                    , frailty = 'gamma'
                    , data=datX, dist='gompertz', method ='ucminf')
pf.u.x.s.gm.int = parfm(Surv(age_pr, age, status) ~ 
                      as.factor(sex) * Agr_CZ
                    + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ
                    ,cluster="sample"
                    , frailty = 'gamma'
                    , data=datX, dist='gompertz', method ='ucminf')
pf.r.o.s.gm.int = parfm(Surv(age_pr, age, status) ~ 
                      as.factor(origin) + as.factor(sex) * Agr_CZ
                    + D.r2.DoB + E.r2.DoB + Con_CZ + N.r1.DoB + O.r2.DoB
                    ,cluster="sample" 
                    , frailty = 'gamma'
                    , data=datX, dist='gompertz', method ='ucminf')
pf.r.x.s.gm.int = parfm(Surv(age_pr, age, status) ~ 
                      as.factor(sex) * Agr_CZ
                    + D.r2.DoB + E.r2.DoB + Con_CZ + N.r1.DoB + O.r2.DoB
                    ,cluster="sample" 
                    , frailty = 'gamma'
                    , data=datX, dist='gompertz', method ='ucminf')






summary(pf.r.x.s.wb)
pf.r.x.s.wb$AIC
plot(pf.u.x.x.wb, type= 'Survival')





summary(pf.u.o.s.6.wb)
plot(pf.u.o.s.6.wb, type = 'Survival')
pf.u.o.s.6.wb$logLik * -2





# pf.u.o.s.6.gm
# -2 * -789.542
# 
# u <- predict(pf.u.o.s.6.gm)
# plot(u)

plot(pf.u.o.s.6.gm, sort='i')




pf.r.x.s.6.sp$logLikPenal



pf.u.o.s.pwp.3 = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                              as.factor(origin) + as.factor(sex) +
                               Agr_CZ + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ,
                            data = datX, hazard =  'Piecewise-per' , nb.int = 3
)
pf.u.o.s.pwp.3


pf.u.o.s.int = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                                as.factor(origin) + as.factor(sex)*Opn_CZ
                                #+ Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ
                              ,data = datX, hazard =  'Piecewise-equi' , nb.int = 3
)
pf.u.o.s.int
plot(pf.r.o.s.int, type='Hazard')

pf.r.o.s.int = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                              as.factor(origin) + as.factor(sex)*Agr_CZ
                              + D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB
                            ,data = datX, hazard =  'Weibull' #, nb.int = 3
)
pf.r.o.s.int






# rememeber, AIC = 2k - 2LL
# so, if all K = 1; LL = 1 - (AIC)/2

AIC2LL <- function(AIC,k=1){
  LL = k - AIC/2
  return(LL)
}



# LLv = c(AIC2LL(pf.u.o.s.wb$AIC),AIC2LL(pf.u.o.s.pwe$AIC),AIC2LL(pf.u.o.s.pwp$AIC),
#         AIC2LL(pf.u.o.x.wb$AIC),AIC2LL(pf.u.o.x.pwe$AIC),AIC2LL(pf.u.o.x.pwp$AIC),
#         AIC2LL(pf.u.x.s.wb$AIC),AIC2LL(pf.u.x.s.pwe$AIC),AIC2LL(pf.u.x.s.pwp$AIC),
#         AIC2LL(pf.u.x.x.wb$AIC),AIC2LL(pf.u.x.x.pwe$AIC),AIC2LL(pf.u.x.x.pwp$AIC),
#         AIC2LL(pf.r.o.s.wb$AIC),AIC2LL(pf.r.o.s.pwe$AIC),AIC2LL(pf.r.o.s.pwp$AIC),
#         AIC2LL(pf.r.o.x.wb$AIC),AIC2LL(pf.r.o.x.pwe$AIC),AIC2LL(pf.r.o.x.pwp$AIC),
#         AIC2LL(pf.r.x.s.wb$AIC),AIC2LL(pf.r.x.s.pwe$AIC),AIC2LL(pf.r.x.s.pwp$AIC),
#         AIC2LL(pf.r.x.x.wb$AIC),AIC2LL(pf.r.x.x.pwe$AIC),AIC2LL(pf.r.x.x.pwp$AIC))
LLv = c(pf.u.o.s.wb$logLik,pf.u.o.s.pwe$logLik,pf.u.o.s.pwp$logLik,logLik(pf.u.o.s.gm)[1],
        pf.u.o.x.wb$logLik,pf.u.o.x.pwe$logLik,pf.u.o.x.pwp$logLik,logLik(pf.u.o.x.gm)[1],
        pf.u.x.s.wb$logLik,pf.u.x.s.pwe$logLik,pf.u.x.s.pwp$logLik,logLik(pf.u.x.s.gm)[1],
        pf.u.x.x.wb$logLik,pf.u.x.x.pwe$logLik,pf.u.x.x.pwp$logLik,logLik(pf.u.x.x.gm)[1],
        pf.r.o.s.wb$logLik,
        pf.r.o.s.pwe$logLik,pf.r.o.s.pwp$logLik,logLik(pf.r.o.s.gm)[1],
        pf.r.o.x.wb$logLik,pf.r.o.x.pwe$logLik,pf.r.o.x.pwp$logLik,logLik(pf.r.o.x.gm)[1],
        pf.r.x.s.wb$logLik,pf.r.x.s.pwe$logLik,pf.r.x.s.pwp$logLik,logLik(pf.r.x.s.gm)[1],
        pf.r.x.x.wb$logLik,pf.r.x.x.pwe$logLik,pf.r.x.x.pwp$logLik,logLik(pf.r.x.x.gm)[1],
        pf.u.o.s.wb.int$logLik,pf.u.o.s.pwe.int$logLik,pf.u.o.s.pwp.int$logLik,logLik(pf.u.o.s.gm.int)[1],
        pf.u.x.s.wb.int$logLik,pf.u.x.s.pwe.int$logLik,pf.u.x.s.pwp.int$logLik,logLik(pf.u.x.s.gm.int)[1],
        pf.r.o.s.wb.int$logLik,pf.r.o.s.pwe.int$logLik,pf.r.o.s.pwp.int$logLik,logLik(pf.r.o.s.gm.int)[1],
        pf.r.x.s.wb.int$logLik,pf.r.x.s.pwe.int$logLik,pf.r.x.s.pwp.int$logLik,logLik(pf.r.x.s.gm.int)[1]
        )
Kv = c(pf.u.o.s.wb$npar,pf.u.o.s.pwe$npar,pf.u.o.s.pwp$npar,attr(logLik(pf.u.o.s.gm),'df'),
        pf.u.o.x.wb$npar,pf.u.o.x.pwe$npar,pf.u.o.x.pwp$npar,attr(logLik(pf.u.o.x.gm),'df'),
        pf.u.x.s.wb$npar,pf.u.x.s.pwe$npar,pf.u.x.s.pwp$npar,attr(logLik(pf.u.x.s.gm),'df'),
        pf.u.x.x.wb$npar,pf.u.x.x.pwe$npar,pf.u.x.x.pwp$npar,attr(logLik(pf.u.x.x.gm),'df'),
        pf.r.o.s.wb$npar,
       pf.r.o.s.pwe$npar,pf.r.o.s.pwp$npar,attr(logLik(pf.r.o.s.gm),'df'),
        pf.r.o.x.wb$npar,pf.r.o.x.pwe$npar,pf.r.o.x.pwp$npar,attr(logLik(pf.r.o.x.gm),'df'),
        pf.r.x.s.wb$npar,pf.r.x.s.pwe$npar,pf.r.x.s.pwp$npar,attr(logLik(pf.r.x.s.gm),'df'),
        pf.r.x.x.wb$npar,pf.r.x.x.pwe$npar,pf.r.x.x.pwp$npar,attr(logLik(pf.r.x.x.gm),'df'),
       pf.u.o.s.wb.int$npar,pf.u.o.s.pwe.int$npar,pf.u.o.s.pwp.int$npar,attr(logLik(pf.u.o.s.gm.int),'df'),
       pf.u.x.s.wb.int$npar,pf.u.x.s.pwe.int$npar,pf.u.x.s.pwp.int$npar,attr(logLik(pf.u.x.s.gm.int),'df'),
       pf.r.o.s.wb.int$npar,pf.r.o.s.pwe.int$npar,pf.r.o.s.pwp.int$npar,attr(logLik(pf.r.o.s.gm.int),'df'),
       pf.r.x.s.wb.int$npar,pf.r.x.s.pwe.int$npar,pf.r.x.s.pwp.int$npar,attr(logLik(pf.r.x.s.gm.int),'df')
       )
#Kv = rep(1,times=24)
mnv = c('pf.u.o.s.wb','pf.u.o.s.pwe','pf.u.o.s.pwp','pf.u.o.s.gm',
        'pf.u.o.x.wb','pf.u.o.x.pwe','pf.u.o.x.pwp','pf.u.o.x.gm',
        'pf.u.x.s.wb','pf.u.x.s.pwe','pf.u.x.s.pwp','pf.u.x.s.gm',
        'pf.u.x.x.wb','pf.u.x.x.pwe','pf.u.x.x.pwp','pf.u.x.x.gm',
        'pf.r.o.s.wb',
        'pf.r.o.s.pwe','pf.r.o.s.pwp','pf.r.o.s.gm',
        'pf.r.o.x.wb','pf.r.o.x.pwe','pf.r.o.x.pwp','pf.r.o.x.gm',
        'pf.r.x.s.wb','pf.r.x.s.pwe','pf.r.x.s.pwp','pf.r.x.s.gm',
        'pf.r.x.x.wb','pf.r.x.x.pwe','pf.r.x.x.pwp','pf.r.x.x.gm',
        'pf.u.o.s.wb.int','pf.u.o.s.pwe.int','pf.u.o.s.pwp.int','pf.u.o.s.gm.int',
        'pf.u.x.s.wb.int','pf.u.x.s.pwe.int','pf.u.x.s.pwp.int','pf.u.x.s.gm.int',
        'pf.r.o.s.wb.int','pf.r.o.s.pwe.int','pf.r.o.s.pwp.int','pf.r.o.s.gm.int',
        'pf.r.x.s.wb.int','pf.r.x.s.pwe.int','pf.r.x.s.pwp.int','pf.r.x.s.gm.int'
        )

### Agreeableness
estv = c(pf.u.o.s.wb$coef['Agr_CZ'],pf.u.o.s.pwe$coef['Agr_CZ'],pf.u.o.s.pwp$coef['Agr_CZ'],coef(pf.u.o.s.gm)['Agr_CZ'],
         pf.u.o.x.wb$coef['Agr_CZ'],pf.u.o.x.pwe$coef['Agr_CZ'],pf.u.o.x.pwp$coef['Agr_CZ'],coef(pf.u.o.x.gm)['Agr_CZ'],
         pf.u.x.s.wb$coef['Agr_CZ'],pf.u.x.s.pwe$coef['Agr_CZ'],pf.u.x.s.pwp$coef['Agr_CZ'],coef(pf.u.x.s.gm)['Agr_CZ'],
         pf.u.x.x.wb$coef['Agr_CZ'],pf.u.x.x.pwe$coef['Agr_CZ'],pf.u.x.x.pwp$coef['Agr_CZ'],coef(pf.u.x.x.gm)['Agr_CZ'],
         pf.r.o.s.wb$coef['Agr_CZ'],
         pf.r.o.s.pwe$coef['Agr_CZ'],pf.r.o.s.pwp$coef['Agr_CZ'],coef(pf.r.o.s.gm)['Agr_CZ'],
         pf.r.o.x.wb$coef['Agr_CZ'],pf.r.o.x.pwe$coef['Agr_CZ'],pf.r.o.x.pwp$coef['Agr_CZ'],coef(pf.r.o.x.gm)['Agr_CZ'],
         pf.r.x.s.wb$coef['Agr_CZ'],pf.r.x.s.pwe$coef['Agr_CZ'],pf.r.x.s.pwp$coef['Agr_CZ'],coef(pf.r.x.s.gm)['Agr_CZ'],
         pf.r.x.x.wb$coef['Agr_CZ'],pf.r.x.x.pwe$coef['Agr_CZ'],pf.r.x.x.pwp$coef['Agr_CZ'],coef(pf.r.x.x.gm)['Agr_CZ'],
         pf.u.o.s.wb.int$coef['Agr_CZ'],pf.u.o.s.pwe.int$coef['Agr_CZ'],pf.u.o.s.pwp.int$coef['Agr_CZ'],coef(pf.u.o.s.gm.int)['Agr_CZ'],
         pf.u.x.s.wb.int$coef['Agr_CZ'],pf.u.x.s.pwe.int$coef['Agr_CZ'],pf.u.x.s.pwp.int$coef['Agr_CZ'],coef(pf.u.x.s.gm.int)['Agr_CZ'],
         pf.r.o.s.wb.int$coef['Agr_CZ'],pf.r.o.s.pwe.int$coef['Agr_CZ'],pf.r.o.s.pwp.int$coef['Agr_CZ'],coef(pf.r.o.s.gm.int)['Agr_CZ'],
         pf.r.x.s.wb.int$coef['Agr_CZ'],pf.r.x.s.pwe.int$coef['Agr_CZ'],pf.r.x.s.pwp.int$coef['Agr_CZ'],coef(pf.r.x.s.gm.int)['Agr_CZ']
                  )
# seH <- sqrt(diag(x$varH))
# seHIH <- sqrt(diag(x$varHIH))
#sev = c(sqrt(diag(pf.r.o.s.6.sp$varH))[6],sqrt(diag(pf.u.o.s.6.sp$varH))[6],sqrt(diag(fpack.r.9$varH))[6])

ind = 3
sev=c(sqrt(diag(pf.u.o.s.wb$varH))[ind],sqrt(diag(pf.u.o.s.pwe$varH))[ind],sqrt(diag(pf.u.o.s.pwp$varH))[ind],pf.u.o.s.gm[ind+3,'SE'],
      sqrt(diag(pf.u.o.x.wb$varH))[ind-1],sqrt(diag(pf.u.o.x.pwe$varH))[ind-1],sqrt(diag(pf.u.o.x.pwp$varH))[ind-1],pf.u.o.x.gm[ind+2,'SE'],
      sqrt(diag(pf.u.x.s.wb$varH))[ind-1],sqrt(diag(pf.u.x.s.pwe$varH))[ind-1],sqrt(diag(pf.u.x.s.pwp$varH))[ind-1],pf.u.x.s.gm[ind+2,'SE'],
      sqrt(diag(pf.u.x.x.wb$varH))[ind-2],sqrt(diag(pf.u.x.x.pwe$varH))[ind-2],sqrt(diag(pf.u.x.x.pwp$varH))[ind-2],pf.u.x.s.gm[ind+1,'SE'],
      sqrt(diag(pf.r.o.s.wb$varH))[ind],
      sqrt(diag(pf.r.o.s.pwe$varH))[ind],sqrt(diag(pf.r.o.s.pwp$varH))[ind],pf.r.o.s.gm[ind+3,'SE'],
      sqrt(diag(pf.r.o.x.wb$varH))[ind-1],sqrt(diag(pf.r.o.x.pwe$varH))[ind-1],sqrt(diag(pf.r.o.x.pwp$varH))[ind-1],pf.r.o.x.gm[ind+2,'SE'],
      sqrt(diag(pf.r.x.s.wb$varH))[ind-1],sqrt(diag(pf.r.x.s.pwe$varH))[ind-1],sqrt(diag(pf.r.x.s.pwp$varH))[ind-1],pf.r.x.s.gm[ind+2,'SE'],
      sqrt(diag(pf.r.x.x.wb$varH))[ind-2],sqrt(diag(pf.r.x.x.pwe$varH))[ind-2],sqrt(diag(pf.r.x.x.pwp$varH))[ind-2],pf.r.x.x.gm[ind+1,'SE'],
      sqrt(diag(pf.u.o.s.wb.int$varH))[ind],sqrt(diag(pf.u.o.s.pwe.int$varH))[ind],sqrt(diag(pf.u.o.s.pwp.int$varH))[ind],pf.u.o.s.gm.int[ind+3,'SE'],
      sqrt(diag(pf.u.x.s.wb.int$varH))[ind-1],sqrt(diag(pf.u.x.s.pwe.int$varH))[ind-1],sqrt(diag(pf.u.x.s.pwp.int$varH))[ind-1],pf.u.x.s.gm.int[ind+2,'SE'],
      sqrt(diag(pf.r.o.s.wb.int$varH))[ind],sqrt(diag(pf.r.o.s.pwe.int$varH))[ind],sqrt(diag(pf.r.o.s.pwp.int$varH))[ind],pf.r.o.s.gm.int[ind+3,'SE'],
      sqrt(diag(pf.r.x.s.wb.int$varH))[ind-1],sqrt(diag(pf.r.x.s.pwe.int$varH))[ind-1],sqrt(diag(pf.r.x.s.pwp.int$varH))[ind-1],pf.r.x.s.gm.int[ind+2,'SE']
      )
modavgCustom(LLv,Kv,mnv,estv,sev,
             #,nobs=538,
             second.ord=F)


### Openness  
estv = c(pf.u.o.s.wb$coef['Opn_CZ'],pf.u.o.s.pwe$coef['Opn_CZ'],pf.u.o.s.pwp$coef['Opn_CZ'],coef(pf.u.o.s.gm)['Opn_CZ'],
         pf.u.o.x.wb$coef['Opn_CZ'],pf.u.o.x.pwe$coef['Opn_CZ'],pf.u.o.x.pwp$coef['Opn_CZ'],coef(pf.u.o.x.gm)['Opn_CZ'],
         pf.u.x.s.wb$coef['Opn_CZ'],pf.u.x.s.pwe$coef['Opn_CZ'],pf.u.x.s.pwp$coef['Opn_CZ'],coef(pf.u.x.s.gm)['Opn_CZ'],
         pf.u.x.x.wb$coef['Opn_CZ'],pf.u.x.x.pwe$coef['Opn_CZ'],pf.u.x.x.pwp$coef['Opn_CZ'],coef(pf.u.x.x.gm)['Opn_CZ'],
         pf.r.o.s.wb$coef['O.r2.DoB'],
         pf.r.o.s.pwe$coef['O.r2.DoB'],pf.r.o.s.pwp$coef['O.r2.DoB'],coef(pf.r.o.s.gm)['O.r2.DoB'],
         pf.r.o.x.wb$coef['O.r2.DoB'],pf.r.o.x.pwe$coef['O.r2.DoB'],pf.r.o.x.pwp$coef['O.r2.DoB'],coef(pf.r.o.x.gm)['O.r2.DoB'],
         pf.r.x.s.wb$coef['O.r2.DoB'],pf.r.x.s.pwe$coef['O.r2.DoB'],pf.r.x.s.pwp$coef['O.r2.DoB'],coef(pf.r.x.s.gm)['O.r2.DoB'],
         pf.r.x.x.wb$coef['O.r2.DoB'],pf.r.x.x.pwe$coef['O.r2.DoB'],pf.r.x.x.pwp$coef['O.r2.DoB'],coef(pf.r.x.x.gm)['O.r2.DoB'],
         pf.u.o.s.wb.int$coef['Opn_CZ'],pf.u.o.s.pwe.int$coef['Opn_CZ'],pf.u.o.s.pwp.int$coef['Opn_CZ'],coef(pf.u.o.s.gm.int)['Opn_CZ'],
         pf.u.x.s.wb.int$coef['Opn_CZ'],pf.u.x.s.pwe.int$coef['Opn_CZ'],pf.u.x.s.pwp.int$coef['Opn_CZ'],coef(pf.u.x.s.gm.int)['Opn_CZ'],
         pf.r.o.s.wb.int$coef['O.r2.DoB'],pf.r.o.s.pwe.int$coef['O.r2.DoB'],pf.r.o.s.pwp.int$coef['O.r2.DoB'],coef(pf.r.o.s.gm.int)['O.r2.DoB'],
         pf.r.x.s.wb.int$coef['O.r2.DoB'],pf.r.x.s.pwe.int$coef['O.r2.DoB'],pf.r.x.s.pwp.int$coef['O.r2.DoB'],coef(pf.r.x.s.gm.int)['O.r2.DoB']
)
ind = 8
sev=c(sqrt(diag(pf.u.o.s.wb$varH))[ind],sqrt(diag(pf.u.o.s.pwe$varH))[ind],sqrt(diag(pf.u.o.s.pwp$varH))[ind],pf.u.o.s.gm[ind+3,'SE'],
      sqrt(diag(pf.u.o.x.wb$varH))[ind-1],sqrt(diag(pf.u.o.x.pwe$varH))[ind-1],sqrt(diag(pf.u.o.x.pwp$varH))[ind-1],pf.u.o.x.gm[ind+2,'SE'],
      sqrt(diag(pf.u.x.s.wb$varH))[ind-1],sqrt(diag(pf.u.x.s.pwe$varH))[ind-1],sqrt(diag(pf.u.x.s.pwp$varH))[ind-1],pf.u.x.s.gm[ind+2,'SE'],
      sqrt(diag(pf.u.x.x.wb$varH))[ind-2],sqrt(diag(pf.u.x.x.pwe$varH))[ind-2],sqrt(diag(pf.u.x.x.pwp$varH))[ind-2],pf.u.x.s.gm[ind+1,'SE'],
      sqrt(diag(pf.r.o.s.wb$varH))[ind],
      sqrt(diag(pf.r.o.s.pwe$varH))[ind],sqrt(diag(pf.r.o.s.pwp$varH))[ind],pf.r.o.s.gm[ind+3,'SE'],
      sqrt(diag(pf.r.o.x.wb$varH))[ind-1],sqrt(diag(pf.r.o.x.pwe$varH))[ind-1],sqrt(diag(pf.r.o.x.pwp$varH))[ind-1],pf.r.o.x.gm[ind+2,'SE'],
      sqrt(diag(pf.r.x.s.wb$varH))[ind-1],sqrt(diag(pf.r.x.s.pwe$varH))[ind-1],sqrt(diag(pf.r.x.s.pwp$varH))[ind-1],pf.r.x.s.gm[ind+2,'SE'],
      sqrt(diag(pf.r.x.x.wb$varH))[ind-2],sqrt(diag(pf.r.x.x.pwe$varH))[ind-2],sqrt(diag(pf.r.x.x.pwp$varH))[ind-2],pf.r.x.x.gm[ind+1,'SE'],
      sqrt(diag(pf.u.o.s.wb.int$varH))[ind],sqrt(diag(pf.u.o.s.pwe.int$varH))[ind],sqrt(diag(pf.u.o.s.pwp.int$varH))[ind],pf.u.o.s.gm.int[ind+3,'SE'],
      sqrt(diag(pf.u.x.s.wb.int$varH))[ind-1],sqrt(diag(pf.u.x.s.pwe.int$varH))[ind-1],sqrt(diag(pf.u.x.s.pwp.int$varH))[ind-1],pf.u.x.s.gm.int[ind+2,'SE'],
      sqrt(diag(pf.r.o.s.wb.int$varH))[ind],sqrt(diag(pf.r.o.s.pwe.int$varH))[ind],sqrt(diag(pf.r.o.s.pwp.int$varH))[ind],pf.r.o.s.gm.int[ind+3,'SE'],
      sqrt(diag(pf.r.x.s.wb.int$varH))[ind-1],sqrt(diag(pf.r.x.s.pwe.int$varH))[ind-1],sqrt(diag(pf.r.x.s.pwp.int$varH))[ind-1],pf.r.x.s.gm.int[ind+2,'SE']
)
modavgCustom(LLv,Kv,mnv,estv,sev,second.ord=T,nobs=538)


### Extraversion
estv = c(pf.u.o.s.wb$coef['Ext_CZ'],pf.u.o.s.pwe$coef['Ext_CZ'],pf.u.o.s.pwp$coef['Ext_CZ'],coef(pf.u.o.s.gm)['Ext_CZ'],
         pf.u.o.x.wb$coef['Ext_CZ'],pf.u.o.x.pwe$coef['Ext_CZ'],pf.u.o.x.pwp$coef['Ext_CZ'],coef(pf.u.o.x.gm)['Ext_CZ'],
         pf.u.x.s.wb$coef['Ext_CZ'],pf.u.x.s.pwe$coef['Ext_CZ'],pf.u.x.s.pwp$coef['Ext_CZ'],coef(pf.u.x.s.gm)['Ext_CZ'],
         pf.u.x.x.wb$coef['Ext_CZ'],pf.u.x.x.pwe$coef['Ext_CZ'],pf.u.x.x.pwp$coef['Ext_CZ'],coef(pf.u.x.x.gm)['Ext_CZ'],
         #pf.r.o.s.wb$coef['E.r2.DoB'],
         pf.r.o.s.pwe$coef['E.r2.DoB'],pf.r.o.s.pwp$coef['E.r2.DoB'],coef(pf.r.o.s.gm)['E.r2.DoB'],
         pf.r.o.x.wb$coef['E.r2.DoB'],pf.r.o.x.pwe$coef['E.r2.DoB'],pf.r.o.x.pwp$coef['E.r2.DoB'],coef(pf.r.o.x.gm)['E.r2.DoB'],
         pf.r.x.s.wb$coef['E.r2.DoB'],pf.r.x.s.pwe$coef['E.r2.DoB'],pf.r.x.s.pwp$coef['E.r2.DoB'],coef(pf.r.x.s.gm)['E.r2.DoB'],
         pf.r.x.x.wb$coef['E.r2.DoB'],pf.r.x.x.pwe$coef['E.r2.DoB'],pf.r.x.x.pwp$coef['E.r2.DoB'],coef(pf.r.x.x.gm)['E.r2.DoB'],
         pf.u.o.s.wb.int$coef['Ext_CZ'],pf.u.o.s.pwe.int$coef['Ext_CZ'],pf.u.o.s.pwp.int$coef['Ext_CZ'],coef(pf.u.o.s.gm.int)['Ext_CZ'],
         pf.u.x.s.wb.int$coef['Ext_CZ'],pf.u.x.s.pwe.int$coef['Ext_CZ'],pf.u.x.s.pwp.int$coef['Ext_CZ'],coef(pf.u.x.s.gm.int)['Ext_CZ'],
         pf.r.o.s.wb.int$coef['E.r2.DoB'],pf.r.o.s.pwe.int$coef['E.r2.DoB'],pf.r.o.s.pwp.int$coef['E.r2.DoB'],coef(pf.r.o.s.gm.int)['E.r2.DoB'],
         pf.r.x.s.wb.int$coef['E.r2.DoB'],pf.r.x.s.pwe.int$coef['E.r2.DoB'],pf.r.x.s.pwp.int$coef['E.r2.DoB'],coef(pf.r.x.s.gm.int)['E.r2.DoB']
)
ind = 4
sev=c(sqrt(diag(pf.u.o.s.wb$varH))[ind],sqrt(diag(pf.u.o.s.pwe$varH))[ind],sqrt(diag(pf.u.o.s.pwp$varH))[ind],pf.u.o.s.gm[ind+3,'SE'],
      sqrt(diag(pf.u.o.x.wb$varH))[ind-1],sqrt(diag(pf.u.o.x.pwe$varH))[ind-1],sqrt(diag(pf.u.o.x.pwp$varH))[ind-1],pf.u.o.x.gm[ind+2,'SE'],
      sqrt(diag(pf.u.x.s.wb$varH))[ind-1],sqrt(diag(pf.u.x.s.pwe$varH))[ind-1],sqrt(diag(pf.u.x.s.pwp$varH))[ind-1],pf.u.x.s.gm[ind+2,'SE'],
      sqrt(diag(pf.u.x.x.wb$varH))[ind-2],sqrt(diag(pf.u.x.x.pwe$varH))[ind-2],sqrt(diag(pf.u.x.x.pwp$varH))[ind-2],pf.u.x.s.gm[ind+1,'SE'],
      #sqrt(diag(pf.r.o.s.wb$varH))[ind],
      sqrt(diag(pf.r.o.s.pwe$varH))[ind],sqrt(diag(pf.r.o.s.pwp$varH))[ind],pf.r.o.s.gm[ind+3,'SE'],
      sqrt(diag(pf.r.o.x.wb$varH))[ind-1],sqrt(diag(pf.r.o.x.pwe$varH))[ind-1],sqrt(diag(pf.r.o.x.pwp$varH))[ind-1],pf.r.o.x.gm[ind+2,'SE'],
      sqrt(diag(pf.r.x.s.wb$varH))[ind-1],sqrt(diag(pf.r.x.s.pwe$varH))[ind-1],sqrt(diag(pf.r.x.s.pwp$varH))[ind-1],pf.r.x.s.gm[ind+2,'SE'],
      sqrt(diag(pf.r.x.x.wb$varH))[ind-2],sqrt(diag(pf.r.x.x.pwe$varH))[ind-2],sqrt(diag(pf.r.x.x.pwp$varH))[ind-2],pf.r.x.x.gm[ind+1,'SE'],
      sqrt(diag(pf.u.o.s.wb.int$varH))[ind],sqrt(diag(pf.u.o.s.pwe.int$varH))[ind],sqrt(diag(pf.u.o.s.pwp.int$varH))[ind],pf.u.o.s.gm.int[ind+3,'SE'],
      sqrt(diag(pf.u.x.s.wb.int$varH))[ind-1],sqrt(diag(pf.u.x.s.pwe.int$varH))[ind-1],sqrt(diag(pf.u.x.s.pwp.int$varH))[ind-1],pf.u.x.s.gm.int[ind+2,'SE'],
      sqrt(diag(pf.r.o.s.wb.int$varH))[ind],sqrt(diag(pf.r.o.s.pwe.int$varH))[ind],sqrt(diag(pf.r.o.s.pwp.int$varH))[ind],pf.r.o.s.gm.int[ind+3,'SE'],
      sqrt(diag(pf.r.x.s.wb.int$varH))[ind-1],sqrt(diag(pf.r.x.s.pwe.int$varH))[ind-1],sqrt(diag(pf.r.x.s.pwp.int$varH))[ind-1],pf.r.x.s.gm.int[ind+2,'SE']
)
modavgCustom(LLv,Kv,mnv,estv,sev,second.ord=F,nobs=538)


### E - adjusted only
LLv = c(pf.r.o.s.pwe$logLik,pf.r.o.s.pwp$logLik,logLik(pf.r.o.s.gm)[1],
        pf.r.o.x.wb$logLik,pf.r.o.x.pwe$logLik,pf.r.o.x.pwp$logLik,logLik(pf.r.o.x.gm)[1],
        pf.r.x.s.wb$logLik,pf.r.x.s.pwe$logLik,pf.r.x.s.pwp$logLik,logLik(pf.r.x.s.gm)[1],
        pf.r.x.x.wb$logLik,pf.r.x.x.pwe$logLik,pf.r.x.x.pwp$logLik,logLik(pf.r.x.x.gm)[1],
        pf.r.o.s.wb.int$logLik,pf.r.o.s.pwe.int$logLik,pf.r.o.s.pwp.int$logLik,logLik(pf.r.o.s.gm.int)[1],
        pf.r.x.s.wb.int$logLik,pf.r.x.s.pwe.int$logLik,pf.r.x.s.pwp.int$logLik,logLik(pf.r.x.s.gm.int)[1]
)
Kv = c(pf.r.o.s.pwe$npar,pf.r.o.s.pwp$npar,attr(logLik(pf.r.o.s.gm),'df'),
       pf.r.o.x.wb$npar,pf.r.o.x.pwe$npar,pf.r.o.x.pwp$npar,attr(logLik(pf.r.o.x.gm),'df'),
       pf.r.x.s.wb$npar,pf.r.x.s.pwe$npar,pf.r.x.s.pwp$npar,attr(logLik(pf.r.x.s.gm),'df'),
       pf.r.x.x.wb$npar,pf.r.x.x.pwe$npar,pf.r.x.x.pwp$npar,attr(logLik(pf.r.x.x.gm),'df'),
       pf.r.o.s.wb.int$npar,pf.r.o.s.pwe.int$npar,pf.r.o.s.pwp.int$npar,attr(logLik(pf.r.o.s.gm.int),'df'),
       pf.r.x.s.wb.int$npar,pf.r.x.s.pwe.int$npar,pf.r.x.s.pwp.int$npar,attr(logLik(pf.r.x.s.gm.int),'df')
)
mnv = c(
        'pf.r.o.s.pwe','pf.r.o.s.pwp','pf.r.o.s.gm',
        'pf.r.o.x.wb','pf.r.o.x.pwe','pf.r.o.x.pwp','pf.r.o.x.gm',
        'pf.r.x.s.wb','pf.r.x.s.pwe','pf.r.x.s.pwp','pf.r.x.s.gm',
        'pf.r.x.x.wb','pf.r.x.x.pwe','pf.r.x.x.pwp','pf.r.x.x.gm',
        'pf.r.o.s.wb.int','pf.r.o.s.pwe.int','pf.r.o.s.pwp.int','pf.r.o.s.gm.int',
        'pf.r.x.s.wb.int','pf.r.x.s.pwe.int','pf.r.x.s.pwp.int','pf.r.x.s.gm.int'
)

estv = c(pf.r.o.s.pwe$coef['E.r2.DoB'],pf.r.o.s.pwp$coef['E.r2.DoB'],coef(pf.r.o.s.gm)['E.r2.DoB'],
         pf.r.o.x.wb$coef['E.r2.DoB'],pf.r.o.x.pwe$coef['E.r2.DoB'],pf.r.o.x.pwp$coef['E.r2.DoB'],coef(pf.r.o.x.gm)['E.r2.DoB'],
         pf.r.x.s.wb$coef['E.r2.DoB'],pf.r.x.s.pwe$coef['E.r2.DoB'],pf.r.x.s.pwp$coef['E.r2.DoB'],coef(pf.r.x.s.gm)['E.r2.DoB'],
         pf.r.x.x.wb$coef['E.r2.DoB'],pf.r.x.x.pwe$coef['E.r2.DoB'],pf.r.x.x.pwp$coef['E.r2.DoB'],coef(pf.r.x.x.gm)['E.r2.DoB'],
         pf.r.o.s.wb.int$coef['E.r2.DoB'],pf.r.o.s.pwe.int$coef['E.r2.DoB'],pf.r.o.s.pwp.int$coef['E.r2.DoB'],coef(pf.r.o.s.gm.int)['E.r2.DoB'],
         pf.r.x.s.wb.int$coef['E.r2.DoB'],pf.r.x.s.pwe.int$coef['E.r2.DoB'],pf.r.x.s.pwp.int$coef['E.r2.DoB'],coef(pf.r.x.s.gm.int)['E.r2.DoB']
)
ind = 4
sev=c(sqrt(diag(pf.r.o.s.pwe$varH))[ind],sqrt(diag(pf.r.o.s.pwp$varH))[ind],pf.r.o.s.gm[ind+3,'SE'],
      sqrt(diag(pf.r.o.x.wb$varH))[ind-1],sqrt(diag(pf.r.o.x.pwe$varH))[ind-1],sqrt(diag(pf.r.o.x.pwp$varH))[ind-1],pf.r.o.x.gm[ind+2,'SE'],
      sqrt(diag(pf.r.x.s.wb$varH))[ind-1],sqrt(diag(pf.r.x.s.pwe$varH))[ind-1],sqrt(diag(pf.r.x.s.pwp$varH))[ind-1],pf.r.x.s.gm[ind+2,'SE'],
      sqrt(diag(pf.r.x.x.wb$varH))[ind-2],sqrt(diag(pf.r.x.x.pwe$varH))[ind-2],sqrt(diag(pf.r.x.x.pwp$varH))[ind-2],pf.r.x.x.gm[ind+1,'SE'],
      sqrt(diag(pf.r.o.s.wb.int$varH))[ind],sqrt(diag(pf.r.o.s.pwe.int$varH))[ind],sqrt(diag(pf.r.o.s.pwp.int$varH))[ind],pf.r.o.s.gm.int[ind+3,'SE'],
      sqrt(diag(pf.r.x.s.wb.int$varH))[ind-1],sqrt(diag(pf.r.x.s.pwe.int$varH))[ind-1],sqrt(diag(pf.r.x.s.pwp.int$varH))[ind-1],pf.r.x.s.gm.int[ind+2,'SE']
)
modavgCustom(LLv,Kv,mnv,estv,sev,second.ord=F,nobs=538)


### Age * Agr
LLv = c(pf.u.o.s.wb.int$logLik,pf.u.o.s.pwe.int$logLik,pf.u.o.s.pwp.int$logLik,logLik(pf.u.o.s.gm.int)[1],
        pf.u.x.s.wb.int$logLik,pf.u.x.s.pwe.int$logLik,pf.u.x.s.pwp.int$logLik,logLik(pf.u.x.s.gm.int)[1],
        pf.r.o.s.wb.int$logLik,pf.r.o.s.pwe.int$logLik,pf.r.o.s.pwp.int$logLik,logLik(pf.r.o.s.gm.int)[1],
        pf.r.x.s.wb.int$logLik,pf.r.x.s.pwe.int$logLik,pf.r.x.s.pwp.int$logLik,logLik(pf.r.x.s.gm.int)[1]
)
Kv = c(pf.u.o.s.wb.int$npar,pf.u.o.s.pwe.int$npar,pf.u.o.s.pwp.int$npar,attr(logLik(pf.u.o.s.gm.int),'df'),
       pf.u.x.s.wb.int$npar,pf.u.x.s.pwe.int$npar,pf.u.x.s.pwp.int$npar,attr(logLik(pf.u.x.s.gm.int),'df'),
       pf.r.o.s.wb.int$npar,pf.r.o.s.pwe.int$npar,pf.r.o.s.pwp.int$npar,attr(logLik(pf.r.o.s.gm.int),'df'),
       pf.r.x.s.wb.int$npar,pf.r.x.s.pwe.int$npar,pf.r.x.s.pwp.int$npar,attr(logLik(pf.r.x.s.gm.int),'df')
)
mnv = c('pf.u.o.s.wb.int','pf.u.o.s.pwe.int','pf.u.o.s.pwp.int','pf.u.o.s.gm.int',
        'pf.u.x.s.wb.int','pf.u.x.s.pwe.int','pf.u.x.s.pwp.int','pf.u.x.s.gm.int',
        'pf.r.o.s.wb.int','pf.r.o.s.pwe.int','pf.r.o.s.pwp.int','pf.r.o.s.gm.int',
        'pf.r.x.s.wb.int','pf.r.x.s.pwe.int','pf.r.x.s.pwp.int','pf.r.x.s.gm.int'
)
estv = c(   pf.u.o.s.wb.int$coef['sex1:Agr_CZ'],pf.u.o.s.pwe.int$coef['sex1:Agr_CZ'],pf.u.o.s.pwp.int$coef['sex1:Agr_CZ'],coef(pf.u.o.s.gm.int)['as.factor(sex)1:Agr_CZ'],
            pf.u.x.s.wb.int$coef['sex1:Agr_CZ'],pf.u.x.s.pwe.int$coef['sex1:Agr_CZ'],pf.u.x.s.pwp.int$coef['sex1:Agr_CZ'],coef(pf.u.x.s.gm.int)['as.factor(sex)1:Agr_CZ'],
            pf.r.o.s.wb.int$coef['sex1:Agr_CZ'],pf.r.o.s.pwe.int$coef['sex1:Agr_CZ'],pf.r.o.s.pwp.int$coef['sex1:Agr_CZ'],coef(pf.r.o.s.gm.int)['as.factor(sex)1:Agr_CZ'],
            pf.r.x.s.wb.int$coef['sex1:Agr_CZ'],pf.r.x.s.pwe.int$coef['sex1:Agr_CZ'],pf.r.x.s.pwp.int$coef['sex1:Agr_CZ'],coef(pf.r.x.s.gm.int)['as.factor(sex)1:Agr_CZ']
) 
ind=9
sev=c(      sqrt(diag(pf.u.o.s.wb.int$varH))[ind],sqrt(diag(pf.u.o.s.pwe.int$varH))[ind],sqrt(diag(pf.u.o.s.pwp.int$varH))[ind],pf.u.o.s.gm.int[ind+3,'SE'],
            sqrt(diag(pf.u.x.s.wb.int$varH))[ind-1],sqrt(diag(pf.u.x.s.pwe.int$varH))[ind-1],sqrt(diag(pf.u.x.s.pwp.int$varH))[ind-1],pf.u.x.s.gm.int[ind+2,'SE'],
            sqrt(diag(pf.r.o.s.wb.int$varH))[ind],sqrt(diag(pf.r.o.s.pwe.int$varH))[ind],sqrt(diag(pf.r.o.s.pwp.int$varH))[ind],pf.r.o.s.gm.int[ind+3,'SE'],
            sqrt(diag(pf.r.x.s.wb.int$varH))[ind-1],sqrt(diag(pf.r.x.s.pwe.int$varH))[ind-1],sqrt(diag(pf.r.x.s.pwp.int$varH))[ind-1],pf.r.x.s.gm.int[ind+2,'SE']
)
modavgCustom(LLv,Kv,mnv,estv,sev,second.ord=F,nobs=538)
























### Old - Cox not appropriate


# AIC2LL(pf.r.o.s.6.sp$LCV),AIC2LL(pf.u.o.s.6.sp$LCV),
#       AIC2LL(pf.r.o.x.6.sp$LCV),AIC2LL(pf.u.o.x.6.sp$LCV),
#       AIC2LL(pf.r.x.s.6.sp$LCV),AIC2LL(pf.u.x.s.6.sp$LCV),
#       AIC2LL(pf.r.x.x.6.sp$LCV),AIC2LL(pf.u.x.x.6.sp$LCV),
#       AIC2LL(pf.r.o.s.6.pw$AIC),AIC2LL(pf.u.o.s.6.pw$AIC),
#       AIC2LL(pf.r.o.x.6.pw$AIC),AIC2LL(pf.u.o.x.6.pw$AIC),
#       AIC2LL(pf.r.x.s.6.pw$AIC),AIC2LL(pf.u.x.s.6.pw$AIC),
#       AIC2LL(pf.r.x.x.6.pw$AIC),AIC2LL(pf.u.x.x.6.pw$AIC),
#       AIC2LL(pf.u.o.s.A.sp$LCV),AIC2LL(pf.u.o.s.A.pw$AIC),
#       AIC2LL(pf.u.x.s.A.sp$LCV),AIC2LL(pf.u.x.s.A.pw$AIC),
#       AIC2LL(pf.u.o.x.A.sp$LCV),AIC2LL(pf.u.o.x.A.pw$AIC),
#       AIC2LL(pf.u.x.x.A.sp$LCV),AIC2LL(pf.u.x.x.A.pw$AIC))
# c(pf.r.o.s.6.sp$coef['Agr_CZ'],pf.u.o.s.6.sp$coef['Agr_CZ'],
#   pf.r.o.x.6.sp$coef['Agr_CZ'],pf.u.o.x.6.sp$coef['Agr_CZ'],
#   pf.r.x.s.6.sp$coef['Agr_CZ'],pf.u.x.s.6.sp$coef['Agr_CZ'],
#   pf.r.x.x.6.sp$coef['Agr_CZ'],pf.u.x.x.6.sp$coef['Agr_CZ'],
#   pf.r.o.s.6.pw$coef['Agr_CZ'],pf.u.o.s.6.pw$coef['Agr_CZ'],
#   pf.r.o.x.6.pw$coef['Agr_CZ'],pf.u.o.x.6.pw$coef['Agr_CZ'],
#   pf.r.x.s.6.pw$coef['Agr_CZ'],pf.u.x.s.6.pw$coef['Agr_CZ'],
#   pf.r.x.x.6.pw$coef['Agr_CZ'],pf.u.x.x.6.pw$coef['Agr_CZ'],
#   pf.u.o.s.A.sp$coef['Agr_CZ'],pf.u.o.s.A.pw$coef['Agr_CZ'],
#   pf.u.x.s.A.sp$coef['Agr_CZ'],pf.u.x.s.A.pw$coef['Agr_CZ'],
#   pf.u.o.x.A.sp$coef['Agr_CZ'],pf.u.o.x.A.pw$coef['Agr_CZ'],
#   pf.u.x.x.A.sp$coef['Agr_CZ'],pf.u.x.x.A.pw$coef['Agr_CZ']
# c(sqrt(diag(pf.r.o.s.6.sp$varH))[6],sqrt(diag(pf.u.o.s.6.sp$varH))[6],
#   sqrt(diag(pf.r.o.x.6.sp$varH))[5],sqrt(diag(pf.u.o.x.6.sp$varH))[5],
#   sqrt(diag(pf.r.x.s.6.sp$varH))[5],sqrt(diag(pf.u.x.s.6.sp$varH))[5],
#   sqrt(diag(pf.r.x.x.6.sp$varH))[4],sqrt(diag(pf.u.x.x.6.sp$varH))[4],
#   sqrt(diag(pf.r.o.s.6.pw$varH))[6],sqrt(diag(pf.u.o.s.6.pw$varH))[6],
#   sqrt(diag(pf.r.o.x.6.pw$varH))[5],sqrt(diag(pf.u.o.x.6.pw$varH))[5],
#   sqrt(diag(pf.r.x.s.6.pw$varH))[5],sqrt(diag(pf.u.x.s.6.pw$varH))[5],
#   sqrt(diag(pf.r.x.x.6.pw$varH))[4],sqrt(diag(pf.u.x.x.6.pw$varH))[4],
#   sqrt(diag(pf.u.o.s.A.sp$varH))[3],sqrt(diag(pf.u.o.s.A.pw$varH))[3],
#   sqrt(diag(pf.u.x.s.A.sp$varH))[2],sqrt(diag(pf.u.x.s.A.pw$varH))[2],
#   sqrt(diag(pf.u.o.x.A.sp$varH))[2],sqrt(diag(pf.u.o.x.A.pw$varH))[2],
#   sqrt(pf.u.x.x.A.sp$varH),sqrt(pf.u.x.x.A.pw$varH))











































### not run

## Agr
pf.u.o.s.A.pw = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               as.factor(sex) + as.factor(origin) +  
                               Agr_CZ,
                             data = datX, hazard =  'Piecewise-equi' , nb.int = 9
)
pf.u.x.x.A.pw = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               Agr_CZ,
                             data = datX, hazard =  'Piecewise-equi' , nb.int = 9
)
pf.u.x.s.A.pw = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               as.factor(sex) +  
                               Agr_CZ,
                             data = datX, hazard =  'Piecewise-equi' , nb.int = 9
)
pf.u.o.x.A.pw = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               as.factor(origin) +  
                               Agr_CZ,
                             data = datX, hazard =  'Piecewise-equi' , nb.int = 9
)






### Splines
pf.u.o.s.6.sp = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               as.factor(sex) + as.factor(origin) +  
                                Agr_CZ + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ,
                             RandDist = 'Gamma'
                             ,data = datX, hazard =  'Splines' 
                             , n.knots = 4, kappa = 1
)
pf.u.o.x.6.sp = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               + as.factor(origin) +  
                                Agr_CZ + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ,
                             RandDist = 'Gamma'
                             ,data = datX, hazard =  'Splines' 
                             , n.knots = 4, kappa = 1
)
pf.u.x.s.6.sp = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               as.factor(sex) + 
                                Agr_CZ + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ,
                             RandDist = 'Gamma'
                             ,data = datX, hazard =  'Splines' 
                             , n.knots = 4, kappa = 1
)
pf.u.x.x.6.sp = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                                Agr_CZ + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ,
                             RandDist = 'Gamma'
                             ,data = datX, hazard =  'Splines' 
                             , n.knots = 4, kappa = 1
)
pf.r.o.s.6.sp = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               as.factor(sex) + as.factor(origin) +  
                               Agr_CZ + D.r2.DoB + E.r2.DoB + Con_CZ + N.r1.DoB + O.r2.DoB,
                             RandDist = 'Gamma'
                             ,data = datX, hazard =  'Splines' 
                             , n.knots = 4, kappa = 1
)
pf.r.o.x.6.sp = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               + as.factor(origin) +  
                               Agr_CZ + D.r2.DoB + E.r2.DoB + Con_CZ + N.r1.DoB + O.r2.DoB,
                             RandDist = 'Gamma'
                             ,data = datX, hazard =  'Splines' 
                             , n.knots = 4, kappa = 1
)
pf.r.x.s.6.sp = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               as.factor(sex) + 
                               Agr_CZ + D.r2.DoB + E.r2.DoB + Con_CZ + N.r1.DoB + O.r2.DoB,
                             RandDist = 'Gamma'
                             ,data = datX, hazard =  'Splines' 
                             , n.knots = 4, kappa = 1
)
pf.r.x.x.6.sp = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               Agr_CZ + D.r2.DoB + E.r2.DoB + Con_CZ + N.r1.DoB + O.r2.DoB,
                             RandDist = 'Gamma'
                             ,data = datX, hazard =  'Splines' 
                             , n.knots = 4, kappa = 1
)





print(pf.u.x.s.A.sp)
pf.u.x.x.A.sp$logLikPenal
pf.u.x.x.A.sp$LCV








pf.u.x.x.A.sp = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               Agr_CZ ,
                             RandDist = 'Gamma'
                             ,data = datX, hazard =  'Splines' 
                             , n.knots = 4, kappa = 1
)
pf.u.o.s.A.sp = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               as.factor(sex) + as.factor(origin) + Agr_CZ ,
                             RandDist = 'Gamma'
                             ,data = datX, hazard =  'Splines' 
                             , n.knots = 4, kappa = 1
)
pf.u.o.x.A.sp = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               as.factor(origin) + Agr_CZ ,
                             RandDist = 'Gamma'
                             ,data = datX, hazard =  'Splines' 
                             , n.knots = 4, kappa = 1
)
pf.u.x.s.A.sp = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               as.factor(sex) + Agr_CZ ,
                             RandDist = 'Gamma'
                             ,data = datX, hazard =  'Splines' 
                             , n.knots = 4, kappa = 1
)
