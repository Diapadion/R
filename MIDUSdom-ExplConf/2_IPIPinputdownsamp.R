#### Script for reading IPIP data and appropriately reducing sample size

library(foreign)
library(psych)
library(caret)




#ipip <- read.spss("~/IPIP300.por", to.data.frame=TRUE) # replace with appropriate code

table(ipip$I299, useNA = 'ifany')
table(!is.na(ipip$I299))
ipip <- ipip[!is.na(ipip$I300),]

set.seed(1234567)
sub.ipip = createDataPartition(c(ipip$AGE,ipip$SEX), times=1, p=0.017, list=TRUE)
head(sub.ipip[[1]])
length(sub.ipip[[1]])
table(ipip[sub.ipip[[1]],'I299'], useNA = 'ifany')

ipip$SEX = -1*ipip$SEX + 2

saveRDS(ipip[sub.ipip[[1]],], file="ipip-subset.RDS")

ipip.sub <- readRDS("ipip-subset.RDS")
ipip.sub <- ipip.sub[!is.na(ipip.sub$I299),]
ipip <- ipip.sub

gc()
