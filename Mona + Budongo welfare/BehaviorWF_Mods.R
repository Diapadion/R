###
# Importing and aggregating behavioural observations
#
###


### manual importation of Lauren's scores

## these lines summarize the aggregation rules followed:
## (probably don't use)
components=welfareagg
attach(components)
components$totalwelfare=(Q3 +Q4.1 +Q4.2+ Q5 +Q6.1 +Q6.2 +Q7 -Q8 +Q9 +Q10)
components$totalswb=(SWB.Q1 + SWB.Q2 + SWB.Q3 + SWB.Q4)
components$welfareswb=(Q3 +Q4.1 +Q4.2+ Q5 +Q6.1 +Q6.2 +Q7 -Q8 +Q9 +Q10+SWB.Q1 + SWB.Q2 + SWB.Q3 + SWB.Q4)
detach(components)




## What do we want?
## 
## counts of a variety of negative and positive behaviors
## regurgitation, cacophagy, urine drinking, plucking,
## play, grooming and receiving
##
## How do we deal with imbalanced collection of data?
## - focals are supposed to be broadly matched across all indivuals
## - scans?... balance by noting number of scans in which they appear?
##
## Alternative: modeling all data at once
##  e.g. categorical -> binary variables in scans
##
## two different models: one for negative (focal), one for positive (scan) behaviours







### importing social data


scans <- read.csv("Scans.csv")
# from this we get Play, Allo-grooming, Auto-grooming
table(scans$PE)[9]/sum(scans$PE!='OOS') # play

sum(scans$PE!='OOS')

sum(scans$KD!='OOS')
sum(scans$LB!='OOS')

library(reshape2)
library(plyr)
meltedScan = melt(scans, id.vars = c(1:10) #, variable.name = scan.vars
                  )
meltedScan = meltedScan[meltedScan$Scan.Interval != '',] # remove some empties
meltedScan = meltedScan[meltedScan$variable != 'VL',]

meltedScan$value = as.factor(meltedScan$value)
table(meltedScan$value)

meltedScan$value = revalue(meltedScan$value, c("FO?"="FO","GR"="G+R","R "="R","R+G"="G+R","R+R"="R","R+SG"="SG+R","RE "="RE")
                              )
meltedScan = meltedScan[(!meltedScan$value %in% c('','?','DA','LB')),]
meltedScan = droplevels(meltedScan)

meltedScan$variable = revalue(meltedScan$variable, c(CI="Cindy", DA="David", ED="Edith", EM="Emma", EV="Eva", FK="Frek", HL="Heleen", KD="Kindia",
                                               KL="Kilimi", LB="Liberius", LI="Lianne", LO="Louis", LU="Lucy", PA="Paul", PE="Pearl",
                                               Q="Qafzeh", RE="Rene", SO="Sofie"))


recastScan = cbind(meltedScan,model.matrix( ~ 0 + value, meltedScan))

focals <- read.csv('Focals.csv', strip.white = T)

table(focals$Regurgitated)
table(focals$Did.focal.eat.faeces)
table(focals$Did.focal.drink.or.touch.urine)
table(focals$Did.focal.self.groom)
table(focals$Self.fur.pluck)
table(focals$Focal.plucked.fur.from.another)
table(focals$Focal.fur.plucked.by.another)




groom <- read.csv("Grooming.csv")


### WF ratings
# we have two time points

wf = read.csv(file = "Edinburgh chimp welfare ratings.csv")

# t1 = July to December, 2014

focals1 = focals[focals$Month %in% c("Jul","Aug","Sep","Oct","Nov","Dec") & focals$Year == 2014,]

focals1$Focal.ID = revalue(focals1$Focal.ID, c(CI="Cindy", DA="David", ED="Edith", EM="Emma", EV="Eva", FK="Frek", HL="Heleen", KD="Kindia",
                                               KL="Kilimi", LB="Liberius", LI="Lianne", LO="Louis", LU="Lucy", PA="Paul", PE="Pearl",
                                               Q="Qafzeh", RE="Rene", SO="Sofie"))

focals1 = focals1[focals1$Focal.ID != '',]

#table(focals1$Did.focal.drink.or.touch.urine) # this var is clean...

focals1$Regurgitated = revalue(focals1$Regurgitated, c("n"="N","N/A"="N"))
levels(focals1$Regurgitated)[1] = 'N'

table


# t2 = January to June, 2015

## Scans
scans2 = meltedScan[meltedScan$Month %in% c("Jan","Feb","Mar","Apr","May","Jun") & meltedScan$Year == 2015,]

## Focals
focals2 = focals[focals$Month %in% c("Jan","Feb","Mar","Apr","May","Jun") & focals$Year == 2015,]
#levels(focals2$Focal.ID)

# all kinds of shit cleaning
focals2$Focal.ID = revalue(focals2$Focal.ID, c(CI="Cindy", DA="David", ED="Edith", EM="Emma", EV="Eva", FK="Frek", HL="Heleen", KD="Kindia",
                            KL="Kilimi", LB="Liberius", LI="Lianne", LO="Louis", LU="Lucy", PA="Paul", PE="Pearl",
                            Q="Qafzeh", RE="Rene", SO="Sofie"))

focals2 = focals2[focals2$Focal.ID != '',]

levels(focals2$Did.focal.drink.or.touch.urine)[1] <- 'N'

table(focals2$Self.fur.pluck)
levels(focals2$Self.fur.pluck)[7] <- 'Y'
levels(focals2$Self.fur.pluck)[1] <- 'N'

levels(focals2$Did.focal.eat.faeces)[1] <- 'N'

#focals2$Did.focal.drink.or.touch.urine = revalue("N"="N", "D"="Y"#, ""=N
 #                                                )

focals2$Focal.fur.plucked.by.another = revalue(focals2$Focal.fur.plucked.by.another,c("Y KD"="Y","Y PE"="Y", "Y SO"="Y","Y? Q"="Y"))
levels(focals2$Focal.fur.plucked.by.another)[1] <- 'N'

focals2$Focal.plucked.fur.from.another = revalue(focals2$Focal.plucked.fur.from.another,c("Y CI"="Y","Y KD"="Y","Y? PE"="Y", 
                                                                                        "Y LB"="Y","Y LI"="Y","Y? CI"="Y",
                                                                                        "Y? KD LB"))
levels(focals2$Focal.plucked.fur.from.another)[1] <- 'N'

#table(focals2$Focal.plucked.fur.from.another)

focals2$Focal.displaced.by.another = revalue(focals2$Focal.displaced.by.another, c("Y? ED"="Y","Y? RE"="Y"))
levels(focals2$Focal.displaced.by.another)[1] = 'N'

temp = merge(focals2, wf[wf$time==2,], by.x= "Focal.ID", "Chimp")

#table(focals2$Did.focal.self.groom)



library(lme4)

fwf.1 <- lmer(totalwelfare ~ Regurgitated + Did.focal.eat.faeces + Did.focal.drink.or.touch.urine +
   Self.fur.pluck + Focal.plucked.fur.from.another + Focal.fur.plucked.by.another +
   Did.focal.self.groom 
   + (1 | Focal.ID) #+ (1 | Month) + (1 | Day)
              ,data = temp
              )  

fwf.1z <- lmer(totalwelfare ~ Regurgitated + (1 | Focal.ID) #+ (1 | Month) + (1 | Day)
               ,data = temp
)  

relgrad <- with(fwf.1@optinfo$derivs,solve(Hessian,gradient))
max(abs(relgrad))

tt <- getME(fwf.1,"theta")
ll <- getME(fwf.1,"lower")
min(tt[ll==0])

library(optimx)
fwf.LBFGSB <- update(fwf.1,control=lmerControl(optimizer="optimx",
                                                   optCtrl=list(method="L-BFGS-B")))
fwf.nlminb <- update(fwf.1,control=lmerControl(optimizer="optimx",
                                               optCtrl=list(method="nlminb")))
# none of the above can fix the problem



fwf.0.regurg <- glmer(Regurgitated ~ totalwelfare + (1 | Focal.ID ), data = temp,
                family=binomial(link="logit")) # *

fwf.0.f_eat <- glmer(Did.focal.eat.faeces ~ totalwelfare + (1 | Focal.ID ), data = temp,
                family=binomial(link="logit")) # *

fwf.0.f_drink <- glmer(Did.focal.drink.or.touch.urine ~ totalwelfare + (1 | Focal.ID ), data = temp,
                     family=binomial(link="logit"))

fwf.0.f_spluck <- glmer(Self.fur.pluck ~ totalwelfare + (1 | Focal.ID ), data = temp,
                       family=binomial(link="logit"))

fwf.0.f_allopluck <- glmer(Focal.plucked.fur.from.another ~ totalwelfare + (1 | Focal.ID ), data = temp,
                        family=binomial(link="logit"))

fwf.0.f_pluckby <- glmer(Focal.fur.plucked.by.another ~ totalwelfare + (1 | Focal.ID ), data = temp,
                        family=binomial(link="logit"))

Self.fur.pluck
Did.focal.drink.or.touch.urine




library(glmnet)

netform2 <- droplevels(temp[,c(21,29,31,32,33,35,36,37)])

netform2 = model.matrix(~ . - 1, data=netform2)
#netform2 = Matrix(netform2, sparse=TRUE)
inherits(netform2, "sparseMatrix")

netform2 = netform2[,c(2,3,4,5,6,7,8,9)]

netform2 <- netform2[, ncol(netform2):1]

### full diagnostics

# will need to run multiple cv's, for lambda and alpha
# http://stats.stackexchange.com/questions/84012/choosing-optimal-alpha-in-elastic-net-logistic-regression

# Questions:
#
# standardize = F ?
# what parameters can I change and covTest remains consistent?
#
# http://web.stanford.edu/~hastie/TALKS/glmnet_webinar.pdf
# # https://web.stanford.edu/~hastie/glmnet/glmnet_alpha.html # sparse matrices at bottom


fwf2.net <- glmnet(netform2, temp$totalwelfare,
                   family = "gaussian",
                   standardize=T, alpha = 0.7,lambda.min.ratio=0.00001,  nlambda=1000
                   #nlambda=1000, lambda.min.ratio = 0.00001
                   )
#plot(fwf2.net)

fwf2.cvnet <- cv.glmnet(netform2, temp$totalwelfare,
                   family = "gaussian", nfolds=20)
plot(fwf2.cvnet)
# coef(fwf2.cvnet, 
#      #s=min(fwf2.net$lambda)
#      s=fwf2.net$lambda[40]
#      ,exact=F
# )

coef(fwf2.net, 
     s=fwf2.cvnet$lambda.min
     #s=fwf2.cvnet$lambda.1se
)
plot(fwf2.net)
plot(fwf2.net, xvar="lambda", label=T)  
plot(fwf2.net, xvar="dev", label=T)  

# glmnetCovTest(fwf2.net, netform2, temp$totalwelfare)

# library(hdlm)
# summary(fwf2.net)

library(lars)
tst.lars  <- lars(netform2, temp$totalwelfare, type="lasso", intercept=T,max.steps = 100000)
#lcv.fwf2.net <- cv.lars(netform2, temp$totalwelfare, type="lasso",plot.it=T,se=T)
coef(tst.lars)

# library(covTest)
cvl.fwf2 <- covTest(tst.lars, netform2, temp$totalwelfare)
covTest(tst.lars, netform2, temp$totalwelfare)

# taking it back to OLS


fwf2.ols <- lmer(totalwelfare ~ Regurgitated + Did.focal.eat.faeces + Did.focal.drink.or.touch.urine +
             Focal.displaced.by.another
              + (1 | Focal.ID) #+ (1 | Month) + (1 | Day)
              ,data = temp
)
# still not working...



### more useful glmnet links
# http://stats.stackexchange.com/questions/70249/feature-selection-model-with-glmnet-on-methylation-data-pn
# http://stats.stackexchange.com/questions/77546/how-to-interpret-glmnet
# http://stats.stackexchange.com/questions/34859/how-to-present-results-of-a-lasso-using-glmnet


