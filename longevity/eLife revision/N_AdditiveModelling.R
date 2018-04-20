### GAM evaluation ###

library(mgcv)


### Dominance
gam.d = gamm(Dom ~ s(age_pr, k=20), data=datX)
# plot(gam.d$gam, residuals=TRUE)
gam.check(gam.d$gam)


### Extraversion
gam.e = gamm(Ext ~ s(age_pr, k=20), data=datX)
plot(gam.e$gam, residuals=TRUE)
gam.check(gam.e$gam)


### Conscientiousness
gam.c = gamm(Con ~ s(age_pr, k=20), data=datX)
plot(gam.c$gam, residuals=TRUE)
gam.check(gam.c$gam)


### Agreeableness
gam.a = gamm(Agr ~ s(age_pr, k=20), data=datX)
plot(gam.a$gam, residuals=TRUE)
gam.check(gam.a$gam)


### Neuroticism
gam.n = gamm(Neu ~ s(age_pr, k=20), data=datX)
plot(gam.n$gam, residuals=TRUE)
gam.check(gam.n$gam)


### Openness
gam.o = gamm(Opn ~ s(age_pr, k=20), data=datX)
plot(gam.o$gam, residuals=TRUE)
gam.check(gam.o$gam)


### Save residuals

datX$D.gr = gam.d$gam$residuals
datX$E.gr = gam.e$gam$residuals
datX$C.gr = gam.c$gam$residuals
datX$N.gr = gam.n$gam$residuals
datX$A.gr = gam.a$gam$residuals
datX$O.gr = gam.o$gam$residuals



library(coxme)
library(frailtypack)
library(parfm)



### Cox


pf.r.o.s.cx = coxme(Surv(age_pr, age, status) ~ as.factor(origin) + as.factor(sex) +
                      A.gr + D.gr + E.gr + C.gr + N.gr + O.gr + (1|sample)
                    , data=datX)
summary(pf.r.o.s.cx)

pf.r.o.s.cx.f = coxme(Surv(age_pr, age, status) ~ as.factor(origin) + 
                      A.gr + D.gr + E.gr + C.gr + N.gr + O.gr + (1|sample)
                    , data=datX[datX$sex==0,]
                    )
pf.r.o.s.cx.m = coxme(Surv(age_pr, age, status) ~ as.factor(origin) + 
                        A.gr + D.gr + E.gr + C.gr + N.gr + O.gr + (1|sample)
                      , data=datX[datX$sex==1,]
                      )
summary(pf.r.o.s.cx.f)
summary(pf.r.o.s.cx.m)


pf.r.o.s.cx = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
               as.factor(origin) + as.factor(sex) +
               A.gr + D.gr + E.gr + C.gr + N.gr + O.gr,
             data = datX
)


pf.r.o.s.cx = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                             as.factor(origin) + as.factor(sex) +
                             A.gr + D.gr + E.gr + C.gr + N.gr + O.gr,
                           data = datX[datX$sex==1,]
)




### Gompertz

pf.gr.gm = parfm(Surv(age_pr, age, status) ~ 
                   as.factor(origin) +
                   as.factor(sex)
                 + A.gr + D.gr + E.gr + 
                   C.gr + N.gr + O.gr
                    ,cluster="sample" 
                    , frailty = 'gamma'
                    , data=datX, dist='gompertz', method ='ucminf')

pf.cz.gm = parfm(Surv(age_pr, age, status) ~ 
                   as.factor(origin) +
                   as.factor(sex)
                 + Agr_CZ + Dom_CZ + Ext_CZ + 
                   Con_CZ + Neu_CZ + Opn_CZ
                 ,cluster="sample" 
                 , frailty = 'gamma'
                 , data=datX, dist='gompertz', method ='ucminf')

pf.gr.gm.m = parfm(Surv(age_pr, age, status) ~ 
                   as.factor(origin) +
                 + A.gr + D.gr + E.gr + 
                   C.gr + N.gr + O.gr
                 ,cluster="sample" 
                 , frailty = 'gamma'
                 , data=datX[datX$sex==1,], dist='gompertz', method ='ucminf')

pf.gr.gm.f = parfm(Surv(age_pr, age, status) ~ 
                   as.factor(origin) +
                 + A.gr + D.gr + E.gr + 
                   C.gr + N.gr + O.gr
                 ,cluster="sample" 
                 , frailty = 'gamma'
                 , data=datX[datX$sex==0,], dist='gompertz', method ='ucminf')



pf.cz.gm.m = parfm(Surv(age_pr, age, status) ~ 
                   as.factor(origin) +
                 + Agr_CZ + Dom_CZ + Ext_CZ + 
                   Con_CZ + Neu_CZ + Opn_CZ
                 ,cluster="sample" 
                 , frailty = 'gamma'
                 , data=datX[datX$sex==1,], dist='gompertz', method ='ucminf')

pf.cz.gm.f = parfm(Surv(age_pr, age, status) ~ 
                     as.factor(origin) +
                   + Agr_CZ + Dom_CZ + Ext_CZ + 
                     Con_CZ + Neu_CZ + Opn_CZ
                   ,cluster="sample" 
                   , frailty = 'gamma'
                   , data=datX[datX$sex==0,], dist='gompertz', method ='ucminf')



print(pf.gr.gm)

print(pf.gr.gm.f)
print(pf.gr.gm.m)

print(pf.cz.gm)

print(pf.cz.gm.m)
print(pf.cz.gm.f)




### Log-logistic

pf.u.o.s.ll = parfm(Surv(age_pr, age, status) ~ 
                     as.factor(origin) +
                     + Agr_CZ + Dom_CZ + Ext_CZ + 
                     Con_CZ + Neu_CZ + Opn_CZ
                   ,cluster="sample" 
                   , frailty = 'gamma'
                   , data=datX
                   , dist='loglogistic', method ='ucminf')

pf.u.o.s.ll.f = parfm(Surv(age_pr, age, status) ~ 
                     as.factor(origin) +
                     + Agr_CZ + Dom_CZ + Ext_CZ + 
                     Con_CZ + Neu_CZ + Opn_CZ
                   ,cluster="sample" 
                   , frailty = 'gamma'
                   , data=datX[datX$sex==0,], dist='gompertz', method ='ucminf')

pf.u.o.s.ll.m = parfm(Surv(age_pr, age, status) ~ 
                     as.factor(origin) +
                     + Agr_CZ + Dom_CZ + Ext_CZ + 
                     Con_CZ + Neu_CZ + Opn_CZ
                   ,cluster="sample" 
                   , frailty = 'gamma'
                   , data=datX[datX$sex==1,], dist='gompertz', method ='ucminf')

pf.r.o.s.ll = parfm(Surv(age_pr, age, status) ~ 
                      as.factor(origin) +
                      A.gr + D.gr + E.gr + C.gr + N.gr + O.gr,
                    ,cluster="sample" 
                    , frailty = 'gamma'
                    , data=datX, dist='loglogistic', method ='ucminf')

pf.r.o.s.ll.f = parfm(Surv(age_pr, age, status) ~ 
                        as.factor(origin) +
                        A.gr + D.gr + E.gr + C.gr + N.gr + O.gr,
                      ,cluster="sample" 
                      , frailty = 'gamma'
                      , data=datX[datX$sex==0,], dist='gompertz', method ='ucminf')

pf.r.o.s.ll.m = parfm(Surv(age_pr, age, status) ~ 
                        as.factor(origin) +
                        A.gr + D.gr + E.gr + C.gr + N.gr + O.gr,
                      ,cluster="sample" 
                      , frailty = 'gamma'
                      , data=datX[datX$sex==1,], dist='gompertz', method ='ucminf')



print(pf.u.o.s.ll)
print(pf.u.o.s.ll.m)
print(pf.u.o.s.ll.f)

print(pf.r.o.s.ll)
print(pf.r.o.s.ll.m)
print(pf.r.o.s.ll.f)

logLik(pf.r.o.s.ll)
pf.r.o.s.cx$loglik
pf.r.o.s.sp$logLikPenal

extractAIC(pf.r.o.s.ll)
extractAIC(pf.r.o.s.cx)
extractAIC(pf.r.o.s.sp)

pf.r.o.s.sp$LCV




### Weibull

pf.u.o.s.wb = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                             as.factor(origin) + as.factor(sex) +
                             Agr_CZ + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ,
                           data = datX, hazard =  'Weibull')

pf.r.o.s.wb = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                             as.factor(origin) + as.factor(sex) +
                             A.gr + D.gr + E.gr + C.gr + N.gr + O.gr,
                           data = datX, hazard =  'Weibull')

summary(pf.u.o.s.wb)
summary(pf.r.o.s.wb)



### Splines

pf.u.o.s.sp = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                              as.factor(origin) + as.factor(sex) +
                              Agr_CZ + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ,
                            data = datX, hazard =  'Splines', n.knots=5, kappa=10
                           )

pf.r.o.s.sp = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                             as.factor(origin) + as.factor(sex) +
                             A.gr + D.gr + E.gr + C.gr + N.gr + O.gr,
                           data = datX, hazard =  'Splines', n.knots=5, kappa=10
)

summary(pf.u.o.s.sp)
summary(pf.r.o.s.sp)


pf.r.o.s.sp.m = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                             as.factor(origin) +
                             A.gr + D.gr + E.gr + C.gr + N.gr + O.gr,
                           data = datX[datX$sex==1,], hazard =  'Splines', n.knots=5, kappa=10
)

pf.r.o.s.sp.f = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               as.factor(origin) +
                               A.gr + D.gr + E.gr + C.gr + N.gr + O.gr,
                             data = datX[datX$sex==0,], hazard =  'Splines', n.knots=5, kappa=10
)

summary(pf.r.o.s.sp.m)
summary(pf.r.o.s.sp.f)




pf.u.o.s.sp.m = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               as.factor(origin) + 
                               Agr_CZ + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ,
                             data = datX[datX$sex==1,], hazard =  'Splines', n.knots=5, kappa=10
)

pf.u.o.s.sp.f = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               as.factor(origin) +
                               Agr_CZ + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ,
                             data = datX[datX$sex==0,], hazard =  'Splines', n.knots=5, kappa=10
)

summary(pf.u.o.s.sp.m)
summary(pf.u.o.s.sp.f)
