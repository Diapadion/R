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

library(optimx)
library(nloptr)
library(bbmle)
library(lme4)

library(Hmisc)

### [0] Correlations among personality domains

# dependent on [1] code


rcorr(as.matrix(intLvlPers2[,c(4:9)]), type="spearman")



### [1] Interaction levels

# this section may be doomed to failure, and ought to be only used for visualization
# see [2] for replacement

# a. HE, LI, RE, Q, KD, LU, SO
# b. EM, LB, ED, LO, DA
# c. CI, EV, PA
# d. FK, KL, PE 

# RSpartic = as.ordered(c(2,1,1,1,2,3,0,3,0,0,1,1,0,2,3,0,0,0))
# intLvlPers = cbind(aggPers,RSpartic)
# 
# RStm <- aggregate(intLvlPers, by=list(intLvlPers$RSpartic), FUN=mean)
# RSts <- aggregate(intLvlPers, by=list(intLvlPers$RSpartic), FUN=sd)
# 
# mp = barplot(height=as.matrix(RStm[4:9]),beside=TRUE,
#              #legend.text=c('Never participated','Incomplete participation','Completed full sessions')
#              ,ylim=c(0,7))
# 
# segments(c(mp), c(t(t(RStm[4:9] - RSts[4:9]))), c(mp),c(t(t(RStm[4:9] + RSts[4:9]))), lwd=2)


### addition:
### compare individuals who never participated, to those who did (to some degree)

## also... Lyndsey was alive
## this will have impact on how we calculate Z scores for pers

RSpartic = as.ordered(c(1,1,1,1,1,1,0,1,0,0,1,1,0,1,1,0,0,0,0))
intLvlPers2 = cbind(RSpartic, aggPers)

RStm <- aggregate(intLvlPers2, by=list(intLvlPers2$RSpartic), FUN=mean)
RSts <- aggregate(intLvlPers2, by=list(intLvlPers2$RSpartic), FUN=sd)

mp = barplot(height=as.matrix(RStm[5:10]),beside=TRUE,
             #legend.text=c('Never participated','Incomplete participation','Completed full sessions')
             ,ylim=c(0,7),
             names.arg=c('Dominance','Extraversion','Conscientiousness',
                         'Agreeableness','Neuroticism','Openness'))

segments(c(mp), c(t(t(RStm[5:10] - RSts[5:10]))), c(mp),c(t(t(RStm[5:10] + RSts[5:10]))), lwd=2)


c.t = t.test(intLvlPers2$Conscientiousness[intLvlPers2$RSpartic==1],intLvlPers2$Conscientiousness[intLvlPers2$RSpartic==0])
# definitely
n.t = t.test(intLvlPers2$Neuroticism[intLvlPers2$RSpartic==1],intLvlPers2$Neuroticism[intLvlPers2$RSpartic==0])
# yes
o.t = t.test(intLvlPers2$Openness[intLvlPers2$RSpartic==1],intLvlPers2$Openness[intLvlPers2$RSpartic==0])
# yes
d.t = t.test(intLvlPers2$Dominance[intLvlPers2$RSpartic==1],intLvlPers2$Dominance[intLvlPers2$RSpartic==0])
# yes

p.adjust(c(0.002396, 0.02227, 0.03598, 0.04071), 'BH', 4)
# okay, all pass, post correction


# starting from 'scratch'


# booterLvl <- NULL
# for (i in 1:500){
#   booterLvl = rbind(booterLvl,intLvlPers)
# }
# 
#   
#   
# library(nnet)
# RS.mult.lvl.0 <- multinom(RSpartic ~ Dominance + Conscientiousness + Openness + Neuroticism +
#                             Agreeableness + Extraversion,  data = intLvlPers)
# # this doesn't _really_ seem lke it has worked
# 
# 
# #polr doesn't work for all predictors
# library(MASS)
# RS.om.lvl.0 <- polr(RSpartic ~ Dominance + Conscientiousness + Openness + Neuroticism +
#                       #Agreeableness + 
#                       Extraversion,
#                     data = intLvlPers, model = "probit"
#                     )
# 
# # nor does clm...
# library(ordinal)
# RS.om.lvl.b0 <- clm(RSpartic ~ Dominance + Conscientiousness + Openness + Neuroticism +
#        Agreeableness + Extraversion,
#      data = booterLvl #, link = "probit"
# )
# 
# saveB = Boot(RS.om.lvl.0, R = 1000, method = 'case') # doens't work
# 
# 
# # ... nope
# library(rms)
# RS.om.lvl.0 <- #orm # is original
#   lrm(RSpartic ~ Dominance + Conscientiousness + Openness + Neuroticism +
#                      Agreeableness + Extraversion,
#                    data = intLvlPers #, model = "probit"
# )
# 
# 
# # 
# library(glmnet)
# 
# fit3=glmnet(as.matrix(intLvlPers[,3:8]),
#             as.double(intLvlPers$RSpartic)-1,
#             #lapply(intLvlPers$RSpartic,as.numeric),
#             family="multinomial")
# 
# 
# # I have no idea
# library(VGAM)
# RS.v.0 <- vglm(RSpartic ~ Dominance + Conscientiousness + Openness + Neuroticism +
#                  Agreeableness + Extraversion,
#                data = intLvlPers,
#                family=cumulative(link="multilogit", parallel=TRUE)
# )
# 
# 
# # let's do this first with the Tukey tests
# #library(multcomp)
# library(DTK)
# RlvlS.dtk.d = DTK.test(intLvlPers$Dominance, intLvlPers$RSpartic)
# RlvlS.dtk.c = DTK.test(intLvlPers$Conscientiousness, intLvlPers$RSpartic)
# RlvlS.dtk.n = DTK.test(intLvlPers$Neuroticism, intLvlPers$RSpartic)
# RlvlS.dtk.o = DTK.test(intLvlPers$Openness, intLvlPers$RSpartic)
# 
# library(MASS)
# mod.polr.o <- polr(RSpartic ~ Openness + I(Openness^2), data=intLvlPers)
# mod.polr.c <- polr(RSpartic ~ Conscientiousness + I(Conscientiousness^2), data=intLvlPers)
# mod.polr.d <- polr(RSpartic ~ Dominance + I(Dominance^2), data=intLvlPers) # + I(Dominance^2)
# mod.polr.n <- polr(RSpartic ~ Neuroticism + I(Neuroticism^2), data=intLvlPers)
# 
# # below is consistent with above
# mod.polr.ce <- polr(RSpartic ~ Extraversion + Conscientiousness, data=intLvlPers)
# mod.polr.oa <- polr(RSpartic ~ Openness + Agreeableness, data=intLvlPers)
# 
# 
# mod.polr.odnc <- polr(RSpartic ~ Openness + Dominance + Neuroticism + Conscientiousness, data=intLvlPers)
# mod.polr.all <- polr(RSpartic ~ Extraversion + Openness + Dominance + Neuroticism + Conscientiousness, data=intLvlPers)



# [2] Trials before drop-out
#     
  
# should be able to model each training stage / individual with Surv
# with frailty for each stage, and individual
# ending in either completion of the training or dropout


TraTri = RStemp[RStemp$stage!='test',]
TraTri.1 = TraTri[TraTri$Correctness==' Correct',]

library(plyr)
#TraTri = aggregate(TraTri, by=list('chimp','stage'), FUN=count)

##### I don't think anything other the line below is needed
aggTraTri = count(RStemp, c("chimp","stage"))

aggTraTri.1 = count(TraTri.1, c("chimp","stage"))
aggTraTri$correct = NA
aggTraTri[aggTraTri$stage!='test',]$correct = aggTraTri.1$freq

# TODO fix below
aggTraTri$prop = aggTraTri$correct / aggTraTri$freq
#####

# adding a column for whether the chimp dropped out or not (0: in, 1: dropped)
# the below seems to be more wrong than it should be ... this may be an aggregation effect
#TraTri = cbind(TraTri, dropped = c(0,0,0,1,1,0,0,0,0,1,0,0,0,1,0,0,0,1,0,0,1,0,0,0,0,1,0,0,1))

#TraTri = cbind(TraTri, dropped = c(0,0,0,1,1,0,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,1,0,0,0,0,1))
aggTraTri = cbind(aggTraTri, dropped = 
                 c(0,0,0,0,1,0,0,0,1,0,
                   0,0,0,0,0,0,1,0,0,0,
                   1,0,0,0,0,1,0,0,0,0,
                   1,0,0,0,0,0,0,0,1,0,
                   0,0,0,0,1,1,1,1))

aggTraTri = merge(aggTraTri,aggPers, by.x= "chimp", "Chimp")

library(survival)
dOut = Surv(aggTraTri$freq, aggTraTri$dropped, type='right')

# which distribution should we use?
themodel <- (dOut ~ aggTraTri$Dominance + aggTraTri$Conscientiousness + aggTraTri$Openness + 
               aggTraTri$Neuroticism + aggTraTri$Agreeableness + aggTraTri$Extraversion)
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
                      Agreeableness + Extraversion, data = aggTraTri, dist='lognormal')

RS.drop.aft.frail <- survreg(dOut ~ Dominance + Conscientiousness + Openness + Neuroticism +
                     Agreeableness + Extraversion +
                       frailty(stage)
                       , data = aggTraTri, dist='lognormal')

summary(RS.drop.aft.frail)
ci.drop = confint(RS.drop.aft.frail, method='profile')
# Significant effect for Conscientiousness
# high Conscientious chimps stay in the task for more trials

# perhaps, for consistency
library(coxme)
RS.drop.cox.f <- coxme(dOut ~ Dominance + Conscientiousness + Openness + Neuroticism +
                               Agreeableness + Extraversion +
                               (1 | stage) + (1 | chimp)
                             , data = aggTraTri)
confint(RS.drop.aft.frail) # how to make this work?
summary(RS.drop.cox.f)
# yes, the Cox ME {TODO}
# probably just need to do the CIs by hand



library(texreg)

ext.RSdaf=extract(RS.drop.aft.frail, include.aic = FALSE, include.bic=FALSE, include.dic=FALSE,
                include.deviance=FALSE, include.loglik=FALSE,include.nobs=FALSE,
                include.groups=FALSE,include.variance=FALSE)

RS2surv.tbl = htmlreg(list(ext.RSdaf), custom.model.names=c('Std. Estimate'), ci.force=TRUE,
                  caption = "", groups=NULL, digits=3, ci.force.level = 0.95, ci.test=NULL,
                  bold=TRUE, custom.note = '')#, reorder.coef = c(1:5,8,9,6,11,10,7),
                  #custom.coef.names=c(NA,"Age","Age<sup>2</sup>","Sex",NA,NA,NA,NA,NA,NA,NA))
write(RS2surv.tbl,"../presentation images/RS2surv.html")


# how about just the test trials?
TestTri = aggTraTri[aggTraTri$stage=='test',]
dOuTst = Surv(TestTri$freq, TestTri$dropped, type='right')

RS.drop.aft.f.tst <- survreg(dOut ~ Dominance + Conscientiousness + Openness + Neuroticism +
                               Agreeableness + Extraversion +
                               frailty(stage)
                             , data = TestTri, dist='lognormal')
# not enough df... oh well



### [2'-prime] - WIP

# Rate of learning from stage to stage, revisited

# say we remove the testing sessions

TrainOnlyTri <- aggTraTri[aggTraTri$stage!='test',]
hist(log(TrainOnlyTri$freq), breaks = 20)


RS.trial.lmm.tot <- lmer(log(freq) ~ Dominance + Conscientiousness + Openness + Neuroticism +
                           Agreeableness + Extraversion +
                           (1 | chimp) + (1 | stage)
                         , data = TrainOnlyTri)

RS.trial.glmm.tot <- glmer(freq ~ Dominance + Conscientiousness + Openness + Neuroticism +
                           Agreeableness + Extraversion +
                           (1 | chimp) + (1 | stage), family = 'poisson'
                         , data = TrainOnlyTri)
summary(RS.trial.glmm.tot)
confint(RS.trial.lmm.tot)

# the below model shouldn't be formulated quite like this,
# and won't produce meaningful results
RS.trial.lmm.prop <- lmer(prop ~ Dominance + Conscientiousness + Openness + Neuroticism +
                            Agreeableness + Extraversion +
                            (1 | chimp) + (1 | stage)
                          , data = TrainOnlyTri)

# again, for rerunning:
TrainOnlyTri <- aggTraTri[aggTraTri$stage!='test',]
# # and how about removing the training sessions where individuals dropped out
# TrainOnlyTri <- TrainOnlyTri[TrainOnlyTri$dropped == 0,]
# # and some custom removals
# # # dropping just the 0 adds
TrainOnlyTri <- TrainOnlyTri[-c(1,2,4,8,11,12,13,14,19,22,24,26,27,29,32,36,38,40,42),]
# # these blocks were not trained to criterion


RS.trial.lmm.tot <- lmer(log(freq) ~ Dominance + Conscientiousness + Openness + Neuroticism +
                           Agreeableness + Extraversion +
                           (1 | chimp) + (1 | stage)
                         , data = TrainOnlyTri)

RS.trial.glmm.tot <- glmer(freq ~ Dominance + Conscientiousness + Openness + Neuroticism +
                             Agreeableness + Extraversion
                             + (1 | chimp)
                             + (1 | stage)
                           , family = poisson(link = 'log')
                           , data = TrainOnlyTri, 
                           #control = glmerControl(optimizer='nloptwrap')
                           control = glmerControl(optimizer='Nelder_Mead')
                           ) 
summary(RS.trial.glmm.tot)
#confint(RS.trial.lmm.tot)
confint(RS.trial.glmm.tot)



## an entirely different *kind* of survival analysis
# whoever reached criterion by the end of the block, is given status
# everyone else is censorsed out

TrainOnlyTri$crit = c(1,1,1,0,1,
                      0,
                      1,0,0,
                      0,0,0,0, # maybe flip :3: (back to/from 0) 
                      0,1,1,1,  # Eva switches conditions too...
                      1,0,1,
                      1,0,1,
                      0,
                      0,0,
                      1,1,0,1,0,
                      0,
                      1,1,1,
                      1,1,1,1,0,1,
                      0)
# this will also be useful for filtering

dCrit = Surv(TrainOnlyTri$freq, TrainOnlyTri$crit, type='right')

# tested, lognormal is good

RS.crit.aft.frail <- survreg(dCrit ~ Dominance + Conscientiousness + Openness + Neuroticism +
                               Agreeableness + Extraversion +
                               frailty(stage)
                             , data = TrainOnlyTri, dist='lognormal')
confint(RS.crit.aft.frail)
# nothing there... Cox to check:

RS.crit.cox <- coxme(dCrit ~ Dominance + Conscientiousness + Openness + Neuroticism +
                       Agreeableness + Extraversion
                     + (1 | stage) + (1 | chimp)
                     , data = TrainOnlyTri)
summary(RS.crit.cox)
# Nope.


RS.crit.lmm <- lmer(log(freq) ~ Dominance + Conscientiousness + Openness + Neuroticism +
                           Agreeableness + Extraversion +
                           (1 | chimp) + (1 | stage)
                         , data = TrainOnlyTri[TrainOnlyTri$crit == 1,])
summary(RS.crit.lmm)

RS.crit.glmm <- glmer(freq ~ Dominance + Conscientiousness + Openness + Neuroticism +
                             Agreeableness + Extraversion +
                             (1 | chimp) + (1 | stage), family = 'poisson'
                           , data = TrainOnlyTri[TrainOnlyTri$crit == 1,])
summary(RS.crit.glmm)
# uuuuuhhhhh what??
# this can't be right
confint(RS.crit.glmm, method = 'Wald')

# looks like there's nothing here
# probably too few data points


### [3] Accuracy

# "simple" GLMM of accuracy predicted by personality

rs.glm1 <- glmer(Correctness ~ Dominance + Conscientiousness + Openness + Neuroticism +
                   Agreeableness + Extraversion +
                   (1 | chimp) + (1 | stage/TrialType)  #(1 | Section) + (1 | TrialType) + ,
                 , data = RStemp, family = binomial
)

# library(arm)
# standardize() # converts everything to 2SE coefficients

rs.glm1.0 <- glmer(Correctness ~ Dominance + Conscientiousness + Openness + Neuroticism +
                     Agreeableness + Extraversion + 
                     #Trial +  # adding this does... well, nothing.
                     (1 | chimp) + (1 | stage) + (1 | TrialType) #+ (1 | Section) + (1 | depend)
                   # last two look degenerate
                   , data = RStemp, family = binomial
)

# confint(rs.glm1.0, method="boot")
# annoying, Wald is the only one which works
rs.accu.ci = confint(rs.glm1.0, method="Wald")

ext.RSaccu=extract(rs.glm1.0, include.aic = FALSE, include.bic=FALSE, include.dic=FALSE,
                  include.deviance=FALSE, include.loglik=FALSE,include.nobs=FALSE,
                  include.groups=FALSE,include.variance=FALSE)

RS2accu.tbl = htmlreg(list(ext.RSaccu), custom.model.names=c('Std. Estimate'), ci.force=TRUE,
                      caption = "", groups=NULL, digits=3, ci.force.level = 0.95, ci.test=NULL,
                      bold=TRUE, custom.note = '')

write(RS2accu.tbl,"../presentation images/RS2accu.html")

# improve grouping with regards to AB,AA and training stages
# turns out not to be helpful

# what about just at testing
# rs.glm1.tstOnly <- glmer(Correctness ~ Dominance + Conscientiousness + Openness + Neuroticism +
#                        Agreeableness + Extraversion +
#                        (1 | chimp) #+ (1 | TrialType)  #(1 | Section) + (1 | TrialType) + ,
#                      , data = temp[temp$TrialType==' Test',], family = binomial
# )
## there are multicolinearity / rank deficiency issues with the above, so just leave it


rs.glm2.0 <- glmer(Correctness ~ Dominance + Conscientiousness + Openness + Neuroticism +
                     Agreeableness + Extraversion +
                     Trial +  # adding this does... well, very little.
                     (1 | chimp) + (1 | stage) + (1 | TrialType) #+ (1 | Section) + (1 | depend)
                   # last two look degenerate
                   , data = RStemp, family = binomial
)
# shall we make trial more cumulative?

rs.glm3.0 <- glmer(Correctness ~ Dominance + Conscientiousness + Openness + Neuroticism +
                     Agreeableness + Extraversion +
                     day +  
                     (1 | chimp) + (1 | stage) + (1 | TrialType) #+ (1 | Section) + (1 | depend)
                   # last two look degenerate
                   , data = RStemp, family = binomial
)

rs.glm3.td <- glmer(Correctness ~ Dominance + Conscientiousness + Openness + Neuroticism +
                     Agreeableness + Extraversion +
                     day +  Trial +
                     (1 | chimp) + (1 | stage) + (1 | TrialType) #+ (1 | Section) + (1 | depend)
                   # last two look degenerate
                   , data = RStemp, family = binomial
)
summary(rs.glm3.0)

rs.glm3.ints <- glmer(Correctness ~ Dominance*day + Conscientiousness*day + Openness*day + Neuroticism*day +
                     Agreeableness*day + Extraversion*day +
                      
                     (1 | chimp) + (1 | stage) + (1 | TrialType) #+ (1 | Section) + (1 | depend)
                   # last two look degenerate
                   , data = RStemp, family = binomial
)
rs.glm3.iA <- glmer(Correctness ~ Dominance + Conscientiousness + Openness + Neuroticism +
                        Agreeableness*day + Extraversion +
                        (1 | chimp) + (1 | stage) + (1 | TrialType) #+ (1 | Section) + (1 | depend)
                      # last two look degenerate
                      , data = RStemp, family = binomial
)

# individual other interactions didn't work out

AICtab(rs.glm2.0, rs.glm1.0,rs.glm3.0, rs.glm3.td, weights=T, delta=T, base=T, logLik=T, sort=T) 

AICtab(rs.glm3.iA, rs.glm3.ints,rs.glm3.0, rs.glm3.td, weights=T, delta=T, base=T, logLik=T, sort=T) 

summary(rs.glm3.iA)

### Learning
# after 33/48 trials, chimps progressed to next stage

# how can we get a handle on this?
setwd("training/2-choice AA1 black/")


### [4] Touches & RT


## Number of touches:


# 738 (?)
# 728

grep("/",as.character(temp$Coordinates[728]))

for (i in 1:dim(RStemp)[1]){
  RStemp$touches[i] = countCharOccurrences('/', as.character(RStemp$Coordinates[i]))
  
}
# okay that function makes it work
#countCharOccurrences('/', as.character(temp$Coordinates[728]))

# below is the most consistently defined model, I think.
rs.touch.lmm <- glmer(touches ~ Dominance + Conscientiousness + Openness + Neuroticism +
                      Agreeableness + Extraversion +
                      (1 | chimp) + (1 | stage) + (1 | TrialType) #+ (1 | Section) + (1 | depend)
                    , data = RStemp[RStemp$touches > 0,]
                    #, data = temp[temp$Correctness==' Correct',]
                    , family = poisson(link = "log"), control = glmerControl(optimizer='nloptwrap')
)
rs.touch.lmm.d <- glmer(touches ~ Dominance + Conscientiousness + Openness + Neuroticism +
                        Agreeableness + Extraversion + day +
                        (1 | chimp) + (1 | stage) + (1 | TrialType) #+ (1 | Section) + (1 | depend)
                      , data = RStemp[RStemp$touches > 0,]
                      #, data = temp[temp$Correctness==' Correct',]
                      , family = poisson(link = "log"), control = glmerControl(optimizer='Nelder_Mead')
)


rs.touch.lmm.1 <- glmer(touches ~ Dominance + Conscientiousness + Openness + Neuroticism +
                        Agreeableness + Extraversion +
                        (1 | chimp) + (1 | stage) + (1 | TrialType) #+ (1 | Section) + (1 | depend)
                      #, data = temp
                      , data = RStemp[(RStemp$Correctness==' Correct' & RStemp$touches > 0),]
                      , family = poisson(link = "log"), control = glmerControl(optimizer='Nelder_Mead')
)
rs.touch.lmm.1.d <- glmer(touches ~ Dominance + Conscientiousness + Openness + Neuroticism +
                          Agreeableness + Extraversion + day +
                          (1 | chimp) + (1 | stage) + (1 | TrialType) #+ (1 | Section) + (1 | depend)
                        #, data = temp
                        , data = RStemp[(RStemp$Correctness==' Correct' & RStemp$touches > 0),]
                        , family = poisson(link = "log"), control = glmerControl(optimizer='Nelder_Mead')
)


rs.touch.lmm.0 <- glmer(touches ~ Dominance + Conscientiousness + Openness + Neuroticism +
                        Agreeableness + Extraversion +
                        (1 | chimp) + (1 | stage) + (1 | TrialType) #+ (1 | Section) + (1 | depend)
                      #, data = temp
                      ,  data = RStemp[(RStemp$Correctness==' Incorrect' & RStemp$touches > 0),]
                      , family = poisson(link = "log"), control = glmerControl(optimizer='Nelder_Mead')
)
rs.touch.lmm.0.d <- glmer(touches ~ Dominance + Conscientiousness + Openness + Neuroticism +
                          Agreeableness + Extraversion + day +
                          (1 | chimp) + (1 | stage) + (1 | TrialType) #+ (1 | Section) + (1 | depend)
                        #, data = temp
                        ,  data = RStemp[(RStemp$Correctness==' Incorrect' & RStemp$touches > 0),]
                        , family = poisson(link = "log"), control = glmerControl(optimizer='Nelder_Mead')
)


AICtab(rs.touch.lmm, rs.touch.lmm.d, rs.touch.lmm.1,
       rs.touch.lmm.1.d, rs.touch.lmm.0, rs.touch.lmm.0.d, 
       weights=T, delta=T, base=T, logLik=T, sort=T) 


# won't complete with N_M
# probably just have to deal with Wald
ci.touches <- confint(rs.touch.lmm, method='Wald')
ci.touches.0 <- confint(rs.touch.lmm.0, method='profile')
ci.touches.1 <- confint(rs.touch.lmm.1, method='profile')
ci.touches.d <- confint(rs.touch.lmm.d, method='Wald')
ci.touches.0.d <- confint(rs.touch.lmm.0.d, method='profile')
ci.touches.1.d <- confint(rs.touch.lmm.1.d, method='profile')




### RT now

# convergence problems with CIs can be fixed
# the best solution at this point seems to be thru Nelder_Mead

rs.rt.lmm.pers <- lmer(log(RT) ~ Dominance + Conscientiousness + Openness + Neuroticism +
                         Agreeableness + Extraversion +
                         (1 | chimp) + (1 | stage) + (1 | TrialType) #+ (1 | Section) + (1 | depend)
                       , data = RStemp
)

rs.rt.lmm.pers.day <- lmer(log(RT) ~ Dominance + Conscientiousness + Openness + Neuroticism +
                             Agreeableness + Extraversion + day + 
                             (1 | chimp) + (1 | stage) + (1 | TrialType) #+ (1 | Section) + (1 | depend)
                           , data = RStemp, control = lmerControl(optimizer='Nelder_Mead')
)



rs.rt.lmm.1 <- lmer(log(RT) ~ Dominance + Conscientiousness + Openness + Neuroticism +
                      Agreeableness + Extraversion +
                      (1 | chimp) + (1 | stage) + (1 | TrialType) #+ (1 | Section) + (1 | depend)
                    , data = RStemp[RStemp$Correctness==' Correct',]
)


rs.rt.lmm.1.day <- lmer(log(RT) ~ Dominance + Conscientiousness + Openness + Neuroticism +
                          Agreeableness + Extraversion + scale(day) +
                          (1 | chimp) + (1 | stage) + (1 | TrialType) #+ (1 | Section) + (1 | depend)
                        , data = RStemp[RStemp$Correctness==' Correct',],
                        control = lmerControl(optimizer='Nelder_Mead' #"nloptwrap"
                          # lmerControl(optimizer = "optimx", 
                          #                     optCtrl=list(#maxfun=1000, 
                          #                                  #method='nlminb'
                          #                                  method='L-BFGS-G' )
                                              ))

ci.RT.1 = confint(rs.rt.lmm.1)
ci.RT.1.d = confint(rs.rt.lmm.1.day, method='profile')


ci.RT = confint(rs.rt.lmm.pers)
ci.RT.d = confint(rs.rt.lmm.pers.day, method='profile')

AICtab(rs.rt.lmm.pers, rs.rt.lmm.pers.day, rs.rt.lmm.1, rs.rt.lmm.1.day, weights=T, delta=T, base=T, logLik=T, sort=T) 





# let's try with just the single touches

rs.rt.lmm.1.1tch <- lmer(log(RT) ~ Dominance + Conscientiousness + Openness + Neuroticism +
                      Agreeableness + Extraversion +
                      (1 | chimp) + (1 | stage) + (1 | TrialType) #+ (1 | Section) + (1 | depend)
                    , data = RStemp[(RStemp$Correctness==' Correct' & RStemp$touches == 1),]
)
rs.rt.lmm.1.day.1tch <- lmer(log(RT) ~ Dominance + Conscientiousness + Openness + Neuroticism +
                          Agreeableness + Extraversion + day +
                          (1 | chimp) + (1 | stage) + (1 | TrialType) #+ (1 | Section) + (1 | depend)
                        , data = RStemp[(RStemp$Correctness==' Correct' & RStemp$touches == 1),]
)
# They don't seem to help. Probably due to the reduced sample size.



countCharOccurrences <- function(char, s) {
  s2 <- gsub(char,"",s)
  return (nchar(s) - nchar(s2))
}
