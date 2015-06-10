

# 1. who completed all the training, and moved onto testing


# 2. who spent time around the apparatus, when no rewards being given out


# 3. who continued to interact with the screen, when not rewarded






#1) CI, ED, FK, KL, EV, PE, LO

EWpartic = as.factor(c(1,0,1,0,1,1,0,1,0,0,0,1,0,0,1,0,0,0))

aggPers = cbind(aggPers, EWpartic)

EWtm <- aggregate(aggPers, by=list(aggPers$EWpartic), FUN=mean)
EWts <- aggregate(aggPers, by=list(aggPers$EWpartic), FUN=sd)

EWp = barplot(height=as.matrix(EWtm[3:8]),beside=TRUE)
segments(c(EWp), c(t(t(EWtm[3:8] - EWts[3:8]))), c(EWp),c(t(t(EWtm[3:8] + EWts[3:8]))), lwd=2)

# logit glm for seeing how pers affects this

mew.gm1 = glm(EWpartic ~ dom + con + neu + ext + agr + opn, 
              data=aggPers, family=binomial(link="logit"))


# t-tests

c.t = t.test(aggPers$con[aggPers$EWpartic==1],aggPers$con[aggPers$EWpartic==0]) # yep
n.t = t.test(aggPers$neu[aggPers$EWpartic==1],aggPers$neu[aggPers$EWpartic==0]) # nope
o.t = t.test(aggPers$opn[aggPers$EWpartic==1],aggPers$opn[aggPers$EWpartic==0]) # yep



#2) Time spent around the apparatus

tAround <- read.csv('EW_timeSpentInPodsFinalStage.csv', header=TRUE)

inPodL <- data.frame(Date=factor(),Chimp=factor(),Time=numeric(),
                     Dominance=numeric(),Extraversion=numeric(),
                     Conscientiousness=numeric(),
                     Agreeableness=numeric(),
                     Neuroticism=numeric(),Openness=numeric()
                         )

#??? inPod$Date <- tAround$Date

for (i in 2:19){
  #tAround[,i] <- as.Date(tAround[,i],format="%H:%M:%S",origin='00:00:00')
  tAround[,i] <- strptime(levels(tAround[,i])[tAround[,i]],format="%H:%M:%S")
}

toSecs <- function(u,v = (Sys.date()-1/24)) {
  difftime(strptime(levels(u)[u],format="%H:%M:%S"),
         v, # this shift works...
         units='secs')
}

# toSecs should work since changed, but we will have to check this again eventually
inPodL = rbind(
  cbind(Date=tAround$Date,Chimp="Cindy",Time=toSecs(tAround$Cindy),aggPers[1,2:7]),
  cbind(Date=tAround$Date,Chimp="David",Time=toSecs(tAround$David),aggPers[2,2:7]),
  cbind(Date=tAround$Date,Chimp="Edith",Time=toSecs(tAround$Edith),aggPers[3,2:7]),
  cbind(Date=tAround$Date,Chimp="Emma",Time=toSecs(tAround$Emma),aggPers[4,2:7]),
  cbind(Date=tAround$Date,Chimp="Eva",Time=toSecs(tAround$Eva),aggPers[5,2:7]),
  cbind(Date=tAround$Date,Chimp="Frek",Time=toSecs(tAround$Frek),aggPers[6,2:7]),
  cbind(Date=tAround$Date,Chimp="Heleen",Time=toSecs(tAround$Heleen),aggPers[7,2:7]),
  cbind(Date=tAround$Date,Chimp="Kilimi",Time=toSecs(tAround$Kilimi),aggPers[8,2:7]),
  cbind(Date=tAround$Date,Chimp="Kindia",Time=toSecs(tAround$Kindia),aggPers[9,2:7]),
  cbind(Date=tAround$Date,Chimp="Lianne",Time=toSecs(tAround$Lianne),aggPers[10,2:7]),
  cbind(Date=tAround$Date,Chimp="Liberius",Time=toSecs(tAround$Liberius),aggPers[11,2:7]),
  cbind(Date=tAround$Date,Chimp="Louis",Time=toSecs(tAround$Louis),aggPers[12,2:7]),
  cbind(Date=tAround$Date,Chimp="Lucy",Time=toSecs(tAround$Lucy),aggPers[13,2:7]),
  cbind(Date=tAround$Date,Chimp="Paul",Time=toSecs(tAround$Paul),aggPers[14,2:7]),
  cbind(Date=tAround$Date,Chimp="Pearl",Time=toSecs(tAround$Pearl),aggPers[15,2:7]),
  cbind(Date=tAround$Date,Chimp="Qafzeh",Time=toSecs(tAround$Qafzeh),aggPers[16,2:7]),
  cbind(Date=tAround$Date,Chimp="Rene",Time=toSecs(tAround$Rene),aggPers[17,2:7]),
  cbind(Date=tAround$Date,Chimp="Sophie",Time=toSecs(tAround$Sophie),aggPers[18,2:7])  
  )
inPodL$Time = as.numeric(inPodL$Time)
  
mew.pois.1 = glmer(Time ~ dom + neu + agr + ext + con + opn + (1 | Date) + (1 | Chimp),
                   data=inPodL, family = poisson)
mew.pois.1s = glmer(Time ~ s(dom) + s(neu) + s(agr) + s(ext) + s(con) + s(opn) + (1 | Date) + (1 | Chimp),
                   data=inPodL, family = poisson)


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


install.packages("glmmADMB", repos=c("http://www.hafro.is/~arnima/repos", getOption("repos")))
install.packages("glmmADMB", repos=c("http://glmmadmb.r-forge.r-project.org/repos", getOption("repos")),type="source")
library(glmmADMB)

mew.poisZIF.1 <- glmmadmb(Time ~ dom + ext + con + agr + neu + opn + (1 | Date) + (1 | Chimp),
         data=inPodL, family = "poisson", zeroInflation=TRUE)
# probably choose to go with MCMCglmm

#3) Who continues to interact?


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
  tatScreen[i,13:18] = aggPers[which(as.character(tatScreen$Individual[i])==as.character(aggPers$Group.1)),2:7]

}


# outliers...
tatScreen$secs[outliers(tatScreen$secs,3)] <- NA


# model time

# how many approaches to screen?
table(tatScreen$Individual)
#aggPers$
EW3particip = c(1,0,15,5,9,15,0,8,0,0,2,4,0,1,9,0,1,2)
aggPers = cbind(aggPers, EW3particip)

mew.3.pm <- glm(EW3particip ~ dom + neu + agr + ext + con + opn, data=aggPers, family=poisson)
# again, need to ZIF
library(pscl)
mew.3.zpm <- zeroinfl(EW3particip ~ #dom + neu + 
                        agr + ext + con + opn, data=aggPers, dist="poisson")



                                                
ext.pm3=extract(mew.3.pm, include.aic = FALSE, include.bic=FALSE, include.dic=FALSE,
                 include.deviance=FALSE, include.loglik=FALSE,include.nobs=FALSE,
                 include.groups=FALSE,include.variance=FALSE)
pm3.tbl = htmlreg(ext.pm3,ci.force=TRUE, custom.model.names='Number of approaches to screen',
                   caption = "", groups=NULL, digits=3, ci.force.level = 0.95, ci.test=NULL,
                   bold=TRUE, custom.note = '', 
                   #reorder.coef = c(1:5,8,9,6,11,10,7),
                   custom.coef.names=c(NA,'Dominance','Neuroticism','Agreeableness','Extraversion',
                                      'Conscientiousness','Openness')
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
