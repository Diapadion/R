library(blavaan)
library(beepr)



sem.df = aggregate(fWHR, by=list(fWHR$Rhesus),FUN=mean)

summary(sem.df)



is.nan.data.frame <- function(x)
  do.call(cbind, lapply(x, is.nan))

sem.df[is.nan(sem.df)] = NA



m.1 <- '
Dom =~ Bullying + Stingy.Greedy + Aggressive + Irritable + Manipulative + 
Defiant + Excitable + Reckless + Dominant + Independent + Individualistic + Gentle

Conf =~ Fearful + Submissive + Timid + Cautious + Dependent.Follower + Vulnerable #+
#Distractible + Disorganized 

Conf ~~ Dom

fWHR ~ Conf + Dom

LFFH ~ Conf + Dom


'

f.1 <- sem(m.1, sem.df[sem.df$agenum<=8,],
           missing='fiml', information='observed')

fitMeasures(f.1, c("chisq", "df", "pvalue", "cfi", "rmsea",'srmr'))

summary(f.1)




mi.1 = modindices(f.1)
subset(mi.1[order(mi.1$mi, decreasing=TRUE), ], mi > 5)




b.1 <- '
Dom =~ Bullying + prior("dnorm(0,.1)")*Stingy.Greedy + prior("dnorm(0,.1)")*Aggressive + 
prior("dnorm(0,.1)")*Irritable + prior("dnorm(0,.1)")*Manipulative + 
prior("dnorm(0,.1)")*Defiant + prior("dnorm(0,.1)")*Excitable + prior("dnorm(0,.1)")*Reckless + 
prior("dnorm(0,.1)")*Dominant + prior("dnorm(0,.1)")*Independent + 
prior("dnorm(0,.1)")*Individualistic + prior("dnorm(0,.1)")*Gentle +
Fearful + Submissive + Timid + Cautious + Dependent.Follower + Vulnerable +
Distractible + Disorganized

Conf =~ Fearful + prior("dnorm(0,.1)")*Submissive + prior("dnorm(0,.1)")*Timid + 
prior("dnorm(0,.1)")*Cautious + prior("dnorm(0,.1)")*Dependent.Follower + 
prior("dnorm(0,.1)")*Vulnerable + prior("dnorm(0,.1)")*Distractible + prior("dnorm(0,.1)")*Disorganized +
Bullying + Stingy.Greedy + Aggressive + Irritable + Manipulative + 
Defiant + Excitable + Reckless + Dominant + Independent + Individualistic + Gentle

Conf ~~ Dom #*prior("dbeta(1,1)")

fWHR ~ Conf + Dom

LFFH ~ Conf + Dom


'


bf.1 = bsem(b.1, data=sem.df[sem.df$agenum<=8,], 
            dp = dpriors(lambda="dnorm(0,100)", beta="dnorm(0,1)"), cp='fa',
            convergence='auto',#n.chains=3, burnin=10, adapt=10,sample=100,
            inits='simple',
            seed=c(1,2,3)
)
beep()
gc()



summary(bf.1)

blavFitIndices(bf.1)
#fitMeasures(bf.1)



########

m.x <- '
Dom =~ Bullying + Stingy.Greedy + Aggressive + Irritable + Manipulative + 
Defiant + Excitable + Reckless + Dominant + Independent + Individualistic + Gentle

Conf =~ Fearful + Submissive + Timid + Cautious + Dependent.Follower + Vulnerable #+
#Distractible + Disorganized 

bifact =~ Bullying + Stingy.Greedy + Aggressive + Irritable + Manipulative + 
Defiant + Excitable + Reckless + Dominant + Independent + Individualistic + Gentle +
Fearful + Submissive + Timid + Cautious + Dependent.Follower + Vulnerable +
Distractible + Disorganized 

Conf ~~ Dom

fWHR ~ Conf + Dom

LFFH ~ Conf + Dom

