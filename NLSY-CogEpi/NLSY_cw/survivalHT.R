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



cph.7 = coxph(y ~ SAMPLE_SEX * AFQT89 + Child_SES + 
                SES_Income_USE
              #SES_Education_USE
              #SES_OccStatus_USE
              + as.numeric(BP.meds.2008)*SAMPLE_SEX
              ,data = ht.df)
summary(cph.7)



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

aft.4.i = aftreg(y ~ SAMPLE_SEX * AFQT89 + Child_SES +
                 + SES_Income_USE * SAMPLE_SEX
               ,data = ht.df, dist='gompertz')
summary(aft.4.i)


aft.5 = aftreg(y ~ SAMPLE_SEX * AFQT89 + Child_SES +
               + SES_Education_USE*SAMPLE_SEX
               ,data = ht.df, dist='gompertz')
summary(aft.5)


aft.6 = aftreg(y ~ SAMPLE_SEX * AFQT89 + Child_SES +
                 + SES_OccStatus_USE#*SAMPLE_SEX
               ,data = ht.df, dist='gompertz')
summary(aft.6)



### Testing sensitivity of lifestyle factors



### I'm not sure what is happening below means anything...
### because events that happen after HT diagnosis (like taking medication) are CAUSED by it
### lifestyle factors ALSO could change after the diagnosis
### we need earlier measures of that...



## HT medication
aft.7 = aftreg(y ~ SAMPLE_SEX * AFQT89 + Child_SES + SES_Income_USE
                       + SAMPLE_SEX * as.numeric(BP.meds.2014)
                       ,data = ht.df, dist='gompertz')
summary(aft.7)
# Woah.


# ## So do smart women go to the doctor more?
# aft.8 = aftreg(y ~ SAMPLE_SEX * AFQT89 + Child_SES + SES_Income_USE
#                + as.numeric(BP.measured.2014)
#                ,data = ht.df, dist='gompertz')
# summary(aft.8)


## Do smart women with HT take medication more?
glm.1 = glm(as.integer(BP.meds.2010) ~ SAMPLE_SEX * AFQT89,
            data=ht.df[ht.df$hasHT==1,],
            family=binomial()
            )
summary(glm.1)

cor(ht.df$BP.measured.2010, ht.df$BP.meds.2010, use='pairwise.complete.obs') # TODO: split by gender?


## Do smart women get screened more?
ht.df$screens.HT= rowSums(ht.df[,c('BP.measured.2008','BP.measured.2010','BP.measured.2012','BP.measured.2014')], na.rm=T)
#ht.df$screens.HT = as.ordered(ht.df$screens.HT)

lrm.1 = lrm(screens.HT ~ SAMPLE_SEX * AFQT89,
            data=ht.df[complete.cases(ht.df[,c(76:79)]),]
            #data=ht.df#[ht.df$hasHT==1,],
)
summary(lrm.1)

# Sanity check
lm.1 = lm(screens.HT ~ SAMPLE_SEX * AFQT89,
            data=ht.df[complete.cases(ht.df[,c(76:79)]),]
            #data=ht.df#[ht.df$hasHT==1,],
)
summary(lm.1)



### Not sleep
# aft.7 = aftreg(y ~ SAMPLE_SEX * AFQT89 + Child_SES + SES_Income_USE
#                        + H50_sleep_3 * SAMPLE_SEX
#                        ,data = ht.df, dist='gompertz')
# summary(aft.7)
