#Chimp welfare

library(corpcor)
library(GPArotation)
library(psych)
#library(paran)
library(MASS)

#setwd("rercode/")

swbwel=read.csv("Chimp welfare ratings.scrubbed.4.csv")


num_observations <- as.data.frame(table(swbwel$Chimp))
num_observations
names(num_observations)[1] <- "Chimp"
swbwel2 <- merge(swbwel,num_observations,by="Chimp")
names(swbwel2)
items<-c(names(swbwel2[10:21]), (names(swbwel2[25:28])))
items
#source('~/Dropbox/PhD/R/R stats steps/ICC/icc3.R', chdir = TRUE)
#icc3.reliability(swbwel2[swbwel2$Freq!=1,], items, "Chimp", "Rater")


data_meanreplace <- swbwel2
for(var in names(data_meanreplace[,10:21])) {
  m <- mean(data_meanreplace[,var], na.rm=T)
  is.missing <- is.na(data_meanreplace[,var])
  data_meanreplace[is.missing,var] <- m
}
for(var in names(data_meanreplace[,25:28])) {
  m <- mean(data_meanreplace[,var], na.rm=T)
  is.missing <- is.na(data_meanreplace[,var])
  data_meanreplace[is.missing,var] <- m
}
summary(data_meanreplace)



#There's probably a better way to do the above than the two step, I just couldn't get it to work.
# means<-data_meanreplace
# icc=icc3.reliability(means[means$Freq!=1,], items, "Chimp", "Rater")
# 
# 
# mean(icc$icc31[1:12])
# mean(icc$icc31[13:16])
# attach(means)
# welfareagg <- aggregate(means, by=list(Chimp), FUN = mean, na.rm = TRUE)
# detach(means)


#library(paran)
library(psych)
items2=items<-c(names(swbwel2[,c(10, 12:21)]), (names(swbwel2[25:28])))
  
  
nfactors(welfareagg[items2])
fa.parallel(welfareagg[items2])
#paran(welfareagg[items2], graph = TRUE,centile=95)
pc_1_none <- principal(welfareagg[items2], nfactors=1, rotate = "none")


items2=items<-c(names(welfareagg[,c(10:14, 16:21)]), (names(swbwel2[25:28])))
pc_1_none <- principal(welfareagg[items2], nfactors=1, rotate = "none")


welfareitems=items<-c(names(welfareagg[,c(10:14, 16:21)]))
pc_welfare_none <- principal(welfareagg[welfareitems], nfactors=1, rotate = "none")


components=welfareagg
attach(components)
components$totalwelfare=(Q3 +Q4.1 +Q4.2+ Q5 +Q6.1 +Q6.2 +Q7 -Q8 +Q9 +Q10)
components$totalswb=(SWB.Q1 + SWB.Q2 + SWB.Q3 + SWB.Q4)
components$welfareswb=(Q3 +Q4.1 +Q4.2+ Q5 +Q6.1 +Q6.2 +Q7 -Q8 +Q9 +Q10+SWB.Q1 + SWB.Q2 + SWB.Q3 + SWB.Q4)
detach(components)
names(components)


personality=read.csv("Edinburgh and Mona Eysneck ratings.1.csv")
num_observations2 <- as.data.frame(table(personality$Animal))
num_observations2
names(num_observations2)[1] <- "Animal"
personality2 <- merge(personality,num_observations2,by="Animal")
names(personality2)
items3<-c(names(personality2[3:14]))
items3
# source('~/Dropbox/PhD/R/R stats steps/ICC/icc3.R', chdir = TRUE)
# icc3.reliability(personality2[personality2$Freq!=1,], items3, "Animal", "Rater")
# summary(is.na(personality2))

# pers=personality2

attach(pers)
eysitems=aggregate(pers, by=list(Animal), FUN = mean, na.rm = TRUE)
detach(pers)




attach(eysitems)
eysitems$F1=(Spontaneous..1. + Active..1. + Sociable..1. - Happy..cheerful..1. +8)/4
eysitems$F2=(Not.aggressive..1. + Calm..1. + Cautious..1. + Empathic..1. + Good.tempered..1.)/5
eysitems$F3= (Dominant..1.)
detach(eysitems)

merged=merge(eysitems, components, by="Group.1")

dob=read.csv("general chimp info.csv")
dob$Q.Date=as.Date(ISOdate(dob$Q.year, dob$Q.month, dob$Q.day))
dob$dob.Date=as.Date(ISOdate(dob$dob.year, dob$dob.month, dob$dob.day))
dob$age= dob$Q.Date - dob$dob.Date
class(dob$age)
dob$agenum=dob$age
dob$agenum=as.numeric(dob$agenum)
class(dob$agenum)

attach(dob)
geninfo=aggregate(dob, by=list(dob$Chimp), FUN = mean, na.rm = TRUE)
detach(dob)

merged2=merge(merged, geninfo, by="Group.1")

origin=read.csv("chimp origin.csv")
merged3=merge(merged2, origin, by.x="Group.1", by.y="Chimp")

model1=lm(welfareswb ~ F1 + F2 + F3 + agenum + Sex, data=merged3)
model2=lm(totalwelfare ~ F1 + F2 + F3 + agenum + Sex, data=merged3)
model3=lm(totalswb ~ F1 + F2 + F3 + agenum + Sex, data=merged3)
summary(model1)
summary(model2)
summary(model3)


pers =read.csv('/Users/s1143245/Dropbox/PhD/All projects/Chimp welfare/Data sets/edinpersonality.csv',header=TRUE)

compare_data <- NULL

compare_data <- data.frame(chimp = pers$chimpname)

compare_data$dom <-
  (pers$Dom - pers$Fear - pers$Subm - pers$Tim - pers$Caut - pers$Depd + pers$Indp - pers$Vuln + 
     pers$Decs + pers$Intll + pers$Pers + pers$Buly + pers$Stngy + pers$Manp - pers$Anx 
   + 7*8
  ) / 15

compare_data$ext <-
  (pers$Actv + pers$Play + pers$Soc + pers$Frdy + pers$Affc + pers$Imit 
   - pers$Sol - pers$Lazy - pers$Indv - pers$Depr     
   + 4*8
  ) / 10

compare_data$con <-
  (#pers$Pred - pers$Impl 
    - pers$Defn - pers$Reckl - pers$Errc - pers$Irri - pers$Aggr - pers$Jeals
    - pers$Dsor - pers$Thotl - pers$Dist - pers$Unper - pers$Quit #- pers$Clmy
    + 11*8
  ) / 11

compare_data$agr <-
  (pers$Symp + pers$Help + pers$Sens + pers$Prot + pers$Gntl + pers$Conv
  ) / 6

compare_data$neu <-
  (pers$Exct + pers$Aut - pers$Stbl - pers$Cool - pers$Unem
   + 3*8
  ) / 5

compare_data$opn <-
  (pers$Inqs + pers$Invt + pers$Curious + pers$Innov
  ) / 4
compare_data = compare_data[25:95,]

aggPers <- aggregate(compare_data, by=list(compare_data$chimp), FUN=mean, na.rm=TRUE,na.action = na.omit)

# removing dead chimps :((((
rownames(aggPers) <- aggPers$Group.1
aggPers<-aggPers[c(-1,-2,-4,-17,-22),]
aggPers<-aggPers[,-2]

colnames(aggPers) <- c("Chimp",'Dominance','Extraversion','Conscientiousness',
                       'Agreeableness','Neuroticism','Openness')

edinHPQ=merge(merged3, aggPers, by.x="Group.1", by.y="Chimp")
setdiff(merged3$Group.1, aggPers$Chimp)
dim(edinHPQ)

HPQ1=lm(welfareswb ~ Dominance + Extraversion	+ Conscientiousness	+ Agreeableness +	Neuroticism	+ Openness + agenum + Sex , data=edinHPQ)
HPQ2=lm(totalwelfare ~ Dominance + Extraversion  + Conscientiousness	+ Agreeableness +	Neuroticism	+ Openness + agenum + Sex , data=edinHPQ)
HPQ3=lm(totalswb ~ Dominance + Extraversion  + Conscientiousness	+ Agreeableness +	Neuroticism	+ Openness + agenum + Sex , data=edinHPQ)
summary(HPQ1)
summary(HPQ2)
summary(HPQ3)
drop1(HPQ1)
drop1(HPQ2)
drop1(HPQ3)

percorr=corr.test(edinHPQ[,c(17:19, 64:66, 81:86)], method="spearman")
allcorr2=corr.test(sofar[,c(6:9,20:31,89:96)],method="spearman")

secondratings=read.csv("Budongo welfare 2nd ratings.csv")
num_observations2nd <- as.data.frame(table(secondratings$Chimp))
num_observations2nd
names(num_observations2nd)[1] <- "Chimp"
items<-c(names(secondratings[3:18]))
items
seconddata <- merge(secondratings,num_observations2nd,by="Chimp")
#source('~/Dropbox/PhD/R/R stats steps/ICC/icc3.R', chdir = TRUE)
icc3.reliability(seconddata[seconddata$Freq!=1,], items, "Chimp", "Rater")


data_meanreplace <- seconddata
for(var in names(data_meanreplace[,3:18])) {
  m <- mean(data_meanreplace[,var], na.rm=T)
  is.missing <- is.na(data_meanreplace[,var])
  data_meanreplace[is.missing,var] <- m
}




#There's probably a better way to do the above than the two step, I just couldn't get it to work.
# means<-data_meanreplace
# icc=icc3.reliability(means[means$Freq!=1,], items, "Chimp", "Rater")
# mean(icc$icc3k)
