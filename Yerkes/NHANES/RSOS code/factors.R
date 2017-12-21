# depends import.R

library(psych)
library(xtable)


### Summarizing data
describe(c.bm.m)
describe(sel.nbm)



### Checking data

#KMO(sel.nbm[complete.cases(sel.nbm),4:35])
# Overall MSA =  0.55
# MSA for each item = 
#   wbc           rbc           hct           hgb           mcv           mch          mchc 
# 0.62          0.65          0.56          0.64          0.47          0.55          0.52 
# lymph         monos           eos       Glucose           BUN      Creatine       Protein 
# 0.65          0.65          0.70          0.44          0.54          0.69          0.33 
# Albumn      Bilirubn       alkphos          sgpt          sgot   cholesterol       calcium 
# 0.39          0.79          0.60          0.64          0.62          0.73          0.84 
# phosphate        sodium     potassium      chloride      globulin triglycerides          ggtp 
# 0.69          0.38          0.75          0.59          0.34          0.76          0.82 
# osmolal           BMI           BPs           BPd 
# 0.45          0.84          0.70          0.71 
cortest.bartlett(sel.nbm[complete.cases(sel.nbm),4:35])
# $chisq
# [1] 147700.3
# 
# $p.value
# [1] 0
# 
# $df
# [1] 496

#KMO(c.bm.m[complete.cases(c.bm.m),c(4:35)])
# Overall MSA =  0.41
# MSA for each item = 
#   wbc           rbc           hct           hgb           mcv           mch          mchc 
# 0.23          0.52          0.53          0.80          0.43          0.39          0.16 
# lymph         monos           eos       Glucose           BUN      Creatine       Protein 
# 0.39          0.35          0.44          0.17          0.29          0.52          0.44 
# Albumn      Bilirubn       alkphos          sgpt          sgot   cholesterol       calcium 
# 0.28          0.45          0.79          0.31          0.26          0.32          0.34 
# phosphate        sodium     potassium      chloride      globulin triglycerides          ggtp 
# 0.69          0.32          0.30          0.34          0.47          0.54          0.32 
# osmolal           BMI           BPs           BPd 
# 0.33          0.46          0.44          0.56 
cortest.bartlett(c.bm.m[complete.cases(c.bm.m),c(4:35)])
# $chisq
# [1] 1740.464
# 
# $p.value
# [1] 9.475263e-138
# 
# $df
# [1] 496



### Humans

dim(sel.nbm[complete.cases(sel.nbm),])

colnames(sel.nbm)[4:35] <- colnames(c.bm)[5:36]

fa.parallel(sel.nbm[complete.cases(sel.nbm),c(4:35)], fm = 'gls')
nfactors(sel.nbm[complete.cases(sel.nbm),c(4:35)], fm = 'gls')
EFA.Comp.Data(sel.nbm[complete.cases(sel.nbm),c(4:35)], F.Max = 15, Graph = T)



pa.10 <- principal(sel.nbm[sampl.pca,c(4:35)], nfactors = 10, rotate='varimax'
) # S, B, C, T, G ...

# xpca <- print(loadings(pa.10), cutoff = 0.0, sort =T)
# str(xpca)
# class(xpca)
# xpca = xtable(unclass(xpca))
# print.xtable(xpca, type="html", file="pca10.html")

pa.9 <- principal(sel.nbm[sampl.pca,c(4:35)], nfactors = 9, rotate='varimax'
) # S, B, C; Albu?, lymph?

pa.8 <- principal(sel.nbm[sampl.pca,c(4:35)], nfactors = 8, rotate='varimax'
) # S, D, B, C; Phos, ALP, Eos?

pa.7 <- principal(sel.nbm[sampl.pca,c(4:35)], nfactors = 7, rotate='varimax'
) # S, D, B, C; Phos, ALP, Eos?

pa.6 <- principal(sel.nbm[sampl.pca,c(4:35)], nfactors = 6, rotate='varimax'
) # S, D, B, C, T; ALP, Phos, Eos?

pa.5 <- principal(sel.nbm[sampl.pca,c(4:35)], nfactors = 5, rotate='varimax',
                  scores = T, missing = T#, impute = 'median'
) # S, D, B, G, C, T; ALP, Phos, Lymph, WBC?, Eos?
# xpca <- print(loadings(pa.5), cutoff = 0.0, sort =T)
# xpca = xtable(unclass(xpca))
# print.xtable(xpca, type="html", file="pca5.html")

# Note that Creatinine never loads with the main metabolic factor,
# but essentially always does with BUN, and sometimes with Glucose, osmolal, potassium, protein, etc.



### We want to do factor stuff, so do the component and factor structures look similar enough?

efa.10 <- fa(sel.nbm[sampl.pca,c(4:35)], nfactors = 10, rotate='varimax', fm = 'minres'
            , scores = 'tenBerge', missing = T, impute = 'median'
)


efa.5 <- fa(sel.nbm[sampl.pca,c(4:35)], nfactors = 5, rotate='varimax', fm = 'minres',
            scores = 'tenBerge', missing = T, impute = 'median'
)

fa.sort(efa.5)
fa.sort(pa.5)

# They look identical. We can move ahead.


