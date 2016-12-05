# Power Analysis attemps

library(simr)

powerSim(mod.gm1, test = fixed('Openness') ,
         nsim = 100)
# 60%
powerSim(mod.gm2, test = fixed('Openness') ,
         nsim = 100)
# 47%
powerSim(mod.gm4, test = fixed('Openness') ,
         nsim = 100)
# 48%

summary(rs.glm1)
powerSim(rs.glm1, test = fixed('Openness') ,
         nsim = 100)
# 49%
powerSim(rs.glm1, test = fixed('Extraversion') ,
         nsim = 100)
# 96%


powerSim(mew.3.pgmm, test = fixed('Openness'), nsim = 100)
# 96
powerSim(mew.3.pgmm, test = fixed('Extraversion'), nsim = 100)
# 90%




library(lmerTest)

anova(mod.gm1, ddf = 'Kenward-Roger')
#anova(RS.trial.lmm.tot, ddf='Kenward-Roger')
