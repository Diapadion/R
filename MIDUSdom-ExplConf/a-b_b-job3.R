### A-B job script - MIDJA 2 & 3 factor CFAs

library(blavaan)
library(foreign)
library(psych)
library(semTools)

# must pre-source 'importMIDJA1.R'

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



b.fit2.j <- bcfa(fact2, data=as.matrix(midja1)[,AEOvars], convergence = 'auto', test='none')
#convergence = 'auto' )
b.fit2.j.tst <- bcfa(fact2, data=as.matrix(midja1)[complete.cases(as.matrix(midja1)[,AEOvars]),AEOvars], convergence = 'auto')

b.fit3.j <- bcfa(fact3, data=as.matrix(midja1)[,AEOvars], convergence = 'auto', test='none')
#convergence = 'auto' )
b.fit3.j.tst <- bcfa(fact3, data=as.matrix(midja1)[complete.cases(as.matrix(midja1)[,AEOvars]),AEOvars], convergence = 'auto')#, test='none')

b.fit2.j.fm = fitMeasures(b.fit2.j.tst)
b.fit3.j.fm = fitMeasures(b.fit3.j.tst)









