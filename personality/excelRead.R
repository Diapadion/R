#setwd("/Users/drew/Dropbox/R/personality")
setwd("/Users/s1229179/git-repos/R/personality")

pers <- NULL

pers <- array(,dim=c(9,12,54))
#12 for Greg



for(i in 1:9){
	surveyIn <- read.xls("MPTA - Alex.xls",sheet=i,verbose=FALSE,'ADJECTIVE',method="tab")
	attach(surveyIn)
	srt <- surveyIn[order(ADJECTIVE,decreasing=FALSE),]
	pers[i,1,] <- srt[,2][2:55]
	detach(surveyIn)
}

for(i in 1:9){
	surveyIn <- read.xls("MPTA - Bayo.xls",sheet=i,verbose=FALSE,'ADJECTIVE',method="tab")
	attach(surveyIn)
	srt <- surveyIn[order(ADJECTIVE,decreasing=FALSE),]
	pers[i,2,] <- srt[,2][2:55]
	detach(surveyIn)
}

for(i in 1:9){
	surveyIn <- read.xls("MPTA - Dakota.xls",sheet=i,verbose=FALSE,'ADJECTIVE',method="tab")
	attach(surveyIn)
	srt <- surveyIn[order(ADJECTIVE,decreasing=FALSE),]
	pers[i,3,] <- srt[,2][2:55]
	detach(surveyIn)
}

for(i in 1:9){
	surveyIn <- read.xls("MPTA - Daniel.xls",sheet=i,verbose=FALSE,'ADJECTIVE',method="tab")
	attach(surveyIn)
	srt <- surveyIn[order(ADJECTIVE,decreasing=FALSE),]
	pers[i,4,] <- srt[,2][2:55]
	detach(surveyIn)
}

for(i in 1:9){
	surveyIn <- read.xls("MPTA - Drew.xls",sheet=i,verbose=FALSE,'ADJECTIVE',method="tab")
	attach(surveyIn)
	srt <- surveyIn[order(ADJECTIVE,decreasing=FALSE),]
	pers[i,5,] <- srt[,2][2:55]
	detach(surveyIn)
}

for(i in 1:9){
	surveyIn <- read.xls("MPTA - Dylan.xls",sheet=i,verbose=FALSE,'ADJECTIVE',method="tab")
	attach(surveyIn)
	srt <- surveyIn[order(ADJECTIVE,decreasing=FALSE),]
	pers[i,6,] <- srt[,2][2:55]
	detach(surveyIn)
}

for(i in 1:9){
	surveyIn <- read.xls("MPTA - Ema.xls",sheet=i,verbose=FALSE,'ADJECTIVE',method="tab")
	attach(surveyIn)
	srt <- surveyIn[order(ADJECTIVE,decreasing=FALSE),]
	pers[i,7,] <- srt[,2][2:55]
	detach(surveyIn)
}

for(i in 1:9){
	surveyIn <- read.xls("MPTA - Farhana.xls",sheet=i,verbose=FALSE,'ADJECTIVE',method="tab")
	attach(surveyIn)
	srt <- surveyIn[order(ADJECTIVE,decreasing=FALSE),]
	pers[i,8,] <- srt[,2][2:55]
	detach(surveyIn)
}

for(i in 1:9){
	surveyIn <- read.xls("MPTA - Rachelle.xls",sheet=i,verbose=FALSE,'ADJECTIVE',method="tab")
	attach(surveyIn)
	srt <- surveyIn[order(ADJECTIVE,decreasing=FALSE),]
	pers[i,9,] <- srt[,2][2:55]
	detach(surveyIn)
}

for(i in 1:9){
	surveyIn <- read.xls("MPTA - Sally.xls",sheet=i,verbose=FALSE,'ADJECTIVE',method="tab")
	attach(surveyIn)
	srt <- surveyIn[order(ADJECTIVE,decreasing=FALSE),]
	pers[i,10,] <- srt[,2][2:55]
	detach(surveyIn)
}

for(i in 1:9){
	surveyIn <- read.xls("MPTA - Shangshang.xls",sheet=i,verbose=FALSE,'ADJECTIVE',method="tab")
	attach(surveyIn)
	srt <- surveyIn[order(ADJECTIVE,decreasing=FALSE),]
	pers[i,11,] <- srt[,2][2:55]
	detach(surveyIn)
}

for(i in 1:9){
	surveyIn <- read.xls("MPTA - Greg.xls",sheet=i,verbose=FALSE,'ADJECTIVE',method="tab")
	attach(surveyIn)
	srt <- surveyIn[order(ADJECTIVE,decreasing=FALSE),]
	pers[i,12,] <- srt[,2][2:55]
	detach(surveyIn)
}


### remove certain raters

trimp = pers[,c(1:4,6:11),]
trimp = trimp[,,-c(5,53)] # take out autistic and unperceptive

# colname tracking
srt <- srt$ADJECTIVE[2:55]
srt <- srt[-c(5,53)]

### Intraclass correlation
library(psych)
icc3 <- NULL
for (i in 1:52){
  icc3[i] =  ICC(trimp[,,i])$results
}

ICC(trimp[,,4])
ticc = ICC(trimp[,,1])
ticc$results$
  
  
  
## potential problems (some estimates and confint below 0):
# 2 - affectionate
# 4 - anxious
# 7 - clumsy
# 15 - disorganzied
# 24 - imitative
# 33 - jealous
# 39 - protective
# 42 - sensitive
# 48 - sympathetic
# 49 - thoughtless
  
## definite problems:
# 6 - cautious
# 12 - defiant
# 26 - independent
# 46 - stingy / greedy

trimp = trimp[,,-c(6,12,26,46)]  # remove only the definite problems

srt <- srt[-c(6,12,26,46)]

# so we've taken out Autistic, Unperceptive, Cautious (Cnf), Defiant(Dom), Independent(Dom), and Stingy/Greedy(Dom)