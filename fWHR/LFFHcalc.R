### LF/FH

library(tidyr)



### Faciliatory code for making LFFH

### The import process here is imperfect at the moment

lffh <- read.csv('all-chimps-LFFH.csv')

#lffh = lffh[lffh$A!='X',c(3,15:21)]

lffh <- separate(data = lffh, col = A, into = c("A.x", "A.y"), sep = "\\,")
lffh <- separate(data = lffh, col = B, into = c("B.x", "B.y"), sep = "\\,")
lffh <- separate(data = lffh, col = G, into = c("G.x", "G.y"), sep = "\\,")

colnames(lffh)

lffh[,15:24] <- data.frame(lapply(lffh[,c('B.x','B.y','G.x','G.y')], 
                                  function(x) euc.dist(B.x, B.y, G.x, G.y)))


i = 0
for (i in (1:dim(lffh)[1])){
  lffh$lower.face[i] = euc.dist(lffh$B.x[i],lffh$B.y[i],lffh$G.x[i],lffh$G.y[i])
  
}

i = 0
for (i in (1:dim(lffh)[1])){
  lffh$face.height[i] = euc.dist(lffh$B.x[i],lffh$B.y[i],lffh$A.x[i],lffh$A.y[i])
  
}

lffh$lffh = (lffh$lower.face)/(lffh$face.height)

head(lffh$lffh)



write.csv(lffh[,c(3,27:29)], "heightsRatios.csv")




####### Functions #######

# euc.dist <- function(x1, x2) sqrt(sum((x1 - x2) ^ 2))

euc.dist <- function(x1.1, x1.2, x2.1, x2.2) sqrt(sum((c(x1.1, x1.2) - c(x2.1, x2.2)) ^ 2))


# df2LFFH <- function(yCh){
#   
#   #yCh = bCh[bCh$A!='X',c(2,14:20)]
#   yCh = yCh[yCh$A!='X',c(3,15:21)]
#   
#   yCh <- separate(data = yCh, col = A, into = c("A.x", "A.y"), sep = "\\,")
#   yCh <- separate(data = yCh, col = B, into = c("B.x", "B.y"), sep = "\\,")
#   yCh <- separate(data = yCh, col = G, into = c("G.x", "G.y"), sep = "\\,")
#   
#   yCh[,2:15] <- data.frame(lapply(yCh[,2:15], function(x) as.numeric(x)))
#   
#   tabl <- yCh
#   fWHRc <- data.frame(ID=factor(dim(yCh)[1]),ratio=numeric(dim(yCh)[1]))
#   
#   #fWHRc$ID = as.character(yCh$ID)
#   fWHRc$ID = yCh$ID
#   
#   for (i in seq_len(dim(tabl)[1])){
#     points <- matrix(c(c(tabl$C.x[i], tabl$D.x[i], tabl$E.x[i], tabl$F.x[i], tabl$G.x[i]), 
#                        c(tabl$C.y[i], tabl$D.y[i], tabl$E.y[i], tabl$F.y[i], tabl$G.y[i]))
#                      ,nrow = 5, ncol = 2)
#     
#     
#     fWHRc$ratio[i] =   fWHR(points, i)
#     
#   }
#   
#   return(fWHRc)
#   
# }  
