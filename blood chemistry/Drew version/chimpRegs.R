### chimp models

# with mean data... big problem is missing BMI data
mmc.sys <- lm(sys ~ age + dom + extra + cons + agree + neuro + open + sex + BMI,
              data=meandat,na.action = na.exclude)

mmc.chol <- lm(chol ~ age + dom + extra + cons + agree + neuro + open + sex + BMI,
              data=meandat,na.action = na.exclude)

mmc.trig <- lm(trig ~ age + dom + extra + cons + agree + neuro + open + sex + BMI,
              data=meandat,na.action = na.exclude)
# above not worth the attempt


### lmer's, with ML
m1a <- lmer(sys ~ Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion + age + BMI + sex + (1 | chimp), 
            data = scoutput,REML=FALSE)
m1b <- lmer(dias ~ Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion + age + BMI + sex + (1 | chimp), 
            data = scoutput,REML=FALSE)

m2.trig <- lmer(trig ~ Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion + age + BMI + sex + (1 | chimp), 
                data = scoutput,REML=FALSE)

m2.chol <- lmer(chol ~ Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion + age + BMI + sex + (1 | chimp), 
                data = scoutput,REML=FALSE)

m2.creat <- lmer(creatinine ~ Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion + age + BMI + sex + (1 | chimp), 
                 data = scoutput,REML=FALSE)


m2.gluc <- lmer(glucose ~ Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion + age + BMI + sex + (1 | chimp), 
                 data = scoutput,REML=FALSE)


# check convergence issues on this one, BMI unscaled?
m3.BMI <- lmer(BMI ~ Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion + age + sex + (1 | chimp), 
               data = scoutput, REML=FALSE, control=lmerControl(optCtrl=list(maxfun=10000)))

tt <- getME(m3.BMI,"theta")
ll <- getME(m3.BMI,"lower")
min(tt[ll==0])

derivs1 <- m3.BMI@optinfo$derivs
sc_grad1 <- with(derivs1,solve(Hessian,gradient))
max(abs(sc_grad1))

max(pmin(abs(sc_grad1),abs(derivs1$gradient)))

source_https <- function(url, ...) {
  # load package
  require(RCurl)
  
  # parse and evaluate each .R script
  sapply(c(url, ...), function(u) {
    eval(parse(text = getURL(u, followlocation = TRUE, cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"))), envir = .GlobalEnv)
  })
}
#test:
source_https("https://raw.github.com/tonybreyal/Blog-Reference-Functions/master/R/bingSearchXScraper/bingSearchXScraper.R")
             
afurl <- source_https("https://raw.githubusercontent.com/lme4/lme4/master/misc/issues/allFit.R")
#eval(parse(text=getURL(afurl)))
library(optimx,nloptr)
library(dfoptim)
aa <- allFit(m3.BMI)
is.OK <- sapply(aa,is,"merMod")  ## only BFGS OK (is it)
aa.OK <- aa[is.OK]
lapply(aa.OK,function(x) x@optinfo$conv$lme4$messages)
lliks <- sort(sapply(aa.OK,logLik))

# so, optimx BFGS


# summary(aa$optimx.nlminb)
# Anova(aa$optimx.nlminb)

# confint(aa$optimx.nlminb, method='boot'
#         #,newdata=imp_mm$imputations$imp3$BMI
# ) 



### with age^2
m1a.a2 <- lmer(sys ~ Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion + age + BMI + sex + I(age^2) + (1 | chimp), 
            data = scoutput,REML=FALSE)
m1b.a2 <- lmer(dias ~ Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion + age + BMI + sex + I(age^2) + (1 | chimp), 
            data = scoutput,REML=FALSE)

m2.trig.a2 <- lmer(trig ~ Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion + age + BMI + sex + I(age^2) + (1 | chimp), 
                data = scoutput,REML=FALSE)

m2.chol.a2 <- lmer(chol ~ Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion + age + BMI + sex + age2 + (1 | chimp), 
                data = scoutput,REML=FALSE)

m2.creat.a2 <- lmer(creatinine ~ Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion + age + BMI + sex + age2 + (1 | chimp), 
                 data = scoutput,REML=FALSE)

# check convergence issues on this one, BMI unscaled?
library(optimx)
m3.BMI.a2 <- lmer(BMI ~ Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion + age + sex + I(age^2) + (1 | chimp), 
               data = scoutput, REML=FALSE, control=lmerControl(optimizer = "optimx", 
                                                                optCtrl=list(maxfun=1000, 
                                                                             method='nlminb')))
confint(m3.BMI.a2, method='Wald')

tt <- getME(m3.BMI.a2,"theta")
ll <- getME(m3.BMI.a2,"lower")
min(tt[ll==0])

derivs1 <- m3.BMI.a2@optinfo$derivs
sc_grad1 <- with(derivs1,solve(Hessian,gradient))
max(abs(sc_grad1))

max(pmin(abs(sc_grad1),abs(derivs1$gradient)))

aa2 <- allFit(m3.BMI.a2)
is2.OK <- sapply(aa2,is,"merMod")   ## this time around, seems no need to refit
aa2.OK <- aa2[is.OK]
lapply(aa2.OK,function(x) x@optinfo$conv$lme4$messages)
lliks <- sort(sapply(aa2.OK,logLik))



### imputation

testimp = imp_mean$imputations$imp2$BMI
imp.scoutput <- cbind(scoutput, s(testimp))
colnames(imp.scoutput)[38]<-'impBMI'
#imp.scoutput$s(testimp)
### the above isn't necessary for models
### (thanks to Zelig)

library(Amelia)
amel_out <- output[,c(-4,-(15:29),-(31:35))]
imp_out = amelia(amel_out,idvars=c(1,4,17), m=10,p2s=0)

library(Zelig)
zim.BMI3 = zelig(BMI ~ Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion + age + sex + age2, 
                             data = imp_mean$imputations, model="ls")

library(ZeligMultilevel)
zimm3.BMI = zelig(BMI ~ dom + open + agree + cons + neuro + extra
                  + age + sex + age2 + tag(1 | chimp), 
                  data = imp_out$imputations, model="ls.mixed")

imp_save <- imp_mm$imputations$imp7
# this looks like it might not work, mm style

# these are spacious
rm(zim.BMI3,zimm3.BMI)



### some Bayesian mucking about
library(blme)
b.m1a.a2 <- blmer(sys ~ Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion + age + BMI + sex + age2 + (1 | chimp), 
               data = scoutput,REML=FALSE)

library(optimx)
b.m3.BMI.a2 <- blmer(BMI ~ Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion + age + sex + age2 + (1 | chimp), 
                  data = scoutput, REML=FALSE, control=lmerControl(optimizer = "optimx", 
                                                                   optCtrl=list(maxfun=1000, 
                                                                                #method='nlminb'
                                                                                method='L-BFGS-G'
                                                                                )))