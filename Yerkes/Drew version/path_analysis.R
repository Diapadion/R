# start with a factor analysis
# using 'aggador'
library(psych)

#some sex bs that needs fixing
aggador$Group.1[is.nan(aggador[,52])]
which(is.nan(aggador[,52]) %in% 'TRUE')
aggador$sex[c(15,156,157)]=0
aggador$sex[c(90,107,132,134)]=1

#head(aggador[,-1:-3])

faggad <- sapply(aggador[c(-1,-2,-3             # subject name, DoB, etc
                           ,-39:-44             # physical characteristics stuff
                           ,-45,-46,-47         # add. height measures & BP
                           ,-48                 # weight
                           ,-49:-51             # group size, MomAge, etc
                           ,-53:-95
                           )],as.numeric)



faggad[is.nan(faggad)] = NA

scree(na.omit(faggad))
paran(na.omit(faggad))
vss(na.omit(faggad))


#princomp(faggad, na.action = 'na.omit')
princomp(na.omit(faggad),scores=TRUE)

fa(na.omit(faggad),nfactors = 7,rotate='oblimin')
fa(na.omit(faggad),nfactors = 5,rotate='oblimin')

principal(na.omit(faggad),nfactors = 7,rotate='varimax') #check out RC4
  

#############################3

scree(na.omit(scoutputd))
