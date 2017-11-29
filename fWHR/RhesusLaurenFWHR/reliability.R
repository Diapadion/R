library(tidyr)
library(alphahull)
library(psych)



# Import and process
reliabl <- read.csv("reliabilityRedos.csv")

reliabl <- separate(data = reliabl, col = A, into = c("A.x", "A.y"), sep = "\\,")
reliabl <- separate(data = reliabl, col = B, into = c("B.x", "B.y"), sep = "\\,")
reliabl <- separate(data = reliabl, col = C, into = c("C.x", "C.y"), sep = "\\,")
reliabl <- separate(data = reliabl, col = D, into = c("D.x", "D.y"), sep = "\\,")
reliabl <- separate(data = reliabl, col = E, into = c("E.x", "E.y"), sep = "\\,")
reliabl <- separate(data = reliabl, col = F, into = c("F.x", "F.y"), sep = "\\,")
reliabl <- separate(data = reliabl, col = G, into = c("G.x", "G.y"), sep = "\\,")

reliabl <- separate(data = reliabl, col = a, into = c("a.x", "a.y"), sep = "\\,")
reliabl <- separate(data = reliabl, col = b, into = c("b.x", "b.y"), sep = "\\,")
reliabl <- separate(data = reliabl, col = c, into = c("c.x", "c.y"), sep = "\\,")
reliabl <- separate(data = reliabl, col = d, into = c("d.x", "d.y"), sep = "\\,")
reliabl <- separate(data = reliabl, col = e, into = c("e.x", "e.y"), sep = "\\,")
reliabl <- separate(data = reliabl, col = f, into = c("f.x", "f.y"), sep = "\\,")
reliabl <- separate(data = reliabl, col = g, into = c("g.x", "g.y"), sep = "\\,")

reliabl[,c(2:30)] <- as.numeric(unlist(reliabl[,c(2:30)]))


# Make fWHR

reliabl$fWHR.a = NA
for (i in seq_len(dim(reliabl)[1])){
  points <- matrix(c(c(reliabl$C.x[i], reliabl$D.x[i], reliabl$E.x[i], reliabl$F.x[i], reliabl$G.x[i]), 
                     c(reliabl$C.y[i], reliabl$D.y[i], reliabl$E.y[i], reliabl$F.y[i], reliabl$G.y[i]))
                   ,nrow = 5, ncol = 2)
  
  reliabl$fWHR.a[i] = calcfWHR(points, i)
  
}

reliabl$fWHR.b = NA
for (i in seq_len(dim(reliabl)[1])){
  points <- matrix(c(c(reliabl$c.x[i], reliabl$d.x[i], reliabl$e.x[i], reliabl$f.x[i], reliabl$g.x[i]), 
                     c(reliabl$c.y[i], reliabl$d.y[i], reliabl$e.y[i], reliabl$f.y[i], reliabl$g.y[i]))
                   ,nrow = 5, ncol = 2)
  
  reliabl$fWHR.b[i] = calcfWHR(points, i)
  
}




# Make fLHFH

for (i in seq_len(dim(reliabl)[1])){
  reliabl$LFFH.a[i] = calcLFFH(c(reliabl$A.x[i],reliabl$A.y[i]),
                           c(reliabl$B.x[i],reliabl$B.y[i]),
                           c(reliabl$C.x[i],reliabl$C.y[i]),
                           c(reliabl$D.x[i],reliabl$D.y[i]))
}

for (i in seq_len(dim(reliabl)[1])){
  reliabl$LFFH.b[i] = calcLFFH(c(reliabl$a.x[i],reliabl$a.y[i]),
                               c(reliabl$b.x[i],reliabl$b.y[i]),
                               c(reliabl$c.x[i],reliabl$c.y[i]),
                               c(reliabl$d.x[i],reliabl$d.y[i]))
}




# Plotting

plot(reliabl$fWHR.a, reliabl$fWHR.b)
text(reliabl$fWHR.a, reliabl$fWHR.b, labels=reliabl$monkey, cex= 0.7)

plot(reliabl$LFFH.a, reliabl$LFFH.b)
text(reliabl$LFFH.a, reliabl$LFFH.b, labels=reliabl$monkey, cex= 0.7)



# Calculate reliabilities

ICC(reliabl)


cor(reliabl$fWHR.a, reliabl$fWHR.b)
cor(reliabl$LFFH.a, reliabl$LFFH.b)

alpha(reliabl[,c("fWHR.a","fWHR.b")])
alpha(reliabl[,c("LFFH.a","LFFH.b")])

