### Importation and Processing

all <- read.csv("long_all.csv")
# cutting off the bottom
all <- all[-c(558:dim(all)[1]),]

# removing row at 378, where the questionnaire changes
all <- all[-378,]

all[,c(7:60)] <- lapply((all[,c(7:60)]), as.character)
all[,c(7:60)] <- lapply((all[,c(7:60)]), as.numeric)

all$status[(all$status == '') & (all$sample == 'AZA')] <- 'Alive'
all$status[(all$status == 'LTF') & (all$sample == 'AZA')] <- 'rm'

all$status[(all$status == 'LTF') & (all$sample == 'Taronga')] <- 'Alive'

all$status[(all$status == 'LTF') & (all$sample == 'Yerkes')] <- 'Alive'

all$status[(all$status == 'dead') & (all$sample == 'Japan')] <- 'Death'
all$status[(all$status == 'alive') & (all$sample == 'Japan')] <- 'Alive'

# just for Bram - what out for the number
all$status[535] <- 'Alive'

# for frailty purposes, we want to make Taronga part of AZA
all$sample[all$sample=='Taronga'] = 'AZA'

#levels(all$sample)

# remove the 'rm's until a better situation is realized
### TODO: come up with a better alternative
all <- all[!all$status == 'rm',]


# Dating shenanigans

all$DoB <- as.Date(all$DoB,format='%m/%d/%Y')
all$lastDate <- as.Date(all$lastDate, format='%d/%m/%Y')


### Ageing
# ... should also be age at Personality rating

# age at last known date
#head(all$lastDate - all$DoB)
all$age = as.numeric(difftime(all$lastDate, all$DoB, units = "weeks"))/52.25 
# The above is super useful. Remember that (it is here).

# making age at DOPR for Yerkes & Edinburgh
# see other files - there may be an issue with death dates overlapping
all$DOPR = as.Date(all$DOPR,format='%m/%d/%Y')
all$DOPR2 = as.Date(all$DOPR2,format='%m/%d/%Y')
all$DOPRmin = pmin(all$DOPR, all$DOPR2, na.rm = TRUE)

# some death dates cut off
# all$DOPRmin = pmin(all$DOPRmin, all$lastDate) # this was a PROBLEM

### TODO: set a cut-off for the rating/death date



ind = all$sample == 'Yerkes' | all$sample == 'Edinburgh'

all$age_pr[ind] = as.numeric(difftime(
  all$DOPRmin[ind], all$DoB[ind], units = "weeks"))/52.25 

library(lubridate)
all$DOPRmin[(all$sample == 'AZA') | (all$sample == 'Taronga')] <- 
  all$DoB[(all$sample == 'AZA') | (all$sample == 'Taronga')] + all$age_pr[(all$sample == 'AZA') | (all$sample == 'Taronga')]

yr = year(all$DoB[(all$sample == 'AZA') | (all$sample == 'Taronga')]) +
  all$age_pr[(all$sample == 'AZA') | (all$sample == 'Taronga')]

all$DOPRmin[(all$sample == 'AZA') | (all$sample == 'Taronga')] <- (as.Date(date_decimal(yr)))

# Some animals died before being rated.
# Test: moving their rating date to a month or year back from DoD

all$age_pr_adj = all$age_pr
all$age_pr_adj[all$age <= all$age_pr & (all$sample %in% c('Taronga', 'Yerkes', 'AZA'))] <-
  (all$age_pr_adj[all$age <= all$age_pr & (all$sample %in% c('Taronga', 'Yerkes', 'AZA'))] - 5)


### Origin
# are these appropriate?
# all$origin[all$sample == 'AZA' & all$origin == 'UNKNOWN'] <- #'CAPTIVE' 
# 
# all$origin[(all$sample == 'Yerkes' | all$sample == 'Taronga') & all$origin == ''] <- 'CAPTIVE'
# all$origin[(all$sample == 'Yerkes' | all$sample == 'Taronga') & all$origin == 'W'] <- 'WILD'
all$origin[all$origin == ''] <- 'CAPTIVE'
all$origin[all$origin == 'W'] <- 'WILD'

table(all$origin)
# library(dplyr) # needed?
all$origin = droplevels(all$origin)

### Lab vs. Zoo

all$LvZ[all$sample == 'AZA'] <- 'zoo'
all$LvZ[all$sample == 'Yerkes'] <- 'lab'
all$LvZ[all$sample == 'Taronga'] <- 'zoo'

###
# there're rearing styles in the AZA file...
# and the Yerkes hematology file...



### creating personality scores


# right now this is being applied to all
# will need to create HPQ composites later
# and compare the possibilities


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
# is 0 enough, or do we need a buffer?
all <- (all[-c(rmovals),])



### Regression prepping

# formerly at beginning of analysis scripts

library(survival)

# Dataset <- all[(all$sample == 'AZA') 
#                | (all$sample == 'Yerkes') | (all$sample == 'Taronga'),]
### !!!
### something is going wrong with the regressions since adding all the new data
#Dataset <- all[all$sample == 'Yerkes',]
#Dataset = all[sample(nrow(all), 200), ]
Dataset <- all


Dataset$origin <- droplevels(Dataset$origin)

# RIGHT censoring - matching 'time' and 'event'

levels(Dataset$status)[levels(Dataset$status)=="Death"] <- 1
levels(Dataset$status)[levels(Dataset$status)=="Alive"] <- 0




y <- Surv(as.numeric(Dataset$age),Dataset$status)


# adding LEFT truncation

# currently optional - my attempt to control for age effects within E
Dataset$adjE <- scale(Dataset$Ext_CZ-scale(1/(1 + Dataset$age_pr_adj)))
# and now O
Dataset$adjO <- scale(Dataset$Opn_CZ-scale(1/(1 + Dataset$age_pr_adj)))
# hell, what if we do it for all of them?
Dataset$adjD <- scale(Dataset$Dom_CZ-scale(1/(1 + Dataset$age_pr_adj)))
Dataset$adjC <- scale(Dataset$Con_CZ-scale(1/(1 + Dataset$age_pr_adj)))
Dataset$adjA <- scale(Dataset$Agr_CZ-scale(1/(1 + Dataset$age_pr_adj)))
Dataset$adjN <- scale(Dataset$Neu_CZ-scale(1/(1 + Dataset$age_pr_adj)))
### LOOK ABOVE


## what OTHER adjustments to E should be here?


#y.Ltrunc <- Surv(as.numeric(Dataset$DOPRmin), as.numeric(Dataset$lastDate),Dataset$status ,
#                 type='counting')
y.Ltrunc <- Surv(Dataset$age_pr, Dataset$age,Dataset$status,  # previously age_pr_adj
                 type='counting')

# attr(y.Ltrunc, 'type') <- 'counting' # this is needed to be able to handle Cox

rmNAs = !is.na(y.Ltrunc)

yLt = y.Ltrunc[rmNAs]
#attr(y.Ltrunc, 'type')
#attr(yLt, 'type')
datX = Dataset[rmNAs,]


### P dimensions confounded with age

library(bbmle)

## Extraversion

fit.e0 <- lm(Ext_CZ ~ 1, data=datX)
# residual entry for quadratic, cubic regs:
fit.e1 <- lm(Ext_CZ ~ scale(age_pr_adj), data=datX)
fit.e2 <- lm(Ext_CZ ~ scale(age_pr_adj) + I(scale(age_pr_adj)^2), data=datX)
datX$E.resid2 <- fit.e2$residuals
fit.e3 <- lm(Ext_CZ ~ scale(age_pr_adj) + I(scale(age_pr_adj)^2) + I(scale(age_pr_adj)^3), data=datX)
datX$E.resid3 <- fit.e3$residuals

anova(fit.e1,fit.e2,fit.e3)

# DoB based?
fit.e1.DoB <- lm(Ext_CZ ~ scale(DoB), data=datX)
fit.e2.DoB <- lm(Ext_CZ ~ scale(DoB) + I(scale(DoB)^2), data=datX) # this seems to be the best (see anova)
fit.e3.DoB <- lm(Ext_CZ ~ scale(DoB) + I(scale(DoB)^2) + I(scale(DoB)^3), data=datX) # No, this is best (see AIC)

anova(fit.e0,fit.e1.DoB,fit.e2.DoB,fit.e3.DoB)
#anova(fit.e1,fit.e2,fit.e3,fit.e1.DoB,fit.e2.DoB,fit.e3.DoB)

AICctab(fit.e0,fit.e1.DoB,fit.e2.DoB,fit.e3.DoB #,fit.e1,fit.e2,fit.e3,
       ,logLik=T,weights=T,base=T,delta=T)

datX$E.r3.DoB <- fit.e3.DoB$residuals
datX$E.r3 <- fit.e3$residuals
# added for sake of LASSO
datX$E.r2.DoB <- fit.e2.DoB$residuals


# what do these residuals look like?

plot(datX$Ext_CZ, datX$E.r3.DoB)
plot(datX$age_pr_adj, datX$E.r3.DoB)

plot(datX$Ext_CZ, datX$E.resid3)
plot(datX$age_pr_adj, datX$E.resid3)


## Openness
fit.o0 <- lm(Opn_CZ ~ 1, data=datX)
fit.o1 <- lm(Opn_CZ ~ scale(age_pr_adj), data=datX)
fit.o2 <- lm(Opn_CZ ~ scale(age_pr_adj) + I(scale(age_pr_adj)^2), data=datX)
fit.o3 <- lm(Opn_CZ ~ scale(age_pr_adj) + I(scale(age_pr_adj)^2) + I(scale(age_pr_adj)^3), data=datX)
fit.o1.DoB <- lm(Opn_CZ ~ scale(DoB), data=datX)
fit.o2.DoB <- lm(Opn_CZ ~ scale(DoB) + I(scale(DoB)^2), data=datX) # this one
fit.o3.DoB <- lm(Opn_CZ ~ scale(DoB) + I(scale(DoB)^2) + I(scale(DoB)^3), data=datX) 

AICctab(fit.o0,fit.o1.DoB,fit.o2.DoB,fit.o3.DoB #, fit.o1,fit.o2,fit.o3
       , logLik=T,weights=T,base=T,delta=T)

anova(fit.o1,fit.o2,fit.o3,fit.o1.DoB,fit.o2.DoB,fit.o3.DoB)


datX$O.r2.DoB <- fit.o2.DoB$residuals
  datX$O.r2 <- fit.o2$residuals


## Dominance

fit.d0 <- lm(Dom_CZ ~ 1, data=datX)
fit.d1 <- lm(Dom_CZ ~ scale(age_pr_adj), data=datX)
fit.d2 <- lm(Dom_CZ ~ scale(age_pr_adj) + I(scale(age_pr_adj)^2), data=datX)
fit.d3 <- lm(Dom_CZ ~ scale(age_pr_adj) + I(scale(age_pr_adj)^2) + I(scale(age_pr_adj)^3), data=datX)
fit.d1.DoB <- lm(Dom_CZ ~ scale(DoB), data=datX)
fit.d2.DoB <- lm(Dom_CZ ~ scale(DoB) + I(scale(DoB)^2), data=datX) 
fit.d3.DoB <- lm(Dom_CZ ~ scale(DoB) + I(scale(DoB)^2) + I(scale(DoB)^3), data=datX) # looks like here again

AICctab(fit.d0, fit.d1.DoB,fit.d2.DoB,fit.d3.DoB #,fit.d1,fit.d2,fit.d3
       ,logLik=T,weights=T,base=T,delta=T)

anova(fit.d0, fit.d1,fit.d2,fit.d3,fit.d1.DoB,fit.d2.DoB,fit.d3.DoB)


#datX$D.r2.DoB <- fit.d2.DoB$residuals
datX$D.r3.DoB <- fit.d3.DoB$residuals
datX$D.r3 <- fit.d3$residuals


## Neuroticism

fit.n0 <- lm(Neu_CZ ~ 1, data=datX)
fit.n1 <- lm(Neu_CZ ~ scale(age_pr_adj), data=datX)
fit.n2 <- lm(Neu_CZ ~ scale(age_pr_adj) + I(scale(age_pr_adj)^2), data=datX)
fit.n3 <- lm(Neu_CZ ~ scale(age_pr_adj) + I(scale(age_pr_adj)^2) + I(scale(age_pr_adj)^3), data=datX)
fit.n1.DoB <- lm(Neu_CZ ~ scale(DoB), data=datX) # This one
fit.n2.DoB <- lm(Neu_CZ ~ scale(DoB) + I(scale(DoB)^2), data=datX)
fit.n3.DoB <- lm(Neu_CZ ~ scale(DoB) + I(scale(DoB)^2) + I(scale(DoB)^3), data=datX)

AICctab(fit.n0, fit.n1.DoB,fit.n2.DoB,fit.n3.DoB #,fit.n1,fit.n2,fit.n3,
       ,logLik=T,weights=T,base=T,delta=T)

anova(fit.n0, fit.n1,fit.n2,fit.n3,fit.n1.DoB,fit.n2.DoB,fit.n3.DoB)


datX$N.r1.DoB <- fit.n1.DoB$residuals
datX$N.r1 <- fit.n1$residuals

# stop indendation


  

  
  


# let's try a LASSO...

library(glmnet)
# see also chimpAnalyses.R

netform = data.frame(cbind(scale(datX$DoB),
                scale(datX$DoB)^2,
                scale(datX$DoB)^3))
colnames(netform) = c("DoB1","DoB2","DoB3") 
  
rmatx = model.matrix( ~ DoB1 + DoB2 + DoB3 - 1, netform)

lasso.rE = glmnet(rmatx, datX$Ext_CZ, #grouped=FALSE
                 )
lasso.rE.cv = cv.glmnet(rmatx, datX$Ext_CZ)

plot(lasso.rE.cv)

plot(lasso.rE, label=T)
plot(lasso.rE, xvar="lambda", label=T)  
plot(lasso.rE, xvar="dev", label=T) 

coef(lasso.rE, s=lasso.rE.cv$lambda.1se
)
# well, this says to leave out the cubic


lasso.rD = glmnet(rmatx, datX$Dom_CZ)
lasso.rD.cv = cv.glmnet(rmatx, datX$Dom_CZ)
plot(lasso.rD, label=T)
coef(lasso.rD, s=lasso.rD.cv$lambda.1se)


lasso.rO = glmnet(rmatx, datX$Opn_CZ)
lasso.rO.cv = cv.glmnet(rmatx, datX$Opn_CZ)
plot(lasso.rO, label=T)
coef(lasso.rO, s=lasso.rO.cv$lambda.1se)


lasso.rN = glmnet(rmatx, datX$Neu_CZ)
lasso.rN.cv = cv.glmnet(rmatx, datX$Neu_CZ)
plot(lasso.rN, label=T)
plot(lasso.rN.cv)
coef(lasso.rN, s=lasso.rN.cv$lambda.1se)

lasso.rD = glmnet(rmatx, datX$Dom_CZ)
lasso.rD.cv = cv.glmnet(rmatx, datX$Dom_CZ)
plot(lasso.rD, label=T)
plot(lasso.rD.cv)
coef(lasso.rD, s=lasso.rD.cv$lambda.1se)

## these suggest just the quadratics for O and E
