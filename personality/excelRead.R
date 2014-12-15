setwd("/Users/drew/Dropbox/R/personality")

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


