### A-B job script - MIDUS 3 factor cross-loadings

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


# m.2.fa = fa(m1exp[,AEOvars], 2)
# m.3.fa = fa(m1exp[,AEOvars], 3)



### UNFINISHED







df = read.spss("IPIP300.por", to.data.frame=T)

set.seed(12345)
ipip.samp = sample(dim(df)[1], 20000)
ipipExpl = df[ipip.samp[1:10000],]
ipipConf = df[ipip.samp[10001:20000],]

ipip.m3.h <-'
Ast =~ I12 + I42 + I72 + I102 + I132 + I162 + I192 + I222 + I252 + I282

Act =~ I17 + I47 + I77 + I107 + I137 + I167 + I197 + I227 + I257 + I287
Frd =~ I2 + I32 + I62 + I92 + I122 + I152 + I182 + I212 + I242 + I272
Grg =~ I7 + I37 + I67 + I97 + I127 + I157 + I187 + I217 + I247 + I277
Exc =~ I22 + I52 + I82 + I112 + I142 + I172 + I202 + I232 + I262 + I292
Chr =~ I27 + I57 + I87 + I117 + I147 + I177 + I207 + I237 + I267 + I297

Img =~ I3 + I33 + I63 + I93 + I123 + I153 + I183 + I213 + I243 + I273
Art =~ I8 + I38 + I68 + I98 + I128 + I158 + I188 + I218 + I248 + I278
Emo =~ I13 + I43 + I73 + I103 + I133 + I163 + I193 + I223 + I253 + I283
Adv =~ I18 + I48 + I78 + I108 + I138 + I168 + I198 + I228 + I258 + I288
Int =~ I23 + I53 + I83 + I113 + I143 + I173 + I203 + I233 + I263 + I293
Lib =~ I28 + I58 + I88 + I118 + I148 + I178 + I208 + I238 + I268 + I298

E =~ Act + Frd + Grg + Exc + Chr
O =~ Img + Art + Emo + Adv + Int + Lib

'
