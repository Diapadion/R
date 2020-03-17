############
#R Script for Suessenbach et al. Study 1

#Packages needed for this R script
library(psych)
library(rsq)
library(lavaan)
library(semTools)
library(sirt)
library(semPlot)
library(lsr)


#Read in dataframe
data3 <- read.csv(file = "./Suessenbach et al data/sample1.csv", header = T)

#names(data3)


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



#################
#Cronbach's alpha for final DoPL scales on basis of Study 3's data. 10-item, 6-item, 4-item:

#Indexes for long and short final DoPL scales
dom10 <- c(3,10,13,16,20,32,33,42,54,71)
dom6 <- c(13,16,20,32,33,54)
dom4 <- c(13,20,33,32)
#leadership
lea10 <- c(5,8,25,34,36,47,50,56,58,66)
lea6 <- c(5,34,25,47,50,58)
lea4 <- c(25,34,58,5)
#prestige
pre10 <- c(6,17,19,23,26,30,39,45,69,77)
pre6 <- c(26,30,45,69,77,23)
pre4 <- c(45,69,77,26)


#Dominance
alpha(data3[dom10])
alpha(data3[dom6])
alpha(data3[dom4])

#Prestige
alpha(data3[pre10])
alpha(data3[pre6])
alpha(data3[pre4])

#Leadership
alpha(data3[lea10])
alpha(data3[lea6])
alpha(data3[lea4])



####
#Cronbach's alpha for validation scales

names(data3)
#verbal aggression
alpha(data3[c(129,132,136,137,139)])

#anger
alpha(data3[c(130,131,133,134,135,138,140)])

#altruism
alpha(data3[c(141:153)])

#agreeableness
alpha(data3[c(86,88,90,91,93,95,97,99,101)])

#Extraversion
alpha(data3[c(92,96)])

#Conscientiousness
alpha(data3[c(94,98)])

#openness
alpha(data3[c(89,102)])

#Neuroticism
alpha(data3[c(87,100)])

#SDO
alpha(data3[c(121:128)])

#NARQ_A
alpha(data3[c(103,106,108,110,112,114,115,117,119)])

#NARQ_R
alpha(data3[c(104,105,107,109,111,113,116,118,120)])

#Power motive
alpha(data3[c(15,27,67,68,79,81,16,61,25,34,83)])

#affiliation motive
alpha(data3[c(7,9,11,18,24,28,41,55,73,74)])
#intimacy motive
alpha(data3[c(14,31,35,38,44,48,59,82,84,85)])
#achievement motive
alpha(data3[c(2,22,63,65,70,72,75,76,78,80)])
#fear of losing control
alpha(data3[c(4,21,57)])
#fear of losing reputation
alpha(data3[c(49,62)])





#######
#Scores for DoPL scales


for(i in 1:nrow(data3)){
  data3$dominance10[i] <- sum(data3[i,c(dom10)])
  data3$prestige10[i] <- sum(data3[i,c(pre10)])
  data3$leadership10[i] <- sum(data3[i,c(lea10)])
  data3$dominance6[i] <- sum(data3[i,c(dom6)])
  data3$prestige6[i] <- sum(data3[i,c(pre6)])
  data3$leadership6[i] <- sum(data3[i,c(lea6)])
  data3$dominance4[i] <- sum(data3[i,c(dom4)])
  data3$prestige4[i] <- sum(data3[i,c(pre4)])
  data3$leadership4[i] <- sum(data3[i,c(lea4)])
  }


#################
#Histograms for DoPL scales

par(mfrow=c(3,3))

hist(data3$dominance10, xlab = "", main = "10-item dominance")
hist(data3$prestige10, xlab = "", main = "10-item prestige")
hist(data3$leadership10, xlab = "", main = "10-item leadership")

hist(data3$dominance6, xlab = "", main = "6-item dominance")
hist(data3$prestige6, xlab = "", main = "6-item prestige")
hist(data3$leadership6, xlab = "", main = "6-item leadership")

hist(data3$dominance4, xlab = "", main = "4-item dominance")
hist(data3$prestige4, xlab = "", main = "4-item prestige")
hist(data3$leadership4, xlab = "", main = "4-item leadership")

par(mfrow=c(1,1))


#######
#Correlations among different lengths of DoPL scales
c1 <- corr.test(data3[c("dominance10","prestige10", "leadership10",
                           "dominance6","prestige6", "leadership6",
                           "dominance4","prestige4", "leadership4")])
c1

#Correlations for males
cm <- corr.test(data3[data3$gender == "male",
                      c("dominance10","prestige10", "leadership10",
                        "dominance6","prestige6", "leadership6",
                        "dominance4","prestige4", "leadership4")])
cm

#Correlations for females
cf <- corr.test(data3[data3$gender == "female",
                      c("dominance10","prestige10", "leadership10",
                        "dominance6","prestige6", "leadership6",
                        "dominance4","prestige4", "leadership4")])
cf


###############
#T-tests for gender differences
t.test(dominance10 ~ gender, data= data3) 
cohensD(dominance10 ~ gender, data = data3)
t.test(prestige10 ~ gender, data= data3)
cohensD(prestige10 ~ gender, data = data3)
t.test(leadership10 ~ gender, data= data3)
cohensD(leadership10 ~ gender, data = data3)

t.test(dominance6 ~ gender, data= data3)
cohensD(dominance6 ~ gender, data = data3)
t.test(prestige6 ~ gender, data= data3)
cohensD(prestige6 ~ gender, data = data3)
t.test(leadership6 ~ gender, data= data3)
cohensD(leadership6 ~ gender, data = data3)

t.test(dominance4 ~ gender, data= data3)
cohensD(dominance4 ~ gender, data = data3)
t.test(prestige4 ~ gender, data= data3)
cohensD(prestige4 ~ gender, data = data3)
t.test(leadership4 ~ gender, data= data3)
cohensD(leadership4 ~ gender, data = data3)




#####
#Abbreviate item names for CFA

datpow <- data3[,c(1:155,184,185,165,166)]
datpow2 <- datpow

for(i in 1:length(colnames(datpow))){
  y <- colnames(datpow)[i]
  x <- unlist(strsplit(y,split = "[.]"))[1]
  
  colnames(datpow2)[i] <- x
}


####
#Confirmatory factor analysis

#10 item model
model <- ' 
# latent variable definitions
Dom  =~ X13 + X3 + X10 + X16 + X20 + X32 + X33 + X42 + X54 + X71
Pres =~ X26 + X6 + X17 + X19 + X23 + X30 + X39 + X45 + X69 + X77
Lead =~ X5 + X8 + X25 + X34 + X36 + X47 + X50 + X56 + X58 + X66

'

cfa1 <- cfa(model, data=datpow2, )

fitMeasures(cfa1, c("chisq", "df", "pvalue", "cfi", "rmsea", 'srmr'))
summary(cfa1, fit.measures = TRUE)


#6 item model

model2 <- ' 
# latent variable definitions
Dom  =~ X13 + X20 + X32 + X33 + X54 + X16
Pres =~ X26 + X30 + X45 + X69 + X77 + X23
Lead =~ X5 + X25 + X34 + X47 + X50 + X58
'

cfa2 <- cfa(model2, data=datpow2, )

fitMeasures(cfa2, c("chisq", "df", "pvalue", "cfi", "rmsea", 'srmr'))
summary(cfa2, fit.measures = TRUE)




#4 item model

model3 <- ' 
# latent variable definitions
Dom  =~ X13 + X20 + X32 + X33
Pres =~ X26 + X45 + X69 + X77
Lead =~ X5 + X25 + X34  + X58 

'

cfa3 <- cfa(model3, data=datpow2, )

fitMeasures(cfa3, c("chisq", "df", "pvalue", "cfi", "rmsea", 'srmr'))
summary(cfa3, fit.measures = TRUE)



####
#Two factor models

#Combining dominance & prestige
model <- ' 
# latent variable definitions
Dom  =~ X13 + X20 + X32 + X33 + X54 + X16 + X26 + X30 + X45 + X69 + X77 + X23
Lead =~ X5 + X25 + X34 + X47 + X50 + X58
'
cfaDP <- cfa(model, data=datpow2, )

fitMeasures(cfaDP, c("chisq", "df", "pvalue", "cfi", "rmsea", 'srmr'))
summary(cfaDP, fit.measures = TRUE)


#Combining prestige & leadership
model <- ' 
# latent variable definitions
Dom  =~ X13 + X20 + X32 + X33 + X54 + X16
Pres =~ X26 + X30 + X45 + X69 + X77 + X23 + X5 + X25 + X34 + X47 + X50 + X58
'
cfaPL <- cfa(model, data=datpow2, )

fitMeasures(cfaPL, c("chisq", "df", "pvalue", "cfi", "rmsea", 'srmr'))
summary(cfaPL, fit.measures = TRUE)


#Combining dominance & prestige
model <- ' 
# latent variable definitions
Dom  =~ X13 + X20 + X32 + X33 + X54 + X16 + X26 + X30 + X45 + X69 + X77 + X23
Lead =~ X5 + X25 + X34 + X47 + X50 + X58
'
cfaDL <- cfa(model, data=datpow2, )

fitMeasures(cfaDL, c("chisq", "df", "pvalue", "cfi", "rmsea", 'srmr'))
summary(cfaDL, fit.measures = TRUE)


###
#One factor solution

model <- ' 
# latent variable definitions
General =~ X13 + X20 + X32 + X33 + X54 + X16 + X26 + X30 + X45 + X69 + X77 + X23 + X5 + X25 + X34 + X47 + X50 + X58
'

cfaONE <- cfa(model, data=datpow2, )

fitMeasures(cfaONE, c("chisq", "df", "pvalue", "cfi", "rmsea", 'srmr'))
summary(cfaONE, fit.measures = TRUE)


###
#Bi-factor model with DoPL motives + General Factor

model <- ' 
# latent variable definitions
Dom  =~ X13 + X20 + X32 + X33 + X54 + X16
Pres =~ X26 + X30 + X45 + X69 + X77 + X23
Lead =~ X5 + X25 + X34 + X47 + X50 + X58

General =~ X13 + X20 + X32 + X33 + X54 + X16 + X26 + X30 + X45 + X69 + X77 + X23 + X5 + X25 + X34 + X47 + X50 + X58  

#Remove covariances among latent variables
Dom ~~ 0*Pres
Dom ~~ 0*Lead
Dom ~~ 0*General

Pres ~~ 0*Lead
Pres ~~ 0*General

Lead ~~ 0*General
'

cfaBI <- cfa(model, data=datpow2, )

fitMeasures(cfaBI, c("chisq", "df", "pvalue", "cfi", "rmsea", 'srmr'))
summary(cfaBI, fit.measures = TRUE)
semPaths(cfaBI, what="par") 


###
#Bi-factor model with DoPL motives + General Factor + UMS achievement, affiliation & intimacy

model <- ' 
# latent variable definitions
Dom  =~ X13 + X20 + X32 + X33 + X54 + X16
Pres =~ X26 + X30 + X45 + X69 + X77 + X23
Lead =~ X5 + X25 + X34 + X47 + X50 + X58
Ach  =~ X2 + X22 + X63 + X65 + X70 + X72 + X75 + X76 + X78 + X80
Aff  =~ X7 + X9 + X11 + X18 + X24 + X28 + X41 + X55 + X73 + X74
Int  =~ X14 + X31 + X35 + X38 + X44 + X48 + X59 + X82 + X84 + X85

General =~ X13 + X20 + X32 + X33 + X54 + X16 + X26 + X30 + X45 + X69 + X77 + X23 + X5 + X25 + X34 + X47 + X50 + X58 +
X2 + X22 + X63 + X65 + X70 + X72 + X75 + X76 + X78 + X80 +
X7 + X9 + X11 + X18 + X24 + X28 + X41 + X55 + X73 + X74 +
X14 + X31 + X35 + X38 + X44 + X48 + X59 + X82 + X84 + X85

#Remove covariances among latent variables
Dom ~~ 0*Pres
Dom ~~ 0*Lead
Dom ~~ 0*Ach
Dom ~~ 0*Aff
Dom ~~ 0*Int
Dom ~~ 0*General

Pres ~~ 0*Lead
Pres ~~ 0*Ach
Pres ~~ 0*Aff
Pres ~~ 0*Int
Pres ~~ 0*General

Lead ~~ 0*Ach
Lead ~~ 0*Aff
Lead ~~ 0*Int
Lead ~~ 0*General

Ach ~~ 0*Aff
Ach ~~ 0*Int
Ach ~~ 0*General

Aff ~~ 0*Int
Aff ~~ 0*General

Int ~~ 0*General
'

cfaUMS <- cfa(model, data=datpow2, )

fitMeasures(cfaUMS, c("chisq", "df", "pvalue", "cfi", "rmsea", 'srmr'))
summary(cfaUMS, fit.measures = TRUE)




#Compare all models
com <- compareFit(cfa1,cfa2,cfa3,cfaDP,cfaPL,cfaDL,cfaBI,cfaONE,cfaUMS)
summary(com)



####
#Indices comparing bi-factor model to model with only specific factors

#Subset dataframe to 6 item scale items
datpow3 <- datpow2[,c("X13","X20","X32","X33","X54","X16","X26","X30","X45","X69","X77","X23","X5","X25","X34","X47","X50","X58")]

#Explained common variance (ECV) and omegas
omega(datpow3, nfactors = 3)
#Result: ECV for general factor is smaller than ECV for individual scales
#Total omega is bigger than omegas for 2 out 3 DoPL scales.

#Worst split-half reliability: Beta
betas <- iclust(datpow3, nclusters = 3)
betas2 <- iclust(datpow3, nclusters = 1)

summary(betas) 
summary(betas2) 
#Result: The worst split-half reliabilities are better when assuming 3 clusters as compared to one cluster. 
#compare Original Beta index.

prmse.subscores.scales(datpow3, subscale = c(rep("A",6),rep("B",6),rep("C",6)))
#Subscale scores prmse.X are always higher than total scores prmse.Z. Hence subscale scores should be used.



