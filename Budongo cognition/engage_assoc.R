# this file requires:


# currently this file cannot be Source'd

# [1] The bar plots of the chimps' interactions


DMAeng <- read.csv("DMA_engage.csv")

DMAeng = merge(DMAeng,aggPers, by.x= "Chimp", "Chimp")
DMAeng$Engagement <- as.ordered(DMAeng$Engagement)

library(ordinal)
# because clmm is the only mixed-mod funct I know of

# with the individual dimensions
cmm.D <- clmm(Engagement ~ Dominance
              + (1 | Date) + (1|Chimp) + (1|Pod), data=DMAeng)


# with all of them included

cmm.1 <- clmm(Engagement ~ 1 + Dominance + Conscientiousness + Neuroticism + Extraversion + 
              Agreeableness + Openness + Pod
            + (1 | Date) + (1|Chimp), data=DMAeng)

cmm.1.nA <- clmm(Engagement ~ Dominance + Conscientiousness + Neuroticism + Extraversion + 
                Openness + Pod
              + (1 | Date) + (1|Chimp), data=DMAeng)

cmm.2 <- clmm(Engagement ~ Dominance + I(Dominance^2) + Conscientiousness + Neuroticism + I(Neuroticism^2) + Extraversion + 
                         Agreeableness + Openness + Pod
              + (1 | Date) + (1|Chimp), data=DMAeng)

library(bbmle)  
AICctab(cmm.1, cmm.1.nA, cmm.2, weights=T, delta=T, base=T, logLik=T, sort=T)  
# model 1 is the best
summary(cmm.1)

ci.DMApartic <- confint(cmm.1)


library(texreg)
ext.cmm1=extract(cmm.1, include.aic = FALSE, include.bic=FALSE, include.dic=FALSE,
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



library(rms)
library(DAAG)
vif(cmm.1)

source("clmm_mer-utils.R")
# this doesn't appear to do anything for clmm, or, you know, work
vif.mer(cmm.1)



####### Everything below is outdated, based on general categorization
####### not the individuals days' data


### engagement ideas

# never involved {0}
# RE, SO, HE, LI, DA, LU, KD

# approach but never complete session {1}
# EM, LO, PA, PE, Q, EV

# complete session {2}
# ED, LB, CI, KL, FK

# based on this...
participat = as.factor(c(2,0,2,1,1,2,0,2,0,0,2,1,0,1,1,1,0,0))
aggPers = cbind(aggPers, participat)

## still useful for visualization

tm <- aggregate(aggPers, by=list(aggPers$participat), FUN=mean)
ts <- aggregate(aggPers, by=list(aggPers$participat), FUN=sd)


mp = barplot(height=as.matrix(tm[3:8]),beside=TRUE,
             #legend.text=c('Never participated','Incomplete participation','Completed full sessions'),
             names.arg=c('Dominance','Extraversion','Conscientiousness',
                         'Agreeableness','Neuroticism','Openness')
              ,ylim=c(0,7))

segments(c(mp), c(t(t(tm[3:8] - ts[3:8]))), c(mp),c(t(t(tm[3:8] + ts[3:8]))), lwd=2)
legend(legend = c('Never participated','Incomplete participation','Completed full sessions'),
       x = 2.5, y = 2,
       fill=c('grey28','grey58','grey88'))
       


vioplot(aggPers[,2:7],aggPers[,8])

with(aggPers[,2:7],vioplot(aggPers[,aggPers$participat==0],aggPers[,aggPers$participat==1],aggPers[,aggPers$participat==2]))
head(aggPers[,2:7])
aggPers[participat==0]

library(beanplot)
beanplot(data=t(aggPers[,2:7]),names=aggPers[,8])


# Ordinal Regression

# is this (polr) appropriate?
library(MASS)
mod.polr.d <- polr(participat ~ dom, data=aggPers)
mod.polr.2.d <- polr(participat ~ I(dom^2), data=aggPers)
mod.polr.all <- polr(participat ~ Dominance + Conscientiousness + Openness + 
                       Neuroticism + Extraversion + Agreeableness, data=aggPers) #**
mod.polr.2.dn <- polr(participat ~ I(Dominance^2) + Conscientiousness + Openness + 
                        I(Neuroticism^2) + Extraversion + Agreeableness, data=aggPers) #**
mod.polr.2.all <- polr(participat ~ I(dom^2) + I(con^2) + I(ext^2) + I(neu^2) + I(opn^2) + I(agr^2)
                       + con + ext + agr + opn + dom + neu, data=aggPers)

mod.polr.o <- polr(participat ~ Openness, data=aggPers)
# I think just the above is what we want
# in order to confirm O's linearity
mod.polr.a <- polr(participat ~ Agreeableness, data=aggPers)


library(rms)
mod.orm <- orm(participat ~ dom + con + neu + ext + agr + opn, data=aggPers)
mod.orm.2 <- orm(participat ~ I(dom^2) + con + I(neu^2) + ext + agr + opn, data=aggPers)



library(ordinal)
#cm.1 <- ...
cm.2 <- clm(participat ~ I(dom^2) + con + I(neu^2) + ext + agr + opn, data=aggPers)
cm.2a <- clm(participat ~ I(dom^2) + dom + con + I(neu^2) + neu + ext + agr + opn, data=aggPers)
# something is wrong above - how can Agr be the only sig predictor?
cm.agr <- clm(participat ~ agr, data=aggPers)
# Nothing. Is there an interaction? (or should I just drop it)
cm.aint <- clm(participat ~ con + ext + I(dom^2) + I(neu^2) + opn, data=aggPers)
# check with vif()
# in order to that, need to use lm() since clm() doesn't have functionality
vif(lm(as.numeric(participat) ~ Dominance + Conscientiousness + Openness + 
         Neuroticism + Extraversion + Agreeableness, data=aggPers))
# dom      con      neu      ext      agr      opn 
# 6.401741 3.181492 7.307849 1.786007 1.737412 1.756628

#cm.2.nom <- clm(participat ~ I(dom^2) + con + I(neu^2) + ext + agr + opn, nominal = ~ I(dom^2) + con + I(neu^2) + ext + agr + opn, data=aggPers)

# step(s)
cm.2.stp <- step(cm.2)
#AIC 39.35
cm.2a.stp <- step(cm.2a)
#AIC 39.55
#
# best model features dom^2, neu^2, agr, opn
anova(cm.2.stp,cm.2a.stp)


cm.naint <- clm(participat ~ I(dom^2), data=aggPers)
cm.naint.stp <- step(cm.naint, direction="forward")


# Tukey attempts using aov() based on best model (above)
dom.aov = aov(Dominance ~ participat, data = aggPers)
pers.aov = aov(aggPers$participat ~ I(aggPers$dom^2) + I(aggPers$neu^2) + aggPers$agr + aggPers$opn)
TukeyHSD(dom.aov)

agr.aov = aov(agr ~ participat, data = aggPers)
summary(agr.aov)
TukeyHSD(agr.aov)

neu.aov = aov(Neuroticism ~ participat, data = aggPers)
TukeyHSD(neu.aov)

opn.aov = aov(Openness ~ participat, data = aggPers)
TukeyHSD(opn.aov)


summary(fm1 <- aov(breaks ~ wool + tension, data = warpbreaks))
TukeyHSD(fm1, "tension", ordered = TRUE)

# Multinomial regression before Tukey'ing?
library(glmnet)
multm.a <- glmnet(as.matrix(aggPers[,2:7]),aggPers[,8],family="multinomial")
plot(cv.glmnet(as.matrix(aggPers[,2:7]),aggPers[,8],family="multinomial"))
#TukeyHSD(multm.1) # doesn't work

library(nnet)
multim.b1 <- multinom(participat ~ dom + con + neu + ext + agr + opn, data=aggPers)
multim.b2 <- multinom(participat ~ I(dom^2) + con + I(neu^2) + ext + agr + opn, data=aggPers)
TukeyHSD(multim.b2)

# Scheffe etc tests
library(multcomp)
#glht(cm.2.stp)
glht(multim.b1)


#t-tests
library(BSDA)
# Dominance
tsum.test(tm$dom[1],ts$dom[1],7,tm$dom[2],ts$dom[2],6)
tsum.test(tm$dom[3],ts$dom[3],5,tm$dom[2],ts$dom[2],6)
tsum.test(tm$dom[1],ts$dom[1],7,tm$dom[3],ts$dom[3],5)
# Neuroticism
tsum.test(tm$neu[1],ts$neu[1],7,tm$neu[2],ts$neu[2],6)
tsum.test(tm$neu[3],ts$neu[3],5,tm$neu[2],ts$neu[2],6)
tsum.test(tm$neu[1],ts$neu[1],7,tm$neu[3],ts$neu[3],5)

# Agreeableness
tsum.test(tm$agr[1],ts$agr[1],7,tm$agr[2],ts$agr[2],6)
tsum.test(tm$agr[3],ts$agr[3],5,tm$agr[2],ts$agr[2],6)
tsum.test(tm$agr[1],ts$agr[1],7,tm$agr[3],ts$agr[3],5)

# Openness
tsum.test(tm$opn[1],ts$opn[1],7,tm$opn[2],ts$opn[2],6)
tsum.test(tm$opn[3],ts$opn[3],5,tm$opn[2],ts$opn[2],6)
tsum.test(tm$opn[1],ts$opn[1],7,tm$opn[3],ts$opn[3],5)

aggPers[order(aggPers[,8],decreasing=FALSE),]



#ultimately with BEST and JAGS





