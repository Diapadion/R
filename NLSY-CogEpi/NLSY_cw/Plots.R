### Plots demonstrating interaction

library(survival)
library(Hmisc)
library(rms)
library(effects)
library(ggplot2)
library(RGraphics)
library(gridExtra)
library(survminer)
library(jtools)



### Quartiles

# ht.df$IQquart <- with(ht.df,cut(AFQT89, 
#                                 breaks=quantile(AFQT89, probs=seq(0,1, by=0.25), na.rm=TRUE), 
#                                 include.lowest=TRUE))


# Tertiles

ht.df$IQtert <- with(ht.df,cut(AFQT89, 
                                breaks=quantile(AFQT89, probs=seq(0,1, by=1/3), na.rm=TRUE), 
                                include.lowest=TRUE))

table(ht.df$IQtert, ht.df$SAMPLE_SEX)



### Kaplan-Meier plots

npsf.1 = npsurv(y ~ IQquart, data=ht.df)

par(mfrow=c(1,1))
survplot(npsf.1, xlab = 'Age', ylim=c(0.6,1),xlim=c(15,59), label.curves=F)


npsf.m = npsurv(y[ht.df$SAMPLE_SEX=='MALE',] ~ IQtert, data=ht.df[ht.df$SAMPLE_SEX=='MALE',])
npsf.f = npsurv(y[ht.df$SAMPLE_SEX=='FEMALE',] ~ IQtert, data=ht.df[ht.df$SAMPLE_SEX=='FEMALE',])

par(mfrow=c(1,2))

survplot(npsf.m, xlab = 'Age',ylim=c(0.6,1),xlim=c(15,59), label.curves=F,col='cornflowerblue'
         
         )

survplot(npsf.f, xlab = 'Age',ylim=c(0.6,1),xlim=c(15,59), label.curves=F,col = 'coral2',
           add=TRUE)


# Create new categorical variable combining sex and tertiles

ht.df$sex_tert = interaction(ht.df$SAMPLE_SEX,ht.df$IQtert)

levels(ht.df$sex_tert) <- c('M-Low','F-Low','M-Mid','F-Mid','M-High','F-High')

npsf.2 = npsurv(y ~ sex_tert, data=ht.df[A,])
survplot(npsf.2, xlab='Age',ylab='Probability of developing hypertension',ylim=c(0.6,1),xlim=c(15,59),
         label.curves=F, col=c('skyblue3','coral2','skyblue3','coral2','skyblue3','coral2')
         , col.fill=c('skyblue','coral','skyblue','coral','skyblue','coral')
         , lty = c(1,1,2,2,3,3)
)



### ggplot attempt - this is the pub plot

ggfit = survfit(Surv(recordTime, hasHT) ~ sex_tert, data=ht.df[A,])

ggsurvplot(ggfit, conf.int=T,censor=F
           , linetype = c(1,1,2,2,3,3)
           #, color = c(1,2,1,2,1,2)
           , palette = c('dodgerblue','violetred1','dodgerblue','violetred1','dodgerblue','violetred1')
           , legend = c(0.2, 0.2) #'none'
           ) + 
  coord_cartesian(xlim=c(15,58),ylim=c(0.1,1.0))+
  xlab('Age')+ylab('Proportion that remains normotensive')+
  scale_x_continuous(limits = c(15,58), breaks=seq(15,57,6))

  #theme(axis.title.y='Risk of developing hypertension', axis.title.x='Age')


## Try with only values with income var - why won't it work?
ggfit = survfit(y[complete.cases(ht.df$SES_Income_USE)] ~ sex_tert, data=ht.df[complete.cases(ht.df$SES_Income_USE),])

ggsurvplot(ggfit, conf.int=T,censor=F
           , linetype = c(1,1,2,2,3,3)
           #, color = c(1,2,1,2,1,2)
           , palette = c('dodgerblue','violetred1','dodgerblue','violetred1','dodgerblue','violetred1')
           , legend = c(0.2, 0.2) #'none'
) + 
  coord_cartesian(xlim=c(15,58),ylim=c(0.6,1.0))+
  xlab('Age')+ylab('Proportion that remains normotensive')+
  scale_x_continuous(limits = c(15,58), breaks=seq(15,57,6))




### Attempt to residualize Income on IQ

IQinc.lm <- lm(AFQT89 ~ SES_Income_USE, data = ht.df, na.action=na.exclude)
ht.df$IQresids = residuals(IQinc.lm)
ht.df$IQtertRs <- with(ht.df,cut(IQresids, 
                               breaks=quantile(IQresids, probs=seq(0,1, by=1/3), na.rm=TRUE), 
                               include.lowest=TRUE))
ht.df$sex_tertRs = interaction(ht.df$SAMPLE_SEX,ht.df$IQtertRs)
levels(ht.df$sex_tertRs) <- c('M-Low','F-Low','M-Mid','F-Mid','M-High','F-High')

ggfit2 = survfit(y ~ sex_tertRs, data=ht.df)

ggsurvplot(ggfit2, conf.int=T,censor=F
           , linetype = c(1,1,2,2,3,3)
           #, color = c(1,2,1,2,1,2)
           , palette = c('dodgerblue','violetred1','dodgerblue','violetred1','dodgerblue','violetred1')
           , legend = c(0.2, 0.2) #'none'
) + 
  coord_cartesian(xlim=c(15,58),ylim=c(0.5,1.0))+
  xlab('Age')+ylab('Proportion that remains normotensive')+
  scale_x_continuous(limits = c(15,58), breaks=seq(15,57,6))



ggfit3 = survfit(Surv(recordTime,hasHT) ~ IQtertRs, data=ht.df)

ggsurvplot(ggfit3, conf.int=T,censor=F
           , linetype = c(1,1,2,2,3,3)
           #, color = c(1,2,1,2,1,2)
           , palette = c('dodgerblue','violetred1','dodgerblue','violetred1','dodgerblue','violetred1')
           , legend = c(0.2, 0.2) #'none'
) +
  coord_cartesian(xlim=c(15,58),ylim=c(0.5,1.0))+
  xlab('Age')+ylab('Proportion that remains normotensive')+
  scale_x_continuous(limits = c(15,58), breaks=seq(15,57,6))
  


ggfit4 = survfit(Surv(recordTime,hasHT) ~ IQtertRs, data=ht.df[ht.df$SAMPLE_SEX=='MALE',])

ggsurvplot(ggfit4, conf.int=T,censor=F
           , linetype = c(1,1,2,2,3,3)
           #, color = c(1,2,1,2,1,2)
           , palette = c('dodgerblue','violetred1','dodgerblue','violetred1','dodgerblue','violetred1')
           , legend = c(0.2, 0.2) #'none'
) + 
  coord_cartesian(xlim=c(15,58),ylim=c(0.5,1.0))+
  xlab('Age')+ylab('Proportion that remains normotensive')+
  scale_x_continuous(limits = c(15,58), breaks=seq(15,57,6))





IQinc.lm <- lm(AFQT89 ~ indiv_income, data = ht.df, na.action=na.exclude)
ht.df$IQresids = residuals(IQinc.lm)
ht.df$IQtertRs <- with(ht.df,cut(IQresids, 
                                 breaks=quantile(IQresids, probs=seq(0,1, by=1/3), na.rm=TRUE), 
                                 include.lowest=TRUE))
ht.df$sex_tertRs = interaction(ht.df$SAMPLE_SEX,ht.df$IQtertRs)
levels(ht.df$sex_tertRs) <- c('M-Low','F-Low','M-Mid','F-Mid','M-High','F-High')
ggfit2 = survfit(y ~ sex_tertRs, data=ht.df)

ggsurvplot(ggfit2, conf.int=T,censor=F
           , linetype = c(1,1,2,2,3,3)
           #, color = c(1,2,1,2,1,2)
           , palette = c('dodgerblue','violetred1','dodgerblue','violetred1','dodgerblue','violetred1')
           , legend = c(0.2, 0.2) #'none'
) + 
  coord_cartesian(xlim=c(15,58),ylim=c(0.5,1.0))+
  xlab('Age')+ylab('Proportion that remains normotensive')+
  scale_x_continuous(limits = c(15,58), breaks=seq(15,57,6))




cph.adj = coxph(y ~ sex_tert + SES_Income_USE,
              data = ht.df)
summary(cph.adj)

hist(ht.df$SES_Income_USE)
hist(ht.df$indiv_income)
sum(table(ht.df$indiv_income))


mysurv <- survfit(cph.adj, 
                  newdata=data.frame(sex_tert=ht.df$sex_tert,
                                     SES_Income_USE=-1
                                     ))
plot(mysurv)




  
### IQ and BMI plots

BMIQ <- ggplot(ht.df, aes(AFQT89, bmi_85))
BMIQ + geom_density_2d() + facet_wrap(~ SAMPLE_SEX)

BMIQ <- ggplot(ht.df, aes(AFQT89, bmi_06))
BMIQ + geom_density_2d() + facet_grid(~ SAMPLE_SEX)

BMIQ <- ggplot(ht.df, aes(AFQT89, bmi_12))
BMIQ + geom_density_2d() + facet_grid(~ SAMPLE_SEX)


### IQ and income plots

IQinc <- ggplot(ht.df,  aes(SES_Income_USE, AFQT89))
IQinc + geom_density_2d() + facet_wrap(~ SAMPLE_SEX)

IQincind <- ggplot(ht.df, aes(indiv_income, AFQT89))
IQincind + geom_density_2d() + facet_wrap(~ SAMPLE_SEX)



### Sex and individual income

hist(ht.df$indiv_income[ht.df$SAMPLE_SEX=='MALE'])
hist(ht.df$indiv_income[ht.df$SAMPLE_SEX=='FEMALE'])






seq(15,57,6)


int.eff = allEffects(mod = t.lm2)
int.eff = Effect(mod = t.lm2, focal.predictors = 'SAMPLE_SEX * AFQT89')

int.eff = Effect(c('SAMPLE_SEX','AFQT89'), mod = t.lm2, partial.residuals=F,
                 partial.residual=list(pch=".", col="#FF00FF80"))

plot(int.eff)



### Hypertension and medication plots

boxplot(AFQT89 ~ BP.meds.2012 * SAMPLE_SEX, data=ht.df)



#######


int.eff.stiff = Effect(c('SAMPLE_SEX','AFQT89'), mod = t2.lm3, partial.residuals=F,
                 partial.residual=list(pch=".", col="#FF00FF80"))

plot(int.eff.stiff)



#######


int.eff.arth = Effect(c('SAMPLE_SEX','AFQT89'), mod = t3.lm3, partial.residuals=F,
                       partial.residual=list(pch=".", col="#FF00FF80"))

plot(int.eff.arth)



#######


int.eff.diabBS = Effect(c('SAMPLE_SEX','AFQT89'), mod = t4.lm3, partial.residuals=F,
                      partial.residual=list(pch=".", col="#FF00FF80"))

plot(int.eff.diabBS)



### Ethnicity glance for C.Gale

levels(ht.df$SAMPLE_ethnicity)[3] <- 'OTHER'

## Mental Health

interact_plot(lm(H50_SF12_MentalHealth ~ AFQT89 * SAMPLE_ethnicity #+ as.numeric(age_1979) 
                 + SAMPLE_SEX, data = ht.df),
              pred = 'AFQT89', modx = 'SAMPLE_ethnicity', interval=T)
interact_plot(lm(H50_SF12_MentalHealth ~ AFQT89 * SAMPLE_ethnicity + as.numeric(age_1979) + SAMPLE_SEX + Child_SES + Adult_SES, data = ht.df),
              pred = 'AFQT89', modx = 'SAMPLE_ethnicity', interval=T)
#summary(lm(H50_SF12_MentalHealth ~ AFQT89 * SAMPLE_ethnicity + as.numeric(age_1979) + SAMPLE_SEX + Child_SES + Adult_SES, data = ht.df))


## Depression

interact_plot(lm(H50_CESD_7 ~ AFQT89 * SAMPLE_ethnicity + as.numeric(age_1979) + SAMPLE_SEX, data = ht.df),
              pred = 'AFQT89', modx = 'SAMPLE_ethnicity', interval=T)
interact_plot(lm(H50_CESD_7 ~ AFQT89 * SAMPLE_ethnicity + as.numeric(age_1979) + SAMPLE_SEX + Child_SES + Adult_SES, data = ht.df),
              pred = 'AFQT89', modx = 'SAMPLE_ethnicity', interval=T)
#summary(lm(H50_CESD_7 ~ AFQT89 * SAMPLE_ethnicity + as.numeric(age_1979) + SAMPLE_SEX + Child_SES + Adult_SES, data = ht.df))


## Sleep

ht.df$Sleep_aggr = as.numeric(ht.df$H50_sleep_1) + as.numeric(ht.df$H50_sleep_2) + as.numeric(ht.df$H50_sleep_3) + as.numeric(ht.df$H50_sleep_4)

interact_plot(lm(Sleep_aggr ~ AFQT89 * SAMPLE_ethnicity + as.numeric(age_1979) + SAMPLE_SEX, data = ht.df),
              pred = 'AFQT89', modx = 'SAMPLE_ethnicity', interval=T)
interact_plot(lm(Sleep_aggr ~ AFQT89 * SAMPLE_ethnicity + as.numeric(age_1979) + SAMPLE_SEX + Child_SES + Adult_SES, data = ht.df),
              pred = 'AFQT89', modx = 'SAMPLE_ethnicity', interval=T)

# Not much of anything for mental health.


## Physical Health

interact_plot(lm(H50_SF12_PhysicalHealth ~ AFQT89 * SAMPLE_ethnicity #+ as.numeric(age_1979) 
                 + SAMPLE_SEX, data = ht.df),
              pred = 'AFQT89', modx = 'SAMPLE_ethnicity', interval=T)
interact_plot(lm(H50_SF12_PhysicalHealth ~ AFQT89 * SAMPLE_ethnicity + as.numeric(age_1979) + SAMPLE_SEX + Child_SES + Adult_SES, data = ht.df),
              pred = 'AFQT89', modx = 'SAMPLE_ethnicity', interval=T)
# summary(lm(H50_SF12_PhysicalHealth ~ AFQT89 * SAMPLE_ethnicity + as.numeric(age_1979) + SAMPLE_SEX + Child_SES + Adult_SES, data = ht.df))


## Hypertension

interact_plot(glm(H50_DR_HighBP_HT ~ AFQT89 * SAMPLE_ethnicity + as.numeric(age_1979) + SAMPLE_SEX, data = ht.df, family=binomial),
              pred = 'AFQT89', modx = 'SAMPLE_ethnicity', interval=T)
interact_plot(glm(H50_DR_HighBP_HT ~ AFQT89 * SAMPLE_ethnicity + as.numeric(age_1979) + SAMPLE_SEX + Child_SES + Adult_SES, data = ht.df, family=binomial)
              , pred = 'AFQT89', modx = 'SAMPLE_ethnicity', interval=T)
#summary(glm(H50_DR_HighBP_HT ~ AFQT89 * SAMPLE_ethnicity + as.numeric(age_1979) + SAMPLE_SEX + Child_SES + Adult_SES, data = ht.df, family=binomial))


## Arthritis

interact_plot(glm(H50_Arthritis ~ AFQT89 * SAMPLE_ethnicity + as.numeric(age_1979) + SAMPLE_SEX, data = ht.df, family=binomial),
              pred = 'AFQT89', modx = 'SAMPLE_ethnicity', interval=T)
interact_plot(glm(H50_Arthritis ~ AFQT89 * SAMPLE_ethnicity + as.numeric(age_1979) + SAMPLE_SEX + Child_SES + Adult_SES, data = ht.df, family=binomial)
              , pred = 'AFQT89', modx = 'SAMPLE_ethnicity', interval=T)
summary(glm(H50_Arthritis ~ AFQT89 * SAMPLE_ethnicity + as.numeric(age_1979) + SAMPLE_SEX + Child_SES + Adult_SES, data = ht.df, family=binomial))


## Stiffness/swelling

interact_plot(glm(H50_PainStiff_joints ~ AFQT89 * SAMPLE_ethnicity + as.numeric(age_1979) + SAMPLE_SEX, data = ht.df, family=binomial),
              pred = 'AFQT89', modx = 'SAMPLE_ethnicity', interval=T)
interact_plot(glm(H50_PainStiff_joints ~ AFQT89 * SAMPLE_ethnicity + as.numeric(age_1979) + SAMPLE_SEX + Child_SES + Adult_SES, data = ht.df, family=binomial)
              , pred = 'AFQT89', modx = 'SAMPLE_ethnicity', interval=T)
#summary(glm(H50_PainStiff_joints ~ AFQT89 * SAMPLE_ethnicity + as.numeric(age_1979) + SAMPLE_SEX + Child_SES + Adult_SES, data = ht.df, family=binomial))


## Diabetes

interact_plot(glm(H50_DR_Diabetes_HighBS ~ AFQT89 * SAMPLE_ethnicity + as.numeric(age_1979) + SAMPLE_SEX, data = ht.df, family=binomial),
              pred = 'AFQT89', modx = 'SAMPLE_ethnicity', interval=T)
interact_plot(glm(H50_DR_Diabetes_HighBS ~ AFQT89 * SAMPLE_ethnicity + as.numeric(age_1979) + SAMPLE_SEX + Child_SES + Adult_SES, data = ht.df, family=binomial)
              , pred = 'AFQT89', modx = 'SAMPLE_ethnicity', interval=T)
#summary(glm(H50_DR_Diabetes_HighBS ~ AFQT89 * SAMPLE_ethnicity + as.numeric(age_1979) + SAMPLE_SEX + Child_SES + Adult_SES, data = ht.df, family=binomial))





### Prototyping

## Hypertension

#...
int.eth.HT = Effect(c('SAMPLE_ethnicity','AFQT89'), mod = lm.eth.1, partial.residuals=F)
plot(int.eth.HT)

lm.eth.1.a = glm(H50_DR_HighBP_HT ~ AFQT89 * SAMPLE_ethnicity + as.numeric(age_1979) + SAMPLE_SEX, data = ht.df, family=binomial)
int.eth.HT = Effect(c('SAMPLE_ethnicity','AFQT89'), mod = lm.eth.1.a, partial.residuals=F)
plot(int.eth.HT)

lm.eth.1.b = glm(H50_DR_HighBP_HT ~ AFQT89 * SAMPLE_ethnicity + as.numeric(age_1979) + SAMPLE_SEX + Child_SES, data = ht.df, family=binomial)
int.eth.HT = Effect(c('SAMPLE_ethnicity','AFQT89'), mod = lm.eth.1.b, partial.residuals=F)
plot(int.eth.HT)

lm.eth.1.c = glm(H50_DR_HighBP_HT ~ AFQT89 * SAMPLE_ethnicity + as.numeric(age_1979) + SAMPLE_SEX + Child_SES + Adult_SES, data = ht.df, family=binomial)
int.eth.HT = Effect(c('SAMPLE_ethnicity','AFQT89'), mod = lm.eth.1.c, partial.residuals=F)
plot(int.eth.HT)

lm.eth.1.d = glm(H50_DR_HighBP_HT ~ AFQT89 * SAMPLE_ethnicity + as.numeric(age_1979) + AFQT89 * SAMPLE_SEX + Child_SES + Adult_SES, data = ht.df, family=binomial)
int.eth.HT = Effect(c('SAMPLE_ethnicity','AFQT89'), mod = lm.eth.1.d, partial.residuals=F)
plot(int.eth.HT)

summary(lm.eth.1.d)

interact_plot(lm.eth.1.a, pred = 'AFQT89', modx = 'SAMPLE_ethnicity')
interact_plot(lm.eth.1.d, pred = 'AFQT89', modx = 'SAMPLE_ethnicity')



## BMI

lm.eth.85 = lm(bmi_85 ~ AFQT89 * SAMPLE_ethnicity + as.numeric(age_1979) + SAMPLE_SEX, data = ht.df)
interact_plot(lm.eth.85, pred = 'AFQT89', modx = 'SAMPLE_ethnicity')

lm.eth.85.b = lm(bmi_85 ~ AFQT89 * SAMPLE_ethnicity + as.numeric(age_1979) + SAMPLE_SEX + Child_SES, data = ht.df)
interact_plot(lm.eth.85.b, pred = 'AFQT89', modx = 'SAMPLE_ethnicity')


lm.eth.12 = lm(bmi_12 ~ AFQT89 * SAMPLE_ethnicity + as.numeric(age_1979) + SAMPLE_SEX, data = ht.df)
interact_plot(lm.eth.12, pred = 'AFQT89', modx = 'SAMPLE_ethnicity')

lm.eth.12.b = lm(bmi_12 ~ AFQT89 * SAMPLE_ethnicity + as.numeric(age_1979) + SAMPLE_SEX + Child_SES, data = ht.df)
interact_plot(lm.eth.85.b, pred = 'AFQT89', modx = 'SAMPLE_ethnicity')

lm.eth.12.c = lm(bmi_12 ~ AFQT89 * SAMPLE_ethnicity + as.numeric(age_1979) + SAMPLE_SEX + Child_SES + Adult_SES, data = ht.df)
interact_plot(lm.eth.85.c, pred = 'AFQT89', modx = 'SAMPLE_ethnicity')




## Physical Health

lm.eth.2 = lm(H50_SF12_PhysicalHealth ~ AFQT89 * SAMPLE_ethnicity, data = ht.df)
int.eth.PH = Effect(c('SAMPLE_ethnicity','AFQT89'), mod = lm.eth.2, partial.residuals=F)
plot(int.eth.PH)

lm.eth.3 = lm(H50_SF12_MentalHealth ~ AFQT89 * SAMPLE_ethnicity, data = ht.df)
int.eth.MH = Effect(c('SAMPLE_ethnicity','AFQT89'), mod = lm.eth.3, partial.residuals=F)
plot(int.eth.MH)

lm.eth.4 = lm(as.numeric(H50_SF12_GeneralHealth) ~ AFQT89 * SAMPLE_ethnicity, data = ht.df)
summary(lm.eth.4)




interact_plot(lm.eth.2, pred = 'AFQT89', modx = 'SAMPLE_ethnicity')

interact_plot(lm.eth.3, pred = 'AFQT89', modx = 'SAMPLE_ethnicity')

interact_plot(lm.eth.4, pred = 'AFQT89', modx = 'SAMPLE_ethnicity')



lm.eth.5 = lm(H50_CESD_7 ~ AFQT89 * SAMPLE_ethnicity, data = ht.df)
interact_plot(lm.eth.5, pred = 'AFQT89', modx = 'SAMPLE_ethnicity')

lm.eth.5.a = lm(H50_CESD_7 ~ AFQT89 * SAMPLE_ethnicity + as.numeric(age_1979) + SAMPLE_SEX, data = ht.df)
interact_plot(lm.eth.5.a, pred = 'AFQT89', modx = 'SAMPLE_ethnicity')

lm.eth.5.b = lm(H50_CESD_7 ~ AFQT89 * SAMPLE_ethnicity + as.numeric(age_1979) + SAMPLE_SEX +
                  Child_SES, data = ht.df)
interact_plot(lm.eth.5.b, pred = 'AFQT89', modx = 'SAMPLE_ethnicity')

lm.eth.5.c = lm(H50_CESD_7 ~ AFQT89 * SAMPLE_ethnicity + as.numeric(age_1979) + SAMPLE_SEX +
                  Child_SES + Adult_SES, data = ht.df)
interact_plot(lm.eth.5.c, pred = 'AFQT89', modx = 'SAMPLE_ethnicity')



##

