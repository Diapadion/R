### Plots demonstrating interaction

library(survival)
library(Hmisc)
library(rms)
library(effects)
library(ggplot2)
library(RGraphics)
library(gridExtra)
library(survminer)



### Quartiles

ht.df$IQquart <- with(ht.df,cut(AFQT89, 
                                breaks=quantile(AFQT89, probs=seq(0,1, by=0.25), na.rm=TRUE), 
                                include.lowest=TRUE))


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

npsf.2 = npsurv(y ~ sex_tert, data=ht.df)
survplot(npsf.2, xlab='Age',ylab='Probability of developing hypertension',ylim=c(0.6,1),xlim=c(15,59),
         label.curves=F, col=c('skyblue3','coral2','skyblue3','coral2','skyblue3','coral2')
         , col.fill=c('skyblue','coral','skyblue','coral','skyblue','coral')
         , lty = c(1,1,2,2,3,3)
)



## ggplot attempt

ggfit = survfit(y ~ sex_tert, data=ht.df)

ggsurvplot(ggfit, conf.int=T,censor=F
           , linetype = c(1,1,2,2,3,3)
           #, color = c(1,2,1,2,1,2)
           , palette = c('dodgerblue','violetred1','dodgerblue','violetred1','dodgerblue','violetred1')
           , legend = c(0.2, 0.2) #'none'
           ) + 
  coord_cartesian(xlim=c(15,58),ylim=c(0.6,1.0))+
  xlab('Age')+ylab('Proportion that remains normotensive')+
  scale_x_continuous(limits = c(15,58), breaks=seq(15,57,6))

  #theme(axis.title.y='Risk of developing hypertension', axis.title.x='Age')


seq(15,57,6)


int.eff = allEffects(mod = t.lm2)
int.eff = Effect(mod = t.lm2, focal.predictors = 'SAMPLE_SEX * AFQT89')

int.eff = Effect(c('SAMPLE_SEX','AFQT89'), mod = t.lm2, partial.residuals=F,
                 partial.residual=list(pch=".", col="#FF00FF80"))

plot(int.eff)



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
