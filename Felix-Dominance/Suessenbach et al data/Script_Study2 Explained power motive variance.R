############
#R Script for Suessenbach et al. Study 2

#Packages needed for this R script
library(psych)
library(yhat)


#Read in dataframe
data3 <- read.csv(file = "sample1.csv", header = T)
data5 <- read.csv(file = "sample2.csv", header = T)


####
#Merge datasets and exclude irrelevant variables
names(data3)
names(data5)

data3$soc_reg <- NA
data3$PRF_dominance <- NA

data_full <- rbind(data3[,c("dominance10","prestige10","leadership10","dominance6","prestige6","leadership6",
                            "dominance4","prestige4","leadership4","power","PRF_dominance","soc_reg")],
                   data5[,c("dominance10","prestige10","leadership10","dominance6","prestige6","leadership6",
                            "dominance4","prestige4","leadership4","power","PRF_dominance","soc_reg")])


#Correlation matrix & descriptives
c1 <- corr.test(data_full[c("dominance6","prestige6","leadership6","power","PRF_dominance","soc_reg")])
describe(data_full)


#Analysis regarding explained variance. Commonality analysis

c1 <- lm(power ~ dominance6 + prestige6 + leadership6, data = data_full)
summary(c1)

c2 <- lm(PRF_dominance ~ dominance6 + prestige6 + leadership6, data = data_full)
summary(c2)

com <- commonalityCoefficients(data_full, "power",list("dominance6","prestige6","leadership6"))
com

com2 <- commonalityCoefficients(data_full, "PRF_dominance",list("dominance6","prestige6","leadership6"))
com2
