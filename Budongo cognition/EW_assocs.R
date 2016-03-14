

# 1. who completed all the training, and moved onto testing


# 2. who spent time around the apparatus, when no rewards being given out


# 3. who continued to interact with the screen, when not rewarded






# [1] CI, ED, FK, KL, EV, PE, LO

EWpartic = as.factor(c(1,0,1,0,1,1,0,1,0,0,0,1,0,0,1,0,0,0))

aggPers = cbind(aggPers, EWpartic)

write.csv(aggPers, file = "aggregatedPers.csv")

EWtm <- aggregate(aggPers, by=list(aggPers$EWpartic), FUN=mean)
EWts <- aggregate(aggPers, by=list(aggPers$EWpartic), FUN=sd)

EWp = barplot(height=as.matrix(EWtm[3:8]),beside=TRUE,
              legend.text=c('Non-participants','Participants'),
              ylim=c(0,7))
segments(c(EWp), c(t(t(EWtm[3:8] - EWts[3:8]))), c(EWp),c(t(t(EWtm[3:8] + EWts[3:8]))), lwd=2)

# logit glm for seeing how pers affects this

mew.gm1 = glm(EWpartic ~ dom + con + neu + ext + agr + opn, 
              data=aggPers, family=binomial(link="logit"))


# t-tests

c.t = t.test(aggPers$Conscientiousness[aggPers$EWpartic==1],aggPers$Conscientiousness[aggPers$EWpartic==0])
# the above is now borderline
n.t = t.test(aggPers$Neuroticism[aggPers$EWpartic==1],aggPers$Neuroticism[aggPers$EWpartic==0]) # nope
# this one doesn't actually meet the 'non-overlapping bars' criteria
# ... exclude it?
o.t = t.test(aggPers$Openness[aggPers$EWpartic==1],aggPers$Openness[aggPers$EWpartic==0]) # yep

p.adjust(c(c.t$p.value, n.t$p.value, o.t$p.value), 'BH', 3)
# none of these pass correction
# n.t$p.value, # hmmmmm



### [2] Time spent around the apparatus

inPodL <- data.frame(Date=factor(),Chimp=factor(),Time=numeric(),
                     Dominance=numeric(),Extraversion=numeric(),
                     Conscientiousness=numeric(),
                     Agreeableness=numeric(),
                     Neuroticism=numeric(),Openness=numeric()
                         )

#??? inPod$Date <- tAround$Date

tAround <- read.csv('EW_timeSpentInPodsFinalStage.csv', header=TRUE)

for (i in 2:19){
  #tAround[,i] <- as.Date(tAround[,i],format="%H:%M:%S",origin='00:00:00')
  tAround[,i] <- difftime(
    strptime(levels(tAround[,i])[tAround[,i]],format="%H:%M:%S")
    ,Sys.Date()-1/24,
    units='secs')
}

# not needed amymore
toSecs <- function(u,v = (Sys.Date()-1/24)) {

    difftime(
      strptime(levels(u)[u],format="%H:%M:%S")
         ,v, # this shift works...
         units='secs')
}

## in lieu of fixing the time conversion functions, we have a backup

tAround <- tAround.bak


# toSecs should work since changed, but we will have to check this again eventually
inPodL = rbind(
  cbind(Date=tAround$Date,Chimp="Cindy",Time=tAround$Cindy,aggPers[1,2:7]),
  cbind(Date=tAround$Date,Chimp="David",Time=tAround$David,aggPers[2,2:7]),
  cbind(Date=tAround$Date,Chimp="Edith",Time=tAround$Edith,aggPers[3,2:7]),
  cbind(Date=tAround$Date,Chimp="Emma",Time=tAround$Emma,aggPers[4,2:7]),
  cbind(Date=tAround$Date,Chimp="Eva",Time=tAround$Eva,aggPers[5,2:7]),
  cbind(Date=tAround$Date,Chimp="Frek",Time=tAround$Frek,aggPers[6,2:7]),
  cbind(Date=tAround$Date,Chimp="Heleen",Time=tAround$Heleen,aggPers[7,2:7]),
  cbind(Date=tAround$Date,Chimp="Kilimi",Time=tAround$Kilimi,aggPers[8,2:7]),
  cbind(Date=tAround$Date,Chimp="Kindia",Time=tAround$Kindia,aggPers[9,2:7]),
  cbind(Date=tAround$Date,Chimp="Lianne",Time=tAround$Lianne,aggPers[10,2:7]),
  cbind(Date=tAround$Date,Chimp="Liberius",Time=tAround$Liberius,aggPers[11,2:7]),
  cbind(Date=tAround$Date,Chimp="Louis",Time=tAround$Louis,aggPers[12,2:7]),
  cbind(Date=tAround$Date,Chimp="Lucy",Time=tAround$Lucy,aggPers[13,2:7]),
  cbind(Date=tAround$Date,Chimp="Paul",Time=tAround$Paul,aggPers[14,2:7]),
  cbind(Date=tAround$Date,Chimp="Pearl",Time=tAround$Pearl,aggPers[15,2:7]),
  cbind(Date=tAround$Date,Chimp="Qafzeh",Time=tAround$Qafzeh,aggPers[16,2:7]),
  cbind(Date=tAround$Date,Chimp="Rene",Time=tAround$Rene,aggPers[17,2:7]),
  cbind(Date=tAround$Date,Chimp="Sophie",Time=tAround$Sophie,aggPers[18,2:7])  
  )


inPodL$Time = as.numeric(inPodL$Time)
  
# may consider removing outliers, to be consisten

inPodL$secs[outliers(tatScreen$secs,3)]
# happy days, no outliers above 3 SDs


## need to fix (add) the score standardizations, here:
levels(inPodL$Chimp)[6] <- 'Freek'
inPodL.mcmc = merge(inPodL[,c(1:3)],aggPers[,c(1,8:13)], by.x= "Chimp", "Chimp")


# what predicts the amount of total time spent in the pod, per day
mew.pois.1 = glmer(Time ~ Dominance + Extraversion + Conscientiousness + Agreeableness
                   + Neuroticism + Openness + (1 | Date) + (1 | Chimp),
                   data=inPodL, family = poisson)
# the above model is almost certainly meaningless

# scaling needs to be done properly, from the outset
## Update - need to see how goes GLMM respond when we just take out the zeros
mew.pois.1s = glmer(Time ~ s(Dominance) + s(Neuroticism) + s(Agreeableness) 
                    + s(Extraversion) + s(Conscientiousness) + s(Openness)
                    + (1 | Date) + (1 | Chimp),
                  data=inPodL, subset = inPodL$Time!=0, family = poisson)

# Ext ... but this isn't properly accounting for zeros; doesn't agree with MCMC


ext.pgm1=extract(mew.pois.1, include.aic = FALSE, include.bic=FALSE, include.dic=FALSE,
                 include.deviance=FALSE, include.loglik=FALSE,include.nobs=FALSE,
                 include.groups=FALSE,include.variance=FALSE)
pgm1.tbl = htmlreg(ext.pgm1,ci.force=TRUE, custom.model.names='Time spent in pod',
                   caption = "", groups=NULL, digits=3, ci.force.level = 0.95, ci.test=NULL,
                   bold=TRUE, custom.note = '', 
                   #reorder.coef = c(1:5,8,9,6,11,10,7),
                   custom.coef.names=c(NA,'Dominance','Neuroticism','Agreeableness','Extraversion',
                                      'Conscientiousness','Openness')
)
write(pgm1.tbl,"InPodPGLM.html")



library(MCMCglmm)

mew.mcmc.pZIF.1 <- MCMCglmm(Time ~ Dominance + Conscientiousness +
                              Openness + Neuroticism + Agreeableness +
                              Extraversion, random= ~Date + Chimp,
                            data = inPodL, family = "zipoisson"
                            , rcov=~idh(trait):units
                            , burnin = 10000 , nitt = 90000 , verbose = FALSE
                            )
# Dom, Neu, Con ### NO - SEE NEW FILE

# I think idh is better, if this is being done correctly
mew.mcmc.pZIF.2 <- MCMCglmm(Time ~ dom + ext + con + agr + neu + opn, random= ~Date + Chimp,
                            data = inPodL, family = "zipoisson"
                            , rcov=~us(trait):units
                            , burnin = 10000 , nitt = 90000 , verbose = FALSE
)

# Let's try it with a specified prior
#prior1.1 <- list(G = list(G1 = list(V = 1, nu = 0.002)), R = list(V = 1, nu = 0.002))
prior1.1 <- list(G = list(G1 = list(V = 1, n = 0.002), G2 = list(V = 1, n = 0.002)),
                 R = list(V = 1, n = 0.002))
prior1.1 = list(R=list(V=1,nu=0.002),G=list(G1=list(V=1,nu=0.002)))
# from JH:
prior1.1 <- list(G=list(G1=list(V=diag(2), nu=2, alpha.mu=c(0,0),  
                           alpha.V=diag(2)*1000)), R=list(V=diag(1), nu=0.002))

# Chimp random effect is degenerate so what if we remove it? (nothing much)
mew.mcmc.pZIF.3 <- MCMCglmm(Time ~ dom + ext + con + agr + neu + opn, random= ~Date,
                            data = inPodL, family = "zipoisson"
                            , rcov=~idh(trait):units
                            , prior = prior1.1
                            , burnin = 10000 , nitt = 90000
                            , verbose = FALSE
)

# Hurdle instead of ZIP
mew.mcmc.hp <- MCMCglmm(Time ~ dom + ext + con + agr + neu + opn, random= ~Date + Chimp,
                            data = inPodL, family = "hupoisson"
                            , rcov=~idh(trait):units
                            #, prior = prior1.1
                            , burnin = 10000 , nitt = 90000
                            , verbose = FALSE
)

prior1.2 = list(
 # B = list(mu = c(0, 0, 0, 0, 0, 0), V = diag(6) * 1e10),
  R = list(V = 1, fix = 1),
  G = list(G1 = list(V = diag(2), n = 0.002), G2 = list(V = diag(2), n = 0.002)))

B.prior <- list(V=diag(6)*1e7, mu=c(0,0,0,0,0,0))
prior2.2  <- list(B=B.prior,
                R=list(V=diag(1), nu=0.02), G=list(G1=list(V=diag(1),
                nu=0.02, alpha.mu=rep(0,1), alpha.V=1000*diag(1)), G2=list(V=diag(1),
                nu=0.02, alpha.mu=rep(0,1), alpha.V=1000*diag(1))))

mew.mcmc.pZIF.4 <- MCMCglmm(Time ~ dom + ext + con + agr + neu + opn, random= ~Date + Chimp,
                            data = inPodL, family = "zipoisson"
                            , rcov=~idh(trait):units
                            , prior = prior2.2
                            , burnin = 10000 , nitt = 90000
                            , verbose = FALSE
)

# ugh - so the first model is what I'll use
### we will return here later for Prior investigation





# [3] Who continues to interact?


tatScreen <- read.csv('EW_timeSpentAtScreenFinalStage.csv', header=TRUE)
# setting up the data.frame
tatScreen$End <- strptime(levels(tatScreen$End)[tatScreen$End],format="%H:%M:%S")
tatScreen$Start.Pressing <- strptime(levels(tatScreen$Start.Pressing)[tatScreen$Start.Pressing],format="%H:%M:%S")

tatScreen$secs = as.numeric(difftime(tatScreen$End,tatScreen$Start.Pressing))

# should maybe so something about the Frek/Freek issue
levels(tatScreen$Individual)[levels(tatScreen$Individual)=="Frek"] <- "Freek"

tatScreen$Dominance = numeric(1)
tatScreen$Extraversion = numeric(1)
tatScreen$Conscientiousness = numeric(1)
tatScreen$Agreeableness = numeric(1)
tatScreen$Neuroticism = numeric(1)
tatScreen$Openness = numeric(1)


for (i in 1:length(tatScreen$Date)){
  tatScreen[i,13:18] = aggPers[which(as.character(tatScreen$Individual[i])==as.character(aggPers$Chimp)),8:13]

}


# outliers...
tatScreen$secs[outliers(tatScreen$secs,3)] <- NA


# model time

# how many approaches to screen?
table(tatScreen$Individual)
#aggPers$
EW3particip = c(1,0,15,5,9,15,0,8,0,0,2,4,0,1,9,0,1,2)
aggPers = cbind(aggPers, EW3particip)

mew.3.pm <- glm(EW3particip ~ Dominance + Neuroticism + Agreeableness +
                  Extraversion + Conscientiousness + Openness, data=aggPers, family=poisson)
# again, need to ZIF
# but ZIFing doesn't really work, so probably means it is unnecessary and we should stick to gm

library(pscl)
mew.3.zpm <- zeroinfl(EW3particip ~ Dominance + Neuroticism + 
                        Agreeableness + Extraversion + 
                        Conscientiousness + Openness
                      , data=aggPers, dist="poisson")
mew.3.hm <- hurdle(EW3particip ~ Dominance + Neuroticism + 
                     Agreeableness + Extraversion + 
                     Conscientiousness + Openness
                   , data=aggPers, dist="poisson")
# Looks like Con doesn't figure into this one, just Agr

# library(bbmle)  
# AICtab(mew.3.pm, mew.3.hm, weights=T, delta=T, base=T, logLik=T, sort=T)

confint(mew.3.pm)


### can this model can be done better?
# No, well, disagreeable chimps like Frek and Edith 
# will approach the screen and lose interest, and they're
# the ones approaching the screen lots because they don't
# care about others around them
#
# but C?



# MCMCglmm again ... to test robustness, or if MCMC is operating correctly
mew.3.mcmc.zpm <- MCMCglmm(EW3particip ~ dom + ext + con + agr + neu + opn, 
                            data = aggPers, family = "zipoisson"
                            , rcov=~idh(trait):units
                           # , burnin = 10000 , nitt = 90000 
                           , verbose = FALSE)
# okay, well this was useless, not too surprising


                                                
ext.pm3=extract(mew.3.hm, include.aic = FALSE, include.bic=FALSE, include.dic=FALSE,
                 include.deviance=FALSE, include.loglik=FALSE,include.nobs=FALSE,
                 include.groups=FALSE,include.variance=FALSE)
pm3.tbl = htmlreg(ext.pm3,ci.force=TRUE, custom.model.names='Number of approaches to screen',
                   caption = "", groups=NULL, digits=3, ci.force.level = 0.95, ci.test=NULL,
                  # bold=TRUE, 
                  custom.note = '', 
                   #reorder.coef = c(1:5,8,9,6,11,10,7),
                  # custom.coef.names=c(NA,'Dominance','Neuroticism','Agreeableness','Extraversion',
                  #                    'Conscientiousness','Openness')
)
write(pm3.tbl,"GotoScreen3PGLM.html")


# how much time spent at the screen?
mew.3.pgmm <- glmer(secs ~ Dominance + Neuroticism + Agreeableness + Extraversion + Conscientiousness + 
                       Openness
                    + (1 | Session.number) 
                    + (1 | Individual)
                    ,data = tatScreen, family = poisson
                    #,control=glmerControl(maxfun=10000)
                    )

mew.3.pgmm.s <- glmer(secs ~ s(Dominance) + s(Neuroticism) + s(Agreeableness) + s(Extraversion) + s(Conscientiousness) + 
                      s(Openness)
                    + (1 | Session.number) 
                    + (1 | Individual)
                    ,data = tatScreen, family = poisson
                    #,control=glmerControl(maxfun=10000)
)
vif.mer(mew.3.pgmm)


# MCMC test check again
mew.3.mcmc.pgmm <- MCMCglmm(secs ~ Dominance + Neuroticism + Agreeableness + Extraversion + Conscientiousness + 
                              Openness, random= ~Session.number + Individual
                           , data = tatScreen, family = "poisson"
                           , rcov=~us(trait):units
                           # , burnin = 10000 , nitt = 90000 
                           #, verbose = FALSE
                           )
# bloody hell, still won't work
# good thing it did work the one place it was needed


# okay, so let's check the convergence/OPTIMIZER issues
library(optimx)
mew.3.opt <- update(mew.3.pois,control=glmerControl(optimizer="optimx",
                                                    optCtrl=list(maxfun=1000, 
                                                                 method='nlminb'
                                                                 #method='L-BFGS-G'
                                                                 )))
                                                    

### regression tables

library(texreg)
ext.pgm3=extract(mew.3.pgmm, include.aic = FALSE, include.bic=FALSE, include.dic=FALSE,
                include.deviance=FALSE, include.loglik=FALSE,include.nobs=FALSE,
                include.groups=FALSE,include.variance=FALSE)
pgm3.tbl = htmlreg(ext.pgm3,ci.force=TRUE, custom.model.names='Time spent at screen',
                  caption = "", groups=NULL, digits=3, ci.force.level = 0.95, ci.test=NULL,
                  bold=TRUE, custom.note = '', 
                  #reorder.coef = c(1:5,8,9,6,11,10,7),
                  #custom.coef.names=c(NA,'Dominance','Neuroticism','Agreeableness','Extraversion',
                   #                   'Conscientiousness','Openness')
)
write(pgm3.tbl,"AtScreen3PGLM.html")
