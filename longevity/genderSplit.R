### Gender split







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

# to gamma or logN?
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
                             RandDist = 'LogN'
                             ,data=datX[datX$sex==0,], hazard =  'Weibull' 
)
pf.u.o.x.wb.f = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                               as.factor(origin) +  
                               Agr_CZ + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ,
                             RandDist = 'LogN'
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



### Origin

estv.u.m.or = c(pf.u.o.x.wb.m$coef['originWILD'],pf.u.o.x.pwp.m$coef['originWILD'],coef(pf.u.o.x.gm.m)['as.factor(origin)WILD'])
estv.r.m.or = c(pf.r.o.x.wb.m$coef['originWILD'],pf.r.o.x.pwp.m$coef['originWILD'],coef(pf.r.o.x.gm.m)['as.factor(origin)WILD'])
ind = 2
sev.u.m.or=c(sqrt(diag(pf.u.o.x.wb.m$varH))[ind-1],sqrt(diag(pf.u.o.x.pwp.m$varH))[ind-1],pf.u.o.x.gm.m[ind+2,'SE'])
sev.r.m.or=c(sqrt(diag(pf.r.o.x.wb.m$varH))[ind-1],sqrt(diag(pf.r.o.x.pwp.m$varH))[ind-1],pf.r.o.x.gm.m[ind+2,'SE'])
modavgCustom(LLv.u.m[1:3],Kv.u.m[1:3],mnv.u.m[1:3],estv.u.m.or,sev.u.m.or,second.ord=F)
modavgCustom(LLv.r.m[1:3],Kv.r.m[1:3],mnv.r.m[1:3],estv.r.m.or,sev.r.m.or,second.ord=F)


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
modavgCustom(LLv.u.m,Kv.u.m,mnv.u.m,estv.u.m.A,sev.u.m.A,second.ord=F)
modavgCustom(LLv.r.m,Kv.r.m,mnv.r.m,estv.r.m.A,sev.r.m.A,second.ord=F)


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
modavgCustom(LLv.u.m,Kv.u.m,mnv.u.m,estv.u.m.D,sev.u.m.D,second.ord=F)
modavgCustom(LLv.r.m,Kv.r.m,mnv.r.m,estv.r.m.D,sev.r.m.D,second.ord=F)


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
modavgCustom(LLv.u.m,Kv.u.m,mnv.u.m,estv.u.m.E,sev.u.m.E,second.ord=F)
modavgCustom(LLv.r.m,Kv.r.m,mnv.r.m,estv.r.m.E,sev.r.m.E,second.ord=F)


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
modavgCustom(LLv.u.m,Kv.u.m,mnv.u.m,estv.u.m.C,sev.u.m.C,second.ord=F)
modavgCustom(LLv.r.m,Kv.r.m,mnv.r.m,estv.r.m.C,sev.r.m.C,second.ord=F)


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
modavgCustom(LLv.u.m,Kv.u.m,mnv.u.m,estv.u.m.N,sev.u.m.N,second.ord=F)
modavgCustom(LLv.r.m,Kv.r.m,mnv.r.m,estv.r.m.N,sev.r.m.N,second.ord=F)


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
modavgCustom(LLv.u.m,Kv.u.m,mnv.u.m,estv.u.m.O,sev.u.m.O,second.ord=F)
modavgCustom(LLv.r.m,Kv.r.m,mnv.r.m,estv.r.m.O,sev.r.m.O,second.ord=F)






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

### Origin

estv.u.f.or = c(pf.u.o.x.wb.f$coef['originWILD'],pf.u.o.x.pwp.f$coef['originWILD'],coef(pf.u.o.x.gm.f)['as.factor(origin)WILD'])
estv.r.f.or = c(pf.r.o.x.wb.f$coef['originWILD'],pf.r.o.x.pwp.f$coef['originWILD'],coef(pf.r.o.x.gm.f)['as.factor(origin)WILD'])
ind = 2
sev.u.f.or=c(sqrt(diag(pf.u.o.x.wb.f$varH))[ind-1],sqrt(diag(pf.u.o.x.pwp.f$varH))[ind-1],pf.u.o.x.gm.f[ind+2,'SE'])
sev.r.f.or=c(sqrt(diag(pf.r.o.x.wb.f$varH))[ind-1],sqrt(diag(pf.r.o.x.pwp.f$varH))[ind-1],pf.r.o.x.gm.f[ind+2,'SE'])
modavgCustom(LLv.u.f[1:3],Kv.u.f[1:3],mnv.u.f[1:3],estv.u.f.or,sev.u.f.or,second.ord=F)
modavgCustom(LLv.r.f[1:3],Kv.r.f[1:3],mnv.r.f[1:3],estv.r.f.or,sev.r.f.or,second.ord=F)


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
modavgCustom(LLv.u.f,Kv.u.f,mnv.u.f,estv.u.f.A,sev.u.f.A,second.ord=F)
modavgCustom(LLv.r.f,Kv.r.f,mnv.r.f,estv.r.f.A,sev.r.f.A,second.ord=F)


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
modavgCustom(LLv.u.f,Kv.u.f,mnv.u.f,estv.u.f.D,sev.u.f.D,second.ord=F)
modavgCustom(LLv.r.f,Kv.r.f,mnv.r.f,estv.r.f.D,sev.r.f.D,second.ord=F)


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
modavgCustom(LLv.u.f,Kv.u.f,mnv.u.f,estv.u.f.E,sev.u.f.E,second.ord=F)
modavgCustom(LLv.r.f,Kv.r.f,mnv.r.f,estv.r.f.E,sev.r.f.E,second.ord=F)


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
modavgCustom(LLv.u.f,Kv.u.f,mnv.u.f,estv.u.f.C,sev.u.f.C,second.ord=F)
modavgCustom(LLv.r.f,Kv.r.f,mnv.r.f,estv.r.f.C,sev.r.f.C,second.ord=F)


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
modavgCustom(LLv.u.f,Kv.u.f,mnv.u.f,estv.u.f.N,sev.u.f.N,second.ord=F)
modavgCustom(LLv.r.f,Kv.r.f,mnv.r.f,estv.r.f.N,sev.r.f.N,second.ord=F)


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
modavgCustom(LLv.u.f,Kv.u.f,mnv.u.f,estv.u.f.O,sev.u.f.O,second.ord=F)
modavgCustom(LLv.r.f,Kv.r.f,mnv.r.f,estv.r.f.O,sev.r.f.O,second.ord=F)
