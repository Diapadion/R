############
#R Script for Suessenbach et al. Study SX3 of supplementary material

#Packages needed for this R script
library(psych)


#Read in dataframe
data3 <- read.csv(file = "sample1.csv", header = T)

names(data3)


#############
#Exclusion of participants

#Excluding participants that have wrongly answered to both of our catch questions. This is the default and so reported in the manuscript
data3 <- data3[data3$catch1 == "keep" & data3$catch2 == "keep",]

#To keep all participants who answered wrongly to catch question 1 please do not execute line #19
#but remove the hashtag at the beginning of line #25 and execute line #25 
#data3 <- data3[data3$catch2 == "keep",]

#To keep all participants who answered wrongly to catch question 2 please do not execute line #19
#but remove the hashtag at the beginning of line #29 and execute line #29 
#data3 <- data3[data3$catch1 == "keep",]

#To keep all participants who answered wrongly to catch question 1 & 2 please do not execute line #19 and continue this
#script from this point onwards



################
#EFA



#Variable containing index number for focal items: total

total <- c(1,3,5,6,8,10,12,13,16,17,19,20,23,25,26,29,30,32,
           33,34,36,37,39,40,42,43,45,46,47,50,52,53,54,56,58,60,
           61,64,66,69,71,77,83)

#names(data3[total])


#Three factor FA with all focal items
fa.3 = fa(data3[,total], nfactors=3, rotate="promax", fm="pa") 
print(fa.3$loadings, sort= TRUE, cutoff=.25)




#Indexes for 10-item scale
total2 <- c(5,8,25,34,36,47,50,56,58,66,
            6,17,19,23,26,30,39,45,69,77,
            3,10,13,16,20,32,33,42,54,71)

#Three factor FA on 10-item scales
fa.3t = fa(data3[,total2], nfactors=3, rotate="promax", fm="pa") 
print(fa.3t$loadings, sort= TRUE, cutoff=.25)



#Post-hoc parallel analysis and MAP test
vss(data3[,total2]) # Map suggests 3 factors. 

fa.parallel(data3[,total2]) #PA suggests 3 components.

