

m1 <- survreg(yLt ~ Ext_CZ
                       , dist = "t", data=datX
)
summary(m1)


mA <- survreg(y ~ Ext_CZ 
               , dist = "loglogistic", data=Dataset)
  
mB <- survreg(y ~ Ext_CZ + age_pr
              , dist = "loglogistic", data=Dataset)
summary(mB)
  
mC <- survreg(y ~ Ext_CZ * age_pr
              , dist = "loglogistic", data=Dataset)
summary(mC)


m2 <- survreg(yLt ~ Ext_CZ + Ext_CZ:as.numeric(DoB)
              , dist = "t", data=datX
)
summary(m2)


  
  
  
mZ <- survreg(y ~ as.factor(Dataset$sex) + Dataset$age_pr + #Dataset$age + 
                as.factor(Dataset$origin) + as.factor(Dataset$LvZ) + 
                Dataset$Dom_CZ + Dataset$Ext_CZ + Dataset$Con_CZ +
                Dataset$Agr_CZ + Dataset$Neu_CZ + Dataset$Opn_CZ,
          dist="loglogistic")
  
  
  
  
  
  
  



m0e<- survreg(yLt ~ as.factor(sex) + 
                         as.factor(origin) + as.factor(LvZ) + 
                         Dom_CZ + Ext_CZ + Con_CZ +
                         Agr_CZ + Neu_CZ + Opn_CZ
                       + as.numeric(DoB):Ext_CZ
                       , dist = "t", data=datX
)
confint(m0e, type="boot")

m0eo <- survreg(yLt ~ as.factor(sex) + 
                as.factor(origin) + as.factor(LvZ) + 
                Dom_CZ + Ext_CZ + Con_CZ +
                Agr_CZ + Neu_CZ + Opn_CZ
              + as.numeric(DoB):Ext_CZ + as.numeric(DoB):Opn_CZ
              , dist = "t", data=datX
)

m0ed <- survreg(yLt ~ as.factor(sex) + 
                  as.factor(origin) + as.factor(LvZ) + 
                  Dom_CZ + Ext_CZ + Con_CZ +
                  Agr_CZ + Neu_CZ + Opn_CZ
                + as.numeric(DoB):Ext_CZ + as.numeric(DoB):Dom_CZ
                , dist = "t", data=datX
)

m0exwDoB <- survreg(yLt ~ as.factor(sex) + 
                  as.factor(origin) + as.factor(LvZ) + 
                  Dom_CZ + Ext_CZ + Con_CZ +
                  Agr_CZ + Neu_CZ + Opn_CZ
                + as.factor(origin):Ext_CZ + as.numeric(DoB):Ext_CZ
                , dist = "t", data=datX
)






# testing

lfit6 <- survreg(Surv(time, status)~pspline(age, df=2), cancer)
plot(cancer$age, predict(lfit6), xlab='Age', ylab="Spline prediction")
title("Cancer Data")
fit0 <- coxph(Surv(time, status) ~ ph.ecog + age, cancer)
fit1 <- coxph(Surv(time, status) ~ ph.ecog + pspline(age,3), cancer)
fit3 <- coxph(Surv(time, status) ~ ph.ecog + pspline(age,8), cancer)
fit0
fit1
fit3
