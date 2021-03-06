####### Chimp faces #######

library(alphahull)
library(tidyr)
library(readxl)



### TO MEASURE:

cPoints = read.csv(file = "ChimpfWHR.csv")



### Betsy's Edinburgh extras

betsy <- read_xlsx('./Extra measures_Betsy photos_DMA.xlsx')

betsy <- separate(data = betsy, col = A, into = c("A.x", "A.y"), sep = "\\,")
betsy <- separate(data = betsy, col = B, into = c("B.x", "B.y"), sep = "\\,")
betsy <- separate(data = betsy, col = C, into = c("C.x", "C.y"), sep = "\\,")
betsy <- separate(data = betsy, col = D, into = c("D.x", "D.y"), sep = "\\,")
betsy <- separate(data = betsy, col = E, into = c("E.x", "E.y"), sep = "\\,")
betsy <- separate(data = betsy, col = F, into = c("F.x", "F.y"), sep = "\\,")
betsy <- separate(data = betsy, col = G, into = c("G.x", "G.y"), sep = "\\,")

betsy[,c(3:16)] <- data.frame(lapply(betsy[,c(3:16)], function(x) as.numeric(x)))

tabl <- betsy
fWHRbetsy <- NULL

for (i in seq_len(dim(tabl)[1])){
  points <- matrix(c(c(tabl$C.x[i], tabl$D.x[i], tabl$E.x[i], tabl$F.x[i], tabl$G.x[i]), 
                     c(tabl$C.y[i], tabl$D.y[i], tabl$E.y[i], tabl$F.y[i], tabl$G.y[i]))
                   ,nrow = 5, ncol = 2)
  
  
  fWHRbetsy[i] =   fWHR(points, i)
  
}
betsy = cbind(betsy, fWHRbetsy)


i = 0
for (i in (1:dim(betsy)[1])){
  betsy$lower.face[i] = euc.dist(betsy$B.x[i],betsy$B.y[i],betsy$G.x[i],betsy$G.y[i])
  
}

i = 0
for (i in (1:dim(betsy)[1])){
  betsy$face.height[i] = euc.dist(betsy$B.x[i],betsy$B.y[i],betsy$A.x[i],betsy$A.y[i])
  
}

betsy$lffh = (betsy$lower.face)/(betsy$face.height)

View(betsy$lffh)



### - Yerkes

yCh = cPoints[cPoints$location=='Yerkes',]
yCh = yCh[yCh$A!='X',c(14:20)]

yCh <- separate(data = yCh, col = A, into = c("A.x", "A.y"), sep = "\\,")
yCh <- separate(data = yCh, col = B, into = c("B.x", "B.y"), sep = "\\,")
yCh <- separate(data = yCh, col = C, into = c("C.x", "C.y"), sep = "\\,")
yCh <- separate(data = yCh, col = D, into = c("D.x", "D.y"), sep = "\\,")
yCh <- separate(data = yCh, col = E, into = c("E.x", "E.y"), sep = "\\,")
yCh <- separate(data = yCh, col = F, into = c("F.x", "F.y"), sep = "\\,")
yCh <- separate(data = yCh, col = G, into = c("G.x", "G.y"), sep = "\\,")

yCh <- data.frame(lapply(yCh, function(x) as.numeric(x)))

tabl <- yCh
fWHRc <- NULL

for (i in seq_len(dim(tabl)[1])){
  points <- matrix(c(c(tabl$C.x[i], tabl$D.x[i], tabl$E.x[i], tabl$F.x[i], tabl$G.x[i]), 
                     c(tabl$C.y[i], tabl$D.y[i], tabl$E.y[i], tabl$F.y[i], tabl$G.y[i]))
                   ,nrow = 5, ncol = 2)
  
  
  fWHRc[i] =   fWHR(points, i)
  
}

### - Bastrop



### - sub-sample of Japan & Edi chimps
#
# > sample(c(2:260), 20)
# [1]  14  54 224  77 191 177 240  21   8 139  15 162 100  40  75 145 182  87 114  93
#
# Holland - Edith 1.JPG             
# kilimi oct2013b.JPG
# Pal.20060611
# 2013-11-27 14.56.34
# Konatsu.20030702
# Gon.20070620
# Shiomi.20030410
# 2013-11-27 15.12.02-1.jpg
# David P1010077.tem
# 2013-11-27 13.57.01
# Holland - Paul (left) and Edith (right).JPG
# Cleo.20060611霊研屋外 024
# Edinburgh - Lucy 2.JPG
# Holland - Frek 1.JPG
# 2013-11-27 14.22.24-1
# 2013-11-27 14.37.34-1
# James20041102
# Liberius.JPG
# Louis P1020290.JPG
# 2013-11-27 14.12.13




cPoints = cPoints[cPoints$A != '',]
carmen = as.numeric(as.character(cPoints$fHWR))
cPoints <- cPoints[,c(14:20)]

cPoints <- separate(data = cPoints, col = A, into = c("A.x", "A.y"), sep = "\\,")
cPoints <- separate(data = cPoints, col = B, into = c("B.x", "B.y"), sep = "\\,")
cPoints <- separate(data = cPoints, col = C, into = c("C.x", "C.y"), sep = "\\,")
cPoints <- separate(data = cPoints, col = D, into = c("D.x", "D.y"), sep = "\\,")
cPoints <- separate(data = cPoints, col = E, into = c("E.x", "E.y"), sep = "\\,")
cPoints <- separate(data = cPoints, col = F, into = c("F.x", "F.y"), sep = "\\,")
cPoints <- separate(data = cPoints, col = G, into = c("G.x", "G.y"), sep = "\\,")

cPoints <- data.frame(lapply(cPoints, function(x) as.numeric(x)))

tabl <- cPoints
fWHRc <- NULL
#i = 28

for (i in seq_len(dim(tabl)[1])){
  #i = 8
  points <- matrix(c(c(tabl$C.x[i], tabl$D.x[i], tabl$E.x[i], tabl$F.x[i], tabl$G.x[i]), 
                     c(tabl$C.y[i], tabl$D.y[i], tabl$E.y[i], tabl$F.y[i], tabl$G.y[i]))
                   ,nrow = 5, ncol = 2)
  
  
  fWHRc[i] =   fWHR(points, i)
  
}


# Correlation
# Paired t-test

fWHRc = cbind(fWHRc, carmen)
fWHRc = fWHRc[-21,]

cor.test(fWHRc[,1], fWHRc[,2])
plot(fWHRc[,1], fWHRc[,2])
t.test(fWHRc[,1], fWHRc[,2], paired=TRUE)



### Comparing to Carmen's ratios

# Issue: Our measurements are not as far apart as hers.
# that is, points E and F should be further outside the chimp's face

# Steps to take:
# 1. Record points E & F
# 2. Subtract larger from smaller - this will be the width
# 3. This can now be directly compard with Carmen's measurements in "Chimp fWHR.xlsx"

xE = 345
yE = 876
xF = 900
yF = 800

euc.dist(c( xE , yE ) , c( xF , yF )) # <- Template

# Entries:

# Gon.20070620
xE = 269.3
yE = 68.7
xF = 356
yF = 69.3
# width = 86.7

# James20041102
xE = 224.7
yE = 92.7
xF = 400
yF = 88.7
# width = 175.34




########
#euc.dist <- function(x1, x2) sqrt(sum((x1 - x2) ^ 2))
euc.dist <- function(x1.1, x1.2, x2.1, x2.2) sqrt(sum((c(x1.1, x1.2) - c(x2.1, x2.2)) ^ 2))


df2fWHR <- function(yCh){
  
  #yCh = bCh[bCh$A!='X',c(2,14:20)]
  yCh = yCh[yCh$A!='X',c(2,14:20)]
  
  yCh <- separate(data = yCh, col = A, into = c("A.x", "A.y"), sep = "\\,")
  yCh <- separate(data = yCh, col = B, into = c("B.x", "B.y"), sep = "\\,")
  yCh <- separate(data = yCh, col = C, into = c("C.x", "C.y"), sep = "\\,")
  yCh <- separate(data = yCh, col = D, into = c("D.x", "D.y"), sep = "\\,")
  yCh <- separate(data = yCh, col = E, into = c("E.x", "E.y"), sep = "\\,")
  yCh <- separate(data = yCh, col = F, into = c("F.x", "F.y"), sep = "\\,")
  yCh <- separate(data = yCh, col = G, into = c("G.x", "G.y"), sep = "\\,")
  
  yCh[,2:15] <- data.frame(lapply(yCh[,2:15], function(x) as.numeric(x)))
  
  tabl <- yCh
  fWHRc <- data.frame(ID=factor(dim(yCh)[1]),ratio=numeric(dim(yCh)[1]))
  
  #fWHRc$ID = as.character(yCh$ID)
  fWHRc$ID = yCh$ID
  
  for (i in seq_len(dim(tabl)[1])){
    points <- matrix(c(c(tabl$C.x[i], tabl$D.x[i], tabl$E.x[i], tabl$F.x[i], tabl$G.x[i]), 
                       c(tabl$C.y[i], tabl$D.y[i], tabl$E.y[i], tabl$F.y[i], tabl$G.y[i]))
                     ,nrow = 5, ncol = 2)
    
    
    fWHRc$ratio[i] =   fWHR(points, i)
    
  }
  
  return(fWHRc)
  
}  



