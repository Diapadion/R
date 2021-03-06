### Parametric frailty models


library(survival)
library(parfm)
library(frailtypack)
library(bbmle)

#attr(yLt, 'type')# <- 'counting'



### Spline testing

fp.test.sp =  frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                             as.factor(sex) + as.factor(origin) +  
                             Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ,
                           data = datX, hazard =  'Splines' 
                           , n.knots = 3, kappa = 1
                           , betaknots = 3, betaorder = 3
)
summary(fp.test.sp)
plot(fp.test.sp, type='Survival')


fpack.r.x = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                           as.factor(sex) + #as.factor(origin) +  
                           D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB,
                         data = datX, hazard =  'Piecewise-equi' , nb.int = 9
                         #, n.knots = 4, kappa =1
)


# strata won't really work with these

fpack.u = frailtyPenal(yLt ~ cluster(sample) + #strata(strt) +
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
fpfLL[9] = fpack.u.9$logLik/
fpfLL[8] = fpack.u.8$logLik
fpfLL[7] = fpack.u.7$logLik
fpfLL[6] = fpack.u.6$logLik
fpfLL[5] = fpack.u.5$logLik
fpfLL[4] = fpack.u.4$logLik
fpfLL[3] = fpack.u.3$logLik
fpfLL[2] = fpack.u.2$logLik
fpfLL[1] = fpack.u$logLik

plot(fpfLL)

# Following Han et al. 2014's BE procedure

pchisq(2*(fpfLL[20]-fpfLL[19]), df=20-19, lower.tail = F)
pchisq(2*(fpfLL[19]-fpfLL[18]), df=19-18, lower.tail = F)
pchisq(2*(fpfLL[18]-fpfLL[17]), df=18-17, lower.tail = F)
pchisq(2*(fpfLL[17]-fpfLL[16]), df=17-16, lower.tail = F)
pchisq(2*(fpfLL[16]-fpfLL[15]), df=16-15, lower.tail = F)
pchisq(2*(fpfLL[15]-fpfLL[14]), df=15-14, lower.tail = F)
pchisq(2*(fpfLL[14]-fpfLL[13]), df=14-13, lower.tail = F)
pchisq(2*(fpfLL[13]-fpfLL[12]), df=13-12, lower.tail = F)
pchisq(2*(fpfLL[12]-fpfLL[11]), df=12-11, lower.tail = F)
pchisq(2*(fpfLL[11]-fpfLL[10]), df=11-10, lower.tail = F)
pchisq(2*(fpfLL[10]-fpfLL[9]), df=10-9, lower.tail = F)
pchisq(2*(fpfLL[9]-fpfLL[8]), df=9-8, lower.tail = F)



pchisq(2*(fpack.u.9$logLik-fpack.u$logLik), df=9-1, lower.tail = F)
summary(fpack.u.9)

#fpack.u.10$AIC


fpack.r = frailtyPenal(yLt ~ cluster(sample) + #strata(strt)
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
plot(fpack.r.9)

# AICtab(fpack.u, fpack.r,
#        logLik=T, sort=T, delta=T, base=T,weights=T)

fpack.u$AIC
fpack.u.10$AIC
fpack.r$AIC



# Specifications of interest


fpack.u.0f = frailtyPenal(Surv(age_pr, age, stat.log,type='counting') ~ #cluster(sample) + 
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
fpack.r.x.sx.A = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                                #as.factor(sex) + #as.factor(origin) +  
                                Agr_CZ,
                              data = datX, hazard =  'Piecewise-equi' , nb.int = 9
                              #, n.knots = 4, kappa =1
)

fpack.r.i.si.A = frailtyPenal(Surv(age_pr, age, status) ~ cluster(sample) + 
                                as.factor(sex) + as.factor(origin) +  
                                Agr_CZ,
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
                           


### prelim anal for Yerkes - AL connection

fpack.u.i.si.6.Y = frailtyPenal(Surv(age_pr, age, status) ~ #cluster(sample) + 
                                as.factor(sex) + as.factor(origin) +  
                                Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ,
                              data = datX[datX$sample==6,], hazard =  'Piecewise-equi' , nb.int = 9
                              #, n.knots = 4, kappa =1
)



### Switch to parfm ###


pf.test = parfm(Surv(Begin, End, Status, type='counting') ~ Drug, cluster = "Patid", 
      data = asthma[asthma$Fevent == 0, ]
      ,dist = "weibull", frailty = "gamma", method = "nlminb")
  

obsdatadi <- aggregate(yLt[,3],
                        by=list(datX$sample), 
                        FUN=sum)[,, drop=FALSE]

a.tst.y = Surv(asthma$Begin,asthma$End,asthma$Status)
c.tst.y = Surv(datX$age_pr, datX$age, datX$stat.log)

attr(Surv(asthma$Begin,asthma$End,asthma$Status),'type')
attr(Surv(datX$age_pr, datX$age, datX$stat.log,type = 'counting'),'type')
attr(Surv(datX$age_pr, datX$age, datX$status,type = 'counting'),'type')
attr(a.tst.y, 'type')
attr(c.tst.y, 'type')

pf.test = parfm(a.tst.y ~ Drug, cluster = "Patid", 
                data = asthma,
                dist = "weibull", frailty = "gamma", 
                method = "nlminb")


#ptm = proc.time()
pfm.u.i.g.6 = parfm(Surv(age_pr, age, status) ~ 
                      as.factor(origin) + as.factor(sex) * Agr_CZ
                      + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ
                    #+ D.r2.DoB + E.r2.DoB + Con_CZ + N.r1.DoB + O.r2.DoB
                    ,cluster="sample" #, strata = "strt"
                    , frailty = 'gamma'
                    , data=datX, dist='gompertz', method ='ucminf') #ucminf Nelder-Mead nlminb #BGFS
#proc.time() - ptm
pfm.r.i.g.6 = parfm(Surv(age_pr, age, stat.log) ~ 
                      as.factor(sex) #+ as.factor(origin) 
                      + D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB,
                    ,cluster="sample" #strata = "strt"
                    , frailty = 'gamma'
                    , data=datX, dist='weibull', method ='Nelder-Mead')

print(pfm.u.i.g.6)
logLik(pfm.u.i.g.6)


#print(pfm.r.i.g.6)
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

print(pfm.r.x.g.6)

pfm.u.i.w.6 = parfm(Surv(age_pr, age, status) ~ 
                      as.factor(sex) + as.factor(origin) +  
                      Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ,
                    cluster="sample" #strata = "strt"
                    , frailty = 'gamma'
                    , data=datX, dist='inweibull', method ='ucminf')
pfm.r.i.w.6 = parfm(Surv(age_pr, age, status) ~ 
                      as.factor(sex) + as.factor(origin) +  
                      D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB,
                    cluster="sample" #strata = "strt"
                    , frailty = 'gamma'
                    , data=datX, dist='weibull', method ='ucminf')

pfm.u.i.f.6 = parfm(Surv(age_pr, age, status) ~ 
                      as.factor(sex) + as.factor(origin) +  
                      Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ,
                    cluster="sample" #strata = "strt"
                    , frailty = 'gamma'
                    , data=datX, dist='inweibull', method ='ucminf')


print(pfm.u.i.f.6)


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

aft.parfm.eq2 = aftreg(Surv(age_pr, age, stat.log) ~ 
                         as.factor(origin) + as.factor(sex) * Agr_CZ
                       + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ,
                   data = datX, param = 'lifeAcc',
                   dist = 'loglogistic')

#print(aft.parfm.eq1)
summary(aft.parfm.eq2)


aft.f = aftreg(Surv(age_pr, age, stat.log) ~ 
                         as.factor(origin) + Agr_CZ
                       + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ,
                       data = datX[datX$sex==0,], param = 'lifeAcc',
                       dist = 'loglogistic')
aft.m = aftreg(Surv(age_pr, age, stat.log) ~ 
                 as.factor(origin) + Agr_CZ
               + Dom_CZ + Ext_CZ + Con_CZ + Neu_CZ + Opn_CZ,
               data = datX[datX$sex==1,], param = 'lifeAcc',
               dist = 'loglogistic')



pf.u.o.s.6.aft = aftreg(Surv(age_pr, age, stat.log) ~ 
                          as.factor(sex) + as.factor(origin) +  
                          Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ,
                        data = datX, param = 'lifeExp',
                        dist = 'gompertz')
summary(pf.u.o.s.6.aft)
