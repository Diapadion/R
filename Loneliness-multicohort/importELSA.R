### ELSA importing and processing

library(readstata13)
library(psych)



setwd("./data")



### Wave 1 
## has most variables


elsa.1 <- read.dta13('wave_1_core_data_v3.dta')

## cflisen # word recall, immediate
## cfani # verbal fluency
## ncorrec # letter cancellation (number correct)
## nmissed # (number of letters missed)
## cflisd # word recall, delayed
## cfmscr # numerical ability

table(elsa.1$cfmscr)

elsa.1$cflisen[elsa.1$cflisen<0] = NA
elsa.1$cfani[elsa.1$cfani<0] = NA
elsa.1$ncorrec[elsa.1$ncorrec<0] = NA
elsa.1$nmissed[elsa.1$nmissed<0] = NA
elsa.1$cflisd[elsa.1$cflisd<0] = NA
elsa.1$cfmscr[elsa.1$cfmscr<0] = NA


cog.list = c('cflisen','cfani','ncorrec','cflisd','cfmscr') #,'nmissed')

cor(elsa.1[,cog.list], use='pairwise.complete.obs')


omega(elsa.1[,cog.list], nfactors=2) ## problem with number of tests



pca.1 = pca(elsa.1[,cog.list], nfactors=1, rotate='varimax')

pca.1



      