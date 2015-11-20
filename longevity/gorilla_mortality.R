# Sex: Male = 1, Female = 2
# Age: Becomes centered

library(survival)
library(ggplot2)

load("Gorilla.RData")

Dataset.xfer1993 <- read.csv(file="gorilla_xfer_1993.csv",header=T,na.string="n/a")
names(Dataset.xfer1993)[1] <- "GORILLA"
names(Dataset.xfer1993)[12] <- "xfer1993"
xfervars <- c("GORILLA","xfer1993")
new.xfer1993 <- Dataset.xfer1993[xfervars]

Dataset.old <- Dataset
Dataset.old <- Dataset[!is.na(Dataset$ACTIVE1),]

Dataset <- merge(Dataset.old,new.xfer1993,by="GORILLA")

groupsize <- as.data.frame(table(Dataset$ZOO1))
names(groupsize) <- c("ZOO1","group")

Dataset <- merge(Dataset,groupsize,by="ZOO1")

Dataset <- Dataset[which(Dataset$rearing2<3 & Dataset$GORILLA != 1190
                         & Dataset$GORILLA != 1182 & Dataset$GORILLA
                         != 341 & Dataset$GORILLA !=358 &
                         Dataset$GORILLA != 359 & Dataset$GORILLA != 1050),]

#Dataset$AGE <- as.vector(scale(Dataset$AGE,center=T,scale=F))

Dataset$xfer <- NA
Dataset$xfer[Dataset$xfer1993==0]<-"0"
Dataset$xfer[Dataset$xfer1993==1]<-"1"
Dataset$xfer[Dataset$xfer1993>=2]<-"2 to 8"
Dataset$xfer <- factor(Dataset$xfer)

Dataset$background <- NA
Dataset$background[Dataset$birth.type==1] <- 0
Dataset$background[Dataset$birth.type==2 & Dataset$rearing2==1] <-1
Dataset$background[Dataset$birth.type==2 & Dataset$rearing2==2] <-2
Dataset$background <- factor(Dataset$background)

Dataset$captive_vs_wild <- NA
Dataset$captive_vs_wild[Dataset$background==0] <- -1
Dataset$captive_vs_wild[Dataset$background==1 | Dataset$background==2] <- .5

Dataset$hand_vs_mother <-NA  
Dataset$hand_vs_mother[Dataset$background==0] <- 0
Dataset$hand_vs_mother[Dataset$background==1] <- -1
Dataset$hand_vs_mother[Dataset$background==2] <- 1

attach(Dataset)
Dataset$Extroverted<-scale((-1*(SOCIABL1+PLAYFUL1+ACTIVE1+POPULAR1+CURIOUS1-SOLITAR1-SLOW1)))
Dataset$Dominant<-scale((-1*(AGGRESS1+EFFECTI1+IRRITAB1+STRONG1+OPPORTU1+EXCITAB1)))
Dataset$Fearful<-scale((-1*(FEARFUL1+APPREHE1+INSECUR1+TENSE1+ECCENTR1-CONFIDE1)))
Dataset$Understanding<-scale((-1*(UNDERSTA+PROTECTI+PERMISS1+EQUABLE1+MOTHER1)))
detach(Dataset)

# Creating age at death for one subject
Dataset$age.at.death[Dataset$GORILLA==292]<-(Dataset$AGE[Dataset$GORILLA==292])+(3203/365.25)

# Adding a month based on the correct date of ratings. This was done
# in Japan but not carried over to this machine until now.
Dataset$time2<-Dataset$time2+31

# Finding the best distribution
thedistributions<-c("weibull","exponential","lognormal","loglogistic")

y <- Surv(Dataset$time2,Dataset$august.2011.status)

themodel <- (y ~ as.factor(Dataset$SEX) + Dataset$AGE +
             Dataset$background + Dataset$xfer + Dataset$Extroverted +
             Dataset$Dominant + Dataset$Fearful +
             Dataset$Understanding)
             
distlist = 0
LLlist1 = 0
LLlist2 = 0
estimates = 0
for (i in 1:length(thedistributions)) {
thisdist = thedistributions[i]
fit = survreg(themodel, dist = thisdist)
distlist[i] = thisdist
LLlist1[i] = -2*(fit$loglik[1])
LLlist2[i] = -2*(fit$loglik[2])
estimates[i] = exp(as.numeric(fit$coefficients[2]))  }
Result = data.frame(distlist, LLlist1, LLlist2, estimates)
names(Result) = c("Distribution", "-2*LL(Baseline)", "-2*LL(Full)","Estimate")
Result = Result[order(Result[,3]),]
Result

# 1: sex, age
model1 <- (y ~ as.factor(Dataset$SEX) + Dataset$AGE)
model1a <- (y ~ Dataset$xfer)
model1b <- (y ~ as.factor(Dataset$SEX) + Dataset$xfer)
model1c <- (y ~ Dataset$AGE + Dataset$xfer)
model1d <- (y ~ as.factor(Dataset$SEX) + Dataset$AGE + Dataset$xfer)

# 2: sex, age, rearing, transfers
model2 <- (y ~ as.factor(Dataset$SEX) + Dataset$AGE +
           Dataset$background +
           Dataset$xfer)

# 3: sex, age, rearing, birth type, transfers, extroverted
model3 <- (y ~ as.factor(Dataset$SEX) + Dataset$AGE +
           Dataset$background +
           Dataset$xfer + Dataset$Extroverted)

# 4: sex, age, rearing, birth type, transfers, extroverted, dominant
model4 <- (y ~ as.factor(Dataset$SEX) + Dataset$AGE +
           Dataset$background +
           Dataset$xfer + Dataset$Extroverted + Dataset$Dominant)

# 5: sex, age, rearing, transfers, birth type, extroverted, dominant, fearful
model5 <- (y ~ as.factor(Dataset$SEX) + Dataset$AGE +
           Dataset$background +
           Dataset$xfer + Dataset$Extroverted + Dataset$Dominant +
           Dataset$Fearful)

# 6: sex, age, rearing, transfers, birth type, extroverted, dominant, fearful, understanding
model6 <- (y ~ as.factor(Dataset$SEX) + Dataset$AGE +
           Dataset$background + Dataset$xfer + Dataset$Extroverted +
           Dataset$Dominant + Dataset$Fearful + Dataset$Understanding)

model6a <- (y ~ as.factor(Dataset$ZOO1) + as.factor(Dataset$SEX) + Dataset$AGE +
           Dataset$background + Dataset$xfer + Dataset$Extroverted +
           Dataset$Dominant + Dataset$Fearful + Dataset$Understanding)

model6b <- (y ~ Dataset$group + as.factor(Dataset$SEX) + Dataset$AGE +
           Dataset$background + Dataset$xfer + Dataset$Extroverted +
           Dataset$Dominant + Dataset$Fearful + Dataset$Understanding)

# 7: sex, age, rearing, transfers,birth type, extroverted, dominant, fearful,
# understanding, and sex interactions
model7 <- (y ~ as.factor(Dataset$SEX) + Dataset$AGE +
           Dataset$background +
           Dataset$xfer + Dataset$Extroverted + Dataset$Dominant +
           Dataset$Fearful + Dataset$Understanding +
           Dataset$Extroverted:Dataset$SEX +
           Dataset$Dominant:Dataset$SEX + Dataset$Fearful:Dataset$SEX
           + Dataset$Understanding:Dataset$SEX)

# 8: sex, age, rearing, transfers,birth type, extroverted, fearful,
# understanding, and age interactions
model8 <- (y ~ as.factor(Dataset$SEX) + Dataset$AGE +
           Dataset$background +
           Dataset$xfer + Dataset$Extroverted + Dataset$Dominant +
           Dataset$Fearful + Dataset$Understanding +
           Dataset$Extroverted:Dataset$AGE +
           Dataset$Dominant:Dataset$AGE + Dataset$Fearful:Dataset$AGE
           + Dataset$Understanding:Dataset$AGE)

# 9: sex, age, rearing, transfers, birth type, extroverted, fearful,
# understanding, and background

model9 <- (y ~ as.factor(Dataset$SEX) + Dataset$AGE +
           Dataset$background +
           Dataset$xfer + Dataset$Extroverted + Dataset$Dominant +
           Dataset$Fearful + Dataset$Understanding +
           Dataset$Extroverted:Dataset$background +
           Dataset$Dominant:Dataset$background +
           Dataset$Fearful:Dataset$background +
           Dataset$Understanding:Dataset$background)

# 10: sex, age, rearing, transfers, birth type, extroverted, fearful,
# understanding, and transfers interactions
model10 <- (y ~ as.factor(Dataset$SEX) + Dataset$AGE +
            Dataset$background +
            Dataset$xfer + Dataset$Extroverted + Dataset$Dominant +
            Dataset$Fearful + Dataset$Understanding +
            Dataset$Extroverted:Dataset$xfer +
            Dataset$Dominant:Dataset$xfer +
            Dataset$Fearful:Dataset$xfer +
            Dataset$Understanding:Dataset$xfer)

# AFT models
aft_model1 <- survreg(model1,dist="weibull")
aft_model1a <- survreg(model1a,dist="weibull")
aft_model1b <- survreg(model1b,dist="weibull")
aft_model1c <- survreg(model1c,dist="weibull")
aft_model1d <- survreg(model1d,dist="weibull")
aft_model2 <- survreg(model2,dist="weibull")
aft_model3 <- survreg(model3,dist="weibull")
aft_model4 <- survreg(model4,dist="weibull")
aft_model5 <- survreg(model5,dist="weibull")
aft_model6 <- survreg(model6,dist="weibull")
aft_model6a <- survreg(model6a,dist="weibull")
aft_model6b <- survreg(model6b,dist="weibull")
aft_model7 <- survreg(model7,dist="weibull")
aft_model8 <- survreg(model8,dist="weibull")
aft_model9 <- survreg(model9,dist="weibull")
aft_model10 <- survreg(model10,dist="weibull")

# Plotting Extraversion

#Dataset$extraversion_cut<-NA
#Dataset$extraversion_cut[Dataset$Extroverted < -1] <- 4
#Dataset$extraversion_cut[Dataset$Extroverted <= -.5 & Dataset$Extroverted >= -1] <- 3
#Dataset$extraversion_cut[Dataset$Extroverted >= -.5 & Dataset$Extroverted <= .5] <- 2
#Dataset$extraversion_cut[Dataset$Extroverted > .5 & Dataset$Extroverted <= 1] <- 1
#Dataset$extraversion_cut[Dataset$Extroverted > 1] <- 0

Dataset$extraversion_cut<-NA
Dataset$extraversion_cut[Dataset$Extroverted < -.7242] <- 1
Dataset$extraversion_cut[Dataset$Extroverted <= .1130 & Dataset$Extroverted >= -.7242] <- 2
Dataset$extraversion_cut[Dataset$Extroverted > .1130 & Dataset$Extroverted <= .7880] <- 3
Dataset$extraversion_cut[Dataset$Extroverted > .7880] <- 4

mean_total_time <- tapply(Dataset$time2,Dataset$extraversion_cut,mean,na.rm=T)
sd_total_time <- tapply(Dataset$time2,Dataset$extraversion_cut,sd,na.rm=T)
npts_total_time <- tapply(Dataset$time2,Dataset$extraversion_cut,length)
proportion_deaths <- tapply(Dataset$august.2011.status,Dataset$extraversion_cut,mean,na.rm=T)
extraversion_cat <- as.numeric(names(mean_total_time))

plots <-
as.data.frame(cbind(extraversion_cat,mean_total_time,sd_total_time,npts_total_time,proportion_deaths))

plots <- transform(plots,se_total_time=(sd_total_time/sqrt(npts_total_time)))

p <- ggplot(plots,aes(as.factor(extraversion_cat),mean_total_time,fill=proportion_deaths))+geom_bar()

p <-
p+scale_fill_gradient(low="lightgray",high="black",name="Proportion Deceased")+theme_bw()

p <-
p+scale_x_discrete(name="Extraversion Quartile")+scale_y_continuous(name="Days to Death or Censoring")

# Change font for Proc Royal
p+opts(legend.text=theme_text(family="Times",size=9),legend.title=theme_text(family="Times",size=11),
axis.text.x=theme_text(family="Times",size=9),axis.title.x=theme_text(family="Times",size=11),
axis.text.y=theme_text(family="Times",size=9),axis.title.y=theme_text(family="Times",size=11,angle=90,vjust=0.4))

# Add error bars
# p <-
#p+geom_errorbar(aes(ymin=(mean_total_time-(1.96*se_total_time)),ymax=(mean_total_time+(1.96*se_total_time))),width=.25)

#mfit<-survfit(Surv(time2,august.2011.status==1)~extraversion_cut,data=Dataset)
# 6: sex, age, rearing, transfers, birth type, extroverted, dominant, fearful, understanding

# Supplementary analysis 1: test whether dropping younger animals adversely
# effects the results
Dataset.older <- Dataset[Dataset$AGE>=10,]

y.older <- Surv(Dataset.older$time2,Dataset.older$august.2011.status)

model6_older <- (y.older ~ as.factor(Dataset.older$SEX) + Dataset.older$AGE +
           Dataset.older$background + Dataset.older$xfer + Dataset.older$Extroverted +
           Dataset.older$Dominant + Dataset.older$Fearful +
           Dataset.older$Understanding)

aft_model6_older <- survreg(model6_older,dist="weibull")

# Show results of second supplementary analysis: Age and sex alone
summary(aft_model1)

# Show results of third supplementary analysis:
summary(aft_model1b)

# Save figure
ggsave(file="final_gorilla_figure_6_nov_2012.pdf",height=17.5, width=17.5,units="cm")
