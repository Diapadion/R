### A-B job script - MIDUS 2 & 3 factor CFAs

library(blavaan)
library(foreign)
library(psych)
library(semTools)

# must pre-source 'importMIDUS1.R'

AEOvars = c('Selfconfident','Forceful','Assertive','Outspoken','Dominant',
            'Creative','Imaginative','Intelligent','Curious','Broadminded',
            'Sophisticated','Adventurous','Warm',
            'Outgoing','Friendly','Lively','Active','Talkative'
)



fact2 <- '
E =~ Selfconfident + Forceful + Assertive + Outspoken + Dominant+
           Warm+Outgoing+Friendly+Lively+Active+Talkative
O =~ Creative+Imaginative+Intelligent+Curious+Broadminded+
           Sophisticated+Adventurous+Active

'


fact3 <- '
A =~ Selfconfident + Forceful + Assertive + Outspoken + Dominant
E =~ Warm+Outgoing+Friendly+Lively+Active+Talkative
O =~ Creative+Imaginative+Intelligent+Curious+Broadminded+
           Sophisticated+Adventurous+Active

'






b.fit2 <- bcfa(fact2, data=as.matrix(m1con)[,AEOvars], convergence = 'auto', test='none')
#convergence = 'auto' )
b.fit2.tst <- bcfa(fact2, data=as.matrix(m1con)[complete.cases(as.matrix(m1con)[,AEOvars]),AEOvars], convergence = 'auto')

b.fit3 <- bcfa(fact3, data=as.matrix(m1con)[,AEOvars], convergence = 'auto', test='none')
#convergence = 'auto' )
b.fit3.tst <- bcfa(fact3, data=as.matrix(m1con)[complete.cases(as.matrix(m1con)[,AEOvars]),AEOvars], convergence = 'auto')#, test='none')

b.fit2.fm = fitMeasures(b.fit2.tst)
b.fit3.fm = fitMeasures(b.fit3.tst)






