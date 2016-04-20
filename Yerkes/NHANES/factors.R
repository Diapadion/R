# depends import.R

library(psych)

### Humans

dim(sel.nbm[complete.cases(sel.nbm),])


fa.parallel(sel.nbm[complete.cases(sel.nbm),c(3:31)], fm = 'gls') #  pa?
# seem like 10

nfactors(sel.nbm[complete.cases(sel.nbm),c(3:31)], fm = 'ml')


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

