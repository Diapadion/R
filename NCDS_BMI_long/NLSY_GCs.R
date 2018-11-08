###

library(lavaan)
library(semTools)



### Setup

nlsy = read.csv('NLSY_bmi_inc.csv')

colnames(nlsy)[c(65,83,89,93)] = c('sex','g','education','Youth_SES')


describe(nlsy[,c('sex','g','education','Youth_SES',
                 'bmi_85','bmi_94','bmi_06','bmi_14',
                 'age.85','age.94','age.06','age.14','age_1979',
                 'income.85','income.94','income.06','income.14'
                 )])

## divide age by 10 to scale it on decade, same as the growth scale
nlsy$age.85 = nlsy$age.85/10
nlsy$age.94 = nlsy$age.94/10
nlsy$age.06 = nlsy$age.06/10
nlsy$age.14 = nlsy$age.14/10
nlsy$age_1979 = nlsy$age_1979/10



nlsy.lv = nlsy[nlsy$SAMPLE_ethnicity=='NON-BLACK, NON-HISPANIC',]

nlsy.lv$lvIQsex = nlsy.lv$g * (as.numeric(nlsy.lv$sex)-1)



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

bm.i ~ sex + g + age_1979 + lvIQsex + Youth_SES + education
bm.s ~ sex + g + age_1979 + lvIQsex + Youth_SES + education
bm.q ~ sex + g + age_1979 + lvIQsex + Youth_SES + education

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




