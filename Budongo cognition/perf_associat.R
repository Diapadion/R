# this file requires the running of:
# fileLoader.R
# perscoring_chimp.R

s <- function(x) {scale(x)}

###
#some correlations


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





# GLM (first attempt)
LBlong <- 1:length(LBdata$Accuracy)
mod.g <- glm(LBdata$Accuracy ~ LBlong, family = binomial(link = 'probit'))


# GLMMs

mod.gm1 <- glmer(Accuracy ~ dom + neu + agr + ext + con + opn + (1 | Group.1),
                 family = binomial, data=cz_bin_pers 
)

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
# stepwise it
library(lmerTest)
#mod.gm2s <- step(mod.gm2) # errrrgggh this would be awful nice
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

### cor checks of accuracy vs. personality
cor.test(accu_pers$acc_mean, accu_pers$dom)
cor(accu_pers$acc_mean, accu_pers$agr)
cor(accu_pers$acc_mean, accu_pers$ext)
cor.test(accu_pers$acc_mean, accu_pers$neu)
cor(accu_pers$acc_mean, accu_pers$opn)
cor.test(accu_pers$acc_mean, accu_pers$con)

# LDA
boxM(accu_pers[,-1], accu_pers[,1])
#mod.l <- lda(LBdata$Accuracy ~ LBlong)
mod.l <- lda()
