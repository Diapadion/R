

# now for some monkey data 

dataIn <- read.xls("AugArbitraryStim.xls",sheet=1,verbose=FALSE,method="tab")
attach(dataIn)
adata <- dataIn[order(TrialAccuracy,decreasing=FALSE),]
detach(dataIn)

dataIn <- read.xls("BenedArbitraryStim.xls",sheet=1,verbose=FALSE,method="tab")
attach(dataIn)
bdata <- dataIn[order(TrialAccuracy,decreasing=FALSE),]
detach(dataIn)

dataIn <- read.xls("ColtArbitraryStim.xls",sheet=1,verbose=FALSE,method="tab")
attach(dataIn)
cdata <- dataIn[order(TrialAccuracy,decreasing=FALSE),]
detach(dataIn)

dataIn <- read.xls("EbbiArbitraryStim.xls",sheet=1,verbose=FALSE,method="tab")
attach(dataIn)
 <- dataIn[order(TrialAccuracy,decreasing=FALSE),]
detach(dataIn)

dataIn <- read.xls("HoratArbitraryStim.xls",sheet=1,verbose=FALSE,method="tab")
attach(dataIn)
hdata <- dataIn[order(TrialAccuracy,decreasing=FALSE),]
detach(dataIn)

dataIn <- read.xls("LashArbitraryStim.xls",sheet=1,verbose=FALSE,method="tab")
attach(dataIn)
ldata <- dataIn[order(TrialAccuracy,decreasing=FALSE),]
detach(dataIn)

dataIn <- read.xls("MacdArbitraryStim.xls",sheet=1,verbose=FALSE,method="tab")
attach(dataIn)
mdata <- dataIn[order(TrialAccuracy,decreasing=FALSE),]
detach(dataIn)

dataIn <- read.xls("OberArbitraryStim.xls",sheet=1,verbose=FALSE,method="tab")
attach(dataIn)
odata <- dataIn[order(TrialAccuracy,decreasing=FALSE),]
detach(dataIn)

dataIn <- read.xls("ProspArbitraryStim.xls",sheet=1,verbose=FALSE,method="tab")
attach(dataIn)
pdata <- dataIn[order(TrialAccuracy,decreasing=FALSE),]
detach(dataIn)


# and now some other data processing shenanigans


