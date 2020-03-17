############
#R Script for Suessenbach et al. Study 5

#Packages needed for this R script
library(lme4)
library(psych)

#Read in dataframe
data5 <- read.csv(file = "sample2.csv", header = T)
names(data5)

#Add effect-coding sex variable
data5$sex <- ifelse(data5$gender == "male",-.5,.5)

#Correlation matrix of all measures
c1 <- corr.test(data5[c("dominance6","prestige6","leadership6","DG1","DG2")])
c1
round(c1$p,3)

#For males
cm <- corr.test(data5[data5$gender == "male",c("DG1","DG2")],
                data5[data5$gender == "male",c("dominance6","prestige6", "leadership6")])
cm

#For females
cf <- corr.test(data5[data5$gender == "female",c("DG1","DG2")],
                data5[data5$gender == "female",c("dominance6","prestige6", "leadership6")])
cf


#Descriptive statistics
describe(data5)



####
#Analyse main effects with gender interaction in neutral condition

#DG online
m1 <- lm(scale(DG1) ~ scale(dominance6)*sex + scale(prestige6)*sex + scale(leadership6)*sex, data = data5 )
summary(m1)


###
#Adjust data for multilevel model

data5.1 <- data5

data5.2 <- rbind(data5.1,data5.1)
nrow(data5.2)
data5.2$DG <- c(data5.1$DG1,data5.1$DG2) #money given in both condition saved in one variable
data5.2$condition <- c(rep(-.5,nrow(data5.1)),rep(.5,nrow(data5.1)))
data5.2$Subject <- as.factor(rep(c(seq(1:nrow(data5.1))),2))

head(data5.2)


####
#Analyse effect of arousal condition with main effects and gender interaction

#pre-registered model without random correlations. 
m2 <- lmer(scale(DG) ~  sex + sex:condition + scale(dominance6)*condition + scale(dominance6):sex + 
             scale(leadership6) + scale(leadership6):sex + scale(leadership6):condition + scale(prestige6) + 
             scale(prestige6):sex + scale(prestige6):condition + condition + (1 + condition || Subject), data = data5.2)
summary(m2)

