### Power analysis and 

library(survival)
library(psych)
library(bbmle)
library(ggplot2)
library(powerSurvEpi)
library(LTRCtrees)
library(rpart.plot)


set.seed(123)



### Power Analysis


## formula for Hazard ratio from AFT:
#  HazRat = exp(coefficient(s) * -1 * 1/scale)

gorillaEHR = exp(0.272 * -1 * 1/(exp(-0.317))) # from Weiss et al. 2012, RSPB
# print(gorillaEHR)
# [1] 0.6883508
# round to a more conservative 0.7


# Change X1 and re-run the command below to get power estimates
# for individual personality variables.
# See plotting.R for full power analyses and plots.

powerEpiCont(formula = (age - age_pr) ~ as.factor(sex) + 
               as.factor(origin) +  
               Dom_CZ + Ext_CZ + datX$Con_CZ +
               Agr_CZ + Neu_CZ + Opn_CZ,
             #X1 = Con_CZ
             #X1 = Ext_CZ
             #X1 = Opn_CZ
             #X1 = Dom_CZ
             #X1 = Neu_CZ
             #X1 = Agr_CZ
             ,failureFlag = datX$status ,
             dat=datX,
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
mean(persPwr)
  


### Trees
## RR = relative risk
## CI = conditional inference

set.seed(123)

### Unadjusted

RR.u <- LTRCART(Surv(age_pr, age, stat.log) ~ 
                  sex + origin +  
                  Dom_CZ + Ext_CZ + Con_CZ +
                  Agr_CZ + Neu_CZ + Opn_CZ, 
                data = datX
                #, control = rpart.control(minsplot = 10, cp = 0.0001, xval = 100)
                )
rpart.plot(RR.u)

CI.u <- LTRCIT(Surv(age_pr, age, stat.log) ~
                 sex + origin +  
                 Dom_CZ + Ext_CZ + Con_CZ +
                 Agr_CZ + Neu_CZ + Opn_CZ, 
                data = datX)



### Residualized

RR.r <- LTRCART(Surv(age_pr, age, stat.log) ~ 
                  sex + origin +  
                  D.gr + E.gr + C.gr +
                  A.gr + N.gr + O.gr,
                data = datX
                #, control = rpart.control(minsplot = 10, cp = 0.0001, xval = 100)
)


CI.r <- LTRCIT(Surv(age_pr, age, stat.log) ~
                 sex + origin +  
                 D.gr + E.gr + C.gr +
                 A.gr + N.gr + O.gr, 
               data = datX)

# Figure 3:
plot(CI.u)
plot(CI.r)

rpart.plot(RR.r)




