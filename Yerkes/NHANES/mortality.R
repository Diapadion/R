### Mortality

library(SAScii)
library(dplyr)
s = function(x){scale(x)}


### Humans

nh.mort = read.SAScii(fn = 'M:/NHANES III/mortality/NHANES_III_MORT_2011_PUBLIC.dat',
                      sas_ri='M:/NHANES III/mortality/SAS-Read-in-Program-All-Surveys.sas')

h.mort = merge(sel.nbm[sampl.cfa,], nh.mort, by.x = 'subject', by.y = 'SEQN')

h.mort$lvAL = lavPredict(final.modAL)[[1]]
h.mort$sumAL = rowMeans(cbind(s(h.mort$BPs),s(h.mort$BPd),s(h.mort$cholesterol),s(h.mort$triglycerides),
                              s(h.mort$phosphate),s(h.mort$BMI)), na.rm = T)

h.mort = h.mort[!is.na(h.mort$lvAL),]
h.mort = h.mort[h.mort$ELIGSTAT == 1,]

# months from exam

h.mort$lastAge = h.mort$PERMTH_EXM/12 + h.mort$age

h.mort$status = as.factor(h.mort$MORTSTAT)
table(h.mort$status)

levels(h.mort$status)[levels(h.mort$status)=="1"] <- TRUE
levels(h.mort$status)[levels(h.mort$status)=="0"] <- FALSE
h.mort$status = as.logical(h.mort$status)


### Chimps

c.mort = read.csv('../mortality/BMnPersChimpMortality-workVersion.csv')

c.mort = c.mort[-c(247:264),]
c.mort = c.mort[!(c.mort$chimp==''),]
c.mort = c.mort[,c(1,3:5)]

#intersect(c.mort$chimp,c.bm.m$subject)
#setdiff(c.mort$chimp,c.bm.m$subject)

c.mort = merge(c.mort,c.bm.m, by.x='chimp',by.y='subject')

c.mort$DoB = as.Date(c.mort$DoB, format="%m/%d/%Y")
c.mort$lastDate = as.Date(c.mort$lastDate, format="%d/%m/%Y")

c.mort$lastAge = 1.5*(as.numeric(c.mort$lastDate) - as.numeric(c.mort$DoB))/365
  
  
### Getting individual AL values

c.mort$sumAL = rowMeans(cbind(s(c.mort$BPs),s(c.mort$BPd),s(c.mort$cholesterol),s(c.mort$triglycerides),
                              s(c.mort$phosphate),s(c.mort$BMI)), na.rm = T)
table(is.na(c.mort$lastDate))
c.mort$lvAL = matrix(lavPredict(final.modAL)[[2]])
cor(c.mort$lvAL,c.mort$sumAL)



### Formatting status var

table(c.mort$status)

c.mort$status[c.mort$status=='LTF'] = 'Alive'
c.mort$status = droplevels(c.mort$status)

levels(c.mort$status)[levels(c.mort$status)=="Death"] <- TRUE
levels(c.mort$status)[levels(c.mort$status)=="Alive"] <- FALSE
c.mort$status = as.logical(c.mort$status)



### Independent survival analyses

library(survival)
library(lubridate)

y.c = Surv(c.mort$age,c.mort$lastAge,c.mort$status, type='counting')

View(y.c)
# Storer and Duncan, what the hell?

# which(is.na(y.c))
# c.mort$chimp[which(is.na(y.c))]
# 
# temp = c.mort[which(is.na(y.c)),]
# Surv(temp$age,temp$lastAge,temp$status, type='mstate')

# Their aggregated 'age' variable is a problem - puts them older on avg than their known date of death
# These records can't be trusted, remove them.



cox1.c = coxph(y.c ~ sumAL + sex , data = c.mort)
cox1.c$coefficients
summary(cox1.c)


coxN.c = coxph(y.c ~ BPs , data = c.mort)
summary(coxN.c)





y.h = Surv(h.mort$age,h.mort$lastAge,h.mort$status, type='counting')
cox1.h = coxph(y.h ~ sumAL + sex , data = h.mort)
cox1.h$coefficients
summary(cox1.h)




### Only associating with age at death


m.AgeAtD.c = lm(lastAge ~ sumAL + age + sex, 
                data = c.mort[c.mort$status,])
summary(m.AgeAtD.c)




m.AgeAtD.h = lm(lastAge ~ sumAL + age + sex, 
                data = h.mort[h.mort$status,])
summary(m.AgeAtD.h)

m.AgeAtD.h.N = lm(lastAge ~ , 
                data = h.mort[h.mort$status,])
summary(m.AgeAtD.h.N)





### Trees?

library(LTRCtrees)

RR.c <- LTRCART(Surv(age,lastAge,status) ~ sex + age + sumAL
                  , data = c.mort[-c(51,161)], 
                control = rpart.control(minsplot = 10, cp = 0.0001, xval = 100)
)

CI.c <- LTRCIT(Surv(age,lastAge,status) ~ sex + age + sumAL
                , data = c.mort[c(-51,-161)])

CI.c <- LTRCIT(Surv(age_pr, age, stat.log) ~ as.factor(sex) + 
                 as.factor(origin) +  
                 Dom_CZ + Ext_CZ + Con_CZ +
                 Agr_CZ + Neu_CZ + Opn_CZ,
               Data = datX)
