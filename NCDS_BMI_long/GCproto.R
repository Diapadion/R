### Proto type analyses

library(lavaan)



### Trying out income growth curves 

## TODO: this needs to be in the import file
## should it be applied to other variables? (e.g. BMI)
temp = scale(ncds[,c('income23','income33','income42','income50','income55')])

ncds$income23 = temp[,'income23']
ncds$income33 = temp[,'income33']
ncds$income42 = temp[,'income42']
ncds$income50 = temp[,'income50']
ncds$income55 = temp[,'income55']



inc.is.m1 <- '
# inc.i =~ 1*income23 + 1*income33 + 1*income42 + 1*income55
# inc.s =~ 0*income23 + 1*income33 + 1.9*income42 + 3.2*income55

# inc.i =~ 1*income23 + 1*income33 + 1*income42 + 1*income50
# inc.s =~ 0*income23 + 1*income33 + 1.9*income42 + 2.7*income50

inc.i =~ 1*income23 + 1*income33 + 1*income42 + 1*income50 + 1*income55
inc.s =~ 0*income23 + 1*income33 + 1.9*income42 + 2.7*income50 + 3.2*income55


#inc.q =~ 0*income23 + 1*income33 + 3.61*income42 + 10.24*income55

'

inc.is.f1 = lavaan(inc.is.m1, data=ncds, meanstructure = TRUE, int.ov.free = FALSE, 
                int.lv.free = TRUE, auto.fix.first = TRUE, auto.fix.single = TRUE, 
                auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
                auto.cov.y = TRUE, #fixed.x = F, # is this okay???
                missing = 'fiml', information='observed'
)
lavInspect(inc.is.f1, "cor.lv")

fitMeasures(inc.is.f1, c("chisq", "df", "pvalue", "cfi", "tli", "srmr", "rmsea"))
summary(inc.is.f1)



inc.isq.m1 <- '
inc.i =~ 1*income23 + 1*income33 + 1*income42 + 1*income50 + 1*income55
inc.s =~ 0*income23 + 1*income33 + 1.9*income42 + 2.7*income50 + 3.2*income55
inc.q =~ 0*income23 + 1*income33 + 3.61*income42 + 7.29*income50 + 10.24*income55

# inc.i =~ 1*income23 + 1*income33 + 1*income42 + 1*income50
# inc.s =~ 0*income23 + 1*income33 + 1.9*income42 + 2.7*income50
# inc.q =~ 0*income23 + 1*income33 + 3.61*income42 + 7.29*income50

# inc.i ~ sex + g + 
# inc.s ~ sex + g
# inc.q ~ sex + g

'

inc.isq.f1 = lavaan(inc.isq.m1, data=ncds, meanstructure = TRUE, int.ov.free = FALSE, 
                   int.lv.free = TRUE, auto.fix.first = TRUE, auto.fix.single = TRUE, 
                   auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
                   auto.cov.y = TRUE, #fixed.x = F, # is this okay???
                   missing = 'fiml', information='observed'
)
lavInspect(inc.isq.f1, "cor.lv")

fitMeasures(inc.isq.f1, c("chisq", "df", "pvalue", "cfi", "tli", "srmr", "rmsea"))
summary(inc.isq.f1)




ncds$lvIQeducation = ncds$g * ncds$education
ncds$lvIQySES = ncds$g * ncds$Youth_SES
ncds$lvySESedu = ncds$education * ncds$Youth_SES
ncds$lvIQySESedu = ncds$g * ncds$Youth_SES * ncds$education

ncds$lvIQsexedu = ncds$g * (as.numeric(ncds$sex)-1) * ncds$education



inc.isq.m2 <- '
inc.i =~ 1*income23 + 1*income33 + 1*income42 + 1*income50 #+ 1*income55
inc.s =~ 0*income23 + 1*income33 + 1.9*income42 + 2.7*income50 #+ 3.2*income55
inc.q =~ 0*income23 + 1*income33 + 3.61*income42 + 7.29*income50 #+ 10.24*income55

inc.i ~ sex + g + education + Youth_SES + lvIQeducation + lvIQySES + lvySESedu + lvIQySESedu + lvIQsexedu
inc.s ~ sex + g + education + Youth_SES + lvIQeducation + lvIQySES + lvySESedu + lvIQySESedu + lvIQsexedu
inc.q ~ sex + g + education + Youth_SES + lvIQeducation + lvIQySES + lvySESedu + lvIQySESedu + lvIQsexedu

'

inc.isq.f2 = lavaan(inc.isq.m2, data=ncds, meanstructure = TRUE, int.ov.free = FALSE, 
                    int.lv.free = TRUE, auto.fix.first = TRUE, auto.fix.single = TRUE, 
                    auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
                    auto.cov.y = TRUE, #fixed.x = F, # is this okay???
                    missing = 'fiml', information='observed'
)
lavInspect(inc.isq.f2, "cor.lv")

fitMeasures(inc.isq.f2, c("chisq", "df", "pvalue", "cfi", "tli", "srmr", "rmsea"))
summary(inc.isq.f2)




#######

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

fitMeasures(mt1, c("chisq", "df", "pvalue", "cfi", "rmsea", 'srmr'))


###


bmi.is.m1 <- '
i =~ 1*bmi16 + 1*bmi23 + 1*bmi33 + 1*bmi42 + 1*bmi55
s =~ 0*bmi16 + 0.7*bmi23 + 1.7*bmi33 + 2.6*bmi42 + 3.9*bmi55
'

is.f1 = lavaan(bmi.is.m1, data=ncds, meanstructure = TRUE, int.ov.free = FALSE, 
            int.lv.free = TRUE, auto.fix.first = TRUE, auto.fix.single = TRUE, 
            auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
            auto.cov.y = TRUE,
            missing = 'fiml', information='observed'
)

fitMeasures(is.f1, c("chisq", "df", "pvalue", "cfi", "tli", "srmr", "rmsea"))
summary(f1)



bmi.isq.m1 <- '
i =~ 1*bmi16 + 1*bmi23 + 1*bmi33 + 1*bmi42 + 1*bmi55
s =~ 0*bmi16 + 0.7*bmi23 + 1.7*bmi33 + 2.6*bmi42 + 3.9*bmi55
q =~ 0*bmi16 + 0.49*bmi23 + 2.89*bmi33 + 6.76*bmi42 + 15.21*bmi55
'

isq.f1 = lavaan(bmi.isq.m1, data=ncds, meanstructure = TRUE, int.ov.free = FALSE, 
               int.lv.free = TRUE, auto.fix.first = TRUE, auto.fix.single = TRUE, 
               auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
               auto.cov.y = TRUE,
               missing = 'fiml', information='observed'
)

fitMeasures(isq.f1, c("chisq", "df", "pvalue", "cfi", "tli", "srmr", "rmsea"))
summary(isq.f1)





ncds$lvIQsex = ncds$g * (as.numeric(ncds$sex)-1)


bmi.isq.m2 <- '
i =~ 1*bmi16 + 1*bmi23 + 1*bmi33 + 1*bmi42 + 1*bmi55
s =~ 0*bmi16 + 0.7*bmi23 + 1.7*bmi33 + 2.6*bmi42 + 3.9*bmi55
q =~ 0*bmi16 + 0.49*bmi23 + 2.89*bmi33 + 6.76*bmi42 + 15.21*bmi55

i ~ sex + g
s ~ sex + g
q ~ sex + g

'

isq.f2 = lavaan(bmi.isq.m2, data=ncds, meanstructure = TRUE, int.ov.free = FALSE, 
            int.lv.free = TRUE, auto.fix.first = TRUE, auto.fix.single = TRUE, 
            auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
            auto.cov.y = TRUE,
            missing = 'fiml', information='observed'
            )

fitMeasures(isq.f2, c("chisq", "df", "pvalue", "cfi", "tli", "srmr", "rmsea"))
summary(isq.f2)



bmi.isq.m3 <- '
i =~ 1*bmi16 + 1*bmi23 + 1*bmi33 + 1*bmi42 + 1*bmi55
s =~ 0*bmi16 + 0.7*bmi23 + 1.7*bmi33 + 2.6*bmi42 + 3.9*bmi55
q =~ 0*bmi16 + 0.49*bmi23 + 2.89*bmi33 + 6.76*bmi42 + 15.21*bmi55

i ~ sex + g + lvIQsex
s ~ sex + g + lvIQsex
q ~ sex + g + lvIQsex

'

isq.f3 = lavaan(bmi.isq.m3, data=ncds, meanstructure = TRUE, int.ov.free = FALSE, 
            int.lv.free = TRUE, auto.fix.first = TRUE, auto.fix.single = TRUE, 
            auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
            auto.cov.y = TRUE,
            missing = 'fiml', information='observed'
            )

fitMeasures(isq.f3, c("chisq", "df", "pvalue", "cfi", "tli", "srmr", "rmsea"))
summary(isq.f3)



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


