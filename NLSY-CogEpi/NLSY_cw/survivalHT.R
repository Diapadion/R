library(survival)
library(eha)
library(survminer)
library(rms)
library(ggplot2)





# cor(ht.df$AFQT89, as.numeric(ht.df$age_1979), use='pairwise.complete.obs', method='spearman')

ggplot(ht.df,aes(y=AFQT89,x=age_1979)) + stat_binhex()
ggplot(ht.df,aes(y=Child_SES,x=age_1979)) + stat_binhex()
ggplot(ht.df,aes(y=Adult_SES,x=age_1979)) + stat_binhex()
ggplot(ht.df,aes(y=SES_Income_USE,x=age_1979)) + stat_binhex()

ggplot(ht.df,aes(y=AFQT89,x=SES_Income_USE)) + stat_binhex()
ggplot(ht.df,aes(y=AFQT89,x=indiv_income)) + stat_binhex()

ggplot(ht.df,aes(y=AFQT89,x=bmi_85)) + stat_binhex()
ggplot(ht.df,aes(y=AFQT89,x=bmi_06)) + stat_binhex()

summary(lm(bmi_85 ~ SAMPLE_SEX*AFQT89, data=ht.df))
summary(lm(bmi_06 ~ SAMPLE_SEX*AFQT89, data=ht.df))



# Obsolete - move to delete
# 
# tset = cw.df[!is.na(cw.df$H50_DR_HighBP_HT),]
# tset = subset(tset, select=-c(H50_Has_HighBP_Hyp))
# tset$H50_DR_HighBP_HT = as.numeric(tset$H50_DR_HighBP_HT) - 1
# tset$age = 79 - as.numeric(levels(tset$DOB_year))[tset$DOB_year]




### Cox modeling

# Are assumptions valid...?
# Useful: http://www.sthda.com/english/wiki/cox-model-assumptions

cph.0 = coxph(y ~ SAMPLE_SEX + AFQT89 + age_1979,
              data = ht.df[A,])
summary(cph.0)

test.ph.0 = cox.zph(cph.0)
ggcoxzph(test.ph.0)

test.fit.0 = npsurv(y ~ SAMPLE_SEX,
                     data = ht.df)
survplot(test.fit.0, loglog=T)



cph.1 = coxph(y ~ SAMPLE_SEX * AFQT89 + age_1979,
              data = ht.df[A,])

summary(cph.1)

test.ph.1 = cox.zph(cph.1)
ggcoxzph(test.ph.1)



cph.2 = coxph(y ~ SAMPLE_SEX * AFQT89 + age_1979 + Child_SES,
              data = ht.df)

summary(cph.2)



cph.3 = coxph(y ~ SAMPLE_SEX * AFQT89 + age_1979 + Child_SES + Adult_SES,
              data = ht.df[A,])

summary(cph.3)

test.ph.3 = cox.zph(cph.3)
ggcoxzph(test.ph.3)


cph.4 = coxph(y ~ SAMPLE_SEX * AFQT89 + age_1979 + Child_SES + 
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


# aft.0.ll = survreg(y ~ SAMPLE_SEX + AFQT89 + age_1979,
#                 data = ht.df, dist='loglogistic')
# confint(aft.0.ll)


aft.0.ll = aftreg(y ~ SAMPLE_SEX + AFQT89 + age_1979,
               data = ht.df[A,], #dist='gompertz')
               dist = 'loglogistic')
summary(aft.0.ll)

aft.0.g = aftreg(y ~ SAMPLE_SEX + AFQT89 + age_1979,
                  data = ht.df[A,], dist='gompertz')

aft.0.w = aftreg(y ~ SAMPLE_SEX + AFQT89 + age_1979,
                 data = ht.df[A,], dist='weibull')

aft.0.ev = aftreg(y ~ SAMPLE_SEX + AFQT89 + age_1979,
                 data = ht.df[A,], dist='ev')

aft.0.ln = aftreg(y ~ SAMPLE_SEX + AFQT89 + age_1979,
                 data = ht.df[A,], dist='lognormal')

extractAIC(aft.0.ll)
extractAIC(aft.0.g)
extractAIC(aft.0.w)
extractAIC(aft.0.ev)
extractAIC(aft.0.ln)

print(aft.0.ll)


aft.1.ll = aftreg(y ~ SAMPLE_SEX * AFQT89 + age_1979,
                 data = ht.df[A,], dist='loglogistic') #'gompertz')

aft.1.g = aftreg(y ~ SAMPLE_SEX * AFQT89 + age_1979,
               data = ht.df[A,], dist='gompertz')

aft.1.w = aftreg(y ~ SAMPLE_SEX * AFQT89 + age_1979,
                 data = ht.df[A,], dist='weibull')

aft.1.ev = aftreg(y ~ SAMPLE_SEX * AFQT89 + age_1979,
                 data = ht.df[A,], dist='ev')

aft.1.ln = aftreg(y ~ SAMPLE_SEX * AFQT89 + age_1979,
                 data = ht.df[A,], dist='lognormal')

extractAIC(aft.1.ll)
extractAIC(aft.1.g)
extractAIC(aft.1.w)
extractAIC(aft.1.ev)
extractAIC(aft.1.ln)

# Loglogistic is always better

summary(aft.1.ll)



aft.2 = aftreg(y ~ SAMPLE_SEX * AFQT89 + age_1979 + Child_SES,
               data = ht.df[A,], dist='loglogistic') 
               #dist = 'gompertz')
summary(aft.2)


aft.3 = aftreg(y ~ SAMPLE_SEX * AFQT89 + age_1979 + Child_SES + Adult_SES, 
               data = ht.df[A,], dist='loglogistic')
               #dist='gompertz')
summary(aft.3)

extractAIC(aft.3)



### Testing sensitivity for Adult_SES components

aft.4 = aftreg(y ~ SAMPLE_SEX * AFQT89 + age_1979 + Child_SES +
                 + SES_Income_USE
               ,data = ht.df[A,], dist='loglogistic')
               #dist='gompertz')
summary(aft.4)
extractAIC(aft.4)

aft.5 = aftreg(y ~ SAMPLE_SEX * AFQT89 + age_1979 + Child_SES +
               + SES_Education_USE#*SAMPLE_SEX
               ,data = ht.df[A,], dist='loglogistic')
               #dist='gompertz')
summary(aft.5)


aft.6 = aftreg(y ~ SAMPLE_SEX * AFQT89 + age_1979 + Child_SES +
                 + SES_OccStatus_USE#*SAMPLE_SEX
               ,data = ht.df[A,], dist='loglogistic')
               #dist='gompertz')
summary(aft.6)


#ht.df$incIQint = ht.df$SES_Income_USE * (as.numeric(ht.df$SAMPLE_SEX)-1)


## see GDerEdits for the formal version of this
aft.4.i = aftreg(y ~ SAMPLE_SEX * AFQT89 + age_1979 + Child_SES + Adult_SES
                   + SES_Income_USE * SAMPLE_SEX
                 ,data = ht.df[A,], dist='loglogistic')
summary(aft.4.i)
confint(aft.4.i)

extractAIC(aft.4.i)


## see GDerEdits for the formal version of this
aft.7 = aftreg(y ~ SAMPLE_SEX * AFQT89 + age_1979 + Child_SES + Adult_SES
                 #+ incIQint 
               + SES_Income_USE * SAMPLE_SEX + indiv_income
               ,data = ht.df[A,], dist='loglogistic')
summary(aft.7)
extractAIC(aft.7)


# Poor fit, no need for
# aft.7.0 = aftreg(y ~ SAMPLE_SEX * AFQT89 + age_1979 + Child_SES +
#                  + indiv_income
#                ,data = ht.df, dist='loglogistic')
# summary(aft.7.0)


## again, see GDerEdits for the formal version of this
aft.7.i = aftreg(y ~ SAMPLE_SEX * AFQT89 + age_1979 + Child_SES + Adult_SES
                 + SES_Income_USE * SAMPLE_SEX 
                 #+ incIQint 
                 + indiv_income*SAMPLE_SEX
               ,data = ht.df[A,], dist='loglogistic')
summary(aft.7.i)
extractAIC(aft.7.i)




##-------------------------------



### Testing sensitivity of lifestyle factors

aft.8 = aftreg(y ~ SAMPLE_SEX * AFQT89 + age_1979 + Child_SES + Adult_SES
               + incIQint + indiv_income
                 + bmi_85
               ,data = ht.df, dist='loglogistic')
summary(aft.8)
extractAIC(aft.8)

aft.9 = aftreg(y ~ SAMPLE_SEX * AFQT89 + age_1979 + Child_SES + Adult_SES
               + incIQint + indiv_income
                 + bmi_85 + bmi_06 #bmi_diff
               ,data = ht.df, dist='loglogistic')
summary(aft.9)
extractAIC(aft.9)



aft.9.alt = aftreg(y ~ SAMPLE_SEX * AFQT89 + age_1979 + Child_SES + Adult_SES
                   + incIQint + indiv_income
               + bmi_06
               ,data = ht.df, dist='loglogistic')
summary(aft.9.alt)
extractAIC(aft.9.alt)






aft.10 = aftreg(y ~ SAMPLE_SEX * AFQT89 + age_1979 + Child_SES + Adult_SES
                + incIQint + indiv_income
                  + bmi_85 + bmi_06*SAMPLE_SEX
               ,data = ht.df, dist='loglogistic')
summary(aft.10)
extractAIC(aft.10)














### Old - not used ###

aft.8 = aftreg(y ~ SAMPLE_SEX * AFQT89 + age_1979 + Child_SES +
                 + SES_Income_USE*SAMPLE_SEX + indiv_income +
                 Drinks_avgDay
               ,data = ht.df, dist='loglogistic')
extractAIC(aft.8)
extractAIC(aft.7.i)
summary(aft.8)



aft.9 = aftreg(y ~ SAMPLE_SEX * AFQT89 + age_1979 + Child_SES +
                 + SES_Income_USE*SAMPLE_SEX + indiv_income +
                 Smoked_atLeast100 #+ Smoked_everDaily
               ,data = ht.df, dist='loglogistic')
summary(aft.9)



aft.10 = aftreg(y ~ SAMPLE_SEX * AFQT89 + age_1979 + Child_SES +
                 + SES_Income_USE*SAMPLE_SEX + indiv_income +
                 H_activity
               ,data = ht.df, dist='loglogistic')

summary(aft.10)



aft.11 = aftreg(y ~ SAMPLE_SEX * AFQT89 + age_1979 + Child_SES +
                  + SES_Income_USE*SAMPLE_SEX + indiv_income +
                  H_activity + Drinks_avgDay
                ,data = ht.df, dist='loglogistic')

summary(aft.11)


aft.12 = aftreg(y ~ SAMPLE_SEX * AFQT89 + age_1979 + Child_SES +
                  + SES_Income_USE*SAMPLE_SEX + indiv_income +
                  bmi
                ,data = ht.df, dist='loglogistic')

summary(aft.12)


aft.13 = aftreg(y ~ SAMPLE_SEX * AFQT89 + age_1979 + Child_SES +
                  + SES_Income_USE * SAMPLE_SEX 
                + indiv_income +
                  bmi + #Read_nutrition #+ Read_ingredients
                  Sugary_drink
                ,data = ht.df, dist='loglogistic')

summary(aft.13)

### end unused segment ###






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
