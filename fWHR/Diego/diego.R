library(tidyr)
library(alphahull)


setwd('../Diego')

diego = read.csv('Diego.csv')



diego <- separate(data = diego, col = a, into = c("a.x", "a.y"), sep = "\\,")
diego <- separate(data = diego, col = b, into = c("b.x", "b.y"), sep = "\\,")
diego <- separate(data = diego, col = c, into = c("c.x", "c.y"), sep = "\\,")
diego <- separate(data = diego, col = d, into = c("d.x", "d.y"), sep = "\\,")
diego <- separate(data = diego, col = e, into = c("e.x", "e.y"), sep = "\\,")
diego <- separate(data = diego, col = f, into = c("f.x", "f.y"), sep = "\\,")
diego <- separate(data = diego, col = g, into = c("g.x", "g.y"), sep = "\\,")

diego[,c(2:15)] <- as.numeric(unlist(diego[,c(2:15)]))



### fWHR

diego$fWHR.a = NA
for (i in seq_len(dim(diego)[1])){
  points <- matrix(c(c(diego$c.x[i], diego$d.x[i], diego$e.x[i], diego$f.x[i], diego$g.x[i]), 
                     c(diego$c.y[i], diego$d.y[i], diego$e.y[i], diego$f.y[i], diego$g.y[i]))
                   ,nrow = 5, ncol = 2)
  
  diego$fWHR.a[i] = calcfWHR(points, i)
  
}



### LF/FH

i = 0
for (i in (1:dim(diego)[1])){
  diego$lower.face[i] = euc.dist(diego$b.x[i],diego$b.y[i],diego$g.x[i],diego$g.y[i])
  
}

i = 0
for (i in (1:dim(diego)[1])){
  diego$face.height[i] = euc.dist(diego$b.x[i],diego$b.y[i],diego$a.x[i],diego$a.y[i])
  
}

diego$lffh = (diego$lower.face)/(diego$face.height)

head(diego$lffh)



write.csv(diego, 'diego-measures.csv')







### Functions ###

euc.dist <- function(x1.1, x1.2, x2.1, x2.2) sqrt(sum((c(x1.1, x1.2) - c(x2.1, x2.2)) ^ 2))
