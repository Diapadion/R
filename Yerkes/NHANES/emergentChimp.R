library(psych)
library(qgraph)
library(ega)

source(file='EGA/R/EGA.R')
source(file='EGA/R/bootEGA.R')
source(file='EGA/R/CFA.R')




### Chimp only emergent components

pa.c.10 <- principal(c.bm.m[,c(4:35)],nfactors = 10)
pa.c.9 <- principal(c.bm.m[,c(4:35)],nfactors = 9)
pa.c.8 <- principal(c.bm.m[,c(4:35)],nfactors = 8)
pa.c.7 <- principal(c.bm.m[,c(4:35)],nfactors = 7)
pa.c.6 <- principal(c.bm.m[,c(4:35)],nfactors = 6)
pa.c.5 <- principal(c.bm.m[,c(4:35)],nfactors = 5)
pa.c.4 <- principal(c.bm.m[,c(4:35)],nfactors = 4)

print(loadings(pa.c.6), cutoff = 0.3, sort =T)




### EGA

EGA(c.bm.m[,c(4:35)])

bs.c.bm.EGA = bootEGA(c.bm.m[,c(4:35)], ncores = 2, n = 20)


# for comparison
EGA(sel.nbm[sampl.pca,c(4:35)])



### Sacha's way

qgraph(pa.c.7)

qgraph(EBICglasso(cor_auto(sel.nbm[sampl.pca,c(4:35)]), 1000))
  
#cor_auto(c.bm.m[,c(4:35)], 200) #???



