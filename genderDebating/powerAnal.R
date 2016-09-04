### starting out with EP's data

EPdf <- read.csv('all_data.csv',header=T)


f.mean <- mean(EPdf$Average.Speaker.Score[EPdf$Speaker.Sex=='Female'])
f.sd <- sd(EPdf$Average.Speaker.Score[EPdf$Speaker.Sex=='Female'])

m.mean <- mean(EPdf$Average.Speaker.Score[EPdf$Speaker.Sex=='Male'])
m.sd <- sd(EPdf$Average.Speaker.Score[EPdf$Speaker.Sex=='Male'])

EPdf.trim <- EPdf[EPdf$Speaker.Sex!='Unknown',]

EP.anova = aov(EPdf.trim$Average.Speaker.Score ~ EPdf.trim$Speaker.Sex)

EP.lm = lm(EPdf.trim$Average.Speaker.Score ~ EPdf.trim$Speaker.Sex)
r.sq = summary(EP.lm)$r.squared



#library(ez)

#ezANOVA(EPdf.trim, Average.Speaker.Score, wid=Speaker.Name, between=Speaker.Sex)
#eta_sq(EP.anova)

# omega.sq = omega_sq(EP.anova)

library(sjstats)

eta.sq = eta_sq(EP.anova)




###

omega.sq = 0.012747

f2 = eta.sq / (1 - eta.sq)
# f2 = omega.sq / (1 - omega.sq)

f = sqrt(f2)



### Power analysis

library(pwr)


pwr.f2.test(u = 2, 
            f2 = f2, sig.level = .05, power = .8)

52.5 + 1 + 2 + 3

# many hundreds ...




# Well, what if we merged the team scores and looked at a 3 level category like that?


levels(EPdf$Speaker.Sex) = c(0,1,-7)
EPdf$Speaker.Sex = as.numeric(levels(EPdf$Speaker.Sex))[EPdf$Speaker.Sex]


# EP.agg = aggregate(EPdf$Average.Speaker.Score ~ EPdf$Team.Name, FUN=sum)
# EP.agg = aggregate(cbind(Tournament, Team.Name) ~ Average.Speaker.Score, data=EPdf, FUN=sum)

EP.agg = aggregate(cbind(Average.Speaker.Score, Speaker.Sex) ~ Tournament + Team.Name, data=EPdf, FUN=sum)

EP.agg = EP.agg[EP.agg$Speaker.Sex>-1,]


EP.agg$Speaker.Sex = ordered(EP.agg$Speaker.Sex)

EPa.lm = lm(EP.agg$Average.Speaker.Score ~ EP.agg$Speaker.Sex)

r.sq = summary(EPa.lm)$r.squared

# EP.agg$subnum = rownames(EP.agg)
# ezANOVA(EP.agg, Average.Speaker.Score, between=Speaker.Sex, wid=subnum)


eta.sq = 0.01895722

f2 = eta.sq / (1 - eta.sq)



omega_sq <- function(aov_in, neg2zero=T){
  aovtab <- summary(aov_in)[[1]]
  n_terms <- length(aovtab[["Sum Sq"]]) - 1
  output <- rep(-1, n_terms)
  SSr <- aovtab[["Sum Sq"]][n_terms + 1]
  MSr <- aovtab[["Mean Sq"]][n_terms + 1]
  SSt <- sum(aovtab[["Sum Sq"]])
  for(i in 1:n_terms){
    SSm <- aovtab[["Sum Sq"]][i]
    DFm <- aovtab[["Df"]][i]
    output[i] <- (SSm-DFm*MSr)/(SSt+MSr)
    if(neg2zero & output[i] < 0){output[i] <- 0}
  }
  names(output) <- rownames(aovtab)[1:n_terms]
  
  return(output)
}


### Design Effects approach
library(sjstats)

deff(8)

smpsize_lmm(0.13, power=0.8, sig.level=0.05, k=8,
            df.n = 2 # number of tested predictors?
            )


### Let's try simulations for the MM method
library(simr)

x <- rep(1:10)
g <- c('a', 'b', 'c')

X <- expand.grid(x=x, g=g)

b <- c(2, -0.1) # fixed intercept and slope
V1 <- 0.5 # random intercept variance
V2 <- matrix(c(0.5,0.05,0.05,0.1), 2) # random intercept and slope variance-covariance matrix
s <- 1 # residual variance

model1 <- makeLmer(y ~ x + (1|g), fixef=b, VarCorr=V1, sigma=s, data=X)

summary(model1)
