### LV analyses of BMI changes throughout adulthood

## Ideally, these models can be fit the same way in both NCDS and NLSY



library(lavaan)
library(semTools)



## Test if sqrt improves model fit(s)
ncds$income23 = sqrt(ncds$income23)
ncds$income33 = sqrt(ncds$income33)
ncds$income42 = sqrt(ncds$income42)
ncds$income50 = sqrt(ncds$income50)
ncds$income55 = sqrt(ncds$income55)


## Scaling
inc.m = mean(unlist(ncds[,c('income23','income33','income42','income50','income55')]), na.rm=TRUE)
inc.sd = sd(unlist(ncds[,c('income23','income33','income42','income50','income55')]), na.rm=TRUE)

ncds$income23 = (ncds$income23 - inc.m)/inc.sd
ncds$income33 = (ncds$income33 - inc.m)/inc.sd
ncds$income42 = (ncds$income42 - inc.m)/inc.sd
ncds$income50 = (ncds$income50 - inc.m)/inc.sd
ncds$income55 = (ncds$income55 - inc.m)/inc.sd



# table(ncds$sex)
# table(as.integer(ncds$sex))
# table(as.numeric(ncds$sex)-1)

# ncds$sex = as.integer(ncds$sex)*-1 + 2 # women are 0, men are 1
ncds$sex = as.integer(ncds$sex)-1 # men are 0, women are 1

## invert SES to make it SED
ncds$Youth_SES = -1 * ncds$Youth_SES

ncds$lvIQsex = ncds$g * ncds$sex

# table(ncds$lvIQsex, useNA='ifany')



ncds.isq.m1 <- '
bm.i =~ 1*bmi23 + 1*bmi33 + 1*bmi42 + 1*bmi55
bm.s =~ 0*bmi23 + 1*bmi33 + 1.9*bmi42 + 3.2*bmi55
bm.q =~ 0*bmi23 + 1*bmi33 + 3.61*bmi42 + 10.24*bmi55

# bm.i ~ sex + g
# bm.s ~ sex + g
# bm.q ~ sex + g

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

inc.i =~ 1*income23 + 1*income33 + 1*income42 + 1*income50 #+ 1*income55
inc.s =~ 0*income23 + 1*income33 + 1.9*income42 + 2.7*income50 #+ 3.2*income55
inc.q =~ 0*income23 + 1*income33 + 3.61*income42 + 7.29*income50 #+ 10.24*income55

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

# inc.i ~~ vinc.i * inc.i
# vinc.i > 0.01

'


isq.f4 = lavaan(ncds.isq.m4, data=ncds, meanstructure = TRUE, int.ov.free = FALSE, 
                int.lv.free = TRUE, auto.fix.first = TRUE, auto.fix.single = TRUE, 
                auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
                auto.cov.y = TRUE,
                missing = 'fiml', information='observed'
)

fitMeasures(isq.f4, c("chisq", "df", "pvalue", "cfi", "tli", "srmr", "rmsea"))
summary(isq.f4)



ncds.isq.m5 <- '
bm.i =~ 1*bmi23 + 1*bmi33 + 1*bmi42 + 1*bmi55
bm.s =~ 0*bmi23 + 1*bmi33 + 1.9*bmi42 + 3.2*bmi55
bm.q =~ 0*bmi23 + 1*bmi33 + 3.61*bmi42 + 10.24*bmi55

bm.i ~ sex + g + lvIQsex + Youth_SES + education
bm.s ~ sex + g + lvIQsex + Youth_SES + education
bm.q ~ sex + g + lvIQsex + Youth_SES + education

bmi23 ~ income23
bmi33 ~ income33
bmi42 ~ income42
bmi55 ~ income50

bmi23 ~~ vbmi23 * bmi23
vbmi23 > 0.01

'


isq.f5 = lavaan(ncds.isq.m5, data=ncds, meanstructure = TRUE, int.ov.free = FALSE, 
                int.lv.free = TRUE, auto.fix.first = TRUE, auto.fix.single = TRUE, 
                auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
                auto.cov.y = TRUE,
                estimator='MLF', #se='robust',test='Yuan.Bentler',
                missing = 'fiml', information='observed'
)

fitMeasures(isq.f5, c("chisq", "df", "pvalue", "cfi", "tli", "srmr", "rmsea"))
summary(isq.f5)







library(xtable)
library(R2HTML)

myXtable <- xtable(parameterEstimates(isq.f4))
coef_rl = print(myXtable, type = "html")
# now here is the hack, i spit the file in html but with .doc ext so that it can be opened in word directly
      
fname = 'isq4'
HTML(coef_rl, paste(fname,"_model_coeff.doc", sep='')) 


