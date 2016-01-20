### Analysis of Ruth Sonnweber's cognitive data

# 1. Distinguish between Interaction levels
#   a. chimps who did not participate
#   b. chimps who were trained but did not proceed to testing (EM, LB, ED, LO, DA)
#   c. chimps who were tested but did not complete all stages (CI, EV, PA)
#   d. chimps who finished all tasks (FK, KL, PE)
# 2. Look at the number of trials taken to complete each stage of training
#     discrete-time hazard model
# 3. Model accuracy across all trials
#   - all training trials? (etc...)
# 4. Model RT
#   - number of touches

#######

### [1] Interaction levels

# this section may be doomed to failure, and ought to be only used for visualization
# see [2] for replacement

# a. HE, LI, RE, Q, KD, LU, SO
# b. EM, LB, ED, LO, DA
# c. CI, EV, PA
# d. FK, KL, PE 

RSpartic = as.ordered(c(2,1,1,1,2,3,0,3,0,0,1,1,0,2,3,0,0,0))
intLvlPers = cbind(aggPers,RSpartic)

RStm <- aggregate(intLvlPers, by=list(intLvlPers$RSpartic), FUN=mean)
RSts <- aggregate(intLvlPers, by=list(intLvlPers$RSpartic), FUN=sd)

mp = barplot(height=as.matrix(RStm[4:9]),beside=TRUE,
             #legend.text=c('Never participated','Incomplete participation','Completed full sessions')
             ,ylim=c(0,7))

segments(c(mp), c(t(t(RStm[4:9] - RSts[4:9]))), c(mp),c(t(t(RStm[4:9] + RSts[4:9]))), lwd=2)

### a possible addition:
### compare individuals who never participated, to those who did (to some degree)

## also... Lyndsey was alive
## this will have impact on how we calculate Z scores for pers

RSpartic = as.ordered(c(1,1,1,1,1,1,0,1,0,0,1,1,0,1,1,0,0,0,0))
intLvlPers2 = cbind(RSpartic, aggPers)

RStm <- aggregate(intLvlPers2, by=list(intLvlPers2$RSpartic), FUN=mean)
RSts <- aggregate(intLvlPers2, by=list(intLvlPers2$RSpartic), FUN=sd)

mp = barplot(height=as.matrix(RStm[5:10]),beside=TRUE,
             #legend.text=c('Never participated','Incomplete participation','Completed full sessions')
             ,ylim=c(0,7))

segments(c(mp), c(t(t(RStm[5:10] - RSts[5:10]))), c(mp),c(t(t(RStm[5:10] + RSts[5:10]))), lwd=2)


c.t = t.test(intLvlPers2$Conscientiousness[intLvlPers2$RSpartic==1],intLvlPers2$Conscientiousness[intLvlPers2$RSpartic==0])
# definitely
n.t = t.test(intLvlPers2$Neuroticism[intLvlPers2$RSpartic==1],intLvlPers2$Neuroticism[intLvlPers2$RSpartic==0])
# yes
o.t = t.test(intLvlPers2$Openness[intLvlPers2$RSpartic==1],intLvlPers2$Openness[intLvlPers2$RSpartic==0])
# yes
d.t = t.test(intLvlPers2$Dominance[intLvlPers2$RSpartic==1],intLvlPers2$Dominance[intLvlPers2$RSpartic==0])
# yes





# starting from 'scratch'


booterLvl <- NULL
for (i in 1:500){
  booterLvl = rbind(booterLvl,intLvlPers)
}

  
  
library(nnet)
RS.mult.lvl.0 <- multinom(RSpartic ~ Dominance + Conscientiousness + Openness + Neuroticism +
                            Agreeableness + Extraversion,  data = intLvlPers)
# this doesn't _really_ seem lke it has worked


#polr doesn't work for all predictors
library(MASS)
RS.om.lvl.0 <- polr(RSpartic ~ Dominance + Conscientiousness + Openness + Neuroticism +
                      #Agreeableness + 
                      Extraversion,
                    data = intLvlPers, model = "probit"
                    )

# nor does clm...
library(ordinal)
RS.om.lvl.b0 <- clm(RSpartic ~ Dominance + Conscientiousness + Openness + Neuroticism +
       Agreeableness + Extraversion,
     data = booterLvl #, link = "probit"
)

saveB = Boot(RS.om.lvl.0, R = 1000, method = 'case') # doens't work


# ... nope
library(rms)
RS.om.lvl.0 <- #orm # is original
  lrm(RSpartic ~ Dominance + Conscientiousness + Openness + Neuroticism +
                     Agreeableness + Extraversion,
                   data = intLvlPers #, model = "probit"
)


# 
library(glmnet)

fit3=glmnet(as.matrix(intLvlPers[,3:8]),
            as.double(intLvlPers$RSpartic)-1,
            #lapply(intLvlPers$RSpartic,as.numeric),
            family="multinomial")


# I have no idea
library(VGAM)
RS.v.0 <- vglm(RSpartic ~ Dominance + Conscientiousness + Openness + Neuroticism +
                 Agreeableness + Extraversion,
               data = intLvlPers,
               family=cumulative(link="multilogit", parallel=TRUE)
)


# let's do this first with the Tukey tests
#library(multcomp)
library(DTK)
RlvlS.dtk.d = DTK.test(intLvlPers$Dominance, intLvlPers$RSpartic)
RlvlS.dtk.c = DTK.test(intLvlPers$Conscientiousness, intLvlPers$RSpartic)
RlvlS.dtk.n = DTK.test(intLvlPers$Neuroticism, intLvlPers$RSpartic)
RlvlS.dtk.o = DTK.test(intLvlPers$Openness, intLvlPers$RSpartic)

library(MASS)
mod.polr.o <- polr(RSpartic ~ Openness + I(Openness^2), data=intLvlPers)
mod.polr.c <- polr(RSpartic ~ Conscientiousness + I(Conscientiousness^2), data=intLvlPers)
mod.polr.d <- polr(RSpartic ~ Dominance + I(Dominance^2), data=intLvlPers) # + I(Dominance^2)
mod.polr.n <- polr(RSpartic ~ Neuroticism + I(Neuroticism^2), data=intLvlPers)

# below is consistent with above
mod.polr.ce <- polr(RSpartic ~ Extraversion + Conscientiousness, data=intLvlPers)
mod.polr.oa <- polr(RSpartic ~ Openness + Agreeableness, data=intLvlPers)


mod.polr.odnc <- polr(RSpartic ~ Openness + Dominance + Neuroticism + Conscientiousness, data=intLvlPers)
mod.polr.all <- polr(RSpartic ~ Extraversion + Openness + Dominance + Neuroticism + Conscientiousness, data=intLvlPers)



# [2] Trials before drop-out
#     
  

# should be able to model each training stage / individual with Surv
# with frailty for each stage, and individual
# ending in either completion of the training or dropout


#TraTri = temp[temp$stage!='test',]
#TraTri.1 = TraTri[TraTri$Correctness==' Correct',]

library(plyr)
#TraTri = aggregate(TraTri, by=list('chimp','stage'), FUN=count)

TraTri = count(temp, c("chimp","stage"))
TraTri.1 = count(TraTri.1, c("chimp","stage"))
TraTri$correct = TraTri.1$freq

TraTri$prop = TraTri$correct / TraTri$freq

TraTri = merge(TraTri,aggPers, by.x= "chimp", "Chimp")

# adding a column for whether the chimp dropped out or not (0: in, 1: dropped)
TraTri = cbind(TraTri, dropped = c(0,0,0,1,1,0,0,0,0,1,0,0,0,1,0,0,0,1,0,0,1,0,0,0,0,1,0,0,1))

TraTri = merge(TraTri,aggPers, by.x= "chimp", "Chimp")

library(survival)
dOut = Surv(TraTri$freq, TraTri$dropped, type='right')

# which distribution should we use?
themodel <- (dOut ~ TraTri$Dominance + TraTri$Conscientiousness + TraTri$Openness + 
               TraTri$Neuroticism + TraTri$Agreeableness + TraTri$Extraversion)
thedistributions<-c("weibull","exponential","lognormal","loglogistic")

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


# basic continuous right censored survival model

RS.drop.aft <- survreg(dOut ~ Dominance + Conscientiousness + Openness + Neuroticism +
                      Agreeableness + Extraversion, data = TraTri, dist='lognormal')

RS.drop.aft.frail <- survreg(dOut ~ Dominance + Conscientiousness + Openness + Neuroticism +
                     Agreeableness + Extraversion +
                       frailty(stage)
                       , data = TraTri, dist='lognormal')
# Significant effect for Conscientiousness
# high Conscientious chimps stay in the task for more trials



# Cox to double check
RS.drop.cox <- coxph(dOut ~ Dominance + Conscientiousness + Openness + Neuroticism +
                       Agreeableness + Extraversion
                     + frailty(chimp)
                     , data = TraTri)


# sketch model

RS.trial.lmm.tot <- lmer(log(freq) ~ Dominance + Conscientiousness + Openness + Neuroticism +
                       Agreeableness + Extraversion +
                       (1 | chimp) + (1 | stage)
                     , data = TraTri)
                       
RS.trial.lmm.prop <- lmer(prop ~ Dominance + Conscientiousness + Openness + Neuroticism +
                       Agreeableness + Extraversion +
                       (1 | chimp) + (1 | stage)
                     , data = TraTri)

# I don't think there is anything here for this kind of model

## Can we model the cumulative functions? Is that what the GLMs do?



### [3] Accuracy

# "simple" GLMM of accuracy predicted by personality
library(lme4)
rs.glm1 <- glmer(Correctness ~ Dominance + Conscientiousness + Openness + Neuroticism +
                   Agreeableness + Extraversion +
                   (1 | chimp) + (1 | stage/TrialType)  #(1 | Section) + (1 | TrialType) + ,
                 , data = temp, family = binomial
)
# library(arm)
# standardize() # converts everything to 2SE coefficients

rs.glm1.0 <- glmer(Correctness ~ Dominance + Conscientiousness + Openness + Neuroticism +
                     Agreeableness + Extraversion + 
                     #Trial +  # adding this does... well, nothing.
                     (1 | chimp) + (1 | stage) + (1 | TrialType) #+ (1 | Section) + (1 | depend)
                   # last two look degenerate
                   , data = temp, family = binomial
)

confint(rs.glm1.0, method="boot")
# annoying, Wald is the only one which works
rs.accu.ci = confint(rs.glm1.0, method="Wald")

# improve grouping with regards to AB,AA and training stages
# turns out not to be helpful

# what about just at testing
# rs.glm1.tstOnly <- glmer(Correctness ~ Dominance + Conscientiousness + Openness + Neuroticism +
#                        Agreeableness + Extraversion +
#                        (1 | chimp) #+ (1 | TrialType)  #(1 | Section) + (1 | TrialType) + ,
#                      , data = temp[temp$TrialType==' Test',], family = binomial
# )
## there are multicolinearity / rank deficiency issues with the above, so just leave it



### Learning
# after 33/48 trials, chimps progressed to next stage

# how can we get a handle on this?
setwd("training/2-choice AA1 black/")


# [4] RT

library(car)

rs.rt.lmm.all <- lmer(log(RT) ~ Dominance + Conscientiousness + Openness + Neuroticism +
                   Agreeableness + Extraversion +
                     (1 | chimp) + (1 | stage) + (1 | TrialType) #+ (1 | Section) + (1 | depend)
                 , data = temp
)

rs.rt.lmm.1 <- lmer(log(RT) ~ Dominance + Conscientiousness + Openness + Neuroticism +
                        Agreeableness + Extraversion +
                        (1 | chimp) + (1 | stage) + (1 | TrialType) #+ (1 | Section) + (1 | depend)
                      , data = temp[temp$Correctness==' Correct',]
)

# No effects.

## Number of touches:


# 738 (?)
# 728

grep("/",as.character(temp$Coordinates[728]))

for (i in 1:dim(temp)[1]){
  temp$touches[i] = countCharOccurrences('/', as.character(temp$Coordinates[i]))
  
}
# okay that function makes it work
#countCharOccurrences('/', as.character(temp$Coordinates[728]))


rs.touch.lmm <- glmer(touches ~ Dominance + Conscientiousness + Openness + Neuroticism +
                      Agreeableness + Extraversion +
                      (1 | chimp) + (1 | stage) + (1 | TrialType) #+ (1 | Section) + (1 | depend)
                    , data = temp
                    #, data = temp[temp$Correctness==' Correct',]
                    , family = poisson(link = "log")
)
confint(rs.touch.lmm, method='Wald')

rs.touch.lmm.1 <- glmer(touches ~ Dominance + Conscientiousness + Openness + Neuroticism +
                        Agreeableness + Extraversion +
                        (1 | chimp) + (1 | stage) #+ (1 | TrialType) #+ (1 | Section) + (1 | depend)
                      #, data = temp
                      , data = temp[temp$Correctness==' Correct',]
                      , family = poisson(link = "log")
)
ci.touches.1 <- confint(rs.touch.lmm.1, method='Wald')

rs.touch.lmm.0 <- glmer(touches ~ Dominance + Conscientiousness + Openness + Neuroticism +
                        Agreeableness + Extraversion +
                        (1 | chimp) + (1 | stage) #+ (1 | TrialType) + (1 | Section) + (1 | depend)
                      #, data = temp
                      , data = temp[temp$Correctness==' Incorrect',]
                      , family = poisson(link = "log")
)
ci.touches.0 <- confint(rs.touch.lmm.0, method='Wald')


countCharOccurrences <- function(char, s) {
  s2 <- gsub(char,"",s)
  return (nchar(s) - nchar(s2))
}
