library(lavaan)

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

bifact =~ Bullying + Stingy.Greedy + Aggressive + Irritable + Manipulative + 
Defiant + Excitable + Reckless + Dominant + Independent + Individualistic + Gentle +
Fearful + Submissive + Timid + Cautious + Dependent.Follower + Vulnerable +
Distractible + Disorganized 

#Conf ~ Dom

fWHR ~ Conf + Dom + bifact

LFFH ~ Conf + Dom + bifact


'

f.1 <- sem(m.1, sem.df[sem.df$agenum<=8,],
           missing='fiml', information='observed')

fitMeasures(f.1, c("chisq", "df", "pvalue", "cfi", "rmsea",'srmr'))

summary(f.1)




mi.1 = modindices(f.1)
subset(mi.1[order(mi.1$mi, decreasing=TRUE), ], mi > 5)

