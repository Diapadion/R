### Plots demonstrating interaction

library(Hmisc)
library(rms)
library(effects)



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

npsf.1 = npsurv(y ~ IQtert, data=ht.df)

par(mfrow=c(1,1))
survplot(npsf.1, xlab = 'Age')


npsf.m = npsurv(y[ht.df$SAMPLE_SEX=='MALE',] ~ IQtert, data=ht.df[ht.df$SAMPLE_SEX=='MALE',])
npsf.f = npsurv(y[ht.df$SAMPLE_SEX=='FEMALE',] ~ IQtert, data=ht.df[ht.df$SAMPLE_SEX=='FEMALE',])

par(mfrow=c(1,2))
survplot(npsf.m, xlab = 'Age',ylim=c(0.5,1),xlim=c(15,59), label.curves=F)
survplot(npsf.f, xlab = 'Age',ylim=c(0.5,1),xlim=c(15,59), label.curves=F)







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
