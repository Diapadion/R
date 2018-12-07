###

library(lavaan)
library(semTools)



### Setup

setwd('C:/Users/daltschu/Dropbox/NCDS data/')
nlsy = read.csv('NLSY_bmi_inc.csv')

colnames(nlsy)[c(65,83,89,93)] = c('sex','g','education','Youth_SES')


nlsy.other = nlsy[nlsy$SAMPLE_ethnicity!='NON-BLACK, NON-HISPANIC',]
nlsy = nlsy[nlsy$SAMPLE_ethnicity=='NON-BLACK, NON-HISPANIC',]


## now make Table 1 (GOTO descript.R)


## Sqrt and scale
nlsy$income.85 = sqrt(nlsy$income.85)
nlsy$income.94 = sqrt(nlsy$income.94)
nlsy$income.06 = sqrt(nlsy$income.06)
nlsy$income.14 = sqrt(nlsy$income.14)


## Mean center and scale
inc.m = mean(unlist(nlsy[,c('income.85','income.94','income.06','income.14')]), na.rm=TRUE)
inc.sd= sd(unlist(nlsy[,c('income.85','income.94','income.06','income.14')]), na.rm=TRUE)

nlsy$income.85 = (nlsy$income.85 - inc.m)/inc.sd
nlsy$income.94 = (nlsy$income.94 - inc.m)/inc.sd
nlsy$income.06 = (nlsy$income.06 - inc.m)/inc.sd
nlsy$income.14 = (nlsy$income.14 - inc.m)/inc.sd


## How many implausible BMI values?
length(which((nlsy$bmi_85 > 70) | (nlsy$bmi_85 < 12)))
length(which((nlsy$bmi_94 > 70) | (nlsy$bmi_94 < 12)))
length(which((nlsy$bmi_06 > 70) | (nlsy$bmi_06 < 12)))
length(which((nlsy$bmi_14 > 70) | (nlsy$bmi_14 < 12)))


## invert SES to make it SED
nlsy$Youth_SES = -1 * nlsy$Youth_SES



summary(nlsy[,c('sex','g','education','Youth_SES',
                 'bmi_85','bmi_94','bmi_06','bmi_14',
                 'age.85','age.94','age.06','age.14','age_1979',
                 'income.85','income.94','income.06','income.14'
                 )])





# table(nlsy$sex)
# table(as.integer(nlsy$sex))
# table(as.integer(nlsy$sex)*-1 + 2) 

nlsy.lv = nlsy
#nlsy.lv$sex = as.integer(nlsy.lv$sex) - 1 # women are 0, men are 1
nlsy.lv$sex = as.integer(nlsy.lv$sex)*(-1) + 2 # men are 0, women are 1
nlsy.lv$lvIQsex = nlsy.lv$g * nlsy.lv$sex


## divide age by 10 to scale it on decade, same as the growth scale
nlsy.lv$age.85 = nlsy.lv$age.85/10
nlsy.lv$age.94 = nlsy.lv$age.94/10
nlsy.lv$age.06 = nlsy.lv$age.06/10
nlsy.lv$age.14 = nlsy.lv$age.14/10
nlsy.lv$age_1979 = nlsy.lv$age_1979/10


### Growth curve models


## simple intercept and slope
nlsy.is.m1 <- '
i =~ 1*bmi_85 + 1*bmi_94 + 1*bmi_06 + 1*bmi_14
s =~ 0*bmi_85 + 1.1*bmi_94 + 2.1*bmi_06 + 2.7*bmi_14
'

nlsy.f1 = lavaan(nlsy.is.m1, data=nlsy.lv, meanstructure = TRUE, int.ov.free = FALSE, 
               int.lv.free = TRUE, auto.fix.first = TRUE, auto.fix.single = TRUE, 
               auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
               auto.cov.y = TRUE,
               missing = 'fiml', information='observed'
)

fitMeasures(nlsy.f1, c("chisq", "df", "pvalue", "cfi", "tli", "srmr", "rmsea"))
summary(nlsy.f1)



## simple intercept, slope, and quad + age control
## this is an important null model
nlsy.isq.m1 <- '
i =~ 1*bmi_85 + 1*bmi_94 + 1*bmi_06 + 1*bmi_14
s =~ 0*bmi_85 + 0.9*bmi_94 + 2.1*bmi_06 + 2.9*bmi_14
q =~ 0*bmi_85 + 0.81*bmi_94 + 4.41*bmi_06 + 8.41*bmi_14

bmi_85 ~ age.85
bmi_94 ~ age.94
bmi_06 ~ age.06
bmi_14 ~ age.14

bmi_85 ~~ vbmi85 * bmi_85
vbmi85 > 0.01 

'

isq.f1 = lavaan(nlsy.isq.m1, data=nlsy.lv, meanstructure = TRUE, int.ov.free = FALSE, 
                int.lv.free = TRUE, auto.fix.first = TRUE, auto.fix.single = TRUE, 
                auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
                auto.cov.y = TRUE,
                missing = 'fiml', information='observed'
)

fitMeasures(isq.f1, c("chisq", "df", "pvalue", "cfi", "tli", "srmr", "rmsea"))
summary(isq.f1)



nlsy.isq.m2 <- '
i =~ 1*bmi_85 + 1*bmi_94 + 1*bmi_06 + 1*bmi_14
s =~ 0*bmi_85 + 0.9*bmi_94 + 2.1*bmi_06 + 2.9*bmi_14
q =~ 0*bmi_85 + 0.81*bmi_94 + 4.41*bmi_06 + 8.41*bmi_14

i ~ sex + g + age_1979
s ~ sex + g + age_1979
q ~ sex + g + age_1979

bmi_85 ~ age.85
bmi_94 ~ age.94
bmi_06 ~ age.06
bmi_14 ~ age.14

bmi_85 ~~ vbmi85 * bmi_85
vbmi85 > 0.01

'


isq.f2 = lavaan(nlsy.isq.m2, data=nlsy.lv, meanstructure = TRUE, int.ov.free = FALSE, 
                int.lv.free = TRUE, auto.fix.first = TRUE, auto.fix.single = TRUE, 
                auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
                auto.cov.y = TRUE)

fitMeasures(isq.f2, c("chisq", "df", "pvalue", "cfi", "tli", "srmr", "rmsea"))
summary(isq.f2)



nlsy.isq.m3 <- '
i =~ 1*bmi_85 + 1*bmi_94 + 1*bmi_06 + 1*bmi_14
s =~ 0*bmi_85 + 0.9*bmi_94 + 2.1*bmi_06 + 2.9*bmi_14
q =~ 0*bmi_85 + 0.81*bmi_94 + 4.41*bmi_06 + 8.41*bmi_14

i ~ sex + g + age_1979 + lvIQsex 
s ~ sex + g + age_1979 + lvIQsex
q ~ sex + g + age_1979 + lvIQsex

bmi_85 ~ age.85
bmi_94 ~ age.94
bmi_06 ~ age.06
bmi_14 ~ age.14

bmi_85 ~~ vbmi85 * bmi_85
vbmi85 > 0.01

'


isq.f3 = lavaan(nlsy.isq.m3, data=nlsy.lv, meanstructure = TRUE, int.ov.free = FALSE, 
                int.lv.free = TRUE, auto.fix.first = TRUE, auto.fix.single = TRUE, 
                auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
                auto.cov.y = TRUE)


fitMeasures(isq.f3, c("chisq", "df", "pvalue", "cfi", "tli", "srmr", "rmsea"))
summary(isq.f3)



nlsy.isq.m4 <- '
bm.i =~ 1*bmi_85 + 1*bmi_94 + 1*bmi_06 + 1*bmi_14
bm.s =~ 0*bmi_85 + 0.9*bmi_94 + 2.1*bmi_06 + 2.9*bmi_14
bm.q =~ 0*bmi_85 + 0.81*bmi_94 + 4.41*bmi_06 + 8.41*bmi_14

bm.i ~ sex + g + age_1979 + lvIQsex + Youth_SES + education
bm.s ~ sex + g + age_1979 + lvIQsex + Youth_SES + education
bm.q ~ sex + g + age_1979 + lvIQsex + Youth_SES + education

bmi_85 ~ age.85
bmi_94 ~ age.94
bmi_06 ~ age.06
bmi_14 ~ age.14

bmi_85 ~~ vbmi85 * bmi_85
vbmi85 > 0.01

'

isq.f4 = lavaan(nlsy.isq.m4, data=nlsy.lv, meanstructure = TRUE, int.ov.free = FALSE, 
                int.lv.free = TRUE, auto.fix.first = TRUE, auto.fix.single = TRUE, 
                auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
                auto.cov.y = TRUE)


fitMeasures(isq.f4, c("chisq", "df", "pvalue", "cfi", "tli", "srmr", "rmsea"))
summary(isq.f4)



### Incorportating income


## Poor fit
# inc.isq.m1 <- '
# i =~ 1*income.85 + 1*income.94 + 1*income.06 + 1*income.14
# s =~ 0*income.85 + 0.9*income.94 + 2.1*income.06 + 2.9*income.14
# q =~ 0*income.85 + 0.81*income.94 + 4.41*income.06 + 8.41*income.14
# 
# '
# 
# inc.isq.f1 = lavaan(inc.isq.m1, data=nlsy.lv, meanstructure = TRUE, int.ov.free = FALSE, 
#                     int.lv.free = TRUE, auto.fix.first = TRUE, auto.fix.single = TRUE, 
#                     auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
#                     auto.cov.y = TRUE,
#                     missing = 'fiml', information='observed'
# )
# 
# fitMeasures(inc.isq.f1, c("chisq", "df", "pvalue", "cfi", "tli", "srmr", "rmsea"))
# summary(inc.isq.f1)
# 
# 
# 
# nlsy.isq.m5 <- '
# bm.i =~ 1*bmi_85 + 1*bmi_94 + 1*bmi_06 + 1*bmi_14
# bm.s =~ 0*bmi_85 + 0.9*bmi_94 + 2.1*bmi_06 + 2.9*bmi_14
# bm.q =~ 0*bmi_85 + 0.81*bmi_94 + 4.41*bmi_06 + 8.41*bmi_14
# 
# inc.i =~ 1*income.85 + 1*income.94 + 1*income.06 + 1*income.14
# inc.s =~ 0*income.85 + 0.9*income.94 + 2.1*income.06 + 2.9*income.14
# inc.q =~ 0*income.85 + 0.81*income.94 + 4.41*income.06 + 8.41*income.14
# 
# bm.i ~ sex + g + age_1979 + lvIQsex + Youth_SES + education
# bm.s ~ sex + g + age_1979 + lvIQsex + Youth_SES + education
# bm.q ~ sex + g + age_1979 + lvIQsex + Youth_SES + education
# 
# bm.i ~~ inc.i
# bm.i ~~ inc.s
# bm.i ~~ inc.q
# bm.s ~~ inc.i
# bm.s ~~ inc.s
# bm.s ~~ inc.q
# bm.q ~~ inc.i
# bm.q ~~ inc.s
# bm.q ~~ inc.q
# 
# bmi_85 ~ age.85
# bmi_94 ~ age.94
# bmi_06 ~ age.06
# bmi_14 ~ age.14
# 
# bmi_85 ~~ vbmi85 * bmi_85
# vbmi85 > 0.01
# 
# '
# 
# isq.f5 = lavaan(nlsy.isq.m5, data=nlsy.lv, meanstructure = TRUE, int.ov.free = FALSE, 
#                 int.lv.free = TRUE, auto.fix.first = TRUE, auto.fix.single = TRUE, 
#                 auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
#                 auto.cov.y = TRUE, fixed.x=TRUE,
#                 missing = 'fiml', information='expected'
# )
# 
# 
# fitMeasures(isq.f5, c("chisq", "df", "pvalue", "cfi", "tli", "srmr", "rmsea"))
# summary(isq.f5)



nlsy.isq.m6 <- '
bm.i =~ 1*bmi_85 + 1*bmi_94 + 1*bmi_06 + 1*bmi_14
bm.s =~ 0*bmi_85 + 0.9*bmi_94 + 2.1*bmi_06 + 2.9*bmi_14
bm.q =~ 0*bmi_85 + 0.81*bmi_94 + 4.41*bmi_06 + 8.41*bmi_14

bm.i ~ sex + g + lvIQsex + age_1979 + Youth_SES + education
bm.s ~ sex + g + lvIQsex + age_1979 + Youth_SES + education
bm.q ~ sex + g + lvIQsex + age_1979 + Youth_SES + education 

bmi_85 ~ age.85 + income.85
bmi_94 ~ age.94 + income.94
bmi_06 ~ age.06 + income.06
bmi_14 ~ age.14 + income.14

bmi_85 ~~ vbmi85 * bmi_85
vbmi85 > 0.01

'


isq.f6 = lavaan(nlsy.isq.m6, data=nlsy.lv, meanstructure = TRUE, int.ov.free = FALSE, 
                int.lv.free = TRUE, auto.fix.first = TRUE, auto.fix.single = TRUE, 
                auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
                auto.cov.y = TRUE, fixed.x=TRUE,
                estimator='MLF', #se='robust.sem',test='Yuan.Bentler',
                missing = 'fiml', information='expected'
                
)

fitMeasures(isq.f6, c("chisq", "df", "pvalue", "cfi", "tli", "srmr", "rmsea"))
summary(isq.f6)




library(xtable)
library(R2HTML)

myXtable <- xtable(parameterEstimates(isq.f5))
coef_rl = print(myXtable, type = "html")
# now here is the hack, i spit the file in html but with .doc ext so that it can be opened in word directly

fname = 'isq5'
HTML(coef_rl, paste(fname,"_model_coeff.doc", sep='')) 




