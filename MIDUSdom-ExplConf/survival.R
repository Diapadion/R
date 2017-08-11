library(survival)
library(LTRCtrees)
library(rpart)
library(eha)



#mXmort = 
load('z:/MIDUS III/ICPSR_36346 (mortality)/DS0002/36346-0002-Data.rda')

# plot(m1exp$Agn, m1exp$Age) # uninterepretable and not relevant based on corr.s


m1exp.t = merge(m1exp, da36346.0002, by = 'M2ID', all.x = T)


m1exp.t$DECEASED = !is.na(m1exp.t$DECEASED)

m1exp.t$DOD_Y[!m1exp.t$DECEASED] = 2015
m1exp.t$DOD_M[!m1exp.t$DECEASED] = 10

m1exp.t$end = (m1exp.t$DOD_Y + (m1exp.t$DOD_M-1)/12 - m1exp.t$`Birth year`)

m1exp.surv = Surv(m1exp.t$Age, m1exp.t$end, m1exp.t$DECEASED, type='counting')




### Models

m1 <- aftreg(m1exp.surv ~ Sex, 
       data = m1exp, dist='gompertz', param = 'lifeAcc'
       )
summary(m1)
km.by.sex <- survfit(m1exp.surv ~ Sex, data = m1exp, conf.type = "log-log")
survplot(km.by.sex)



m2 <- aftreg(m1exp.surv ~ Con + Opn + Ext + Neu + Agr,
            data = m1exp, dist='gompertz', param = 'lifeAcc'
)
summary(m2)



m3 <- aftreg(m1exp.surv ~ Agn,
             data = m1exp, dist='weibull', param = 'lifeAcc'
)
summary(m3)

m3 <- aftreg(m1exp.surv ~ Agn + Con + Opn + Ext + Neu + Agr,
             data = m1exp, dist='gompertz', param = 'lifeAcc'
)
summary(m3)


Agn.sd = sd(m1exp.t$Agn, na.rm=T)
Agn.m = mean(m1exp.t$Agn, na.rm=T)
m1exp.t$Agn_cut = 2
m1exp.t$Agn_cut[m1exp.t$Agn < Agn.m - Agn.sd/3] = 1
m1exp.t$Agn_cut[m1exp.t$Agn > Agn.m + Agn.sd/3] = 3
table(m1exp.t$Agn_cut)


survplot(npsurv(m1exp.surv ~ m1exp.t$Agn_cut))





m1 <- coxph(m1exp.surv ~ Sex,
            data = m1exp)
summary(m1)



m2 <- coxph(m1exp.surv ~ Con,
            data = m1exp)
summary(m2)

m2 <- coxph(m1exp.surv ~ Con + Opn + Ext + Neu + Agr,
            data = m1exp)
summary(m2)



m3 <- coxph(m1exp.surv ~ Agn,
            data = m1exp)
summary(m3)

m3 <- coxph(m1exp.surv ~ Agn + Con + Opn + Ext + Neu + Agr,
            data = m1exp)
summary(m3)






### Trees

RRT1 = LTRCART(Surv(Age, end, DECEASED) ~ Sex + Agn + Con + Opn + Ext + Neu + Agr
               ,data = m1exp.t)
summary(RRT1)
plot(RRT1)
text(RRT1, use.n=T)



CIT1 = LTRCIT(Surv(Age, end, DECEASED) ~ Agn + Con + Opn + Ext + Neu + Agr
               ,data = m1exp.t)
summary(CIT1)
