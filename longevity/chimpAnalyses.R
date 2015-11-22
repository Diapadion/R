# survival analyses

#

library(survival)

Dataset <- all[(all$sample == 'AZA') 
               | (all$sample == 'Yerkes') | (all$sample == 'Taronga'),]

# Alex's code for finding the ideal distribution

thedistributions<-c("weibull","exponential","lognormal","loglogistic")

# RIGHT censoring - matching 'time' and 'event'

levels(Dataset$status)[levels(Dataset$status)=="Death"] <- 1
levels(Dataset$status)[levels(Dataset$status)=="Alive"] <- 0

y <- Surv(as.numeric(Dataset$lastDate),Dataset$status)


themodel <- (y ~ as.factor(Dataset$sex) + Dataset$age_pr + #Dataset$age + 
               as.factor(Dataset$origin) + as.factor(Dataset$LvZ) + 
               Dataset$Dom_CZ + Dataset$Ext_CZ + Dataset$Con_CZ +
               Dataset$Agr_CZ + Dataset$Neu_CZ + Dataset$Opn_CZ
)

model.p <- (y ~ Dataset$Dom_CZ + Dataset$Ext_CZ + Dataset$Con_CZ +
               Dataset$Agr_CZ + Dataset$Neu_CZ + Dataset$Opn_CZ
)

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
Result = data.frame(distlist, LLlist1, LLlist2, estimates, LLlist1 - LLlist2)
names(Result) = c("Distribution", "-2*LL(Baseline)", "-2*LL(Full)","Estimate")
Result = Result[order(Result[,3]),]
Result

# loglogistic? weibull?


### The model(s)

mod1.w <- survreg(themodel, dist = 'weibull')
mod1.ll <- survreg(themodel, dist = 'loglogistic')
mod1.e <- survreg(themodel, dist = 'exponential')

mod.p.ll <- survreg(model.p, dist = 'loglogistic')
  
summary(mod1.ll)

library(car)


### INTERVAL censoring

y.Ltrunc <- Surv(as.numeric(Dataset$DOPRmin), as.numeric(Dataset$lastDate),Dataset$status ,
                 type='counting')

rmNAs = !is.na(y.Ltrunc)

yLt = y.Ltrunc[rmNAs]
datX = Dataset[rmNAs,]

mod.trunc <- survreg(yLt ~ as.factor(sex) + #Dataset$age + 
                       as.factor(origin) + as.factor(LvZ) + 
                       Dom_CZ + Ext_CZ + Con_CZ +
                       Agr_CZ + Neu_CZ + Opn_CZ,
                     dist = "loglogistic", data=datX
                     )
                 
# Thought:                  
# subtract a year from DoD of those who died before being rated...?                 
                 

### left TRUNCATION??



### LASSO...

library(glmnet)

netform <- Dataset[,c(2,62,66,71,72,73,74,75,76,77)]
netform$origin <- droplevels(netform$origin)
x <- model.matrix( ~ sex + age_pr + origin + LvZ + 
                     Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ - 1, netform)

x <- x[,-3] # fix some origin glitches
y1 <- y[-354,]
  
net1 <- glmnet(x, y1, family="cox")

# this isn't working:
net1.cv <- cv.glmnet(x, y1, family="cox", type.measure = "deviance", grouped=FALSE)
plot(net1.cv)

plot(net1, label=T)
plot(net1, xvar="lambda", label=T)  
plot(net1, xvar="dev", label=T) 


coef(net1, s=net1.cv$lambda.min
     )
coef(net1, s=0.01)


