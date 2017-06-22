### Mortality

library(SAScii)



### Humans

nh.mort = read.SAScii(fn = 'Z:/NHANES III/mortality/NHANES_III_MORT_2011_PUBLIC.dat',
                      sas_ri='Z:/NHANES III/mortality/SAS-Read-in-Program-All-Surveys.sas')

h.mort = merge(sel.nbm[sampl.cfa,], nh.mort, by.x = 'subject', by.y = 'SEQN')

h.mort$AL = lavPredict(final.modAL)[[1]]

h.mort = h.mort[!is.na(h.mort$AL),]
h.mort = h.mort[h.mort$ELIGSTAT == 1,]

# months from exam



### Chimps









### Getting individual AL values

lavPredict(final.modAL)[2]






### Independent survival analyses
