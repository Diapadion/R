setwd("/Users/drew/Documents/R/")

exp1 <- F

### Experiment 2

### V this will need to be rebuilt V ###
#allData <- read.delim("Lash10daysMetaPrev-0.txt", header = TRUE, sep="\t",quote= " ", dec=".", comment.char=" ")

allData <- read.delim("Ebbi10daysMetaPrev.txt", header = TRUE, sep="\t",quote= " ", dec=".", comment.char=" ")

# for testing Lashley training period
#allData <- read.delim("LashMetaPrev7dayTrain.txt", header = TRUE, sep="\t",quote= " ", dec=".", comment.char=" ")
 
### Experiment 1 
 
##
#exp1 <- T
##

#allData <- read.delim("Ebbi 3 risk first 10 days prospective.txt", header = TRUE, sep="\t",quote= " ", dec=".", comment.char=" ")
 
#allData <- read.delim("Lash 3 risk first 10 days prospective.txt", header = TRUE, sep="\t",quote= " ", dec=".", comment.char=" ")
 
#allData <- read.delim("Lash 3 risk retrospective first 10 days final params.txt", header = TRUE, sep="\t",quote= " ", dec=".", comment.char=" ")
 
#allData <- read.delim("Ebbi 3 risk retrospective final params.txt", header = TRUE, sep="\t",quote= " ", dec=".", comment.char=" ")

# for (i in 1:dim(allData)[1])

	

l<-0
m<-0
n<-0
hightrials <- NULL
medtrials <- NULL
lowtrials <- NULL


### are these my combinedfiles or Gin's?
# experiment 1:
if (exp1){
	riskInd = 7
	accuInd = 5
		}else{
		#experiment 2
		riskInd = 5
		accuInd = 4
	}

for (i in 1:dim(allData)[1])
{

if (allData[i,riskInd]=="High"){
	hightrials <- c(hightrials,allData[i,accuInd])
	#[n,]<-allData[i,]
	n<-n+1
		}
		else if (allData[i,riskInd]=="Medium"){
			medtrials <- c(medtrials,allData[i,accuInd])
			m<-m+1
			
		}
		else if (allData[i,riskInd]=="Low"){
			lowtrials <- c(lowtrials,allData[i,accuInd])
			l<-l+1
				}
				}
 
if(exp1){
	for (i in 1:length(hightrials)){
		if (hightrials[i]==2){
			hightrials[i]=1
			}else{
				hightrials[i]=0
	
		}
	}
	for (i in 1:length(medtrials)){
		if (medtrials[i]==2){
			medtrials[i]=1
			}else{
				medtrials[i]=0
				}
				}
	for (i in 1:length(lowtrials)){
		if (lowtrials[i]==2){
			lowtrials[i]=1
			}else{
				lowtrials[i]=0
					}
					}
}				
				
				
				
