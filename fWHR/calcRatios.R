# importing and processing the spreadsheets of points (A-H)

# based on the first OHSU macaque photos:
#
# A is Middle of the brows, where it meets the hairline
# B is Bottom of chin
# C is Top of left eye
# D is Top of the right eye
# E is Left edge of the face
# F is Right edge of the face
# G is Top of the lip

library(alphahull)
library(tidyr)


dfOHSU1 <- read.csv("ORmacaq1.csv", header=T)

#test <- data.frame(do.call('rbind', strsplit(as.character(dfOHSU1$A),',',fixed=TRUE)))

dfOHSU1 <- separate(data = dfOHSU1, col = A, into = c("A.x", "A.y"), sep = "\\,")
dfOHSU1 <- separate(data = dfOHSU1, col = B, into = c("B.x", "B.y"), sep = "\\,")
dfOHSU1 <- separate(data = dfOHSU1, col = C, into = c("C.x", "C.y"), sep = "\\,")
dfOHSU1 <- separate(data = dfOHSU1, col = D, into = c("D.x", "D.y"), sep = "\\,")
dfOHSU1 <- separate(data = dfOHSU1, col = E, into = c("E.x", "E.y"), sep = "\\,")
dfOHSU1 <- separate(data = dfOHSU1, col = F, into = c("F.x", "F.y"), sep = "\\,")
dfOHSU1 <- separate(data = dfOHSU1, col = G, into = c("G.x", "G.y"), sep = "\\,")

dfOHSU1[,c(2:15)] <- as.numeric(unlist(dfOHSU1[,c(2:15)]))

tabl <- dfOHSU1
fWHR1 <- NULL
#i = 28

for (i in seq_len(dim(tabl)[1])){
  #i = 38
  points <- matrix(c(c(tabl$C.x[i], tabl$D.x[i], tabl$E.x[i], tabl$F.x[i], tabl$G.x[i]), 
                     c(tabl$C.y[i], tabl$D.y[i], tabl$E.y[i], tabl$F.y[i], tabl$G.y[i]))
                     ,nrow = 5, ncol = 2)
  
  
  fWHR1[i] =   fWHR(points, i)
  
}

# There appear to be some problems. Are these points not always in the right order?

# [28] bobby05228 seems to have some points placed incorrectly, 
# as well as having the crossbar not drawn in the right place

# redo these faces as something seems wrong with the first measures:
# Ramsay05178
# Dougal05056
# Bobby05228
# BJ05023

