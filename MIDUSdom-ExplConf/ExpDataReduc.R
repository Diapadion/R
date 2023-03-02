library(psych)
library(semTools)
library(blavaan)
library(data.table)


sort( sapply(ls(),function(x){object.size(get(x))})) 


AEOvars = c('Selfconfident','Forceful','Assertive','Outspoken','Dominant',
           'Creative','Imaginative','Intelligent','Curious','Broadminded',
           'Sophisticated','Adventurous','Warm',
           'Outgoing','Friendly','Lively','Active','Talkative'
           )

colnames(EFAdat)[c(147,167)] = c('Selfconfident','Broadminded')


cor(m1exp[,..AEOvars], use='pairwise.complete.obs',method='spearman')



fa.parallel(m1exp[,..AEOvars,with=F])
nfactors(m1exp[,..AEOvars])

ccs = complete.cases(m1exp[,.SD, .SDcols = AEOvars])
ECdat = subset(m1exp,ccs) 
EFA.Comp.Data(as.data.frame(ECdat[,AEOvars,with=FALSE]), F.Max=10, Graph=T, Spearman=T)



m.2.fa = fa(EFAdat[,..AEOvars], 2, rotate = 'varimax')
m.3.fa = fa(EFAdat[,..AEOvars], 3, rotate = 'varimax')

m.2.fa.ob = fa(m1exp[,..AEOvars], 2, rotate = 'oblimin')
m.3.fa.ob = fa(m1exp[,..AEOvars], 3, rotate = 'oblimin')


print(m.3.fa.ob)







### Bayes ###

b.mod2 <- bcfa(fact2, data=as.matrix(m1exp)[,AEOvars], convergence = 'auto', test='none')
               #convergence = 'auto' )
b.mod2.tst <- bcfa(fact2, data=as.matrix(m1exp)[complete.cases(as.matrix(m1exp)[,AEOvars]),AEOvars], convergence = 'auto')

b.mod3 <- bcfa(fact3, data=as.matrix(m1exp)[,AEOvars], convergence = 'auto', test='none')
               #convergence = 'auto' )
b.mod3.tst <- bcfa(fact3, data=as.matrix(m1exp)[complete.cases(as.matrix(m1exp)[,AEOvars]),AEOvars], convergence = 'auto')#, test='none')

b.mod2.fm =fitMeasures(b.mod2.tst)
b.mod3.fm = fitMeasures(b.mod3.tst)
b.mod2.fm['margloglik']/b.mod3.fm['margloglik']


b.ipip.f3.h <- bcfa(ipip.m3.h, data=ipipExpl[,EOvars], convergence = 'auto' )
b.ipip.f3.h.fm = fitMeasures(b.ipip.f3.h)



# set.seed(12345)
# ipip.samp = sample(dim(df)[1], 20000)
# b.ipip.f3.h <- bcfa(ipip.m3.h, data=df[ipip.samp[1:10000],EOvars], convergence = 'auto' )
# b.ipip.f3.h.fm = fitMeasures(b.ipip.f3.h)
# 
# b.ipip.f2.h <- bcfa(ipip.m2.h, data=df[ipip.samp[1:10000],EOvars], convergence = 'auto' )
# b.ipip.f2.h.fm = fitMeasures(b.ipip.f2.h)

            
#table(complete.cases(as.matrix(m1exp)[,AEOvars]))

#############

fact2 <- '
E =~ Selfconfident + Forceful + Assertive + Outspoken + Dominant+
           Warm+Outgoing+Friendly+Lively+Active+Talkative
O =~ Creative+Imaginative+Intelligent+Curious+Broadminded+
           Sophisticated+Adventurous+Active

'

mod2 <- cfa(fact2, data=m1exp[,..AEOvars])

summary(mod2)
fitMeasures(mod2, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC','rmsea.ci.upper'))
mi2 = modificationindices(mod2)
head(mi2[order(mi2$mi, decreasing=TRUE), ], 10)



fact2.1 <- '
E =~ Selfconfident + Forceful + Assertive + Outspoken + Dominant+
           Warm+Outgoing+Friendly+Lively+Active+Talkative
O =~ Creative+Imaginative+Intelligent+Curious+Broadminded+
           Sophisticated+Adventurous+Active
Warm ~~ Friendly

'

mod2.1 <- cfa(fact2.1, data=m1exp[,..AEOvars])

summary(compareFit(mod2.1,mod2))
fitMeasures(mod2.1, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC','rmsea.ci.upper'))
mi2 = modificationindices(mod2.1)
head(mi2[order(mi2$mi, decreasing=TRUE), ], 10)



fact2.2 <- '
E =~ Selfconfident + Forceful + Assertive + Outspoken + Dominant+
           Warm+Outgoing+Friendly+Lively+Active+Talkative
O =~ Creative+Imaginative+Intelligent+Curious+Broadminded+
           Sophisticated+Adventurous+Active
Warm ~~ Friendly
Creative ~~ Imaginative

'

mod2.2 <- cfa(fact2.2, data=m1exp[,..AEOvars])

summary(compareFit(mod2.2,mod2.1))
fitMeasures(mod2.2, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC','rmsea.ci.upper'))
mi2 = modificationindices(mod2.2)
head(mi2[order(mi2$mi, decreasing=TRUE), ], 10)



fact2.3 <- '
E =~ Selfconfident + Forceful + Assertive + Outspoken + Dominant+
           Warm+Outgoing+Friendly+Lively+Active+Talkative
O =~ Creative+Imaginative+Intelligent+Curious+Broadminded+
           Sophisticated+Adventurous+Active
Warm ~~ Friendly
Creative ~~ Imaginative
Dominant ~~ Forceful

'

mod2.3 <- cfa(fact2.3, data=m1exp[,..AEOvars])

summary(compareFit(mod2.3,mod2.2))
mi2 = modificationindices(mod2.3)
head(mi2[order(mi2$mi, decreasing=TRUE), ], 10)



fact2.4 <- '
E =~ Selfconfident + Forceful + Assertive + Outspoken + Dominant+
           Warm+Outgoing+Friendly+Lively+Active+Talkative
O =~ Creative+Imaginative+Intelligent+Curious+Broadminded+
           Sophisticated+Adventurous+Active
Warm ~~ Friendly
Creative ~~ Imaginative
Dominant ~~ Forceful
Lively ~~ Active

'

mod2.4 <- cfa(fact2.4, data=m1exp[,..AEOvars])

summary(compareFit(mod2.4,mod2.3))
mi2 = modificationindices(mod2.4)
head(mi2[order(mi2$mi, decreasing=TRUE), ], 10)



fact2.5 <- '
E =~ Selfconfident + Forceful + Assertive + Outspoken + Dominant+
           Warm+Outgoing+Friendly+Lively+Active+Talkative
O =~ Creative+Imaginative+Intelligent+Curious+Broadminded+
           Sophisticated+Adventurous+Active
Warm ~~ Friendly
Creative ~~ Imaginative
Dominant ~~ Forceful
Lively ~~ Active
Selfconfident ~~ Talkative

'

mod2.5 <- cfa(fact2.5, data=m1exp[,..AEOvars])

summary(compareFit(mod2.5,mod2.4))
mi2 = modificationindices(mod2.5)
head(mi2[order(mi2$mi, decreasing=TRUE), ], 10)



fact2.6 <- '
E =~ Selfconfident + Forceful + Assertive + Outspoken + Dominant+
           Warm+Outgoing+Friendly+Lively+Active+Talkative
O =~ Creative+Imaginative+Intelligent+Curious+Broadminded+
           Sophisticated+Adventurous+Active
Warm ~~ Friendly
Creative ~~ Imaginative
Dominant ~~ Forceful
Lively ~~ Active
Selfconfident ~~ Talkative
Forceful ~~ Assertive

'

mod2.6 <- cfa(fact2.6, data=m1exp[,..AEOvars])

summary(compareFit(mod2.6,mod2.5))
mi2 = modificationindices(mod2.6)
head(mi2[order(mi2$mi, decreasing=TRUE), ], 10)



fact2.7 <- '
E =~ Selfconfident + Forceful + Assertive + Outspoken + Dominant+
           Warm+Outgoing+Friendly+Lively+Active+Talkative
O =~ Creative+Imaginative+Intelligent+Curious+Broadminded+
           Sophisticated+Adventurous+Active
Warm ~~ Friendly
Creative ~~ Imaginative
Dominant ~~ Forceful
Lively ~~ Active
Selfconfident ~~ Talkative
Forceful ~~ Assertive
Assertive ~~    Dominant

'

mod2.7 <- cfa(fact2.7, data=m1exp[,..AEOvars])

summary(compareFit(mod2.7,mod2.6))
mi2 = modificationindices(mod2.7)
head(mi2[order(mi2$mi, decreasing=TRUE), ], 10)



fact2.8 <- '
E =~ Selfconfident + Forceful + Assertive + Outspoken + Dominant+
           Warm+Outgoing+Friendly+Lively+Active+Talkative
O =~ Creative+Imaginative+Intelligent+Curious+Broadminded+
           Sophisticated+Adventurous+Active
Warm ~~ Friendly
Creative ~~ Imaginative
Dominant ~~ Forceful
Lively ~~ Active
Selfconfident ~~ Talkative
Forceful ~~ Assertive
Assertive ~~ Dominant
Intelligent ~~ Adventurous
'

mod2.8 <- cfa(fact2.8, data=m1exp[,..AEOvars])

summary(compareFit(mod2.8,mod2.7))
mi2 = modificationindices(mod2.8)
head(mi2[order(mi2$mi, decreasing=TRUE), ], 10)



fact2.9 <- '
E =~ Selfconfident + Forceful + Assertive + Outspoken + Dominant+
           Warm+Outgoing+Friendly+Lively+Active+Talkative
O =~ Creative+Imaginative+Intelligent+Curious+Broadminded+
           Sophisticated+Adventurous+Active
Warm ~~ Friendly
Creative ~~ Imaginative
Dominant ~~ Forceful
Lively ~~ Active
Selfconfident ~~ Talkative
Forceful ~~ Assertive
Assertive ~~ Dominant
Intelligent ~~ Adventurous
Outspoken ~~ Dominant
'

mod2.9 <- cfa(fact2.9, data=m1exp[,..AEOvars])

summary(compareFit(mod2.9,mod2.8))
mi2 = modificationindices(mod2.9)
head(mi2[order(mi2$mi, decreasing=TRUE), ], 10)



fact2.10 <- '
E =~ Selfconfident + Forceful + Assertive + Outspoken + Dominant+
           Warm+Outgoing+Friendly+Lively+Active+Talkative
O =~ Creative+Imaginative+Intelligent+Curious+Broadminded+
           Sophisticated+Adventurous+Active
Warm ~~ Friendly
Creative ~~ Imaginative
Dominant ~~ Forceful
Lively ~~ Active
Selfconfident ~~ Talkative
Forceful ~~ Assertive
Assertive ~~ Dominant
Intelligent ~~ Adventurous
Outspoken ~~ Dominant
Forceful ~~ Outspoken
'

mod2.10 <- cfa(fact2.10, data=m1exp[,..AEOvars])

summary(compareFit(mod2.10,mod2.9))
mi2 = modificationindices(mod2.10)
head(mi2[order(mi2$mi, decreasing=TRUE), ], 10)



fact2.11 <- '
E =~ Selfconfident + Forceful + Assertive + Outspoken + Dominant+
           Warm+Outgoing+Friendly+Lively+Active+Talkative
O =~ Creative+Imaginative+Intelligent+Curious+Broadminded+
           Sophisticated+Adventurous+Active
Warm ~~ Friendly
Creative ~~ Imaginative
Dominant ~~ Forceful
Lively ~~ Active
Selfconfident ~~ Talkative
Forceful ~~ Assertive
Assertive ~~ Dominant
Intelligent ~~ Adventurous
Outspoken ~~ Dominant
Forceful ~~ Outspoken
Assertive ~~ Outspoken
'

mod2.11 <- cfa(fact2.11, data=m1exp[,..AEOvars])

summary(compareFit(mod2.11,mod2.10))
mi2 = modificationindices(mod2.11)
head(mi2[order(mi2$mi, decreasing=TRUE), ], 10)



fact2.12 <- '
E =~ Selfconfident + Forceful + Assertive + Outspoken + Dominant+
           Warm+Outgoing+Friendly+Lively+Active+Talkative
O =~ Creative+Imaginative+Intelligent+Curious+Broadminded+
           Sophisticated+Adventurous+Active
Warm ~~ Friendly
Creative ~~ Imaginative
Dominant ~~ Forceful
Lively ~~ Active
Selfconfident ~~ Talkative
Forceful ~~ Assertive
Assertive ~~ Dominant
Intelligent ~~ Adventurous
Outspoken ~~ Dominant
Forceful ~~ Outspoken
Assertive ~~ Outspoken
Outspoken ~~     Talkative
'

mod2.12 <- cfa(fact2.12, data=m1exp[,..AEOvars])

summary(compareFit(mod2.12,mod2.11))
mi2 = modificationindices(mod2.12)
head(mi2[order(mi2$mi, decreasing=TRUE), ], 10)



fact2.13 <- '
E =~ Selfconfident + Forceful + Assertive + Outspoken + Dominant+
           Warm+Outgoing+Friendly+Lively+Active+Talkative
O =~ Creative+Imaginative+Intelligent+Curious+Broadminded+
           Sophisticated+Adventurous+Active
Warm ~~ Friendly
Creative ~~ Imaginative
Dominant ~~ Forceful
Lively ~~ Active
Selfconfident ~~ Talkative
Forceful ~~ Assertive
Assertive ~~ Dominant
Intelligent ~~ Adventurous
Outspoken ~~ Dominant
Forceful ~~ Outspoken
Assertive ~~ Outspoken
Outspoken ~~ Talkative
Selfconfident ~~ Assertive
'

mod2.13 <- cfa(fact2.13, data=m1exp[,..AEOvars])

summary(compareFit(mod2.13,mod2.12))
mi2 = modificationindices(mod2.13)
head(mi2[order(mi2$mi, decreasing=TRUE), ], 10)



fact2.14 <- '
E =~ Selfconfident + Forceful + Assertive + Outspoken + Dominant+
           Warm+Outgoing+Friendly+Lively+Active+Talkative
O =~ Creative+Imaginative+Intelligent+Curious+Broadminded+
           Sophisticated+Adventurous+Active + Outgoing
Warm ~~ Friendly
Creative ~~ Imaginative
Dominant ~~ Forceful
Lively ~~ Active
Selfconfident ~~ Talkative
Forceful ~~ Assertive
Assertive ~~ Dominant
Intelligent ~~ Adventurous
Outspoken ~~ Dominant
Forceful ~~ Outspoken
Assertive ~~ Outspoken
Outspoken ~~ Talkative
Selfconfident ~~ Assertive
'

mod2.14 <- cfa(fact2.14, data=m1exp[,..AEOvars])

summary(compareFit(mod2.14,mod2.13))
mi2 = modificationindices(mod2.14)
head(mi2[order(mi2$mi, decreasing=TRUE), ], 10)



fact2.15 <- '
E =~ Selfconfident + Forceful + Assertive + Outspoken + Dominant+
           Warm+Outgoing+Friendly+Lively+Active+Talkative
O =~ Creative+Imaginative+Intelligent+Curious+Broadminded+
           Sophisticated+Adventurous+Active + Outgoing
Warm ~~ Friendly
Creative ~~ Imaginative
Dominant ~~ Forceful
Lively ~~ Active
Selfconfident ~~ Talkative
Forceful ~~ Assertive
Assertive ~~ Dominant
Intelligent ~~ Adventurous
Outspoken ~~ Dominant
Forceful ~~ Outspoken
Assertive ~~ Outspoken
Outspoken ~~ Talkative
Selfconfident ~~ Assertive
Assertive ~~ Creative
'

mod2.15 <- cfa(fact2.15, data=m1exp[,..AEOvars])

summary(compareFit(mod2.15,mod2.14))
mi2 = modificationindices(mod2.15)
head(mi2[order(mi2$mi, decreasing=TRUE), ], 10)



fact2.16 <- '
E =~ Selfconfident + Forceful + Assertive + Outspoken + Dominant+
           Warm+Outgoing+Friendly+Lively+Active+Talkative
O =~ Creative+Imaginative+Intelligent+Curious+Broadminded+
           Sophisticated+Adventurous+Active + Outgoing + Talkative
Warm ~~ Friendly
Creative ~~ Imaginative
Dominant ~~ Forceful
Lively ~~ Active
Selfconfident ~~ Talkative
Forceful ~~ Assertive
Assertive ~~ Dominant
Intelligent ~~ Adventurous
Outspoken ~~ Dominant
Forceful ~~ Outspoken
Assertive ~~ Outspoken
Outspoken ~~ Talkative
Selfconfident ~~ Assertive
Assertive ~~ Creative
'

mod2.16 <- cfa(fact2.16, data=m1exp[,..AEOvars])

summary(compareFit(mod2.16,mod2.15))
mi2 = modificationindices(mod2.16)
head(mi2[order(mi2$mi, decreasing=TRUE), ], 10)


fact2.17 <- '
E =~ Selfconfident + Forceful + Assertive + Outspoken + Dominant+
Warm+Outgoing+Friendly+Lively+Active+Talkative
O =~ Creative+Imaginative+Intelligent+Curious+Broadminded+
Sophisticated+Adventurous+Active + Outgoing + Talkative
Warm ~~ Friendly
Creative ~~ Imaginative
Dominant ~~ Forceful
Lively ~~ Active
Selfconfident ~~ Talkative
Forceful ~~ Assertive
Assertive ~~ Dominant
Intelligent ~~ Adventurous
Outspoken ~~ Dominant
Forceful ~~ Outspoken
Assertive ~~ Outspoken
Outspoken ~~ Talkative
Selfconfident ~~ Assertive
Assertive ~~ Creative
Selfconfident ~~   Intelligent
'

mod2.17 <- cfa(fact2.17, data=m1exp[,..AEOvars])

summary(compareFit(mod2.17,mod2.16))
mi2 = modificationindices(mod2.17)
head(mi2[order(mi2$mi, decreasing=TRUE), ], 10)

fitMeasures(mod2.17, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC','rmsea.ci.upper'))


#######

fact3 <- '
# A =~ Dominant + Forceful + Assertive + Outspoken + Selfconfident + Outgoing + Talkative
# E =~ Warm + Outgoing + Friendly + Lively + Active + Talkative + Selfconfident
# O =~ Creative + Imaginative + Intelligent + Curious + Broadminded +
#            Sophisticated + Adventurous + Active + Assertive + Selfconfident
A =~ Dominant + Forceful + Assertive + Outspoken + Selfconfident
E =~ Warm + Outgoing + Friendly + Lively + Active + Talkative
O =~ Creative + Imaginative + Intelligent + Curious + Broadminded +
           Sophisticated + Adventurous + Active
A ~~ E
A ~~ O
E ~~ O

'

mod3 <- cfa(fact3, data=m1exp[,..AEOvars])

summary(mod3)
fitMeasures(mod3, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC'))
mi3 = modificationindices(mod3)
head(mi3[order(mi3$mi, decreasing=TRUE), ], 10)



fact3.1 <- '
A =~ Dominant + Forceful + Assertive + Outspoken + Selfconfident + Outgoing + Talkative
E =~ Warm + Outgoing + Friendly + Lively + Active + Talkative + Selfconfident
O =~ Imaginative + Intelligent + Curious + Broadminded +
           Sophisticated + Adventurous + Active + Assertive + Selfconfident
# A =~ Dominant + Forceful + Assertive + Outspoken
# E =~ Warm+Outgoing+Friendly+Lively+Talkative #+ Active
# O =~ Creative+Imaginative+Intelligent+Curious+Broadminded+
#            Sophisticated+Adventurous
#Warm ~~ Friendly

'

mod3.1 <- cfa(fact3.1, data=m1exp[,..AEOvars])

#summary(mod3.1)
fitMeasures(mod3.1, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC'))
mi3.1 = modificationindices(mod3.1)
head(mi3.1[order(mi3.1$mi, decreasing=TRUE), ], 10)



fact3.2 <- '
A =~ Dominant + Forceful + Assertive + Outspoken + Selfconfident + Outgoing + Talkative
E =~ Warm + Outgoing + Lively + Active + Talkative + Selfconfident
O =~ Imaginative + Intelligent + Curious + Broadminded +
           Sophisticated + Adventurous + Active + Assertive + Selfconfident
# A =~ Selfconfident + Forceful + Assertive + Outspoken + Dominant
# E =~ Warm+Outgoing+Friendly+Lively+Active+Talkative
# O =~ Creative+Imaginative+Intelligent+Curious+Broadminded+
#            Sophisticated+Adventurous+Active
# 
# Warm ~~ Friendly
# Creative ~~ Imaginative

'


mod3.2 <- cfa(fact3.2, data=m1exp[,..AEOvars])

fitMeasures(mod3.2, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC'))
summary(compareFit(mod3.2,mod3.1))
mi3.2 = modificationindices(mod3.2)
head(mi3.2[order(mi3.2$mi, decreasing=TRUE), ], 10)



fact3.3 <- '
A =~ Dominant + Forceful + Assertive + Outspoken + Selfconfident + Outgoing
E =~ Warm + Outgoing + Lively + Active + Selfconfident
O =~ Imaginative + Intelligent + Curious + Broadminded +
           Sophisticated + Adventurous + Active + Assertive + Selfconfident
# A =~ Selfconfident + Forceful + Assertive + Outspoken + Dominant
# E =~ Warm+Outgoing+Friendly+Lively+Active+Talkative
# O =~ Creative+Imaginative+Intelligent+Curious+Broadminded+
#            Sophisticated+Adventurous+Active
# 
# Warm ~~ Friendly
# Creative ~~ Imaginative
# Forceful ~~ Dominant
'


mod3.3 <- cfa(fact3.3, data=m1exp[,..AEOvars])

summary(mod3.3)
fitMeasures(mod3.3, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC'))
mi3.3 = modificationindices(mod3.3)
head(mi3.3[order(mi3.3$mi, decreasing=TRUE), ], 10)



fact3.4 <- '
A =~ Dominant + Forceful + Assertive + Outspoken + Outgoing + Selfconfident
E =~ Warm + Outgoing + Lively + Active + Selfconfident
O =~ Imaginative + Curious + Broadminded +
           Sophisticated + Adventurous + Active + Assertive + Selfconfident
# A =~ Forceful + Assertive + Outspoken + Dominant
# E =~ Warm+Outgoing+Friendly+Lively+Active+Talkative
# O =~ Creative+Imaginative+Intelligent+Curious+Broadminded+
#            Sophisticated+Adventurous+Active
# 
# Warm ~~ Friendly
# Creative ~~ Imaginative
# Forceful ~~ Dominant
# #Outspoken ~~ Talkative
'


mod3.4 <- cfa(fact3.4, data=m1exp[,..AEOvars])

summary(mod3.4)
fitMeasures(mod3.4, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC'))
mi3.4 = modificationindices(mod3.4)
head(mi3.4[order(mi3.4$mi, decreasing=TRUE), ], 10)



## US
cfa.fDEO.1.con <- cfa(fact3.4, data=m1con[,..AEOvars])

summary(cfa.fDEO.1.con)
fitMeasures(cfa.fDEO.1.con, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC'))


## Japan
cfa.fDEO.1.j.con = cfa(fact3.4, data=midja1)

summary(cfa.fDEO.1.j.con)
fitMeasures(cfa.fDEO.1.j.con, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC'))

mi3.4 = modificationindices(cfa.fDEO.1.j.con)
head(mi3.4[order(mi3.4$mi, decreasing=TRUE), ], 10)

### STOP - so far this is the best for confirmation in the Japanese sample



fact3.5 <- '
A =~ Dominant + Forceful + Assertive + Outspoken + Selfconfident
E =~ Warm + Lively + Active + Selfconfident
O =~ Imaginative + Curious + Broadminded +
           Sophisticated + Adventurous + Active + Assertive + Selfconfident
# A =~ Selfconfident + Forceful + Assertive + Outspoken + Dominant
# E =~ Warm+Outgoing+Friendly+Lively+Active+Talkative
# O =~ Creative+Imaginative+Intelligent+Curious+Broadminded+
#            Sophisticated+Adventurous+Active
# 
# Warm ~~ Friendly
# Creative ~~ Imaginative
# Forceful ~~ Dominant
# Outspoken ~~ Talkative
# Lively ~~ Active
'


mod3.5 <- cfa(fact3.5, data=m1exp)

fitMeasures(mod3.5, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC'))
#summary(compareFit(mod3.5,mod3.4))
mi3.5 = modificationindices(mod3.5)
head(mi3.5[order(mi3.5$mi, decreasing=TRUE), ], 10)



fact3.6 <- '
A =~ Dominant + Forceful + Assertive + Outspoken
E =~ Warm + Lively + Active + Selfconfident
O =~ Imaginative + Curious + Broadminded +
           Sophisticated + Adventurous + Active + Assertive + Selfconfident
# A =~ Selfconfident + Forceful + Assertive + Outspoken + Dominant
# E =~ Warm+Outgoing+Friendly+Lively+Active+Talkative
# O =~ Creative+Imaginative+Intelligent+Curious+Broadminded+
#            Sophisticated+Adventurous+Active
# 
# Warm ~~ Friendly
# Creative ~~ Imaginative
# Forceful ~~ Dominant
# Outspoken ~~ Talkative
# Lively ~~ Active
# Intelligent ~~ Adventurous
'


mod3.6 <- cfa(fact3.6, data=m1exp[,..AEOvars])

fitMeasures(mod3.6, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC'))
#summary(compareFit(mod3.6,mod3.5))
mi3.6 = modificationindices(mod3.6)
head(mi3.6[order(mi3.6$mi, decreasing=TRUE), ], 10)


## US
cfa.fDEO.1.con <- cfa(fact3.6, data=m1con[,..AEOvars])

#summary(cfa.fDEO.1.con)
fitMeasures(cfa.fDEO.1.con, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC'))


## Japan
cfa.fDEO.1.j.con = cfa(fact3.2, data=midja1)

#summary(cfa.fDEO.1.j.con)
fitMeasures(cfa.fDEO.1.j.con, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC'))

mi3.4 = modificationindices(cfa.fDEO.1.j.con)
head(mi3.4[order(mi3.4$mi, decreasing=TRUE), ], 10)






fact3.7 <- '
A =~ Selfconfident + Forceful + Assertive + Outspoken + Dominant
E =~ Warm+Outgoing+Friendly+Lively+Active+Talkative
O =~ Creative+Imaginative+Intelligent+Curious+Broadminded+
           Sophisticated+Adventurous+Active + Selfconfident

Warm ~~ Friendly
Creative ~~ Imaginative
Forceful ~~ Dominant
Outspoken ~~ Talkative
Lively ~~ Active
Intelligent ~~ Adventurous
'


mod3.7 <- cfa(fact3.7, data=m1exp[,..AEOvars])

fitMeasures(mod3.7, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC'))
summary(compareFit(mod3.7,mod3.6))
mi3.7 = modificationindices(mod3.7)
head(mi3.7[order(mi3.7$mi, decreasing=TRUE), ], 10)



fact3.8 <- '
A =~ Selfconfident + Forceful + Assertive + Outspoken + Dominant
E =~ Warm+Outgoing+Friendly+Lively+Active+Talkative
O =~ Creative+Imaginative+Intelligent+Curious+Broadminded+
           Sophisticated+Adventurous+Active + Selfconfident

Warm ~~ Friendly
Creative ~~ Imaginative
Forceful ~~ Dominant
Outspoken ~~ Talkative
Lively ~~ Active
Intelligent ~~ Adventurous
Assertive ~~ Creative
'


mod3.8 <- cfa(fact3.8, data=m1exp[,..AEOvars])

summary(compareFit(mod3.8,mod3.7))
mi3.8 = modificationindices(mod3.8)
head(mi3.8[order(mi3.8$mi, decreasing=TRUE), ], 10)



fact3.9 <- '
A =~ Selfconfident + Forceful + Assertive + Outspoken + Dominant
E =~ Warm+Outgoing+Friendly+Lively+Active+Talkative
O =~ Creative+Imaginative+Intelligent+Curious+Broadminded+
           Sophisticated+Adventurous+Active + Selfconfident

Warm ~~ Friendly
Creative ~~ Imaginative
Forceful ~~ Dominant
Outspoken ~~ Talkative
Lively ~~ Active
Intelligent ~~ Adventurous
Assertive ~~ Creative
Outspoken ~~ Outgoing
'

mod3.9 <- cfa(fact3.9, data=m1exp[,..AEOvars])

summary(compareFit(mod3.9,mod3.8))
mi3.8 = modificationindices(mod3.8)
head(mi3.8[order(mi3.8$mi, decreasing=TRUE), ], 10)




