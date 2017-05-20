### chimp models

library(lme4)
library(MuMIn)
library(glmnet)
library(bbmle)



# should I rejigger data for this purpose, to be more like the SEM data?[???]



scoutput$AL = rowMeans(cbind(scoutput$sys,scoutput$dias,scoutput$chol,scoutput$trig,scoutput$BMI), na.rm = T)


smeandat$AL = rowMeans(cbind(s(smeandat$sys),s(smeandat$dias),
               s(smeandat$chol),s(smeandat$trig),
               s(smeandat$BMI)), na.rm = T)
mcAL.1.simplm <- lm(AL ~ Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion
                    + s(age) + s(age2) + sex, 
                    #data = all3[all3$sample=='YNPRC',]
                    data = smeandat
)
summary(mcAL.1.simplm)

mcAL.1.simpl.m <- lm(AL ~ Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion
                    + s(age) + s(age2),
                    data = smeandat[smeandat$sex==1,]
)
mcAL.1.simpl.f <- lm(AL ~ Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion
                     + s(age) + s(age2),
                     data = smeandat[smeandat$sex==2,]
)
summary(mcAL.1.simpl.m)
summary(mcAL.1.simpl.f)


mcAL.1 <- lmer(AL ~ Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion
               + age + age2 + sex + (1 | chimp), 
               data = scoutput,REML=FALSE)
summary(mcAL.1)
confint(mcAL.1, method="profile")
r.squaredGLMM(mcAL.1)


mcAL.1.f <- lmer(AL ~ Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion
               + age + age2 + (1 | chimp), 
               data = scoutput[scoutput$sex==2,],REML=FALSE)
mcAL.1.m <- lmer(AL ~ Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion
                 + age + age2 + (1 | chimp), 
                 data = scoutput[scoutput$sex==1,],REML=FALSE)
summary(mcAL.1.m)
summary(mcAL.1.f)


mcAL.2 <- lmer(AL ~ Dominance + Openness + Agreeableness * Conscientiousness + Neuroticism + Extraversion
                 + age + age2 + sex + (1 | chimp), 
                 data = scoutput,REML=FALSE)



fullcast$AL = rowMeans(cbind(s(fullcast$systolic),s(fullcast$diastolic),
                             s(fullcast$cholesterol),s(fullcast$triglycerides),
                             s(fullcast$BMI)), na.rm = T)
mcAL.3 <- lmer(AL ~ chimp_Dom_CZ + chimp_Ext_CZ + chimp_Con_CZ + chimp_Agr_CZ + chimp_Neu_CZ + chimp_Opn_CZ
                         + sex + age + age2 +
                 (1 | chimp)
                # (1 + chimp_Opn_CZ | chimp)
                  #+ sex + chimp_Dom_CZ + chimp_Con_CZ | chimp) 
#                  (1 + chimp_Dom_CZ + chimp_Ext_CZ + chimp_Con_CZ + chimp_Agr_CZ +  chimp_Neu_CZ | chimp)
                      #                        chimp_Opn_CZ | chimp)
               
               , 
                         data = fullcast[!is.nan(fullcast$AL),],REML=FALSE)
summary(mcAL.3)
confint(mcAL.3,method='boot')  
  


mcAL.3.m <- lmer(AL ~ chimp_Dom_CZ + chimp_Ext_CZ + chimp_Con_CZ + chimp_Agr_CZ + chimp_Neu_CZ + chimp_Opn_CZ
               + age + age2 + 
               #  (1 | chimp) 
                (1 + chimp_Dom_CZ | chimp)
               , data = fullcast[!is.nan(fullcast$AL)&(fullcast$sex==1),],REML=FALSE,
               control = lmerControl(optimizer = 'Nelder_Mead')
                 )
summary(mcAL.3.m)
confint(mcAL.3.m, method='Wald')

mcAL.3.f <- lmer(AL ~ chimp_Dom_CZ + chimp_Ext_CZ + chimp_Con_CZ + chimp_Agr_CZ + chimp_Neu_CZ + chimp_Opn_CZ
                 + age + age2 + 
                  # (1 | chimp) 
                  (1 + chimp_Dom_CZ | chimp)
                 , data = fullcast[!is.nan(fullcast$AL)&(fullcast$sex==0),],REML=FALSE)
summary(mcAL.3.f)


  


AICctab(mcAL.1, mcAL.2,
        weights=T, delta=T,base=T,logLik=T,sort=T
        )



### Item by item
#scoutput$AL = scoutput$sys + scoutput$dias + scoutput$chol + scoutput$trig + scoutput$BMI

mcALallItems.1 <- lmer(AL ~ Depressed + Fearful + Persistent + Cautious + Stable + Autistic + Stingy  
                       + Jealous + Reckless + Sociable + Timid + Sympathetic + Playful 
                       + Solitary + Active + Helpful + Bullying + Aggressive + Manipiulative
                       + Gentle + Affectionate + Excitable + Impulsive + Inquisitve + Submissive
                       + Dependent + Irritible + Predictable + Decisive + Independent + Sensitive
                       + Defiant + Intelligent + Protective + Inventive + Clumsy + Erratic + Friendly
                       + Lazy + Disorganized + Unemotional + Imitative + Dominant
               + age + I(age^2) + sex + (1 | chimp), 
               data = scoutput,REML=FALSE)
summary(mcALallItems.1)
confint(mcALallItems.1, method="profile")
r.squaredGLMM(mcALallItems.1)



netformC = as.matrix(as.data.frame(lapply(scoutput[complete.cases(scoutput),], as.numeric)))

alif = 0.1

net.C.AL = glmnet(netformC[,c(2,5,12:54)], netformC[,c(81)],
                  family='gaussian',standardize=T,
                  nlambda=1000, alpha = alif)
cvnet.C.AL = cv.glmnet(netformC[,c(2,5,12:54)], netformC[,c(81)],family='gaussian',nfolds=100,alpha=alif)
plot(cvnet.C.AL)

coef(net.C.AL,s=cvnet.C.AL$lambda.1se)



head(all3[all3$sample=='YNPRC',])

netformC.1 = as.matrix(as.data.frame(lapply(all3[complete.cases(all3)&(all3$sample=='YNPRC'),], as.numeric)))
netformC.2 = as.matrix(as.data.frame(lapply(all3[complete.cases(all3$AL)&(all3$sample=='YNPRC'),], as.numeric)))
# fucking Tara. Fix her eventually...###
netformC.2 = netformC.2[-149,]

smeandat$AL = rowMeans(cbind(smeandat$sys,smeandat$dias,smeandat$chol,smeandat$trig,smeandat$BMI),na.rm=T)
netformC.3 = as.matrix(as.data.frame(lapply(smeandat[complete.cases(smeandat$AL),],as.numeric)))
netformC.3 = netformC.3[-149,]



net.C.AL = glmnet(netformC.3[,c(2:4,23:65)], netformC.3[,c(66)],
                  family='gaussian',standardize=T,
                  nlambda=1000, alpha = alif)
cvnet.C.AL = cv.glmnet(netformC.3[,c(2:4,23:65)], netformC.3[,c(66)],family='gaussian',nfolds=100,alpha=alif)
plot(cvnet.C.AL)

coef(net.C.AL,s=cvnet.C.AL$lambda.min)








###...

mcAL.1 <- lm(AL ~ age + age2 + sex
             + Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion,
             data = smeandat)



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
m1a.a2 <- lmer(sys ~ age + I(age^2) + sex + BMI +
                 Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion + (1 | chimp), 
            data = scoutput,REML=FALSE)
m1b.a2 <- lmer(dias ~ age + I(age^2) + sex + BMI +
                 Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion + (1 | chimp), 
            data = scoutput,REML=FALSE)

m2.trig.a2 <- lmer(trig ~ age + I(age^2) + sex + BMI + 
                     Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion + (1 | chimp), 
                data = scoutput,REML=FALSE)

m2.chol.a2 <- lmer(chol ~ age + I(age^2) + sex + BMI +
                     Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion + (1 | chimp), 
                data = scoutput,REML=FALSE)

m2.creat.a2 <- lmer(creatinine ~ age + I(age^2) + sex + BMI +
                      Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion + (1 | chimp), 
                 data = scoutput,REML=FALSE)

# check convergence issues on this one, BMI unscaled?
library(optimx)
m3.BMI.a2 <- lmer(BMI ~ age + I(age^2) + sex + Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion + (1 | chimp), 
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
