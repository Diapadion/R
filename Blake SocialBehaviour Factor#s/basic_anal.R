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

fa.parallel(bsbd[,2:11])






library(nFactors)

nfn = nScree(x=bsbd[complete.cases(bsbd),2:11], model = 'factors')

ncn = nScree(x=bsbd[complete.cases(bsbd),2:11], model = 'components')



# not appropriate for components...
EFA.Comp.Data(Data=bsbd[complete.cases(bsbd),2:11],F.Max=6,
              ,Graph=TRUE)



# Hull method?



