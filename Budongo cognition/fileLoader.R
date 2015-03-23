# script for importing excel files

library(Rcpp)
library(plyr)

rbind.all.columns <- function(x, y) {
  
  x.diff <- setdiff(colnames(x), colnames(y))
  y.diff <- setdiff(colnames(y), colnames(x))
  
  x[, c(as.character(y.diff))] <- NA
  
  y[, c(as.character(x.diff))] <- NA
  
  return(rbind(x, y 
               ,header = FALSE
               ))
}

### 
# personality
###





###
# cognition
###

setwd('C:/Users/s1229179/git-repos/R/Budongo cognition/')
pers <- read.csv('EDIpersonality.csv',header=TRUE)

setwd('Z:/chimp cognitive data/raw/')




temp = list.files(pattern="*.csv")

# Kilimi
KLlist = grep('kl',temp,ignore.case=TRUE)

KLdata = read.csv(temp[KLlist[1]], header=TRUE)
KLlist = KLlist[-1]
for (i in 1:length(KLlist)){
  KLdata <- rbind(KLdata,read.csv(temp[KLlist[i]]), header=FALSE) 
}
KLattempt <- subset(KLdata, KLdata[ , 1] < 1)
KLdata <- subset(KLdata, KLdata[ , 1] > 0)

# Emma
EMlist = grep('em',temp,ignore.case=TRUE)

EMdata = read.csv(temp[EMlist[1]], header=TRUE)
EMlist = EMlist[-1]
for (i in 1:length(EMlist)){
  EMdata <- rbind(EMdata,read.csv(temp[EMlist[i]]), header=FALSE) 
}
EMattempt <- subset(EMdata, EMdata[ , 1] < 1)
EMdata <- subset(EMdata, EMdata[ , 1] > 0)

# Cindy
CIlist = grep('CI',temp,ignore.case=TRUE)

CIdata = read.csv(temp[CIlist[1]], header=TRUE)
CIlist = CIlist[-1]
for (i in 1:length(CIlist)){
  CIdata <- rbind(CIdata,read.csv(temp[CIlist[i]]), header=FALSE) 
}
CIattempt <- subset(CIdata, CIdata[ , 1] < 1)
CIdata <- subset(CIdata, CIdata[ , 1] > 0)

# Frek
FKlist = grep('FK',temp,ignore.case=TRUE)

FKdata = read.csv(temp[FKlist[1]], header=TRUE)
FKlist = FKlist[-1]
for (i in 1:length(FKlist)){
  FKdata <- rbind(FKdata,read.csv(temp[FKlist[i]]), header=FALSE) 
}
FKattempt <- subset(FKdata, FKdata[ , 1] < 1)
FKdata <- subset(FKdata, FKdata[ , 1] > 0)

# Liberius
LBlist = grep('LB',temp,ignore.case=TRUE)

LBdata = read.csv(temp[LBlist[1]], header=TRUE)
LBlist = LBlist[-1]
for (i in 1:length(LBlist)){
  LBdata <- rbind(LBdata,read.csv(temp[LBlist[i]]), header=FALSE) 
}
LBattempt <- subset(LBdata, LBdata[ , 1] < 1)
LBdata <- subset(LBdata, LBdata[ , 1] > 0)

# Pearl
PElist = grep('PE',temp,ignore.case=TRUE)

PEdata = read.csv(temp[PElist[1]], header=TRUE)
PElist = PElist[-1]
for (i in 1:length(PElist)){
  PEdata <- rbind(PEdata,read.csv(temp[PElist[i]]), header=FALSE) 
}
PEattempt <- subset(PEdata, PEdata[ , 1] < 1)
PEdata <- subset(PEdata, PEdata[ , 1] > 0)

# Eva
EVlist = grep('EV',temp,ignore.case=TRUE)

EVdata = read.csv(temp[EVlist[1]], header=TRUE)
EVlist = EVlist[-1]
for (i in 1:length(EVlist)){
  EVdata <- rbind(EVdata,read.csv(temp[EVlist[i]]), header=FALSE) 
}
EVattempt <- subset(EVdata, EVdata[ , 1] < 1)
EVdata <- subset(EVdata, EVdata[ , 1] > 0)

# David
DAlist = grep('DA',temp,ignore.case=TRUE)

DAdata = read.csv(temp[DAlist[1]], header=TRUE)
DAlist = DAlist[-1]
for (i in 1:length(DAlist)){
  DAdata <- rbind(DAdata,read.csv(temp[DAlist[i]]), header=FALSE) 
}
DAattempt <- subset(DAdata, DAdata[ , 1] < 1)
DAdata <- subset(DAdata, DAdata[ , 1] > 0)

# Sophie
SOlist = grep('SO',temp,ignore.case=TRUE)

SOdata = read.csv(temp[SOlist[1]], header=TRUE)
SOlist = SOlist[-1]
for (i in 1:length(SOlist)){
  SOdata <- rbind(SOdata,read.csv(temp[SOlist[i]]), header=FALSE) 
}
SOattempt <- subset(SOdata, SOdata[ , 1] < 1)
SOdata <- subset(SOdata, SOdata[ , 1] > 0)

# Lucy
LUlist = grep('LU',temp,ignore.case=TRUE)

LUdata = read.csv(temp[LUlist[1]], header=TRUE)
LUlist = LUlist[-1]
for (i in 1:length(LUlist)){
  LUdata <- rbind(LUdata,read.csv(temp[LUlist[i]]), header=FALSE) 
}
LUattempt <- subset(LUdata, LUdata[ , 1] < 1)
LUdata <- subset(LUdata, LUdata[ , 1] > 0)

# Rene
RElist = grep('RE',temp,ignore.case=TRUE)

REdata = read.csv(temp[RElist[1]], header=TRUE)
RElist = RElist[-1]
for (i in 1:length(RElist)){
  REdata <- rbind(REdata,read.csv(temp[RElist[i]]), header=FALSE) 
}
REattempt <- subset(REdata, REdata[ , 1] < 1)
REdata <- subset(REdata, REdata[ , 1] > 0)

# Kindia
KDlist = grep('KD',temp,ignore.case=TRUE)

KDdata = read.csv(temp[KDlist[1]], header=TRUE)
KDlist = KDlist[-1]
for (i in 1:length(KDlist)){
  KDdata <- rbind(KDdata,read.csv(temp[KDlist[i]]), header=FALSE) 
}
KDattempt <- subset(KDdata, KDdata[ , 1] < 1)
KDdata <- subset(KDdata, KDdata[ , 1] > 0)

# Paul
PAlist = grep('PA',temp,ignore.case=TRUE)

PAdata = read.csv(temp[PAlist[1]], header=TRUE)
PAlist = PAlist[-1]
for (i in 1:length(PAlist)){
  PAdata <- rbind(PAdata,read.csv(temp[PAlist[i]]), header=FALSE) 
}
PAattempt <- subset(PAdata, PAdata[ , 1] < 1)
PAdata <- subset(PAdata, PAdata[ , 1] > 0)


# Qafzeh
Qlist = grep('Q',temp,ignore.case=TRUE)
#needs to be done semi-manually
Qdata = read.csv(temp[Qlist[3]], header=TRUE)
Qlist = Qlist[-3]
# Qdata = rbind.data.frame(Qdata,read.csv(temp[Qlist[1]], header=FALSE))
# Qlist = Qlist[-1]
# Qdata = rbind.data.frame(Qdata,read.csv(temp[Qlist[1]], header=FALSE))
# Qlist = Qlist[-1]
# Qdata = rbind.data.frame(Qdata,read.csv(temp[Qlist[1]], header=FALSE))
# dimsQ <- NULL
# for (i in 1:length(Qlist)){
#   dimsQ <- cbind(dims, dim(read.csv(temp[Qlist[i]])))
#   #Qdata <- rbind(Qdata,read.csv(temp[Qlist[i]]), header=FALSE)
#   Qdata <- rbind.all.columns(Qdata,read.csv(temp[Qlist[i]])) 
# }

# need an alternative for this
# Qlist = grep('Q',temp,ignore.case=TRUE)
dimsQ <- NULL
for (i in 1:length(Qlist)){  
  dimsQ <- cbind(dimsQ, dim(read.csv(temp[Qlist[i]])))
}  
Qattempts <- table(dimsQ)[1]

#rewmoving BS
#Qdata <- subset(Qdata, Qdata$V2 != 'Accuracy')
colnames(Qdata) <- colnames(LBdata[,1:13])


# Louis
LOlist = grep('LO',temp,ignore.case=TRUE)

LOdata = read.csv(temp[LOlist[1]], header=TRUE)
LOlist = LOlist[-1]
for (i in 1:length(LOlist)){
  #LOdata <- rbind(LOdata,read.csv(temp[LOlist[i]]), header=FALSE)
  LOdata <- rbind.fill(LOdata,read.csv(temp[LOlist[i]])) 
}
LOlist = grep('LO',temp,ignore.case=TRUE)
dimsLO <- NULL
for (i in 1:length(LOlist)){  
  dimsLO <- cbind(dimsLO, dim(read.csv(temp[LOlist[i]])))
}  
LOattempts <- table(dimsLO)[1]

# Edith
# her data is fucked up for some reason, god knows why
EDlist = grep('ed',temp,ignore.case=TRUE)

EDdata = read.csv(temp[EDlist[1]], header=TRUE)
EDlist = EDlist[-1]
# EDdata = rbind(EDdata, read.csv(temp[EDlist[37]], header=TRUE))
# EDlist = EDlist[-37]
for (i in 1:length(EDlist)){  
  EDdata <- rbind.fill(EDdata,read.csv(temp[EDlist[i]])) 
  #EDdata <- rbind(EDdata,read.csv(temp[EDlist[i]]), header = TRUE) 
}
# Attempts need to be tabulated differently now
EDlist = grep('ed',temp,ignore.case=TRUE)
dimsED <- NULL
for (i in 1:length(EDlist)){  
  dimsED <- cbind(dimsED, dim(read.csv(temp[EDlist[i]])))
}  
EDattempts <- table(dimsED)[1]






# what is this?
# for (i in 1:length(temp)) assign(temp[i], read.csv(temp[i]))
# 
# objects()
# 
# 


# Misc BS

#11/14/2014, 9:37:01 AM GMT+0:00

#1415957821.25373+549.6891090869904+26.198975086212158
#1415958397.14
#1415958397.141814173203
#11/14/2014, 9:46:37 AM GMT+0:00