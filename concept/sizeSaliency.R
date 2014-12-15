### MLM analysis of ecological concept image size-saliency

## importing data
library(plyr)

# performance
tabletop = c('Sub','Date','Press','Trial','ItemPressed','CorrectItem','Progress','PressAccuracy','TrialAccuracy','RT','SessionTime','TotalTime','ListNum','ListPics','ItemsInList','NumLists','CorrectionProcedure','ex1','ex2','ex3','ListType','PortPressed','CorrectPort','PicturePressed','Chamber','TrialsPerSession','TO','ITI','Label','Ports','Used','v1','v2','v3','v4','v5','v6','v7','v8','v9','v10','v11','v12','v13','v14','v15')

#Aug = read.table("SCrawdata/SimChain.Augustus.3%3A10%3A11", header=FALSE, skip=1, sep="\t",
#                  col.names=c('Sub','Date','Press','Trial','ItemPressed','CorrectItem','Progress','PressAccuracy','TrialAccuracy','RT','SessionTime','TotalTime','ListNum','ListPics','ItemsInList','NumLists','CorrectionProcedure','ex1','ex2','ex3','ListType','PortPressed','CorrectPort','PicturePressed','Chamber','TrialsPerSession','TO','ITI','Label','Ports','Used','v1','v2','v3','v4','v5','v6','v7','v8','v9','v10','v11','v12','v13','v14','v15'))
#                   quote = "\"'",as.is = !stringsAsFactors,
#                   na.strings = "NA", colClasses = NA, nrows = -1,
#                   skip = 0, check.names = TRUE, fill = !blank.lines.skip,
#                   strip.white = FALSE, blank.lines.skip = TRUE,
#                   comment.char = "#",
#                   allowEscapes = FALSE, flush = FALSE,
#                   stringsAsFactors = default.stringsAsFactors(),
#                   fileEncoding = "", encoding = "unknown", text)


augRaw = ldply(list(
  read.table("SCrawdata/SimChain.Augustus.3%3A10%3A11", header=FALSE, skip=1, sep="\t",col.names=tabletop),
  read.table("SCrawdata/SimChain.Augustus.3%3A11%3A11", header=FALSE, skip=1, sep="\t",col.names=tabletop),
  read.table("SCrawdata/SimChain.Augustus.3%3A15%3A11", header=FALSE, skip=2, sep="\t", col.names=tabletop),
  read.table("SCrawdata/SimChain.Augustus.3%3A16%3A11", header=FALSE, skip=1, sep="\t", col.names=tabletop),
  read.table("SCrawdata/SimChain.Augustus.3%3A17%3A11", header=FALSE, skip=1, sep="\t", col.names=tabletop),
  read.table("SCrawdata/SimChain.Augustus.3%3A18%3A11", header=FALSE, skip=1, sep="\t", col.names=tabletop),
  read.table("SCrawdata/SimChain.Augustus.3%3A21%3A11", header=FALSE, skip=1, sep="\t", col.names=tabletop),
  read.table("SCrawdata/SimChain.Augustus.3%3A22%3A11", header=FALSE, skip=1, sep="\t", col.names=tabletop),
  read.table("SCrawdata/SimChain.Augustus.3%3A23%3A11.1", header=FALSE, skip=1, sep="\t", col.names=tabletop),
  read.table("SCrawdata/SimChain.Augustus.3%3A24%3A11", header=FALSE, skip=1, sep="\t", col.names=tabletop),
  read.table("SCrawdata/SimChain.Augustus.3%3A25%3A11", header=FALSE, skip=1, sep="\t", col.names=tabletop),
  read.table("SCrawdata/SimChain.Augustus.3%3A29%3A11", header=FALSE, skip=1, sep="\t", col.names=tabletop),
  read.table("SCrawdata/SimChain.Augustus.3%3A30%3A11", header=FALSE, skip=1, sep="\t", col.names=tabletop),
  read.table("SCrawdata/SimChain.Augustus.3%3A31%3A11", header=FALSE, skip=1, sep="\t", col.names=tabletop),
  read.table("SCrawdata/SimChain.Augustus.4%3A1%3A11", header=FALSE, skip=1, sep="\t", col.names=tabletop),
  read.table("SCrawdata/SimChain.Augustus.4%3A11%3A11", header=FALSE, skip=1, sep="\t", col.names=tabletop),
  read.table("SCrawdata/SimChain.Augustus.4%3A4%3A11", header=FALSE, skip=1, sep="\t", col.names=tabletop),
  read.table("SCrawdata/SimChain.Augustus.4%3A5%3A11", header=FALSE, skip=1, sep="\t", col.names=tabletop),
  read.table("SCrawdata/SimChain.Augustus.4%3A6%3A11", header=FALSE, skip=1, sep="\t", col.names=tabletop),
  read.table("SCrawdata/SimChain.Augustus.4%3A7%3A11", header=FALSE, skip=1, sep="\t", col.names=tabletop),
  read.table("SCrawdata/SimChain.Augustus.4%3A8%3A11", header=FALSE, skip=1, sep="\t", col.names=tabletop)
      ))

coltRaw = ldply(list(
  read.table("SCrawdata//SimChain.Coltrane.2%3A15%3A11.1", header=FALSE, skip=1, sep="\t",col.names=tabletop),
  read.table("SCrawdata//SimChain.Coltrane.2%3A16%3A11.1", header=FALSE, skip=1, sep="\t",col.names=tabletop),
  read.table("SCrawdata//SimChain.Coltrane.2%3A17%3A11.1", header=FALSE, skip=1, sep="\t",col.names=tabletop),
  read.table("SCrawdata//SimChain.Coltrane.2%3A18%3A11.1", header=FALSE, skip=1, sep="\t",col.names=tabletop),
  read.table("SCrawdata//SimChain.Coltrane.2%3A22%3A11.1", header=FALSE, skip=1, sep="\t",col.names=tabletop),
  read.table("SCrawdata//SimChain.Coltrane.2%3A23%3A11.1", header=FALSE, skip=1, sep="\t",col.names=tabletop),
  read.table("SCrawdata//SimChain.Coltrane.2%3A24%3A11.1", header=FALSE, skip=1, sep="\t",col.names=tabletop),
  read.table("SCrawdata//SimChain.Coltrane.2%3A25%3A11.1", header=FALSE, skip=1, sep="\t",col.names=tabletop),
  read.table("SCrawdata//SimChain.Coltrane.2%3A28%3A11", header=FALSE, skip=1, sep="\t",col.names=tabletop),
  read.table("SCrawdata//SimChain.Coltrane.3%3A1%3A11", header=FALSE, skip=1, sep="\t",col.names=tabletop),
  read.table("SCrawdata//SimChain.Coltrane.3%3A10%3A11", header=FALSE, skip=1, sep="\t",col.names=tabletop),
  read.table("SCrawdata//SimChain.Coltrane.3%3A11%3A11", header=FALSE, skip=1, sep="\t",col.names=tabletop),
  read.table("SCrawdata//SimChain.Coltrane.3%3A15%3A11", header=FALSE, skip=1, sep="\t",col.names=tabletop),
  read.table("SCrawdata//SimChain.Coltrane.3%3A16%3A11", header=FALSE, skip=1, sep="\t",col.names=tabletop),
  read.table("SCrawdata//SimChain.Coltrane.3%3A17%3A11", header=FALSE, skip=1, sep="\t",col.names=tabletop),
  read.table("SCrawdata//SimChain.Coltrane.3%3A18%3A11", header=FALSE, skip=1, sep="\t",col.names=tabletop),
  read.table("SCrawdata//SimChain.Coltrane.3%3A2%3A11", header=FALSE, skip=1, sep="\t",col.names=tabletop),
  read.table("SCrawdata//SimChain.Coltrane.3%3A21%3A11", header=FALSE, skip=1, sep="\t",col.names=tabletop),
#  read.table("SCrawdata//SimChain.Coltrane.3%3A22%3A11", header=FALSE, skip=1, sep="\t",col.names=tabletop),
  read.table("SCrawdata//SimChain.Coltrane.3%3A3%3A11.1", header=FALSE, skip=1, sep="\t",col.names=tabletop),
  read.table("SCrawdata//SimChain.Coltrane.3%3A7%3A11", header=FALSE, skip=1, sep="\t",col.names=tabletop)
    
  ))

lashRaw = ldply(list(
  read.table("SCrawdata//SimChain.Lashley.1%3A26%3A11", header=FALSE, skip=1, sep="\t",col.names=tabletop),
  read.table("SCrawdata//SimChain.Lashley.1%3A27%3A11", header=FALSE, skip=1, sep="\t",col.names=tabletop),
  read.table("SCrawdata//SimChain.Lashley.1%3A28%3A11", header=FALSE, skip=1, sep="\t",col.names=tabletop),
  read.table("SCrawdata//SimChain.Lashley.1%3A31%3A11", header=FALSE, skip=1, sep="\t",col.names=tabletop),
  read.table("SCrawdata//SimChain.Lashley.12%3A10%3A10", header=FALSE, skip=1, sep="\t",col.names=tabletop[-31:-46]),
  read.table("SCrawdata//SimChain.Lashley.12%3A14%3A10", header=FALSE, skip=1, sep="\t",col.names=tabletop[-31:-46]),
  read.table("SCrawdata//SimChain.Lashley.12%3A15%3A10", header=FALSE, skip=1, sep="\t",col.names=tabletop[-31:-46]),
  read.table("SCrawdata//SimChain.Lashley.12%3A16%3A10", header=FALSE, skip=1, sep="\t",col.names=tabletop[-31:-46]),
  read.table("SCrawdata//SimChain.Lashley.12%3A17%3A10", header=FALSE, skip=1, sep="\t",col.names=tabletop[-31:-46]),
  read.table("SCrawdata//SimChain.Lashley.12%3A6%3A10", header=FALSE, skip=1, sep="\t",col.names=tabletop[-31:-46]),
  read.table("SCrawdata//SimChain.Lashley.12%3A7%3A10", header=FALSE, skip=1, sep="\t",col.names=tabletop[-31:-46]),
  read.table("SCrawdata//SimChain.Lashley.12%3A8%3A10", header=FALSE, skip=1, sep="\t",col.names=tabletop[-31:-46]),
  read.table("SCrawdata//SimChain.Lashley.12%3A9%3A10", header=FALSE, skip=1, sep="\t",col.names=tabletop[-31:-46]),
  read.table("SCrawdata//SimChain.Lashley.2%3A9%3A11", header=FALSE, skip=1, sep="\t",col.names=tabletop),
  read.table("SCrawdata//SimChain.Lashley.2%3A7%3A11", header=FALSE, skip=1, sep="\t",col.names=tabletop),
  read.table("SCrawdata//SimChain.Lashley.2%3A4%3A11", header=FALSE, skip=1, sep="\t",col.names=tabletop),
  read.table("SCrawdata//SimChain.Lashley.2%3A3%3A11", header=FALSE, skip=1, sep="\t",col.names=tabletop),
  read.table("SCrawdata//SimChain.Lashley.2%3A2%3A11", header=FALSE, skip=1, sep="\t",col.names=tabletop),
  read.table("SCrawdata//SimChain.Lashley.2%3A10%3A11", header=FALSE, skip=1, sep="\t",col.names=tabletop),
  read.table("SCrawdata//SimChain.Lashley.2%3A1%3A11", header=FALSE, skip=1, sep="\t",col.names=tabletop)

))

lashRaw <- lashRaw[,1:16]


# saliency
ssIn = read.csv("ecoSaliencySizeNew.csv", header = TRUE)

sizeSal <- NULL

## building the matrix
# accuracy ~ subject, trial, saliency, category


# Coltrane
sal <- NULL
size <- NULL

# subj, trial, correctItem, accuracy
sal <- coltRaw[c(1,4,6,8)]

l <-list('A','B','C','D')
for (i in 1:dim(coltRaw)[1]){
  picsIndex <- which(l == coltRaw[i,6])
  picsList <- coltRaw[i,14]
  #size=c(size,ssIn[ssIn$imageName==strsplit(as.character(picsList),' ')[[1]][picsIndex],c(2,3)])
  size=rbind(size,cbind(ssIn[ssIn$imageName==strsplit(as.character(picsList),' ')[[1]][picsIndex],2],ssIn[ssIn$imageName==strsplit(as.character(picsList),' ')[[1]][picsIndex],3]))
  
    
}
sizeSal <- cbind(sal,size)


# Augustus
sal <- NULL
size <- NULL

# subj, trial, correctItem, accuracy
sal <- augRaw[c(1,4,6,8)]

l <-list('A','B','C','D')
for (i in 1:dim(augRaw)[1]){
  picsIndex <- which(l == augRaw[i,6])
  picsList <- augRaw[i,14]
  #size=c(size,ssIn[ssIn$imageName==strsplit(as.character(picsList),' ')[[1]][picsIndex],c(2,3)])
  size=rbind(size,cbind(ssIn[ssIn$imageName==strsplit(as.character(picsList),' ')[[1]][picsIndex],2],ssIn[ssIn$imageName==strsplit(as.character(picsList),' ')[[1]][picsIndex],3]))
  
}
sizeSal <- rbind(sizeSal,cbind(sal,size))


# Lashley
sal <- NULL
size <- NULL

# subj, trial, correctItem, accuracy
sal <- lashRaw[c(1,4,6,8)]

l <-list('A','B','C','D')
for (i in 1:dim(lashRaw)[1]){
  picsIndex <- which(l == lashRaw[i,6])
  picsList <- lashRaw[i,14]
  size=rbind(size,cbind(ssIn[ssIn$imageName==strsplit(as.character(picsList),' ')[[1]][picsIndex],2],ssIn[ssIn$imageName==strsplit(as.character(picsList),' ')[[1]][picsIndex],3]))
  
}
sizeSal <- rbind(sizeSal,cbind(sal,size))


library(lme4)
library(car)
#           accuracy        trial         saliency           subject                            category
model <- lmer(sizeSal[,4] ~ sizeSal[,2] + sizeSal[,5] + (1 | sizeSal[,1]) + (1 + sizeSal[,5] | sizeSal[,6]))

#model2 <- lmer(sizeSal[,4] ~ sizeSal[,2] + sizeSal[,5] + (1 | sizeSal[,1]) + (sizeSal[,5] | sizeSal[,6]))
# model2 <- lmer(sizeSal[,4] ~ sizeSal[,2] + sizeSal[,5] + (1 | sizeSal[,1]) + (1 | sizeSal[,6]))
# 
# 
# model3 <- lmer(1 + sizeSal[,4] ~ sizeSal[,2] + sizeSal[,5] + (1 | sizeSal[,1] / sizeSal[,6])
#                #+ (sizeSal[,5] | sizeSal[,6])
#                )
# 
# 
# model4 <- lmer(sizeSal[,4] ~ sizeSal[,5] + (sizeSal[,5] | sizeSal[,6]))
# 
# model5 <- lmer(sizeSal[,4] ~ sizeSal[,2] + sizeSal[,5] + sizeSal[,6] + (1 | sizeSal[,1]))
  


#library(afex)
# mixed(sizeSal[,4] ~ sizeSal[,2] + sizeSal[,5] + (1 | sizeSal[,1]) + (1 + sizeSal[,5] | sizeSal[,6])
#       ,data = sizeSal
#       )


### glmer for using logit family link function

#           accuracy        trial         saliency           subject                            category
godel <- glmer(sizeSal[,4] ~ sizeSal[,2] + sizeSal[,5] + (1 | sizeSal[,1]) + (1 + sizeSal[,5] | sizeSal[,6])
              , family = 'binomial'
              )
#rodeo <- lmer(sizeSal[,4] ~ sizeSal[,2] + sizeSal[,5] + (1 | sizeSal[,1]) + (1 + sizeSal[,5] | sizeSal[,6]))

godel2 <- glmer(sizeSal[,4] ~ sizeSal[,2] + sizeSal[,5] + (1 + sizeSal[,2]| sizeSal[,1]) + (1 + sizeSal[,5] | sizeSal[,6])
               , family = 'binomial'
)

godel3 <- glmer(sizeSal[,4] ~ sizeSal[,5] + (1 | sizeSal[,1]) + (1 + sizeSal[,5] | sizeSal[,6])
, family = 'binomial'
)
