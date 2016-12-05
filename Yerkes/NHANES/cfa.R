# CFA and measurement invariance


library(lavaan)
library(semTools)


mod.1 <- "
PC1 =~ rbc + hct + hgb 
PC2 =~ mcv + mch + mchc
PC3 =~ cholesterol + triglycerides + BPs + BPd + BMI + Glucose
PC4 =~ sgot + sgpt + ggtp + Bilirubn
PC5 =~ BUN + Creatine + potassium
PC6 =~ Albumn + calcium + lymph
#PC7 =~ sodium + chloride + osmolal
PC8 =~ alkphos + phosphate
#PC9 =~ globulin + Protein
#PC10 =~ wbc + monos + eos
"


fit.1 <- cfa(mod.1, data=all.bm, group = "species")
fit.h1 <- cfa(mod.1, data=sel.nbm[complete.cases(sel.nbm),])

fitmeasures(fit.1)
summary(fit.1)

measurementInvariance(mod.1, group = "species", data = all.bm, fit.measures=c('cfi','rmsea','srmr'))

fit.config = cfa(mod.1, data=all.bm, group="species", group.equal=c("means"))
fit.metric = cfa(mod.1, data=all.bm, group="species", group.equal=c("means", "loadings"))
fit.scalar = cfa(mod.1, data=all.bm, group="species", group.equal=c("loadings", "thresholds"))
fit.strict = cfa(mod.1, data=all.bm, group="species", group.equal=c("loadings", "thresholds", "residuals"))
fit.all = cfa(mod.1, data=all.bm, group="species", group.equal=c("loadings", "thresholds", "residuals","means"))

fitMeasures(fit.config, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))
fitMeasures(fit.metric, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))
fitMeasures(fit.scalar, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))
fitMeasures(fit.strict, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))
fitMeasures(fit.all, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))
