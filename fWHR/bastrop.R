### Bastrop


bCh = cPoints[cPoints$location=='Bastrop',]
bCh = bCh[c(-1,-2),]

sample(bCh$ID,16)
# [1] Beta    Punch   Lexus   Austin  Dahpi   Minna   Michon  Xena    Alpha   Gremlin Bo     
# [12] Samson  Kampani Mahsho  Cheopi  Maishpa
sample(1:10,16, replace=T)
# [1]  2 10  8  4  2  4  4  2  5  9  4  6 10  7  5  5



# Are these ratings all okay?

bCh = bCh[bCh$A!='X',c(14:20)]

bCh <- separate(data = bCh, col = A, into = c("A.x", "A.y"), sep = "\\,")
bCh <- separate(data = bCh, col = B, into = c("B.x", "B.y"), sep = "\\,")
bCh <- separate(data = bCh, col = C, into = c("C.x", "C.y"), sep = "\\,")
bCh <- separate(data = bCh, col = D, into = c("D.x", "D.y"), sep = "\\,")
bCh <- separate(data = bCh, col = E, into = c("E.x", "E.y"), sep = "\\,")
bCh <- separate(data = bCh, col = F, into = c("F.x", "F.y"), sep = "\\,")
bCh <- separate(data = bCh, col = G, into = c("G.x", "G.y"), sep = "\\,")

bCh <- data.frame(lapply(bCh, function(x) as.numeric(x)))

tabl <- bCh
fWHRc <- NULL


for (i in seq_len(dim(tabl)[1])){
  points <- matrix(c(c(tabl$C.x[i], tabl$D.x[i], tabl$E.x[i], tabl$F.x[i], tabl$G.x[i]), 
                     c(tabl$C.y[i], tabl$D.y[i], tabl$E.y[i], tabl$F.y[i], tabl$G.y[i]))
                   ,nrow = 5, ncol = 2)
  
  
  fWHRc[i] =   fWHR(points, i)
  
}

# redos-
# definite: c(16, 24, 56, 60)
# possible: c(27, 28, 32, 44, 72, 74)
bCh$ID[c(27, 28, 32, 44, 72, 74)]



