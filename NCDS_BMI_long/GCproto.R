### Proto type analyses

library(lavaan)


ncds0123$n914 = as.numeric(ncds0123$n914) - 2
ncds0123$n917 = as.numeric(ncds0123$n917) - 2
ncds0123$n923 = as.numeric(ncds0123$n923) - 2
ncds0123$n926 = as.numeric(ncds0123$n926) - 2

ncds0123$n914[ncds0123$n914==-1] = NA
ncds0123$n917[ncds0123$n917==-1] = NA
ncds0123$n923[ncds0123$n923==-1] = NA
ncds0123$n926[ncds0123$n926==-1] = NA



table(ncds0123$n917)



t1 <- '
g =~ n914 + n917 + n926 + n923


'

f.t1 = cfa(t1, data=ncds0123)


summary(mt1)

fitMeasures(mt1, c("chisq", "df", "pvalue", "cfi", "rmsea"))


###



ncds$lvIQsex = ncds$g * (as.numeric(ncds$sex)-1)


bmi.in.t.1 <- '
i =~ 1*bmi16 + 1*bmi23 + 1*bmi33 + 1*bmi42 + 1*bmi55
s =~ 0*bmi16 + 7*bmi23 + 17*bmi33 + 26*bmi42 + 39*bmi55

i ~ sex + g
s ~ sex + g

'

f1 = lavaan(bmi.in.t.1, data=ncds, meanstructure = TRUE, int.ov.free = FALSE, 
            int.lv.free = TRUE, auto.fix.first = TRUE, auto.fix.single = TRUE, 
            auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
            auto.cov.y = TRUE,
            missing = 'fiml', information='observed'
            )

fitMeasures(f1, c("chisq", "df", "pvalue", "cfi", "tli", "srmr", "rmsea"))
summary(f1)



bmi.in.t.2 <- '
i =~ 1*bmi16 + 1*bmi23 + 1*bmi33 + 1*bmi42 + 1*bmi55
s =~ 0*bmi16 + 7*bmi23 + 17*bmi33 + 26*bmi42 + 39*bmi55

i ~ sex + g + lvIQsex
s ~ sex + g + lvIQsex

'

f2 = lavaan(bmi.in.t.2, data=ncds, meanstructure = TRUE, int.ov.free = FALSE, 
            int.lv.free = TRUE, auto.fix.first = TRUE, auto.fix.single = TRUE, 
            auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
            auto.cov.y = TRUE,
            missing = 'fiml', information='observed'
            )

fitMeasures(f2, c("chisq", "df", "pvalue", "cfi", "tli", "srmr", "rmsea"))
summary(f2)



###


t2 <- '
g =~ verbal + nonverbal + maths

i =~ 1*bmi16 + 1*bmi23 + 1*bmi33 + 1*bmi42 + 1*bmi55
s =~ 0*bmi16 + 7*bmi23 + 17*bmi33 + 26*bmi42 + 39*bmi55

i ~ sex + g
s ~ sex + g

'

f.t2 = lavaan(t2, data=ncds, meanstructure = TRUE, int.ov.free = FALSE, 
              int.lv.free = TRUE, auto.fix.first = TRUE, auto.fix.single = TRUE, 
              auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
              auto.cov.y = TRUE,
              missing = 'fiml', information='observed'
)
  


fitMeasures(f.t2, c("chisq", "df", "pvalue", "cfi", "srmr","rmsea"))
summary(f.t2)


# sum(is.na(ncds[!is.na(ncds$sex),]$sex))
# ncdsNoNA = ncds[!is.na(ncds$sex),]


t3 <- '
g =~ verbal + nonverbal + maths

i =~ 1*bmi16 + 1*bmi23 + 1*bmi33 + 1*bmi42 + 1*bmi55
s =~ 0*bmi16 + 7*bmi23 + 17*bmi33 + 26*bmi42 + 39*bmi55

i ~ g
s ~ g

'


f.t3 = lavaan(t3, data=ncds, 
                  meanstructure = TRUE, int.ov.free = FALSE, 
              int.lv.free = TRUE, auto.fix.first = TRUE, auto.fix.single = TRUE, 
              auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
              auto.cov.y = TRUE, group='sex',
              missing = 'fiml', information='observed'
)



fitMeasures(f.t3, c("chisq", "df", "pvalue", "cfi","srmr","rmsea"))
summary(f.t3)


