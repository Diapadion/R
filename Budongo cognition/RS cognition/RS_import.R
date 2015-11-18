### Importing and processing Ruth Sonnweber's data


setwd('Z:/chimp cognitive data/RS/training/')


## sample sheet to work with (for now)


hder = c(
  "Section","Trial","RT","CorrectResponse","Response","TrialType","Stimulus Location 1",
  "Stimulus Location 2","Coordinates","Correctness","FileNames1","FileNames2")

train <- read.csv(file="2-choice AA1 black/2013_10_17_14_53_17_744465.csv", header= FALSE, skip = 7)
colnames(train) = hder
train$chimp = read.csv(file="2-choice AA1 black/2013_10_17_14_53_17_744465.csv", header=FALSE)[4,1]
train$date = read.csv(file="2-choice AA1 black/2013_10_17_14_53_17_744465.csv", header=FALSE)[1,2]




setwd("2-choice AA1 black/")
temp = list.files(pattern="*.csv")

trainAA1 <- NULL
for (i in 1:length(temp)){
  trainAA1 = rbind(trainAA1, RSbySheet(temp[i], hder))
}
trainAA1$stage = "AA1"

setwd("../2-choice AA2 black/")
temp = list.files(pattern="*.csv")

trainAA2 <- NULL
for (i in 1:length(temp)){
  trainAA2 = rbind(trainAA2, RSbySheet(temp[i], hder))
}
trainAA2$stage = "AA2"

#
setwd("../2-choice ABpairs2_fine/")
temp = list.files(pattern="*.csv")

trainABp2 <- NULL
for (i in 1:length(temp)){
  trainABp2 = rbind(trainABp2, RSbySheet(temp[i], hder))
}
trainABp2$stage = "ABp2"

#
setwd("../2-choice ABpairs3_fett/")
temp = list.files(pattern="*.csv")

trainABp3 <- NULL
for (i in 1:length(temp)){
  trainABp3 = rbind(trainABp3, RSbySheet(temp[i], hder))
}
trainABp3$stage = "ABp3"

#
setwd("../2-choice ABpairs4/")
temp = list.files(pattern="*.csv")

trainABp4 <- NULL
for (i in 1:length(temp)){
  trainABp4 = rbind(trainABp4, RSbySheet(temp[i], hder))
}
trainABp4$stage = "ABp4"

#
setwd("../../testing/all/")
temp = list.files(pattern="*.csv")

testing <- NULL
for (i in 1:length(temp)){
  testing = rbind(testing, RSbySheet(temp[i], hder))
}
testing$stage = "test"

# putting them all together
RSdat = rbind(trainAA1, trainAA2, trainABp2, trainABp3, trainABp4, testing)


## importing personality
setwd("../../")
aggPers = read.csv("aggregatedPers.csv", header=TRUE)

# two groups:
# AA (features): 6 - FK, KL, EM, LB, ED
# AB (association): 5 - CI, EV, PA, PE, DA, LO

# these need to be centered and scaled first
aggPers <- cbind(aggPers,scale(aggPers[,3:8]))
aggPers$depend = c('AB','AB','AA','AA','AB','AA','X','AA','X','X','AA','AB','X','AB','AB',
                   'X','X','X')
colnames(aggPers)[3:8] <- list("unz.Dom","unz.Ext","unz.Con","unz.Agr","unz.Neu","unz.Opn")
## merge dataframes

RSdat$chimp = droplevels(RSdat$chimp)
library(plyr)
RSdat$chimp <- revalue(RSdat$chimp, c("killimi"="Kilimi", "emma"="Emma", "lib"="Liberius","frek"="Freek",
                       "edith"="Edith", "paul"="Paul", "eva" = "Eva", "louis"="Louis",
                       "pearl"="Pearl", "david" = "David", "cindy"="Cindy"))

#head(levels(RSdat$chimp),12)
#levels(droplevels(RSdat$chimp))

temp = merge(RSdat,aggPers, by.x= "chimp", "Chimp")

# clean some empty rows from this

temp=temp[!is.na(temp$RT),]



### DOES TIME ORDER NEED TO BE MAINTAINED?
## given that they keep seeing stimuli from previous trial, probably









RSbySheet <- function(val, hder){
  load = read.csv(file=val, header=FALSE)
  imp = NULL
  if(!is.na(load[11,1])){
    imp <- read.csv(file=val, header= FALSE, skip = 7)
    colnames(imp) = hder
    imp$chimp = load[4,1]
    imp$date = load[1,2]
  }
  
  return(imp)
}
  
