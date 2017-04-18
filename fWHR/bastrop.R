### Bastrop


bCh = cPoints[cPoints$location=='Bastrop',]
bCh = bCh[c(-1,-2),]

#bCh = bCh[bCh$A!='X',]
bCh = bCh[bCh$Notes!='redo',]

bChsub = bCh[c(78:93),]


sample(bCh$ID,16)
# [1] Beta    Punch   Lexus   Austin  Dahpi   Minna   Michon  Xena    Alpha   Gremlin Bo     
# [12] Samson  Kampani Mahsho  Cheopi  Maishpa
sample(1:10,16, replace=T)
# [1]  2 10  8  4  2  4  4  2  5  9  4  6 10  7  5  5

### Redos -
# definite: c(16, 24, 56, 60)
# possible: c(27, 28, 32, 44, 72, 74)
bCh$ID[c(16, 24, 56, 60)]



### Testing correlations between morphs and composite images

ind = duplicated(bCh$ID) | duplicated(bCh$ID[nrow(bCh):1])[nrow(bCh):1]
ind = ind[1:77]

bCHsup = NULL
bChsup = bCh[ind,]
bChsup = bChsup[1:16,] # don't know why this is necessary

fWHR.Bsub = df2fWHR(bChsub)
fWHR.Bsup = df2fWHR(bChsup)
fWHR.Btemp = merge(fWHR.Bsub,fWHR.Bsup, by.x='ID', by.y='ID')
plot(fWHR.Btemp[,2:3])

cor.test(fWHR.Btemp$ratio.x,fWHR.Btemp$ratio.y)



### Calculate fWHR for morphs

fWHR.Bmorph = df2fWHR(bCh[1:77,])

# copy and paste results back into CSV


