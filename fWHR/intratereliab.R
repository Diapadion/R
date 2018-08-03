### Intra-rater reliability - comparing ratings on Bastrop morphs and individual faces



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





