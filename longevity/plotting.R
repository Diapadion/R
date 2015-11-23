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

fit.e <- lm(Ext_CZ ~ years(DoB)-age, data=Dataset)
plot(fit.e)

fit.e <- lm(Ext_CZ ~ age, data=Dataset)
plot(fit.e)


# survfits

library(survival)
plot(survfit(y ~ age_pr, data=Dataset))

plot(survfit(yLt ~ Ext_CZ, data=datX))

