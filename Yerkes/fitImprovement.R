### Improving Fit


mod_ind <- modificationindices(f3.2)
head(mod_ind[order(mod_ind$mi, decreasing=TRUE), ], 10)
subset(mod_ind[order(mod_ind$mi, decreasing=TRUE), ], mi > 5)

imp.m0 <- ' # Null model (f3.3b)
AL =~ c(chLV,chLV,chLV)*chol + c(trLV,trLV,trLV)*trig + c(sLV,sLV,sLV)*sys + s(dLV,dLV,dLV)*dias + c(bLV,bLV,bLV)*BMI

AL ~ sex + age + age2 + Dominance + Extraversion + Openness + Conscientiousness + Agreeableness + Neuroticism

sys ~~ dias
sys ~~ trig
sys ~~ BMI
sys ~~ chol
dias ~~ trig
dias ~~ BMI
dias ~~ chol
trig ~~ BMI
trig ~~ chol
BMI ~~ chol

# within particular samples these variances tend to go negative, so we set them = to 0
sys ~~ c(vSysJ,vSysA,vSysC)*sys
dias ~~ c(vDiasJ,vDiasA,vDiasC)*dias
chol ~~ c(vChJ,vChA,vChC)*chol
trig ~~ c(vTrigJ,vTrigA,vTrigC)*trig
BMI ~~ c(vBMIJ,vBMIA,vBMIC)*BMI

vChC > 0
vTrigC > 0
vTrigA > 0
vSysA > 0
vChJ > 0
vBMIJ > 0
vDiasJ > 0
vDiasA > 0
vDiasC > 0
'

imp.f0 <- lavaan(imp.m0, data = all3, missing="ML", group = 'sample', 
                group.equal = c("regressions"),
                group.partial = c("AL ~ sex","AL ~ age","AL ~ age2")
                ,model.type='sem', std.lv = T, int.ov.free = TRUE, int.lv.free = T, auto.fix.first = T, 
                auto.fix.single = TRUE, auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
                auto.cov.y = TRUE

)

imp.f3 <- lavaan(imp.m0, data = all3, missing="ML", group = 'sample', 
                 ,model.type='sem', std.lv = T, int.ov.free = TRUE, int.lv.free = T, auto.fix.first = T, 
                 auto.fix.single = TRUE, auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
                 auto.cov.y = TRUE
                 
)

imp.m1 <- '
AL =~ c(chLV,chLV,chLV)*chol + c(trLV,trLV,trLV)*trig + c(sLV,sLV,sLV)*sys + s(dLV,dLV,dLV)*dias + c(bLV,bLV,bLV)*BMI

AL ~ sex + age + age2 + c(d1,d1,d2)*Dominance + c(e1,e1,e2)* Extraversion + c(o1,o1,o2)*Openness + 
c(c1,c1,c2)*Conscientiousness + c(a1,a1,a2)*Agreeableness + c(n1,n1,n2)*Neuroticism

sys ~~ dias
sys ~~ trig
sys ~~ BMI
sys ~~ chol
dias ~~ trig
dias ~~ BMI
dias ~~ chol
trig ~~ BMI
trig ~~ chol
BMI ~~ chol

# within particular samples these variances tend to go negative, so we set them = to 0
sys ~~ c(vSysJ,vSysA,vSysC)*sys
dias ~~ c(vDiasJ,vDiasA,vDiasC)*dias
chol ~~ c(vChJ,vChA,vChC)*chol
trig ~~ c(vTrigJ,vTrigA,vTrigC)*trig
BMI ~~ c(vBMIJ,vBMIA,vBMIC)*BMI

vChC > 0
vTrigC > 0
vTrigA > 0
vSysA > 0
vChJ > 0
vBMIJ > 0
vDiasJ > 0
vDiasA > 0
vDiasC > 0
'

imp.f1 <- lavaan(imp.m1, data = all3, missing="ML", group = 'sample', 
                 ,model.type='sem', std.lv = T, int.ov.free = TRUE, int.lv.free = T, auto.fix.first = T, 
                 auto.fix.single = TRUE, auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
                 auto.cov.y = TRUE
                 
)

imp.m2 <- '
AL =~ c(chLV,chLV,chLV)*chol + c(trLV,trLV,trLV)*trig + c(sLV,sLV,sLV)*sys + s(dLV,dLV,dLV)*dias + c(bLV,bLV,bLV)*BMI

AL ~ sex + age + age2 + c(d1,d2,d2)*Dominance + c(e1,e2,e2)* Extraversion + c(o1,o2,o2)*Openness + 
c(c1,c2,c2)*Conscientiousness + c(a1,a2,a2)*Agreeableness + c(n1,n2,n2)*Neuroticism

sys ~~ dias
sys ~~ trig
sys ~~ BMI
sys ~~ chol
dias ~~ trig
dias ~~ BMI
dias ~~ chol
trig ~~ BMI
trig ~~ chol
BMI ~~ chol

# within particular samples these variances tend to go negative, so we set them = to 0
sys ~~ c(vSysJ,vSysA,vSysC)*sys
dias ~~ c(vDiasJ,vDiasA,vDiasC)*dias
chol ~~ c(vChJ,vChA,vChC)*chol
trig ~~ c(vTrigJ,vTrigA,vTrigC)*trig
BMI ~~ c(vBMIJ,vBMIA,vBMIC)*BMI

vChC > 0
vTrigC > 0
vTrigA > 0
vSysA > 0
vChJ > 0
vBMIJ > 0
vDiasJ > 0
vDiasA > 0
vDiasC > 0
'
imp.f2 <- lavaan(imp.m2, data = all3, missing="ML", group = 'sample', 
                 ,model.type='sem', std.lv = T, int.ov.free = TRUE, int.lv.free = T, auto.fix.first = T, 
                 auto.fix.single = TRUE, auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
                 auto.cov.y = TRUE
                 
)

imp.m4 <- '
AL =~ c(chLV,chLV,chLV)*chol + c(trLV,trLV,trLV)*trig + c(sLV,sLV,sLV)*sys + s(dLV,dLV,dLV)*dias + c(bLV,bLV,bLV)*BMI

AL ~ sex + age + age2 + c(d2,d1,d2)*Dominance + c(e2,e1,e2)* Extraversion + c(o2,o1,o2)*Openness + 
  c(c2,c1,c2)*Conscientiousness + c(a2,a1,a2)*Agreeableness + c(n2,n1,n2)*Neuroticism

sys ~~ dias
sys ~~ trig
sys ~~ BMI
sys ~~ chol
dias ~~ trig
dias ~~ BMI
dias ~~ chol
trig ~~ BMI
trig ~~ chol
BMI ~~ chol

# within particular samples these variances tend to go negative, so we set them = to 0
sys ~~ c(vSysJ,vSysA,vSysC)*sys
dias ~~ c(vDiasJ,vDiasA,vDiasC)*dias
chol ~~ c(vChJ,vChA,vChC)*chol
trig ~~ c(vTrigJ,vTrigA,vTrigC)*trig
BMI ~~ c(vBMIJ,vBMIA,vBMIC)*BMI

vChC > 0
vTrigC > 0
vTrigA > 0
vSysA > 0
vChJ > 0
vBMIJ > 0
vDiasJ > 0
vDiasA > 0
vDiasC > 0
'




imp.f4 <- lavaan(imp.m4, data = all3, missing="ML", model.type='sem', group = 'sample',
               #                group.equal = c("regressions"),
               #                group.partial = c("AL ~ sex","AL ~ age","AL ~ age2"),
               std.lv = T, int.ov.free = TRUE, int.lv.free = T, auto.fix.first = T, 
               auto.fix.single = TRUE, auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
               auto.cov.y = TRUE
)


fitMeasures(imp.f0, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr",'AIC','BIC')) # All as one
fitMeasures(imp.f1, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr",'AIC','BIC')) # species
fitMeasures(imp.f2, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr",'AIC','BIC')) # country
fitMeasures(imp.f3, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr",'AIC','BIC')) # samples
fitMeasures(imp.f4, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr",'AIC','BIC')) # others

summary(imp.f0)

measurementInvariance(imp.f3)


mod_ind <- modificationindices(imp.f0)
head(mod_ind[order(mod_ind$mi, decreasing=TRUE), ], 10)
subset(mod_ind[order(mod_ind$mi, decreasing=TRUE), ], mi > 5)
