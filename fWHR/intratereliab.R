### Intra-rater reliability - 


### Comparing ratings on Bastrop morphs and individual faces

library(psych)
library(alphahull)
library(tidyr)
library(dplyr)



newBas <- read.csv('SubsetofMorphs_BastropChimps_VADWrated.csv', header=T)

## what are fWHR.B* ???



newBas[,c(4:17)] <- as.numeric(unlist(newBas[,c(4:17)]))

tabl <- newBas
fWHR1 <- NULL
#i = 28

for (i in seq_len(dim(tabl)[1])){
  #i = 3
  points <- matrix(c(c(tabl$C.x[i], tabl$D.x[i], tabl$E.x[i], tabl$F.x[i], tabl$G.x[i]), 
                     c(tabl$C.y[i], tabl$D.y[i], tabl$E.y[i], tabl$F.y[i], tabl$G.y[i]))
                   ,nrow = 5, ncol = 2)
  
  
  fWHR1[i] =   fWHR(points, i)
  
}


## compare to fWHR.Bmorph

newBas = cbind(newBas, fWHR1)

nB1 = newBas[duplicated(newBas$Chimp),]
nB2 = newBas[!duplicated(newBas$Chimp),]

nBmorph = fWHR.Bmorph[fWHR.Bmorph$ID %in% nB1$Chimp,]

nBmorph = arrange(nBmorph, desc(nBmorph$ID)) 
nB1 = arrange(nB1, desc(nB1$Chimp)) 
nB2 = arrange(nB2, desc(nB2$Chimp))



cor(nBmorph$ratio, nB1$fWHR1)
cor(nBmorph$ratio, nB2$fWHR1)
cor(nB1$fWHR1, nB2$fWHR1)




### Calcuating IRR for the HPQ chimps


df_irr = read.csv('M:/Chimp faces/japan+Edi_chimps.csv')

df_irr = df_irr[!df_irr$hpq_rater == '',]
df_irr = df_irr[!df_irr$hpq_rater == ' ',]
table(df_irr$hpq_rater)



df_irr$Dominance <-
  (df_irr$Dom
   -df_irr$Subm
   -df_irr$Depd
   +df_irr$Indp
   -df_irr$Fear
   +df_irr$Decs
   -df_irr$Tim
   -df_irr$Caut
   +df_irr$Intll
   +df_irr$Pers
   +df_irr$Buly
   +df_irr$Stngy
   -df_irr$Vuln - df_irr$Anx + df_irr$Manp + 56)/15

df_irr$Extraversion <-
  (-df_irr$Sol-df_irr$Lazy-df_irr$Depr
   +df_irr$Actv+df_irr$Play+df_irr$Soc+df_irr$Frdy+df_irr$Affc+df_irr$Imit
   -df_irr$Indv + 32)/10

df_irr$Conscientiousness <-
  (-df_irr$Impl-df_irr$Defn-df_irr$Reckl-df_irr$Errc-df_irr$Irri
   +df_irr$Pred-df_irr$Aggr-df_irr$Jeals-df_irr$Dsor
   - df_irr$Thot - df_irr$Dist - df_irr$Unper - df_irr$Quit - df_irr$Clmy + 104)/14

df_irr$Agreeableness <-
  (df_irr$Symp+df_irr$Help+df_irr$Sens+df_irr$Prot+df_irr$Gntl
   + df_irr$Conv)/6

df_irr$Neuroticism <-
  (-df_irr$Stbl+df_irr$Exct-df_irr$Unem
   - df_irr$Cool + df_irr$Aut + 24)/5

df_irr$Openness <-
  (df_irr$Inqs+df_irr$Invt
   + df_irr$Cur + df_irr$Innov) / 4


colnames(df_irr)

df_irr_cut = df_irr[,c(1,3,4,239:244)]



# library(tidyr)
# 
# df_D = spread(df_irr[,c('chimp','location','hpq_rater','Dominance')], 'hpq_rater','Dominance')
# 
# 
# 
# ICC(df_D, missing=FALSE, lmer=TRUE)


### change to G theory

