####### Chimp faces #######

library(alphahull)
library(tidyr)

### TO MEASURE:
#
# - Yerkes
# - Bastrop?
# - sub-sample of Japan & Edi chimps
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


cPoints = read.csv(file = "ChimpfWHR.csv")

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
xE = 
yE = 
xF = 
yF = 
# width = 



########
euc.dist <- function(x1, x2) sqrt(sum((x1 - x2) ^ 2))

