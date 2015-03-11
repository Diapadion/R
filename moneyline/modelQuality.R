### this file follows directly from matchup.R ...

### its purpose is to test the variance being accounted for my progressive models
### to make sure that fit and prediction power is actually increasing with refinement


library(car)

# 2014

summary(gm.diff14)
summary(gm.diff14.stp)
summary(gm.diff14_3)
summary(gm.diff14_2)
summary(gm.diff14_4)

gm.diff14_5 <- glm(result ~ Rank + sagRating + Pyth + OppO + AdjO + AdjD, data=kpDiffs14, family = 'binomial')
summary(gm.diff14_5)
Anova(gm.diff14_5)

gm.diff14_5.stp <- step(gm.diff14_5)

# not sure what R is...
#gm.diff14_3$R
#gm.diff14$R

anova(gm.diff14_4,gm.diff14.stp)

Anova(gm.diff14.stp)
Anova(gm.diff14_5.stp)

# comparing these two, what happens if we throw in sagRank and sagRating to 14_5.stp
gm.diff14_6 <- glm(result ~ Rank + sagRank + sagRating + Pyth + OppO, data=kpDiffs14, family = 'binomial')
summary(gm.diff14_6)
gm.diff14_6.stp <- step(gm.diff14_6) # only has the sag vars left

anova(gm.diff14_4,gm.diff14.stp,gm.diff14_5,gm.diff14_5.stp,gm.diff14_6, gm.diff14_6.stp)



