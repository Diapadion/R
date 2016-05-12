library(BayesFactor)


data(puzzles)
## neverExclude argument makes sure that participant factor ID
## is in all models
result = generalTestBF(RT ~ shape*color + ID, data = puzzles, whichRandom = "ID",
                       neverExclude="ID", progress=FALSE)
result




BF.p = lm(as.numeric(participat) ~ Dominance + Conscientiousness + Openness + 
     Neuroticism + Extraversion + Agreeableness, data=aggPers)
summary(BF.p)

lmBF.1 = lmBF(as.numeric(participat) ~ Dominance + Conscientiousness + Openness + 
                Neuroticism + Extraversion + Agreeableness, data=aggPers, progress=F)


regrBF.1 = regressionBF(as.numeric(participat) ~ Dominance + Conscientiousness + Openness + 
                Neuroticism + Extraversion + Agreeableness, data=aggPers)




mod.gm1 <- generalTestBF(as.numeric(Accuracy) ~ Dominance + Conscientiousness + Openness + Neuroticism
                 + Agreeableness + Extraversion + as.factor(Chimp),
                 whichRandom = "Chimp",
                 #family = binomial, 
                 data=cz_bin_pers 
)

