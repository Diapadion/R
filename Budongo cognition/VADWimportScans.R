# script for importing Vanessa's scan data from .csv



scans = read.csv("combined old style corrected KS 210513 1558.csv", header=TRUE)

# taking out extra rows
subscans = subset(scans, scans$Qafzeh!="")
subscans = subset(subscans, Qafzeh != "Qafzeh")

colnames(subscans)[1] <- 'date'

# builds the basic data.frame that we're to add to
MLMformat = data.frame(date = character(0), observationNumber = integer(0), scanNumber = integer(0),
                       chimp = character(0), behaviour = character(0),
                       stringsAsFactors = TRUE)
#colnames(MLMformat) #<- c('date','observationNumber','scanNumber','chimp','behaviour')
#test = 0

obsNum = 1


# main loop
# i is for rows
# j is for columns
# 

for (i in 1:dim(subscans)[1]){
  # there should be a better way to denote the columns below
  # but manual indexing is the first thing I got to work (and it does work)
  
  # for keeping track of which scan it is, within the block
  if (subscans$Scan.time[i] == "0min"){
    scanNum = 1
  } else if (subscans$Scan.time[i] == "10min"){
    scanNum = 2
  } else if (subscans$Scan.time[i] == "20min"){
    scanNum = 3
  } else if (subscans$Scan.time[i] == "30min"){
    scanNum = 4
  }  
  
  # for keeping track of which block it is, within the day
  if ((scanNum == 1) && (i>1)){
    if (subscans$date[i] == subscans$date[i-1]){
      obsNum = obsNum + 1
    } else obsNum = 1
  }
  
  
  # now the part where we put all this together into a single row
  for (j in 9:27){
    
    if (subscans[i,j] != 'OOS'){
      
      MLMformat = rbind(MLMformat, data.frame(date=subscans$date[i],
                                     observationNumber=obsNum, 
                                     scanNumber=scanNum, 
                                     chimp=colnames(subscans)[j], 
                                     behaviour=subscans[i,j]
                                     ))
      
    }      
  }    
}
