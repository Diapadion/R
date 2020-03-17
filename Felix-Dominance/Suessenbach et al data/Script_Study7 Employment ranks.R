############
#R Script for Suessenbach et al. Study 7

#Packages needed for this R script
library(lme4)
library(psych)
library(ggplot2)
library(rsq)
library(lsr)


#Read in dataframes
sampleUS <- read.csv(file = "sample4.csv", header = T) #US sample

sampleUK <- read.csv(file = "sample5.csv", header = T) #UK sample


#Descriptive statistics
describe(sampleUS)
describe(sampleUK)


#Correlation matrix for zero order correlations
c1 <- corr.test(sampleUS[c("dominance6","prestige6", "leadership6","employment_rank")], method = "spearman")
c1
round(c1$p,3)

c2 <- corr.test(sampleUK[c("dominance6","prestige6", "leadership6","employment_rank")], method = "spearman")
c2
round(c2$p,3)

#Gender differences US
cm <- corr.test(sampleUS[sampleUS$gender == "male",c("dominance6","prestige6", "leadership6","employment_rank")], method = "spearman")
cm
cf <- corr.test(sampleUS[sampleUS$gender == "female",c("dominance6","prestige6", "leadership6","employment_rank")], method = "spearman")
cf


#Gender differences UK
cm <- corr.test(sampleUK[sampleUK$gender == "male",c("dominance6","prestige6", "leadership6","employment_rank")], method = "spearman")
cm
cf <- corr.test(sampleUK[sampleUK$gender == "female",c("dominance6","prestige6", "leadership6","employment_rank")], method = "spearman")
cf



###
#Analyse relationship between leadership motive and employment rank in both samples

#Add gender effect coded
sampleUS$sex <- ifelse(sampleUS$gender == "male",-.5,.5)
sampleUK$sex <- ifelse(sampleUK$gender == "male",-.5,.5)

##US

#Residualised L model with interaction for US
m1 <- glm(employment_rank ~ scale(dominance6)*sex + scale(prestige6)*sex + scale(leadership6)*sex, data= sampleUS, family = "quasipoisson" )
summary(m1)

#L as single predictor with interaction for US
m1.1 <- glm(employment_rank ~ scale(leadership6)*sex, data= sampleUS, family = "quasipoisson" )
summary(m1.1)


#To calculate R² differences for US
#For residualised L
m1.2 <- glm(employment_rank ~ scale(dominance6)*sex + scale(prestige6)*sex + scale(leadership6):sex, data= sampleUS, family = "quasipoisson" )
summary(m1.2)

rsq(m1) - rsq(m1.2) 

#For interaction
m1.4 <- glm(employment_rank ~ scale(dominance6)*sex + scale(prestige6)*sex + scale(leadership6), data= sampleUS, family = "quasipoisson" )
summary(m1.4)

rsq(m1) - rsq(m1.4) 

#For gender differences in employment rank

m1.6 <- glm(employment_rank ~ scale(dominance6) + scale(dominance6):sex + scale(prestige6) + scale(prestige6):sex +
              scale(leadership6) + scale(leadership6):sex, data= sampleUS, family = "quasipoisson" )
summary(m1.6)

rsq(m1) - rsq(m1.6)




##UK

#Residualised L model with interaction for UK
m2 <- glm(employment_rank ~ scale(dominance6)*sex + scale(prestige6)*sex + scale(leadership6)*sex, data= sampleUK, family = "quasipoisson" )
summary(m2)

#L as single predictor with interaction for UK
m2.1 <- glm(employment_rank ~ scale(leadership6)*sex, data= sampleUK, family = "quasipoisson" )
summary(m2.1)


#To calculate R² differences for UK
#For residualised L
m2.2 <- glm(employment_rank ~ scale(dominance6)*sex + scale(prestige6)*sex + scale(leadership6):sex, data= sampleUK, family = "quasipoisson" )
summary(m2.2)

rsq(m2) - rsq(m2.2)

#For interaction
m2.4 <- glm(employment_rank ~ scale(dominance6)*sex + scale(prestige6)*sex + scale(leadership6), data= sampleUK, family = "quasipoisson" )
summary(m2.4)

rsq(m2) - rsq(m2.4) 

#For gender differences in employment rank

m2.6 <- glm(employment_rank ~ scale(dominance6) + scale(dominance6):sex + scale(prestige6) + scale(prestige6):sex +
             scale(leadership6) + scale(leadership6):sex, data= sampleUK, family = "quasipoisson" )
summary(m2.6)

rsq(m2) - rsq(m2.6)


################
#Mean gender differences

t.test(dominance6 ~ gender, data = sampleUS)
t.test(dominance6 ~ gender, data = sampleUK)
cohensD(dominance6 ~ gender, data = sampleUK)

t.test(prestige6 ~ gender, data = sampleUS)
cohensD(prestige6 ~ gender, data = sampleUS)
t.test(prestige6 ~ gender, data = sampleUK)

t.test(leadership6 ~ gender, data = sampleUS)
t.test(leadership6 ~ gender, data = sampleUK)



############
#Draw graph for manuscript

sampleUS$dominance_s <- scale(sampleUS$dominance6)
sampleUS$prestige_s <- scale(sampleUS$prestige6)
sampleUS$leadership_s <- scale(sampleUS$leadership6)

sampleUK$dominance_s <- scale(sampleUK$dominance6)
sampleUK$prestige_s <- scale(sampleUK$prestige6)
sampleUK$leadership_s <- scale(sampleUK$leadership6)


m1.1 <- glm(employment_rank ~ dominance_s*sex + prestige_s*sex + leadership_s*sex , data= sampleUS, family = "quasipoisson" )
summary(m1.1)

m1.2 <- glm(employment_rank ~ dominance_s*sex + prestige_s*sex + leadership_s*sex , data= sampleUK, family = "quasipoisson" )
summary(m1.2)


mUS <- vector()
fUS <- vector()
mUK <- vector()
fUK <- vector()
SDs <- seq(-3,2.5,by = 0.05)


for(i in SDs){
  k = -.5
  mUS <- c(mUS, exp(coef(m1.1)[[1]] + i*coef(m1.1)[[5]] + (coef(m1.1)[[3]]*k) + i*(coef(m1.1)[[8]]*k)))
  mUK <- c(mUK, exp(coef(m1.2)[[1]] + i*coef(m1.2)[[5]] + (coef(m1.2)[[3]]*k) + i*(coef(m1.2)[[8]]*k)))
  
  k = +.5
  fUS <- c(fUS, exp(coef(m1.1)[[1]] + i*coef(m1.1)[[5]] + (coef(m1.1)[[3]]*k) + i*(coef(m1.1)[[8]]*k)))
  fUK <- c(fUK, exp(coef(m1.2)[[1]] + i*coef(m1.2)[[5]] + (coef(m1.2)[[3]]*k) + i*(coef(m1.2)[[8]]*k)))
}

#plot(SDs,fA,type="l",col="red")
#lines(SDs,mA,col="green")

y <- c(mUS,fUS,mUK,fUK)
Gender <- rep( c(rep("Male",length(SDs)),rep("Female",length(SDs))) ,2)
SD <- rep(rep(SDs,2),2)
sample <- c(rep("US sample",length(SDs)*2),rep("UK sample",length(SDs)*2))

d1 <- data.frame(y,SD,Gender,sample)

d2 <- d1[d1$y < 12,]

#Merge dataframes for ggplot
sampleUS$sample <- "US sample"
sampleUK$sample <- "UK sample"


lead_data <- rbind(sampleUS[c("employment_rank","gender","sample","leadership_s")],
                   sampleUK[c("employment_rank","gender","sample","leadership_s")] )

#Remove NAs from gender
lead_data2 <- lead_data[complete.cases(lead_data),  ]


 lead_data2$Gender <- lead_data2$gender
 levels(lead_data2$Gender) <- c("Female","Male")


ggplot(lead_data2, aes(x=leadership_s, y=employment_rank, color = Gender, shape = Gender)) + facet_wrap( ~ sample) + 
  geom_point(position=position_jitter(width=.2,height=.2), size = 2) + scale_colour_hue(l=50) + 
  geom_line(aes(x = SD, y = y, color = Gender, linetype = Gender), d2, size = 1)  + scale_y_continuous(name="Employment rank", breaks = seq(0,11,2)) + 
  scale_x_continuous(name="Residualised leadership motive [in SD]", breaks = seq(-3,2,1)) + element_blank() +
  theme(panel.background = element_rect(fill='white', colour='black'), panel.grid = element_line(linetype = 0)) +
  theme(axis.text = element_text(colour = "black")) +
  theme(legend.margin = unit(-0.5, "cm")) + theme(legend.text = element_text(size = 12)) +
  theme(legend.key=element_rect(fill="white", colour="white"), legend.key.size=unit(1,"cm"), legend.key.height = unit(0.5,"cm")) +
  theme(legend.justification=c(0.01,0.95), legend.position=c(0.01,0.95)) +
  theme(legend.text=element_text(size=10)) +
  theme(legend.title=element_text(size=10)) + theme(strip.background = element_rect(fill="white"))



