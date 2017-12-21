### Mortality

library(SAScii)
library(dplyr)
library(survival)
library(lubridate)

s = function(x){scale(x)}



### Humans

nh.mort = read.SAScii(fn = 'M:/NHANES III/mortality/NHANES_III_MORT_2011_PUBLIC.dat',
                      sas_ri='M:/NHANES III/mortality/SAS-Read-in-Program-All-Surveys.sas')

h.mort = merge(sel.nbm[sampl.cfa,], nh.mort, by.x = 'subject', by.y = 'SEQN')

h.mort$sumAL = rowMeans(cbind(s(h.mort$BPs),s(h.mort$BPd),s(h.mort$cholesterol),s(h.mort$triglycerides),
                              s(h.mort$phosphate),s(h.mort$BMI)), na.rm = T)

h.mort = h.mort[h.mort$ELIGSTAT == 1,]

# months from exam

h.mort$lastAge = h.mort$PERMTH_EXM/12 + h.mort$age

h.mort$status = as.factor(h.mort$MORTSTAT)
table(h.mort$status)

levels(h.mort$status)[levels(h.mort$status)=="1"] <- TRUE
levels(h.mort$status)[levels(h.mort$status)=="0"] <- FALSE
h.mort$status = as.logical(h.mort$status)



### Chimps

c.mort = read.csv('cMortality.csv')

c.mort = merge(c.mort,c.bm.m, by.x='chimp',by.y='subject')

c.mort$DoB = as.Date(c.mort$DoB, format="%m/%d/%Y")
c.mort$lastDate = as.Date(c.mort$lastDate, format="%d/%m/%Y")

c.mort$lastAge = 1.5*(as.numeric(c.mort$lastDate) - as.numeric(c.mort$DoB))/365
  

  
### Getting individual AL values

c.mort$sumAL = rowMeans(cbind(s(c.mort$BPs),s(c.mort$BPd),s(c.mort$cholesterol),s(c.mort$triglycerides),
                              s(c.mort$phosphate),s(c.mort$BMI)), na.rm = T)



### Formatting status var

table(c.mort$status)

c.mort$status[c.mort$status=='LTF'] = 'Alive'
c.mort$status = droplevels(c.mort$status)

levels(c.mort$status)[levels(c.mort$status)=="Death"] <- TRUE
levels(c.mort$status)[levels(c.mort$status)=="Alive"] <- FALSE
c.mort$status = as.logical(c.mort$status)



### Independent survival analyses

y.c = Surv(c.mort$age,c.mort$lastAge,c.mort$status, type='counting')

cox1.c = coxph(y.c ~ sumAL + sex , data = c.mort)
cox1.c$coefficients
summary(cox1.c)


y.h = Surv(h.mort$age,h.mort$lastAge,h.mort$status, type='counting')

cox1.h = coxph(y.h ~ sumAL + sex , data = h.mort)
cox1.h$coefficients
summary(cox1.h)

