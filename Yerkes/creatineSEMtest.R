### Creatine-weight pseudo replication, inspired by ME Thompson et al. 2016

# attempting to use 'fullcast' df



# retain:
# Creatine
# Personality
# Weights
# age , time


# cw.df1 <- fullcast[,c(1,2,5,47,48,95:100)]
# 
# cw.df1 <- cw.df1[!(is.na(cw.df1$Creatine) & is.na(cw.df1$weight)),]
# # Agatha: beware dumb shit date entries

cw.df1 <- dmdob[,c(2,119,4,123,7,33,59,85,268,271,274,322)]

colnames(cw.df1) <- c('chimp','sex','Year4','age','c4','c3','c2','c1','w3','w2','w1','H.sq')

cw.df1$H.sq = 1/cw.df1$H.sq

cw.df1 <- cw.df1[!(is.na(cw.df1$w3)),]

cw.df1[,4:12] <- scale(cw.df1[,4:12])

### bigger df for stage 2
cwp.df1 <- data.frame(dmdob[,c(2,119,4,123,7,33,59,85,268,271,274,322,156)], compare_data)

colnames(cwp.df1) <-  c('chimp','sex','Year4','age','c4','c3','c2','c1','w3','w2','w1','H.sq',
                       'depr','Dom','Ext','Con','Agr','Neu','Opn')

cwp.df1[,4:19] <- scale(cwp.df1[,4:19])

cwp.df1 <- cwp.df1[!(is.na(cwp.df1$c4)),]

###

# Let's start with some basic correlations
library(psych)

slope  <-  function(x){
  if(all(is.na(x)))
    # if x is all missing, then lm will throw an error that we want to avoid
    return(NA)
  else
    return(coef(lm(I(1:length(x))~x))[2])
}

cwp.df1$b.c <- apply(cwp.df1[,c('c4','c3','c2','c1')],1,slope)
cwp.df1$w.c <- apply(cwp.df1[,c('w3','w2','w1')],1,slope)

corPlot(cwp.df1[,4:21])

df.cor <- data
cor.test(apply(cwp.df1[,9:11],1,mean,na.rm=TRUE), apply(cwp.df1[,5:8],1,mean,na.rm=TRUE))
cor.test(apply(cwp.df1[,9:11],1,mean,na.rm=TRUE)/cwp.df1$H.sq, apply(cwp.df1[,5:8],1,mean,na.rm=TRUE))

cor.test(cwp.df1$Dom, apply(cwp.df1[,5:8],1,mean,na.rm=TRUE)) # *
cor.test(cwp.df1$Ext, apply(cwp.df1[,5:8],1,mean,na.rm=TRUE))
cor.test(cwp.df1$Con, apply(cwp.df1[,5:8],1,mean,na.rm=TRUE)) # **        
cor.test(cwp.df1$Agr, apply(cwp.df1[,5:8],1,mean,na.rm=TRUE)) # *       
cor.test(cwp.df1$Neu, apply(cwp.df1[,5:8],1,mean,na.rm=TRUE))
cor.test(cwp.df1$Opn, apply(cwp.df1[,5:8],1,mean,na.rm=TRUE))
cor.test(cwp.df1$depr, apply(cwp.df1[,5:8],1,mean,na.rm=TRUE)) # *** ...


library(lavaan)
library(semPlot)
library(semTools)
library(blavaan)

#library(bbmle)


# a linear growth model with a time-varying covariate
mod.1 <- '
# intercept and slope with fixed coefficients
i =~ 1*w3 + 1*w2 + 1*w1
s =~ 1*w3 + 2*w2 + 3*w1

i.c =~ 1*c4 + 1*c3 + 1*c2 + 1*c1
s.c =~ 0*c4 + 1*c3 + 2*c2 + 3*c1
# regressions
#i ~ x1 + x2
#s ~ x1 + x2
# time-varying covariates
#w1 ~ c2
#w2 ~ c3
#w3 ~ c4
#t4 ~ c4

# regs for earlier c LVs onto later w LVs
i ~ i.c + s.c + age + sex
s ~ i.c + s.c + age + sex
'
fit <- growth(mod.1, data = cw.df1, missing="ML")
semPaths(fit, whatLabels = 'par')
summary(fit)
fitMeasures(fit, c("chisq", "df", "pvalue", "cfi", "rmsea",'srmr'))

mod_ind <- modificationindices(fit)
head(mod_ind[order(mod_ind$mi, decreasing=TRUE), ], 10)

# Base model, modify as required
# 
mod.1.x <- '
# intercept and slope with fixed coefficients
i.c =~ 1*c4 + 1*c3 + 1*c2 + 1*c1
s.c =~ 0*c4 + 1*c3 + 2*c2 + 3*c1

Wt =~ w3 + w2 + w1 

# regs for earlier c LVs onto later w LV
Wt~ i.c + s.c
Wt ~ age + sex # last two are "new"
'
fit1x <- lavaan(mod.1.x, data = cw.df1, missing="ML", model.type='growth',
               int.ov.free = TRUE, int.lv.free = FALSE, auto.fix.first = TRUE, 
               auto.fix.single = TRUE, auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
               auto.cov.y = TRUE)

semPaths(fit1x, what='mod', whatLabels = 'par')
summary(fit1x)
fitMeasures(fit1x, baseline.model = fit, c("chisq", "df", "pvalue", "cfi", "rmsea",'srmr'))


mod.1.y <- '
# intercept and slope with fixed coefficients
c =~ c4 + c3 + c2 + c1

Wt =~ w3 + w2 + w1 

# regs for earlier c LVs onto later w LV
Wt~ c
Wt ~ age + sex # last two are "new"
'
fit1y <- lavaan(mod.1.y, data = cw.df1, missing="ML", model.type='growth',
                int.ov.free = TRUE, int.lv.free = FALSE, auto.fix.first = TRUE, 
                auto.fix.single = TRUE, auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
                auto.cov.y = TRUE)

semPaths(fit1y, what='mod', whatLabels = 'par')
summary(fit1y)
fitMeasures(fit1y, baseline.model = fit, c("chisq", "df", "pvalue", "cfi", "rmsea",'srmr'))

anova(fit, fit1y)

BICtab(fit,fit1x,fit1y,weights=TRUE, delta=TRUE, base=TRUE, logLik=TRUE, sort=TRUE)

compareFit(fit, fit1x, fit1y)

# looks like the original dual slope model is best




# changing weight into a latent variable, and formulating BMI from it
mod.2 <- '
# intercept and slope with fixed coefficients
i =~ 1*w3 + 1*w2 + 1*w1
s =~ 1*w3 + 2*w2 + 3*w1

i.c =~ 1*c4 + 1*c3 + 1*c2 + 1*c1
s.c =~ 1*c4 + 2*c3 + 3*c2 + 4*c1

i.BMI =~ H.sq*i
s.BMI =~ H.sq*s

# regs for earlier c LVs onto later w LVs
i.BMI ~ i.c + s.c + age + sex
s.BMI ~ i.c + s.c + age + sex


# regs for earlier c LVs onto later w LV
# s ~ s.c
# i ~ i.c
'
fit2 <- lavaan(mod.2, data = cw.df1, missing="ML", model.type='growth',
              int.ov.free = TRUE, int.lv.free = FALSE, auto.fix.first = TRUE, 
              auto.fix.single = TRUE, auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
              auto.cov.y = TRUE)

semPaths(fit2, what='mod', whatLabels = 'par')
summary(fit2)
fitMeasures(fit2, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))
compareFit(fit, fit2)
# BMI doesn't seem to fit the model better


bfit2.1 <- blavaan(mod.2, data = cw.df1, missing="ML", model.type='growth',
               int.ov.free = TRUE, int.lv.free = FALSE, auto.fix.first = TRUE, 
               auto.fix.single = TRUE, auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
               auto.cov.y = TRUE)
mod.2.2 <- '
# intercept and slope with fixed coefficients
i.c =~ 1*c4 + 1*c3 + 1*c2 + 1*c1
s.c =~ 0*c4 + 1*c3 + 2*c2 + 3*c1

Wt =~ w3 + w2 + w1

# regressions
#i ~ x1 + x2
#s ~ x1 + x2
# time-varying covariates

# regs for earlier c LVs onto later w LV
Wt~ i.c + 0*s.c
'

mod.2.3 <- '
# intercept and slope with fixed coefficients
i.c =~ 1*c4 + 1*c3 + 1*c2 + 1*c1
s.c =~ 0*c4 + 1*c3 + 2*c2 + 3*c1

Wt =~ w3 + w2 + w1

# regressions
#i ~ x1 + x2
#s ~ x1 + x2
# time-varying covariates

# regs for earlier c LVs onto later w LV
Wt~ 0*s.c + 0*i.c
'
fit2.2 <- lavaan(mod.2.2, data = cw.df1, missing="ML", model.type='growth',
                   int.ov.free = TRUE, int.lv.free = FALSE, auto.fix.first = TRUE, 
                   auto.fix.single = TRUE, auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
                   auto.cov.y = TRUE)
fit2.3 <- lavaan(mod.2.3, data = cw.df1, missing="ML", model.type='growth',
                 int.ov.free = TRUE, int.lv.free = FALSE, auto.fix.first = TRUE, 
                 auto.fix.single = TRUE, auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
                 auto.cov.y = TRUE)
semPaths(fit2.3)


mod.2.X <- '
# just the weight LV
Wt =~ w3 + w2 + w1
'
bfit2.X <- blavaan(mod.2.X, data = cw.df1, missing="ML", model.type='growth',
                   int.ov.free = TRUE, int.lv.free = FALSE, auto.fix.first = TRUE, 
                   auto.fix.single = TRUE, auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
                   auto.cov.y = TRUE)
summary(fit)

fitMeasures(fit)
fitMeasures(fit, c("chisq", "df", "pvalue", "cfi", "rmsea"))
fitMeasures(fit2.2, baseline.model = fit,c("chisq", "df", "pvalue", "cfi", "rmsea"))
fitMeasures(fit2.3, baseline.model = fit,c("chisq", "df", "pvalue", "cfi", "rmsea"))
# I'm not sure this is all being done correctly


#fitMeasures(bfit2.1)


# add personality?




# not a growth model anymore
mod.3 <- '
# intercept and slope with fixed coefficients
i.c =~ c4 + c3 + c2 + c1

Wt =~ w3 + w2 + w1

# regressions
#i ~ x1 + x2
#s ~ x1 + x2
# time-varying covariates


# regs for earlier c LVs onto later w LV
Wt ~ i.c
'
# not currently functional
fit <- lavaan(mod.3, data = cw.df1, missing="ML",model.type='sem')
semPaths(fit)
summary(fit)

fit <- growth(mod.3, data = cw.df1, missing="ML")




### Personality ###

# 
# dmdob$chimp_Dom_CZ <-
#   (fulldata$dom.z-fulldata$subm.z-fulldata$depd.z+fulldata$indp.z-fulldata$fear.z+fulldata$decs.z-fulldata$tim.z-fulldata$caut.z+
#      fulldata$intll.z+fulldata$pers.z+fulldata$buly.z+fulldata$stngy.z+40)/12
# 
# dmdob$chimp_Ext_CZ <-
#   (-fulldata$sol.z-fulldata$lazy.z+fulldata$actv.z+fulldata$play.z+fulldata$soc.z-fulldata$depr.z+fulldata$frdy.z+fulldata$affc.z+fulldata$imit.z+24)/9
# 
# dmdob$chimp_Con_CZ <-
#   (-fulldata$impl.z-fulldata$defn.z-fulldata$reckl.z-fulldata$errc.z-fulldata$irri.z+fulldata$pred.z-fulldata$aggr.z-fulldata$jeals.z-fulldata$dsor.z+64)/9
# 
# dmdob$chimp_Agr_CZ <-
#   (fulldata$symp.z+fulldata$help.z+fulldata$sens.z+fulldata$prot.z+fulldata$gntl.z)/5
# 
# dmdob$chimp_Neu_CZ <-
#   (-fulldata$stbl.z+fulldata$exct.z-fulldata$unem.z+16)/3
# 
# dmdob$chimp_Opn_CZ <-
#   (fulldata$inqs.z+fulldata$invt.z)/2

# cwp.df1 <- data.frame(dmdob[,c(2,156,4,7,33,59,85,268,271,274,123,119)], compare_data)
# 
# colnames(cwp.df1) <- c('chimp','sex','Year4','c4','c3','c2','c1','w3','w2','w1','age',
#                       'depr','Dom','Ext','Con','Agr','Neu','Opn')
# 
# cwp.df1[,4:18] <- scale(cwp.df1[,4:18])

# cw.df1 <- cw.df1[!(is.na(cw.df1$w3)),] #?


mp.1 <- '
# intercept and slope with fixed coefficients
i =~ 1*w3 + 1*w2 + 1*w1
s =~ 1*w3 + 2*w2 + 3*w1

i.c =~ 1*c4 + 1*c3 + 1*c2 + 1*c1
s.c =~ 0*c4 + 1*c3 + 2*c2 + 3*c1

# regs for earlier c LVs onto later w LVs
i ~ i.c + s.c + age + sex
s ~ i.c + s.c + age + sex + Ext

# regressions
#i.c ~ Dom + Ext + Con + Agr + Neu + Opn
#s ~ Ext #+ Con + Agr + Neu + Opn + Dom
'

fit.p1 = lavaan(mp.1, data = cwp.df1, missing="ML", model.type='growth',
int.ov.free = TRUE, int.lv.free = FALSE, auto.fix.first = TRUE, 
auto.fix.single = TRUE, auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
auto.cov.y = TRUE)

semPaths(fit.p1,  what='mod', whatLabels = 'par')

summary(fit.p1)

fitMeasures(fit.p1, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))
compareFit(fit, fit.p1)

mod_ind <- modificationindices(fit.p1)
head(mod_ind[order(mod_ind$mi, decreasing=TRUE), ], 10)
subset(mod_ind[order(mod_ind$mi, decreasing=TRUE), ], mi > 5)


mp.1.medi <- ' # a correctly defined mediator
# intercept and slope with fixed coefficients
i.c =~ 1*c4 + 1*c3 + 1*c2 + 1*c1
s.c =~ 0*c4 + 1*c3 + 2*c2 + 3*c1

Wt =~ w3 + w2 + w1

# direct effect
Wt ~ i.c + c*s.c + age + sex

# mediator
Ext ~ a*s.c
Wt ~ b*Ext
# indirect effect (a*b)
ab := a*b
# total effect
total := c + (a*b)

# time-varying covariates

# # setting covariances
# Dom ~~ 0*Ext
# Dom ~~ 0*Con
# Dom ~~ 0*Agr
# Dom ~~ 0*Neu
# Dom ~~ 0*Opn
# Ext ~~ 0*Con
# Ext ~~ 0*Agr
# Ext ~~ 0*Neu
# Ext ~~ 0*Opn
# Con ~~ 0*Agr
# Con ~~ 0*Neu
# Con ~~ 0*Opn
# Agr ~~ 0*Neu
# Agr ~~ 0*Opn
# Neu ~~ 0*Opn
'

fit.p2 = lavaan(mp.1.medi, data = cwp.df1, missing="ML", model.type='growth',
                int.ov.free = TRUE, int.lv.free = FALSE, auto.fix.first = TRUE, 
                auto.fix.single = TRUE, auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
                auto.cov.y = TRUE)

semPaths(fit.p2,  what='mod', whatLabels = 'par')

summary(fit.p2)

fitMeasures(fit, c("chisq", "df", "pvalue", "cfi", "rmsea"))
fitMeasures(fit.p2, c("chisq", "df", "pvalue", "cfi", "rmsea"))

mod_ind <- modificationindices(fit)
head(mod_ind[order(mod_ind$mi, decreasing=TRUE), ], 10)
subset(mod_ind[order(mod_ind$mi, decreasing=TRUE), ], mi > 5)


### Regularized SEM testing

library(regsem)

HS <- data.frame(scale(HolzingerSwineford1939[,7:15]))
mod <- '
f =~ x1 + x2 + x3 + x4 + x5 + x6 + x7 + x8 + x9
'
outt = cfa(mod,HS)

cv.out = cv_regsem(outt,type="ridge",gradFun="none",n.lambda=100)



rfit1 = regsem(fit)
cvfit1 = invisible(cv_regsem(fit1x, mult.start = F, 
                             missing='fiml', gradFun='none'))

summary(cvfit1)

fit_indices(rfit1)

### also qgraph

library(qgraph)

