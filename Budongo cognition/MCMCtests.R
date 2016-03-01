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

mcmc2 <- MCMCglmm(Time ~ Dominance + Conscientiousness +
                    Openness + Neuroticism + Agreeableness +
                    Extraversion, 
                  random =~ idh(trait):Chimp + idh(trait):Date,
                  data = inPodL, family='zipoisson',
                  , rcov=~idh(trait):units
                  , verbose = FALSE,
                  burnin = 10000 , nitt = 90000,
                  prior = priorB
)

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

priorC <- list(B=list(mu=matrix(0, nterms, 1), V=diag(nterms)*1e+6),  
               R=list(V=diag(2), nu=1.002, fix=2),
               G=list(G1=list(V=diag(c(1, 1e-6)), nu=1.002, fix=2),
                      G2=list(V=diag(c(1, 1e-6)), nu=1.002, fix=2)))

# this sets up a diffuse prior around zero on the fixed effects,   
# where nterms is the number of fixed effects your fitting

diag(priorC$B$V)[seq(4, nterms, 2)] <- 1e-6

# this sets the variance around the zero inflation terms (except the  
# intercept) to be very small, essentially fixing them to zero.


mcmc3 <- MCMCglmm(Time ~ s(Dominance) + s(Conscientiousness) +
                    s(Openness) + s(Neuroticism) + s(Agreeableness) +
                    s(Extraversion), 
                  random =~ idh(trait):Chimp + idh(trait):Date,
                  data = inPodL, family='zipoisson',
                  , rcov=~idh(trait):units
                  , verbose = FALSE,
                  burnin = 10000 , nitt = 90000,
                  prior = priorC
)


mcmc3.us <- MCMCglmm(Time ~ Dominance + Conscientiousness +
                    Openness + Neuroticism + Agreeableness +
                    Extraversion, 
                  random =~ us(trait):Chimp + us(trait):Date,
                  data = inPodL, family='zipoisson',
                  , rcov=~us(trait):units
                  , verbose = FALSE,
                  burnin = 10000 , nitt = 90000,
                  prior = priorC
)


