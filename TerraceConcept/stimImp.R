library(entropy)
library(jpeg)


# training set

birdsAr <- NULL
peoplAr <- NULL
catsAr <- NULL
flowAr <- NULL

daliAr <- NULL
geromeAr <- NULL
vangAr <- NULL
monetAr <- NULL


for (i in 0:3110){
  birdsAr[i] <- entropy(readJPEG(paste("C:/Users/Public/Pictures/pics.categories/birds.",formatC(i,width=4,flag="0"),".jpg",sep="")), method="ML")
}

for (i in 0:2852){
  peoplAr[i] <- entropy(readJPEG(paste("C:/Users/Public/Pictures/pics.categories/people.",formatC(i,width=4,flag="0"),".jpg",sep="")), method="ML")
}

for (i in 0:872){
  catsAr[i] <- entropy(readJPEG(paste("C:/Users/Public/Pictures/pics.categories/cats.",formatC(i,width=4,flag="0"),".jpg",sep="")), method="ML")
}

for (i in 0:3032){
  flowAr[i] <- entropy(readJPEG(paste("C:/Users/Public/Pictures/pics.categories/flowers.",formatC(i,width=4,flag="0"),".jpg",sep="")), method="ML")
}

#---

for (i in 1:202){
  daliAr[i] <- entropy(readJPEG(paste("C:/Users/Public/Pictures/pics.categories/dali.",formatC(i,width=4,flag="0"),".jpg",sep="")), method="ML")
}

for (i in 1:406){
  geromeAr[i] <- entropy(readJPEG(paste("C:/Users/Public/Pictures/pics.categories/gerome.",formatC(i,width=4,flag="0"),".jpg",sep="")), method="ML")
}

for (i in 1:283){
  monetAr[i] <- entropy(readJPEG(paste("C:/Users/Public/Pictures/pics.categories/monet.",formatC(i,width=4,flag="0"),".jpg",sep="")), method="ML")
}

for (i in 1:231){
  vangAr[i] <- entropy(readJPEG(paste("C:/Users/Public/Pictures/pics.categories/vangogh.",formatC(i,width=4,flag="0"),".jpg",sep="")), method="ML")
}

#---

smrB <- c(summary(birdsAr)[3:4],sd(birdsAr))
smrC <- c(summary(catsAr)[3:4],sd(catsAr))
smrF <- c(summary(flowAr)[3:4],sd(flowAr))
smrP <- c(summary(peoplAr)[3:4],sd(peoplAr))

smrD <- c(summary(daliAr)[3:4],sd(daliAr))
smrG <- c(summary(geromeAr)[3:4],sd(geromeAr))
smrM <- c(summary(monetAr)[3:4],sd(monetAr))
smrV <- c(summary(vangAr)[3:4],sd(vangAr))



  
# testing set

bTstAr <- NULL
cTstAr <- NULL
fTstAr <- NULL
pTstAr <- NULL

for (i in 0:49){
  pTstAr[i+1] <- entropy(readJPEG(paste("C:/Users/Public/Pictures/test stimuli/sc.1",formatC(i,width=4,flag="0"),".jpg",sep="")), method="ML")
}
for (i in 50:98){
  fTstAr[i-49] <- entropy(readJPEG(paste("C:/Users/Public/Pictures/test stimuli/sc.1",formatC(i,width=4,flag="0"),".jpg",sep="")), method="ML")
}
for (i in 100:148){
  cTstAr[i-99] <- entropy(readJPEG(paste("C:/Users/Public/Pictures/test stimuli/sc.1",formatC(i,width=4,flag="0"),".jpg.jpg",sep="")), method="ML")
}
for (i in 150:198){
  bTstAr[i-149] <- entropy(readJPEG(paste("C:/Users/Public/Pictures/test stimuli/sc.1",formatC(i,width=4,flag="0"),".jpg.jpg",sep="")), method="ML")
}
smrPTst <- c(summary(pTstAr)[3:4],sd(pTstAr))
smrFTst <- c(summary(fTstAr)[3:4],sd(fTstAr))
smrBTst <- c(summary(bTstAr)[3:4],sd(bTstAr))
smrCTst <- c(summary(cTstAr)[3:4],sd(cTstAr))

###
  
dTstAr <- NULL
vTstAr <- NULL
mTstAr <- NULL
jTstAr <- NULL

for (i in 200:224){
  dTstAr[i-199] <- entropy(readJPEG(paste("C:/Users/Public/Pictures/test stimuli/sc.1",formatC(i,width=4,flag="0"),".jpg.jpg",sep="")), method="ML")
}
for (i in 250:274){
  jTstAr[i-249] <- entropy(readJPEG(paste("C:/Users/Public/Pictures/test stimuli/sc.1",formatC(i,width=4,flag="0"),".jpg.jpg",sep="")), method="ML")
}
for (i in 300:324){
  mTstAr[i-299] <- entropy(readJPEG(paste("C:/Users/Public/Pictures/test stimuli/sc.1",formatC(i,width=4,flag="0"),".jpg.jpg",sep="")), method="ML")
}
for (i in 350:374){
  vTstAr[i-349] <- entropy(readJPEG(paste("C:/Users/Public/Pictures/test stimuli/sc.1",formatC(i,width=4,flag="0"),".jpg.jpg",sep="")), method="ML")
}
smrDTst <- c(summary(dTstAr)[3:4],sd(dTstAr))
smrJTst <- c(summary(jTstAr)[3:4],sd(jTstAr))
smrMTst <- c(summary(mTstAr)[3:4],sd(mTstAr))
smrVTst <- c(summary(vTstAr)[3:4],sd(vTstAr))




### some BS
explPic <- readJPEG(paste("C:/Users/Public/Pictures/pics.categories/birds.",formatC(1,width=4,flag="0"),".jpg",sep=""))

epl1 <- entropy(explPic[,,1])
epl3 <- entropy(explPic[,,3])
epl2 <- entropy(explPic[,,2])
exptrop <- entropy(explPic)
