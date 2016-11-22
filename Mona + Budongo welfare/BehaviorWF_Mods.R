###
# Importing and aggregating behavioural observations
#
###

#### NEW TODO
# correlate PLay behaviour with Grooming, Receiving
# check the amount of supplants in set for calculating DA scores


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

# some exploratory plots
interaction.plot(wf$time, wf$Chimp, wf$welfareswb, type='b', col = c(1:18))

library(ggplot2)
ggplot(wf, aes(time, welfareswb,colour=Chimp)) + 
  geom_line() + 
  geom_point()

ggplot(wf, aes(time, totalwelfare)) + 
  geom_line() + 
  geom_point()

# are they actually different?
t.test(wf$welfareswb[wf$time==1],wf$welfareswb[wf$time==2])




# t1 = July to December, 2014

## Scans

scans1 = recastScan[recastScan$Month %in% c("Jul","Aug","Sep","Oct","Nov","Dec") & recastScan$Year == 2014,]

scans1 = merge(scans1, wf[wf$time==1,], by.x= "variable", "Chimp")

netform1s = scans1[,c(13:27)]
netform1s = model.matrix(~ . - 1, data=netform1s)


## Focals

focals1 = focals[focals$Month %in% c("Jul","Aug","Sep","Oct","Nov","Dec") & focals$Year == 2014,]

focals1$Focal.ID = revalue(focals1$Focal.ID, c(CI="Cindy", DA="David", ED="Edith", EM="Emma", EV="Eva", FK="Frek", HL="Heleen", KD="Kindia",
                                               KL="Kilimi", LB="Liberius", LI="Lianne", LO="Louis", LU="Lucy", PA="Paul", PE="Pearl",
                                               Q="Qafzeh", RE="Rene", SO="Sofie"))

focals1 = focals1[focals1$Focal.ID != '',]

#table(focals1$Did.focal.drink.or.touch.urine) # this var is clean...

focals1$Regurgitated = revalue(focals1$Regurgitated, c("n"="N","N/A"="N", "N?"="N","Y?"="Y"))
levels(focals1$Regurgitated)[1] = 'N'

table(focals1$Did.focal.drink.or.touch.urine)
levels(focals1$Did.focal.drink.or.touch.urine)[4] <- 'Y'
focals1$Did.focal.drink.or.touch.urine <- droplevels(focals1$Did.focal.drink.or.touch.urine)

levels(focals1$Self.fur.pluck)[1] <- 'N'
levels(focals1$Self.fur.pluck)[3] <- 'N'
focals1$Self.fur.pluck <- droplevels(focals1$Self.fur.pluck)

levels(focals1$Did.focal.eat.faeces)[1] <- 'N'


focals1$Focal.fur.plucked.by.another = revalue(focals1$Focal.fur.plucked.by.another,
                                               c('?'='N','N SO'='N','N PA'='N','Y EM'='Y','Y EV SO'="Y","Y PA"="Y", "Y LO"="Y","Y FK"="Y"))
levels(focals1$Focal.fur.plucked.by.another)[1] <- 'N'

focals1$Focal.plucked.fur.from.another = revalue(focals1$Focal.plucked.fur.from.another,
                                                 c('?'='N',"Y EM"="Y","Y EV"="Y","Y EV SO"="Y",'Y FK'='Y','Y HL'='Y',
                                                   "Y LB"="Y","Y LU"="Y","Y PA"="Y"))
levels(focals1$Focal.plucked.fur.from.another)[1] <- 'N'

levels(focals1$Focal.displaced.by.another)[1] = 'N'

table(focals1$Distance.of.nearest.neighbour)
focals1$Distance.of.nearest.neighbour = droplevels(focals1$Distance.of.nearest.neighbour)
levels(focals1$Distance.of.nearest.neighbour) = c("NA","0.5",'0','15','1','1','2','2','3','3','4','5','5','9','NA')
focals1$Distance.of.nearest.neighbour = as.numeric(focals1$Distance.of.nearest.neighbour) # ... is this really working?

levels(focals1$Did.focal.self.groom)[1] <-'N'
levels(focals1$Eating.at.any.point.in.the.focal)[3] <- 'Y'
levels(focals1$Eating.at.any.point.in.the.focal)[1] <- 'N'

levels(focals1$Focal.groom.with.another)[1]<- 'N'
focals1$Focal.groom.with.another = droplevels(focals1$Focal.groom.with.another)


focals1 = merge(focals1, wf[wf$time==1,], by.x= "Focal.ID", "Chimp")



# t2 = January to June, 2015

## Scans
scans2 = recastScan[recastScan$Month %in% c("Jan","Feb","Mar","Apr","May","Jun") & recastScan$Year == 2015,]

scans2 = merge(scans2, wf[wf$time==2,], by.x= "variable", "Chimp")

netform2s = scans2[,c(13:27)]
netform2s = model.matrix(~ . - 1, data=netform2s)
#netform2s = netform2s[,-c(1,4,5,10)]


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

table(focals2$Distance.of.nearest.neighbour)
focals2$Distance.of.nearest.neighbour = droplevels(focals2$Distance.of.nearest.neighbour)
#gsub('[:alpha:]','',levels(focals2$Distance.of.nearest.neighbour))
#focals2$Distance.of.nearest.neighbour = revalue(focals2$Distance.of.nearest.neighbour, c("0.5M"=0.5,""))
levels(focals2$Distance.of.nearest.neighbour) = c("0.5",'0','1','2','3','4','5','9','NA')
focals2$Distance.of.nearest.neighbour = as.numeric(focals2$Distance.of.nearest.neighbour)

levels(focals2$Eating.at.any.point.in.the.focal)[3] <- 'Y'
focals2$Eating.at.any.point.in.the.focal = droplevels(focals2$Eating.at.any.point.in.the.focal)

focals2$Focal.groom.with.another = droplevels(focals2$Focal.groom.with.another)


focals2 = merge(focals2, wf[wf$time==2,], by.x= "Focal.ID", "Chimp")

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



### LASSO models 

library(glmnet)

## Focals

# t1
#colnames(focals1)
netform1f <- droplevels(focals1[,c(21,29,31,32,33,34,35,36,37,18,19)])

# netform1f.x = as.matrix(as.data.frame(lapply(netform1f, as.numeric))) # as preferred by Emil OWK


netform1f = model.matrix(~ . - 1, data=netform1f)

netform1f = netform1f[,c(2,3,4,5,6,7,8,9,10,11,12)]

fwf1f.net <- glmnet(netform1f.x, focals1$welfareswb,
                    family = "gaussian",
                    standardize=T, alpha = 1,lambda.min.ratio=0.00001,  nlambda=1000
                    #nlambda=1000, lambda.min.ratio = 0.00001
)

fwf1f.cvnet <- cv.glmnet(netform1f, focals1$welfareswb, family = "gaussian", nfolds=20)

plot(fwf1f.cvnet)

coef(fwf1f.net, 
     s=fwf1f.cvnet$lambda.min
     #s=fwf1f.cvnet$lambda.1se
)

plot(fwf1f.net)

#
library(lme4)
f1.mm <- lmer(welfareswb ~ Regurgitated + Did.focal.eat.faeces + Did.focal.drink.or.touch.urine +
                Did.focal.self.groom + Self.fur.pluck + Focal.groom.with.another + Focal.fur.plucked.by.another +
                     Focal.displaced.by.another + Distance.of.nearest.neighbour + Eating.at.any.point.in.the.focal
                   + (1 | Focal.ID) #+ (1 | Month) + (1 | Day)
                   , data = focals1
  ) # I don't think this is going to work, ever

# t2

netform2f <- droplevels(focals2[,c(21,29,31,32,33,34,35,36,37,18,19)])

netform2f = model.matrix(~ . - 1, data=netform2f)
#netform2 = Matrix(netform2, sparse=TRUE)
inherits(netform2f, "sparseMatrix")

netform2f = netform2f[,c(2,3,4,5,6,7,8,9,10,11,12)]

#netform2f <- netform2[, ncol(netform2f):1]

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


fwf2f.net <- glmnet(netform2f, focals2$welfareswb,
                   family = "gaussian",
                   standardize=T, alpha = 1,lambda.min.ratio=0.00001,  nlambda=1000
                   #nlambda=1000, lambda.min.ratio = 0.00001
                   )

fwf2f.cvnet <- cv.glmnet(netform2f, focals2$welfareswb,
                   family = "gaussian", nfolds=20)
plot(fwf2f.cvnet)
# coef(fwf2.cvnet, 
#      #s=min(fwf2.net$lambda)
#      s=fwf2.net$lambda[40]
#      ,exact=F
# )

coef(fwf2f.net, 
     s=fwf2f.cvnet$lambda.min
     #s=fwf2.cvnet$lambda.1se
)
plot(fwf2f.net)
plot(fwf2f.net, xvar="lambda", label=T)  
plot(fwf2f.net, xvar="dev", label=T)  

# glmnetCovTest(fwf2.net, netform2, temp$totalwelfare)

# library(hdlm)
# summary(fwf2.net)


## Scans

# t1

fwf1s.net <- glmnet(netform1s, scans1$welfareswb,
                    family = "gaussian",
                    standardize=T, alpha = 1,lambda.min.ratio=0.00001,  nlambda=1000
             )

fwf1s.cvnet <- cv.glmnet(netform1s, scans1$welfareswb,
                         family = "gaussian", nfolds=20)
plot(fwf1s.cvnet)

coef(fwf1s.net, 
     s=fwf1s.cvnet$lambda.min
     #s=fwf1s.cvnet$lambda.1se
)

table(scans1$variable[scans1$valuePL == 1])



fwf2s.net <- glmnet(netform2s, scans2$welfareswb,
                    family = "gaussian",
                    standardize=T, alpha = 1,lambda.min.ratio=0.00001,  nlambda=1000
                    #nlambda=1000, lambda.min.ratio = 0.00001
)
#plot(fwf2s.net)

fwf2s.cvnet <- cv.glmnet(netform2s, scans2$welfareswb,
                         family = "gaussian", nfolds=20)
plot(fwf2s.cvnet)
coef(fwf2s.net, 
     s=fwf2s.cvnet$lambda.min
     #s=fwf2.cvnet$lambda.1se
)
plot(fwf2s.net)
plot(fwf2s.net, xvar="lambda", label=T)  
plot(fwf2s.net, xvar="dev", label=T)

fwf2s.lars  <- lars(netform2s, scans2$welfareswb, type="lasso", intercept=T,max.steps = 100000)

#cvl.fwf2 <- covTest(tst.lars, netform2, temp$totalwelfare)
covTest(fwf2s.lars, netform2s, scans2$welfareswb)

table(scans2$variable[scans2$valuePL == 1])



library(lars)
tst.lars  <- lars(netform2f, focals2$welfareswb, type="lasso", intercept=T,max.steps = 100000)
#lcv.fwf2.net <- cv.lars(netform2, temp$totalwelfare, type="lasso",plot.it=T,se=T)
coef(tst.lars)

# library(covTest)
cvl.fwf2 <- covTest(tst.lars, netform2, temp$totalwelfare)
covTest(tst.lars, netform2f, focals2$welfareswb)

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



### summary stats on number of scans, focals
summary(as.vector(table(droplevels(focals1$Focal.ID))))
sd(as.vector(table(droplevels(focals1$Focal.ID))))

summary(as.vector(table(droplevels(focals2$Focal.ID))))
sd(as.vector(table(droplevels(focals2$Focal.ID))))




### Chimps 2016 abstract snippet
# Welfare was found to be predicted by observed negative behaviours (e.g. regurgitation, cacophagy), using LASSO penalized linear modeling and covariance tests.



### Katie Slocombe directed model revisions - 11/11/2016

netform1f = netform1f[,c(-9,-11)]

fwf1f.net <- glmnet(netform1f, focals1$welfareswb,
                    family = "gaussian",
                    standardize=T, alpha = 1,lambda.min.ratio=0.00001,  nlambda=1000
                    #nlambda=1000, lambda.min.ratio = 0.00001
)

fwf1.cvnet <- cv.glmnet(netform1f, focals1$welfareswb,
                         family = "gaussian", nfolds=20)
plot(fwf1f.cvnet)

coef(fwf1f.net, 
     s=fwf1f.cvnet$lambda.min
     #s=fwf1.cvnet$lambda.1se
)


netform2f = netform2f[,c(-9,-11)]

fwf2f.net <- glmnet(netform2f, focals2$welfareswb,
                    family = "gaussian",
                    standardize=T, alpha = 1,lambda.min.ratio=0.00001,  nlambda=1000
                    #nlambda=1000, lambda.min.ratio = 0.00001
)

fwf2f.cvnet <- cv.glmnet(netform2f, focals2$welfareswb,
                         family = "gaussian", nfolds=20)
plot(fwf2f.cvnet)

coef(fwf2f.net, 
     s=fwf2f.cvnet$lambda.min
     #s=fwf2.cvnet$lambda.1se
)
 

netform1s = netform1s[,c(-2, -3, -5, -15)]   # remove EA, FO, TR, CL

fwf1s.net <- glmnet(netform1s, scans1$welfareswb,
                    family = "gaussian",
                    standardize=T, alpha = 1,lambda.min.ratio=0.00001,  nlambda=1000
)

fwf1s.cvnet <- cv.glmnet(netform1s, scans1$welfareswb,
                         family = "gaussian", nfolds=20)
plot(fwf1s.cvnet)

coef(fwf1s.net, 
     s=fwf1s.cvnet$lambda.min
     #s=fwf1s.cvnet$lambda.1se
)


netform2s = netform2s[,c(-2, -3, -5, -15)]   # remove EA, FO, TR, CL

fwf2s.net <- glmnet(netform2s, scans2$welfareswb,
                    family = "gaussian",
                    standardize=T, alpha = 1,lambda.min.ratio=0.00001,  nlambda=1000
)

fwf2s.cvnet <- cv.glmnet(netform2s, scans2$welfareswb,
                         family = "gaussian", nfolds=20)
plot(fwf2s.cvnet)

coef(fwf2s.net, 
     s=fwf2s.cvnet$lambda.min
     #s=fwf1s.cvnet$lambda.1se
)
