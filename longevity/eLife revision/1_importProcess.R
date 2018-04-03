### Importation and Processing

library(dplyr)
library(lubridate)
library(survival)
library(bbmle)
library(psych)



all <- read.csv("long_all.csv")
# cutting off the bottom
all <- all[-c(558:dim(all)[1]),]

# removing row at 378, where the questionnaire changes
all <- all[-378,]

all[,c(7:60)] <- lapply((all[,c(7:60)]), as.character)
all[,c(7:60)] <- lapply((all[,c(7:60)]), as.numeric)

all$status[(all$status == '') & (all$sample == 'AZA')] <- 'Alive'
all$status[(all$status == 'LTF') & (all$sample == 'AZA')] <- 'Alive'

all$status[(all$status == 'LTF') & (all$sample == 'Taronga')] <- 'Alive'

all$status[(all$status == 'LTF') & (all$sample == 'Yerkes')] <- 'Alive'

all$status[(all$status == 'dead') & (all$sample == 'Japan')] <- 'Death'
all$status[(all$status == 'alive') & (all$sample == 'Japan')] <- 'Alive'

# just for Bram - watch out for the number
all$status[535] <- 'Alive'
table(all$status)
# for frailty purposes, we want to make Taronga part of AZA
all$sample[all$sample=='Taronga'] = 'AZA'

#levels(all$sample)

# remove the rm's
all <- all[!all$status == 'rm',]



### Dating

all$DoB <- as.Date(all$DoB,format='%m/%d/%Y')
all$lastDate <- as.Date(all$lastDate, format='%d/%m/%Y')


### Ageing

# age at last known date
#head(all$lastDate - all$DoB)
all$age = as.numeric(difftime(all$lastDate, all$DoB, units = "weeks"))/52.25 
# The above is super useful. Remember that (it is here).

# making age at DOPR for Yerkes & Edinburgh
all$DOPR = as.Date(all$DOPR,format='%m/%d/%Y')
all$DOPR2 = as.Date(all$DOPR2,format='%m/%d/%Y')
all$DOPRmin = pmin(all$DOPR, all$DOPR2, na.rm = TRUE)


ind = all$sample == 'Yerkes' | all$sample == 'Edinburgh'

all$age_pr[ind] = as.numeric(difftime(
  all$DOPRmin[ind], all$DoB[ind], units = "weeks"))/52.25 

all$DOPRmin[(all$sample == 'AZA') | (all$sample == 'Taronga')] <- 
  all$DoB[(all$sample == 'AZA') | (all$sample == 'Taronga')] + all$age_pr[(all$sample == 'AZA') | (all$sample == 'Taronga')]

yr = year(all$DoB[(all$sample == 'AZA') | (all$sample == 'Taronga')]) +
  all$age_pr[(all$sample == 'AZA') | (all$sample == 'Taronga')]

all$DOPRmin[(all$sample == 'AZA') | (all$sample == 'Taronga')] <- (as.Date(date_decimal(yr)))

# Some animals died before being rated.



### Origin

all$origin[all$origin == ''] <- 'CAPTIVE'
all$origin[all$origin == 'W'] <- 'WILD'
all$origin[all$origin == 'UNKNOWN'] <- 'CAPTIVE'

table(all$origin)

all$origin = droplevels(all$origin)



### Lab vs. Zoo

all$LvZ[all$sample == 'AZA'] <- 'zoo'
all$LvZ[all$sample == 'Yerkes'] <- 'lab'
all$LvZ[all$sample == 'Taronga'] <- 'zoo'

# This variable is not accurate, and should not be used for analysis.



### Creating personality scores

all$Dom = NA
all$Ext = NA
all$Con = NA
all$Agr = NA
all$Neu = NA
all$Opn = NA


ind = (all$sample == 'AZA' | all$sample == 'Yerkes' | all$sample == 'Taronga')

all[ind,]$Dom <-
  (all[ind,]$dom-all[ind,]$subm-all[ind,]$depd+all[ind,]$indp-all[ind,]$fear+all[ind,]$decs
   -all[ind,]$tim-all[ind,]$caut+all[ind,]$intll+all[ind,]$pers+all[ind,]$buly+all[ind,]$stngy+40)/12

all[ind,]$Ext <-
  (-all[ind,]$sol-all[ind,]$lazy-all[ind,]$depr
   +all[ind,]$actv+all[ind,]$play+all[ind,]$soc+all[ind,]$frdy+all[ind,]$affc+all[ind,]$imit+24)/9

all[ind,]$Con <-
  (-all[ind,]$impl-all[ind,]$defn-all[ind,]$reckl-all[ind,]$errc-all[ind,]$irri
   +all[ind,]$pred-all[ind,]$aggr-all[ind,]$jeals-all[ind,]$dsor+64)/9

all[ind,]$Agr <-
  (all[ind,]$symp+all[ind,]$help+all[ind,]$sens+all[ind,]$prot+all[ind,]$gntl)/5

all[ind,]$Neu <-
  (-all[ind,]$stbl+all[ind,]$exct-all[ind,]$unem+16)/3

all[ind,]$Opn <-
  (all[ind,]$inqs+all[ind,]$invt) /2
  


ind = (all$sample == 'Japan' | all$sample == 'Edinburgh') 

all[ind,]$Dom <-
  (all[ind,]$dom
   -all[ind,]$subm
   -all[ind,]$depd
   +all[ind,]$indp
   -all[ind,]$fear
   +all[ind,]$decs
   -all[ind,]$tim
   -all[ind,]$caut
   +all[ind,]$intll
   +all[ind,]$pers
   +all[ind,]$buly
   +all[ind,]$stngy
   -all[ind,]$Vuln - all[ind,]$Anx + all[ind,]$manp + 56)/15

all[ind,]$Ext <-
  (-all[ind,]$sol-all[ind,]$lazy-all[ind,]$depr
   +all[ind,]$actv+all[ind,]$play+all[ind,]$soc+all[ind,]$frdy+all[ind,]$affc+all[ind,]$imit
   -all[ind,]$Indv + 32)/10

all[ind,]$Con <-
  (-all[ind,]$impl-all[ind,]$defn-all[ind,]$reckl-all[ind,]$errc-all[ind,]$irri
   +all[ind,]$pred-all[ind,]$aggr-all[ind,]$jeals-all[ind,]$dsor
   - all[ind,]$Thot - all[ind,]$Dist - all[ind,]$Unper - all[ind,]$Quit - all[ind,]$clmy + 104)/14

all[ind,]$Agr <-
  (all[ind,]$symp+all[ind,]$help+all[ind,]$sens+all[ind,]$prot+all[ind,]$gntl
   + all[ind,]$Conv)/6

all[ind,]$Neu <-
  (-all[ind,]$stbl+all[ind,]$exct-all[ind,]$unem
   - all[ind,]$Cool + all[ind,]$aut + 24)/5

all[ind,]$Opn <-
  (all[ind,]$inqs+all[ind,]$invt
   + all[ind,]$Cur + all[ind,]$Innov) / 4


# Scale each dimension across all chimps
all$Dom_CZ <- scale(all$Dom)
all$Ext_CZ <- scale(all$Ext)
all$Con_CZ <- scale(all$Con)
all$Agr_CZ <- scale(all$Agr)
all$Neu_CZ <- scale(all$Neu)
all$Opn_CZ <- scale(all$Opn)

# removing individuals who died before rating
rmovals <- which((all$age - all$age_pr) < 0.0)   # 29, 505, ++...

all <- (all[-c(rmovals),])

# REMOVE?

# all$status <- droplevels(all$status)
# 
# levels(all$status)[levels(all$status)=="Death"] <- TRUE
# levels(all$status)[levels(all$status)=="Alive"] <- FALSE
# 
# all$status = as.logical(all$status)


### Regression prepping

Dataset <- all

Dataset$origin <- droplevels(Dataset$origin)


# RIGHT censoring - matching 'time' and 'event'

Dataset$stat.log <- droplevels(Dataset$status)

levels(Dataset$status)[levels(Dataset$status)=="Death"] <- 1
levels(Dataset$status)[levels(Dataset$status)=="Alive"] <- 0


levels(Dataset$stat.log)[levels(Dataset$stat.log)=="Death"] <- TRUE
levels(Dataset$stat.log)[levels(Dataset$stat.log)=="Alive"] <- FALSE

Dataset$stat.log = as.logical(Dataset$stat.log)


# Stratification

Dataset$strt = NA
Dataset$strt[Dataset$age_pr < 8] <- 1
Dataset$strt[(Dataset$age_pr > 8) & (Dataset$age_pr < 15)] <- 2
Dataset$strt[(Dataset$age_pr > 15) & (Dataset$age_pr < 25)] <- 3
Dataset$strt[(Dataset$age_pr > 25) & (Dataset$age_pr < 35)] <- 4
Dataset$strt[(Dataset$age_pr > 35)] <- 5



### Make Surv objects

# Right censored

y <- Surv(as.numeric(Dataset$age),Dataset$stat.log)


# adding LEFT truncation

y.Ltrunc <- Surv(Dataset$age_pr, Dataset$age,Dataset$stat.log, 
                 type='counting')

rmNAs = !is.na(y.Ltrunc)

datX = Dataset[rmNAs,]
yLt = Surv(datX$age_pr, datX$age, datX$stat.log)


datX$sample = as.integer(datX$sample)
datX$status <- relevel(datX$status,'1')
datX$status <- relevel(datX$status,'0')
datX$status = as.integer(datX$status) - 1



### Check which P dimensions are confounded with age

pxt.cors = corr.test(x=Dataset[,c('Ext_CZ','Opn_CZ','Dom_CZ','Neu_CZ','Con_CZ','Agr_CZ')],
                     y=data.frame(as.numeric(Dataset$DoB)), 
                     method = "kendall", adjust='none'
                     , ci=TRUE)
print(pxt.cors, short=F)
# only correlations between DoB and D, E, N, and O are significant



## Extraversion

fit.e0 <- lm(Ext_CZ ~ 1, data=datX)
fit.e1 <- lm(Ext_CZ ~ scale(DoB), data=datX)
fit.e2 <- lm(Ext_CZ ~ scale(DoB) + I(scale(DoB)^2), data=datX) # this seems to be the best (see below)
fit.e3 <- lm(Ext_CZ ~ scale(DoB) + I(scale(DoB)^2) + I(scale(DoB)^3), data=datX)

anova(fit.e0,fit.e1,fit.e2,fit.e3)
AICctab(fit.e0,fit.e1,fit.e2,fit.e3
       ,logLik=T,weights=T,base=T,delta=T)

datX$E.r2.DoB <- fit.e2$residuals

# what do these residuals look like?
#plot(datX$Ext_CZ, datX$E.r2.DoB)


## Openness
fit.o0 <- lm(Opn_CZ ~ 1, data=datX)
fit.o1 <- lm(Opn_CZ ~ scale(DoB), data=datX) 
fit.o2 <- lm(Opn_CZ ~ scale(DoB) + I(scale(DoB)^2), data=datX) # This one
fit.o3 <- lm(Opn_CZ ~ scale(DoB) + I(scale(DoB)^2) + I(scale(DoB)^3), data=datX)

anova(fit.o0,fit.o1,fit.o2,fit.o3)
AICctab(fit.o0,fit.o1,fit.o2,fit.o3
       , logLik=T,weights=T,base=T,delta=T)

datX$O.r2.DoB <- fit.o2$residuals
  
#plot(datX$age_pr, datX$O.r2.DoB)


## Dominance

fit.d0 <- lm(Dom_CZ ~ 1, data=datX)
fit.d1 <- lm(Dom_CZ ~ scale(DoB), data=datX)
fit.d2 <- lm(Dom_CZ ~ scale(DoB) + I(scale(DoB)^2), data=datX) # This one 
fit.d3 <- lm(Dom_CZ ~ scale(DoB) + I(scale(DoB)^2) + I(scale(DoB)^3), data=datX) 

anova(fit.d0, fit.d1,fit.d2,fit.d3)
AICctab(fit.d0, fit.d1,fit.d2,fit.d3
       ,logLik=T,weights=T,base=T,delta=T)

datX$D.r2.DoB <- fit.d2$residuals


## Neuroticism

fit.n0 <- lm(Neu_CZ ~ 1, data=datX)
fit.n1 <- lm(Neu_CZ ~ scale(DoB), data=datX) # This one
fit.n2 <- lm(Neu_CZ ~ scale(DoB) + I(scale(DoB)^2), data=datX)
fit.n3 <- lm(Neu_CZ ~ scale(DoB) + I(scale(DoB)^2) + I(scale(DoB)^3), data=datX)

anova(fit.n0,fit.n1,fit.n2,fit.n3)
AICctab(fit.n0,fit.n1,fit.n2,fit.n3
       ,logLik=T,weights=T,base=T,delta=T)

datX$N.r1.DoB <- fit.n1$residuals






