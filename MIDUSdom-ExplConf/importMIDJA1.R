library(Hmisc)
#library(SAScii)
library(data.table)



# setwd("M:/MIDJA/DS0001/")
# 
# midja1 <- read.SAScii('30822-0001-Data.txt','30822-0001-Setup.sas')
# 
# saveRDS(midja1, "midja1.Rda")

#midja1 <- readRDS('midja1.Rda')



midja1$J1SG6A[midja1$J1SG6A==8] <- NA
midja1$J1SG6B[midja1$J1SG6B==8] <- NA
midja1$J1SG6C[midja1$J1SG6C==8] <- NA
midja1$J1SG6D[midja1$J1SG6D==8] <- NA
midja1$J1SG6E[midja1$J1SG6E==8] <- NA
midja1$J1SG6F[midja1$J1SG6F==8] <- NA
midja1$J1SG6G[midja1$J1SG6G==8] <- NA
midja1$J1SG6H[midja1$J1SG6H==8] <- NA
midja1$J1SG6I[midja1$J1SG6I==8] <- NA
midja1$J1SG6J[midja1$J1SG6J==8] <- NA
midja1$J1SG6K[midja1$J1SG6K==8] <- NA
midja1$J1SG6L[midja1$J1SG6L==8] <- NA
midja1$J1SG6M[midja1$J1SG6M==8] <- NA
midja1$J1SG6N[midja1$J1SG6N==8] <- NA
midja1$J1SG6O[midja1$J1SG6O==8] <- NA
midja1$J1SG6P[midja1$J1SG6P==8] <- NA
midja1$J1SG6Q[midja1$J1SG6Q==8] <- NA
midja1$J1SG6R[midja1$J1SG6R==8] <- NA
midja1$J1SG6S[midja1$J1SG6S==8] <- NA
midja1$J1SG6T[midja1$J1SG6T==8] <- NA
midja1$J1SG6U[midja1$J1SG6U==8] <- NA
midja1$J1SG6V[midja1$J1SG6V==8] <- NA
midja1$J1SG6W[midja1$J1SG6W==8] <- NA
midja1$J1SG6X[midja1$J1SG6X==8] <- NA
midja1$J1SG6Y[midja1$J1SG6Y==8] <- NA
midja1$J1SG6Z[midja1$J1SG6Z==8] <- NA
midja1$J1SG6AA[midja1$J1SG6AA==8] <- NA
midja1$J1SG6BB[midja1$J1SG6BB==8] <- NA
midja1$J1SG6CC[midja1$J1SG6CC==8] <- NA
midja1$J1SG6DD[midja1$J1SG6DD==8] <- NA



vars= c('MIDJA_IDS',
# Personality items
'J1SG6A','J1SG6B','J1SG6C','J1SG6D','J1SG6E','J1SG6F','J1SG6G','J1SG6H','J1SG6I','J1SG6J',
'J1SG6K','J1SG6L','J1SG6M','J1SG6N','J1SG6O','J1SG6P','J1SG6Q','J1SG6R','J1SG6S','J1SG6T',
'J1SG6U','J1SG6V','J1SG6W','J1SG6X','J1SG6Y','J1SG6Z','J1SG6AA','J1SG6BB','J1SG6CC','J1SG6DD'
)


newnames =  c('MIDJA_IDS', 'Outgoing','Helpful','Moody','Organized','Selfconfident','Friendly','Warm','Worrying',
'Responsible','Forceful','Lively','Caring','Nervous','Creative','Assertive','Hardworking',
'Imaginative','Softhearted','Calm','Outspoken','Intelligent','Curious','Active','Careless',
'Broadminded','Sympathetic','Talkative','Sophisticated','Adventurous','Dominant'
)

setnames(midja1,vars,newnames)



