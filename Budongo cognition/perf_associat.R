# this file requires the running of:
# fileLoader.R
# perscoring_chimp.R


s <- function(x) {scale(x)}

outliers <- function(obs, x = 2.5)
  abs(obs - mean(obs, na.rm = T)) > (sd(obs, na.rm = T) * x)



# first we need an average performance matrix

# need to deal with Frek later

accuracy <- data.frame(chimp = character(0), acc_mean = numeric(0), acc_sd = numeric(0))
accuracy <- data.frame(
  rbind.data.frame(accuracy, cbind.data.frame(chimp='Cindy',acc_mean=mean(CIdata$Accuracy),acc_sd=sd(CIdata$Accuracy)),
                  cbind.data.frame(chimp='David',acc_mean=mean(DAdata$Accuracy),acc_sd=sd(DAdata$Accuracy)),
                  cbind.data.frame(chimp='Edith',acc_mean=mean(EDdata$Accuracy),acc_sd=sd(EDdata$Accuracy)),
                  cbind.data.frame(chimp='Emma',acc_mean=mean(EMdata$Accuracy),acc_sd=sd(EMdata$Accuracy)),
                  cbind.data.frame(chimp='Eva',acc_mean=mean(EVdata$Accuracy),acc_sd=sd(EVdata$Accuracy)),
                  cbind.data.frame(chimp='Freek',acc_mean=mean(FKdata$Accuracy),acc_sd=sd(FKdata$Accuracy)),
                  #cbind.data.frame(chimp='Heleen',acc_mean=mean(HLdata$Accuracy),acc_sd=sd(HLdata$Accuracy)),
                  cbind.data.frame(chimp='Kilimi',acc_mean=mean(KLdata$Accuracy),acc_sd=sd(KLdata$Accuracy)),
                  cbind.data.frame(chimp='Kindia',acc_mean=mean(KDdata$Accuracy),acc_sd=sd(KDdata$Accuracy)),
                  #cbind.data.frame(chimp='Lianne',acc_mean=mean(LIdata$Accuracy),acc_sd=sd(LIdata$Accuracy)),
                  cbind.data.frame(chimp='Liberius',acc_mean=mean(LBdata$Accuracy),acc_sd=sd(LBdata$Accuracy)),
                  cbind.data.frame(chimp='Louis',acc_mean=mean(LOdata$Accuracy),acc_sd=sd(LOdata$Accuracy)),
                #  cbind.data.frame(chimp='Lucy',acc_mean=mean(LUdata$Accuracy),acc_sd=sd(LUdata$Accuracy)),
                  cbind.data.frame(chimp='Paul',acc_mean=mean(PAdata$Accuracy),acc_sd=sd(PAdata$Accuracy)),
                  cbind.data.frame(chimp='Pearl',acc_mean=mean(PEdata$Accuracy),acc_sd=sd(PEdata$Accuracy)),
                  cbind.data.frame(chimp='Qafzeh',acc_mean=mean(Qdata$Accuracy),acc_sd=sd(Qdata$Accuracy))
                  #cbind.data.frame(chimp='Rene',acc_mean=mean(REdata$Accuracy),acc_sd=sd(REdata$Accuracy)),
                  #cbind.data.frame(chimp='Sophie',acc_mean=mean(SOdata$Accuracy),acc_sd=sd(SOdata$Accuracy))
                                
                  
), stringsAsFactors = FALSE
                  )

# add personality
accu_pers <- cbind(accuracy,aggPers[c(-7,-10,-13,-17,-18),2:7])
#accu_pers[2:3] <- cbind(as.numeric(accu_pers[2]))
  
#some stupid model(s)
urr <- lm(acc_mean ~ s(dom) + s(ext) + s(con) + s(neu) + s(opn) + s(agr), data=accu_pers )
uurrrr <- lm(acc_sd ~ s(dom) + s(ext) + s(con) + s(neu) + s(opn) + s(agr), data=accu_pers )



runif(10,0,1)

LBlong <- 1:length(LBdata$Accuracy)

plot(1:length(CIdata$Accuracy),CIdata$Accuracy)
plot(LBdata$Accuracy ~ LBlong)
plot(1:length(EDdata$Accuracy),EDdata$Accuracy)
plot(1:length(KLdata$Accuracy),KLdata$Accuracy)
plot(1:length(PEdata$Accuracy),PEdata$Accuracy)



####### Accuracy #######
library(lme4)


# GLM (first attempt)
LBlong <- 1:length(LBdata$Accuracy)
mod.g <- glm(LBdata$Accuracy ~ LBlong, family = binomial(link = 'probit'))


# GLMMs

# this is the main one
# used in ASP 2015 presentation
mod.gm1 <- glmer(Accuracy ~ dom + con + opn + neu + agr + ext +  (1 | Group.1),
                 family = binomial, data=cz_bin_pers 
)
library(texreg)
ext.gm1=extract(mod.gm1, include.aic = FALSE, include.bic=FALSE, include.dic=FALSE,
                include.deviance=FALSE, include.loglik=FALSE,include.nobs=FALSE,
                include.groups=FALSE,include.variance=FALSE)
gm1.tbl = htmlreg(ext.gm1,ci.force=TRUE, custom.model.names='Chimpanzee Accuracy',
                  caption = "", groups=NULL, digits=3, ci.force.level = 0.95, ci.test=NULL,
                  bold=TRUE, custom.note = '', 
                  #reorder.coef = c(1:5,8,9,6,11,10,7),
                  custom.coef.names=c(NA,'Dominance','Conscientiousness','Openness',
                                      'Neuroticism','Agreeableness','Extraversion')
                  )
write(gm1.tbl,"PerfGLM.html")
# library(stargazer)
# stargazer(mod.gm1, type="html")



mod.gm2 <- glmer(Accuracy ~ dom + neu + agr + ext + con + opn + Trial + (1 | Group.1),
  family = binomial, data=cz_bin_pers 
  )


mod.gm3 <- glmer(Accuracy ~ Trial + (1 | Group.1),
                 family = binomial, data=cz_bin_pers 
)
mod.gm4 <- glmer(Accuracy ~ Trial + (1 + Trial | Group.1),
                 family = binomial, data=cz_bin_pers 
)

mod.gm3a <- glmer(Accuracy ~ Trial + s(SessionStart) + (1 | Group.1),
                             family = binomial, data=cz_bin_pers 
)

mod.gm2a <- glmer(Accuracy ~ dom + neu + agr + ext + con + opn + Trial + s(SessionStart) + (1 | Group.1),
                  family = binomial, data=cz_bin_pers 
)


anova(mod.gm1,mod.gm2,mod.gm3,mod.gm4
      #,mod.gm2a
      ) # so gm2 is the best model
# can't step is with lme4
library(lmerTest)
library(car)
#mod.gm2s <- step(mod.gm2a) # errrrgggh this would be awful nice
mod.gm2.1 <- glmer(Accuracy ~ dom + con + Trial + (1 | Group.1),
                               family = binomial, data=cz_bin_pers 
)
mod.gm2.2 <- glmer(Accuracy ~ dom + neu + ext + Trial + (1 | Group.1),
                   family = binomial, data=cz_bin_pers 
)
mod.gm2.3 <- glmer(Accuracy ~ dom + neu + Trial + (1 | Group.1),
                   family = binomial, data=cz_bin_pers 
)
mod.gm2.4 <- glmer(Accuracy ~ dom + Trial + (1 | Group.1),
                   family = binomial, data=cz_bin_pers 
)
anova(mod.gm2,mod.gm2.1,mod.gm2.2,mod.gm2.3,mod.gm2.4)


### testing some BLUP stuff from gm4
# mostly garbage
blup.gm4 = ranef(mod.gm4)

cor(blup.gm4$Group.1[,1], accu_pers$agr[c(1,3:12)])
cor.test(blup.gm4$Group.1[,1], accu_pers$dom[c(1,3:12)])
cor.test(blup.gm4$Group.1[,1], accu_pers$neu[c(1,3:12)])
cor(blup.gm4$Group.1[,1], accu_pers$opn[c(1,3:12)])
cor.test(blup.gm4$Group.1[,1], accu_pers$con[c(1,3:12)])
cor.test(blup.gm4$Group.1[,1], accu_pers$ext[c(1,3:12)])

cor(blup.gm4$Group.1[,2], accu_pers$agr[c(1,3:12)])
cor(blup.gm4$Group.1[,2], accu_pers$dom[c(1,3:12)])
cor(blup.gm4$Group.1[,2], accu_pers$neu[c(1,3:12)])
cor(blup.gm4$Group.1[,2], accu_pers$opn[c(1,3:12)])
cor(blup.gm4$Group.1[,2], accu_pers$con[c(1,3:12)])
cor.test(blup.gm4$Group.1[,2], accu_pers$ext[c(1,3:12)])

cor.test(blup.gm4$Group.1[,2], accu_pers$dom[c(1,3:12)])
cor.test(blup.gm4$Group.1[,2], accu_pers$neu[c(1,3:12)])

### cor checks of accuracy vs. personality
cor.test(accu_pers$acc_mean, accu_pers$dom)
cor(accu_pers$acc_mean, accu_pers$agr)
cor(accu_pers$acc_mean, accu_pers$ext)
cor.test(accu_pers$acc_mean, accu_pers$neu)
cor(accu_pers$acc_mean, accu_pers$opn)
cor.test(accu_pers$acc_mean, accu_pers$con)

# LDA
library(MASS)
#boxM(accu_pers[,-1], accu_pers[,1])
#mod.l <- lda(LBdata$Accuracy ~ LBlong)
mod.l <- lda()



####### Processing Time #######
cz_bin_pers$inspecTime = cz_bin_pers$SampleSelect - cz_bin_pers$SampleOn
cz_bin_pers$procTime = cz_bin_pers$ChoiceSelect - cz_bin_pers$ChoiceOn


# remove upper outliers
cz_bin_pers$procTime[outliers(cz_bin_pers$procTime,2.5)] <- NA
#outliers(cz_bin_pers$procTime, 2.5)
cz_bin_pers$inspecTime[outliers(cz_bin_pers$inspecTime,2.5)] <- NA

# log transfoooooooorrrmm
cz_bin_pers$logprocTime <- log(cz_bin_pers$procTime)
cz_bin_pers$loginspecTime <- log(cz_bin_pers$inspecTime)


shapiro.test(cz_bin_pers$logprocTime) # doesn't make sense untransformed, RT is never normal
qqnorm(cz_bin_pers$logprocTime)
qqline(cz_bin_pers$logprocTime)

shapiro.test(cz_bin_pers$loginspecTime)
qqnorm(cz_bin_pers$loginspecTime)
qqline(cz_bin_pers$loginspecTime)

#cz_bin_pers$logprocTime[outliers(cz_bin_pers$logprocTime,2.5)] <- NA
#cz_bin_pers$loginspecTime[outliers(cz_bin_pers$loginspecTime,2.5)] <- NA


mod.pt1 <- lmer(log(procTime) ~ dom + neu + opn + agr + con + ext + (1 | Group.1)
                , data=cz_bin_pers
)
mod.pt2 <- lmer(log(procTime) ~ Trial + dom + neu + opn + agr + con + ext + (1 | Group.1)
               , data=cz_bin_pers
               )
mod.pt3 <- lmer(logprocTime ~ Trial + (1 | Group.1)
                , data=cz_bin_pers
)


mod.it1 <- lmer(log(inspecTime) ~ dom + neu + opn + agr + con + ext + (1 | Group.1)
                , data=cz_bin_pers
)
mod.it2 <- lmer(log(inspecTime) ~ dom + neu + opn + agr + con + ext + Trial + (1 | Group.1)
                , data=cz_bin_pers
)
mod.it3 <- lmer(loginspecTime ~ Trial + (1 | Group.1)
                , data=cz_bin_pers
)


library(corrgram)

pBLUP = ranef(mod.pt3)
pBLUP = cbind(pBLUP$Group.1, accu_pers[c(1,3:12),])
corrgram(pBLUP)

iBLUP = ranef(mod.it3)
iBLUP = cbind(iBLUP$Group.1, accu_pers[c(1,3:12),])
corrgram(iBLUP)

cor.test(pBLUP[,12],pBLUP[,6])

cor.test(iBLUP[,12],pBLUP[,9])


# RT medians

medLogProcT <- aggregate(cz_bin_pers$logprocTime, by=list(cz_bin_pers$Group.1), FUN=median, na.rm=TRUE)
medLogInspecT <- aggregate(cz_bin_pers$loginspecTime, by=list(cz_bin_pers$Group.1), FUN=median, na.rm = TRUE)

pBLUP = cbind(pBLUP, medLogProcT)
iBLUP = cbind(iBLUP, medLogInspecT)



### GLMM check

# So this doesn't work. So won't worry about it till later, if that is even necessary.
mcmc.gm1 <- MCMCglmm(Accuracy ~ dom + ext + con + agr + neu + opn, 
                           random = ~Group.1,
                           data = cz_bin_pers, family = "multinomial"
                           , rcov=~idh(trait):units
                           # , burnin = 10000 , nitt = 90000 
                           , verbose = FALSE)
