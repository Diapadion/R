# script for importing excel files



setwd('Z:/chimp cognitive data/raw/')

temp = list.files(pattern="*.csv")

# Emma
EMlist = grep('em',temp,ignore.case=TRUE)

EMdata = read.csv(temp[EMlist[1]], header=TRUE)
EMlist = EMlist[-1]
for (i in 1:length(EMlist)){
  EMdata <- rbind(EMdata,read.csv(temp[EMlist[i]]), header=FALSE) 
}
EMattempt <- subset(EMdata, EMdata[ , 1] < 1)
EMdata <- subset(EMdata, EMdata[ , 1] > 0)

# Edith
EDlist = grep('ed',temp,ignore.case=TRUE)

EDdata = read.csv(temp[EDlist[1]], header=TRUE)
EDlist = EDlist[-1]
for (i in 1:length(EDlist)){
  EDdata <- rbind(EDdata,read.csv(temp[EDlist[i]]), header=FALSE) 
}
EDattempt <- subset(EDdata, EDdata[ , 1] < 1)
EDdata <- subset(EDdata, EDdata[ , 1] > 0)




for (i in 1:length(temp)) assign(temp[i], read.csv(temp[i]))

objects()








# Misc BS

#11/14/2014, 9:37:01 AM GMT+0:00

#1415957821.25373+549.6891090869904+26.198975086212158
#1415958397.14
#1415958397.141814173203
#11/14/2014, 9:46:37 AM GMT+0:00