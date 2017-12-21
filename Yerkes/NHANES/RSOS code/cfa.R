# CFA and measurement invariance


library(lavaan)
library(semTools)
library(semPlot)



mod.comp5 <- '
PC1 =~ BPs + BPd + BMI + cholesterol + triglycerides + Glucose + phosphate
PC2 =~ rbc + hct + hgb + Albumn + calcium + Protein 
PC3 =~ mch + mcv + mchc + globulin + hgb
PC4 =~ sgot + sgpt + ggtp
PC5 =~ osmolal + sodium + BUN + Creatine + potassium

PC1 ~~ 0*PC2
PC1 ~~ 0*PC3
PC1 ~~ 0*PC4
PC1 ~~ 0*PC5

PC2 ~~ 0*PC3
PC2 ~~ 0*PC4
PC2 ~~ 0*PC5

PC3 ~~ 0*PC4
PC3 ~~ 0*PC5

PC4 ~~ 0*PC5

'


fit1.comp5 <- cfa(mod.comp5, data=sel.nbm[sampl.cfa,c(4:35)], std.ov=T, missing = 'fiml')
  
fitmeasures(fit1.comp5, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))



mod.comp10 <- '
PC1 =~ rbc + hct + hgb 
PC2 =~ mcv + mch + mchc
PC3 =~ cholesterol + triglycerides + BPs + BMI + Glucose # + BPd
PC4 =~ sgot + sgpt + ggtp
PC5 =~ BUN + Creatine + potassium + osmolal
PC6 =~ Albumn + calcium + lymph
PC7 =~ sodium + chloride + osmolal
PC8 =~ alkphos + phosphate + BPd # See above. Salient loadings for both, so...
PC9 =~ globulin + Protein
PC10 =~ wbc + monos + eos

'

fit1.comp10 <- cfa(mod.comp10, data=sel.nbm[sampl.cfa,c(4:35)], std.ov=T, missing = 'fiml', orthogonal=T)

fitMeasures(fit1.comp10, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))



### Chimps

fit1c.comp10 <- cfa(mod.comp10, data=c.bm.m[,c(4:35)], std.ov=T, 
                    estimator = 'ML', # missing = 'direct', 
                    orthogonal=T)
fitmeasures(fit1c.comp10, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))


fit1c.comp5 <- cfa(mod.comp5, data=c.bm.m[,c(4:35)], std.ov=T, missing = 'fiml')

fitmeasures(fit1c.comp5, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))



### Restricting down to the AL factor

# begin with all variables that have 4 or more primary loadings on AL (from PCAs)
# ... which means no glucose

modAL1.comp5 <- '
AL =~ cholesterol + triglycerides + BPs + BPd + BMI + phosphate + alkphos

'

fitAL1.comp5 <- cfa(modAL1.comp5,data=sel.nbm[sampl.cfa,c(4:35)], std.ov=T, missing = 'fiml')
fitMeasures(fitAL1.comp5, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))

fitAL1c.comp5 <- cfa(modAL1.comp5,data=c.bm.m[,c(4:35)], std.ov=T, missing = 'fiml')
fitMeasures(fitAL1c.comp5, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))



modAL2.comp5 <- '
AL =~ cholesterol + triglycerides + BPs + BPd + BMI + phosphate

'

fitAL2.comp5 <- cfa(modAL2.comp5,data=sel.nbm[sampl.cfa,c(4:35)], std.ov=T, missing = 'fiml')
fitMeasures(fitAL2.comp5, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))

# ALP doesn't look like it adds anything. Drop it.

fitAL2c.comp5 <- cfa(modAL2.comp5,data=c.bm.m[,c(4:35)], std.ov=T, missing = 'fiml')
fitMeasures(fitAL2c.comp5, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))



modAL3.comp5 <- '
AL =~ cholesterol + triglycerides + BPs + BPd + BMI

'

fitAL3.comp5 <- cfa(modAL3.comp5,data=sel.nbm[sampl.cfa,c(4:35)], std.ov=T, missing = 'fiml')
fitMeasures(fitAL3.comp5, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))

# Taking phosphates out didn't help. Model 2 is our final model.

fitAL3c.comp5 <- cfa(modAL3.comp5,data=c.bm.m[,c(4:35)], std.ov=T, missing = 'fiml')
fitMeasures(fitAL3c.comp5, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))



### ModAL2 should also be sufficiently good fit to test Measurement Invariance

mi.6vars <- measurementInvariance(modAL2.comp5, group = "species", 
                      data = all.bm, fit.measures=c('cfi','rmsea','srmr'), 
                      std.lv=T,strict=T)
# Invariance doesn't look good.

fitAL2.grp <- cfa(modAL2.comp5, data=all.bm, std.ov=T, missing = 'fiml', group = "species",
                  std.lv=T)

fitMeasures(fitAL2.grp, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))



### Attempt partial invariance testing

# (weak)
partialInvariance(mi.6vars, type='metric', p.adjust = 'BH')
partialInvariance(mi.6vars, type='metric', p.adjust = 'BH', free='BPd')
partialInvariance(mi.6vars, type='metric', p.adjust = 'holm', free=c('BPd','BPs','phosphate'), return.fit = T)
pI.teardown.metric = partialInvariance(mi.6vars, type='metric', p.adjust = 'BH', free=c('BPd','BPs'), return.fit=T)

# BPs;BPd should have loadings freed across groups
summary(pI.teardown.metric$models$nested)
fitMeasures(pI.teardown.metric$models$nested, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))


# (strong)
partialInvariance(mi.6vars, type='scalar', p.adjust = 'BH')
partialInvariance(mi.6vars, type='scalar', p.adjust = 'BH', free='BPs')
partialInvariance(mi.6vars, type='scalar', p.adjust = 'BH', free=c('BPs','phosphate'))
pI.teardown.scalar = partialInvariance(mi.6vars, type='scalar', p.adjust = 'BH', free=c('BPs','triglycerides','phosphate'), return.fit=T)

summary(pI.teardown.scalar$models$nested)
fitMeasures(pI.teardown.metric$models$nested, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))
# BPs, phosphates, trigs should have intercepts freed across groups


# (strict)
partialInvariance(mi.6vars, type='strict', p.adjust = 'holm')
partialInvariance(mi.6vars, type='strict', p.adjust = 'holm', free=c('phosphate'))
partialInvariance(mi.6vars, type='strict', p.adjust = 'holm', free=c('phosphate','triglycerides'))
partialInvariance(mi.6vars, type='strict', p.adjust = 'holm', free=c('phosphate','triglycerides','BPs'))
partialInvariance(mi.6vars, type='strict', p.adjust = 'holm', free=c('phosphate','triglycerides','BPs','BPd'))
partialInvariance(mi.6vars, type='strict', p.adjust = 'holm', free=c('phosphate','triglycerides','BPs','BPd','BMI'))
# can't establish any partial invariance for fixed residuals



### Combine strong and weak 

final.modAL = cfa(modAL2.comp5,data=all.bm, 
                  group = 'species',
                  std.ov=T, missing = 'fiml',std.lv=T,
                  group.equal = c("loadings", "intercepts"),
                  group.partial = c('AL=~BPs','AL=~BPd',
                                    'BPs~1','triglycerides~1','phosphate~1')
                  )

fitMeasures(final.modAL, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))

#summary(final.modAL)


# and if we compare to a null model?

final.0.modAL = cfa(modAL2.comp5,data=all.bm, 
                    group='species',
                  std.ov=T, missing = 'fiml',std.lv=T)
fitMeasures(final.0.modAL, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))



compfit.final = compareFit(final.modAL, final.0.modAL)
summary(compfit.final)

#clipboard(final.modAL, what='summary')



