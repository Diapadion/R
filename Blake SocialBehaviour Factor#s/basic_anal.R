#library(foreign)
#bsbd = read.spss("PCA_relationship_qualities.sav", to.data.frame=TRUE)

library(memisc)
bsbd <- as.data.frame(as.data.set(spss.system.file('PCA_relationship_qualities.sav')))


write.csv(as.data.frame(bsdb),file='excel.csv')


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


library(nFactors)

nfn = nScree(x=bsbd[complete.cases(bsbd),2:11], model = 'factors')

ncn = nScree(x=bsbd[complete.cases(bsbd),2:11], model = 'components')



# not appropriate for components...
EFA.Comp.Data(Data=bsbd[complete.cases(bsbd),2:11],F.Max=6,
              ,Graph=TRUE)



# Hull method?




##### Actual extractions


sb.f2 = fa(bsbd[,2:11], nfactors = 2, rotate="varimax")
sb.pc2 = principal(bsbd[,2:11], nfactors = 2, rotate="varimax")
# replace current solution in text (???)

sb.f3 = fa(bsbd[,2:11], nfactors = 3, rotate="varimax")
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

