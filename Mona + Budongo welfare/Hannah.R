

library(lattice)

wf$z_wfswb[1:18] = scale(wf$welfareswb[1:18])
wf$z_wfswb[19:36] = scale(wf$welfareswb[19:36])

wf$time <- as.factor(wf$time)


xyplot(z_wfswb ~ time, data = wf, type = 'l')

interaction.plot(wf$time, wf$Chimp, wf$z_wfswb, type='b', col = c(1:18))

library(ggplot2)

ggplot(wf, aes(time, z_wfswb,colour=Chimp)) +
  geom_line() + geom_point()

wf$EWpartic = as.factor(c(1,0,1,0,1,1,0,1,0,0,0,1,0,0,1,0,0,0,1,0,1,0,1,1,0,1,0,0,0,1,0,0,1,0,0,0))

# never involved {0}
# RE, SO, HE, LI, DA, LU, KD

# approach but never complete session {1}
# EM, LO, PA, PE, Q, EV;

# complete session {2}
# ED, LB, KL, FK, CI
wf$DMpartic = as.factor(c(2,0,2,1,1,2,0,2,0,0,2,1,0,1,1,1,0,0,
                          2,0,2,1,1,2,0,2,0,0,2,1,0,1,1,1,0,0))


ggplot(wf, aes(time, welfareswb,colour=EWpartic)) +
  geom_abline() + geom_point()


interaction.plot(wf$time, wf$EWpartic, wf$z_wfswb, type='b')

interaction.plot(wf$time, wf$DMpartic, wf$z_wfswb, type='b')

                    #      CI  DA  ED  EM  EV  FK  HE  KL  KD  LI  LB  LO  LU  PA  PE  Q   RE  SO
wf$Compartic = as.factor(c(0,  0,  1,  0,  1,  1,  0,  1,  0,  0,  1,  0,  0,  0,  1,  0,  0,  0,
                           0,  0,  1,  0,  1,  1,  0,  1,  0,  0,  1,  0,  0,  0,  1,  0,  0,  0))

interaction.plot(wf$time, wf$Compartic, wf$z_wfswb, type='b')

# t.test(wf$welfareswb[wf$time==1],wf$welfareswb[wf$time==2])

anova.DM <- aov(z_wfswb ~ DMpartic * time, data=wf)

anova.comp <- aov(z_wfswb ~ Compartic * time, data=wf)

summary(anova.DM)
TukeyHSD(anova.DM)



library(lme4)

lmm.DM <- lmer(z_wfswb ~ DMpartic * time + (1|Chimp), data=wf)

confint(lmm.DM, type='boot')


lmm.comp <- lmer(z_wfswb ~ Compartic * time + (1|Chimp), data=wf)



### Bootstrapping

# lmer

mySumm <- function(.) { s <- sigma(.)
c(beta =getME(., "beta"), sigma = s, sig01 = unname(s * getME(., "theta"))) }
(t0 <- mySumm(lmm.comp)) # just three parameters

set.seed(101)
boot.1 = bootMer(lmm.comp, mySumm, nsim=100)

head(as.data.frame(boot.1))

## Extract all CIs (somewhat awkward)
bCI.tab <- function(b,ind=length(b$t0), type="perc", conf=0.95) {
  btab0 <- t(sapply(as.list(seq(ind)),
                    function(i)
                      boot.ci(b,index=i,conf=conf, type=type)$percent))
  btab <- btab0[,4:5]
  rownames(btab) <- names(b$t0)
  a <- (1 - conf)/2
  a <- c(a, 1 - a)
  pct <- stats:::format.perc(a, 3)
  colnames(btab) <- pct
  return(btab)
}
bCI.tab(boot.1)



# ANOVA bootstrapping

# define function to compute and return test statistics of interest
permDiff <- function(wf, indices){
  wf$z_wfswb <- wf$z_wfswb[indices]
  anova.comp <- aov(z_wfswb ~ Compartic * time, data=wf)
  #model <- glm(job ~ cset*(r1 + r2), family=binomial, data=dat)
  return(coefs = coef(anova.comp))
}

resamples <- 1000
results2 <- boot(data=wf, statistic=permDiff, R=resamples, sim="permutation"
                 )
# plot sampling distributions
layout(cbind(1:2,3:4))
apply(results2$t, 2, function(x){plot(density(x)); abline(v=0);})
layout(1)

# get p-values
pVals <- sapply(1:4, function(x){
  mean(results2$t[,x] > abs(results2$t0[x]) | results2$t[,x] < -1*abs(results2$t0[x]))
})
pVals

# display with default glm results
cbind(coef(anova.comp), permP=pVals)




# ANOVA permutation

observed_F_value <- anova(lm(z_wfswb ~ DMpartic * time, data=wf))$"F value"[1]

n <- 10000
permutation_F_values <- numeric(length=n)

for(i in 1:n){
  # note: the sample function without extra parameters defaults to a permutation
  temp_fit <- anova(lm(z_wfswb ~ sample(DMpartic) * time,data=wf))
  permutation_F_values[i] <- temp_fit$"F value"[1]
}

hist(permutation_F_values, xlim=range(c(observed_F_value, permutation_F_values)))
abline(v=observed_F_value, lwd=3, col="red")
cat("P value: ", sum(permutation_F_values >= observed_F_value), "/", n, "\n", sep="")



# Model-based resampling


P     <- 4
Nj    <- c(41, 37, 42, 40)
muJ   <- rep(c(-1, 0, 1, 2), Nj)
dfCRp <- data.frame(IV=factor(rep(LETTERS[1:P], Nj)),
                    DV=rnorm(sum(Nj), muJ, 6))

anBase <- anova(lm(z_wfswb ~ Compartic * time, data=wf))
Fbase  <- anBase["IV", "F value"]
(pBase <- anBase["IV", "Pr(>F)"])



## the below does not work

B-nova <- boot.anova(wf, z_wfswb ~ Compartic * time)

alias(z_wfswb ~ Compartic * time, data=wf)


####### Functions #######

require(car)
require(boot)

# Bootstrapped AN(C)OVA Options -------------------------------------------
#
# formula:      Formula for AN(C)OVA model
#
# conf.int:     Confidence intervals (default = 0.95)
#
# dec:          Number of decimal places (default = 3)
#
# reps:         Number of bootstrap replications (default = 1000)

# Bootstrap statistic -----------------------------------------------------

anboot <- function(formula, data, i){
  
  data.resamp <- data[i,] # Resample rows
  
  fit <- lm(formula, data.resamp)
  
  f.coef <- Anova(fit, type = 2)[["F value"]] # Extract F-values
  
  return <- c(f.coef)
}

# Function to run bootstrap and provide output ----------------------------
boot.anova <- function(data, formula, conf.int = 0.95, dec = 2, reps = 1000) {
  
  # Fit non-bootstrapped ANOVA to obtain Sum Sq and df
  lm.fit <- lm(formula, data = data)
  # Get DV name
  dv.name <- colnames(model.frame(lm.fit))[1]                    
  # Get IV names
  iv.names <- attr(lm.fit$terms , "term.labels")
  
  # Fit ANOVA model with Type III Sum of Squares
  anova.fit <- Anova(lm.fit, type = 2)
  
  
  # Call anboot function
  anboot.run <- boot(statistic = anboot, formula = formula, data = data, R = reps)
  
  f.ssq <- anova.fit[["Sum Sq"]]           # Sum of Squares (Type III)    
  f.values <- summary(anboot.run)$original # F-values
  f.se <- summary(anboot.run)$bootSE       # Bootstrap SE
  f.z <- f.values/f.se                     # z-value
  f.z.p <- 2*pnorm(-abs(f.z))              # Pr(>|z|)
  f.df <- anova.fit[["Df"]]                # df
  
  f.crit <- NULL # To prevent errors
  
  # Critical F-Value (excludes the 'Residuals' term)
  for(i in 1:(length(f.df)-1)){
    f.crit[i] <- qf(conf.int, f.df[i], f.df[length(f.df)])
  }
  
  # Get Bootstrapped confidence intervals
  ci.lower <- NULL
  ci.upper <- NULL
  
  for(i in 1:length(f.values)){
    boot.bca <- boot.ci(anboot.run, index = i, type = "bca", conf = conf.int)$bca
    ci.lower[i] <- boot.bca[4]
    ci.upper[i] <- boot.bca[5]     
  }
  
  # P-value stars
  fstar <- NULL
  
  for(i in 1:length(na.omit(f.z.p))) {
    if(f.z.p[i] < .001) {
      fstar[i] <- "***"
    } else if(f.z.p[i] < .01) {
      fstar[i] <- "**"
    } else if(f.z.p[i] < .05) {
      fstar[i] <- "*"
    } else if(f.z.p[i] < .10){
      fstar[i] <- "."
    } else {
      fstar[i] <- ""
    }
  }
  
  # Column names
  cnames <- c("Sum Sq", "Df", "F value", "SE", "LB", "UB", "Crit F", "z", "Pr(>|z|)", "")
  
  # Row names
  rnames <- c("(Intercept)", iv.names, "Residuals")
  
  # Turn warnings off as the variables are not equal length when creating output.df
  options(warn = -1)
  
  # Create data frame to use as output
  output.df <- as.data.frame(cbind(round(f.ssq, dec), 
                                   f.df, 
                                   format(round(f.values, dec), dec), 
                                   format(round(f.se, dec), dec), 
                                   format(round(ci.lower, dec), dec), 
                                   format(round(ci.upper, dec), dec), 
                                   format(round(f.crit, dec), dec),
                                   format(round(f.z, dec), dec), 
                                   signif(f.z.p, 3),
                                   fstar))
  
  
  # Remove redundant values for the Residuals row
  output.df[nrow(output.df), 3:10] <- NA
  
  # Set column and row names
  colnames(output.df) <- cnames
  rownames(output.df) <- rnames
  
  
  # Print results
  cat("BCa Bootstrap Anova Table (Type III tests)", 
      "\n",
      "\n", "Response: ", dv.name,
      "\n",
      sep ="")
  
  print(as.matrix(output.df), justify = "right", na.print = "" , quote = FALSE )
  
  cat("---",
      "\n", "Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1)",
      sep = "")
  
  # Turn warnings on
  options(warn = 0)
}