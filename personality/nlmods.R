# non-linear models of performance

library (dplyr)

trial.dat<-left_join(trial.dat, mtrim, by='Subject')
trial.dat$Subject = as.factor(trial.dat$Subject)


library(ggplot2)
gg.e <- ggplot(trial.dat, aes(Trial,Error))+geom_point()+
  facet_wrap(~Subject)

gg.e + stat_summary(fun.data="mean_cl_boot",colour='red') + stat_smooth(method='glm') # this isn't very good



gg.p <- ggplot(trial.dat, aes(Trial,Progress))+geom_point()+
  facet_wrap(~Subject)

gg.p + stat_summary(fun.data="mean_cl_boot",colour='green')


gg.p.tr <-  ggplot(trial.dat, aes(Trial,Prog.t))+geom_point()+
  facet_wrap(~Subject)
gg.p.tr + stat_summary(fun.data="mean_cl_boot",colour='green') + stat_smooth(method='lm')

### PROGRESS

library(lme4)
library(car)

# y = L(x + P) /
#     x + P + R
L = 5

# (L / y - 1)^-1 = x/R + P/R  

trial.dat$Prog.t = ((L / trial.dat$Progress) - 1 )^-1


# linear(ly transformed) models

#null models
lmm.Prog.00 <- lmer(Prog.t ~ (1 | Subject ), data=trial.dat)
lmm.Prog.0 <- lmer(Prog.t ~ Trial + 1 + (1 + Trial| Subject), data = trial.dat)

lmm.Prog.o.main <- lmer(Prog.t ~ Trial + 1 + Trial + Openness + (1 + Trial| Subject), data = trial.dat)
lmm.Prog.o.mainint <- lmer(Prog.t ~ Trial + 1 + Trial*Openness + (1 + Trial| Subject), data = trial.dat)
lmm.Prog.o.int <- lmer(Prog.t ~ Trial + 1 + Trial:Openness + (1 + Trial| Subject), data = trial.dat)
# main+interaction is best

lmm.Prog.f.main <- lmer(Prog.t ~ Trial + 1 + Trial + Friendliness + (1 + Trial| Subject), data = trial.dat)
lmm.Prog.f.mainint <- lmer(Prog.t ~ Trial + 1 + Trial * Friendliness + (1 + Trial| Subject), data = trial.dat)
anova(lmm.Prog.00,lmm.Prog.0,lmm.Prog.f.main,lmm.Prog.f.mainint)

lmm.Prog.c.main <- lmer(Prog.t ~ Trial + 1 + Trial + Confidence + (1 + Trial| Subject), data = trial.dat)
lmm.Prog.c.mainint <- lmer(Prog.t ~ Trial + 1 + Trial * Confidence + (1 + Trial| Subject), data = trial.dat)
anova(lmm.Prog.00,lmm.Prog.0,lmm.Prog.c.main,lmm.Prog.c.mainint)

lmm.Prog.ac.main <- lmer(Prog.t ~ Trial + 1 + Trial + Activity + (1 + Trial| Subject), data = trial.dat)
#lmm.Prog.ac.mainint <- lmer(Prog.t ~ Trial + 1 + Trial * Confidence + (1 + Trial| Subject), data = trial.dat)

lmm.Prog.d.main <- lmer(Prog.t ~ Trial + 1 + Trial + Dominance + (1 + Trial| Subject), data = trial.dat)
#lmm.Prog.d.mainint <- lmer(Prog.t ~ Trial + 1 + Trial * Confidence + (1 + Trial| Subject), data = trial.dat)

lmm.Prog.an.main <- lmer(Prog.t ~ Trial + 1 + Trial + Anxiety + (1 + Trial| Subject), data = trial.dat)
#lmm.Prog.an.mainint <- lmer(Prog.t ~ Trial + 1 + Trial * Confidence + (1 + Trial| Subject), data = trial.dat)


lmm.Prog.fo.main <- lmer(Prog.t ~ Trial + 1 + Trial + Friendliness + Openness + (1 + Trial| Subject), data = trial.dat)

# this isn't kosher since the equation does not have a quadratic term
lmm.Prog.fo.mainint <- lmer(Prog.t ~ Trial + 1 + Trial + Friendliness * Openness + (1 + Trial| Subject), data = trial.dat)


anova(lmm.Prog.00,lmm.Prog.0,lmm.Prog.f.main,lmm.Prog.c.main,lmm.Prog.o.main,
            lmm.Prog.d.main,lmm.Prog.ac.main,lmm.Prog.an.main)

prog.AICc <- AICctab(lmm.Prog.00,lmm.Prog.0,lmm.Prog.f.main,lmm.Prog.c.main,lmm.Prog.o.main,
      lmm.Prog.d.main,lmm.Prog.ac.main,lmm.Prog.an.main,lmm.Prog.fo.main,#lmm.Prog.fo.mainint,
      logLik=TRUE, delta=TRUE,base=TRUE)

###

library(bbmle) # for ICtab
prog.AIC <- AICctab(lmm.Prog.0,lmm.Prog.00,lmm.Prog.f,lmm.Prog.o,lmm.Prog.fo,lmm.Prog.all,
                   lmm.Prog.c, lmm.Prog.ac,lmm.Prog.an,lmm.Prog.d,
                   #type=c("BIC","AIC","AICc","qAIC","qAICc"),
                   logLik=TRUE, delta=TRUE, base=TRUE, dispersion=TRUE)

BICtab(lmm.Prog.0,lmm.Prog.f,lmm.Prog.o,lmm.Prog.fo,lmm.Prog.all, #type=c("BIC","AIC","AICc","qAIC","qAICc"),
       logLik=TRUE)

## BLUP individual parameter tests
BLUP.prog = ranef(lmm.Prog.0,drop=TRUE)

# intercept: P/R
cor.test(unlist(BLUP.prog$Subject[1]),mtrim$Friendliness)
cor.test(unlist(BLUP.prog$Subject[1]),mtrim$Openness)
cor.test(unlist(BLUP.prog$Subject[1]),mtrim$Anxiety)
cor.test(unlist(BLUP.prog$Subject[1]),mtrim$Activity)
cor.test(unlist(BLUP.prog$Subject[1]),mtrim$Dominance)
cor.test(unlist(BLUP.prog$Subject[1]),mtrim$Confidence)

# just P

# slope: 1/R -> transform via 1/beta
# this needs to be tested
cor.test(1/unlist(BLUP.err$Subject[2]),mtrim$Friendliness)
cor.test(1/unlist(BLUP.err$Subject[2]),mtrim$Openness)
cor.test(1/unlist(BLUP.err$Subject[2]),mtrim$Confidence)




### ERROR

# this one we can try with a quadratic fit




#trial.dat$Err.t = ((L / trial.dat$Error) - 1 )^-1
# this transform makes regular OLS not a great approach
# one alternative is Weighted LS, but ML is still good, and REML probably best

#|

# null model
lmm.err.0 <- lmer(Err.t ~ Trial + 1 + (1 + Trial| Subject), data = trial.dat)

lmm.err.o <- lmer(Err.t ~ Trial + 1 
                  #  + (1 + Trial|Subject) 
                    + (1 + Trial|Openness)
                    #+ Openness + Friendliness + Dominance + Confidence + Activity)
                         , data = trial.dat)

lmm.err.f <- lmer(Err.t ~ Trial + 1 
                  #+ (1 + Trial|Subject) 
                  + (1 + Trial|Friendliness)
                  #+ Openness + Friendliness + Dominance + Confidence + Activity)
                  , data = trial.dat)

lmm.err.fo <- lmer(Err.t ~ Trial + 1 
                    #+ (1 + Trial|Subject)                   
                    + (1 + Trial|Friendliness) 
                    + (1 + Trial|Openness)
                    #+ Openness + Friendliness + Dominance + Confidence + Activity)
                    , data = trial.dat)

# lmm.err.fxo <- lmer(Err.t ~ Trial + 1 
#                    #+ (1 + Trial|Subject)                   
#                    + (1 + Trial|Friendliness:Openness)
#                    #+ Openness + Friendliness + Dominance + Confidence + Activity)
#                    , data = trial.dat)

lmm.err.ac <- lmer(Err.t ~ Trial + 1 
                  #+ (1 + Trial|Subject) 
                  + (1 + Trial|Activity)
                  #+ Openness + Friendliness + Dominance + Confidence + Activity)
                  , data = trial.dat)

lmm.err.an <- lmer(Err.t ~ Trial + 1 
                  #+ (1 + Trial|Subject) 
                  + (1 + Trial|Anxiety)
                  #+ Openness + Friendliness + Dominance + Confidence + Activity)
                  , data = trial.dat)

lmm.err.c <- lmer(Err.t ~ Trial + 1 
                  #+ (1 + Trial|Subject) 
                  + (1 + Trial|Confidence)
                  #+ Openness + Friendliness + Dominance + Confidence + Activity)
                  , data = trial.dat)

lmm.err.d <- lmer(Err.t ~ Trial + 1 
                  #+ (1 + Trial|Subject) 
                  + (1 + Trial|Dominance)
                  #+ Openness + Friendliness + Dominance + Confidence + Activity)
                  , data = trial.dat)

lmm.err.all <- lmer(Err.t ~ Trial + 1 + 
                      #(1 + Trial| Subject)
                    + (1 + Trial|Friendliness) 
                    + (1 + Trial|Openness)
                    + (1 + Trial|Anxiety)
                    + (1 + Trial|Activity)
                    + (1 + Trial|Confidence)
                    + (1 + Trial|Dominance)                    
                    ,data = trial.dat)


err.AIC <- AICctab(lmm.err.0,lmm.err.f,lmm.err.o,lmm.err.fo,lmm.err.all,
                   lmm.err.c, lmm.err.ac,lmm.err.an,lmm.err.d,
                   #type=c("BIC","AIC","AICc","qAIC","qAICc"),
      logLik=TRUE, delta=TRUE, base=TRUE, dispersion=TRUE)
                    
BICtab(lmm.err.0,lmm.err.f,lmm.err.o,lmm.err.fo,lmm.err.all, #type=c("BIC","AIC","AICc","qAIC","qAICc"),
       logLik=TRUE)

library(lmtest)

lrtest(lmm.err.f)

Dfo_0 = -2*logLik(lmm.err.0, REML = TRUE) + 2*logLik(lmm.err.fo, REML = TRUE)
ddf = 3
chi.fo_0 <- pchisq(Dfo_0, ddf, ncp=0, lower.tail=FALSE, log.p=FALSE)


### BLUP individual parameter tests
BLUP.err = ranef(lmm.err.0,drop=TRUE)

# intercept: P/R
cor.test(unlist(BLUP.err$Subject[1]),mtrim$Friendliness)
cor.test(unlist(BLUP.err$Subject[1]),mtrim$Openness)
cor.test(unlist(BLUP.err$Subject[1]),mtrim$Anxiety)
cor.test(unlist(BLUP.err$Subject[1]),mtrim$Activity)
cor.test(unlist(BLUP.err$Subject[1]),mtrim$Dominance)
cor.test(unlist(BLUP.err$Subject[1]),mtrim$Confidence)

# just P

# slope: 1/R -> transform via 1/beta
cor.test(1/unlist(BLUP.err$Subject[2]),mtrim$Friendliness)
cor.test(1/unlist(BLUP.err$Subject[2]),mtrim$Openness)
cor.test(1/unlist(BLUP.err$Subject[2]),mtrim$Confidence)

