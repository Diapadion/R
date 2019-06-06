### Determining the best structural model for D lv and
### Checking reliability of D lv, informed by EFAs


library(psych)
library(lavaan)




### CFAs, with vars over 0.3 in 3 factor EFA

cfa.m.1 <- '
A =~ Dominant + Forceful + Assertive + Outspoken + Selfconfident + Outgoing + Talkative
'

cfa.f.1 = cfa(cfa.m.1, data=m1exp)

summary(cfa.f.1)
fitMeasures(cfa.f.1, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC'))



cfa.m.2 <- '
A =~ Dominant + Forceful + Assertive + Outspoken + Selfconfident
'

cfa.f.2 = cfa(cfa.m.2, data=m1exp)

summary(cfa.f.2)
fitMeasures(cfa.f.2, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC'))



cfa.m.3 <- '
A =~ Dominant + Forceful + Assertive + Outspoken'

cfa.f.3 = cfa(cfa.m.3, data=m1exp)

summary(cfa.f.3)
fitMeasures(cfa.f.3, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC'))


## now confirming in the other samples

## US
cfa.f.3.con = cfa(cfa.m.3, data=m1con)

summary(cfa.f.3.con)
fitMeasures(cfa.f.3.con, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC'))

## Japan
cfa.f.3.j.con = cfa(cfa.m.3, data=midja1)

summary(cfa.f.3.j.con)
fitMeasures(cfa.f.3.j.con, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC'))

### 4 item model of the contruct is the best, a good fit, in all samples. We'll call this D.



### Omega and other reliabilities of the models

omega(m1exp[,c('Selfconfident','Forceful','Assertive','Outspoken','Dominant',
               'Outgoing','Talkative')]
      , nfactors=3)

## seems to be separate factors for Selfconfident(+Assertive+Outgoing) and
## Outgoing+Talkative(+Outspoken)
## but the first factor of 'dominance' is still the primary link for the 4 'core' items.


omega(m1exp[,c('Selfconfident','Forceful','Assertive','Outspoken','Dominant')], nfactors=2)


omega(m1exp[,c('Forceful','Assertive','Outspoken','Dominant')], nfactors=1)             





### Ought to do the same for E and O

### Extraversion

cfa.mE.1 <- '
E =~ Warm + Outgoing + Friendly + Lively + Talkative + Active
'

cfa.fE.1 = cfa(cfa.mE.1, data=m1exp)

summary(cfa.fE.1)
fitMeasures(cfa.fE.1, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC'))


cfa.mE.2 <- '
E =~ Warm + Outgoing + Friendly + Lively + Talkative
'

cfa.fE.2 = cfa(cfa.mE.2, data=m1exp)

summary(cfa.fE.2)
fitMeasures(cfa.fE.2, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC'))


cfa.mE.3 <- '
E =~ Outgoing + Friendly + Lively + Talkative
'

cfa.fE.3 = cfa(cfa.mE.3, data=m1exp)

summary(cfa.fE.3)
fitMeasures(cfa.fE.3, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC'))


## now confirming in the other samples

## US
cfa.fE.3.con = cfa(cfa.mE.3, data=m1con)

summary(cfa.fE.3.con)
fitMeasures(cfa.fE.3.con, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC'))


## Japan
cfa.fE.3.j.con = cfa(cfa.mE.3, data=midja1)

summary(cfa.fE.3.j.con)
fitMeasures(cfa.fE.3.j.con, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC'))
## good fit stats across smaples.


omega(m1exp[,c('Outgoing','Friendly','Lively','Talkative')], nfactors=1) # good reliability.      



### Openness

cfa.mO.1 <- '
O =~ Creative+Imaginative+Intelligent+Curious+Broadminded+Sophisticated+Adventurous
'

cfa.fO.1 = cfa(cfa.mO.1, data=m1exp)

summary(cfa.fO.1)
fitMeasures(cfa.fO.1, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC'))

mi.O = modificationindices(cfa.fO.1)
subset(mi.O[order(mi.O$mi, decreasing=TRUE), ], mi > 5)


cfa.mO.2 <- '
O =~ Creative+Imaginative+Intelligent+Curious+Broadminded+Sophisticated+Adventurous
Creative ~~ Imaginative
'

cfa.fO.2 = cfa(cfa.mO.2, data=m1exp)

summary(cfa.fO.2)
fitMeasures(cfa.fO.2, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC'))


cfa.mO.3 <- '
O =~ Creative+Imaginative+Intelligent+Curious+Broadminded+Sophisticated+Adventurous
Creative ~~ Imaginative
Intelligent ~~ Curious
'

cfa.fO.3 = cfa(cfa.mO.3, data=m1exp)

summary(cfa.fO.3)
fitMeasures(cfa.fO.3, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC'))

mi.O = modificationindices(cfa.fO.3)
subset(mi.O[order(mi.O$mi, decreasing=TRUE), ], mi > 5)








cfa.mO.4 <- '
O =~ Creative+Imaginative+Curious+Broadminded+Sophisticated+Adventurous + Intelligent
Creative ~~ Imaginative
Intelligent ~~ Curious
Intelligent ~~ Adventurous
Intelligent ~~ Sophisticated
'

cfa.fO.4 = cfa(cfa.mO.4, data=m1exp)

summary(cfa.fO.4)
fitMeasures(cfa.fO.4, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC'))




## now confirming in the other samples

## US
cfa.fO.4.con = cfa(cfa.mO.4, data=m1con)

summary(cfa.fO.4.con)
fitMeasures(cfa.fO.4.con, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC'))


## Japan
cfa.fO.4.j.con = cfa(cfa.mO.4, data=midja1)

summary(cfa.fO.4.j.con)
fitMeasures(cfa.fO.4.j.con, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC'))

mi.O = modificationindices(cfa.fO.4.j.con)
subset(mi.O[order(mi.O$mi, decreasing=TRUE), ], mi > 5)




