# non-linear models of performance

library(nlme)

# y = L(x + P) /
#     x + P + R
L = 5

nlm.err <- nlme(Error ~ (L * (Trial + P))/(Trial + P + R), data = trial.dat, fixed)



# maybe still better with lmer
library(lme4)

# (L / y - 1)^-1 = x/R + P/R  

trial.dat$Err.t = ((L / trial.dat$Error) - 1 )^-1
|
lmm.err <- lmer(Err.t ~ Trial + 1 + (1 + Trial | Subject), data = trial.dat)
                  