### Parametric frailty models


library(survival)
library(parfm)

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
