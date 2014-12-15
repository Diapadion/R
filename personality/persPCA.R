topca <- NULL
topca = (pers[,12,]) 
ttopca = t(topca)

fullset = apply(pers,c(1,3),mean)

pca1 <- prcomp(pers)
pca2 <- prcomp(ttopca, scale. = TRUE, tol=0.1) # "correct" positions, I think
pca3 <- prcomp(topca, ,scale. = TRUE, tol=0.1)
#pca1 <- princomp(topca, cor="TRUE")
#pca2 <- princomp(ttopca,cor="TRUE")

pcafull <- prcomp(fullset, scale. = TRUE, tol=0.3) # "correct" positions, I think



#rotate?
#r1 <- principal(ttopca, nfactors=6, rotate="varimax")
#r2 <- principal(ttopca, nfactors=6, rotate="promax")


#parall <- paran(ttopca)
#paral1 <- paran(topca)


spca=apply(pcafull$rotation, 2, sort)
#spca = sort(pcafull$rotation)

#cluster analysis
r.mat<- pcafull$rotation
ic.demo <- ICLUST(r.mat)
ICLUST.graph(ic.demo,out.file = ic.demo.dot)



#ongoing notes on putting this all together
# 
# 



