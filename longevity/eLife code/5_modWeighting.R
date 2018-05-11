### Models to weight and aggregate

library(frailtypack)
library(parfm)
library(AICcmodavg)
library(coxme)



### How can the specification vary?

# x2
# In/exclude Origin

# x2
# In/exclude sex

# x2
# Leave confounded
# Residulaize data by DoB

# x4
# Method used
# cx - Cox
# ll - Log-logistic
# wb - Weibull
# gm - Gompertz
# sp - Spline
 


### All individuals



### Cox


## Uncorrected

pf.u.o.s.cx = coxme(Surv(age_pr, age, status) ~ origin + sex +
                      Agr_CZ + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ + (1|sample)
                    , data=datX)

pf.u.x.s.cx = coxme(Surv(age_pr, age, status) ~ sex +
                      Agr_CZ + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ + (1|sample)
                    , data=datX)

pf.u.o.x.cx = coxme(Surv(age_pr, age, status) ~ origin +
                      Agr_CZ + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ + (1|sample)
                    , data=datX)

pf.u.x.x.cx = coxme(Surv(age_pr, age, status) ~
                      Agr_CZ + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ + (1|sample)
                    , data=datX)


## Residualized

pf.r.o.s.cx = coxme(Surv(age_pr, age, status) ~ origin + sex +
                      A.gr + D.gr + E.gr + C.gr + N.gr + O.gr + (1|sample)
                    , data=datX)

pf.r.x.s.cx = coxme(Surv(age_pr, age, status) ~ sex +
                      A.gr + D.gr + E.gr + C.gr + N.gr + O.gr + (1|sample)
                    , data=datX)

pf.r.o.x.cx = coxme(Surv(age_pr, age, status) ~ origin +
                      A.gr + D.gr + E.gr + C.gr + N.gr + O.gr + (1|sample)
                    , data=datX)

pf.r.x.x.cx = coxme(Surv(age_pr, age, status) ~
                      A.gr + D.gr + E.gr + C.gr + N.gr + O.gr + (1|sample)
                    , data=datX)



### Weibull

pf.u.o.s.wb = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) +
                             origin + sex +
                                Agr_CZ + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ,
                             RandDist = 'Gamma'
                             ,data = datX, hazard =  'Weibull' 
)
pf.u.x.x.wb = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                                Agr_CZ + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ,
                             RandDist = 'Gamma'
                             ,data = datX, hazard =  'Weibull' 
)
pf.u.x.s.wb = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               sex + 
                                Agr_CZ + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ,
                             RandDist = 'Gamma'
                             ,data = datX, hazard =  'Weibull' 
)
pf.u.o.x.wb = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               origin +
                                Agr_CZ + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ,
                             RandDist = 'Gamma'
                             ,data = datX, hazard =  'Weibull' 
)

pf.r.x.s.wb = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                             sex +
                             A.gr + D.gr + E.gr + C.gr + N.gr + O.gr,
                             RandDist = 'Gamma'
                             ,data = datX, hazard =  'Weibull' 
)
pf.r.o.x.wb = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                             origin +  
                             A.gr + D.gr + E.gr + C.gr + N.gr + O.gr,
                           RandDist = 'Gamma'
                           ,data = datX, hazard =  'Weibull' 
)
pf.r.o.s.wb = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) +
                             origin + sex +
                             A.gr + D.gr + E.gr + C.gr + N.gr + O.gr,
                           RandDist = 'Gamma', #maxit = 1000, recurrentAG=F
                           ,data = datX, hazard =  'Weibull'
) 
pf.r.x.x.wb = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                             A.gr + D.gr + E.gr + C.gr + N.gr + O.gr,
                           RandDist = 'Gamma'
                           ,data = datX, hazard =  'Weibull' 
)



### Gompertz

pf.u.o.s.gm = parfm(Surv(age_pr, age, status) ~ 
                      origin + sex + Agr_CZ
                    + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ
                    ,cluster="sample"
                    , frailty = 'gamma'
                    , data=datX, dist='gompertz', method ='ucminf')
pf.u.x.s.gm = parfm(Surv(age_pr, age, status) ~ 
                      sex + Agr_CZ
                    + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ
                    ,cluster="sample"
                    , frailty = 'gamma'
                    , data=datX, dist='gompertz', method ='ucminf')
pf.u.o.x.gm = parfm(Surv(age_pr, age, status) ~ 
                      origin + Agr_CZ
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
                      origin + sex + A.gr + D.gr + E.gr + C.gr + N.gr + O.gr
                    ,cluster="sample" 
                    , frailty = 'gamma'
                    , data=datX, dist='gompertz', method ='ucminf')
pf.r.x.s.gm = parfm(Surv(age_pr, age, status) ~ 
                      sex + A.gr + D.gr + E.gr + C.gr + N.gr + O.gr
                    ,cluster="sample" 
                    , frailty = 'gamma'
                    , data=datX, dist='gompertz', method ='ucminf')
pf.r.o.x.gm = parfm(Surv(age_pr, age, status) ~ 
                      origin + A.gr + D.gr + E.gr + C.gr + N.gr + O.gr
                    ,cluster="sample" 
                    , frailty = 'gamma'
                    , data=datX, dist='gompertz', method ='ucminf')
pf.r.x.x.gm = parfm(Surv(age_pr, age, status) ~ 
                      A.gr + D.gr + E.gr + C.gr + N.gr + O.gr
                    ,cluster="sample" 
                    , frailty = 'gamma'
                    , data=datX, dist='gompertz', method ='ucminf')



### Log-logistic

pf.u.o.s.ll = parfm(Surv(age_pr, age, status) ~ 
                      origin + sex + Agr_CZ
                    + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ
                    ,cluster="sample"
                    , frailty = 'gamma'
                    , data=datX, dist='loglogistic', method ='ucminf')
pf.u.x.s.ll = parfm(Surv(age_pr, age, status) ~ 
                      sex + Agr_CZ
                    + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ
                    ,cluster="sample"
                    , frailty = 'gamma'
                    , data=datX, dist='loglogistic', method ='ucminf')
pf.u.o.x.ll = parfm(Surv(age_pr, age, status) ~ 
                      origin + Agr_CZ
                    + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ
                    ,cluster="sample" 
                    , frailty = 'gamma'
                    , data=datX, dist='loglogistic', method ='ucminf')
pf.u.x.x.ll = parfm(Surv(age_pr, age, status) ~ 
                      Agr_CZ
                    + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ
                    ,cluster="sample" 
                    , frailty = 'gamma'
                    , data=datX, dist='loglogistic', method ='ucminf')

pf.r.o.s.ll = parfm(Surv(age_pr, age, status) ~ 
                      origin + sex + A.gr + D.gr + E.gr + C.gr + N.gr + O.gr
                    ,cluster="sample" 
                    , frailty = 'gamma'
                    , data=datX, dist='loglogistic', method ='ucminf')
pf.r.x.s.ll = parfm(Surv(age_pr, age, status) ~ 
                      sex + A.gr + D.gr + E.gr + C.gr + N.gr + O.gr
                    ,cluster="sample" 
                    , frailty = 'gamma'
                    , data=datX, dist='loglogistic', method ='ucminf')
pf.r.o.x.ll = parfm(Surv(age_pr, age, status) ~ 
                      origin + A.gr + D.gr + E.gr + C.gr + N.gr + O.gr
                    ,cluster="sample" 
                    , frailty = 'gamma'
                    , data=datX, dist='loglogistic', method ='ucminf')
pf.r.x.x.ll = parfm(Surv(age_pr, age, status) ~ 
                      A.gr + D.gr + E.gr + C.gr + N.gr + O.gr
                    ,cluster="sample" 
                    , frailty = 'gamma'
                    , data=datX, dist='loglogistic', method ='ucminf')



### Splines

pf.u.o.s.sp = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                             origin + sex +
                             Agr_CZ + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ,
                           data = datX, hazard =  'Splines', n.knots=5, kappa=15
)

pf.u.x.s.sp = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                             sex +
                             Agr_CZ + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ,
                           data = datX, hazard =  'Splines', n.knots=5, kappa=15
)

pf.u.o.x.sp = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                             origin +
                             Agr_CZ + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ,
                           data = datX, hazard =  'Splines', n.knots=5, kappa=15
)

pf.u.x.x.sp = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                             Agr_CZ + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ,
                           data = datX, hazard =  'Splines', n.knots=5, kappa=15
)


pf.r.o.s.sp = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                             origin + sex +
                             A.gr + D.gr + E.gr + C.gr + N.gr + O.gr,
                           data = datX, hazard =  'Splines', n.knots=5, kappa=15
)

pf.r.x.s.sp = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                             sex +
                             A.gr + D.gr + E.gr + C.gr + N.gr + O.gr,
                           data = datX, hazard =  'Splines', n.knots=5, kappa=15
)

pf.r.o.x.sp = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                             origin +
                             A.gr + D.gr + E.gr + C.gr + N.gr + O.gr,
                           data = datX, hazard =  'Splines', n.knots=5, kappa=15
)

pf.r.x.x.sp = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                             A.gr + D.gr + E.gr + C.gr + N.gr + O.gr,
                           data = datX, hazard =  'Splines', n.knots=5, kappa=15
)



### AIC weighting average regression tables ###

# Remember: unadjusted and adjusted models are not based on the same data,
# so they should be tabulated separately



# # rememeber, AIC = 2k - 2LL
# # so, if all K = 1; LL = 1 - (AIC)/2
# 
# AIC2LL <- function(AIC,k=1){
#   LL = k - AIC/2
#   return(LL)
# }

### Unnecessary test - TODO: RM
## S3 method for class 'AICcoxme'
# modavg(cand.set, parm, modnames = NULL, second.ord
#        = TRUE, nobs = NULL, uncond.se = "revised", conf.level = 0.95,
#        exclude = NULL, warn = TRUE, ...)
# cdset = list(pf.u.o.s.cx,pf.u.x.s.cx,pf.u.o.x.cx,pf.u.x.x.cx)
# coxme.sum = modavg(cdset, "Agr_CZ")



LLv.u = c(pf.u.o.s.wb$logLik,pf.u.o.s.cx$loglik[3],pf.u.o.s.sp$logLikPenal,logLik(pf.u.o.s.gm)[1],logLik(pf.u.o.s.ll)[1],
        pf.u.o.x.wb$logLik,pf.u.o.x.cx$loglik[3],pf.u.o.x.sp$logLikPenal,logLik(pf.u.o.x.gm)[1],logLik(pf.u.o.x.ll)[1],
        pf.u.x.s.wb$logLik,pf.u.x.s.cx$loglik[3],pf.u.x.s.sp$logLikPenal,logLik(pf.u.x.s.gm)[1],logLik(pf.u.x.s.ll)[1],
        pf.u.x.x.wb$logLik,pf.u.x.x.cx$loglik[3],pf.u.x.x.sp$logLikPenal,logLik(pf.u.x.x.gm)[1],logLik(pf.u.x.x.ll)[1])
LLv.r = c(pf.r.o.s.wb$logLik,
        pf.r.o.s.cx$loglik[3],pf.r.o.s.sp$logLikPenal,logLik(pf.r.o.s.gm)[1],logLik(pf.r.o.s.ll)[1],
        pf.r.o.x.wb$logLik,pf.r.o.x.cx$loglik[3],pf.r.o.x.sp$logLikPenal,logLik(pf.r.o.x.gm)[1],logLik(pf.r.o.x.ll)[1],
        pf.r.x.s.wb$logLik,pf.r.x.s.cx$loglik[3],pf.r.x.s.sp$logLikPenal,logLik(pf.r.x.s.gm)[1],logLik(pf.r.x.s.ll)[1],
        pf.r.x.x.wb$logLik,pf.r.x.x.cx$loglik[3],pf.r.x.x.sp$logLikPenal,logLik(pf.r.x.x.gm)[1],logLik(pf.r.x.x.ll)[1])
Kv.u = c(pf.u.o.s.wb$npar,pf.u.o.s.cx$df[2],pf.u.o.s.sp$npar,attr(logLik(pf.u.o.s.gm),'df'),attr(logLik(pf.u.o.s.ll),'df'),
        pf.u.o.x.wb$npar,pf.u.o.x.cx$df[2],pf.u.o.x.sp$npar,attr(logLik(pf.u.o.x.gm),'df'),attr(logLik(pf.u.o.x.ll),'df'),
        pf.u.x.s.wb$npar,pf.u.x.s.cx$df[2],pf.u.x.s.sp$npar,attr(logLik(pf.u.x.s.gm),'df'),attr(logLik(pf.u.x.s.ll),'df'),
        pf.u.x.x.wb$npar,pf.u.x.x.cx$df[2],pf.u.x.x.sp$npar,attr(logLik(pf.u.x.x.gm),'df'),attr(logLik(pf.u.x.x.ll),'df'))
Kv.r = c(pf.r.o.s.wb$npar,
        pf.r.o.s.cx$df[2],pf.r.o.s.sp$npar,attr(logLik(pf.r.o.s.gm),'df'),attr(logLik(pf.r.o.s.ll),'df'),
        pf.r.o.x.wb$npar,pf.r.o.x.cx$df[2],pf.r.o.x.sp$npar,attr(logLik(pf.r.o.x.gm),'df'),attr(logLik(pf.r.o.x.ll),'df'),
        pf.r.x.s.wb$npar,pf.r.x.s.cx$df[2],pf.r.x.s.sp$npar,attr(logLik(pf.r.x.s.gm),'df'),attr(logLik(pf.r.x.s.ll),'df'),
        pf.r.x.x.wb$npar,pf.r.x.x.cx$df[2],pf.r.x.x.sp$npar,attr(logLik(pf.r.x.x.gm),'df'),attr(logLik(pf.r.x.x.ll),'df'))
mnv.u = c('pf.u.o.s.wb','pf.u.o.s.cx','pf.u.o.s.sp','pf.u.o.s.gm','pf.u.o.s.ll',
        'pf.u.o.x.wb','pf.u.o.x.cx','pf.u.o.x.sp','pf.u.o.x.gm','pf.u.o.x.ll',
        'pf.u.x.s.wb','pf.u.x.s.cx','pf.u.x.s.sp','pf.u.x.s.gm','pf.u.x.s.ll',
        'pf.u.x.x.wb','pf.u.x.x.cx','pf.u.x.x.sp','pf.u.x.x.gm','pf.u.x.x.ll')
mnv.r = c('pf.r.o.s.wb',
        'pf.r.o.s.cx','pf.r.o.s.sp','pf.r.o.s.gm','pf.r.o.s.ll',
        'pf.r.o.x.wb','pf.r.o.x.cx','pf.r.o.x.sp','pf.r.o.x.gm','pf.r.o.x.ll',
        'pf.r.x.s.wb','pf.r.x.s.cx','pf.r.x.s.sp','pf.r.x.s.gm','pf.r.x.s.ll',
        'pf.r.x.x.wb','pf.r.x.x.cx','pf.r.x.x.sp','pf.r.x.x.gm','pf.r.x.x.ll')



pf.u.o.s.wb$coef
pf.u.o.s.cx$coef
pf.u.o.s.sp$coef
coef(pf.u.o.s.gm)
coef(pf.u.o.s.ll)



### Wild - TODO
estv.u.W = c(pf.u.o.s.wb$coef['originWILD'],pf.u.o.s.cx$coef['originWILD'],pf.u.o.s.sp$coef['originWILD'],coef(pf.u.o.s.gm)['originWILD'],coef(pf.u.o.s.ll)['originWILD'],
             pf.u.o.x.wb$coef['originWILD'],pf.u.o.x.cx$coef['originWILD'],pf.u.o.x.sp$coef['originWILD'],coef(pf.u.o.x.gm)['originWILD'],coef(pf.u.o.x.ll)['originWILD'])
estv.r.W = c(pf.r.o.s.wb$coef['originWILD'],
             pf.r.o.s.cx$coef['originWILD'],pf.r.o.s.sp$coef['originWILD'],coef(pf.r.o.s.gm)['originWILD'],coef(pf.r.o.s.ll)['originWILD'],
             pf.r.o.x.wb$coef['originWILD'],pf.r.o.x.cx$coef['originWILD'],pf.r.o.x.sp$coef['originWILD'],coef(pf.r.o.x.gm)['originWILD'],coef(pf.r.o.x.ll)['originWILD'])
ind = 1
sev.u.W=c(sqrt(diag(pf.u.o.s.wb$varH))[ind],sqrt(diag(vcov(pf.u.o.s.cx)))[ind],sqrt(diag(pf.u.o.s.sp$varH))[ind],pf.u.o.s.gm[ind+3,'SE'],pf.u.o.s.ll[ind+3,'SE'],
          sqrt(diag(pf.u.o.x.wb$varH))[ind],sqrt(diag(vcov(pf.u.o.x.cx)))[ind],sqrt(diag(pf.u.o.x.sp$varH))[ind],pf.u.o.x.gm[ind+2,'SE'],pf.u.o.x.gm[ind+2,'SE'])
sev.r.W=c(sqrt(diag(pf.r.o.s.wb$varH))[ind],
          sqrt(diag(vcov(pf.r.o.s.cx)))[ind],sqrt(diag(pf.r.o.s.sp$varH))[ind],pf.r.o.s.gm[ind+3,'SE'],pf.r.o.s.ll[ind+3,'SE'],
          sqrt(diag(pf.r.o.x.wb$varH))[ind],sqrt(diag(vcov(pf.r.o.x.cx)))[ind],sqrt(diag(pf.r.o.x.sp$varH))[ind],pf.r.o.x.gm[ind+2,'SE'],pf.r.o.x.ll[ind+2,'SE'])

mavg.u.W = modavgCustom(LLv.u[1:10],Kv.u[1:10],mnv.u[1:10],estv.u.W,sev.u.W,second.ord=F)
exp(mavg.u.W$Mod.avg.est)
exp(mavg.u.W$Lower.CL)
exp(mavg.u.W$Upper.CL)

mavg.r.W = modavgCustom(LLv.r[1:10],Kv.r[1:10],mnv.r[1:10],estv.r.W,sev.r.W,second.ord=F)
exp(mavg.r.W$Mod.avg.est)
exp(mavg.r.W$Lower.CL)
exp(mavg.r.W$Upper.CL)

  
### Sex
estv.u.S = c(pf.u.o.s.wb$coef['sex1'],pf.u.o.s.cx$coef['sex1'],pf.u.o.s.sp$coef['sex1'],coef(pf.u.o.s.gm)['sex1'],coef(pf.u.o.s.ll)['sex1'],
             pf.u.x.s.wb$coef['sex1'],pf.u.x.s.cx$coef['sex1'],pf.u.x.s.sp$coef['sex1'],coef(pf.u.x.s.gm)['sex1'],coef(pf.u.x.s.ll)['sex1'])
estv.r.S = c(pf.r.o.s.wb$coef['sex1'],
             pf.r.o.s.cx$coef['sex1'],pf.r.o.s.sp$coef['sex1'],coef(pf.r.o.s.gm)['sex1'],coef(pf.r.o.s.ll)['sex1'],
             pf.r.x.s.wb$coef['sex1'],pf.r.x.s.cx$coef['sex1'],pf.r.x.s.sp$coef['sex1'],coef(pf.r.x.s.gm)['sex1'],coef(pf.r.x.s.ll)['sex1'])
ind = 2
sev.u.S=c(sqrt(diag(pf.u.o.s.wb$varH))[ind],sqrt(diag(vcov(pf.u.o.s.cx)))[ind],sqrt(diag(pf.u.o.s.sp$varH))[ind],pf.u.o.s.gm[ind+3,'SE'],pf.u.o.s.ll[ind+3,'SE'],
          sqrt(diag(pf.u.x.s.wb$varH))[ind-1],sqrt(diag(vcov(pf.u.x.s.cx)))[ind-1],sqrt(diag(pf.u.x.s.sp$varH))[ind-1],pf.u.x.s.gm[ind+2,'SE'],pf.u.x.s.gm[ind+2,'SE'])
sev.r.S=c(sqrt(diag(pf.r.o.s.wb$varH))[ind],
          sqrt(diag(vcov(pf.r.o.s.cx)))[ind],sqrt(diag(pf.r.o.s.sp$varH))[ind],pf.r.o.s.gm[ind+3,'SE'],pf.r.o.s.ll[ind+3,'SE'],
          sqrt(diag(pf.r.x.s.wb$varH))[ind-1],sqrt(diag(vcov(pf.r.x.s.cx)))[ind-1],sqrt(diag(pf.r.x.s.sp$varH))[ind-1],pf.r.x.s.gm[ind+2,'SE'],pf.r.x.s.ll[ind+2,'SE'])

mavg.u.S = modavgCustom(LLv.u[c(1:5,11:15)],Kv.u[c(1:5,11:15)],mnv.u[c(1:5,11:15)],estv.u.S,sev.u.S,second.ord=F)
exp(mavg.u.S$Mod.avg.est)
exp(mavg.u.S$Lower.CL)
exp(mavg.u.S$Upper.CL)

mavg.r.S = modavgCustom(LLv.r[c(1:5,11:15)],Kv.r[c(1:5,11:15)],mnv.r[c(1:5,11:15)],estv.r.S,sev.r.S,second.ord=F)          
exp(mavg.r.S$Mod.avg.est)
exp(mavg.r.S$Lower.CL)
exp(mavg.r.S$Upper.CL)


### Agreeableness
estv.u.A = c(pf.u.o.s.wb$coef['Agr_CZ'],pf.u.o.s.cx$coef['Agr_CZ'],pf.u.o.s.sp$coef['Agr_CZ'],coef(pf.u.o.s.gm)['Agr_CZ'],coef(pf.u.o.s.ll)['Agr_CZ'],
         pf.u.o.x.wb$coef['Agr_CZ'],pf.u.o.x.cx$coef['Agr_CZ'],pf.u.o.x.sp$coef['Agr_CZ'],coef(pf.u.o.x.gm)['Agr_CZ'],coef(pf.u.o.x.ll)['Agr_CZ'],
         pf.u.x.s.wb$coef['Agr_CZ'],pf.u.x.s.cx$coef['Agr_CZ'],pf.u.x.s.sp$coef['Agr_CZ'],coef(pf.u.x.s.gm)['Agr_CZ'],coef(pf.u.x.s.ll)['Agr_CZ'],
         pf.u.x.x.wb$coef['Agr_CZ'],pf.u.x.x.cx$coef['Agr_CZ'],pf.u.x.x.sp$coef['Agr_CZ'],coef(pf.u.x.x.gm)['Agr_CZ'],coef(pf.u.x.x.ll)['Agr_CZ'])
estv.r.A = c(pf.r.o.s.wb$coef['A.gr'],
         pf.r.o.s.cx$coef['A.gr'],pf.r.o.s.sp$coef['A.gr'],coef(pf.r.o.s.gm)['A.gr'],coef(pf.r.o.s.ll)['A.gr'],
         pf.r.o.x.wb$coef['A.gr'],pf.r.o.x.cx$coef['A.gr'],pf.r.o.x.sp$coef['A.gr'],coef(pf.r.o.x.gm)['A.gr'],coef(pf.r.o.x.ll)['A.gr'],
         pf.r.x.s.wb$coef['A.gr'],pf.r.x.s.cx$coef['A.gr'],pf.r.x.s.sp$coef['A.gr'],coef(pf.r.x.s.gm)['A.gr'],coef(pf.r.x.s.ll)['A.gr'],
         pf.r.x.x.wb$coef['A.gr'],pf.r.x.x.cx$coef['A.gr'],pf.r.x.x.sp$coef['A.gr'],coef(pf.r.x.x.gm)['A.gr'],coef(pf.r.x.x.ll)['A.gr'])
ind = 3
sev.u.A=c(sqrt(diag(pf.u.o.s.wb$varH))[ind],sqrt(diag(vcov(pf.u.o.s.cx)))[ind],sqrt(diag(pf.u.o.s.sp$varH))[ind],pf.u.o.s.gm[ind+3,'SE'],pf.u.o.s.ll[ind+3,'SE'],
      sqrt(diag(pf.u.o.x.wb$varH))[ind-1],sqrt(diag(vcov(pf.u.o.x.cx)))[ind-1],sqrt(diag(pf.u.o.x.sp$varH))[ind-1],pf.u.o.x.gm[ind+2,'SE'],pf.u.o.x.ll[ind+2,'SE'],
      sqrt(diag(pf.u.x.s.wb$varH))[ind-1],sqrt(diag(vcov(pf.u.x.s.cx)))[ind-1],sqrt(diag(pf.u.x.s.sp$varH))[ind-1],pf.u.x.s.gm[ind+2,'SE'],pf.u.x.s.ll[ind+2,'SE'],
      sqrt(diag(pf.u.x.x.wb$varH))[ind-2],sqrt(diag(vcov(pf.u.x.x.cx)))[ind-2],sqrt(diag(pf.u.x.x.sp$varH))[ind-2],pf.u.x.s.gm[ind+1,'SE'],pf.u.x.x.ll[ind+1,'SE'])
sev.r.A=c(sqrt(diag(pf.r.o.s.wb$varH))[ind],sqrt(diag(vcov(pf.r.o.s.cx)))[ind],sqrt(diag(pf.r.o.s.sp$varH))[ind],pf.r.o.s.gm[ind+3,'SE'],pf.r.o.s.ll[ind+3,'SE'],
          sqrt(diag(pf.r.o.x.wb$varH))[ind-1],sqrt(diag(vcov(pf.r.o.x.cx)))[ind-1],sqrt(diag(pf.r.o.x.sp$varH))[ind-1],pf.r.o.x.gm[ind+2,'SE'],pf.r.o.x.ll[ind+2,'SE'],
          sqrt(diag(pf.r.x.s.wb$varH))[ind-1],sqrt(diag(vcov(pf.r.x.s.cx)))[ind-1],sqrt(diag(pf.r.x.s.sp$varH))[ind-1],pf.r.x.s.gm[ind+2,'SE'],pf.r.x.s.ll[ind+2,'SE'],
          sqrt(diag(pf.r.x.x.wb$varH))[ind-2],sqrt(diag(vcov(pf.r.x.x.cx)))[ind-2],sqrt(diag(pf.r.x.x.sp$varH))[ind-2],pf.r.x.s.gm[ind+1,'SE'],pf.r.x.x.ll[ind+1,'SE'])

mavg.u.A = modavgCustom(LLv.u,Kv.u,mnv.u,estv.u.A,sev.u.A,second.ord=F)
exp(mavg.u.A$Mod.avg.est)
exp(mavg.u.A$Lower.CL)
exp(mavg.u.A$Upper.CL)

mavg.r.A = modavgCustom(LLv.r,Kv.r,mnv.r,estv.r.A,sev.r.A,second.ord=F)
exp(mavg.r.A$Mod.avg.est)
exp(mavg.r.A$Lower.CL)
exp(mavg.r.A$Upper.CL)


### Dominance
estv.u.D = c(pf.u.o.s.wb$coef['Dom_CZ'],pf.u.o.s.cx$coef['Dom_CZ'],pf.u.o.s.sp$coef['Dom_CZ'],coef(pf.u.o.s.gm)['Dom_CZ'],coef(pf.u.o.s.ll)['Dom_CZ'],
             pf.u.o.x.wb$coef['Dom_CZ'],pf.u.o.x.cx$coef['Dom_CZ'],pf.u.o.x.sp$coef['Dom_CZ'],coef(pf.u.o.x.gm)['Dom_CZ'],coef(pf.u.o.x.ll)['Dom_CZ'],
             pf.u.x.s.wb$coef['Dom_CZ'],pf.u.x.s.cx$coef['Dom_CZ'],pf.u.x.s.sp$coef['Dom_CZ'],coef(pf.u.x.s.gm)['Dom_CZ'],coef(pf.u.x.s.ll)['Dom_CZ'],
             pf.u.x.x.wb$coef['Dom_CZ'],pf.u.x.x.cx$coef['Dom_CZ'],pf.u.x.x.sp$coef['Dom_CZ'],coef(pf.u.x.x.gm)['Dom_CZ'],coef(pf.u.x.x.ll)['Dom_CZ'])
estv.r.D = c(pf.r.o.s.wb$coef['D.gr'],
             pf.r.o.s.cx$coef['D.gr'],pf.r.o.s.sp$coef['D.gr'],coef(pf.r.o.s.gm)['D.gr'],coef(pf.r.o.s.ll)['D.gr'],
             pf.r.o.x.wb$coef['D.gr'],pf.r.o.x.cx$coef['D.gr'],pf.r.o.x.sp$coef['D.gr'],coef(pf.r.o.x.gm)['D.gr'],coef(pf.r.o.x.ll)['D.gr'],
             pf.r.x.s.wb$coef['D.gr'],pf.r.x.s.cx$coef['D.gr'],pf.r.x.s.sp$coef['D.gr'],coef(pf.r.x.s.gm)['D.gr'],coef(pf.r.x.s.ll)['D.gr'],
             pf.r.x.x.wb$coef['D.gr'],pf.r.x.x.cx$coef['D.gr'],pf.r.x.x.sp$coef['D.gr'],coef(pf.r.x.x.gm)['D.gr'],coef(pf.r.x.x.ll)['D.gr'])
ind = 4
sev.u.D=c(sqrt(diag(pf.u.o.s.wb$varH))[ind],sqrt(diag(vcov(pf.u.o.s.cx)))[ind],sqrt(diag(pf.u.o.s.sp$varH))[ind],pf.u.o.s.gm[ind+3,'SE'],pf.u.o.s.ll[ind+3,'SE'],
          sqrt(diag(pf.u.o.x.wb$varH))[ind-1],sqrt(diag(vcov(pf.u.o.x.cx)))[ind-1],sqrt(diag(pf.u.o.x.sp$varH))[ind-1],pf.u.o.x.gm[ind+2,'SE'],pf.u.o.x.ll[ind+2,'SE'],
          sqrt(diag(pf.u.x.s.wb$varH))[ind-1],sqrt(diag(vcov(pf.u.x.s.cx)))[ind-1],sqrt(diag(pf.u.x.s.sp$varH))[ind-1],pf.u.x.s.gm[ind+2,'SE'],pf.u.x.s.ll[ind+2,'SE'],
          sqrt(diag(pf.u.x.x.wb$varH))[ind-2],sqrt(diag(vcov(pf.u.x.x.cx)))[ind-2],sqrt(diag(pf.u.x.x.sp$varH))[ind-2],pf.u.x.s.gm[ind+1,'SE'],pf.u.x.x.ll[ind+1,'SE'])
sev.r.D=c(sqrt(diag(pf.r.o.s.wb$varH))[ind],sqrt(diag(vcov(pf.r.o.s.cx)))[ind],sqrt(diag(pf.r.o.s.sp$varH))[ind],pf.r.o.s.gm[ind+3,'SE'],pf.r.o.s.ll[ind+3,'SE'],
          sqrt(diag(pf.r.o.x.wb$varH))[ind-1],sqrt(diag(vcov(pf.r.o.x.cx)))[ind-1],sqrt(diag(pf.r.o.x.sp$varH))[ind-1],pf.r.o.x.gm[ind+2,'SE'],pf.r.o.x.ll[ind+2,'SE'],
          sqrt(diag(pf.r.x.s.wb$varH))[ind-1],sqrt(diag(vcov(pf.r.x.s.cx)))[ind-1],sqrt(diag(pf.r.x.s.sp$varH))[ind-1],pf.r.x.s.gm[ind+2,'SE'],pf.r.x.s.ll[ind+2,'SE'],
          sqrt(diag(pf.r.x.x.wb$varH))[ind-2],sqrt(diag(vcov(pf.r.x.x.cx)))[ind-2],sqrt(diag(pf.r.x.x.sp$varH))[ind-2],pf.r.x.s.gm[ind+1,'SE'],pf.r.x.x.ll[ind+1,'SE'])

mavg.u.D = modavgCustom(LLv.u,Kv.u,mnv.u,estv.u.D,sev.u.D,second.ord=F)
exp(mavg.u.D$Mod.avg.est)
exp(mavg.u.D$Lower.CL)
exp(mavg.u.D$Upper.CL)

mavg.r.D = modavgCustom(LLv.r,Kv.r,mnv.r,estv.r.D,sev.r.D,second.ord=F)
exp(mavg.r.D$Mod.avg.est)
exp(mavg.r.D$Lower.CL)
exp(mavg.r.D$Upper.CL)


### Extraversion
estv.u.E = c(pf.u.o.s.wb$coef['Ext_CZ'],pf.u.o.s.cx$coef['Ext_CZ'],pf.u.o.s.sp$coef['Ext_CZ'],coef(pf.u.o.s.gm)['Ext_CZ'],
             pf.u.o.x.wb$coef['Ext_CZ'],pf.u.o.x.cx$coef['Ext_CZ'],pf.u.o.x.sp$coef['Ext_CZ'],coef(pf.u.o.x.gm)['Ext_CZ'],
             pf.u.x.s.wb$coef['Ext_CZ'],pf.u.x.s.cx$coef['Ext_CZ'],pf.u.x.s.sp$coef['Ext_CZ'],coef(pf.u.x.s.gm)['Ext_CZ'],
             pf.u.x.x.wb$coef['Ext_CZ'],pf.u.x.x.cx$coef['Ext_CZ'],pf.u.x.x.sp$coef['Ext_CZ'],coef(pf.u.x.x.gm)['Ext_CZ'])
estv.r.E = c(pf.r.o.s.wb$coef['E.r2.DoB'],
             pf.r.o.s.cx$coef['E.r2.DoB'],pf.r.o.s.sp$coef['E.r2.DoB'],coef(pf.r.o.s.gm)['E.r2.DoB'],
             pf.r.o.x.wb$coef['E.r2.DoB'],pf.r.o.x.cx$coef['E.r2.DoB'],pf.r.o.x.sp$coef['E.r2.DoB'],coef(pf.r.o.x.gm)['E.r2.DoB'],
             pf.r.x.s.wb$coef['E.r2.DoB'],pf.r.x.s.cx$coef['E.r2.DoB'],pf.r.x.s.sp$coef['E.r2.DoB'],coef(pf.r.x.s.gm)['E.r2.DoB'],
             pf.r.x.x.wb$coef['E.r2.DoB'],pf.r.x.x.cx$coef['E.r2.DoB'],pf.r.x.x.sp$coef['E.r2.DoB'],coef(pf.r.x.x.gm)['E.r2.DoB'])
ind = 5
sev.u.E=c(sqrt(diag(pf.u.o.s.wb$varH))[ind],sqrt(diag(pf.u.o.s.cx$varH))[ind],sqrt(diag(pf.u.o.s.sp$varH))[ind],pf.u.o.s.gm[ind+3,'SE'],
          sqrt(diag(pf.u.o.x.wb$varH))[ind-1],sqrt(diag(pf.u.o.x.cx$varH))[ind-1],sqrt(diag(pf.u.o.x.sp$varH))[ind-1],pf.u.o.x.gm[ind+2,'SE'],
          sqrt(diag(pf.u.x.s.wb$varH))[ind-1],sqrt(diag(pf.u.x.s.cx$varH))[ind-1],sqrt(diag(pf.u.x.s.sp$varH))[ind-1],pf.u.x.s.gm[ind+2,'SE'],
          sqrt(diag(pf.u.x.x.wb$varH))[ind-2],sqrt(diag(pf.u.x.x.cx$varH))[ind-2],sqrt(diag(pf.u.x.x.sp$varH))[ind-2],pf.u.x.s.gm[ind+1,'SE'])
sev.r.E=c(sqrt(diag(pf.r.o.s.wb$varH))[ind],
          sqrt(diag(pf.r.o.s.cx$varH))[ind],sqrt(diag(pf.r.o.s.sp$varH))[ind],pf.r.o.s.gm[ind+3,'SE'],
          sqrt(diag(pf.r.o.x.wb$varH))[ind-1],sqrt(diag(pf.r.o.x.cx$varH))[ind-1],sqrt(diag(pf.r.o.x.sp$varH))[ind-1],pf.r.o.x.gm[ind+2,'SE'],
          sqrt(diag(pf.r.x.s.wb$varH))[ind-1],sqrt(diag(pf.r.x.s.cx$varH))[ind-1],sqrt(diag(pf.r.x.s.sp$varH))[ind-1],pf.r.x.s.gm[ind+2,'SE'],
          sqrt(diag(pf.r.x.x.wb$varH))[ind-2],sqrt(diag(pf.r.x.x.cx$varH))[ind-2],sqrt(diag(pf.r.x.x.sp$varH))[ind-2],pf.r.x.x.gm[ind+1,'SE'])

mavg.u.E = modavgCustom(LLv.u,Kv.u,mnv.u,estv.u.E,sev.u.E,second.ord=F)
exp(mavg.u.E$Mod.avg.est)
exp(mavg.u.E$Lower.CL)
exp(mavg.u.E$Upper.CL)

mavg.r.E = modavgCustom(LLv.r,Kv.r,mnv.r,estv.r.E,sev.r.E,second.ord=F)
exp(mavg.r.E$Mod.avg.est)
exp(mavg.r.E$Lower.CL)
exp(mavg.r.E$Upper.CL)


### Conscientiuousness
estv.u.C = c(pf.u.o.s.wb$coef['Con_CZ'],pf.u.o.s.cx$coef['Con_CZ'],pf.u.o.s.sp$coef['Con_CZ'],coef(pf.u.o.s.gm)['Con_CZ'],
             pf.u.o.x.wb$coef['Con_CZ'],pf.u.o.x.cx$coef['Con_CZ'],pf.u.o.x.sp$coef['Con_CZ'],coef(pf.u.o.x.gm)['Con_CZ'],
             pf.u.x.s.wb$coef['Con_CZ'],pf.u.x.s.cx$coef['Con_CZ'],pf.u.x.s.sp$coef['Con_CZ'],coef(pf.u.x.s.gm)['Con_CZ'],
             pf.u.x.x.wb$coef['Con_CZ'],pf.u.x.x.cx$coef['Con_CZ'],pf.u.x.x.sp$coef['Con_CZ'],coef(pf.u.x.x.gm)['Con_CZ'])
estv.r.C = c(pf.r.o.s.wb$coef['Con_CZ'],
             pf.r.o.s.cx$coef['Con_CZ'],pf.r.o.s.sp$coef['Con_CZ'],coef(pf.r.o.s.gm)['Con_CZ'],
             pf.r.o.x.wb$coef['Con_CZ'],pf.r.o.x.cx$coef['Con_CZ'],pf.r.o.x.sp$coef['Con_CZ'],coef(pf.r.o.x.gm)['Con_CZ'],
             pf.r.x.s.wb$coef['Con_CZ'],pf.r.x.s.cx$coef['Con_CZ'],pf.r.x.s.sp$coef['Con_CZ'],coef(pf.r.x.s.gm)['Con_CZ'],
             pf.r.x.x.wb$coef['Con_CZ'],pf.r.x.x.cx$coef['Con_CZ'],pf.r.x.x.sp$coef['Con_CZ'],coef(pf.r.x.x.gm)['Con_CZ'])
ind = 6
sev.u.C=c(sqrt(diag(pf.u.o.s.wb$varH))[ind],sqrt(diag(pf.u.o.s.cx$varH))[ind],sqrt(diag(pf.u.o.s.sp$varH))[ind],pf.u.o.s.gm[ind+3,'SE'],
          sqrt(diag(pf.u.o.x.wb$varH))[ind-1],sqrt(diag(pf.u.o.x.cx$varH))[ind-1],sqrt(diag(pf.u.o.x.sp$varH))[ind-1],pf.u.o.x.gm[ind+2,'SE'],
          sqrt(diag(pf.u.x.s.wb$varH))[ind-1],sqrt(diag(pf.u.x.s.cx$varH))[ind-1],sqrt(diag(pf.u.x.s.sp$varH))[ind-1],pf.u.x.s.gm[ind+2,'SE'],
          sqrt(diag(pf.u.x.x.wb$varH))[ind-2],sqrt(diag(pf.u.x.x.cx$varH))[ind-2],sqrt(diag(pf.u.x.x.sp$varH))[ind-2],pf.u.x.s.gm[ind+1,'SE'])
sev.r.C=c(sqrt(diag(pf.r.o.s.wb$varH))[ind],
          sqrt(diag(pf.r.o.s.cx$varH))[ind],sqrt(diag(pf.r.o.s.sp$varH))[ind],pf.r.o.s.gm[ind+3,'SE'],
          sqrt(diag(pf.r.o.x.wb$varH))[ind-1],sqrt(diag(pf.r.o.x.cx$varH))[ind-1],sqrt(diag(pf.r.o.x.sp$varH))[ind-1],pf.r.o.x.gm[ind+2,'SE'],
          sqrt(diag(pf.r.x.s.wb$varH))[ind-1],sqrt(diag(pf.r.x.s.cx$varH))[ind-1],sqrt(diag(pf.r.x.s.sp$varH))[ind-1],pf.r.x.s.gm[ind+2,'SE'],
          sqrt(diag(pf.r.x.x.wb$varH))[ind-2],sqrt(diag(pf.r.x.x.cx$varH))[ind-2],sqrt(diag(pf.r.x.x.sp$varH))[ind-2],pf.r.x.x.gm[ind+1,'SE'])

mavg.u.C = modavgCustom(LLv.u,Kv.u,mnv.u,estv.u.C,sev.u.C,second.ord=F)
exp(mavg.u.C$Mod.avg.est)
exp(mavg.u.C$Lower.CL)
exp(mavg.u.C$Upper.CL)

mavg.r.C = modavgCustom(LLv.r,Kv.r,mnv.r,estv.r.C,sev.r.C,second.ord=F)
exp(mavg.r.C$Mod.avg.est)
exp(mavg.r.C$Lower.CL)
exp(mavg.r.C$Upper.CL)


### Neuroticism
estv.u.N = c(pf.u.o.s.wb$coef['Neu_CZ'],pf.u.o.s.cx$coef['Neu_CZ'],pf.u.o.s.sp$coef['Neu_CZ'],coef(pf.u.o.s.gm)['Neu_CZ'],
             pf.u.o.x.wb$coef['Neu_CZ'],pf.u.o.x.cx$coef['Neu_CZ'],pf.u.o.x.sp$coef['Neu_CZ'],coef(pf.u.o.x.gm)['Neu_CZ'],
             pf.u.x.s.wb$coef['Neu_CZ'],pf.u.x.s.cx$coef['Neu_CZ'],pf.u.x.s.sp$coef['Neu_CZ'],coef(pf.u.x.s.gm)['Neu_CZ'],
             pf.u.x.x.wb$coef['Neu_CZ'],pf.u.x.x.cx$coef['Neu_CZ'],pf.u.x.x.sp$coef['Neu_CZ'],coef(pf.u.x.x.gm)['Neu_CZ'])
estv.r.N = c(pf.r.o.s.wb$coef['N.r1.DoB'],
             pf.r.o.s.cx$coef['N.r1.DoB'],pf.r.o.s.sp$coef['N.r1.DoB'],coef(pf.r.o.s.gm)['N.r1.DoB'],
             pf.r.o.x.wb$coef['N.r1.DoB'],pf.r.o.x.cx$coef['N.r1.DoB'],pf.r.o.x.sp$coef['N.r1.DoB'],coef(pf.r.o.x.gm)['N.r1.DoB'],
             pf.r.x.s.wb$coef['N.r1.DoB'],pf.r.x.s.cx$coef['N.r1.DoB'],pf.r.x.s.sp$coef['N.r1.DoB'],coef(pf.r.x.s.gm)['N.r1.DoB'],
             pf.r.x.x.wb$coef['N.r1.DoB'],pf.r.x.x.cx$coef['N.r1.DoB'],pf.r.x.x.sp$coef['N.r1.DoB'],coef(pf.r.x.x.gm)['N.r1.DoB'])
ind = 7
sev.u.N=c(sqrt(diag(pf.u.o.s.wb$varH))[ind],sqrt(diag(pf.u.o.s.cx$varH))[ind],sqrt(diag(pf.u.o.s.sp$varH))[ind],pf.u.o.s.gm[ind+3,'SE'],
          sqrt(diag(pf.u.o.x.wb$varH))[ind-1],sqrt(diag(pf.u.o.x.cx$varH))[ind-1],sqrt(diag(pf.u.o.x.sp$varH))[ind-1],pf.u.o.x.gm[ind+2,'SE'],
          sqrt(diag(pf.u.x.s.wb$varH))[ind-1],sqrt(diag(pf.u.x.s.cx$varH))[ind-1],sqrt(diag(pf.u.x.s.sp$varH))[ind-1],pf.u.x.s.gm[ind+2,'SE'],
          sqrt(diag(pf.u.x.x.wb$varH))[ind-2],sqrt(diag(pf.u.x.x.cx$varH))[ind-2],sqrt(diag(pf.u.x.x.sp$varH))[ind-2],pf.u.x.s.gm[ind+1,'SE'])
sev.r.N=c(sqrt(diag(pf.r.o.s.wb$varH))[ind],
          sqrt(diag(pf.r.o.s.cx$varH))[ind],sqrt(diag(pf.r.o.s.sp$varH))[ind],pf.r.o.s.gm[ind+3,'SE'],
          sqrt(diag(pf.r.o.x.wb$varH))[ind-1],sqrt(diag(pf.r.o.x.cx$varH))[ind-1],sqrt(diag(pf.r.o.x.sp$varH))[ind-1],pf.r.o.x.gm[ind+2,'SE'],
          sqrt(diag(pf.r.x.s.wb$varH))[ind-1],sqrt(diag(pf.r.x.s.cx$varH))[ind-1],sqrt(diag(pf.r.x.s.sp$varH))[ind-1],pf.r.x.s.gm[ind+2,'SE'],
          sqrt(diag(pf.r.x.x.wb$varH))[ind-2],sqrt(diag(pf.r.x.x.cx$varH))[ind-2],sqrt(diag(pf.r.x.x.sp$varH))[ind-2],pf.r.x.x.gm[ind+1,'SE'])

mavg.u.N = modavgCustom(LLv.u,Kv.u,mnv.u,estv.u.N,sev.u.N,second.ord=F)
exp(mavg.u.N$Mod.avg.est)
exp(mavg.u.N$Lower.CL)
exp(mavg.u.N$Upper.CL)

mavg.r.N = modavgCustom(LLv.r,Kv.r,mnv.r,estv.r.N,sev.r.N,second.ord=F)
exp(mavg.r.N$Mod.avg.est)
exp(mavg.r.N$Lower.CL)
exp(mavg.r.N$Upper.CL)


### Openness  
estv.u.O = c(pf.u.o.s.wb$coef['Opn_CZ'],pf.u.o.s.cx$coef['Opn_CZ'],pf.u.o.s.sp$coef['Opn_CZ'],coef(pf.u.o.s.gm)['Opn_CZ'],
         pf.u.o.x.wb$coef['Opn_CZ'],pf.u.o.x.cx$coef['Opn_CZ'],pf.u.o.x.sp$coef['Opn_CZ'],coef(pf.u.o.x.gm)['Opn_CZ'],
         pf.u.x.s.wb$coef['Opn_CZ'],pf.u.x.s.cx$coef['Opn_CZ'],pf.u.x.s.sp$coef['Opn_CZ'],coef(pf.u.x.s.gm)['Opn_CZ'],
         pf.u.x.x.wb$coef['Opn_CZ'],pf.u.x.x.cx$coef['Opn_CZ'],pf.u.x.x.sp$coef['Opn_CZ'],coef(pf.u.x.x.gm)['Opn_CZ'])
estv.r.O = c(pf.r.o.s.wb$coef['O.r2.DoB'],
         pf.r.o.s.cx$coef['O.r2.DoB'],pf.r.o.s.sp$coef['O.r2.DoB'],coef(pf.r.o.s.gm)['O.r2.DoB'],
         pf.r.o.x.wb$coef['O.r2.DoB'],pf.r.o.x.cx$coef['O.r2.DoB'],pf.r.o.x.sp$coef['O.r2.DoB'],coef(pf.r.o.x.gm)['O.r2.DoB'],
         pf.r.x.s.wb$coef['O.r2.DoB'],pf.r.x.s.cx$coef['O.r2.DoB'],pf.r.x.s.sp$coef['O.r2.DoB'],coef(pf.r.x.s.gm)['O.r2.DoB'],
         pf.r.x.x.wb$coef['O.r2.DoB'],pf.r.x.x.cx$coef['O.r2.DoB'],pf.r.x.x.sp$coef['O.r2.DoB'],coef(pf.r.x.x.gm)['O.r2.DoB'])
ind = 8
sev.u.O=c(sqrt(diag(pf.u.o.s.wb$varH))[ind],sqrt(diag(pf.u.o.s.cx$varH))[ind],sqrt(diag(pf.u.o.s.sp$varH))[ind],pf.u.o.s.gm[ind+3,'SE'],
      sqrt(diag(pf.u.o.x.wb$varH))[ind-1],sqrt(diag(pf.u.o.x.cx$varH))[ind-1],sqrt(diag(pf.u.o.x.sp$varH))[ind-1],pf.u.o.x.gm[ind+2,'SE'],
      sqrt(diag(pf.u.x.s.wb$varH))[ind-1],sqrt(diag(pf.u.x.s.cx$varH))[ind-1],sqrt(diag(pf.u.x.s.sp$varH))[ind-1],pf.u.x.s.gm[ind+2,'SE'],
      sqrt(diag(pf.u.x.x.wb$varH))[ind-2],sqrt(diag(pf.u.x.x.cx$varH))[ind-2],sqrt(diag(pf.u.x.x.sp$varH))[ind-2],pf.u.x.s.gm[ind+1,'SE'])
sev.r.O=c(sqrt(diag(pf.r.o.s.wb$varH))[ind],
      sqrt(diag(pf.r.o.s.cx$varH))[ind],sqrt(diag(pf.r.o.s.sp$varH))[ind],pf.r.o.s.gm[ind+3,'SE'],
      sqrt(diag(pf.r.o.x.wb$varH))[ind-1],sqrt(diag(pf.r.o.x.cx$varH))[ind-1],sqrt(diag(pf.r.o.x.sp$varH))[ind-1],pf.r.o.x.gm[ind+2,'SE'],
      sqrt(diag(pf.r.x.s.wb$varH))[ind-1],sqrt(diag(pf.r.x.s.cx$varH))[ind-1],sqrt(diag(pf.r.x.s.sp$varH))[ind-1],pf.r.x.s.gm[ind+2,'SE'],
      sqrt(diag(pf.r.x.x.wb$varH))[ind-2],sqrt(diag(pf.r.x.x.cx$varH))[ind-2],sqrt(diag(pf.r.x.x.sp$varH))[ind-2],pf.r.x.x.gm[ind+1,'SE'])
 
mavg.u.O = modavgCustom(LLv.u,Kv.u,mnv.u,estv.u.O,sev.u.O,second.ord=F)
exp(mavg.u.O$Mod.avg.est)
exp(mavg.u.O$Lower.CL)
exp(mavg.u.O$Upper.CL)

mavg.r.O = modavgCustom(LLv.r,Kv.r,mnv.r,estv.r.O,sev.r.O,second.ord=F)
exp(mavg.r.O$Mod.avg.est)
exp(mavg.r.O$Lower.CL)
exp(mavg.r.O$Upper.CL)







### Splitting the process by sex



### Males ###


pf.u.x.x.pwp.m = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                                Agr_CZ + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Ext_CZ,
                              data=datX[datX$sex==1,], hazard =  'Piecewise-per' , nb.int = 3
)

pf.u.o.x.pwp.m = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                                as.factor(origin) +  
                                Agr_CZ + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ,
                              data=datX[datX$sex==1,], hazard =  'Piecewise-per' , nb.int = 3
)

pf.r.x.x.pwp.m = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                                Agr_CZ + D.r2.DoB + E.r2.DoB + Con_CZ + N.r1.DoB + O.r2.DoB,
                              data=datX[datX$sex==1,], hazard =  'Piecewise-per' , nb.int = 3
)

pf.r.o.x.pwp.m = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                                as.factor(origin) +  
                                Agr_CZ + D.r2.DoB + E.r2.DoB + Con_CZ + N.r1.DoB + O.r2.DoB,
                              data=datX[datX$sex==1,], hazard =  'Piecewise-per' , nb.int = 3
)

pf.u.x.x.wb.m = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               Agr_CZ + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ,
                             RandDist = 'Gamma'
                             ,data=datX[datX$sex==1,], hazard =  'Weibull' 
)

pf.u.o.x.wb.m = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               as.factor(origin) +  
                               Agr_CZ + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ,
                             RandDist = 'Gamma'
                             ,data=datX[datX$sex==1,], hazard =  'Weibull' 
)
pf.r.o.x.wb.m = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               as.factor(origin) +  
                               Agr_CZ + D.r2.DoB + E.r2.DoB + Con_CZ + N.r1.DoB + O.r2.DoB,
                             RandDist = 'Gamma'
                             ,data=datX[datX$sex==1,], hazard =  'Weibull' 
)

pf.r.x.x.wb.m = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               Agr_CZ + D.r2.DoB + E.r2.DoB + Con_CZ + N.r1.DoB + O.r2.DoB,
                             RandDist = 'Gamma'
                             ,data=datX[datX$sex==1,], hazard =  'Weibull' 
)

pf.u.o.x.gm.m = parfm(Surv(age_pr, age, status) ~ 
                        as.factor(origin) + Agr_CZ
                      + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ
                      ,cluster="sample" 
                      , frailty = 'gamma'
                      , data=datX[datX$sex==1,], dist='gompertz', method ='ucminf')
pf.u.x.x.gm.m = parfm(Surv(age_pr, age, status) ~ 
                        Agr_CZ
                      + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ
                      ,cluster="sample" 
                      , frailty = 'gamma'
                      , data=datX[datX$sex==1,], dist='gompertz', method ='ucminf')
pf.r.o.x.gm.m = parfm(Surv(age_pr, age, status) ~ 
                        as.factor(origin) + Agr_CZ
                      + D.r2.DoB + E.r2.DoB + Con_CZ + N.r1.DoB + O.r2.DoB
                      ,cluster="sample" 
                      , frailty = 'gamma'
                      , data=datX[datX$sex==1,], dist='gompertz', method ='ucminf')
pf.r.x.x.gm.m = parfm(Surv(age_pr, age, status) ~ 
                        Agr_CZ
                      + D.r2.DoB + E.r2.DoB + Con_CZ + N.r1.DoB + O.r2.DoB
                      ,cluster="sample" 
                      , frailty = 'gamma'
                      , data=datX[datX$sex==1,], dist='gompertz', method ='ucminf')



### Females ###


pf.u.x.x.pwp.f = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                                Agr_CZ + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ,
                              data=datX[datX$sex==0,], hazard =  'Piecewise-per' , nb.int = 3
)

pf.u.o.x.pwp.f = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                                as.factor(origin) +  
                                Agr_CZ + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ,
                              data=datX[datX$sex==0,], hazard =  'Piecewise-per' , nb.int = 3
)

pf.r.x.x.pwp.f = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                                Agr_CZ + D.r2.DoB + E.r2.DoB + Con_CZ + N.r1.DoB + O.r2.DoB,
                              data=datX[datX$sex==0,], hazard =  'Piecewise-per' , nb.int = 3
)

pf.r.o.x.pwp.f = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                                as.factor(origin) +  
                                Agr_CZ + D.r2.DoB + E.r2.DoB + Con_CZ + N.r1.DoB + O.r2.DoB,
                              data=datX[datX$sex==0,], hazard =  'Piecewise-per' , nb.int = 3
)

pf.u.x.x.wb.f = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               Agr_CZ + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ,
                             RandDist = 'Gamma' #LogN'
                             ,data=datX[datX$sex==0,], hazard =  'Weibull' 
)
pf.u.o.x.wb.f = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               as.factor(origin) +  
                               Agr_CZ + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ,
                             RandDist = 'Gamma' #'LogN'
                             ,data=datX[datX$sex==0,], hazard =  'Weibull' 
)
pf.r.o.x.wb.f = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               as.factor(origin) +  
                               Agr_CZ + D.r2.DoB + E.r2.DoB + Con_CZ + N.r1.DoB + O.r2.DoB,
                             RandDist = 'Gamma'
                             ,data=datX[datX$sex==0,], hazard =  'Weibull' 
)
pf.r.x.x.wb.f = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               Agr_CZ + D.r2.DoB + E.r2.DoB + Con_CZ + N.r1.DoB + O.r2.DoB,
                             RandDist = 'Gamma'
                             ,data=datX[datX$sex==0,], hazard =  'Weibull' 
)

pf.u.o.x.gm.f = parfm(Surv(age_pr, age, status) ~ 
                        as.factor(origin) + Agr_CZ
                      + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ
                      ,cluster="sample" 
                      , frailty = 'gamma'
                      , data=datX[datX$sex==0,], dist='gompertz', method ='ucminf')
pf.u.x.x.gm.f = parfm(Surv(age_pr, age, status) ~ 
                        Agr_CZ
                      + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ
                      ,cluster="sample" 
                      , frailty = 'gamma'
                      , data=datX[datX$sex==0,], dist='gompertz', method ='ucminf')
pf.r.o.x.gm.f = parfm(Surv(age_pr, age, status) ~ 
                        as.factor(origin) + Agr_CZ
                      + D.r2.DoB + E.r2.DoB + Con_CZ + N.r1.DoB + O.r2.DoB
                      ,cluster="sample" 
                      , frailty = 'gamma'
                      , data=datX[datX$sex==0,], dist='gompertz', method ='ucminf')
pf.r.x.x.gm.f = parfm(Surv(age_pr, age, status) ~ 
                        Agr_CZ
                      + D.r2.DoB + E.r2.DoB + Con_CZ + N.r1.DoB + O.r2.DoB
                      ,cluster="sample" 
                      , frailty = 'gamma'
                      , data=datX[datX$sex==0,], dist='gompertz', method ='ucminf')







### Model averaged parameter tables


### MALES
LLv.u.m = c(pf.u.o.x.wb.m$logLik,pf.u.o.x.pwp.m$logLik,logLik(pf.u.o.x.gm.m)[1],
            pf.u.x.x.wb.m$logLik,pf.u.x.x.pwp.m$logLik,logLik(pf.u.x.x.gm.m)[1])
LLv.r.m = c(pf.r.o.x.wb.m$logLik,pf.r.o.x.pwp.m$logLik,logLik(pf.r.o.x.gm.m)[1],
            pf.r.x.x.wb.m$logLik,pf.r.x.x.pwp.m$logLik,logLik(pf.r.x.x.gm.m)[1])

Kv.u.m = c(pf.u.o.x.wb.m$npar,pf.u.o.x.pwp.m$npar,attr(logLik(pf.u.o.x.gm.m),'df'),
           pf.u.x.x.wb.m$npar,pf.u.x.x.pwp.m$npar,attr(logLik(pf.u.x.x.gm.m),'df'))
Kv.r.m = c(pf.r.o.x.wb.m$npar,pf.r.o.x.pwp.m$npar,attr(logLik(pf.r.o.x.gm.m),'df'),
           pf.r.x.x.wb.m$npar,pf.r.x.x.pwp.m$npar,attr(logLik(pf.r.x.x.gm.m),'df'))

mnv.u.m = c('pf.u.o.x.wb.m','pf.u.o.x.pwp.m','pf.u.o.x.gm.m',
            'pf.u.x.x.wb.m','pf.u.x.x.pwp.m','pf.u.x.x.gm.m')
mnv.r.m = c('pf.r.o.x.wb.m','pf.r.o.x.pwp.m','pf.r.o.x.gm.m',
            'pf.r.x.x.wb.m','pf.r.x.x.pwp.m','pf.r.x.x.gm.m')


### Wild

estv.u.m.or = c(pf.u.o.x.wb.m$coef['originWILD'],pf.u.o.x.pwp.m$coef['originWILD'],coef(pf.u.o.x.gm.m)['as.factor(origin)WILD'])
estv.r.m.or = c(pf.r.o.x.wb.m$coef['originWILD'],pf.r.o.x.pwp.m$coef['originWILD'],coef(pf.r.o.x.gm.m)['as.factor(origin)WILD'])
ind = 2
sev.u.m.or=c(sqrt(diag(pf.u.o.x.wb.m$varH))[ind-1],sqrt(diag(pf.u.o.x.pwp.m$varH))[ind-1],pf.u.o.x.gm.m[ind+2,'SE'])
sev.r.m.or=c(sqrt(diag(pf.r.o.x.wb.m$varH))[ind-1],sqrt(diag(pf.r.o.x.pwp.m$varH))[ind-1],pf.r.o.x.gm.m[ind+2,'SE'])

mavg.u.W.m = modavgCustom(LLv.u.m[1:3],Kv.u.m[1:3],mnv.u.m[1:3],estv.u.m.or,sev.u.m.or,second.ord=F)
exp(mavg.u.W.m$Mod.avg.est)
exp(mavg.u.W.m$Lower.CL)
exp(mavg.u.W.m$Upper.CL)
mavg.r.W.m = modavgCustom(LLv.r.m[1:3],Kv.r.m[1:3],mnv.r.m[1:3],estv.r.m.or,sev.r.m.or,second.ord=F)
exp(mavg.r.W.m$Mod.avg.est)
exp(mavg.r.W.m$Lower.CL)
exp(mavg.r.W.m$Upper.CL)


### Agr

estv.u.m.A = c(pf.u.o.x.wb.m$coef['Agr_CZ'],pf.u.o.x.pwp.m$coef['Agr_CZ'],coef(pf.u.o.x.gm.m)['Agr_CZ'],
               pf.u.x.x.wb.m$coef['Agr_CZ'],pf.u.x.x.pwp.m$coef['Agr_CZ'],coef(pf.u.x.x.gm.m)['Agr_CZ'])
estv.r.m.A = c(pf.r.o.x.wb.m$coef['Agr_CZ'],pf.r.o.x.pwp.m$coef['Agr_CZ'],coef(pf.r.o.x.gm.m)['Agr_CZ'],
               pf.r.x.x.wb.m$coef['Agr_CZ'],pf.r.x.x.pwp.m$coef['Agr_CZ'],coef(pf.r.x.x.gm.m)['Agr_CZ'])
ind = 3
sev.u.m.A=c(sqrt(diag(pf.u.o.x.wb.m$varH))[ind-1],sqrt(diag(pf.u.o.x.pwp.m$varH))[ind-1],pf.u.o.x.gm.m[ind+2,'SE'],
            sqrt(diag(pf.u.x.x.wb.m$varH))[ind-2],sqrt(diag(pf.u.x.x.pwp.m$varH))[ind-2],pf.u.x.x.gm.m[ind+1,'SE'])
sev.r.m.A=c(sqrt(diag(pf.r.o.x.wb.m$varH))[ind-1],sqrt(diag(pf.r.o.x.pwp.m$varH))[ind-1],pf.r.o.x.gm.m[ind+2,'SE'],
            sqrt(diag(pf.r.x.x.wb.m$varH))[ind-2],sqrt(diag(pf.r.x.x.pwp.m$varH))[ind-2],pf.r.x.x.gm.m[ind+1,'SE'])

mavg.u.A.m = modavgCustom(LLv.u.m,Kv.u.m,mnv.u.m,estv.u.m.A,sev.u.m.A,second.ord=F)
exp(mavg.u.A.m$Mod.avg.est)
exp(mavg.u.A.m$Lower.CL)
exp(mavg.u.A.m$Upper.CL)
mavg.r.A.m = modavgCustom(LLv.r.m,Kv.r.m,mnv.r.m,estv.r.m.A,sev.r.m.A,second.ord=F)
exp(mavg.r.A.m$Mod.avg.est)
exp(mavg.r.A.m$Lower.CL)
exp(mavg.r.A.m$Upper.CL)


### Dom

estv.u.m.D = c(pf.u.o.x.wb.m$coef['Dom_CZ'],pf.u.o.x.pwp.m$coef['Dom_CZ'],coef(pf.u.o.x.gm.m)['Dom_CZ'],
               pf.u.x.x.wb.m$coef['Dom_CZ'],pf.u.x.x.pwp.m$coef['Dom_CZ'],coef(pf.u.x.x.gm.m)['Dom_CZ'])
estv.r.m.D = c(pf.r.o.x.wb.m$coef['D.r2.DoB'],pf.r.o.x.pwp.m$coef['D.r2.DoB'],coef(pf.r.o.x.gm.m)['D.r2.DoB'],
               pf.r.x.x.wb.m$coef['D.r2.DoB'],pf.r.x.x.pwp.m$coef['D.r2.DoB'],coef(pf.r.x.x.gm.m)['D.r2.DoB'])
ind = 4
sev.u.m.D=c(sqrt(diag(pf.u.o.x.wb.m$varH))[ind-1],sqrt(diag(pf.u.o.x.pwp.m$varH))[ind-1],pf.u.o.x.gm.m[ind+2,'SE'],
            sqrt(diag(pf.u.x.x.wb.m$varH))[ind-2],sqrt(diag(pf.u.x.x.pwp.m$varH))[ind-2],pf.u.x.x.gm.m[ind+1,'SE'])
sev.r.m.D=c(sqrt(diag(pf.r.o.x.wb.m$varH))[ind-1],sqrt(diag(pf.r.o.x.pwp.m$varH))[ind-1],pf.r.o.x.gm.m[ind+2,'SE'],
            sqrt(diag(pf.r.x.x.wb.m$varH))[ind-2],sqrt(diag(pf.r.x.x.pwp.m$varH))[ind-2],pf.r.x.x.gm.m[ind+1,'SE'])

mavg.u.D.m = modavgCustom(LLv.u.m,Kv.u.m,mnv.u.m,estv.u.m.D,sev.u.m.D,second.ord=F)
exp(mavg.u.D.m$Mod.avg.est)
exp(mavg.u.D.m$Lower.CL)
exp(mavg.u.D.m$Upper.CL)
mavg.r.D.m = modavgCustom(LLv.r.m,Kv.r.m,mnv.r.m,estv.r.m.D,sev.r.m.D,second.ord=F)
exp(mavg.r.D.m$Mod.avg.est)
exp(mavg.r.D.m$Lower.CL)
exp(mavg.r.D.m$Upper.CL)


### Ext

estv.u.m.E = c(pf.u.o.x.wb.m$coef['Ext_CZ'],pf.u.o.x.pwp.m$coef['Ext_CZ'],coef(pf.u.o.x.gm.m)['Ext_CZ'],
               pf.u.x.x.wb.m$coef['Ext_CZ'],pf.u.x.x.pwp.m$coef['Ext_CZ'],coef(pf.u.x.x.gm.m)['Ext_CZ'])
estv.r.m.E = c(pf.r.o.x.wb.m$coef['E.r2.DoB'],pf.r.o.x.pwp.m$coef['E.r2.DoB'],coef(pf.r.o.x.gm.m)['E.r2.DoB'],
               pf.r.x.x.wb.m$coef['E.r2.DoB'],pf.r.x.x.pwp.m$coef['E.r2.DoB'],coef(pf.r.x.x.gm.m)['E.r2.DoB'])
ind = 5
sev.u.m.E=c(sqrt(diag(pf.u.o.x.wb.m$varH))[ind-1],sqrt(diag(pf.u.o.x.pwp.m$varH))[ind-1],pf.u.o.x.gm.m[ind+2,'SE'],
            sqrt(diag(pf.u.x.x.wb.m$varH))[ind-2],sqrt(diag(pf.u.x.x.pwp.m$varH))[ind-2],pf.u.x.x.gm.m[ind+1,'SE'])
sev.r.m.E=c(sqrt(diag(pf.r.o.x.wb.m$varH))[ind-1],sqrt(diag(pf.r.o.x.pwp.m$varH))[ind-1],pf.r.o.x.gm.m[ind+2,'SE'],
            sqrt(diag(pf.r.x.x.wb.m$varH))[ind-2],sqrt(diag(pf.r.x.x.pwp.m$varH))[ind-2],pf.r.x.x.gm.m[ind+1,'SE'])
mavg.u.E.m = modavgCustom(LLv.u.m,Kv.u.m,mnv.u.m,estv.u.m.E,sev.u.m.E,second.ord=F)
exp(mavg.u.E.m$Mod.avg.est)
exp(mavg.u.E.m$Lower.CL)
exp(mavg.u.E.m$Upper.CL)
mavg.r.E.m = modavgCustom(LLv.r.m,Kv.r.m,mnv.r.m,estv.r.m.E,sev.r.m.E,second.ord=F)
exp(mavg.r.E.m$Mod.avg.est)
exp(mavg.r.E.m$Lower.CL)
exp(mavg.r.E.m$Upper.CL)


### Con

estv.u.m.C = c(pf.u.o.x.wb.m$coef['Con_CZ'],pf.u.o.x.pwp.m$coef['Con_CZ'],coef(pf.u.o.x.gm.m)['Con_CZ'],
               pf.u.x.x.wb.m$coef['Con_CZ'],pf.u.x.x.pwp.m$coef['Con_CZ'],coef(pf.u.x.x.gm.m)['Con_CZ'])
estv.r.m.C = c(pf.r.o.x.wb.m$coef['Con_CZ'],pf.r.o.x.pwp.m$coef['Con_CZ'],coef(pf.r.o.x.gm.m)['Con_CZ'],
               pf.r.x.x.wb.m$coef['Con_CZ'],pf.r.x.x.pwp.m$coef['Con_CZ'],coef(pf.r.x.x.gm.m)['Con_CZ'])
ind = 6
sev.u.m.C=c(sqrt(diag(pf.u.o.x.wb.m$varH))[ind-1],sqrt(diag(pf.u.o.x.pwp.m$varH))[ind-1],pf.u.o.x.gm.m[ind+2,'SE'],
            sqrt(diag(pf.u.x.x.wb.m$varH))[ind-2],sqrt(diag(pf.u.x.x.pwp.m$varH))[ind-2],pf.u.x.x.gm.m[ind+1,'SE'])
sev.r.m.C=c(sqrt(diag(pf.r.o.x.wb.m$varH))[ind-1],sqrt(diag(pf.r.o.x.pwp.m$varH))[ind-1],pf.r.o.x.gm.m[ind+2,'SE'],
            sqrt(diag(pf.r.x.x.wb.m$varH))[ind-2],sqrt(diag(pf.r.x.x.pwp.m$varH))[ind-2],pf.r.x.x.gm.m[ind+1,'SE'])
mavg.u.C.m = modavgCustom(LLv.u.m,Kv.u.m,mnv.u.m,estv.u.m.C,sev.u.m.C,second.ord=F)
exp(mavg.u.C.m$Mod.avg.est)
exp(mavg.u.C.m$Lower.CL)
exp(mavg.u.C.m$Upper.CL)
mavg.r.C.m = modavgCustom(LLv.r.m,Kv.r.m,mnv.r.m,estv.r.m.C,sev.r.m.C,second.ord=F)
exp(mavg.r.C.m$Mod.avg.est)
exp(mavg.r.C.m$Lower.CL)
exp(mavg.r.C.m$Upper.CL)


### Neu

estv.u.m.N = c(pf.u.o.x.wb.m$coef['Neu_CZ'],pf.u.o.x.pwp.m$coef['Neu_CZ'],coef(pf.u.o.x.gm.m)['Neu_CZ'],
               pf.u.x.x.wb.m$coef['Neu_CZ'],pf.u.x.x.pwp.m$coef['Neu_CZ'],coef(pf.u.x.x.gm.m)['Neu_CZ'])
estv.r.m.N = c(pf.r.o.x.wb.m$coef['N.r1.DoB'],pf.r.o.x.pwp.m$coef['N.r1.DoB'],coef(pf.r.o.x.gm.m)['N.r1.DoB'],
               pf.r.x.x.wb.m$coef['N.r1.DoB'],pf.r.x.x.pwp.m$coef['N.r1.DoB'],coef(pf.r.x.x.gm.m)['N.r1.DoB'])
ind = 7
sev.u.m.N=c(sqrt(diag(pf.u.o.x.wb.m$varH))[ind-1],sqrt(diag(pf.u.o.x.pwp.m$varH))[ind-1],pf.u.o.x.gm.m[ind+2,'SE'],
            sqrt(diag(pf.u.x.x.wb.m$varH))[ind-2],sqrt(diag(pf.u.x.x.pwp.m$varH))[ind-2],pf.u.x.x.gm.m[ind+1,'SE'])
sev.r.m.N=c(sqrt(diag(pf.r.o.x.wb.m$varH))[ind-1],sqrt(diag(pf.r.o.x.pwp.m$varH))[ind-1],pf.r.o.x.gm.m[ind+2,'SE'],
            sqrt(diag(pf.r.x.x.wb.m$varH))[ind-2],sqrt(diag(pf.r.x.x.pwp.m$varH))[ind-2],pf.r.x.x.gm.m[ind+1,'SE'])

mavg.u.N.m = modavgCustom(LLv.u.m,Kv.u.m,mnv.u.m,estv.u.m.N,sev.u.m.N,second.ord=F)
exp(mavg.u.N.m$Mod.avg.est)
exp(mavg.u.N.m$Lower.CL)
exp(mavg.u.N.m$Upper.CL)

mavg.r.N.m = modavgCustom(LLv.r.m,Kv.r.m,mnv.r.m,estv.r.m.N,sev.r.m.N,second.ord=F)
exp(mavg.r.N.m$Mod.avg.est)
exp(mavg.r.N.m$Lower.CL)
exp(mavg.r.N.m$Upper.CL)


### Opn

estv.u.m.O = c(pf.u.o.x.wb.m$coef['Opn_CZ'],pf.u.o.x.pwp.m$coef['Opn_CZ'],coef(pf.u.o.x.gm.m)['Opn_CZ'],
               pf.u.x.x.wb.m$coef['Opn_CZ'],pf.u.x.x.pwp.m$coef['Opn_CZ'],coef(pf.u.x.x.gm.m)['Opn_CZ'])
estv.r.m.O = c(pf.r.o.x.wb.m$coef['O.r2.DoB'],pf.r.o.x.pwp.m$coef['O.r2.DoB'],coef(pf.r.o.x.gm.m)['O.r2.DoB'],
               pf.r.x.x.wb.m$coef['O.r2.DoB'],pf.r.x.x.pwp.m$coef['O.r2.DoB'],coef(pf.r.x.x.gm.m)['O.r2.DoB'])
ind = 8
sev.u.m.O=c(sqrt(diag(pf.u.o.x.wb.m$varH))[ind-1],sqrt(diag(pf.u.o.x.pwp.m$varH))[ind-1],pf.u.o.x.gm.m[ind+2,'SE'],
            sqrt(diag(pf.u.x.x.wb.m$varH))[ind-2],sqrt(diag(pf.u.x.x.pwp.m$varH))[ind-2],pf.u.x.x.gm.m[ind+1,'SE'])
sev.r.m.O=c(sqrt(diag(pf.r.o.x.wb.m$varH))[ind-1],sqrt(diag(pf.r.o.x.pwp.m$varH))[ind-1],pf.r.o.x.gm.m[ind+2,'SE'],
            sqrt(diag(pf.r.x.x.wb.m$varH))[ind-2],sqrt(diag(pf.r.x.x.pwp.m$varH))[ind-2],pf.r.x.x.gm.m[ind+1,'SE'])

mavg.u.O.m = modavgCustom(LLv.u.m,Kv.u.m,mnv.u.m,estv.u.m.O,sev.u.m.O,second.ord=F)
exp(mavg.u.O.m$Mod.avg.est)
exp(mavg.u.O.m$Lower.CL)
exp(mavg.u.O.m$Upper.CL)
mavg.r.O.m = modavgCustom(LLv.r.m,Kv.r.m,mnv.r.m,estv.r.m.O,sev.r.m.O,second.ord=F)
exp(mavg.r.O.m$Mod.avg.est)
exp(mavg.r.O.m$Lower.CL)
exp(mavg.r.O.m$Upper.CL)



### FEMALES

LLv.u.f = c(pf.u.o.x.wb.f$logLik,pf.u.o.x.pwp.f$logLik,logLik(pf.u.o.x.gm.f)[1],
            pf.u.x.x.wb.f$logLik,pf.u.x.x.pwp.f$logLik,logLik(pf.u.x.x.gm.f)[1])
LLv.r.f = c(pf.r.o.x.wb.f$logLik,pf.r.o.x.pwp.f$logLik,logLik(pf.r.o.x.gm.f)[1],
            pf.r.x.x.wb.f$logLik,pf.r.x.x.pwp.f$logLik,logLik(pf.r.x.x.gm.f)[1])

Kv.u.f = c(pf.u.o.x.wb.f$npar,pf.u.o.x.pwp.f$npar,attr(logLik(pf.u.o.x.gm.f),'df'),
           pf.u.x.x.wb.f$npar,pf.u.x.x.pwp.f$npar,attr(logLik(pf.u.x.x.gm.f),'df'))
Kv.r.f = c(pf.r.o.x.wb.f$npar,pf.r.o.x.pwp.f$npar,attr(logLik(pf.r.o.x.gm.f),'df'),
           pf.r.x.x.wb.f$npar,pf.r.x.x.pwp.f$npar,attr(logLik(pf.r.x.x.gm.f),'df'))

mnv.u.f = c('pf.u.o.x.wb.f','pf.u.o.x.pwp.f','pf.u.o.x.gm.f',
            'pf.u.x.x.wb.f','pf.u.x.x.pwp.f','pf.u.x.x.gm.f')
mnv.r.f = c('pf.r.o.x.wb.f','pf.r.o.x.pwp.f','pf.r.o.x.gm.f',
            'pf.r.x.x.wb.f','pf.r.x.x.pwp.f','pf.r.x.x.gm.f')

### Wild

estv.u.f.or = c(pf.u.o.x.wb.f$coef['originWILD'],pf.u.o.x.pwp.f$coef['originWILD'],coef(pf.u.o.x.gm.f)['as.factor(origin)WILD'])
estv.r.f.or = c(pf.r.o.x.wb.f$coef['originWILD'],pf.r.o.x.pwp.f$coef['originWILD'],coef(pf.r.o.x.gm.f)['as.factor(origin)WILD'])
ind = 2
sev.u.f.or=c(sqrt(diag(pf.u.o.x.wb.f$varH))[ind-1],sqrt(diag(pf.u.o.x.pwp.f$varH))[ind-1],pf.u.o.x.gm.f[ind+2,'SE'])
sev.r.f.or=c(sqrt(diag(pf.r.o.x.wb.f$varH))[ind-1],sqrt(diag(pf.r.o.x.pwp.f$varH))[ind-1],pf.r.o.x.gm.f[ind+2,'SE'])

mavg.u.W.f = modavgCustom(LLv.u.f[1:3],Kv.u.f[1:3],mnv.u.f[1:3],estv.u.f.or,sev.u.f.or,second.ord=F)
exp(mavg.u.W.f$Mod.avg.est)
exp(mavg.u.W.f$Lower.CL)
exp(mavg.u.W.f$Upper.CL)
mavg.r.W.f = modavgCustom(LLv.r.f[1:3],Kv.r.f[1:3],mnv.r.f[1:3],estv.r.f.or,sev.r.f.or,second.ord=F)
exp(mavg.r.W.f$Mod.avg.est)
exp(mavg.r.W.f$Lower.CL)
exp(mavg.r.W.f$Upper.CL)


### Agr

estv.u.f.A = c(pf.u.o.x.wb.f$coef['Agr_CZ'],pf.u.o.x.pwp.f$coef['Agr_CZ'],coef(pf.u.o.x.gm.f)['Agr_CZ'],
               pf.u.x.x.wb.f$coef['Agr_CZ'],pf.u.x.x.pwp.f$coef['Agr_CZ'],coef(pf.u.x.x.gm.f)['Agr_CZ'])
estv.r.f.A = c(pf.r.o.x.wb.f$coef['Agr_CZ'],pf.r.o.x.pwp.f$coef['Agr_CZ'],coef(pf.r.o.x.gm.f)['Agr_CZ'],
               pf.r.x.x.wb.f$coef['Agr_CZ'],pf.r.x.x.pwp.f$coef['Agr_CZ'],coef(pf.r.x.x.gm.f)['Agr_CZ'])
ind = 3
sev.u.f.A=c(sqrt(diag(pf.u.o.x.wb.f$varH))[ind-1],sqrt(diag(pf.u.o.x.pwp.f$varH))[ind-1],pf.u.o.x.gm.f[ind+2,'SE'],
            sqrt(diag(pf.u.x.x.wb.f$varH))[ind-2],sqrt(diag(pf.u.x.x.pwp.f$varH))[ind-2],pf.u.x.x.gm.f[ind+1,'SE'])
sev.r.f.A=c(sqrt(diag(pf.r.o.x.wb.f$varH))[ind-1],sqrt(diag(pf.r.o.x.pwp.f$varH))[ind-1],pf.r.o.x.gm.f[ind+2,'SE'],
            sqrt(diag(pf.r.x.x.wb.f$varH))[ind-2],sqrt(diag(pf.r.x.x.pwp.f$varH))[ind-2],pf.r.x.x.gm.f[ind+1,'SE'])

mavg.u.A.f = modavgCustom(LLv.u.f,Kv.u.f,mnv.u.f,estv.u.f.A,sev.u.f.A,second.ord=F)
exp(mavg.u.A.f$Mod.avg.est)
exp(mavg.u.A.f$Lower.CL)
exp(mavg.u.A.f$Upper.CL)
mavg.r.A.f = modavgCustom(LLv.r.f,Kv.r.f,mnv.r.f,estv.r.f.A,sev.r.f.A,second.ord=F)
exp(mavg.r.A.f$Mod.avg.est)
exp(mavg.r.A.f$Lower.CL)
exp(mavg.r.A.f$Upper.CL)


### Dom

estv.u.f.D = c(pf.u.o.x.wb.f$coef['Dom_CZ'],pf.u.o.x.pwp.f$coef['Dom_CZ'],coef(pf.u.o.x.gm.f)['Dom_CZ'],
               pf.u.x.x.wb.f$coef['Dom_CZ'],pf.u.x.x.pwp.f$coef['Dom_CZ'],coef(pf.u.x.x.gm.f)['Dom_CZ'])
estv.r.f.D = c(pf.r.o.x.wb.f$coef['D.r2.DoB'],pf.r.o.x.pwp.f$coef['D.r2.DoB'],coef(pf.r.o.x.gm.f)['D.r2.DoB'],
               pf.r.x.x.wb.f$coef['D.r2.DoB'],pf.r.x.x.pwp.f$coef['D.r2.DoB'],coef(pf.r.x.x.gm.f)['D.r2.DoB'])
ind = 4
sev.u.f.D=c(sqrt(diag(pf.u.o.x.wb.f$varH))[ind-1],sqrt(diag(pf.u.o.x.pwp.f$varH))[ind-1],pf.u.o.x.gm.f[ind+2,'SE'],
            sqrt(diag(pf.u.x.x.wb.f$varH))[ind-2],sqrt(diag(pf.u.x.x.pwp.f$varH))[ind-2],pf.u.x.x.gm.f[ind+1,'SE'])
sev.r.f.D=c(sqrt(diag(pf.r.o.x.wb.f$varH))[ind-1],sqrt(diag(pf.r.o.x.pwp.f$varH))[ind-1],pf.r.o.x.gm.f[ind+2,'SE'],
            sqrt(diag(pf.r.x.x.wb.f$varH))[ind-2],sqrt(diag(pf.r.x.x.pwp.f$varH))[ind-2],pf.r.x.x.gm.f[ind+1,'SE'])

mavg.u.D.f = modavgCustom(LLv.u.f,Kv.u.f,mnv.u.f,estv.u.f.D,sev.u.f.D,second.ord=F)
exp(mavg.u.D.f$Mod.avg.est)
exp(mavg.u.D.f$Lower.CL)
exp(mavg.u.D.f$Upper.CL)
mavg.r.D.f = modavgCustom(LLv.r.f,Kv.r.f,mnv.r.f,estv.r.f.D,sev.r.f.D,second.ord=F)
exp(mavg.r.D.f$Mod.avg.est)
exp(mavg.r.D.f$Lower.CL)
exp(mavg.r.D.f$Upper.CL)


### Ext

estv.u.f.E = c(pf.u.o.x.wb.f$coef['Ext_CZ'],pf.u.o.x.pwp.f$coef['Ext_CZ'],coef(pf.u.o.x.gm.f)['Ext_CZ'],
               pf.u.x.x.wb.f$coef['Ext_CZ'],pf.u.x.x.pwp.f$coef['Ext_CZ'],coef(pf.u.x.x.gm.f)['Ext_CZ'])
estv.r.f.E = c(pf.r.o.x.wb.f$coef['E.r2.DoB'],pf.r.o.x.pwp.f$coef['E.r2.DoB'],coef(pf.r.o.x.gm.f)['E.r2.DoB'],
               pf.r.x.x.wb.f$coef['E.r2.DoB'],pf.r.x.x.pwp.f$coef['E.r2.DoB'],coef(pf.r.x.x.gm.f)['E.r2.DoB'])
ind = 5
sev.u.f.E=c(sqrt(diag(pf.u.o.x.wb.f$varH))[ind-1],sqrt(diag(pf.u.o.x.pwp.f$varH))[ind-1],pf.u.o.x.gm.f[ind+2,'SE'],
            sqrt(diag(pf.u.x.x.wb.f$varH))[ind-2],sqrt(diag(pf.u.x.x.pwp.f$varH))[ind-2],pf.u.x.x.gm.f[ind+1,'SE'])
sev.r.f.E=c(sqrt(diag(pf.r.o.x.wb.f$varH))[ind-1],sqrt(diag(pf.r.o.x.pwp.f$varH))[ind-1],pf.r.o.x.gm.f[ind+2,'SE'],
            sqrt(diag(pf.r.x.x.wb.f$varH))[ind-2],sqrt(diag(pf.r.x.x.pwp.f$varH))[ind-2],pf.r.x.x.gm.f[ind+1,'SE'])

mavg.u.E.f = modavgCustom(LLv.u.f,Kv.u.f,mnv.u.f,estv.u.f.E,sev.u.f.E,second.ord=F)
exp(mavg.u.E.f$Mod.avg.est)
exp(mavg.u.E.f$Lower.CL)
exp(mavg.u.E.f$Upper.CL)
mavg.r.E.f = modavgCustom(LLv.r.f,Kv.r.f,mnv.r.f,estv.r.f.E,sev.r.f.E,second.ord=F)
exp(mavg.r.E.f$Mod.avg.est)
exp(mavg.r.E.f$Lower.CL)
exp(mavg.r.E.f$Upper.CL)


### Con

estv.u.f.C = c(pf.u.o.x.wb.f$coef['Con_CZ'],pf.u.o.x.pwp.f$coef['Con_CZ'],coef(pf.u.o.x.gm.f)['Con_CZ'],
               pf.u.x.x.wb.f$coef['Con_CZ'],pf.u.x.x.pwp.f$coef['Con_CZ'],coef(pf.u.x.x.gm.f)['Con_CZ'])
estv.r.f.C = c(pf.r.o.x.wb.f$coef['Con_CZ'],pf.r.o.x.pwp.f$coef['Con_CZ'],coef(pf.r.o.x.gm.f)['Con_CZ'],
               pf.r.x.x.wb.f$coef['Con_CZ'],pf.r.x.x.pwp.f$coef['Con_CZ'],coef(pf.r.x.x.gm.f)['Con_CZ'])
ind = 6
sev.u.f.C=c(sqrt(diag(pf.u.o.x.wb.f$varH))[ind-1],sqrt(diag(pf.u.o.x.pwp.f$varH))[ind-1],pf.u.o.x.gm.f[ind+2,'SE'],
            sqrt(diag(pf.u.x.x.wb.f$varH))[ind-2],sqrt(diag(pf.u.x.x.pwp.f$varH))[ind-2],pf.u.x.x.gm.f[ind+1,'SE'])
sev.r.f.C=c(sqrt(diag(pf.r.o.x.wb.f$varH))[ind-1],sqrt(diag(pf.r.o.x.pwp.f$varH))[ind-1],pf.r.o.x.gm.f[ind+2,'SE'],
            sqrt(diag(pf.r.x.x.wb.f$varH))[ind-2],sqrt(diag(pf.r.x.x.pwp.f$varH))[ind-2],pf.r.x.x.gm.f[ind+1,'SE'])

mavg.u.C.f = modavgCustom(LLv.u.f,Kv.u.f,mnv.u.f,estv.u.f.C,sev.u.f.C,second.ord=F)
exp(mavg.u.C.f$Mod.avg.est)
exp(mavg.u.C.f$Lower.CL)
exp(mavg.u.C.f$Upper.CL)
mavg.r.C.f = modavgCustom(LLv.r.f,Kv.r.f,mnv.r.f,estv.r.f.C,sev.r.f.C,second.ord=F)
exp(mavg.r.C.f$Mod.avg.est)
exp(mavg.r.C.f$Lower.CL)
exp(mavg.r.C.f$Upper.CL)


### Neu

estv.u.f.N = c(pf.u.o.x.wb.f$coef['Neu_CZ'],pf.u.o.x.pwp.f$coef['Neu_CZ'],coef(pf.u.o.x.gm.f)['Neu_CZ'],
               pf.u.x.x.wb.f$coef['Neu_CZ'],pf.u.x.x.pwp.f$coef['Neu_CZ'],coef(pf.u.x.x.gm.f)['Neu_CZ'])
estv.r.f.N = c(pf.r.o.x.wb.f$coef['N.r1.DoB'],pf.r.o.x.pwp.f$coef['N.r1.DoB'],coef(pf.r.o.x.gm.f)['N.r1.DoB'],
               pf.r.x.x.wb.f$coef['N.r1.DoB'],pf.r.x.x.pwp.f$coef['N.r1.DoB'],coef(pf.r.x.x.gm.f)['N.r1.DoB'])
ind = 7
sev.u.f.N=c(sqrt(diag(pf.u.o.x.wb.f$varH))[ind-1],sqrt(diag(pf.u.o.x.pwp.f$varH))[ind-1],pf.u.o.x.gm.f[ind+2,'SE'],
            sqrt(diag(pf.u.x.x.wb.f$varH))[ind-2],sqrt(diag(pf.u.x.x.pwp.f$varH))[ind-2],pf.u.x.x.gm.f[ind+1,'SE'])
sev.r.f.N=c(sqrt(diag(pf.r.o.x.wb.f$varH))[ind-1],sqrt(diag(pf.r.o.x.pwp.f$varH))[ind-1],pf.r.o.x.gm.f[ind+2,'SE'],
            sqrt(diag(pf.r.x.x.wb.f$varH))[ind-2],sqrt(diag(pf.r.x.x.pwp.f$varH))[ind-2],pf.r.x.x.gm.f[ind+1,'SE'])

mavg.u.N.f = modavgCustom(LLv.u.f,Kv.u.f,mnv.u.f,estv.u.f.N,sev.u.f.N,second.ord=F)
exp(mavg.u.N.f$Mod.avg.est)
exp(mavg.u.N.f$Lower.CL)
exp(mavg.u.N.f$Upper.CL)
mavg.r.N.f = modavgCustom(LLv.r.f,Kv.r.f,mnv.r.f,estv.r.f.N,sev.r.f.N,second.ord=F)
exp(mavg.r.N.f$Mod.avg.est)
exp(mavg.r.N.f$Lower.CL)
exp(mavg.r.N.f$Upper.CL)


### Opn

estv.u.f.O = c(pf.u.o.x.wb.f$coef['Opn_CZ'],pf.u.o.x.pwp.f$coef['Opn_CZ'],coef(pf.u.o.x.gm.f)['Opn_CZ'],
               pf.u.x.x.wb.f$coef['Opn_CZ'],pf.u.x.x.pwp.f$coef['Opn_CZ'],coef(pf.u.x.x.gm.f)['Opn_CZ'])
estv.r.f.O = c(pf.r.o.x.wb.f$coef['O.r2.DoB'],pf.r.o.x.pwp.f$coef['O.r2.DoB'],coef(pf.r.o.x.gm.f)['O.r2.DoB'],
               pf.r.x.x.wb.f$coef['O.r2.DoB'],pf.r.x.x.pwp.f$coef['O.r2.DoB'],coef(pf.r.x.x.gm.f)['O.r2.DoB'])
ind = 8
sev.u.f.O=c(sqrt(diag(pf.u.o.x.wb.f$varH))[ind-1],sqrt(diag(pf.u.o.x.pwp.f$varH))[ind-1],pf.u.o.x.gm.f[ind+2,'SE'],
            sqrt(diag(pf.u.x.x.wb.f$varH))[ind-2],sqrt(diag(pf.u.x.x.pwp.f$varH))[ind-2],pf.u.x.x.gm.f[ind+1,'SE'])
sev.r.f.O=c(sqrt(diag(pf.r.o.x.wb.f$varH))[ind-1],sqrt(diag(pf.r.o.x.pwp.f$varH))[ind-1],pf.r.o.x.gm.f[ind+2,'SE'],
            sqrt(diag(pf.r.x.x.wb.f$varH))[ind-2],sqrt(diag(pf.r.x.x.pwp.f$varH))[ind-2],pf.r.x.x.gm.f[ind+1,'SE'])

mavg.u.O.f = modavgCustom(LLv.u.f,Kv.u.f,mnv.u.f,estv.u.f.O,sev.u.f.O,second.ord=F)
exp(mavg.u.O.f$Mod.avg.est)
exp(mavg.u.O.f$Lower.CL)
exp(mavg.u.O.f$Upper.CL)
mavg.r.O.f = modavgCustom(LLv.r.f,Kv.r.f,mnv.r.f,estv.r.f.O,sev.r.f.O,second.ord=F)
exp(mavg.r.O.f$Mod.avg.est)
exp(mavg.r.O.f$Lower.CL)
exp(mavg.r.O.f$Upper.CL)





  




