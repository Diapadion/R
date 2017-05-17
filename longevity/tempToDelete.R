### temp

library(frailtypack)
library(parfm)


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
# wbl - weibull
# 
# ...


parfm.tst.all = parfm(Surv(age_pr, age, status) ~ 
                        as.factor(sex) + as.factor(origin) +  
                        D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB,
                      cluster="sample" #strata = "strt"
                      , frailty = 'gamma'
                      , data=datX, dist='logskewnormal', method ='ucminf')
print(parfm.tst.all)




# pf.u.x.x.pw(e/p)
# pf.r.o.s.wb


### Piecewise
pf.u.o.s.pwe = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                         as.factor(sex) + as.factor(origin) +  
                         Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ,
                       data = datX, hazard =  'Piecewise-equi' , nb.int = 9
)
pf.u.x.x.pwe = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ,
                             data = datX, hazard =  'Piecewise-equi' , nb.int = 9
)
pf.u.x.s.pwe = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               as.factor(sex) +  
                               Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ,
                             data = datX, hazard =  'Piecewise-equi' , nb.int = 9
)
pf.u.o.x.pwe = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               as.factor(origin) +  
                               Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ,
                             data = datX, hazard =  'Piecewise-equi' , nb.int = 9
)
pf.r.o.s.pwe = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               as.factor(sex) + as.factor(origin) +  
                               D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB,
                             data = datX, hazard =  'Piecewise-equi' , nb.int = 9
)
pf.r.x.x.pwe = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB,
                             data = datX, hazard =  'Piecewise-equi' , nb.int = 9
)
pf.r.x.s.pwe = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               as.factor(sex) +  
                               D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB,
                             data = datX, hazard =  'Piecewise-equi' , nb.int = 9
)
pf.r.o.x.pwe = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               as.factor(origin) +  
                               D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB,
                             data = datX, hazard =  'Piecewise-equi' , nb.int = 9
)

pf.u.o.s.pwp = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               as.factor(sex) + as.factor(origin) +  
                               Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ,
                             data = datX, hazard =  'Piecewise-per' , nb.int = 9
)
pf.u.x.x.pwp = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ,
                             data = datX, hazard =  'Piecewise-per' , nb.int = 9
)
pf.u.x.s.pwp = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               as.factor(sex) +  
                               Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ,
                             data = datX, hazard =  'Piecewise-per' , nb.int = 9
)
pf.u.o.x.pwp = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               as.factor(origin) +  
                               Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ,
                             data = datX, hazard =  'Piecewise-per' , nb.int = 9
)
pf.r.o.s.pwp = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               as.factor(sex) + as.factor(origin) +  
                               D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB,
                             data = datX, hazard =  'Piecewise-per' , nb.int = 9
)
pf.r.x.x.pwp = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB,
                             data = datX, hazard =  'Piecewise-per' , nb.int = 9
)
pf.r.x.s.pwp = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               as.factor(sex) +  
                               D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB,
                             data = datX, hazard =  'Piecewise-per' , nb.int = 9
)
pf.r.o.x.pwp = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               as.factor(origin) +  
                               D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB,
                             data = datX, hazard =  'Piecewise-per' , nb.int = 9
)



summary(pf.u.x.s.A.pw)



### Weibull
# won't run:
# pf.u.o.s.6.wb
# pf.r.* # problem visible in the plots
pf.u.o.s.wb = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) +
                             as.factor(sex) + as.factor(origin) +  
                               Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ,
                             RandDist = 'LogN'
                             ,data = datX, hazard =  'Weibull' 
)
pf.u.x.x.6.wb = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ,
                             RandDist = 'Gamma'
                             ,data = datX, hazard =  'Weibull' 
)
pf.u.x.s.6.wb = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               as.factor(sex) + #as.factor(origin) +  
                               Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ,
                             RandDist = 'Gamma'
                             ,data = datX, hazard =  'Weibull' 
)
pf.u.o.x.6.wb = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               as.factor(origin) +  
                               Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ,
                             RandDist = 'Gamma'
                             ,data = datX, hazard =  'Weibull' 
)


pf.r.o.x.wb = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               as.factor(origin) +  
                             D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB,
                             RandDist = 'LogN'
                             ,data = datX, hazard =  'Weibull' 
)



summary(pf.r.o.x.wb)
pf.r.x.s.6.wb$AIC
plot(pf.r.o.x.wb, type= 'Survival')





summary(pf.u.o.s.6.wb)
plot(pf.u.o.s.6.wb, type = 'Survival')
pf.u.o.s.6.wb$logLik * -2


plot(fpack.r.9, type = 'Hazard')


# pf.u.o.s.6.gm
# -2 * -789.542
# 
# u <- predict(pf.u.o.s.6.gm)
# plot(u)

plot(pf.u.o.s.6.gm, sort='i')




pf.r.x.s.6.sp$logLikPenal






fpack.u.spl = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                             as.factor(sex) + as.factor(origin) +  
                             Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ,
                           RandDist = 'Gamma'
                           ,data = datX, hazard =  'Splines' 
                           , n.knots = 4, kappa = 1
)


library(AICcmodavg)


# rememeber, AIC = 2k - 2LL
# so, if all K = 1; LL = 1 - (AIC)/2

AIC2LL <- function(AIC,k=1){
  LL = k - AIC/2
  return(LL)
}

LLv = c(AIC2LL(pf.r.o.s.6.sp$LCV), 
        AIC2LL(pf.u.o.s.6.sp$LCV),
        AIC2LL(fpack.r.9$AIC))

LLv = c(AIC2LL(pf.r.o.s.6.sp$LCV),AIC2LL(pf.u.o.s.6.sp$LCV),
        AIC2LL(pf.r.o.x.6.sp$LCV),AIC2LL(pf.u.o.x.6.sp$LCV),
        AIC2LL(pf.r.x.s.6.sp$LCV),AIC2LL(pf.u.x.s.6.sp$LCV),
        AIC2LL(pf.r.x.x.6.sp$LCV),AIC2LL(pf.u.x.x.6.sp$LCV),
        AIC2LL(pf.r.o.s.6.pw$AIC),AIC2LL(pf.u.o.s.6.pw$AIC),
        AIC2LL(pf.r.o.x.6.pw$AIC),AIC2LL(pf.u.o.x.6.pw$AIC),
        AIC2LL(pf.r.x.s.6.pw$AIC),AIC2LL(pf.u.x.s.6.pw$AIC),
        AIC2LL(pf.r.x.x.6.pw$AIC),AIC2LL(pf.u.x.x.6.pw$AIC),
        AIC2LL(pf.u.o.s.A.sp$LCV),AIC2LL(pf.u.o.s.A.pw$AIC),
        AIC2LL(pf.u.x.s.A.sp$LCV),AIC2LL(pf.u.x.s.A.pw$AIC),
        AIC2LL(pf.u.o.x.A.sp$LCV),AIC2LL(pf.u.o.x.A.pw$AIC),
        AIC2LL(pf.u.x.x.A.sp$LCV),AIC2LL(pf.u.x.x.A.pw$AIC))
Kv = rep(1,times=24)
mnv = c('pf.r.o.s.6.sp','pf.u.o.s.6.sp',
  'pf.r.o.x.6.sp','pf.u.o.x.6.sp',
  'pf.r.x.s.6.sp','pf.u.x.s.6.sp',
  'pf.r.x.x.6.sp','pf.u.x.x.6.sp',
  'pf.r.o.s.6.pw','pf.u.o.s.6.pw',
  'pf.r.o.x.6.pw','pf.u.o.x.6.pw',
  'pf.r.x.s.6.pw','pf.u.x.s.6.pw',
  'pf.r.x.x.6.pw','pf.u.x.x.6.pw',
  'pf.u.o.s.A.sp','pf.u.o.s.A.pw',
  'pf.u.x.s.A.sp','pf.u.x.s.A.pw',
  'pf.u.o.x.A.sp','pf.u.o.x.A.pw',
  'pf.u.x.x.A.sp','pf.u.x.x.A.pw')
estv = c(pf.r.o.s.6.sp$coef['Agr_CZ'],pf.u.o.s.6.sp$coef['Agr_CZ'],
         pf.r.o.x.6.sp$coef['Agr_CZ'],pf.u.o.x.6.sp$coef['Agr_CZ'],
         pf.r.x.s.6.sp$coef['Agr_CZ'],pf.u.x.s.6.sp$coef['Agr_CZ'],
         pf.r.x.x.6.sp$coef['Agr_CZ'],pf.u.x.x.6.sp$coef['Agr_CZ'],
         pf.r.o.s.6.pw$coef['Agr_CZ'],pf.u.o.s.6.pw$coef['Agr_CZ'],
         pf.r.o.x.6.pw$coef['Agr_CZ'],pf.u.o.x.6.pw$coef['Agr_CZ'],
         pf.r.x.s.6.pw$coef['Agr_CZ'],pf.u.x.s.6.pw$coef['Agr_CZ'],
         pf.r.x.x.6.pw$coef['Agr_CZ'],pf.u.x.x.6.pw$coef['Agr_CZ'],
         pf.u.o.s.A.sp$coef['Agr_CZ'],pf.u.o.s.A.pw$coef['Agr_CZ'],
         pf.u.x.s.A.sp$coef['Agr_CZ'],pf.u.x.s.A.pw$coef['Agr_CZ'],
         pf.u.o.x.A.sp$coef['Agr_CZ'],pf.u.o.x.A.pw$coef['Agr_CZ'],
         pf.u.x.x.A.sp$coef['Agr_CZ'],pf.u.x.x.A.pw$coef['Agr_CZ']
)

         
         
# seH <- sqrt(diag(x$varH))
# seHIH <- sqrt(diag(x$varHIH))
#sev = c(sqrt(diag(pf.r.o.s.6.sp$varH))[6],sqrt(diag(pf.u.o.s.6.sp$varH))[6],sqrt(diag(fpack.r.9$varH))[6])

sev=c(sqrt(diag(pf.r.o.s.6.sp$varH))[6],sqrt(diag(pf.u.o.s.6.sp$varH))[6],
  sqrt(diag(pf.r.o.x.6.sp$varH))[5],sqrt(diag(pf.u.o.x.6.sp$varH))[5],
  sqrt(diag(pf.r.x.s.6.sp$varH))[5],sqrt(diag(pf.u.x.s.6.sp$varH))[5],
  sqrt(diag(pf.r.x.x.6.sp$varH))[4],sqrt(diag(pf.u.x.x.6.sp$varH))[4],
  sqrt(diag(pf.r.o.s.6.pw$varH))[6],sqrt(diag(pf.u.o.s.6.pw$varH))[6],
  sqrt(diag(pf.r.o.x.6.pw$varH))[5],sqrt(diag(pf.u.o.x.6.pw$varH))[5],
  sqrt(diag(pf.r.x.s.6.pw$varH))[5],sqrt(diag(pf.u.x.s.6.pw$varH))[5],
  sqrt(diag(pf.r.x.x.6.pw$varH))[4],sqrt(diag(pf.u.x.x.6.pw$varH))[4],
  sqrt(diag(pf.u.o.s.A.sp$varH))[3],sqrt(diag(pf.u.o.s.A.pw$varH))[3],
  sqrt(diag(pf.u.x.s.A.sp$varH))[2],sqrt(diag(pf.u.x.s.A.pw$varH))[2],
  sqrt(diag(pf.u.o.x.A.sp$varH))[2],sqrt(diag(pf.u.o.x.A.pw$varH))[2],
  sqrt(pf.u.x.x.A.sp$varH),sqrt(pf.u.x.x.A.pw$varH))




modavgCustom(LLv,Kv,mnv,estv,sev,
             nobs=NULL,second.ord=F, uncond.se='old')

























































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
                               Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ,
                             RandDist = 'Gamma'
                             ,data = datX, hazard =  'Splines' 
                             , n.knots = 4, kappa = 1
)
pf.u.o.x.6.sp = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               + as.factor(origin) +  
                               Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ,
                             RandDist = 'Gamma'
                             ,data = datX, hazard =  'Splines' 
                             , n.knots = 4, kappa = 1
)
pf.u.x.s.6.sp = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               as.factor(sex) + 
                               Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ,
                             RandDist = 'Gamma'
                             ,data = datX, hazard =  'Splines' 
                             , n.knots = 4, kappa = 1
)
pf.u.x.x.6.sp = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ,
                             RandDist = 'Gamma'
                             ,data = datX, hazard =  'Splines' 
                             , n.knots = 4, kappa = 1
)
pf.r.o.s.6.sp = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               as.factor(sex) + as.factor(origin) +  
                               D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB,
                             RandDist = 'Gamma'
                             ,data = datX, hazard =  'Splines' 
                             , n.knots = 4, kappa = 1
)
pf.r.o.x.6.sp = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               + as.factor(origin) +  
                               D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB,
                             RandDist = 'Gamma'
                             ,data = datX, hazard =  'Splines' 
                             , n.knots = 4, kappa = 1
)
pf.r.x.s.6.sp = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               as.factor(sex) + 
                               D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB,
                             RandDist = 'Gamma'
                             ,data = datX, hazard =  'Splines' 
                             , n.knots = 4, kappa = 1
)
pf.r.x.x.6.sp = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB,
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
