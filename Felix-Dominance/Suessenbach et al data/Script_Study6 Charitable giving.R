############
#R Script for Suessenbach et al. Study 6

#Packages needed for this R script
library(psych)
library(BayesFactor)
library(MCMCpack)

#Read in dataframe
data8 <- read.csv(file = "sample5.csv", header = T)

#Descriptive statistics
describe(data8)


###
#Correlation matrix

c1 <- corr.test(data8[c("dominance6","prestige6", "leadership6","percentage")])
c1

round(c1$p,3)

#For males
cm <- corr.test(data8[data8$gender == "male",c("dominance6","prestige6", "leadership6","percentage")])
cm

cf <- corr.test(data8[data8$gender == "female",c("dominance6","prestige6", "leadership6","percentage")])
cf


#Safe variables as standardised for Bayesian Analysis
data8$percentage_s <- scale(data8$percentage)
data8$dominance6_s <- scale(data8$dominance6)
data8$prestige6_s <- scale(data8$prestige6)
data8$leadership6_s <- scale(data8$leadership6)



##############
#DV1: Total amount donated


#Create Bayesian model. All DoPL motives
BF1 <- regressionBF(percentage_s ~ 1 + dominance6_s + prestige6_s + leadership6_s, data = data8)
BF1

#Investigate posterior distribution
post <- posterior(BF1, index = 7, iterations=100000)
summary(post)


#Zero-order effect of dominance
BF2 <- regressionBF(percentage_s ~ 1 + dominance6_s, data = data8)
BF2

#Investigate posterior distribution
post <- posterior(BF2, index = 1, iterations=100000)
summary(post)


#Zero-order effect of prestige
BF3 <- regressionBF(percentage_s ~ 1 + prestige6_s, data = data8)
BF3

#Investigate posterior distribution
post <- posterior(BF3, index = 1, iterations=100000)
summary(post)


#Zero-order effect of leadership
BF4 <- regressionBF(percentage_s ~ 1 + leadership6_s, data = data8)
BF4

#Investigate posterior distribution
post <- posterior(BF4, index = 1, iterations=100000)
summary(post)




##############
#DV2: Probability to donate

#Create binomial variable for donating decision
data8$donate <- ifelse(data8$percentage > 0,1,0)
table(data8$donate)

mc1 <- MCMClogit(donate ~ scale(dominance6) + scale(prestige6) + scale(leadership6), data = data8)
summary(mc1)

mc2 <- MCMClogit(donate ~ scale(dominance6) , data = data8)
summary(mc2)

mc3 <- MCMClogit(donate ~ scale(prestige6) , data = data8)
summary(mc3)

mc4 <- MCMClogit(donate ~ scale(leadership6) , data = data8)
summary(mc4)



##############
#DV3: Amount donated in subsample of donors

#Subset dataframe for donators
data8$donate <- ifelse(data8$percentage > 0,1,0)
data_donators <- data8[data8$donate == 1,]
nrow(data_donators)

#Scale DoPL motives (BayesFactor package cannot handle scale() function)
data_donators$percentage_s <- scale(data_donators$percentage)
data_donators$dominance6_s <- scale(data_donators$dominance6)
data_donators$prestige6_s <- scale(data_donators$prestige6)
data_donators$leadership6_s <- scale(data_donators$leadership6)

#Create Bayesian model. All DoPL motives
BF1 <- regressionBF(percentage_s ~ 1 + dominance6_s + prestige6_s + leadership6_s, data = data_donators)
BF1

#Investigate posterior distribution
post <- posterior(BF1, index = 7, iterations=100000)
summary(post)


#Create Bayesian model. Dominance
BF2 <- regressionBF(percentage_s ~ 1 + dominance6_s, data = data_donators)
BF2

#Investigate posterior distribution
post <- posterior(BF2, index = 1, iterations=100000)
summary(post)


#Create Bayesian model. Prestige
BF3 <- regressionBF(percentage_s ~ 1 + prestige6_s, data = data_donators)
BF3

#Investigate posterior distribution
post <- posterior(BF3, index = 1, iterations=100000)
summary(post)


#Create Bayesian model. Leadership
BF4 <- regressionBF(percentage_s ~ 1 + leadership6_s, data = data_donators)
BF4

#Investigate posterior distribution
post <- posterior(BF4, index = 1, iterations=100000)
summary(post)
