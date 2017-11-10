 ### A-B job script - IPIP 3 factor

library(blavaan)
library(foreign)
library(psych)

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

EOvars = c(
  #Extraversion
  'I2',  # Frd
  'I7',  # Grg
  'I12', # Ast
  'I17', # Act
  'I22', # Exc
  'I27', # Chr
  'I32', # Frd
  'I37', # Grg
  'I42', # Ast
  'I47', # Act
  'I52', # Exc
  'I57', # Chr
  'I62', # Frd
  'I67', # Grg
  'I72', # Ast
  'I77', # Act
  'I82', # Exc
  'I87', # Chr
  'I92', # Frd
  'I97', # Grg
  'I102', # Ast
  'I107', # Act
  'I112', # Exc
  'I117', # Chr
  'I122', # Frd
  'I127', # Grg
  'I132', # Ast
  'I137', # Act
  'I142', # Exc
  'I147', # Chr
  'I152', # Frd
  'I157', # Grg
  'I162', # Ast
  'I167', # Act
  'I172', # Exc
  'I177', # Chr
  'I182', # Frd
  'I187', # Grg
  'I192', # Ast
  'I197', # Act
  'I202', # Exc
  'I207', # Chr
  'I212', # Frd
  'I217', # Grg
  'I222', # Ast
  'I227', # Act
  'I232', # Exc
  'I237', # Chr
  'I242', # Frd
  'I247', # Grg
  'I252', # Ast
  'I257', # Act
  'I262', # Exc
  'I267', # Chr
  'I272', # Frd
  'I277', # Grg
  'I282', # Ast
  'I287', # Act
  'I292', # Exc
  'I297', # Chr
  # Openness
  'I3',  # Img
  'I8',  # Art
  'I13', # Emo
  'I18', # Adv
  'I23', # Int
  'I28', # Lib
  'I33', # Img
  'I38', # Art
  'I43', # Emo
  'I48', # Adv
  'I53', # Int
  'I58', # Lib
  'I63', # Img
  'I68', # Art
  'I73', # Emo
  'I78', # Adv
  'I83', # Int
  'I88', # Lib
  'I93', # Img
  'I98', # Art
  'I103', # Emo
  'I108', # Adv
  'I113', # Int
  'I118', # Lib
  'I123', # Img
  'I128', # Art
  'I133', # Emo
  'I138', # Adv
  'I143', # Int
  'I148', # Lib
  'I153', # Img
  'I158', # Art
  'I163', # Emo
  'I168', # Adv
  'I173', # Int
  'I178', # Lib
  'I183', # Img
  'I188', # Art
  'I193', # Emo
  'I198', # Adv
  'I203', # Int
  'I208', # Lib
  'I213', # Img
  'I218', # Art
  'I223', # Emo
  'I228', # Adv
  'I233', # Int
  'I238', # Lib
  'I243', # Img
  'I248', # Art
  'I253', # Emo
  'I258', # Adv
  'I263', # Int
  'I268', # Lib
  'I273', # Img
  'I278', # Art
  'I283', # Emo
  'I288', # Adv
  'I293', # Int
  'I298'  # Lib
)


b.ipip.f3.h <- bcfa(ipip.m3.h, data=ipipExpl[,EOvars], convergence = 'auto') 

b.ipip.f3.h.fm = fitMeasures(b.ipip.f3.h)
