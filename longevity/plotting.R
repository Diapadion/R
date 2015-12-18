# Plots

plot(Dataset$Ext_CZ ~ Dataset$status)

plot(Dataset$Dom_CZ ~ Dataset$status)


plot(Dataset$origin ~ Dataset$status)
plot(Dataset$age ~ Dataset$origin)

# plot(Ext_CZ ~ age_pr, data=datX)
plot(Dom_CZ ~ age_pr, data=datX)
plot(Neu_CZ ~ age_pr, data=datX)
plot(Opn_CZ ~ age_pr, data=datX)


plot(Dataset$age_pr, Dataset$Agr_CZ)
cor.test(Dataset$age_pr, Dataset$Agr_CZ)

plot(Dataset$age_pr, Dataset$Dom_CZ)
cor.test(Dataset$age_pr, Dataset$Dom_CZ) # *

plot(Dataset$age_pr, Dataset$Opn_CZ)
cor.test(Dataset$age_pr, Dataset$Opn_CZ) # **

plot(Dataset$age_pr, Dataset$Con_CZ)
cor.test(Dataset$age_pr, Dataset$Con_CZ)

plot(Dataset$age_pr, Dataset$Neu_CZ)
cor.test(Dataset$age_pr, Dataset$Neu_CZ) # *

plot(Dataset$age_pr, Dataset$Ext_CZ)
cor.test(Dataset$age_pr, Dataset$Ext_CZ) # *

plot(Dataset$DoB, Dataset$Ext_CZ)
plot(Dataset$age, Dataset$Ext_CZ)
plot(Dataset$age_pr_adj, Dataset$Ext_CZ)

library(psych)

corr.test(as.matrix(Dataset[,c(73:78)]),as.matrix(as.numeric(Dataset$DoB)), method = "spearman", adjust='BY')
# Dom, Neu, Opn, Ext



plot(Dataset$age_pr, Dataset$DoB-Dataset$age)


plot(Dataset$Ext_CZ, Dataset$Ext_CZ - scale(Dataset$age_pr))
plot(Dataset$Ext_CZ, Dataset$age_pr - 5 * Dataset$Ext_CZ)

# could one substract the max value to reverse the range?



# substraction is not quite the right operation
plot(1/Dataset$age_pr_adj, Dataset$Ext_CZ)
plot(scale(1/scale(Dataset$age_pr_adj)), Dataset$Ext_CZ)
plot(Dataset$Ext_CZ-scale(1/scale(Dataset$age_pr_adj)), Dataset$Ext_CZ)

# which of these two?
plot(Dataset$age_pr_adj, Dataset$Ext_CZ-scale(1/(1 + Dataset$age_pr_adj))) # former, this one
plot(Dataset$age_pr_adj, scale(1/scale(Dataset$age_pr_adj))-Dataset$Ext_CZ)

# also...
plot(Dataset$age_pr_adj, Dataset$Ext_CZ-scale(1/as.numeric(year(Dataset$DoB)))) # nope, no good



View(cbind(Dataset$age_pr_adj, Dataset$Ext_CZ,
           Dataset$Ext_CZ-scale(1/Dataset$age_pr_adj),
           scale(1/scale(Dataset$age_pr_adj))-Dataset$Ext_CZ     ))

# division?
plot(Dataset$Ext_CZ/scale(Dataset$age_pr_adj), Dataset$Ext_CZ)
plot(Dataset$age_pr_adj, Dataset$Ext_CZ/scale(Dataset$age_pr_adj)) # too condensed

Dataset$divE <- scale(Dataset$Ext_CZ/scale(Dataset$age_pr_adj))

fit.e <- lm(Ext_CZ ~ years(DoB)-age, data=Dataset)
plot(fit.e)

fit.e <- lm(Ext_CZ ~ age, data=Dataset)
plot(fit.e)


plot(datX$age_pr_adj, datX$Ext_CZ)
plot(datX$age_pr_adj, datX$E.resid)
#fit.e2 <- 


# survfits

library(survival)
plot(survfit(y ~ age_pr, data=Dataset))

plot(survfit(yLt ~ Ext_CZ, data=datX))



# Wild vs. Captive 
plot(datX$DoB, datX$origin)
plot(datX$age_pr_adj, datX$origin)
plot(datX$age, datX$origin)

