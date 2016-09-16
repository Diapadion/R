# depends import.R

library(psych)

### Humans

dim(sel.nbm[complete.cases(sel.nbm),])

colnames(sel.nbm)[3:31] <- colnames(c.bm)[5:33]


fa.parallel(sel.nbm[complete.cases(sel.nbm),c(3:31)], fm = 'gls') #  pa?
# seem like 10

plot(nfactors(sel.nbm[complete.cases(sel.nbm),c(3:31)], fm = 'gls')$map)


EFA.Comp.Data(sel.nbm[complete.cases(sel.nbm),c(3:31)], F.Max = 15, Graph = T)
# okay fine, 10


fa.1 <- fa(sel.nbm[,c(3:31)], nfactors = 10, fm = 'minres'
   )

fa.1a <- fa(sel.nbm[complete.cases(sel.nbm),c(3:31)], nfactors = 10, fm = 'minres'
)

fa.1x <- fa(sel.nbm[complete.cases(sel.nbm),c(3:31)], nfactors = 10, fm = 'ml'
)

pa.1 <- principal(sel.nbm[,c(3:31)], nfactors = 10
)


### Chimps

nfactors(c.bm[,c(5:33)], fm = 'gls') #  pa?

fa.parallel(c.bm[,c(5:33)], fm = 'minres') #  pa?

# chokes on missing data:
# EFA.Comp.Data(
#   aggregate(c.bm[,c(3:32)], by = list(c.bm$chimp), mean)
#   ,F.Max = 15, Graph = T)

fa.c.1 <- fa(c.bm[,c(5:33)], nfactors = 10, fm = 'minres'
)


pa.c.1 <- principal(c.bm[,c(5:33)], nfactors = 10)



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

# components with decent similarity:
# (C)   (H)
# MR3 - MR2
# MR4 - MR9
# MR2 - MR10 (?)
# MR5 - MR3 (?)
# MR6 - MR7
# MR10 - MR6
# MR9 - MR8




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




# based on screes, maybe 6

fa.6 = fa(sel.nbm[complete.cases(sel.nbm),c(3:31)], nfactors = 6, fm = 'gls')

fa.c.6 = fa(c.bm[,c(5:33)], nfactors = 6, fm = 'gls')
       
