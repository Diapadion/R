############
#R Script for Suessenbach et al. Study 4

#Packages needed for this R script
library(psych)


#Read in dataframe
data6 <- read.csv(file = "sample3.csv", header = T)
data6$sample <- "sample 3"

data7 <- read.csv(file = "sample4.csv", header = T)
data7$sample <- "sample 4"

data8 <- read.csv(file = "sample5.csv", header = T)
data8$sample <- "sample 5"


####
#Subset dataframes for all necessary variables and combine them

data_moral <- rbind(data6[c("dominance6","prestige6","leadership6","sample","gender",
                            "MFQ_harm_s","MFQ_fair_s","MFQ_ingroup_s","MFQ_authority_s","MFQ_purity_s")],
                    data7[c("dominance6","prestige6","leadership6","sample","gender",
                            "MFQ_harm_s","MFQ_fair_s","MFQ_ingroup_s","MFQ_authority_s","MFQ_purity_s")],
                    data8[c("dominance6","prestige6","leadership6","sample","gender",
                            "MFQ_harm_s","MFQ_fair_s","MFQ_ingroup_s","MFQ_authority_s","MFQ_purity_s")])

###
#Correlation matrix

c1 <- corr.test(data_moral[c("MFQ_harm_s","MFQ_fair_s","MFQ_ingroup_s","MFQ_authority_s","MFQ_purity_s")],
          data_moral[c("dominance6","prestige6", "leadership6")])
c1
round(c1$p,3)

#For males
cm <- corr.test(data_moral[data_moral$gender == "male",c("MFQ_harm_s","MFQ_fair_s","MFQ_ingroup_s","MFQ_authority_s","MFQ_purity_s")],
                data_moral[data_moral$gender == "male",c("dominance6","prestige6", "leadership6")])
cm

#For females
cf <- corr.test(data_moral[data_moral$gender == "female",c("MFQ_harm_s","MFQ_fair_s","MFQ_ingroup_s","MFQ_authority_s","MFQ_purity_s")],
                data_moral[data_moral$gender == "female",c("dominance6","prestige6", "leadership6")])
cf


c2 <- corr.test(data_moral[c("dominance6","prestige6", "leadership6")])
c2

c3 <- corr.test(data_moral[c("MFQ_harm_s","MFQ_fair_s","MFQ_ingroup_s","MFQ_authority_s","MFQ_purity_s")])
c3
round(c3$p,3)




##########
#Create multiple regression models and select best fitting models 

##
#Sum code sample factor
data_moral$sample <- as.factor(data_moral$sample)
contrasts(data_moral$sample) <- contr.sum(n = 3)


###For harm
m1.1 <- lm(MFQ_harm_s ~ scale(dominance6) + scale(prestige6) + scale(leadership6), data = data_moral)
summary(m1.1)

m1.2 <- lm(MFQ_harm_s ~ scale(dominance6) + scale(prestige6) + scale(leadership6) + sample, data = data_moral)
summary(m1.2)

m1.3 <- lm(MFQ_harm_s ~ scale(dominance6)*sample + scale(prestige6)*sample + scale(leadership6)*sample, data = data_moral)
summary(m1.3)

anova(m1.1,m1.2,m1.3) #m1.1 fits best


###For fairness
m2.1 <- lm(MFQ_fair_s ~ scale(dominance6) + scale(prestige6) + scale(leadership6), data = data_moral)
summary(m2.1)

m2.2 <- lm(MFQ_fair_s ~ scale(dominance6) + scale(prestige6) + scale(leadership6) + sample, data = data_moral)
summary(m2.2)

m2.3 <- lm(MFQ_fair_s ~ scale(dominance6)*sample + scale(prestige6)*sample + scale(leadership6)*sample, data = data_moral)
summary(m2.3)

anova(m2.1,m2.2,m2.3) #m2.1 fits best


###For ingroup
m3.1 <- lm(MFQ_ingroup_s ~ scale(dominance6) + scale(prestige6) + scale(leadership6), data = data_moral)
summary(m3.1)

m3.2 <- lm(MFQ_ingroup_s ~ scale(dominance6) + scale(prestige6) + scale(leadership6) + sample, data = data_moral)
summary(m3.2)

m3.3 <- lm(MFQ_ingroup_s ~ scale(dominance6)*sample + scale(prestige6)*sample + scale(leadership6)*sample, data = data_moral)
summary(m3.3)

anova(m3.1,m3.2,m3.3) #m3.3 fits best


###For authority
m4.1 <- lm(MFQ_authority_s ~ scale(dominance6) + scale(prestige6) + scale(leadership6), data = data_moral)
summary(m4.1)

m4.2 <- lm(MFQ_authority_s ~ scale(dominance6) + scale(prestige6) + scale(leadership6) + sample, data = data_moral)
summary(m4.2)

m4.3 <- lm(MFQ_authority_s ~ scale(dominance6)*sample + scale(prestige6)*sample + scale(leadership6)*sample, data = data_moral)
summary(m4.3)

anova(m4.1,m4.2,m4.3) #m4.1 fits best


###For purity
m5.1 <- lm(MFQ_purity_s ~ scale(dominance6) + scale(prestige6) + scale(leadership6), data = data_moral)
summary(m5.1)

m5.2 <- lm(MFQ_purity_s ~ scale(dominance6) + scale(prestige6) + scale(leadership6) + sample, data = data_moral)
summary(m5.2)

m5.3 <- lm(MFQ_purity_s ~ scale(dominance6)*sample + scale(prestige6)*sample + scale(leadership6)*sample, data = data_moral)
summary(m5.3)

anova(m5.1,m5.2,m5.3) #m5.1 fits best
