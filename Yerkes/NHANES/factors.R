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


#colnames(sel.nbm)[3:31] <- colnames(c.bm)[5:33]
colnames(sel.nbm)[4:35] <- colnames(c.bm)[5:36]


fa.parallel(sel.nbm[complete.cases(sel.nbm),c(4:35)], fm = 'gls') #  pa?
 # seem like 10

nfactors(sel.nbm[complete.cases(sel.nbm),c(4:35)], fm = 'gls')
plot(nfactors(sel.nbm[complete.cases(sel.nbm),c(4:35)], fm = 'gls')$map)


EFA.Comp.Data(sel.nbm[complete.cases(sel.nbm),c(4:35)], F.Max = 15, Graph = T)
# okay fine, 10
# no wait... 9


fa.1 <- fa(sel.nbm[,c(3:31)], nfactors = 10, fm = 'minres'
   )

fa.1a <- fa(sel.nbm[complete.cases(sel.nbm),c(3:31)], nfactors = 10, fm = 'minres'
)

fa.1x <- fa(sel.nbm[complete.cases(sel.nbm),c(3:31)], nfactors = 10, fm = 'ml'
)

# PCA - a better model for AL




# pa.1 <- principal(sel.nbm[,c(3:31)], nfactors = 10
# )
pa.10 <- principal(sel.nbm[sampl.pca,c(4:35)], nfactors = 10, rotate='varimax'
) # S, B, C, T, G ...
# this one is interesting: D does load at 0.45, but it has a -0.5 higher loading elsewhere
#print(loadings(pa.10), cutoff = 0.3, sort =T)
xpca <- print(loadings(pa.10), cutoff = 0.0, sort =T)
str(xpca)
class(xpca)
xpca = xtable(unclass(xpca))
print.xtable(xpca, type="html", file="pca10.html")


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
xpca <- print(loadings(pa.5), cutoff = 0.0, sort =T)
xpca = xtable(unclass(xpca))
print.xtable(xpca, type="html", file="pca5.html")


pa.4 <- principal(sel.nbm[sampl.pca,c(4:35)], nfactors = 4, rotate='varimax'
) # S, D, B, C; ... 
# 4 is not a very good model - end here.

print(loadings(pa.5), cutoff = 0.3, sort =T)

fa.sort(pa.7)

fa.sort(pa.10)
fa.sort(efa.10)

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







### Chimps

nfactors(c.bm[,c(4:35)], fm = 'ml') #  pa?

#fa.parallel(c.bm[,c(5:36)], fm = 'minres') #  pa?
fa.parallel(c.bm.m[,c(4:35)], fm = 'ml') #  pa?

# chokes on missing data...
EFA.Comp.Data(c.bm.m[complete.cases(c.bm.m),c(4:35)], F.Max = 15, Graph = T)

# DO NOT RUN

fa.c.1 <- fa(c.bm[,c(5:36)], nfactors = 10, fm = 'minres'
)

pa.c.10 <- principal(#c.bm[,c(5:36)],
  c.bm.m[,c(4:35)],
  nfactors = 10)
pa.c.5 <- principal(#c.bm[,c(5:36)],
  c.bm.m[,c(4:35)],
  nfactors = 5)



c.fa.10 <- fa(c.bm.m[,c(4:35)], nfactors = 10, rotate='varimax', fm = 'minres'
      , scores = 'tenBerge', missing = T, impute = 'median'
)


c.fa.5 <- fa(c.bm.m[,c(4:35)], nfactors = 5, rotate='varimax', fm = 'minres',
            scores = 'tenBerge', missing = T, impute = 'median'
)
fa.sort(c.fa.10)



### Factor/Component structure comparisons

# Congruence

factor.congruence(fa.c.1$loadings, fa.1$loadings)
       MR1   MR2   MR3   MR9   MR4   MR7   MR5  MR10   MR6   MR8
MR1   0.79  0.06 -0.05  0.05  0.22 -0.19  0.27 -0.02  0.10 -0.07
MR3   0.09  0.88 -0.22 -0.08 -0.03  0.11  0.06 -0.07  0.23 -0.08
MR4  -0.11  0.01 -0.12  0.57  0.07 -0.26  0.00 -0.03 -0.01  0.05
MR2   0.16  0.05  0.02  0.04 -0.11  0.15  0.55  0.61  0.07  0.09
MR5   0.03 -0.05 -0.56  0.18  0.42 -0.03 -0.17  0.21  0.17 -0.19
MR6  -0.01  0.04  0.13  0.28  0.20  0.76  0.05  0.06 -0.11 -0.09
MR10 -0.01  0.03  0.20 -0.24  0.47 -0.17 -0.22  0.21  0.63  0.05
MR8   0.03  0.06  0.16  0.15 -0.14  0.17  0.19 -0.04  0.08  0.20
MR7  -0.01 -0.07  0.30  0.13  0.08  0.05 -0.08 -0.09  0.10  0.00
MR9   0.02  0.08 -0.08  0.23  0.02 -0.01 -0.23  0.10  0.03  0.65

# factors with decent similarity:
# (C)   (H)
# MR3 - MR2
# MR4 - MR9
# MR2 - MR10 (?)
# MR5 - MR3 (?)
# MR6 - MR7
# MR10 - MR6
# MR9 - MR8



factor.congruence(pa.c.1$loadings, pa.1$loadings)
       PC1   PC2   PC5   PC4   PC9  PC10   PC3   PC6   PC7   PC8
PC1   0.81  0.16  0.13  0.03 -0.14  0.28 -0.06 -0.16 -0.11  0.01
PC3   0.13  0.89  0.06 -0.06  0.09  0.03  0.18 -0.24 -0.17  0.07
PC2   0.22  0.10  0.85 -0.02  0.20  0.06  0.18 -0.02  0.04  0.02
PC4  -0.07 -0.06 -0.06  0.68 -0.17  0.04 -0.17 -0.10 -0.17 -0.04
PC5  -0.09 -0.18  0.09 -0.16  0.03 -0.21  0.27  0.59 -0.46 -0.02
PC6   0.01 -0.03  0.10  0.25  0.88  0.12  0.15  0.10 -0.10  0.05
PC10 -0.04  0.23 -0.02 -0.16 -0.18  0.46 -0.47  0.08  0.25 -0.10
PC8   0.06  0.04  0.23  0.05  0.16 -0.16  0.35  0.18 -0.07  0.16
PC7  -0.04 -0.03 -0.09  0.08 -0.04  0.17  0.18  0.21  0.56  0.23
PC9  -0.14 -0.06 -0.01  0.23 -0.09  0.34  0.05 -0.04 -0.02  0.66

# components with decent similarity:
# (C)   (H)
PC1 - PC1
PC3 - PC2
PC2 - PC5
PC4 ~ PC4
PC5 ~ PC6
PC6 ~ PC9
PC7 ~ PC7?
PC9 ~ PC8
PC8 ~ ?
PC10 ~ ?



# Procrustes, using code from the group

procrustes(fa.c.1$loadings, fa.1$loadings)

procrustes(fa.c.1$loadings, fa.1$loadings[,c(1:5,10,9,7,8,6)])


0.793876724  8.809095e-01  0.71974158  0.747031357  0.59239310  0.82627457
0.600784478  0.627731145  0.56643907  0.684564831  
0.7193371


pcrust = procrustes(fa.1$loadings, fa.c.1$loadings)

pcrust = protest(fa.1$loadings, fa.c.1$loadings)
pspc = permustats(pcrust)



pcrusta = procrustes(pa.1$loadings, pa.c.1$loadings)
0.841861752  0.892964096  0.864579231  0.756832481  0.803025736  0.891505227  0.7185726578
0.311983995  0.629106243  0.816920692  0.7742925




pcrust = procrustes(pa.5$loadings, pa.c.5$loadings)
pspc = permustats(pcrust)
       
factor.congruence(pa.5$loadings, pa.c.5$loadings) # human - rows; chimps - columns
# Human RC3
# Chimp RC4
