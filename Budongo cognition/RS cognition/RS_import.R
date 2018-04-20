### Importing and processing Ruth Sonnweber's data


setwd('M:/chimp cognitive data/RS/training/')


## sample sheet to work with (for now)


hder = c(
  "Section","Trial","RT","CorrectResponse","Response","TrialType","StimulusLocation1",
  "StimulusLocation2","Coordinates","Correctness","FileNames1","FileNames2")

hder0 = c(
  "Section","Trial","RT","CorrectResponse","Response","TrialType","StimulusLocation1",
  "StimulusLocation2","Correctness","FileNames1","FileNames2")

# 
# train <- read.csv(file="2-choice AA1 black/2013_10_17_14_53_17_744465.csv", header= FALSE, skip = 7)
# colnames(train) = hder
# train$chimp = read.csv(file="2-choice AA1 black/2013_10_17_14_53_17_744465.csv", header=FALSE)[4,1]
# train$date = read.csv(file="2-choice AA1 black/2013_10_17_14_53_17_744465.csv", header=FALSE)[1,2]
# 

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
setwd('../2-choice ABpairs2_fine/')
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

### fresh stuff from RS
setwd('../output_2-choice_AA 1 BLACK/')
temp = list.files(pattern="*.csv")

trainAA1_0 <- NULL
for (i in 1:length(temp)){
  trainAA1_0 = rbind(trainAA1_0, RSbySheet(temp[i], hder0))
}
trainAA1_0$stage = "AA1_0"

#
setwd('../output_2-choice_ABpairs 1 black/')
temp = list.files(pattern="*.csv")

trainABp1_0 <- NULL
for (i in 1:length(temp)){
  trainABp1_0 = rbind(trainABp1_0, RSbySheet(temp[i], hder0))
}
trainABp1_0$stage = "ABp1_0"

#
setwd('../output_2-choice_ABpairs 2 black/')
temp = list.files(pattern="*.csv")

trainABp2_0 <- NULL
for (i in 1:length(temp)){
  trainABp2_0 = rbind(trainABp2_0, RSbySheet(temp[i], hder0))
}
trainABp2_0$stage = "ABp2_0"

#
setwd('../output_2-choice_ABpairs 3 black/')
temp = list.files(pattern="*.csv")

trainABp3_0 <- NULL
for (i in 1:length(temp)){
  trainABp3_0 = rbind(trainABp3_0, RSbySheet(temp[i], hder0))
}
trainABp3_0$stage = "ABp3_0"


###
setwd("../../testing/all/")
temp = list.files(pattern="*.csv")

testing <- NULL
for (i in 1:length(temp)){
  testing = rbind(testing, RSbySheet(temp[i], hder))
}
testing$stage = "test"


## fixing the column numbers in the old data files
#bspot <- which(names(testing)=="Correctness")
# tAA10test <-> trainAA1_0
bspot = 8

trainAA1_0 <- data.frame(trainAA1_0[1:bspot],Coordinates=NA,trainAA1_0[(bspot+1):ncol(trainAA1_0)])
names(trainAA1_0)
trainABp3_0<- data.frame(trainABp3_0[1:bspot],Coordinates=NA,trainABp3_0[(bspot+1):ncol(trainABp3_0)])
trainABp2_0 <- data.frame(trainABp2_0[1:bspot],Coordinates=NA,trainABp2_0[(bspot+1):ncol(trainABp2_0)])
trainABp1_0 <- data.frame(trainABp1_0[1:bspot],Coordinates=NA,trainABp1_0[(bspot+1):ncol(trainABp1_0)])




# putting them all together
RSdat = rbind(trainAA1, trainAA2, trainABp2, trainABp3, trainABp4, 
              trainAA1_0
              , trainABp1_0, trainABp2_0, trainABp3_0,
              testing)


## importing personality
setwd('M:/chimp cognitive data/RS/')
aggPers = read.csv("aggregatedPers.csv", header=TRUE)

# two groups:
# AA (features): 6 - FK, KL, EM, LB, ED
# AB (association): 5 - CI, EV, PA, PE, DA, LO

# these need to be centered and scaled first
aggPers <- cbind(aggPers,scale(aggPers[,3:8]))

### THIS NEEDS REVISION
aggPers$depend = c('AB','AB','AA','AA','AB','AA','X','AA','X','X','AA','AB','X','AB','AB',
                   'X','X','X','X')
colnames(aggPers)[3:8] <- list("unz.Dom","unz.Ext","unz.Con","unz.Agr","unz.Neu","unz.Opn")
## merge dataframes

#write.csv(RSdat, '../what.csv')

RSdat$chimp = droplevels(RSdat$chimp)
library(plyr)
RSdat$chimp <- revalue(RSdat$chimp, c("killimi"="Kilimi", "emma"="Emma", "lib"="Liberius","frek"="Freek",
                       "edith"="Edith", "paul"="Paul", "eva" = "Eva", "louis"="Louis",
                       "pearl"="Pearl", "david" = "David", "cindy"="Cindy", 'edithj' = 'Edith',
                       'frekl' = 'Freek', 'rene' = 'Rene', 'kindia' = 'Kindia', 'lucy' = 'Lucy'
                       ))

#head(levels(RSdat$chimp),12)
#levels(droplevels(RSdat$chimp))

RStemp = merge(RSdat,aggPers, by.x= "chimp", "Chimp")

# clean some empty rows from this

RStemp=RStemp[!is.na(RStemp$RT),]


# taking stock of the amount of time involved in the task
RStemp$short_date <- droplevels(RStemp$date)

RStemp$short_date <- as.Date(substr(RStemp$date,6,11), format="%B %d")


# This seemed to work. Now re-order the df by date:
library(dplyr)


# require(data.table)
# RStemp <- data.table(RStemp)
# RStemp = RStemp[order(RStemp$short_date),]
# RStemp$short_date = as.numeric(RStemp$short_date)

RStemp$day = NA
indivs = levels(RStemp$chimp)
for (i in 1:length(indivs)){
  
  RStemp[RStemp$chimp==indivs[i],] = RStemp[RStemp$chimp==indivs[i],] %>% mutate(day = dense_rank(short_date))
}



#head(RStemp[RStemp$chimp=='Freek',])


#head(unique(RStemp$day)) 



### DOES TIME ORDER NEED TO BE MAINTAINED?
## given that they keep seeing stimuli from previous trial, probably





write.csv(aggPers[c(1:18),c(2:8,11:16)], 'scaledPers.csv')



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
  
