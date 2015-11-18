#setwd("/Users/drew/Dropbox/R/personality")
setwd("/Users/s1229179/git-repos/R/personality")

pers <- NULL

pers <- array(,dim=c(9,12,54))
#12 for Greg



for(i in 1:9){
	surveyIn <- read.xls("MPTA - Alex.xls",sheet=i,verbose=FALSE,'ADJECTIVE',method="tab")
	attach(surveyIn)
	srt <- surveyIn[order(ADJECTIVE,decreasing=FALSE),]
	pers[i,1,] <- srt[,2][2:55]
	detach(surveyIn)
}

for(i in 1:9){
	surveyIn <- read.xls("MPTA - Bayo.xls",sheet=i,verbose=FALSE,'ADJECTIVE',method="tab")
	attach(surveyIn)
	srt <- surveyIn[order(ADJECTIVE,decreasing=FALSE),]
	pers[i,2,] <- srt[,2][2:55]
	detach(surveyIn)
}

for(i in 1:9){
	surveyIn <- read.xls("MPTA - Dakota.xls",sheet=i,verbose=FALSE,'ADJECTIVE',method="tab")
	attach(surveyIn)
	srt <- surveyIn[order(ADJECTIVE,decreasing=FALSE),]
	pers[i,3,] <- srt[,2][2:55]
	detach(surveyIn)
}

for(i in 1:9){
	surveyIn <- read.xls("MPTA - Daniel.xls",sheet=i,verbose=FALSE,'ADJECTIVE',method="tab")
	attach(surveyIn)
	srt <- surveyIn[order(ADJECTIVE,decreasing=FALSE),]
	pers[i,4,] <- srt[,2][2:55]
	detach(surveyIn)
}

for(i in 1:9){
	surveyIn <- read.xls("MPTA - Drew.xls",sheet=i,verbose=FALSE,'ADJECTIVE',method="tab")
	attach(surveyIn)
	srt <- surveyIn[order(ADJECTIVE,decreasing=FALSE),]
	pers[i,5,] <- srt[,2][2:55]
	detach(surveyIn)
}

for(i in 1:9){
	surveyIn <- read.xls("MPTA - Dylan.xls",sheet=i,verbose=FALSE,'ADJECTIVE',method="tab")
	attach(surveyIn)
	srt <- surveyIn[order(ADJECTIVE,decreasing=FALSE),]
	pers[i,6,] <- srt[,2][2:55]
	detach(surveyIn)
}

for(i in 1:9){
	surveyIn <- read.xls("MPTA - Ema.xls",sheet=i,verbose=FALSE,'ADJECTIVE',method="tab")
	attach(surveyIn)
	srt <- surveyIn[order(ADJECTIVE,decreasing=FALSE),]
	pers[i,7,] <- srt[,2][2:55]
	detach(surveyIn)
}

for(i in 1:9){
	surveyIn <- read.xls("MPTA - Farhana.xls",sheet=i,verbose=FALSE,'ADJECTIVE',method="tab")
	attach(surveyIn)
	srt <- surveyIn[order(ADJECTIVE,decreasing=FALSE),]
	pers[i,8,] <- srt[,2][2:55]
	detach(surveyIn)
}

for(i in 1:9){
	surveyIn <- read.xls("MPTA - Rachelle.xls",sheet=i,verbose=FALSE,'ADJECTIVE',method="tab")
	attach(surveyIn)
	srt <- surveyIn[order(ADJECTIVE,decreasing=FALSE),]
	pers[i,9,] <- srt[,2][2:55]
	detach(surveyIn)
}

for(i in 1:9){
	surveyIn <- read.xls("MPTA - Sally.xls",sheet=i,verbose=FALSE,'ADJECTIVE',method="tab")
	attach(surveyIn)
	srt <- surveyIn[order(ADJECTIVE,decreasing=FALSE),]
	pers[i,10,] <- srt[,2][2:55]
	detach(surveyIn)
}

for(i in 1:9){
	surveyIn <- read.xls("MPTA - Shangshang.xls",sheet=i,verbose=FALSE,'ADJECTIVE',method="tab")
	attach(surveyIn)
	srt <- surveyIn[order(ADJECTIVE,decreasing=FALSE),]
	pers[i,11,] <- srt[,2][2:55]
	detach(surveyIn)
}

for(i in 1:9){
	surveyIn <- read.xls("MPTA - Greg.xls",sheet=i,verbose=FALSE,'ADJECTIVE',method="tab")
	attach(surveyIn)
	srt <- surveyIn[order(ADJECTIVE,decreasing=FALSE),]
	pers[i,12,] <- srt[,2][2:55]
	detach(surveyIn)
}


### remove certain raters

trimp = pers[,c(1:4,6:11),]
##trimp = trimp[,,-c(5,53)] # take out autistic and unperceptive

# colname tracking
srt <- srt$ADJECTIVE[2:55]
##srt <- srt[-c(5,53)]

### Intraclass correlation
library(psych)
icc3 <- NULL
for (i in 1:54){
  icc3[i] =  ICC(trimp[,,i])$results
}

ICC(trimp[,,4])
ticc = ICC(trimp[,,1])
ticc$results$
  
# just checking on Autistic and Unperceptive
icc3[6]
  
  
## potential problems (some estimates and confint below 0):
# 2 - affectionate
# 4 - anxious
# 7 - clumsy
# 15 - disorganzied
# 24 - imitative
# 33 - jealous
# 39 - protective
# 42 - sensitive
# 48 - sympathetic
# 49 - thoughtless
  
## definite problems:
# 6 - cautious
# 12 - defiant
# 26 - independent
# 46 - stingy / greedy

trimp = trimp[,,-c(6,12,26,46)]  # remove only the definite problems

srt <- srt[-c(6,12,26,46)]

# so we've taken out Autistic, Unperceptive, Cautious (Cnf), Defiant(Dom), 
# Independent(Dom), and Stingy/Greedy(Dom)

#3,1 ; 3,k
1) 0.25, 0.77
2) 0.03, 0.21
3) 0.159, 0.655
4) 0.193, 0.165
5) 0.086, 0.486
6) .0264, .2135
7) .12, .57
8) .14, .63
9) .26, .78
10) .22, .74
11) .115, .565
12) .26, .78
13) .034, .262
14) .067, .417
15) .14, .63
16) .17, .67
17) .27, .79
18) .139, .617
19) .090, .496
20) .090, .498
21) .124, .586
22) .010, .094
23) .024, .194
24) .078, .459
25) .22, .74
26) .058, .380
27) .23, .75
28) .12, .57
29) .078, .457
30) .041, .300
31) .29, .80
32) .082, .473
33) .20, .72
34) .063, .400
35) .022, .186
36) .046, .325
37) .106, .542
38) .095, .512
39) .025, .212
40) .11, .56
41) .28, .80
42) .094, .511
43) .109, .551
44) .014, .127
45) .009, .079
46) .25, .77
47) .22, .73
48) .17, .67











