# Power Analysis attemps

library(simr)
library(ordinal)
library(lmerTest)
library(powerSurvEpi)


### Study 1


## Drop-out

pwr.1.drop.cox_f.c <- powerEpiCont(formula = freq ~ Dominance + Conscientiousness + Openness + Neuroticism +
                                   Agreeableness + Extraversion,
                                 dat = aggTraTri,
                                 X1 = aggTraTri$Conscientiousness,
                                 failureFlag = aggTraTri$dropped,
                                 n = 19, theta = 0.06)

pwr.1.drop.cox_f.a <- powerEpiCont(formula = freq ~ Dominance + Conscientiousness + Openness + Neuroticism +
                                   Agreeableness + Extraversion,
                                 dat = aggTraTri,
                                 X1 = aggTraTri$Agreeableness,
                                 failureFlag = aggTraTri$dropped,
                                 n = 19, theta = 9.12)
                                   
# not possible for AFT
pwr.1.drop.aft_f
RS.drop.aft.frail


## Trials to criterion
pwr.1.criter.c = powerSim(RS.trial.glmm.tot, test = fixed('Conscientiousness'), nsim=1000)


## Accuracy

pwr.1.accu.1.d <- powerSim(rs.glm1.0, test = fixed('Dominance') , nsim = 1000)
pwr.1.accu.1.c <- powerSim(rs.glm1.0, test = fixed('Conscientiousness') , nsim = 1000)
pwr.1.accu.1.e <- powerSim(rs.glm1.0, test = fixed('Extraversion') , nsim = 1000)
# 96%

pwr.1.accu.3.d <- powerSim(rs.glm3.0, test = fixed('Dominance') , nsim = 1000)
pwr.1.accu.3.c <- powerSim(rs.glm3.0, test = fixed('Conscientiousness') , nsim = 1000)
pwr.1.accu.3.e <- powerSim(rs.glm3.0, test = fixed('Extraversion') , nsim = 1000)

pwr.1.accu.3td.d <- powerSim(rs.glm3.td, test = fixed('Dominance') , nsim = 1000)
pwr.1.accu.3td.c <- powerSim(rs.glm3.td, test = fixed('Conscientiousness') , nsim = 1000)
pwr.1.accu.3td.e <- powerSim(rs.glm3.td, test = fixed('Extraversion') , nsim = 1000)


## RTs

pwr.1.RT.all.c <- powerSim(rs.rt.lmm.pers, test=fixed('Conscientiousness'), nsim=1000)
pwr.1.RT.all.o <- powerSim(rs.rt.lmm.pers, test=fixed('Openness'), nsim=1000)
pwr.1.RT.all.a <- powerSim(rs.rt.lmm.pers, test=fixed('Agreeableness'), nsim=1000)
pwr.1.RT.all.e <- powerSim(rs.rt.lmm.pers, test=fixed('Extraversion'), nsim=1000)

pwr.1.RT.1.c <- powerSim(rs.rt.lmm.1, test=fixed('Conscientiousness'), nsim=1000)
pwr.1.RT.1.o <- powerSim(rs.rt.lmm.1, test=fixed('Openness'), nsim=1000)
pwr.1.RT.1.a <- powerSim(rs.rt.lmm.1, test=fixed('Agreeableness'), nsim=1000)
pwr.1.RT.1.e <- powerSim(rs.rt.lmm.1, test=fixed('Extraversion'), nsim=1000)

pwr.1.RT.1d.c <- powerSim(rs.rt.lmm.1.day, test=fixed('Conscientiousness'), nsim=1000)
pwr.1.RT.1d.o <- powerSim(rs.rt.lmm.1.day, test=fixed('Openness'), nsim=1000)
pwr.1.RT.1d.a <- powerSim(rs.rt.lmm.1.day, test=fixed('Agreeableness'), nsim=1000)
pwr.1.RT.1d.e <- powerSim(rs.rt.lmm.1.day, test=fixed('Extraversion'), nsim=1000)


## Touches

pwr.1.touch.c <- powerSim(rs.touch.lmm, test = fixed('Conscientiousness'), nsim = 1000)



### Study 2


## Engagement


#pwr.2.eng.1.o <- powerSim(cmm.1, test = fixed('Openness') , nsim = 1000)
# not feasible


## Accuracy

pwr.2.accu.1.o  <- powerSim(mod.gm1, test = fixed('Openness') , nsim = 1000)
# 50%

# only the first model matters

# 
# pwr.2.accu.2.o  <- powerSim(mod.gm2, test = fixed('Openness') ,
#                             nsim = 100)
# # 60%
# pwr.2.accu.2.d  <- powerSim(mod.gm2, test = fixed('Dominance') ,
#                             nsim = 100)
# pwr.2.accu.2.e  <- powerSim(mod.gm2, test = fixed('Extraversion') ,
#                             nsim = 100)
# pwr.2.accu.2.a  <- powerSim(mod.gm2, test = fixed('Agreeableness') ,
#                             nsim = 100)
# pwr.2.accu.2.n  <- powerSim(mod.gm2, test = fixed('Neuroticism') ,
#                             nsim = 100)
# pwr.2.accu.2.c  <- powerSim(mod.gm2, test = fixed('Conscientiousness') ,
#                             nsim = 100)
# 
# 
# pwr.2.accu.4.o  <- powerSim(mod.gm4, test = fixed('Openness') ,
#                             nsim = 100)
# # 60%
# pwr.2.accu.4.d  <- powerSim(mod.gm4, test = fixed('Dominance') ,
#                             nsim = 100)
# pwr.2.accu.4.e  <- powerSim(mod.gm4, test = fixed('Extraversion') ,
#                             nsim = 100)
# pwr.2.accu.4.a  <- powerSim(mod.gm4, test = fixed('Agreeableness') ,
#                             nsim = 100)
# pwr.2.accu.4.n  <- powerSim(mod.gm4, test = fixed('Neuroticism') ,
#                             nsim = 100)
# pwr.2.accu.4.c  <- powerSim(mod.gm4, test = fixed('Conscientiousness') ,
#                             nsim = 100)

# powerSim(mod.gm4, test = fixed('Openness') ,
#          nsim = 100)
# 48%


## Response Times

# none of the models have significant effects



### Study 3


## Time spent in research pod

pwr.3.tInPod.e <- powerSim(mew.ng.1, test = fixed('Extraversion'), nsim=1000)
# 81%


## Approaches to the screen

# These won't work
#pwr.3.approach.a <- powerSim(mew.3.nbm, test = fixed('Agreeableness'), nsim=100)
#pwr.3.approach.c

## Time spent at the screen


pwr.3.tAtScr.o <- powerSim(mew.3.pgmm, test = fixed('Openness'), nsim = 1000)
# 96%
pwr.3.tAtScr.e <- powerSim(mew.3.pgmm, test = fixed('Extraversion'), nsim = 1000)
# 87%








library(lmerTest)

anova(mod.gm1, ddf = 'Kenward-Roger')
#anova(RS.trial.lmm.tot, ddf='Kenward-Roger')
