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
library(readxl)
library(tidyr)



df.cats <- read_xlsx('Cat_facial_points.xlsx')
df.cat.p <- read_xlsx('Personality(2017-11-12).xlsx')

df.cats <- separate(data = df.cats, col = A, into = c("A.x", "A.y"), sep = "\\,")
df.cats <- separate(data = df.cats, col = B, into = c("B.x", "B.y"), sep = "\\,")
df.cats <- separate(data = df.cats, col = C, into = c("C.x", "C.y"), sep = "\\,")
df.cats <- separate(data = df.cats, col = D, into = c("D.x", "D.y"), sep = "\\,")
df.cats <- separate(data = df.cats, col = E, into = c("E.x", "E.y"), sep = "\\,")

df.cats[df.cats=='NA'] = NA

# head(unlist(df.cats[,c(6:15)]))
# df.cats[,c(6:15)] <- as.numeric(unlist(df.cats[,c(6:15)]))

df.cats[,c(6:15)] <- lapply(df.cats[,c(6:15)], as.numeric)

head(sapply(df.cats[,c(6:15)], as.numeric))



tabl <- df.cats
tabl = tabl[!is.na(tabl$C.y),]
fWHR <- NULL
#i = 28

#for (i in seq_len(dim(tabl)[1])){
for (i in 1:84){ 
  points <- matrix(c(c(tabl$A.x[i], tabl$B.x[i], tabl$C.x[i], tabl$D.x[i], tabl$E.x[i]), 
                     c(tabl$A.y[i], tabl$B.y[i], tabl$C.y[i], tabl$D.y[i], tabl$E.y[i]))
                   ,nrow = 5, ncol = 2)
  
  
  fWHR[i] =   calcfWHR(points, i)
  
}
# 08-02-2020 - Problem faces:
# 169, 146?, 139? |84| 77?, 73?, 36, 30?, 19, 13  
chk1 = c(169, 146, 139, 77, 73, 36, 30, 19, 13)
chk2 = c(169, 36, 19, 13)

tabl[chk2,c('Unique Identifier','Photo name')]
write.csv(tabl[chk1,c('Unique Identifier','Photo name')], 'Redo1cats.csv')


## "Final" check
#redone1 <- read_xls("./Redo1cats.xls")
redone1 <- read_xls("./Redo1cats-fix2.xls")

redone1 <- separate(data = redone1, col = A, into = c("A.x", "A.y"), sep = "\\,")
redone1 <- separate(data = redone1, col = B, into = c("B.x", "B.y"), sep = "\\,")
redone1 <- separate(data = redone1, col = C, into = c("C.x", "C.y"), sep = "\\,")
redone1 <- separate(data = redone1, col = D, into = c("D.x", "D.y"), sep = "\\,")
redone1 <- separate(data = redone1, col = E, into = c("E.x", "E.y"), sep = "\\,")

redone1[,c(4:13)] <- lapply(redone1[,c(4:13)], as.numeric)

fWHRedo <- NULL
#i = 28

#for (i in seq_len(dim(tabl)[1])){
for (i in 1:10){ 
  points <- matrix(c(c(redone1$A.x[i], redone1$B.x[i], redone1$C.x[i], redone1$D.x[i], redone1$E.x[i]), 
                     c(redone1$A.y[i], redone1$B.y[i], redone1$C.y[i], redone1$D.y[i], redone1$E.y[i]))
                   ,nrow = 5, ncol = 2)
  
  
  fWHRedo[i] =   calcfWHR(points, i)
  
}



## Second rater
rater2 <- read_xlsx("./CatImages_RepeatMeasure.xlsx")

rater2 <- separate(data = rater2, col = A, into = c("A.x", "A.y"), sep = "\\,")
rater2 <- separate(data = rater2, col = B, into = c("B.x", "B.y"), sep = "\\,")
rater2 <- separate(data = rater2, col = C, into = c("C.x", "C.y"), sep = "\\,")
rater2 <- separate(data = rater2, col = D, into = c("D.x", "D.y"), sep = "\\,")
rater2 <- separate(data = rater2, col = E, into = c("E.x", "E.y"), sep = "\\,")

rater2[,c(2:11)] <- lapply(rater2[,c(2:11)], as.numeric)

fWHRater2 <- NULL
#i = 28

#for (i in seq_len(dim(tabl)[1])){
for (i in 1:10){ 
  points <- matrix(c(c(rater2$A.x[i], rater2$B.x[i], rater2$C.x[i], rater2$D.x[i], rater2$E.x[i]), 
                     c(rater2$A.y[i], rater2$B.y[i], rater2$C.y[i], rater2$D.y[i], rater2$E.y[i]))
                   ,nrow = 5, ncol = 2)
  
  
  fWHRedo[i] =   calcfWHR(points, i)
  
}







### Personality checks
library(lavaan)

colnames(df.cat.p)[19:64] = c('Active','Anxious','Bold','Bullying','Calm','Clumsy','Constrained',
                              'Cool','Cooperative','Curious','Decisive','Defiant','Deliberate',
                              'Distractible','Dominant','Eccentric','Erratic','Excitable','Fearful',
                              'Friendly','Gentle','Impulsive','Indep','Indiv','Inq','Insecure',
                              'Invent','Irrit','Jealous','Persever','Playful','Predict','Quit','Reck',
                              'Selfassured','Smart','Solitary','Stable','Stingy','Subm','Sus',
                              'Tense','Timid','Trust','Vigil','Vocal'
                              )

m.cat.D <-'
D =~ Dominant + Bullying + Subm + Cooperative #+ Gentle + Stingy + Jealous + Defiant

'



f.cat.D = cfa(m.cat.D, df.cat.p)

fitMeasures(f.cat.D, c("chisq", "df", "pvalue", "cfi", "rmsea", "srmr"))

summary(f.cat.D)





### OLD PRIMATE CODE ###


### OHSU PRC

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


## OHSU batch 2

dfOHSU2 <- read.csv("ORmacaq2.csv", header=T)
dfOHSU2 <- dfOHSU2[dfOHSU2$A != '?',]

dfOHSU2 <- separate(data = dfOHSU2, col = A, into = c("A.x", "A.y"), sep = "\\,")
dfOHSU2 <- separate(data = dfOHSU2, col = B, into = c("B.x", "B.y"), sep = "\\,")
dfOHSU2 <- separate(data = dfOHSU2, col = C, into = c("C.x", "C.y"), sep = "\\,")
dfOHSU2 <- separate(data = dfOHSU2, col = D, into = c("D.x", "D.y"), sep = "\\,")
dfOHSU2 <- separate(data = dfOHSU2, col = E, into = c("E.x", "E.y"), sep = "\\,")
dfOHSU2 <- separate(data = dfOHSU2, col = F, into = c("F.x", "F.y"), sep = "\\,")
dfOHSU2 <- separate(data = dfOHSU2, col = G, into = c("G.x", "G.y"), sep = "\\,")

dfOHSU2[,c(2:15)] <- as.numeric(unlist(dfOHSU2[,c(2:15)]))

rownames(dfOHSU2) <- NULL

fWHR.OHSU2 <- NULL

for (i in seq_len(dim(dfOHSU2)[1])){

  
  #i = 38
  points <- matrix(c(c(dfOHSU2$C.x[i], dfOHSU2$D.x[i], dfOHSU2$E.x[i], dfOHSU2$F.x[i], dfOHSU2$G.x[i]), 
                     c(dfOHSU2$C.y[i], dfOHSU2$D.y[i], dfOHSU2$E.y[i], dfOHSU2$F.y[i], dfOHSU2$G.y[i]))
                   ,nrow = 5, ncol = 2)
  
  
  fWHR.OHSU2[i] =   fWHR(points, i)
  
}

# REDO:
# 26596



### Davis CA PRC

df.CA <- read.csv("CAmacaq1-2.csv", header=T)

df.CA <- df.CA[df.CA$A != 'X',]

#test <- data.frame(do.call('rbind', strsplit(as.character(dfOHSU1$A),',',fixed=TRUE)))

df.CA <- separate(data = df.CA, col = A, into = c("A.x", "A.y"), sep = "\\,")
df.CA <- separate(data = df.CA, col = B, into = c("B.x", "B.y"), sep = "\\,")
df.CA <- separate(data = df.CA, col = C, into = c("C.x", "C.y"), sep = "\\,")
df.CA <- separate(data = df.CA, col = D, into = c("D.x", "D.y"), sep = "\\,")
df.CA <- separate(data = df.CA, col = E, into = c("E.x", "E.y"), sep = "\\,")
df.CA <- separate(data = df.CA, col = F, into = c("F.x", "F.y"), sep = "\\,")
df.CA <- separate(data = df.CA, col = G, into = c("G.x", "G.y"), sep = "\\,")

df.CA[,c(2:15)] <- as.numeric(unlist(df.CA[,c(2:15)]))

rownames(df.CA) <- NULL

fWHR.CA <- NULL
#i = 28

#for (i in seq_len(dim(df.CA)[1])){
for (i in 59:124){

  #i = 38
  points <- matrix(c(c(df.CA$C.x[i], df.CA$D.x[i], df.CA$E.x[i], df.CA$F.x[i], df.CA$G.x[i]), 
                     c(df.CA$C.y[i], df.CA$D.y[i], df.CA$E.y[i], df.CA$F.y[i], df.CA$G.y[i]))
                   ,nrow = 5, ncol = 2)
  
  
  fWHR.CA[i] =   fWHR(points, i)
  
}



# REDO:
# Squishy6538
# Springfield6518
# Kwik6574
# Bart6595
# Topher6880
# Hayden6903
# Estrella6888
# Estrella6887
# 
# Questionable:
# Topher6884
# Estrella6886

# Another 10:

sample(df.CA$monkey..photo.id, 10)
# Kyra6521
# Cecil6952
# Hazel7001
# Maggie6599
# Sherri6548
# Veicht6839
# Vermouth6733
# Sourpatch6894
# Crabapple6584
# Obscure6832



