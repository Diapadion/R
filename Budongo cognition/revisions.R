####### for revisions

library(bbmle)
library(MuMIn)


### For describing number of trials, etc.
table(RSdat$chimp)
View(RSdat[RSdat$chimp=='Lucy',])

## General picture of accuracy
table(RSdat$chimp[RSdat$Correctness==" Correct"])
table(RSdat$chimp[RSdat$Correctness==" Correct"])/table(RSdat$chimp)

mean(as.numeric(RSdat$Correctness)-1)


## some descriptors for revision (Study 2)
table(cz_bin_pers$Chimp)
aggregate(as.numeric(cz_bin_pers$Accuracy)-1, by=list(Chimp=cz_bin_pers$Chimp), FUN=mean, na.action = na.omit)

mean(as.numeric(cz_bin_pers$Accuracy)-1)
# median(as.numeric(cz_bin_pers$Accuracy)-1)

sum(table(cz_bin_pers$Accuracy[cz_bin_pers$Chimp=='Liberius'])
)








### Why are the RT simulations crashing? Let's try a few things
RStemp$logRT = log(RStemp$RT)

rs.rt.glmm.pers.pwr.1 <- glmer(RT ~ Dominance + Conscientiousness + Openness + Neuroticism +
                                 Agreeableness + Extraversion +
                                 (1 | chimp) + (1 | stage) + (1 | TrialType),
                               family = Gamma(link="identity"),
                               control =  glmerControl(optimizer = "optimx", 
                                                       optCtrl=list(#maxfun=1000, 
                                                         method='nlminb')) 
                               #= glmerControl(optimizer='Nelder_Mead') #nloptwrap
                               , data = RStemp
)
# AIC      BIC   logLik deviance df.resid 
# 79865.8  79948.5 -39921.9  79843.8    13655
rs.rt.glmm.pers.pwr.2 <- glmer(RT ~ Dominance + Conscientiousness + Openness + Neuroticism +
                                 Agreeableness + Extraversion +
                                 (1 | chimp) + (1 | stage) + (1 | TrialType),
                               family = Gamma(link="inverse")
                               , data = RStemp
)
# AIC      BIC   logLik deviance df.resid 
# 79825.3  79908.1 -39901.7  79803.3    13655 
rs.rt.glmm.pers.pwr.3 <- glmer(RT ~ Dominance + Conscientiousness + Openness + Neuroticism +
                                 Agreeableness + Extraversion +
                                 (1 | chimp) + (1 | stage) + (1 | TrialType),
                               family = Gamma(link="log")
                               , data = RStemp
)
# AIC      BIC   logLik deviance df.resid 
# 79837.7  79920.4 -39907.8  79815.7    13655 

# also vs. the old LMM
#                     logLik   AIC      
# rs.rt.lmm.pers     -19647.2  39316.3 
# ... but this is with different data

AICtab(rs.rt.glmm.pers.pwr.1, rs.rt.glmm.pers.pwr.2, rs.rt.glmm.pers.pwr.3, rs.rt.gamma,
       #rs.rt.lmm.1, rs.rt.lmm.1.day, rs.rt.lmm.1.td,
       weights=T, delta=T, base=T, logLik=T, sort=T) 

summary(rs.rt.glmm.pers.pwr.2)

r.squaredGLMM(rs.rt.lmm.pers) # not usable on the Gamma models



### Moving fwd with log Gamma models

# which are by far the most stable of the link options
# New models start here:

rs.rt.logamma <- glmer(RT ~ Dominance + Conscientiousness + Openness + Neuroticism +
                         Agreeableness + Extraversion +
                         (1 | chimp) + (1 | stage) + (1 | TrialType) #+ (1 | Section) + (1 | depend)
                       ,family = Gamma(link="log"),
                       control =  glmerControl(optimizer = 'Nelder_Mead')
                       , data = RStemp
)

rs.rt.logamma.d <- glmer(RT ~ Dominance + Conscientiousness + Openness + Neuroticism +
                           Agreeableness + Extraversion + scale(day) + 
                           (1 | chimp) + (1 | stage) + (1 | TrialType) #+ (1 | Section) + (1 | depend)
                         ,family = Gamma(link="log"),
                         control =  glmerControl(optimizer = 'Nelder_Mead')
                         
                         , data = RStemp
)
AICtab(rs.rt.logamma, rs.rt.logamma.d,
       weights=T, delta=T, base=T, logLik=T, sort=T) 
pchisq(2*(-39906.3+39907.8),12-11,lower.tail=F)
# 0.08326452
# Stick with initial model.


# rs.rt.logamma.td <- glmer(RT ~ Dominance + Conscientiousness + Openness + Neuroticism +
#                             Agreeableness + Extraversion + scale(day) + scale(Trial) + 
#                             (1 | chimp) + (1 | stage) + (1 | TrialType) #+ (1 | Section) + (1 | depend)
#                           ,family = Gamma(link="log")
#                           # ,control =  glmerControl(optimizer = "optimx", 
#                           #                          optCtrl=list(#maxfun=1000,
#                           #                            method='L-BFGS-G')) 
#                           , data = RStemp
# )
# AICtab(rs.rt.gamma, rs.rt.gamma.d, rs.rt.invgamma, rs.rt.invgamma.d, 
#        rs.rt.logamma, rs.rt.logamma.d, rs.rt.logamma.td,
#        #rs.rt.lmm.1, rs.rt.lmm.1.day, rs.rt.lmm.1.td,
#        weights=T, delta=T, base=T, logLik=T, sort=T) 


rs.rt1.logamma <- glmer(RT ~ Dominance + Conscientiousness + Openness + Neuroticism +
                          Agreeableness + Extraversion +
                          (1 | chimp) + (1 | stage) + (1 | TrialType) #+ (1 | Section) + (1 | depend)
                        ,family = Gamma(link="log"),
                        control =  glmerControl(optimizer = 'Nelder_Mead')
                        , data = RStemp[RStemp$Correctness==' Correct',]
)

rs.rt1.logamma.d <- glmer(RT ~ Dominance + Conscientiousness + Openness + Neuroticism +
                            Agreeableness + Extraversion + scale(day) + 
                            (1 | chimp) + (1 | stage) + (1 | TrialType) #+ (1 | Section) + (1 | depend)
                          ,family = Gamma(link="log"),
                          control =  glmerControl(optimizer = 'Nelder_Mead')
                          , data = RStemp[RStemp$Correctness==' Correct',]
)
AICtab(rs.rt1.logamma, rs.rt1.logamma.d,
       weights=T, delta=T, base=T, logLik=T, sort=T) 
pchisq(2*(-23913.0+23913.1),12-11,lower.tail=F)
# 0.6547208

# Stick with model 1.

# New models mean new CIs

ci.RT = confint(rs.rt.logamma, method='Wald')
ci.RT.1 = confint(rs.rt1.logamma, method='Wald')



### We were probably using the wrong model distr for RTs. Well, for consistency, we need to use log Gamma now anyway
### Study 2 RTs

library(optimx)

# All trials - processing time
mod.ptG.1 <- glmer(procTime ~ Dominance + Conscientiousness + Openness + Neuroticism
                   + Agreeableness + Extraversion + (1 | Chimp),
                   family = Gamma(link="log")
                   , data=cz_bin_pers
)
mod.ptG.2 <- glmer(procTime ~ Dominance + Conscientiousness + Openness + Neuroticism
                   + Agreeableness + Extraversion + s(day) + (1 | Chimp),
                   family = Gamma(link="log"),
                   control =  glmerControl(optimizer = "optimx", 
                                           optCtrl=list(#maxfun=1000, 
                                             method='nlminb'))
                   , data=cz_bin_pers
)
AICtab(mod.ptG.1, mod.ptG.2,
       weights=T, delta=T, base=T, logLik=T, sort=T) 
pchisq(2*(-4414.4+4552.8),10-9,lower.tail=F)
# [1] 3.740638e-62
mod.ptG.3 <- glmer(procTime ~ Dominance + Conscientiousness + Openness + Neuroticism
                   + Agreeableness + Extraversion + s(day) + s(Trial) + (1 | Chimp),
                   family = Gamma(link="log"),
                   #control =  glmerControl(optimizer = 'Nelder_Mead'#"optimx", 
                   # optCtrl=list(maxfun=1000, 
                   #   method='L-BFGS-G') #'nlminb'
                   #)
                   data=cz_bin_pers
) # Will not converge - stick with model 2.


## Rewarded trials - processing time
mod.ptGrw.1 <- glmer(procTime ~ Dominance + Conscientiousness + Openness + Neuroticism
                     + Agreeableness + Extraversion + (1 | Chimp),
                     family = Gamma(link="log"),
                     control =  glmerControl(optimizer = "optimx", 
                                             optCtrl=list(#maxfun=1000, 
                                               method='nlminb')) 
                     , data=cz_bin_pers[cz_bin_pers$Accuracy==1,]
)
mod.ptGrw.2 <- glmer(procTime ~ Dominance + Conscientiousness + Openness + Neuroticism
                     + Agreeableness + Extraversion + s(day) + (1 | Chimp),
                     family = Gamma(link="log"),
                     control =  glmerControl(optimizer = "optimx", 
                                             optCtrl=list(#maxfun=1000, 
                                               method='nlminb')) 
                     , data=cz_bin_pers[cz_bin_pers$Accuracy==1,]
)
AICtab(mod.ptGrw.1, mod.ptGrw.2,
       weights=T, delta=T, base=T, logLik=T, sort=T) 
pchisq(2*(-2480.8+2539.8),10-9,lower.tail=F)
# 1.73388e-27
mod.ptGrw.3 <- glmer(procTime ~ Dominance + Conscientiousness + Openness + Neuroticism
                     + Agreeableness + Extraversion + s(day) + s(Trial) + (1 | Chimp),
                     family = Gamma(link="log"),
                     control =  glmerControl(optimizer = "optimx", 
                                             optCtrl=list(#maxfun=1000, 
                                               method='nlminb')) 
                     , data=cz_bin_pers[cz_bin_pers$Accuracy==1,]
)
AICtab(mod.ptGrw.1, mod.ptGrw.2, mod.ptGrw.3,
       weights=T, delta=T, base=T, logLik=T, sort=T) 
pchisq(2*(-2472.9+2480.8),10-9,lower.tail=F)
# 7.040251e-05

# Model 3 is the best.
pchisq(2*(-2472.9+2539.8),10-8,lower.tail=F)


## All trials - inspection time
mod.itG.1 <- glmer(inspecTime ~ Dominance + Conscientiousness + Openness + Neuroticism
                   + Agreeableness + Extraversion + (1 | Chimp),
                   family = Gamma(link="log")
                   , data=cz_bin_pers
)
mod.itG.2 <- glmer(inspecTime ~ Dominance + Conscientiousness + Openness + Neuroticism
                   + Agreeableness + Extraversion + s(day) + (1 | Chimp),
                   family = Gamma(link="log")
                   , data=cz_bin_pers
)
AICtab(mod.itG.1, mod.itG.2,
       weights=T, delta=T, base=T, logLik=T, sort=T) 
pchisq(2*(-4692.2+4836),10-9,lower.tail=F)
# 1.657685e-64
mod.itG.3 <- glmer(inspecTime ~ Dominance + Conscientiousness + Openness + Neuroticism
                   + Agreeableness + Extraversion + s(day) + s(Trial) + (1 | Chimp),
                   family = Gamma(link="log"),
                   control =  glmerControl(optimizer = "optimx", 
                                           optCtrl=list(#maxfun=1000, 
                                             method='nlminb')) 
                   , data=cz_bin_pers
)
AICtab(mod.itG.1, mod.itG.2, mod.itG.3,
       weights=T, delta=T, base=T, logLik=T, sort=T) 
pchisq(2*(-4659.5+4692.2),11-10,lower.tail=F)
# 6.113889e-16

# Model 3 is the best.


## Rewarded trials - inspection time
mod.itGrw.1 <- glmer(inspecTime ~ Dominance + Conscientiousness + Openness + Neuroticism
                     + Agreeableness + Extraversion + (1 | Chimp),
                     family = Gamma(link="log")
                     , data=cz_bin_pers[cz_bin_pers$Accuracy==1,]
)
mod.itGrw.2 <- glmer(inspecTime ~ Dominance + Conscientiousness + Openness + Neuroticism
                     + Agreeableness + Extraversion + s(day) + (1 | Chimp),
                     family = Gamma(link="log")
                     , data=cz_bin_pers[cz_bin_pers$Accuracy==1,]
)
AICtab(mod.itGrw.1, mod.itGrw.2,
       weights=T, delta=T, base=T, logLik=T, sort=T) 
pchisq(2*(-2567.6+2631.5),10-9,lower.tail=F)
# 1.241432e-29
mod.itGrw.3 <- glmer(inspecTime ~ Dominance + Conscientiousness + Openness + Neuroticism
                     + Agreeableness + Extraversion + s(day) + s(Trial) + (1 | Chimp),
                     family = Gamma(link="log")
                     , data=cz_bin_pers[cz_bin_pers$Accuracy==1,]
)
AICtab(mod.itGrw.1, mod.itGrw.2, mod.itGrw.3,
       weights=T, delta=T, base=T, logLik=T, sort=T) 
pchisq(2*(-2547.6+2567.6),10-9,lower.tail=F)
# 2.539629e-10

# Model 3 is the best.
pchisq(2*(-2547.6+2631.5),10-8,lower.tail=F)

## New CIs

ci.pt2.G <- confint(mod.ptG.2, method='Wald')
ci.ptrw.3.G <- confint(mod.ptGrw.3, method='Wald')
ci.it3.G <- confint(mod.itG.3, method='Wald')
ci.itrw.3.G <- confint(mod.itGrw.3, method='Wald')



### Power analysis results

# D
d.pwr = c(81,63,77, 95)
mean(d.pwr)
  
# C
c.pwr = c(93,73,93,65,92,90,77)
mean(c.pwr)

# O
o.pwr = c(80,76,50,96)
mean(o.pwr)

# N
n.pwr = c(77)

# A
a.pwr = c(95,87,60,26)
mean(a.pwr)

# E
e.pwr = c(96,88,94,93,88,84,97,86,81,87)
mean(e.pwr)



### Combining and anonymizing data for Dryad

chNames = c('A3850','B1436','C2114','D6517','E7774','F2037','G5131','H2266','I3971',
            'J9399','K5443','L1147','M2488','N4140','O7218','P7437','Q6065','R0466'
            #,'S8073' # Lyndsey is the last in the list
)
mapping = data.frame(old = aggPers$Chimp,
                     new = chNames)

## Study 1

colnames(RSdat)
Dryad1 <- RSdat[,c(-11,-12)]

Dryad1$chimp <- with(mapping, new[match(Dryad1$chimp, old)])

write.csv(Dryad1, file="../Study1.csv")


## Study 2

colnames(cz_bin_pers)
Dryad2.1 <- cz_bin_pers[,c(1:2,8:14,27)]
Dryad2.1$Chimp <- with(mapping, new[match(Dryad2.1$Chimp, old)])
write.csv(Dryad2.1,file='Study2performance.csv')


colnames(DMAeng)
Dryad2.2 <- DMAeng[,c(1:4)]
Dryad2.2$Chimp <- with(mapping, new[match(Dryad2.2$Chimp, old)])
write.csv(Dryad2.2,file='Study2participation.csv')


### Study 3

colnames(inPodL) 
Dryad3.1 <- inPodL[,c(1:3)]
Dryad3.1$Chimp <- with(mapping, new[match(Dryad3.1$Chimp, old)])
write.csv(Dryad3.1,file='Study3inPods.csv')

colnames(tatScreen)
Dryad3.2 <- tatScreen[,c(1:5)]
Dryad3.2$Individual <- with(mapping, new[match(Dryad3.2$Individual, old)])
write.csv(Dryad3.2,file='Study3atScreen.csv')



### Final round