library(foreign)
bsbd = read.spss("PCA_relationship_qualities.sav", to.data.frame=TRUE)

library(memisc)
bsbd <- as.data.frame(as.data.set(spss.system.file('PCA_relationship_qualities.sav')))


write.csv(as.data.frame(bsdb),file='excel.csv')


library(psych)

VSS.scree(bsbd[,2:11])
nfactors(bsbd[,2:11])
         #,nrotate="varimax")

bvss = VSS(bsbd[,2:11])
plot(bvss$map)

fa.parallel(bsbd[,2:11],sim=F)


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

