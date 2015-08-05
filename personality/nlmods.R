# non-linear models of performance

library (dplyr)

trial.dat<-left_join(trial.dat, mtrim, by='Subject')
trial.dat$Subject = as.factor(trial.dat$Subject)

# log modulus transformation
trial.dat$Err.t <- log(abs(trial.dat$Error)+1) * sign(trial.dat$Error)
# inverse modulus transform
trial.dat$Err.t <- 1/(abs(trial.dat$Error)+1) * sign(trial.dat$Error)
# this seem to be the best, but needs refelction
# ... and reflection fucks it all up
trial.dat$Err.t.r <- 1/(abs(trial.dat$Error)*-1+3) * sign(trial.dat$Error)

library(car)
library(MASS)
# Yeo-Johnson transformations. Seem less good.
# ... but I don't think there is a robust alternative
yj.lambda = with(data=trial.dat,boxcox(Error[Error>0] ~ Trial[Error>0], plotit=TRUE,eps=0.01,
                                       lambda=seq(-2,2,0.0001)))
yj.lambda = with(data=trial.dat,boxcox(abs(Error)+1 ~ Trial, plotit=TRUE,eps=0.01,
                                       lambda=seq(-2,2,0.001)))
trial.dat$Err.yj <- yjPower(trial.dat$Error, #-1.887,
                            -0.146,
                            jacobian.adjusted = TRUE)

gg.e.yj <- ggplot(trial.dat, aes(Trial,Err.yj))+geom_point()+
  facet_wrap(~Subject) + stat_summary(fun.data="mean_cl_boot",colour='purple')
gg.e.yj + coord_cartesian(ylim = c(-3, 3)) 


library(ggplot2)
gg.e <- ggplot(trial.dat, aes(Trial,Error))+geom_point()+
  facet_wrap(~Subject)

gg.e + stat_summary(fun.data="mean_cl_boot",colour='red') #+ stat_smooth(method='glm') # this isn't very good

gg.e <- ggplot(trial.dat, aes(Trial,Err.t.r))+geom_point()+
  facet_wrap(~Subject) + stat_summary(fun.data="mean_cl_boot",colour='purple')
gg.e


# this is used in ASP2015 presentation
gg.p <- ggplot(trial.dat, aes(Trial,Progress))+geom_point()+
  facet_wrap(~Subject) + theme_bw()

gg.p + stat_summary(fun.data="mean_cl_boot",colour='blue')


gg.p.tr <-  ggplot(trial.dat, aes(Trial,Prog.t))+geom_point()+
  facet_wrap(~Subject)
gg.p.tr + stat_summary(fun.data="mean_cl_boot",colour='green') + stat_smooth(method='lm')

 ### PROGRESS

library(lme4)
library(car)

# y = L(x + P) /
#     x + P + R
L = 4 #4.1

## back to nlme's
library(nlme)

initVals <- getInitial(Progress ~ SSlogis(Trial, Asym, xmid, scal), data = trial.dat)
nlm.0 <- nlme(Progress ~ SSlogis(Trial, Asym, xmid, scal),
                 data = trial.dat,
                 fixed = list(Asym ~ 1, xmid ~ 1, scal ~ 1),
                 random = Asym + xmid ~ 1|Subject,
                 start = initVals)
# Scal seems like it should be a constant. What does it really mean? 
# Should it have a random effect but no personality impact?


# setting up df for random effects (nested) via nlme
nlm.dat = groupedData(Progress ~ Trial | Subject, data=trial.dat , order.groups=0)

nlm.date = groupedData(Progress ~ Trial | Subject/Date, data=trial.dat , order.groups=c(0,0))

#nlm.dat$ran = runif(length(nlm.dat$Subject))

nlm.0 <- nlme(Progress ~ SSlogis(Trial, Asym, xmid, scal),
              data = nlm.dat,
              fixed = list(Asym ~ 1, xmid ~ 1, scal ~ 1),
              random = Asym + xmid ~ 1|Subject,
              #groups = ~ Subject
              #start = initVals
)

# now trying to nest trials within subject
## this is the null model for pub
nlm.0rs <- nlme(Progress ~ SSlogis(Trial, Asym, xmid, scal),
              data = nlm.dat,
              fixed = list(Asym ~ 1, xmid ~ 1, scal ~ 1),
              random = Asym + xmid + scal ~ 1|Subject
              #, groups = ~ Subject/Date,
              #start = initVals
              #verbose=TRUE
)

control = nlmeControl(pnlsTol = 0.001, msVerbose = FALSE, opt='nlminb')
nlm.0.o <- update(nlm.0, fixed=list(Asym ~ Openness, xmid ~ Openness, scal ~ 1)
                #, start = c(fixef(nlm.0),fixef(nlm.0),fixef(nlm.0)))
                , start = c(Asym = fixef(nlm.0)[1],xmid = fixef(nlm.0)[2], scal = fixef(nlm.0)[3],
                            Openness=c(1,1)))

nlm.0.f <- update(nlm.0, fixed=list(Asym ~ Friendliness, xmid ~ Friendliness, scal ~ 1)
                  #, start = c(fixef(nlm.0),fixef(nlm.0),fixef(nlm.0)))
                  , start = c(Asym = fixef(nlm.0)[1],xmid = fixef(nlm.0)[2], scal = fixef(nlm.0)[3],1,1))

nlm.0.fo<- update(nlm.0, fixed=list(Asym ~ Friendliness + Openness, xmid ~ Friendliness + Openness, scal ~ 1)
                  #, start = c(fixef(nlm.0),fixef(nlm.0),fixef(nlm.0)))
                  , start = c(Asym = fixef(nlm.0)[1],xmid = fixef(nlm.0)[2], scal = fixef(nlm.0)[3],
                              #fixef(nlm.0.f)[2],fixef(nlm.0.o)[2],fixef(nlm.0.f)[4],fixef(nlm.0.o)[4]))
                              1,1,1,1))
 
## similarly, the rs models are for pub
nlm.0rs.o <- update(nlm.0rs, fixed=list(Asym ~ Openness, xmid ~ Openness, scal ~ 1)
                  #, start = c(fixef(nlm.0),fixef(nlm.0),fixef(nlm.0)))
                  , start = c(Asym = fixef(nlm.0)[1],xmid = fixef(nlm.0)[2], scal = fixef(nlm.0)[3],
                              Openness=c(0.5,0.5)))

nlm.0rs.f <- update(nlm.0rs, fixed=list(Asym ~ Friendliness, xmid ~ Friendliness, scal ~ 1)
                  #, start = c(fixef(nlm.0),fixef(nlm.0),fixef(nlm.0)))
                  , start = c(Asym = fixef(nlm.0)[1],xmid = fixef(nlm.0)[2], scal = fixef(nlm.0)[3],0.5,0.5))

nlm.0rs.c <- update(nlm.0rs, fixed=list(Asym ~ Confidence, xmid ~ Confidence, scal ~ 1)
                    #, start = c(fixef(nlm.0),fixef(nlm.0),fixef(nlm.0)))
                    , start = c(Asym = fixef(nlm.0rs)[1],xmid = fixef(nlm.0rs)[2], scal = fixef(nlm.0rs)[3],0.5,0.5))

# new - a is for activity
nlm.0rs.a <- update(nlm.0rs, fixed=list(Asym ~ Activity, xmid ~ Activity, scal ~ 1)
                    #, start = c(fixef(nlm.0),fixef(nlm.0),fixef(nlm.0)))
                    , start = c(Asym = fixef(nlm.0)[1],xmid = fixef(nlm.0)[2], scal = fixef(nlm.0)[3],
                                c(0.5,0.5)))
# fuck it

control = nlmeControl(pnlsTol = 0.02, msVerbose = TRUE)
nlm.0rs.fo<- update(nlm.0rs, fixed=list(Asym ~ Friendliness + Openness, xmid ~ Friendliness + Openness, scal ~ 1)
                  #, start = c(fixef(nlm.0),fixef(nlm.0),fixef(nlm.0)))
                  , start = c(Asym = fixef(nlm.0)[1],xmid = fixef(nlm.0)[2], scal = fixef(nlm.0)[3],
                            #  fixef(nlm.0.f)[2],fixef(nlm.0.o)[2],fixef(nlm.0.f)[4],fixef(nlm.0.o)[4]))
                              0.5,0.5,0.5,0.5))

nlm.0rs.foc<- update(nlm.0rs, fixed=list(Asym ~ Friendliness + Openness + Confidence, 
                                        xmid ~ Friendliness + Openness + Confidence, scal ~ 1)
                    #, start = c(fixef(nlm.0),fixef(nlm.0),fixef(nlm.0)))
                    , start = c(Asym = fixef(nlm.0)[1],xmid = fixef(nlm.0)[2], scal = fixef(nlm.0)[3],
                                #  fixef(nlm.0.f)[2],fixef(nlm.0.o)[2],fixef(nlm.0.f)[4],fixef(nlm.0.o)[4]))
                                0.5,0.5,0.5,0.5,0.5,0.5))

library(bbmle)
temp <- AICctab(nlm.0rs,nlm.0rs.o,nlm.0rs.f,nlm.0rs.c,nlm.0rs.fo,nlm.0rs.foc,
        logLik=TRUE, delta=TRUE, base=TRUE, dispersion=TRUE)
write.csv(cbind(rownames(temp),temp$df,temp$logLik,temp$AICc), "clipboard.csv", sep=,)
temp <- BICtab(nlm.0rs,nlm.0rs.o,nlm.0rs.f,nlm.0rs.c,nlm.0rs.fo,nlm.0rs.foc,base=TRUE)
write.csv(cbind(rownames(temp),temp$df,temp$BIC), "clipboard.csv")

AICtab(nlm.0rs,nlm.0rs.o,nlm.0rs.f,nlm.0rs.c,nlm.0rs.fo,nlm.0rs.foc,base=TRUE)

anova(nlm.0rs,nlm.0rs.o,nlm.0rs.f,nlm.0rs.c,nlm.0rs.fo,nlm.0rs.foc)


# fit plots

library(ggplot2)
gg.p <- ggplot(trial.dat, aes(Trial,Progress))+stat_summary(fun.data="mean_cl_boot",colour='green')
  
gg.p + facet_wrap(~Subject)

yPred=coef(nlm.0)

# scal
par(mfrow=c(2,2))

plot(nlm.dat$Trial, nlm.dat$Progress)

yPred = coef(nlm.0)
ypred 
plot(nlm.dat$Trial, 
      yPred[1]/(1 + exp((yPred[2]-nlm.dat$Trial)/(yPred[3])))
)
plot(nlm.dat$Trial, 
     yPred[1]/(1 + exp((yPred[2]-nlm.dat$Trial)/(2*yPred[3])))
)
plot(nlm.dat$Trial, 
     yPred[1]/(1 + exp((yPred[2]-nlm.dat$Trial)/(1/2*yPred[3])))
)

#xmid
par(mfrow=c(2,2))

plot(nlm.dat$Trial, nlm.dat$Progress)

yPred = fixef(nlm.0)
plot(nlm.dat$Trial, 
     yPred[1]/(1 + exp((yPred[2]-nlm.dat$Trial)/(yPred[3])))
)
plot(nlm.dat$Trial, 
     yPred[1]/(1 + exp((2*yPred[2]-nlm.dat$Trial)/(yPred[3])))
)
plot(nlm.dat$Trial, 
     yPred[1]/(1 + exp((1/2*yPred[2]-nlm.dat$Trial)/(yPred[3])))
)

      

fixef(nlm.0)
# this doesn't really work

# Correlation tests with ranef's

ran.prog = ranef(nlm.0rs,drop=TRUE)

# with Asymptote
cor.test(unlist(ran.prog[1]),mtrim$Friendliness)
cor.test(unlist(ran.prog[1]),mtrim$Openness)
cor.test(unlist(ran.prog[1]),mtrim$Anxiety)
cor.test(unlist(ran.prog[1]),mtrim$Activity)
cor.test(unlist(ran.prog[1]),mtrim$Dominance)
cor.test(unlist(ran.prog[1]),mtrim$Confidence)

# with xmid (slope rise)
cor.test(unlist(ran.prog[2]),mtrim$Friendliness)
cor.test(unlist(ran.prog[2]),mtrim$Openness)
cor.test(unlist(ran.prog[2]),mtrim$Confidence)


##

thurstone <- function(x, L, P, R) (L*(x + P)/(x + P + R))

thurstone <- deriv(~(4*(x + P)/(x + P + R)),
                    c('P','R'), function(x, P, R){})

thrs.nlm.0 <- nlme(Progress ~ thurstone(Trial, P, R),
              data=nlm.dat,
              fixed=list(P ~ 1, R ~ 1),
              random = R + R ~ 1|Subject
              , start = c(0.1,0.1)
)


nlm.o <- nlme(Progress ~ thurstone(Trial, P, R),
              data=nlm.dat,
              fixed=list(P ~ 1 + Openness, R ~ 1 + Openness),
              random = R + R ~ 1|Subject
              , start = c(0.01,0.01,0.01,0.01)
)

nlm.f <- nlme(Progress ~ thurstone(Trial, P, R),
              data=nlm.dat,
              fixed=list(P ~ 1 + Friendliness, R ~ 1 + Friendliness),
              random = P + R ~ 1|Subject
              , start = c(0.01,0.01,0.01,0.01)
)

nlm.fo <- nlme(Progress ~ thurstone(Trial, P, R),
              data=nlm.dat,
              fixed=list(P ~ 1 + Friendliness + Openness, R ~ 1 + Friendliness + Openness),
              random = P + R ~ 1|Subject
              , start = c(0.01,0.01,0.01,0.01,0.01,0.01)
)


# (L / y - 1)^-1 = x/R + P/R  

trial.dat$Prog.t = ((L / trial.dat$Progress) - 1 )^-1

trial.dat$Prog.t = exp(trial.dat$Progress)


# linear(ly transformed) models

#null models
lmm.Prog.00 <- lmer(Prog.t ~ (1 | Subject ), data=trial.dat)
lmm.Prog.0 <- lmer(Prog.t ~ Trial + 1 + (1 + Trial| Subject), data = trial.dat)

lmm.Prog.o.main <- lmer(Prog.t ~ Trial + 1 + Trial + Openness + (1 + Trial| Subject), data = trial.dat)
lmm.Prog.o.mainint <- lmer(Prog.t ~ Trial + 1*Openness + Trial*Openness + (1 + Trial| Subject), data = trial.dat)
lmm.Prog.o.int <- lmer(Prog.t ~ Trial + 1 + Trial:Openness + (1 + Trial| Subject), data = trial.dat)
# main+interaction is best

lmm.Prog.f.main <- lmer(Prog.t ~ Trial + 1 + Trial + Friendliness + (1 + Trial| Subject), data = trial.dat)
lmm.Prog.f.mainint <- lmer(Prog.t ~ Trial + 1 + Trial * Friendliness + (1 + Trial| Subject), data = trial.dat)
anova(lmm.Prog.00,lmm.Prog.0,lmm.Prog.f.main,lmm.Prog.f.mainint)

lmm.Prog.fo.all <-lmer(Prog.t ~ 1 + Trial + Openness + Friendliness + Openness:Trial + Friendliness:Trial + (1 + Trial| Subject), data = trial.dat )

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


lmm.Prog.all.mainint <- lmer(Prog.t ~ 1 + Trial + Openness + Friendliness + 
                               Dominance + Confidence + Anxiety + Activity +
                               Openness:Trial + Friendliness:Trial + 
                               Dominance:Trial + Confidence:Trial + 
                               Anxiety:Trial + Activity:Trial +
                               (1 + Trial| Subject), data = trial.dat )



##

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

# using General Additive Models

library(mgcv)
library(gamm4)
library(bbmle)

gam.err.0 <- gamm4(Error ~ 1 + Trial,
                  data = trial.dat,
                  random= ~ (1+Trial | Subject/Date)
)


# testing for which is best
# gam.err.0s.tp10 <- gamm4(Error ~ 1 + s(Trial,k=10),
#                    data = trial.dat,
#                    random= ~ (1+Trial | Subject/Date)
# )
# gam.err.0s.cr10 
gam.err.0s <- gamm4(Error ~ 1 + s(Trial,bs='cr',k=5),
                    data = trial.dat,
                    random= ~ (1+Trial | Subject/Date)
)
# gam.err.0s.cr20 <- gamm4(Error ~ 1 + s(Trial,bs='cr',k=20),
#                     data = trial.dat,
#                     random= ~ (1+Trial | Subject/Date)
# )




gam.err.pers.f <- gamm4(Error ~ 1 + s(Trial,bs='cr',k=5) + 
                           s(Friendliness,bs='cr',k=5) +
                           t2(Trial,Friendliness,bs='cr',k=5),
                         data = trial.dat,
                         random= ~ (1+Trial | Subject/Date)
)

gam.err.pers.o <- gamm4(Error ~ 1 + s(Trial,bs='cr',k=5) + 
                          s(Openness,bs='cr',k=5) +
                          t2(Trial,Openness,bs='cr',k=5),
                        data = trial.dat,
                        random= ~ (1+Trial | Subject/Date)
)



gam.err.pers.fo <- gamm4(Error ~ 1 + s(Trial,bs='cr',k=5) + 
                            t2(Trial,Friendliness,bs='cr',k=5) +
                            t2(Trial,Openness,bs='cr',k=5),
                          data = trial.dat,
                          random= ~ (1+Trial | Subject/Date)
)

gam.err.pers.fo.int <- gamm4(Error ~ 1 + s(Trial,bs='cr',k=5) + 
                               s(Openness,bs='cr',k=5) + s(Friendliness,bs='cr',k=5) +
                           t2(Trial,Friendliness,bs='cr',k=5) +
                           t2(Trial,Openness,bs='cr',k=5),
                         data = trial.dat,
                         random= ~ (1+Trial | Subject/Date)
)


gam.err.pers.foc <- gamm4(Error ~ 1 + s(Trial,bs='cr',k=5) + 
                            t2(Trial,Friendliness,bs='cr',k=5) +
                            t2(Trial,Openness,bs='cr',k=5) + 
                            t2(Trial,Confidence,bs='cr',k=5),
                            data = trial.dat,
                            random= ~ (1+Trial | Subject/Date)
)


gam.err.pers.fxo.0 <- gamm4(Error ~ 1 + s(Trial,bs='cr',k=10) +
                      #t2(Trial,Friendliness) +
                      t2(Trial,Openness,Friendliness,bs='cr',k=5),
                    data = trial.dat,
                    random= ~ (1+Trial | Subject/Date)
)

gam.err.pers.fxo <- gamm4(Error ~ 1 + s(Trial,bs='cr',k=10) +
                              t2(Trial,Friendliness) +
                              t2(Trial,Openness,Friendliness,bs='cr',k=5),
                            data = trial.dat,
                            random= ~ (1+Trial | Subject/Date)
)



#trial.dat$Err.t = ((L / trial.dat$Error) - 1 )^-1
# the above transform makes regular OLS not a great approach
# one alternative is Weighted LS, but ML is still good, and REML probably best


# this one we can try with a quadratic fit
library(coefplot)

lmm.q.err.0 <- lmer(Error ~ I(Trial^2) + Trial + 1 + (1 + Trial + I(Trial^2)| Subject), data = trial.dat, REML=FALSE)
# Yes, I think we want the slope in there (above)
#lmm.q.err.01 <- lmer(Error ~ I(Trial^2) + 1 + (1 + I(Trial^2)| Subject), data = trial.dat)
lmm.q.err.o <- lmer(Error ~ I(Trial^2) + Trial + 1 + 
                      I(Trial^2):Openness + 
                      (1 + Trial + I(Trial^2)| Subject/Date), data = trial.dat, REML=FALSE)

lmm.q.err.o2 <- lmer(Error ~ I(Trial^2) + Trial + 1 + 
                      I(Trial^2):Openness + Openness +
                      (1 + Trial + I(Trial^2)| Subject/Date), data = trial.dat, REML=FALSE)

lmm.q.err.f <- lmer(Error ~ I(Trial^2) + Trial + 1 + 
                      I(Trial^2):Friendliness + Friendliness +
                      (1 + Trial + I(Trial^2)| Subject), data = trial.dat, REML=FALSE)


trial.dat$err.pred = predict(lmm.q.err.0, newdata=trial.dat$Trial)

plotLMER.fnc(lmm.q.err.0)

coefplot(lmm.err.0)


## Error models for pub

# null model
lmm.err.0 <- lmer(Err.yj ~ Trial + 1 + (1 + Trial| Subject/Date), data = trial.dat, REML=FALSE)

lmm.err.0.rtr <- lmer(Err.yj ~ 1 + (1 | Subject:Date) + (1 | Subject:Trial) + (1 | Subject), data = trial.dat, REML=FALSE)
# model .0 is better




lmm.err.o <- lmer(Err.yj ~ Trial + 1 + Openness
                  #  + (1 + Trial|Subject) 
                    + (1 + Trial|Subject/Date)
                    #+ Openness + Friendliness + Dominance + Confidence + Activity)
                         , data = trial.dat, REML=FALSE)

lmm.err.oB <- lmer(Err.yj ~ Trial + 1 + Openness:Trial
                  #  + (1 + Trial|Subject) 
                  + (1 + Trial|Subject/Date)
                  #+ Openness + Friendliness + Dominance + Confidence + Activity)
                  , data = trial.dat, REML=FALSE)


lmm.err.f <- lmer(Err.yj ~ Trial + 1 + Friendliness
                  #  + (1 + Trial|Subject) 
                  + (1 + Trial|Subject/Date)
                  #+ Openness + Friendliness + Dominance + Confidence + Activity)
                  , data = trial.dat, REML=FALSE)

lmm.err.fB <- lmer(Err.yj ~ Trial + 1 + Friendliness:Trial
                  #  + (1 + Trial|Subject) 
                  + (1 + Trial|Subject/Date)
                  #+ Openness + Friendliness + Dominance + Confidence + Activity)
                  , data = trial.dat, REML=FALSE)

anova(lmm.err.f,lmm.err.o,lmm.err.fB,lmm.err.oB)

lmm.err.fBc <- lmer(Err.yj ~ Trial + 1 + Friendliness:Trial + Friendliness
                   #  + (1 + Trial|Subject) 
                   + (1 + Trial|Subject/Date)
                   #+ Openness + Friendliness + Dominance + Confidence + Activity)
                   , data = trial.dat, REML=FALSE)

anova(lmm.err.f,lmm.err.o,lmm.err.fB,lmm.err.fBc)

# this is the best model
lmm.err.fB.oc <- lmer(Err.yj ~ Trial + 1 + Friendliness:Trial + Openness
                      #  + (1 + Trial|Subject) 
                       + (1 + Trial|Subject/Date)
                      #+ Openness + Friendliness + Dominance + Confidence + Activity)
                      , data = trial.dat, REML=FALSE)

lmm.err.fBc.oc <- lmer(Err.yj ~ Trial + 1 + Friendliness:Trial + Friendliness + Openness
                       #  + (1 + Trial|Subject) 
                       + (1 + Trial|Subject/Date)
                       #+ Openness + Friendliness + Dominance + Confidence + Activity)
                       , data = trial.dat, REML=FALSE)

anova(lmm.err.0,lmm.err.f,lmm.err.o,lmm.err.fB,lmm.err.fBc,lmm.err.fB.oc,lmm.err.fBc.oc)

temp <- AICctab(lmm.err.0,lmm.err.f,lmm.err.o,lmm.err.oB,lmm.err.fB,
                lmm.err.fBc,lmm.err.fB.oc,lmm.err.fBc.oc,
                    logLik=TRUE, delta=TRUE, base=TRUE, dispersion=TRUE)
write.csv(cbind(rownames(temp),temp$df,temp$AICc,temp$logLik), "clipboard.csv")
temp<-BICtab(lmm.err.0,lmm.err.f,lmm.err.o,lmm.err.oB,lmm.err.fB,
             lmm.err.fBc,lmm.err.fB.oc,lmm.err.fBc.oc, base=T)
write.csv(cbind(rownames(temp),temp$df,temp$BIC), "clipboard.csv")

Anova(lmm.err.fB.oc)
Anova(lmm.err.fBc.oc)

### BLUP individual parameter tests
BLUP.err = ranef(lmm.err.0,drop=TRUE)

# the below appears to have become useless  

# intercept
cor.test(unlist(BLUP.err$Subject[1]),mtrim$Friendliness)
cor.test(unlist(BLUP.err$Subject[1]),mtrim$Openness)
cor.test(unlist(BLUP.err$Subject[1]),mtrim$Anxiety)
cor.test(unlist(BLUP.err$Subject[1]),mtrim$Activity)
cor.test(unlist(BLUP.err$Subject[1]),mtrim$Dominance)
cor.test(unlist(BLUP.err$Subject[1]),mtrim$Confidence)

# slope
cor.test(1/unlist(BLUP.err$Subject[2]),mtrim$Friendliness)
cor.test(1/unlist(BLUP.err$Subject[2]),mtrim$Openness)
cor.test(1/unlist(BLUP.err$Subject[2]),mtrim$Confidence)



### REWARD RATE

library(lme4)

glm.rrtr <- glmer(Correct ~ 1 + Trial + Anxiety + Activity + Dominance + Confidence + Openness + Friendliness
                + (1 + Trial|Subject:Date) + (0 + Trial | Subject),
                data=trial.dat,
                family=binomial(link='logit'))

glm.rrntr <- glmer(Correct ~ 1 + Trial + Anxiety + Activity + Dominance + Confidence + Openness + Friendliness
                  + (1 | Subject:Date),
                  data=trial.dat,
                  family=binomial(link='logit'))

glm.rDinSntr <- glmer(Correct ~ 1 + Trial + Anxiety + Activity + Dominance + Confidence + Openness + Friendliness
                   + (1 | Subject/Date),
                   data=trial.dat,
                   family=binomial(link='logit'))

# model below is probably not meaningful
glm.rr <- glmer(Correct ~ 1 + Anxiety + Activity + Dominance + Confidence + Openness + Friendliness
                + (1 | Subject:Date) + (1 | Subject:Trial), #+ (1 | Subject),
                data=trial.dat,
                family=binomial(link='logit'))

# indicate that Subject effect on Intercept is degenerate


#library(MCMCglmm)



### REACTION TIME
### for both all and only correct responses

library(lme4)

RT.dat = dataIn[(
    (dataIn$CorrectItem=='A')),c(1:11)]

RT.dat1 = dataIn[((dataIn$PressAccuracy=='1')&(dataIn$CorrectItem=='A')),c(1:11)]


RT.dat$Subject = as.factor(RT.dat$Sub)
RT.dat1$Subject = as.factor(RT.dat1$Sub)

RT.dat <-left_join(RT.dat, mtrim, by='Subject')

RT.dat <-RT.dat[!outliers(RT.dat$RT,3.5),]


RT.dat1 <-left_join(RT.dat1, mtrim, by='Subject')

RT.dat1 <-RT.dat1[!outliers(RT.dat1$RT,3.5),]


# regrss
#library(blme) # noooo...
library(lmer)

lmm.rt.0 <- lmer(log(RT) ~ Trial + 1 + (1 + Trial| Subject/Date)# + (1 + Trial| Date)
                 , data = RT.dat, REML=FALSE)
# not worth the bother of modeling, the correlations are crap (??)

lmm.rt.1 <- lmer(log(RT) ~ Confidence + Openness + Friendliness + Dominance +
                 Anxiety + Activity + 1 + (1 + Trial| Subject) #+ (1 + Trial| Date)
                 , data = RT.dat, REML=FALSE)

lmm.rt.1tr <- lmer(log(RT) ~ Trial + Confidence + Openness + Friendliness + Dominance +
                   Anxiety + Activity + 1 + (1 + Trial| Subject)# + (1 + Trial| Date)
                 , data = RT.dat, REML=FALSE)

lmm.rt1.1 <- lmer(log(RT) ~ Confidence + Openness + Friendliness + Dominance +
                    Anxiety + Activity + 1 + (1 + Trial| Subject)# + (1 + Trial| Date)
                  , data = RT.dat1, REML=FALSE)

lmm.rt1.1tr <- lmer(log(RT) ~ Trial + Confidence + Openness + Friendliness + Dominance +
                     Anxiety + Activity + 1 + (1 + Trial| Subject)# + (1 + Trial| Date)
                   , data = RT.dat1, REML=FALSE)



head(RT.dat$RT[RT.dat$Subject=='Prospero'],30)



### acces. func.

outliers <- function(obs, x = 3)
  abs(obs - mean(obs, na.rm = T)) > (sd(obs, na.rm = T) * x)



##### Cleanup

.ls.objects <- function (pos = 1, pattern, order.by,
                         decreasing=FALSE, head=FALSE, n=5) {
  napply <- function(names, fn) sapply(names, function(x)
    fn(get(x, pos = pos)))
  names <- ls(pos = pos, pattern = pattern)
  obj.class <- napply(names, function(x) as.character(class(x))[1])
  obj.mode <- napply(names, mode)
  obj.type <- ifelse(is.na(obj.class), obj.mode, obj.class)
  obj.size <- napply(names, object.size)
  obj.dim <- t(napply(names, function(x)
    as.numeric(dim(x))[1:2]))
  vec <- is.na(obj.dim)[, 1] & (obj.type != "function")
  obj.dim[vec, 1] <- napply(names, length)[vec]
  out <- data.frame(obj.type, obj.size, obj.dim)
  names(out) <- c("Type", "Size", "Rows", "Columns")
  if (!missing(order.by))
    out <- out[order(out[[order.by]], decreasing=decreasing), ]
  if (head)
    out <- head(out, n)
  out
}
# shorthand
lsos <- function(..., n=10) {
  .ls.objects(..., order.by="Size", decreasing=TRUE, head=TRUE, n=n)
}


### Old stuff


lmm.err.fo <- lmer(Err.t ~ Trial + 1 
                   + Friendliness + Friendliness:Trial
                   + Openness + Openness:Trial
                   + (1 + Trial|Subject/Date)
                   #+ (1 + Trial|Subject)                   
                   #+ (1 + Trial|Friendliness) 
                   #+ (1 + Trial|Openness)
                   #+ Openness + Friendliness + Dominance + Confidence + Activity)
                   , data = trial.dat, REML=FALSE)

anova(lmm.err.0,lmm.err.fo,lmm.err.f,lmm.err.fB,lmm.err.o,lmm.err.oB)
# is f on B and o on c the meaningful interactions?

lmm.err.Bf <- lmer(Err.t ~ Trial + 1 
                   + Friendliness:Trial
                   + (1 + Trial|Subject/Date)
                   , data = trial.dat, REML=FALSE)

lmm.err.Co <- lmer(Err.t ~ Trial + 1 
                   + Openness
                   + (1 + Trial|Subject/Date)
                   , data = trial.dat, REML=FALSE)


lmm.err.BfCo <- lmer(Err.t ~ Trial + 1 
                     + Friendliness:Trial + Openness
                     + (1 + Trial|Subject/Date)
                     , data = trial.dat, REML=FALSE)

lmm.err.Bf_o <- lmer(Err.t ~ Trial + 1 
                     + Friendliness:Trial + Openness + Openness:Trial
                     + (1 + Trial|Subject/Date)
                     , data = trial.dat, REML=FALSE)

anova(lmm.err.0,lmm.err.fo,lmm.err.f,lmm.err.fB,lmm.err.o,lmm.err.oB, lmm.err.Bf,lmm.err.Co,lmm.err.BfCo, lmm.err.Bf_o)
anova(lmm.err.0,lmm.err.f,lmm.err.fB,lmm.err.o, lmm.err.Bf,lmm.err.BfCo, lmm.err.Bf_o)


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


