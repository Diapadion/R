### LV analyses of BMI changes throughout adulthood

## Ideally, these models can be fit the same way in both NCDS and NLSY



library(lavaan)



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

