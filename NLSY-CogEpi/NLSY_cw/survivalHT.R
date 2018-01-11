library(survival)
library(eha)
library(survminer)
library(rms)



### getting the survival analyses setup


y = Surv(as.numeric(ht.df$HTdiagDate-ht.df$DOB)/365.25, ht.df$hasHT)




# Obsolete - move to delete
# 
# tset = cw.df[!is.na(cw.df$H50_DR_HighBP_HT),]
# tset = subset(tset, select=-c(H50_Has_HighBP_Hyp))
# tset$H50_DR_HighBP_HT = as.numeric(tset$H50_DR_HighBP_HT) - 1
# tset$age = 79 - as.numeric(levels(tset$DOB_year))[tset$DOB_year]




### Cox modeling

# Are assumptions valid...?
# Useful: http://www.sthda.com/english/wiki/cox-model-assumptions

cph.0 = coxph(y ~ SAMPLE_SEX + AFQT89,
              data = ht.df)

test.ph.0 = cox.zph(cph.0)
ggcoxzph(test.ph.0)

test.fit.0 = npsurv(y ~ SAMPLE_SEX,
                     data = ht.df)
survplot(test.fit.0, loglog=T)



cph.1 = coxph(y ~ SAMPLE_SEX * AFQT89,
              data = ht.df)

summary(cph.1)



cph.2 = coxph(y ~ SAMPLE_SEX * AFQT89 + Child_SES,
              data = ht.df)

summary(cph.2)



cph.3 = coxph(y ~ SAMPLE_SEX * AFQT89 + Child_SES + Adult_SES,
              data = ht.df)

summary(cph.3)



cph.4 = coxph(y ~ SAMPLE_SEX * AFQT89 + Child_SES + 
                SES_Income_USE
                #SES_Education_USE
                #SES_OccStatus_USE
              ,data = ht.df)

summary(cph.4)



### AFT modeling

#attr(y,'type') <- 'right'


aft.0 = survreg(y ~ SAMPLE_SEX + AFQT89,
                data = ht.df)
summary(aft.0)


aft.0 = aftreg(y ~ SAMPLE_SEX + AFQT89,
               data = ht.df, dist='gompertz')
summary(aft.0)


aft.1 = aftreg(y ~ SAMPLE_SEX * AFQT89,
                 data = ht.df, dist='gompertz')
summary(aft.1)


aft.2 = aftreg(y ~ SAMPLE_SEX * AFQT89 + Child_SES,
               data = ht.df, dist='gompertz')
summary(aft.2)


aft.3 = aftreg(y ~ SAMPLE_SEX * AFQT89 + Child_SES + Adult_SES, 
               data = ht.df, dist='gompertz')
summary(aft.3)



### Testing sensitivity for Adult_SES components

aft.4 = aftreg(y ~ SAMPLE_SEX * AFQT89 + Child_SES +
                 + SES_Income_USE
               ,data = ht.df, dist='gompertz')
summary(aft.4)


aft.5 = aftreg(y ~ SAMPLE_SEX * AFQT89 + Child_SES +
               + SES_Education_USE
               ,data = ht.df, dist='gompertz')
summary(aft.5)


aft.6 = aftreg(y ~ SAMPLE_SEX * AFQT89 + Child_SES +
                 + SES_OccStatus_USE
               ,data = ht.df, dist='gompertz')
summary(aft.6)

