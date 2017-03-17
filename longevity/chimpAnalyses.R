# Progressive regression models of main analysis sequence


library(survival)
library(psych)
library(bbmle)
library(ggplot2)
library(powerSurvEpi)
# library(NPHMC)

library(LTRCtrees)
library(rpart.plot)



### Power Analysis

## formula for Hazard ratio from AFT:
#  HazRat = exp(coefficient(s) * -1 * 1/scale)

gorillaEHR = exp(0.272 * -1 * 1/(exp(-0.317)))
# print(gorillaEHR)
# [1] 0.6883508
# round to a more conservative 0.7



powerEpiCont(formula = (age - age_pr) ~ as.factor(sex) + 
               as.factor(origin) +  
               Dom_CZ + Ext_CZ + Con_CZ +
               Agr_CZ + Neu_CZ + Opn_CZ,
             dat=datX, 
             #X1 = Con_CZ
             #X1 = Ext_CZ
             #X1 = Opn_CZ
             #X1 = Dom_CZ
             #X1 = Neu_CZ
             X1 = Agr_CZ
             ,failureFlag = datX$status  ,
             n = 538, theta = 0.7)
# $power
# [1] 0.800775
# 
# $rho2
# [1] 0.114313
# 
# $sigma2
# [1] 0.4262737
# 
# $psi
# [1] 0.3043478

# this is just for E

# p_Agr = 0.88
# p_Neu = 0.94
# p_Dom = 0.89
# p_Opn = 0.98
# p_Con = 0.80

persPwr = c(0.80, 0.88, 0.94, 0.89, 0.98, 0.80)
mean(persP)
  

### Plot the data over time
pdx = gather(datX, Personality, Measurement, Dom:Opn)

p <- ggplot(pdx, aes(age_pr, Measurement, colour = factor(Personality))) + geom_point() + 
  theme_bw() + theme(legend.position="none") + labs(x='Age at Personality Rating')

# Figure 3:
p + facet_wrap(~ Personality, nrow = 2)



### Testing for correlations between time and personality

pxt.cors = corr.test(as.matrix(Dataset[,c(73:78)]),as.matrix(as.numeric(Dataset$DoB)), 
                     method = "kendall", adjust='none'
                     , ci=TRUE)
print(pxt.cors, short=F)
# only correlations between DoB and D, E, N, and O are significant



### Extraversion: identifying relationship with time
fit.e0 <- lm(Ext_CZ ~ 1, data=datX)
fit.e1.DoB <- lm(Ext_CZ ~ scale(DoB), data=datX)
fit.e2.DoB <- lm(Ext_CZ ~ scale(DoB) + I(scale(DoB)^2), data=datX) # this seems to be the best (see anova)
fit.e3.DoB <- lm(Ext_CZ ~ scale(DoB) + I(scale(DoB)^2) + I(scale(DoB)^3), data=datX)

AICctab(fit.e0,fit.e1.DoB,fit.e2.DoB,fit.e3.DoB
        ,logLik=T,weights=T,base=T,delta=T)
# Either Q or C
plot(fit.e2.DoB)
plot(fit.e3.DoB)
# Quadratic is better.


### Openness: identifying relationship with time
fit.o0 <- lm(Opn_CZ ~ 1, data=datX)
fit.o1.DoB <- lm(Opn_CZ ~ scale(DoB), data=datX) # this, according to LASSO
fit.o2.DoB <- lm(Opn_CZ ~ scale(DoB) + I(scale(DoB)^2), data=datX) # or this, according to stabsel
fit.o3.DoB <- lm(Opn_CZ ~ scale(DoB) + I(scale(DoB)^2) + I(scale(DoB)^3), data=datX)

AICctab(fit.o0,fit.o1.DoB,fit.o2.DoB,fit.o3.DoB
        , logLik=T,weights=T,base=T,delta=T)
# Either Q or C
plot(fit.o2.DoB)
plot(fit.o3.DoB)
# Quadratic is better.


### Dominance: identifying relationship with time
fit.d0 <- lm(Dom_CZ ~ 1, data=datX)
fit.d1.DoB <- lm(Dom_CZ ~ scale(DoB), data=datX)
fit.d2.DoB <- lm(Dom_CZ ~ scale(DoB) + I(scale(DoB)^2), data=datX)
fit.d3.DoB <- lm(Dom_CZ ~ scale(DoB) + I(scale(DoB)^2) + I(scale(DoB)^3), data=datX) 

AICctab(fit.d0, fit.d1.DoB,fit.d2.DoB,fit.d3.DoB
        ,logLik=T,weights=T,base=T,delta=T)
# Either Q or C
plot(fit.d2.DoB)
plot(fit.d3.DoB)
# Quadratic is better.


### Neuroticism: identifying relationship with time
fit.n0 <- lm(Neu_CZ ~ 1, data=datX)
fit.n1.DoB <- lm(Neu_CZ ~ scale(DoB), data=datX)
fit.n2.DoB <- lm(Neu_CZ ~ scale(DoB) + I(scale(DoB)^2), data=datX)
fit.n3.DoB <- lm(Neu_CZ ~ scale(DoB) + I(scale(DoB)^2) + I(scale(DoB)^3), data=datX)

AICctab(fit.n0, fit.n1.DoB,fit.n2.DoB,fit.n3.DoB
        ,logLik=T,weights=T,base=T,delta=T)
# Linear is better.


### Creating residualized versions of these personality vars




# Alex's code for finding the ideal distribution
thedistributions<-c("weibull","exponential","lognormal","loglogistic")

themodel <- (y ~ as.factor(Dataset$sex) + #Dataset$DoB + #Dataset$age_pr + Dataset$age + 
               as.factor(Dataset$origin) + as.factor(Dataset$LvZ) + 
               Dataset$Dom_CZ + Dataset$Ext_CZ + Dataset$Con_CZ +
               Dataset$Agr_CZ + Dataset$Neu_CZ + Dataset$Opn_CZ
)

model.p <- (y ~ Dataset$Dom_CZ + Dataset$Ext_CZ + Dataset$Con_CZ +
               Dataset$Agr_CZ + Dataset$Neu_CZ + Dataset$Opn_CZ
)

model.agexE <- (y ~ as.factor(Dataset$sex) + 
                  as.factor(Dataset$origin) + as.factor(Dataset$LvZ) +
                Dataset$Dom_CZ + Dataset$Ext_CZ + Dataset$Con_CZ +
              Dataset$Agr_CZ + Dataset$Neu_CZ + Dataset$Opn_CZ +
                Dataset$Ext_CZ*Dataset$age_pr_adj
              )


testSurvDist(distlist, model.p)

# loglogistic? weibull?


### The model(s)

mod0.w <- survreg(y ~ 1, dist='weibull', control=list(maxiter = 10000))

mod1.w <- survreg(themodel, dist = 'weibull', control=list(maxiter = 10000))
mod1.ll <- survreg(themodel, dist = 'loglogistic')
mod1.e <- survreg(themodel, dist = 'exponential')

mod.p.ll <- survreg(model.p, dist = 'loglogistic')
  
summary(mod1.ll)

fit1 <- survfit(yLt ~ 1 + as.factor(Dataset$sex)
                )
plot(fit1)
summary(fit1)

mod2.ll <- survreg(model.agexE, dist = 'loglogistic')

mod.3 <- coxph(themodel)
# Cox model doesn't support "mright" survival data

# what happens if we build in the adjusted E and O

mod.10.DoB <-  survreg(y ~ as.factor(Dataset$sex) + Dataset$DoB + #Dataset$age_pr + Dataset$age + 
              as.factor(Dataset$origin) + as.factor(Dataset$LvZ) + 
              Dataset$Dom_CZ + Dataset$Ext_CZ + Dataset$Con_CZ +
              Dataset$Agr_CZ + Dataset$Neu_CZ + Dataset$Opn_CZ,
              dist = 'weibull'
)

mod.10.age_pr <- survreg(y ~ as.factor(Dataset$sex) + Dataset$age_pr +
                        as.factor(Dataset$origin) + as.factor(Dataset$LvZ) + 
                        Dataset$Dom_CZ + Dataset$Ext_CZ + Dataset$Con_CZ +
                        Dataset$Agr_CZ + Dataset$Neu_CZ + Dataset$Opn_CZ,
                        dist = 'weibull'
)

mod.10.age <- survreg(y ~ as.factor(Dataset$sex) + Dataset$age +
                           as.factor(Dataset$origin) + as.factor(Dataset$LvZ) + 
                           Dataset$Dom_CZ + Dataset$Ext_CZ + Dataset$Con_CZ +
                           Dataset$Agr_CZ + Dataset$Neu_CZ + Dataset$Opn_CZ,
                      dist = 'weibull'
)
# so with just age, the Personality stuff comes through
  


# testing
attr(y, 'type') <- 'right'
#Surv(age,status)
mod.99 <-  survreg(y ~ 1 + as.factor(sex) #+ #Dataset$DoB + #Dataset$age_pr + Dataset$age + 
                         #as.factor(Dataset$origin) + #as.factor(Dataset$LvZ) + 
                        # Dataset$Dom_CZ + Dataset$Ext_CZ + Dataset$Con_CZ
                        #+ Dataset$Agr_CZ #+ Dataset$Neu_CZ# + Dataset$Opn_CZ
                   , data = Dataset    
                   , dist = 'weibull'
)  

mod.199 <- survreg(yLt ~ 1, , dist = 't')
# fuck




library(car)


### INTERVAL censoring?
### ... left TRUNCATION (!)
#library(flexsurv)


#“extreme”, “logistic”, “gaussian”, “weibull”, “exponential”, “rayleigh”, “loggaussian”, 
# “lognormal”, “loglogistic”, “t
distlist = c('extreme', 'logistic', 'gaussian', 'weibull', 'exponential', 'rayleigh', 'loggaussian', 
 'lognormal', 'loglogistic', 't')

mod.trunc <- survreg(yLt ~ as.factor(sex) + 
                       #as.factor(origin) + # as.factor(LvZ) + 
                       Dom_CZ + Con_CZ + Ext_CZ +
                       Agr_CZ + Neu_CZ + Opn_CZ #+ adjE
                     ,dist = "t", data=datX
                     )
# Log(scale)                2.061     0.0465  44.340 0.00e+00
# maybe change from extreme to t?

# Log(scale)                 1.505     0.0627 23.989 3.66e-127
# better with t

summary(mod.trunc)

confint(mod.trunc)

exp(as.numeric(mod.trunc$coefficients[7]))

mod.t.adj <- survreg(yLt ~ as.factor(sex) + 
                       as.factor(origin) + as.factor(LvZ) + 
                       adjD + adjE + adjC +
                       adjA + adjN + adjO,
                     dist = "t", data=datX
)


                 
# Thought:                  
# subtract year(s) from DoD of those who died before being rated...? 
# Done - see importProcess

mod.t.agexE <- survreg(yLt ~ as.factor(sex) + 
                       as.factor(origin) + as.factor(LvZ) + 
                       Dom_CZ + Ext_CZ + Con_CZ +
                       Agr_CZ + Neu_CZ + Opn_CZ
                       + DoB:Ext_CZ
                       , dist = "t", data=datX
)
summary(mod.t.agexE)
                 
anova(mod.t.agexE)

mod.t.agexEDNO <- survreg(yLt ~ as.factor(sex) + 
                         as.factor(origin) + as.factor(LvZ) + 
                         Dom_CZ + Ext_CZ + Con_CZ +
                         Agr_CZ + Neu_CZ + Opn_CZ
                       + age_pr:Ext_CZ + age_pr:Dom_CZ
                       + age_pr:Neu_CZ + age_pr:Opn_CZ
                       , dist = "t", data=datX
)


source("https://bioconductor.org/biocLite.R")
biocLite("survcomp")

survdiff(themodel)
#Error in survdiff(themodel) : Right censored data only   # what the hell

library(coin)
#logrank_test(themodel)



fit.T1 <- survfit(yLt ~ as.factor(sex) + 
                    as.factor(origin) + as.factor(LvZ) + 
                    Dom_CZ + Ext_CZ + Con_CZ +
                    Agr_CZ + Neu_CZ + Opn_CZ
                  , data=datX)


# residualized E in AFT?

mod.E.r2 <- survreg(yLt ~ as.factor(sex) + 
                    as.factor(origin) + as.factor(LvZ) + 
                    Dom_CZ + E.r2.DoB + Con_CZ + #E.resid3 +
                    Agr_CZ + Neu_CZ + Opn_CZ
                  , data=datX, dist='t')

summary(mod.t.Er2)


## O and E residulized

mod.EOr <- survreg(yLt ~ as.factor(sex) + 
                       as.factor(origin) + #as.factor(LvZ) + 
                       Dom_CZ + E.r2.DoB + Con_CZ +
                       Agr_CZ + Neu_CZ + O.r1.DoB
                     , data=datX, dist='logistic') # this model is informed by LASSO
summary(mod.EOr)

model.Ltrunc.spec = (yLt ~ as.factor(datX$sex) + as.factor(datX$origin) + #as.factor(LvZ) + 
                       datX$Dom_CZ + datX$E.r2.DoB + datX$Con_CZ + datX$Agr_CZ + datX$Neu_CZ + datX$O.r2.DoB)
testSurvDist(truncdistributions, model.Ltrunc.spec)
                             

datX$Yerkes = as.factor(datX$sample=='Yerkes')
datX$Japan = as.factor(datX$sample=='Japan')

mod.Alex.int <- survreg(yLt ~ as.factor(sex) + 
                       as.factor(origin) +# as.factor(LvZ) + 
                       Dom_CZ + Con_CZ + 
                       Agr_CZ + Neu_CZ + O.r2.DoB
                       + E.r2.DoB * as.numeric(Yerkes)
                       + E.r2.DoB * as.numeric(Japan)
                       
                     , data=datX, dist='t') # this model is informed by LASSO



# with all significantly confounded dimensions properly residualized
mod.EODN.r <- survreg(yLt ~ as.factor(sex) + 
                       as.factor(origin) + as.factor(LvZ) + 
                        D.r3.DoB + E.r3.DoB + Con_CZ + #E.resid3 +
                       Agr_CZ + N.r1.DoB + O.r2.DoB
                     , data=datX, dist='t')


mod.EODN.r.betr <- survreg(yLt ~ as.factor(sex) + 
                           as.factor(origin) + as.factor(LvZ) + 
                           D.r3 + E.r3 + Con_CZ + #E.resid3 +
                           Agr_CZ + N.r1 + O.r2
                         , data=datX, dist='t')


mod.ENr.2 <- survreg(yLt ~ as.factor(sex) + 
                         as.factor(origin) + #as.factor(LvZ) + 
                         D.cv.r + E.cv.r + C.cv.r +
                         A.cv.r + N.cv.r + O.cv.r
                       , data=datX, dist='logistic')



### LASSO...

# library(glmnet)
# 
# netform <- Dataset[,c(2,62,66,71,72,73,74,75,76,77)]
# netform$origin <- droplevels(netform$origin)
# x <- model.matrix( ~ sex + age_pr + origin + LvZ + 
#                      Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ - 1, netform)
# 
# x <- x[,-3] # fix some origin glitches
# y1 <- y[-354,]
#   
# net1 <- glmnet(x, y1, family="cox")
# 
# # this isn't working:
# net1.cv <- cv.glmnet(x, y1, family="cox", type.measure = "deviance", grouped=FALSE)
# plot(net1.cv)
# 
# plot(net1, label=T)
# plot(net1, xvar="lambda", label=T)  
# plot(net1, xvar="dev", label=T) 
# 
# 
# coef(net1, s=net1.cv$lambda.min
#      )
# coef(net1, s=0.01)


### testing distr for left truncation

truncdistributions = c("t","extreme","logistic")

truncmod <- (yLt ~ as.factor(datX$sex) + 
                       as.factor(datX$origin) + #as.factor(datX$LvZ) + 
               datX$Dom_CZ + datX$Ext_CZ + datX$Con_CZ +
               datX$Agr_CZ + datX$Neu_CZ + datX$Opn_CZ)


# Extreme value distribution
# Loglik(model)= -846.9   Loglik(intercept only)= -957.9
# Chisq= 221.83 on 10 degrees of freedom, p= 0 
# Number of Newton-Raphson Iterations: 6 
# n=361 (1 observation deleted due to missingness)
# 
# 1            t        1793.482    1577.619 0.11779359 215.8636
# 3     logistic        1797.079    1587.880 0.08042083 209.1991
# 2      extreme        1915.704    1693.870 0.02409324 221.8341


# not really informative or useful

library(flexsurv)
attr(yLt, 'type') <- 'counting'


# distlist = c('gengamma', 'genf', 'gompertz', 'weibull', 'exp', 'gamma', 'llogis', 
#              'lnorm')
# mod.l.f = (yLt ~ as.factor(datX$sex) + as.factor(datX$origin) + #as.factor(LvZ) + 
#                        datX$Dom_CZ + datX$E.r2.DoB + datX$Con_CZ + datX$Agr_CZ + datX$Neu_CZ + datX$O.r1.DoB
#                      + frailty.gamma(datX$sample))
# testSurvDist <- function(thedistributions, model){
#   distlist = 0
#   LLlist1 = 0
#   LLlist2 = 0
#   estimates = 0
#   fAIC = NULL
#   for (i in 1:length(thedistributions)) {
#     thisdist = thedistributions[i]
#     fit = flexsurvreg(model, dist = thisdist)
#     distlist[i] = thisdist
#     LLlist1[i] = -2*(fit$loglik[1])
#     LLlist2[i] = -2*(fit$loglik[2])
#     fAIC[i] = extractAIC(fit)[2]
#     estimates[i] = exp(as.numeric(fit$coefficients[2]))  }
#   Result = data.frame(distlist, LLlist1, LLlist2, estimates, LLlist1 - LLlist2, fAIC)
#   names(Result) = c("Distribution", "-2*LL(Baseline)", "-2*LL(Full)","Estimate", 'LL diff','AIC')
#   Result = Result[order(Result[,3]),]
#   Result
# }
# testSurvDist(distlist, mod.l.f)

m.flx.EOr <- flexsurvreg(yLt ~ as.factor(sex) +
                       as.factor(origin) + #as.factor(LvZ) +
                       Dom_CZ + E.r2.DoB + Con_CZ +
                       Agr_CZ + Neu_CZ + O.r1.DoB
                       + frailty.gaussian(sample)
                     , data=datX, dist='gengamma')
m.flx.EOr
confint(m.flx.EOr)
plot.flexsurvreg(m.flx.EOr)

# 
# model.Ltrunc.spec = (yLt ~ as.factor(datX$sex) + as.factor(datX$origin) + #as.factor(LvZ) + 
#                        datX$Dom_CZ + datX$E.r2.DoB + datX$Con_CZ + datX$Agr_CZ + datX$Neu_CZ + datX$O.r1.DoB)
# testSurvDist(truncdistributions, model.Ltrunc.spec)

attr(yLt, 'type') <- 'counting'



### TREES ###
# RR = relative risk
# CI = conditional inference

RR.a <- LTRCART(Surv(age_pr, age, stat.log) ~ as.factor(sex) + 
                  as.factor(origin) +  
                  Dom_CZ + Ext_CZ + Con_CZ +
                  Agr_CZ + Neu_CZ + Opn_CZ, data = datX, 
                control = rpart.control(minsplot = 10, cp = 0.0001, xval = 100)
                )
CI.a <- LTRCIT(Surv(age_pr, age, stat.log) ~ as.factor(sex) + 
                  as.factor(origin) +  
                  Dom_CZ + Ext_CZ + Con_CZ +
                  Agr_CZ + Neu_CZ + Opn_CZ,
                Data = datX)
plot(CI.a)
rpart.plot(RR.a)

RR.a.samp <- LTRCART(Surv(age_pr, age, stat.log) ~ as.factor(sex) + 
                       as.factor(origin) +
                       as.factor(sample=='Japan') + as.factor(sample=='Yerkes') +
                     as.factor(sample=='Edinburgh') +
                       Dom_CZ + Ext_CZ + Con_CZ +
                       Agr_CZ + Neu_CZ + Opn_CZ, data = datX,
                     control = rpart.control(minsplot = 10, cp = 0.0001, xval = 100)
                     )
CI.a.samp <- LTRCIT(Surv(age_pr, age, stat.log) ~ as.factor(sex) + 
                       as.factor(origin) +
                       as.factor(sample=='Japan') + as.factor(sample=='Yerkes') +
                       as.factor(sample=='Edinburgh') +
                       Dom_CZ + Ext_CZ + Con_CZ +
                       Agr_CZ + Neu_CZ + Opn_CZ, Data = datX) #,
                     
plot(CI.a.samp)



  (as.factor(datX$sex),
   as.factor(datX$sample=='Japan'),as.factor(datX$sample=='Yerkes'),
   as.factor(datX$sample=='Edinburgh'),
   as.factor(datX$origin), 
   datX$Dom_CZ, datX$Ext_CZ, datX$Con_CZ,
   datX$Agr_CZ, datX$Neu_CZ, datX$Opn_CZ))


