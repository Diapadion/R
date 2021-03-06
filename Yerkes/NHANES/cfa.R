# CFA and measurement invariance


library(lavaan)
library(semTools)
library(semPlot)


# cutoff > |0.4|
# cross-loadings allowed

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
  
semPaths(fit1.comp5, what='est')
fitmeasures(fit1.comp5, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))
summary(fit1.comp5)




mod_ind <- modificationindices(fit1.comp5)

#Spoting the top 10:
head(mod_ind[order(mod_ind$mi, decreasing=TRUE), ], 10)
#And the bigger than 5:
subset(mod_ind[order(mod_ind$mi, decreasing=TRUE), ], mi > 5)



mod.comp10 <- "
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

"

fit1.comp10 <- cfa(mod.comp10, data=sel.nbm[sampl.cfa,c(4:35)], std.ov=T, missing = 'fiml', orthogonal=T)

#fit.h1 <- cfa(mod.1, data=sel.nbm[complete.cases(sel.nbm),])

fitMeasures(fit1.comp10, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))
summary(fit1.comp10)
semPaths(fit1.comp10, what='est')



### Chimps

fit1c.comp10 <- cfa(mod.comp10, data=c.bm.m[,c(4:35)], std.ov=T, 
                    estimator = 'MLMV', # missing = 'direct', 
                    orthogonal=T)
semPaths(fit1c.comp10, what='est')
fitmeasures(fit1c.comp10, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))
summary(fit1c.comp10)

fit1c.comp5 <- cfa(mod.comp5, data=c.bm.m[,c(4:35)], std.ov=T, missing = 'fiml')

semPaths(fit1c.comp5, what='est')
fitmeasures(fit1c.comp5, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))
summary(fit1c.comp5)

# This doesn't really work; too many vars for the data, I think.

# Move along with group comparisons, though.



### Group Comparisons

fit.all.comp5 <- cfa(mod.comp5, data=all.bm[,c(4:35)], std.ov=T, missing = 'fiml')
summary(fit.all.comp5)
fitMeasures(fit.all.comp5, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))

measurementInvariance(mod.comp5, group = "species", data = all.bm, fit.measures=c('cfi','rmsea','srmr'))

fit.config = cfa(mod.comp5, data=all.bm, group="species", group.equal=c("means"))
fit.metric = cfa(mod.comp5, data=all.bm, group="species", group.equal=c("means", "loadings"))
fit.scalar = cfa(mod.comp5, data=all.bm, group="species", group.equal=c("loadings", "thresholds"))
fit.strict = cfa(mod.comp5, data=all.bm, group="species", group.equal=c("loadings", "thresholds", "residuals"))
fit.all = cfa(mod.comp5, data=all.bm, group="species", group.equal=c("loadings", "thresholds", "residuals","means"))

fitMeasures(fit.config, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))
fitMeasures(fit.metric, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))
fitMeasures(fit.scalar, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))
fitMeasures(fit.strict, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))
fitMeasures(fit.all, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))

# This appears not to work, i.e. the model isn't invariant between groups.


# Perhaps if we only focus on the component of interest:
# TODO?

measurementInvariance(mod.comp5, group = "species", 
                      #group.partial = colnames(all.bm)[c(-1,-2,-3,-14,-23,-30,-33,-34,-35,-36,-25)],
                      group.partial= c('rbc','hct','hgb','Albumn'),
                      data = all.bm, fit.measures=c('cfi','rmsea','srmr'))

fit.config = cfa(mod.comp5, data=all.bm, group="species", group.equal=c("means"))
                 #group.partial= c('rbc','hct','hgb','Albumn'))
fit.metric = cfa(mod.comp5, data=all.bm, group="species", group.equal=c("means", "loadings"))
fit.scalar = cfa(mod.comp5, data=all.bm, group="species", group.equal=c("loadings", "thresholds"))
fit.strict = cfa(mod.comp5, data=all.bm, group="species", group.equal=c("loadings", "thresholds", "residuals"))
fit.all = cfa(mod.comp5, data=all.bm, group="species", group.equal=c("loadings", "thresholds", "residuals","means"))

fitMeasures(fit.config, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))
fitMeasures(fit.metric, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))
fitMeasures(fit.scalar, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))
fitMeasures(fit.strict, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))
fitMeasures(fit.all, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))

anova(fit.config, fit.metric)



# ### What if we restrict it down to the AL factor?
# 
# # begin with all variables that have 
# 
# modAL1.comp5 <- '
# AL =~ cholesterol + triglycerides + BPs + BPd + BMI + Glucose + phosphate
# 
# '
# 
# fitAL1.comp5 <- cfa(modAL1.comp5,data=sel.nbm[sampl.cfa,c(4:35)], std.ov=T, missing = 'fiml')
# 
# fitMeasures(fitAL1.comp5, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))
# summary(fitAL1.comp5)
# semPaths(fitAL1.comp5, what='est')
# 
# measurementInvariance(modAL1.comp5, group = "species", 
#                       data = all.bm, fit.measures=c('cfi','rmsea','srmr'), strict=T)
# 
# 
# 
# modAL2.comp5 <- '
# AL =~ cholesterol + triglycerides + BPs + BPd + BMI + Glucose
# 
# '
# 
# fitAL2.comp5 <- cfa(modAL2.comp5,data=sel.nbm[sampl.cfa,c(4:35)], std.ov=T, missing = 'fiml')
# 
# fitMeasures(fitAL2.comp5, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))
# summary(fitAL2.comp5)
# semPaths(fitAL2.comp5, what='est')
# 
# measurementInvariance(modAL2.comp5, group = "species", 
#                       data = all.bm, fit.measures=c('cfi','rmsea','srmr'), strict=T)
# # I guess we should keep phosphates in the model
# 
# 
# 
# modAL3.comp5_old <- '
# AL =~ cholesterol + triglycerides + BPs + BPd + BMI + phosphate
# 
# '
# 
# fitAL3.comp5_old <- cfa(modAL3.comp5_old,data=sel.nbm[sampl.cfa,c(4:35)], std.ov=T, missing = 'fiml')
# 
# fitMeasures(fitAL3.comp5_old, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))
# summary(fitAL3.comp5)
# semPaths(fitAL3.comp5, what='est')
# 
# anova(fitAL1.comp5, fitAL2.comp5, fitAL3.comp5)
# anova(fitAL2.comp5, fitAL3.comp5)
# 
# compareFit(fitAL1.comp5, fitAL2.comp5, fitAL3.comp5)
# 
# 
# 
# # ModAL3 should be sufficiently good fit to test measurement Invariance
# 
# measurementInvariance(modAL3.comp5_old, group = "species", 
#                       #group.partial = colnames(all.bm)[c(-1,-2,-3,-14,-23,-30,-33,-34,-35,-36,-25)],
#                       data = all.bm, fit.measures=c('cfi','rmsea','srmr'), strict=T)
# 
# # Invariance looks good.
# 
# fitAL3.grp <- cfa(modAL3.comp5, data=all.bm, std.ov=T, missing = 'fiml', group = "species",
#                   std.lv=T)
# # fitAl3.grp <- 
# 
# fitMeasures(fitAL3.grp, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))
# summary(fitAL3.grp)
# semPaths(fitAL3.grp, what='est')
# 
# 
# # Group 1 [human]:
# #   
# #   Latent Variables:
# #   Estimate  Std.Err  z-value  P(>|z|)
# # AL =~                                               
# #   cholesterol       1.000                           
# # triglycerides     0.683    0.027   24.871    0.000
# # BPs               1.526    0.039   39.383    0.000
# # BPd               1.525    0.041   37.656    0.000
# # BMI               1.166    0.033   35.709    0.000
# # phosphate        -0.609    0.036  -16.964    0.000
# # 
# # 
# # Group 2 [chimp]:
# #   
# #   Latent Variables:
# #   Estimate  Std.Err  z-value  P(>|z|)
# # AL =~                                               
# #   cholesterol       1.000                           
# # triglycerides     3.010    2.349    1.281    0.200
# # BPs               5.416    4.061    1.334    0.182
# # BPd               6.503    4.621    1.407    0.159
# # BMI               0.125    1.089    0.115    0.908
# # phosphate        -0.974    1.135   -0.858    0.391







###### NEW VERSION

### What if we restrict it down to the AL factor?

# begin with all variables that have 4 or more primary loadings on AL (from PCAs)
# ... which means no glucose

modAL1.comp5 <- '
AL =~ cholesterol + triglycerides + BPs + BPd + BMI + phosphate + alkphos

'

fitAL1.comp5 <- cfa(modAL1.comp5,data=sel.nbm[sampl.cfa,c(4:35)], std.ov=T, missing = 'fiml')

fitMeasures(fitAL1.comp5, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))
semPaths(fitAL1.comp5, what='est')

# Does not converge. Remove vars first.
# measurementInvariance(modAL1.comp5, group = "species", 
#                       data = all.bm, fit.measures=c('cfi','rmsea','srmr'), strict=T)
fitAL1c.comp5 <- cfa(modAL1.comp5,data=c.bm.m[,c(4:35)], std.ov=T, missing = 'fiml')
fitMeasures(fitAL1c.comp5, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))



modAL2.comp5 <- '
AL =~ cholesterol + triglycerides + BPs + BPd + BMI + phosphate

'

fitAL2.comp5 <- cfa(modAL2.comp5,data=sel.nbm[sampl.cfa,c(4:35)], std.ov=T, missing = 'fiml')

fitMeasures(fitAL2.comp5, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))
semPaths(fitAL2.comp5, what='est')

# measurementInvariance(modAL2.comp5, group = "species", 
#                       data = all.bm, fit.measures=c('cfi','rmsea','srmr'), strict=T)

# ALP doesn't look like it adds anything. Drop it.

fitAL2c.comp5 <- cfa(modAL2.comp5,data=c.bm.m[,c(4:35)], std.ov=T, missing = 'fiml')
fitMeasures(fitAL2c.comp5, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))


modAL3.comp5 <- '
AL =~ cholesterol + triglycerides + BPs + BPd + BMI

'

fitAL3.comp5 <- cfa(modAL3.comp5,data=sel.nbm[sampl.cfa,c(4:35)], std.ov=T, missing = 'fiml')

fitMeasures(fitAL3.comp5, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))
semPaths(fitAL3.comp5, what='est')

# Taking phosphates out didn't help. Model 2 is our final model.

fitAL3c.comp5 <- cfa(modAL3.comp5,data=c.bm.m[,c(4:35)], std.ov=T, missing = 'fiml')
fitMeasures(fitAL3c.comp5, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))



# ModAL2 should also be sufficiently good fit to test measurement Invariance

mi.6vars <- measurementInvariance(modAL2.comp5, group = "species", 
                      #group.partial = colnames(all.bm)[c(-1,-2,-3,-14,-23,-30,-33,-34,-35,-36,-25)],
                      data = all.bm, fit.measures=c('cfi','rmsea','srmr'), 
                      std.lv=T,strict=T)

# Invariance doesn't look good.

fitAL2.grp <- cfa(modAL2.comp5, data=all.bm, std.ov=T, missing = 'fiml', group = "species",
                  std.lv=T)
# fitAl3.grp <- 

fitMeasures(fitAL2.grp, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))
summary(fitAL2.grp)
semPaths(fitAL2.grp, what='est')

# (weak)
partialInvariance(mi.6vars, type='metric', p.adjust = 'BH')
partialInvariance(mi.6vars, type='metric', p.adjust = 'BH', free='BPd')
pI.teardown.metric = partialInvariance(mi.6vars, type='metric', p.adjust = 'BH', free=c('BPd','BPs'), return.fit=T)
#partialInvariance(mi.6vars, type='metric', p.adjust = 'holm', free=c('BPd','BPs','phosphate'), return.fit = T)

# partialInvariance(mi.6vars, type='metric', p.adjust = 'holm', fix='cholesterol')
# partialInvariance(mi.6vars, type='metric', p.adjust = 'holm', fix=c('cholesterol','BMI'))
# partialInvariance(mi.6vars, type='metric', p.adjust = 'holm', fix=c('cholesterol','BMI','triglycerides'))

# BPs;d should have loadings freed across groups
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

# mean
partialInvariance(mi.6vars, type='mean', p.adjust = 'holm')
# nothing.



### Let's combine strong and weak 

final.modAL = cfa(modAL2.comp5,data=all.bm, 
                  group = 'species',
                  std.ov=T, missing = 'fiml',std.lv=T,
                  group.equal = c("loadings", "intercepts"),
                  group.partial = c('AL=~BPs','AL=~BPd',
                                    'BPs~1','triglycerides~1','phosphate~1')
                  )

fitMeasures(final.modAL, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))

summary(final.modAL)

# and if we compare to a null model?

final.0.modAL = cfa(modAL2.comp5,data=all.bm, 
                    group='species',
                  std.ov=T, missing = 'fiml',std.lv=T)
fitMeasures(final.0.modAL, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))

final.00.modAL = cfa(modAL2.comp5,data=all.bm, 
                    std.ov=T, missing = 'fiml',std.lv=T)
fitMeasures(final.00.modAL, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))
                  

compfit.final = compareFit(final.modAL, final.0.modAL)
summary(compfit.final)

clipboard(final.modAL, what='summary')





######################################



# partialInvariance(mi.6vars, type='scalar', p.adjust = 'holm', fix='BPd')
# 
# partialInvariance(mi.6vars, type='strict', p.adjust = 'holm')
# partialInvariance(mi.6vars, type='strict', p.adjust = 'holm', fix='cholesterol')
# 
# partialInvariance(mi.6vars, type='means', p.adjust = 'holm')







## After retaining phosphates, the rest of this appears to be unnecessary...


fit.config = cfa(modAL3.comp5, data=all.bm, group="species", group.equal=c("means"))
#group.partial= c('rbc','hct','hgb','Albumn'))
fit.metric = cfa(modAL3.comp5, data=all.bm, group="species", group.equal=c("means", "loadings"))
fit.scalar = cfa(modAL3.comp5, data=all.bm, group="species", group.equal=c("loadings", "thresholds"))
fit.strict = cfa(modAL3.comp5, data=all.bm, group="species", group.equal=c("loadings", "thresholds", "residuals"))
fit.all = cfa(modAL3.comp5, data=all.bm, group="species", group.equal=c("loadings", "thresholds", "residuals","means"))

fitMeasures(fit.config, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))
fitMeasures(fit.metric, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))
fitMeasures(fit.scalar, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))
fitMeasures(fit.strict, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))
fitMeasures(fit.all, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))

# Metric invariance. What do we need to free up to get scalar inv?

fit.metric0 = cfa(modAL3.comp5, data=all.bm, group="species", group.equal=c("loadings"))
 
fit.scalar0 = cfa(modAL3.comp5, data=all.bm, group="species", group.equal=c("loadings", "intercepts"))
                 #group.partial = c('AL=~triglycerides'))
fit.scalar1 = cfa(modAL3.comp5, data=all.bm, group="species", group.equal=c("loadings", "intercepts"),
                  group.partial = c('AL=~BMI'))
compareFit(fit.metric0,fit.scalar0, fit.scalar1)

summary(fit.scalar1)

# Removing BMI makes sense, and it gives us scalar invaraince. It also means that
# the contribution of BMI to AL is inconsistent, as a difference in intercept or loading
# could be causing this difference.

# However, we can now compare the other vars directly.

fitAL3.grp <- cfa(modAL3.comp5, data=all.bm, std.ov=T, missing = 'fiml', group = "species")

fitMeasures(fitAL3.grp, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))
summary(fitAL3.grp)
semPaths(fitAL3.grp, what='est')


# Group 1 [human]:
#   
#   Latent Variables:
#   Estimate  Std.Err  z-value  P(>|z|)
# AL =~                                               
# cholesterol       1.000                           
# triglycerides     0.690    0.027   25.255    0.000
# BPs               1.523    0.039   39.309    0.000
# BPd               1.496    0.040   37.742    0.000
# BMI               1.152    0.032   35.724    0.000
# 
# Group 2 [chimp]:
#   
#   Latent Variables:
#   Estimate  Std.Err  z-value  P(>|z|)
# AL =~                                               
# cholesterol       1.000                           
# triglycerides     2.639    1.852    1.425    0.154
# BPs               4.800    3.200    1.500    0.134
# BPd               5.500    3.355    1.639    0.101
# BMI               0.151    0.975    0.155    0.877







### Old - Do Not Use

fit.scalar2 = cfa(modAL3.comp5, data=all.bm, group="species", group.equal=c("loadings", "intercepts"),
                  group.partial = c('AL=~cholesterol','AL=~BMI'))
compareFit(fit.metric,fit.scalar0, fit.scalar1, fit.scalar2)

measurementInvariance(modAL3.comp5, group = "species", 
                      group.partial = c('AL=~triglycerides'),
                      data = all.bm, fit.measures=c('cfi','rmsea','srmr'), strict=T)

measurementInvariance(modAL3.comp5, group = "species", 
                      group.partial = c('AL=~triglycerides+l',AL=~cholesterol'),
                      data = all.bm, fit.measures=c('cfi','rmsea','srmr'), strict=T)
