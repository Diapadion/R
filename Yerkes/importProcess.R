bc1 <- read.csv('bchemi.csv')
bc2 <- read.csv('bbchemii.csv')
persIn <- NULL
persIn <- read.csv("yerkes_dec2_traits.csv")

chmcor <- array(data=NA, dim=c(35,153))
chscor <- array(data=NA, dim=c(35,153))

# ossabaw and zeb removed

#order the dfs?
# should be set...

# {BC1}

#glucose
gluc <- cbind(bc1[,4],bc1[,30],bc1[,56],bc1[,82])
mgluc <- apply(gluc,1,mean,na.rm=TRUE)
chscor[1,] <- apply(gluc,1,sd,na.rm=TRUE)

#BUN
bun <- cbind(bc1[,5],bc1[,31],bc1[,57],bc1[,83])
mbun <- apply(bun,1,mean,na.rm=TRUE)
sbun <- apply(gluc,1,mean,na.rm=TRUE)
chscor[2,] <- apply(bun,1,sd,na.rm=TRUE)

#creatine
creat <- cbind(bc1[,6],bc1[,32],bc1[,58],bc1[,84])
mcreat <- apply(creat,1,mean,na.rm=TRUE)
chscor[3,] <- apply(creat,1,sd,na.rm=TRUE)

#protein
prot <- cbind(bc1[,7],bc1[,33],bc1[,59],bc1[,85])
mprot <- apply(prot,1,mean,na.rm=TRUE)
chscor[4,] <- apply(prot,1,sd,na.rm=TRUE)


#albumin
albm <-cbind(bc1[,8],bc1[,34],bc1[,60],bc1[,86])
malbm <- apply(albm,1,mean,na.rm=TRUE)
chscor[5,] <- apply(albm,1,sd,na.rm=TRUE)

#bilirubn
blrb <- cbind(bc1[,9],bc1[,35],bc1[,61],bc1[,87])
mblrb <- apply(blrb,1,mean,na.rm=TRUE)
chscor[6,] <- apply(blrb,1,sd,na.rm=TRUE)

#alkphos
alkp <- cbind(bc1[,10],bc1[,36],bc1[,62],bc1[,88])
malkp <- apply(alkp,1,mean,na.rm=TRUE)
chscor[7,] <- apply(alkp,1,sd,na.rm=TRUE)

#sgpt
sgpt <- cbind(bc1[,11],bc1[,37],bc1[,63],bc1[,89])
msgpt <- apply(sgpt,1,mean,na.rm=TRUE)
chscor[8,] <- apply(sgpt,1,sd,na.rm=TRUE)

#sgot
sgot <- cbind(bc1[,12],bc1[,38],bc1[,64],bc1[,90])
msgot <- apply(sgot,1,mean,na.rm=TRUE)
chscor[9,] <- apply(sgot,1,sd,na.rm=TRUE)

#cholesterol
chol <- cbind(bc1[,13],bc1[,39],bc1[,65],bc1[,91])
mchol <- apply(chol,1,mean,na.rm=TRUE)
chscor[10,] <- apply(chol,1,sd,na.rm=TRUE)

#calcium
calc <- cbind(bc1[,14],bc1[,40],bc1[,66],bc1[,92])
mcalc <- apply(calc,1,mean,na.rm=TRUE)
chscor[11,] <- apply(calc,1,sd,na.rm=TRUE)

#phosphate
phos <- cbind(bc1[,15],bc1[,41],bc1[,67],bc1[,93])
mphos <- apply(phos,1,mean,na.rm=TRUE)
chscor[12,] <- apply(phos,1,sd,na.rm=TRUE)

#sodium
sodm <- cbind(bc1[,16],bc1[,42],bc1[,68],bc1[,94])
msodm <- apply(sodm,1,mean,na.rm=TRUE)
chscor[13,] <- apply(sodm,1,sd,na.rm=TRUE)

#potassium
ptsm <- cbind(bc1[,17],bc1[,43],bc1[,69],bc1[,95])
mptsm <- apply(ptsm,1,mean,na.rm=TRUE)
chscor[14,] <- apply(ptsm,1,sd,na.rm=TRUE)

#chloride
clrd <- cbind(bc1[,18],bc1[,44],bc1[,70],bc1[,96])
mclrd <- apply(clrd,1,mean,na.rm=TRUE)
chscor[15,] <- apply(clrd,1,sd,na.rm=TRUE)

#ag-ratio
ag_r <- cbind(bc1[,19],bc1[,45],bc1[,71],bc1[,97])
mag_r<- apply(ag_r,1,mean,na.rm=TRUE)
chscor[16,] <- apply(ag_r,1,sd,na.rm=TRUE)

#bc-ratio
bc_r <- cbind(bc1[,20],bc1[,46],bc1[,72],bc1[,98])
mbc_r <- apply(bc_r,1,mean,na.rm=TRUE)
chscor[17,] <- apply(bc_r,1,sd,na.rm=TRUE)

#globulin
glob <- cbind(bc1[,21],bc1[,47],bc1[,73],bc1[,99])
mglob <- apply(glob,1,mean,na.rm=TRUE)
chscor[18,] <- apply(glob,1,sd,na.rm=TRUE)

#lipase
lipa <- cbind(bc1[,22],bc1[,48],bc1[,74],bc1[,100])
mlipa <- apply(lipa,1,mean,na.rm=TRUE)
chscor[19,] <- apply(lipa,1,sd,na.rm=TRUE)

#amylase
amyl <- cbind(bc1[,23],bc1[,49],bc1[,75],bc1[,101])
mamyl <- apply(amyl,1,mean,na.rm=TRUE)
chscor[20,] <- apply(amyl,1,sd,na.rm=TRUE)

#triglicerides
trgl <- cbind(bc1[,24],bc1[,50],bc1[,76],bc1[,102])
mtrgl <- apply(trgl,1,mean,na.rm=TRUE)
chscor[21,] <- apply(trgl,1,sd,na.rm=TRUE)

#cpk
cpk <- cbind(bc1[,25],bc1[,51],bc1[,77],bc1[,103])
mcpk <- apply(cpk,1,mean,na.rm=TRUE)
chscor[22,] <- apply(cpk,1,sd,na.rm=TRUE)

#ggtp
ggtp <- cbind(bc1[,26],bc1[,52],bc1[,78],bc1[,104])
mggtp <- apply(ggtp,1,mean,na.rm=TRUE)
chscor[23,] <- apply(ggtp,1,sd,na.rm=TRUE)

#magnesium
mgns <- cbind(bc1[,27],bc1[,53],bc1[,79],bc1[,105])
mmgns <- apply(mgns,1,mean,na.rm=TRUE)
chscor[24,] <- apply(mgns,1,sd,na.rm=TRUE)

#osmolal
osml <- cbind(bc1[,28],bc1[,54],bc1[,80],bc1[,106])
mosml <- apply(osml,1,mean,na.rm=TRUE)
chscor[25,] <- apply(osml,1,sd,na.rm=TRUE)


#{BC2}

#rbc
rbc <- cbind(bc2[,12],bc2[,23],bc2[,34])
mrbc <- apply(rbc,1,mean,na.rm=TRUE)
chscor[26,] <- apply(rbc,1,sd,na.rm=TRUE)

#wbc
wbc <- cbind(bc2[,13],bc2[,24],bc2[,35])
mwbc <- apply(wbc,1,mean,na.rm=TRUE)
chscor[27,] <- apply(wbc,1,sd,na.rm=TRUE)

#hct
hct <- cbind(bc2[,14],bc2[,25],bc2[,36])
mhct <- apply(hct,1,mean,na.rm=TRUE)
chscor[28,] <- apply(hct,1,sd,na.rm=TRUE)

#hgb
hgb <- cbind(bc2[,15],bc2[,26],bc2[,37])
mhgb <- apply(hgb,1,mean,na.rm=TRUE)
chscor[29,] <- apply(hgb,1,sd,na.rm=TRUE)

#mcv
mcv <- cbind(bc2[,16],bc2[,27],bc2[,38])
mmcv <- apply(mcv,1,mean,na.rm=TRUE)
chscor[30,] <- apply(mcv,1,sd,na.rm=TRUE)

#mch
mch <- cbind(bc2[,17],bc2[,28],bc2[,39])
mmch <- apply(mch,1,mean,na.rm=TRUE)
chscor[31,] <- apply(mch,1,sd,na.rm=TRUE)

#mchc
mchc <- cbind(bc2[,18],bc2[,29],bc2[,40])
mmchc <- apply(mchc,1,mean,na.rm=TRUE)
chscor[32,] <- apply(mchc,1,sd,na.rm=TRUE)

#lymph
lym <- cbind(bc2[,19],bc2[,30],bc2[,41])
mlym <- apply(lym,1,mean,na.rm=TRUE)
chscor[33,] <- apply(lym,1,sd,na.rm=TRUE)

#monos
mon <- cbind(bc2[,20],bc2[,31],bc2[,42])
mmon <- apply(mon,1,mean,na.rm=TRUE)
chscor[34,] <- apply(mon,1,sd,na.rm=TRUE)

#eos
eos <- cbind(bc2[,21],bc2[,32],bc2[,43])
meos <- apply(eos,1,mean,na.rm=TRUE)
chscor[35,] <- apply(eos,1,sd,na.rm=TRUE)

# extra vars from bc2

# mom's age (@?)

# age

# sex


# PERSONALITY

pdim = dim(persIn)

#combine 
#something wrong here I don't know why,
#but pDomainScr and persIn are (...not?) saved fine
#I don't fucking know
for (i in 1:(pdim[1]-1)){
  if (persIn[i,1]==persIn[i+1,1]){
    for (j in 12:60){
      persIn[i,j] <- 0.5*(persIn[i+1,j]+persIn[i,j])
    }
    persIn<-persIn[-(i+1),]
  }
}

pDomainScr <-persIn[,-c(2:54)]

  


chmcor[1,] <- mgluc
chmcor[2,] <- mbun
chmcor[3,] <- mcreat
chmcor[4,] <- mprot
chmcor[5,] <- malbm
chmcor[6,] <- mblrb
chmcor[7,] <- malkp
chmcor[8,] <- msgpt
chmcor[9,] <- msgot
chmcor[10,] <- mchol
chmcor[11,] <- mcalc
chmcor[12,] <- mphos
chmcor[13,] <- msodm
chmcor[14,] <- mptsm
chmcor[15,] <- mclrd
chmcor[16,] <- mag_r
chmcor[17,] <- mbc_r
chmcor[18,] <- mglob
chmcor[19,] <- mlipa
chmcor[20,] <- mamyl
chmcor[21,] <- mtrgl
chmcor[22,] <- mcpk
chmcor[23,] <- mggtp
chmcor[24,] <- mmgns
chmcor[25,] <- mosml
chmcor[26,] <- mrbc
chmcor[27,] <- mwbc
chmcor[28,] <- mhct
chmcor[29,] <- mhgb
chmcor[30,] <- mmcv
chmcor[31,] <- mmch
chmcor[32,] <- mmchc
chmcor[33,] <- mlym
chmcor[34,] <- mmon
chmcor[35,] <- meos





# ... find initial removals in history, if possible, and below for commands to do it
# 
# pdim = dim(persIn)
# persProc <- persIn
# 
# for (i in 1:pdim[1]){
#   if (is.element(toupper(persProc[i,1]),mustPersRm)){
#     persProc <- persProc[-i,
#     i = i-1
#   }
# }



