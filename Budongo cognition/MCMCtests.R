### MCMCglmm Priors

### figuring it out

library(MCMCglmm)

### This is what we want to deal with, ultimately:
mew.mcmc.pZIF.1 <- MCMCglmm(Time ~ Dominance + Conscientiousness +
                              Openness + Neuroticism + Agreeableness +
                              Extraversion, random= ~Date + Chimp,
                            data = inPodL, family = "zipoisson"
                            , rcov=~idh(trait):units
                            , burnin = 10000 , nitt = 90000 , verbose = FALSE
)
## are the random effects specified correctly?


plot(mew.mcmc.pZIF.2)



### Building up to it

prior1.1 <- list(G = list(G1 = list(V = 1, n = 0.002), 
                          G2 = list(V = 1,n = 0.002)), 
                      R = list(V = 1, n = 0.002))

g.pri1 <- gelman.prior(Time ~ Dominance, data = inPodL)

g.priX <- gelman.prior(Time ~ Dominance + Conscientiousness +
                         Openness + Neuroticism + Agreeableness +
                         Extraversion, data=inPodL)

#prior1.2 <- 

prior1.3 <- list((R=list(V=diag(2),n=2,fix=2),
                  
                  )


mcmc1 <- MCMCglmm(Time ~ Dominance, random = ~Chimp + Date,
                  data = inPodL, family='zipoisson',
                  , rcov=~idh(trait):units
                  , verbose = FALSE,
                  prior = priorB
                  )


### THIS ONE ###
mcmc2 <- MCMCglmm(Time ~ Dominance + Conscientiousness +
                    Openness + Neuroticism + Agreeableness +
                    Extraversion, 
                  random =~ idh(trait):Chimp + idh(trait):Date,
                  data = inPodL.mcmc, family='zipoisson',
                  , rcov=~idh(trait):units
                  , verbose = FALSE,
                  burnin = 10000 , nitt = 90000,
                  prior = priorB
)

mcmc2.0.0 <- MCMCglmm(Time ~ Dominance + Conscientiousness +
                    Openness + Neuroticism + Agreeableness +
                    Extraversion, 
                  random =~ idh(trait):Chimp + idh(trait):Date,
                  data = inPodL.mcmc, family='hupoisson',
                  , rcov=~idh(trait):units
                  , verbose = FALSE,
                  burnin = 10000 , nitt = 90000,
                  prior = priorB
)

# maybe this one...
mcmc2.1 <- MCMCglmm(Time ~ Dominance + Conscientiousness +
                    Openness + Neuroticism + Agreeableness +
                    Extraversion, 
                  random =~ us(trait):Chimp + us(trait):Date,
                  data = inPodL, family='zipoisson',
                  , rcov=~us(trait):units
                  , verbose = FALSE,
                  burnin = 10000 , nitt = 90000,
                  prior = priorB
)

mcmc2.1.0 <- MCMCglmm(Time ~ Dominance + Conscientiousness +
                      Openness + Neuroticism + Agreeableness +
                      Extraversion, 
                    random =~ us(trait):Chimp + us(trait):Date,
                    data = inPodL, family='hupoisson',
                    , rcov=~us(trait):units
                    , verbose = FALSE,
                    burnin = 10000 , nitt = 90000,
                    prior = priorB
)



mcmc2.2 <- MCMCglmm(Time ~ trait + Dominance + Conscientiousness +
                    Openness + Neuroticism + Agreeableness +
                    Extraversion, 
                  #random =~ idh(trait):Chimp + Chimp + idh(trait):Date + Date,
                  random =~ idh(trait):Chimp + idh(trait):Date,
                  data = inPodL, family='zipoisson',
                  , rcov=~idh(trait):units
                  , verbose = FALSE,
                  burnin = 10000 , nitt = 90000,
                  prior = priorB
)




MCMCglmm(abund~trait+trait:fl+trait:mps+trait:elev+trait:distance +trait:dens-1,
         random=~idh(trait):YEAR +idh(trait):pop,rcov=~idh(trait):units,data=flyden
         s,family="zipoisson",prior=p


priorB <- list(R=list(V=diag(2),n=2,fix=2),
               G=list(
                 G1=list(V=diag(c(1, 1e-6)),n=2, fix=2),
                 G2=list(V=diag(c(1, 1e-6)),n=2, fix=2)))

priorB.1 <- list(R=list(V=diag(2),n=2,fix=2),
               G=list(
                 G1=list(V=diag(c(2, 1e-6)),n=2, fix=2),
                 G2=list(V=diag(c(2, 1e-6)),n=2, fix=2)))

priorB.2 <- list(R=list(V=diag(2),n=2,fix=2),
                 G=list(
                   G1=list(V=diag(c(2, 1e-6)),n=2, fix=2),
                   G2=list(V=diag(c(2, 1e-6)),n=2, fix=2)))


nterms = 7

# # this appears to be the best prior
# priorC <- list(B=list(mu=matrix(0, nterms, 1), V=diag(nterms)*1e+6),  
#                R=list(V=diag(2), nu=0.001, fix=2),
#                G=list(G1=list(V=diag(c(1, 1e-6)), nu=0.001, fix=2),
#                       G2=list(V=diag(c(1, 1e-6)), nu=0.001, fix=2)))

priorC <- list(B=list(mu=matrix(0, nterms, 1), V=diag(nterms)*1e+6),  
               R=list(V=diag(2), nu=2.001, fix=2),
               G=list(G1=list(V=diag(c(1, 1e-6)), nu=2.001, fix=2),
                      G2=list(V=diag(c(1, 1e-6)), nu=2.001, fix=2)))

# this sets up a diffuse prior around zero on the fixed effects,   
# where nterms is the number of fixed effects your fitting

diag(priorC$B$V)[seq(4, nterms, 2)] <- 1e-6

# this sets the variance around the zero inflation terms (except the  
# intercept) to be very small, essentially fixing them to zero.


# mcmc3 <- MCMCglmm(Time ~ Dominance + Conscientiousness +
#                     Openness + Neuroticism + Agreeableness +
#                     Extraversion, 
#                   random =~ idh(trait):Chimp + idh(trait):Date,
#                   data = inPodL.mcmc, family='zipoisson',
#                   , rcov=~idh(trait):units
#                   , verbose = FALSE,
#                   burnin = 10000 , nitt = 90000,
#                   prior = priorC
# )


# THIS ONE?
mcmc3.us <- MCMCglmm(Time ~ Dominance + Conscientiousness +
                    Openness + Neuroticism + Agreeableness +
                    Extraversion, 
                  random =~ us(trait):Chimp + us(trait):Date,
                  data = inPodL.mcmc, family='zipoisson',
                  , rcov=~us(trait):units
                  , verbose = FALSE,
                  #burnin = 30000 , nitt = 300000,
                  burnin = 10000 , nitt = 50000,
                  prior = priorC
)
summary(mcmc3.us)


### hurdle?
### ... probably not

### should compare the ZIFp to the regular Poisson

priorD <-list(R = list(V = diag(1), nu = 0.002), G =
              list(G1 = list(V = diag(1), nu = 0.002)))

mcmc3.p.us <- MCMCglmm(Time ~ Dominance + Conscientiousness +
                          Openness + Neuroticism + Agreeableness +
                          Extraversion, 
                        random =~ us(trait):Chimp + us(trait):Date,
                        data = inPodL.mcmc, family='poisson',
                        , rcov=~us(trait):units
                        , verbose = FALSE,
                        burnin = 30000 , nitt = 100000,
                        prior = priorC
)

mcmc3.za.us <- MCMCglmm(Time ~ Dominance + Conscientiousness +
                       Openness + Neuroticism + Agreeableness +
                       Extraversion, 
                     random =~ us(trait):Chimp + us(trait):Date,
                     data = inPodL.mcmc, family='zapoisson',
                     , rcov=~us(trait):units
                     , verbose = FALSE,
                     burnin = 30000 , nitt = 100000,
                     prior = priorC
)

mcmc3.hu.us <- MCMCglmm(Time ~ Dominance + Conscientiousness +
                          Openness + Neuroticism + Agreeableness +
                          Extraversion, 
                        random =~ us(trait):Chimp + us(trait):Date,
                        data = inPodL.mcmc, family='hupoisson',
                        , rcov=~us(trait):units
                        , verbose = FALSE,
                        burnin = 30000 , nitt = 100000,
                        prior = priorC
)
#summary(mcmc3.us)

## can it just be done with glmm and compared via DIC?
library(lme4)
glm3.p.us <- glmer(Time ~ Dominance + Conscientiousness +
                     Openness + Neuroticism + Agreeableness +
                     Extraversion +
                     (1 | Date) + (1 | Chimp)
                     , data = inPodL.mcmc,
                   family = poisson()
                   )
# this is shit, what about a regular ZIP?

library(pscl)
zifp3 <- zeroinfl(Time ~ Dominance + Conscientiousness +
                    Openness + Neuroticism + Agreeableness +
                    Extraversion
                  , data = inPodL.mcmc, dist="poisson")
zifp3.hu <- hurdle(Time ~ Dominance + Conscientiousness +
                    Openness + Neuroticism + Agreeableness +
                    Extraversion
                  , data = inPodL.mcmc, dist="poisson")



require(R2admb)
install.packages("glmmADMB", repos="http://R-Forge.R-project.org")

install.packages('./glmmADMB_0.8.1.zip', repos=NULL)

install.packages("glmmADMB", 
                 repos=c("http://glmmadmb.r-forge.r-project.org/repos",
                         getOption("repos")),
                 type="source")

library(glmmADMB)
# ... shit
# ... yeah?

mew.poisZIF.1 <- glmmadmb(Time ~ Dominance + Conscientiousness +
                            Openness + Neuroticism + Agreeableness +
                            Extraversion + (1 | Date)# + (1 | Chimp)
                          ,data=inPodL.mcmc, family = "poisson"
                          #, zeroInflation=TRUE
                          , save.dir='./ADMB/',
                          admb.opts = admbControl(noinit=FALSE, shess=FALSE)
)

## new fun toy thing
library(gamlss)

gam.zip.1 <- gamlss(Time ~ Dominance + Conscientiousness +
                      Openness + Neuroticism + Agreeableness +
                      Extraversion + random(Date) + random(Chimp), 
                    data=inPodL.mcmc, family=ZIP)
summary(gam.zip.1)


# probably choose to go with MCMCglmm


