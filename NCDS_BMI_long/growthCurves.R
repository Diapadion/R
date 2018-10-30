### LV analyses of BMI changes throughout adulthood

## Ideally, these models can be fit the same way in both NCDS and NLSY



library(lavaan)
library(semTools)



table(as.numeric(ncds$sex))
ncds$lvIQsex = ncds$g * (as.numeric(ncds$sex)-1)



ncds.isq.m1 <- '
bm.i =~ 1*bmi23 + 1*bmi33 + 1*bmi42 + 1*bmi55
bm.s =~ 0*bmi23 + 1*bmi33 + 1.9*bmi42 + 3.2*bmi55
bm.q =~ 0*bmi23 + 1*bmi33 + 3.61*bmi42 + 10.24*bmi55

bm.i ~ sex + g
bm.s ~ sex + g
bm.q ~ sex + g

#bmi23 ~ Vbmi23 * bmi23
#Vbmi23 > 0

'

isq.f1 = lavaan(ncds.isq.m1, data=ncds, meanstructure = TRUE, int.ov.free = FALSE, 
                int.lv.free = TRUE, auto.fix.first = TRUE, auto.fix.single = TRUE, 
                auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
                auto.cov.y = TRUE, #fixed.x = F, # is this okay???
                missing = 'fiml', information='observed'
)

fitMeasures(isq.f1, c("chisq", "df", "pvalue", "cfi", "tli", "srmr", "rmsea"))
summary(isq.f1)






ncds.isq.m2 <- '
bm.i =~ 1*bmi23 + 1*bmi33 + 1*bmi42 + 1*bmi55
bm.s =~ 0*bmi23 + 1*bmi33 + 1.9*bmi42 + 3.2*bmi55
bm.q =~ 0*bmi23 + 1*bmi33 + 3.61*bmi42 + 10.24*bmi55

bm.i ~ sex + g + lvIQsex
bm.s ~ sex + g + lvIQsex
bm.q ~ sex + g + lvIQsex

'


isq.f2 = lavaan(ncds.isq.m2, data=ncds, meanstructure = TRUE, int.ov.free = FALSE, 
                int.lv.free = TRUE, auto.fix.first = TRUE, auto.fix.single = TRUE, 
                auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
                auto.cov.y = TRUE, fixed.x = F,
                missing = 'fiml', information='observed'
)

fitMeasures(isq.f2, c("chisq", "df", "pvalue", "cfi", "tli", "srmr", "rmsea"))
summary(isq.f2)






ncds.isq.m3 <- '
bm.i =~ 1*bmi23 + 1*bmi33 + 1*bmi42 + 1*bmi55
bm.s =~ 0*bmi23 + 1*bmi33 + 1.9*bmi42 + 3.2*bmi55
bm.q =~ 0*bmi23 + 1*bmi33 + 3.61*bmi42 + 10.24*bmi55

bm.i ~ sex + g + lvIQsex + Youth_SES + education
bm.s ~ sex + g + lvIQsex + Youth_SES + education
bm.q ~ sex + g + lvIQsex + Youth_SES + education

'


isq.f3 = lavaan(ncds.isq.m3, data=ncds, meanstructure = TRUE, int.ov.free = FALSE, 
                int.lv.free = TRUE, auto.fix.first = TRUE, auto.fix.single = TRUE, 
                auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
                auto.cov.y = TRUE,
                missing = 'fiml', information='observed'
)

fitMeasures(isq.f3, c("chisq", "df", "pvalue", "cfi", "tli", "srmr", "rmsea"))
summary(isq.f3)



ncds.isq.m4 <- '
bm.i =~ 1*bmi23 + 1*bmi33 + 1*bmi42 + 1*bmi55
bm.s =~ 0*bmi23 + 1*bmi33 + 1.9*bmi42 + 3.2*bmi55
bm.q =~ 0*bmi23 + 1*bmi33 + 3.61*bmi42 + 10.24*bmi55

inc.i =~ 1*income23 + 1*income33 + 1*income42 + 1*income50 + 1*income55
inc.s =~ 0*income23 + 1*income33 + 1.9*income42 + 2.7*income50 + 3.2*income55
inc.q =~ 0*income23 + 1*income33 + 3.61*income42 + 7.29*income50 + 10.24*income55

bm.i ~ sex + g + lvIQsex + Youth_SES + education
bm.s ~ sex + g + lvIQsex + Youth_SES + education
bm.q ~ sex + g + lvIQsex + Youth_SES + education

bm.i ~~ inc.i
bm.i ~~ inc.s
bm.i ~~ inc.q
bm.s ~~ inc.i
bm.s ~~ inc.s
bm.s ~~ inc.q
bm.q ~~ inc.i
bm.q ~~ inc.s
bm.q ~~ inc.q

'


isq.f4 = lavaan(ncds.isq.m4, data=ncds, meanstructure = TRUE, int.ov.free = FALSE, 
                int.lv.free = TRUE, auto.fix.first = TRUE, auto.fix.single = TRUE, 
                auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
                auto.cov.y = TRUE,
                missing = 'fiml', information='observed'
)

fitMeasures(isq.f4, c("chisq", "df", "pvalue", "cfi", "tli", "srmr", "rmsea"))
summary(isq.f4)



library(xtable)
library(R2HTML)

myXtable <- xtable(parameterEstimates(isq.f4))
coef_rl = print(myXtable, type = "html")
# now here is the hack, i spit the file in html but with .doc ext so that it can be opened in word directly
      
fname = 'isq4'
HTML(coef_rl, paste(fname,"_model_coeff.doc", sep='')) 


