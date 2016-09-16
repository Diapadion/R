#library(foreign)
#bsbd = read.spss("PCA_relationship_qualities.sav", to.data.frame=TRUE)

library(memisc)
bsbd <- as.data.frame(as.data.set(spss.system.file('PCA_relationship_qualities.sav')))


#write.csv(as.data.frame(bsdb),file='excel.csv')


library(psych)

VSS.scree(bsbd[,2:11])
nfactors(bsbd[,2:11])
         #,nrotate="varimax")

bvss = VSS(bsbd[,2:11])
plot(bvss$map)

fa.parallel(bsbd[,2:11],sim=F, error.bars = T, se.bars = F)


### construct validity

w.2 = omega(bsbd[,2:11],2,fm='pc')
w.3 = omega(bsbd[,2:11],3,fm='pc')


# library(nFactors)
# 
# nfn = nScree(x=bsbd[complete.cases(bsbd),2:11], model = 'factors')
# 
# ncn = nScree(x=bsbd[complete.cases(bsbd),2:11], model = 'components')



# not appropriate for components...
# EFA.Comp.Data(Data=bsbd[complete.cases(bsbd),2:11],F.Max=6,
#               ,Graph=TRUE)



# Hull method?




##### Actual extractions


#sb.f2 = fa(bsbd[,2:11], nfactors = 2, rotate="varimax", n.iter=1000, fm='ml')
sb.pc2 = principal(bsbd[,2:11], nfactors = 2, rotate="varimax") 
# replace current solution in text (???)

#sb.f3 = fa(bsbd[,2:11], nfactors = 3, rotate="varimax", n.iter=1000)
sb.pc3 = principal(bsbd[,2:11], nfactors = 3, rotate="varimax")

sb.f4 = fa(bsbd[,2:11], nfactors = 4, rotate="varimax")
sb.pc4 = principal(bsbd[,2:11], nfactors = 4, rotate="varimax")

### how good oblique?

sb.f2.ob = fa(bsbd[,2:11], nfactors = 2, rotate="oblimin")
#sb.pc2 = principal(bsbd[,2:11], nfactors = 2, rotate="varimax")
# replace current solution in text (???)

sb.f3.ob = fa(bsbd[,2:11], nfactors = 3, rotate="oblimin")
#sb.pc3 = principal(bsbd[,2:11], nfactors = 3, rotate="varimax")

sb.f3.ob$chi
sb.f2.ob$chi
sb.f2$chi

####### Revisions
KMO(bsbd[,2:11])
cortest.bartlett(bsbd[,2:11])

cor(bsbd[,2:11], use = 'na.or.complete')


# Tucker congruence
factor.congruence(sb.pc2$loadings,sb.pc3$loadings)



# Bootstrapped PCA

boot.3 <- PCAboot(bsbd[,-1], nf = 3, permutations=10) #,rot="varimax")
boot.2 <- PCAboot(bsbd[,-1], nf = 2, rot="varimax")


# x = bsbd[,-1]
# nf = 2
# rot = 'varimax'

PCAboot <- function (x, permutations=1000, nf){
  pcnull <- pca(x, nfactors=nf, rotate='varimax')
  res <- pcnull$loadings[,1]
  # bsresults = matrix( rep.int(NA, permutations*NROW(res)) ,
  #                     nrow=permutations, ncol=NROW(res) )
  N <- ncol(x)
  bsresults <- array(NA,dim=c(permutations,N,nf))
  for (i in 1:permutations) {
    pc <- pca(x[sample(N, replace=TRUE), ], nfactors=nf) #, rotate=rot )
    pred <- predict(pc, data = x)
    r <-  cor(pcnull$scores, pred,use="pairwise.complete.obs")
    k <- apply(abs(r), 2, which.max)
    reve <- sign(diag(r[k,]))
    sol <- pc$loadings[,k]
    #sol <- sweep(sol, 2, reve, "*")
    bsresults[i,,] <- sol
  }
  #print(apply( bsresults, 2, quantile, c(0.05, 0.95) ))
  return(bsresults)
} 


library(boot)

# this version seems to work the best
key2 <- matrix(c(1,1,1,1,1,1,1,1,0,0,
                0,0,0,0,0,0,0,0,1,1),ncol=2)
key3 <- matrix(c(1,1,1,0,0,0,0,0,0,0,
                 0,0,0,1,1,1,1,1,0,0,
                 0,0,0,0,0,0,0,0,1,1),ncol=3)
  
perms = 100
nf = 3

efa <- function(data, indices, key) {
  dd <- data[indices,]
  bsresults <- array(NA,dim=c(perms,ncol(data),nf))
  fitefa <- pca(r=dd, nfactors=3, rotate = "varimax") #, keys = key2)
  #fitefa <- target.rot(pca(r=dd, nfactors=nf) , keys = key3)
  return(c(fitefa$loadings))
  #bsresults[i,,] <- fitefa
  
}
epcaresults <- boot(data=bsbd[,-1], statistic=efa, R=perms)


# getPrcStat <- function (bsbd,vname,pcnum,nf){
#   prcs <- pca(bsbd[,-1],nf) # returns matrix
#   return(prcs$loadings)   # pick out the thing we need
# }
# 
# bootEst <- function(df,d){
#   sampledDf <- df[ d, ]  # resample dataframe 
#   return(getPrcStat(sampledDf,nf=3))
# }
# 
# bootOut <- boot(bsbd,bootEst,R=100)
# boot.ci(bootOut,type=c("basic"))


# pcaLoad <- function(x, ...){
#   z <- pca(x, ...)
#   return(pca$loadings)
#   
# }
# 
# b.obj.2 <- boot(bsbd[,-1],pcaLoad, R=999, nfactor=2)



### SEM???
library(lavaan)
library(semPlot)

mod2 <-'
  # measurement model
pc1 =~ spatialproximity + grooming + groom_symmetry + 
avoidstaysymmetry + foodshare + food_share_symmetry + coalitions + socialforaging
pc2 =~ conflict + conflict_symmetry

# regressions
pc1 ~~ 0*pc2
'

mod3.ob <-'
  # measurement model
pc1 =~ spatialproximity + grooming + groom_symmetry
pc3 =~ avoidstaysymmetry + foodshare + food_share_symmetry + coalitions + socialforaging
pc2 =~ conflict + conflict_symmetry

# regressions
pc1 ~~ 0*pc2
pc3 ~~ 0*pc2
'

mod3 <-'
  # measurement model
pc1 =~ spatialproximity + grooming + groom_symmetry
pc3 =~ avoidstaysymmetry + foodshare + food_share_symmetry + coalitions + socialforaging
pc2 =~ conflict + conflict_symmetry

# regressions
pc1 ~~ 0*pc2
pc1 ~~ 0*pc3
pc3 ~~ 0*pc2
'

mod2.ml <-'
  # measurement model
pc1 =~ spatialproximity + grooming + groom_symmetry
pc3 =~ avoidstaysymmetry + foodshare + food_share_symmetry + coalitions + socialforaging
pc2 =~ conflict + conflict_symmetry
pcHi =~ pc1 + pc3

# regressions
# pc1 ~~ 0*pc2
# pc1 ~~ 0*pc3
# pc3 ~~ 0*pc2
pcHi ~~ 0*pc2

pc1 ~~ 1*pc1
pc2 ~~ 1*pc2
pc3 ~~ 1*pc3
pcHi ~~ 1*pcHi
'

mod2.bi <- '
# measurement model
pc1 =~ spatialproximity + grooming + groom_symmetry
pc3 =~ avoidstaysymmetry + foodshare + food_share_symmetry + coalitions + socialforaging
pc2 =~ conflict + conflict_symmetry
pcBi =~ spatialproximity + grooming + groom_symmetry + 
avoidstaysymmetry + foodshare + food_share_symmetry + coalitions + socialforaging

# regressions
pc1 ~~ 0*pc2
pc1 ~~ 0*pc3
pc3 ~~ 0*pc2
pcBi ~~ 0*pc2
pcBi ~~ 0*pc3
pcBi ~~ 0*pc1

pc1 ~~ 1*pc1
pc2 ~~ 1*pc2
pc3 ~~ 1*pc3
pcBi ~~ 1*pcBi
'

mod3.pseudo.bi <- '
# measurement model
pc3 =~ avoidstaysymmetry + foodshare + food_share_symmetry + coalitions + socialforaging
pc2 =~ conflict + conflict_symmetry
pcBi =~ spatialproximity + grooming + groom_symmetry + pc3


# regressions
pc3 ~~ 0*pc2
pcBi ~~ 0*pc2
pcBi ~~ 0*pc3


pc2 ~~ 1*pc2
pc3 ~~ 1*pc3
pcBi ~~ 1*pcBi
'

bsbd[,2:11] = scale(bsbd[,2:11])


fit2 <- sem(mod2, data=bsbd)
fit3 <- sem(mod3, data=bsbd)
fit3.ob <- sem(mod3.ob, data=bsbd)
fit2.ml <- sem(mod2.ml, data=bsbd, missing='fiml')
fit2.bi <- sem(mod2.bi, data=bsbd, missing='fiml')
fit3.p.bi<- sem(mod3.pseudo.bi, data=bsbd, missing='fiml') # this model is unusual - it is unclear to me if it is okay to do something like this

semPaths(fit2, what='std')
semPaths(fit3, what='std')
semPaths(fit3.ob, what='std')
semPaths(fit2.ml, what='std')
semPaths(fit3.p.bi, what='std')

summary(fit2.ml, fit.measures=T)

fitMeasures(fit2, c("chisq", "df", "pvalue", "cfi", "rmsea"))
fitMeasures(fit3, c("chisq", "df", "pvalue", "cfi", "rmsea"))
fitMeasures(fit2.bi,  c("chisq", "df", "pvalue", "cfi", "rmsea"))
fitMeasures(fit3.ob, c("chisq", "df", "pvalue", "cfi", "rmsea"))
fitMeasures(fit2.ml, c("chisq", "df", "pvalue", "cfi", "rmsea"))
fitMeasures(fit3.p.bi, c("chisq", "df", "pvalue", "cfi", "rmsea"))

