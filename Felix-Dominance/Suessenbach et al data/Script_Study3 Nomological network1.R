############
#R Script for Suessenbach et al. Study 3

#Packages needed for this R script
library(psych)
library(rsq)
library(lavaan)
library(semTools)
library(semPlot)

#Read in dataframe
data3 <- read.csv(file = "sample1.csv", header = T)

names(data3)


#############
#Exclusion of participants

#Excluding participants that have wrongly answered to both of our catch questions. This is the default and so reported in the manuscript
data3 <- data3[data3$catch1 == "keep" & data3$catch2 == "keep",]

#To keep all participants who answered wrongly to catch question 1 please do not execute line #19
#but remove the hashtag at the beginning of line #25 and execute line #25 
#data3 <- data3[data3$catch2 == "keep",]

#To keep all participants who answered wrongly to catch question 2 please do not execute line #19
#but remove the hashtag at the beginning of line #29 and execute line #29 
#data3 <- data3[data3$catch1 == "keep",]

#To keep all participants who answered wrongly to catch question 1 & 2 please do not execute line #19 and continue this
#script from this point onwards





#############
#Study 3: Nomological net. ALLL VARIABLES need to be named dominance6 etc.!!!


###
#Correlation matrix

c1 <- corr.test(data3[c("BFI_A","BFI_E","BFI_N","BFI_O","BFI_C","NARQ_A","NARQ_R","SDO",
                        "affiliation","achievement","intimacy","FoLC","FoLR",
                       "v.agression","anger","altruism","porn","leadingpos")], 
                data3[c("dominance6","prestige6","leadership6")])
print(c1, short = FALSE)

#Just for males. Table in SOM
cm <- corr.test(data3[data3$gender == "male",c("BFI_A","BFI_E","BFI_N","BFI_O","BFI_C","NARQ_A","NARQ_R","SDO",
                        "affiliation","achievement","intimacy","FoLC","FoLR",
                        "v.agression","anger","altruism","porn","leadingpos")], 
                data3[data3$gender == "male",c("dominance6","prestige6","leadership6")])
cm

#Just for females. Table in SOM
cf <- corr.test(data3[data3$gender == "female",c("BFI_A","BFI_E","BFI_N","BFI_O","BFI_C","NARQ_A","NARQ_R","SDO",
                                               "affiliation","achievement","intimacy","FoLC","FoLR",
                                               "v.agression","anger","altruism","porn","leadingpos")], 
                data3[data3$gender == "female",c("dominance6","prestige6","leadership6")])
cf




###
#Regression analyses

bfia <- lm(scale(BFI_A) ~ scale(dominance6) + scale(prestige6) + scale(leadership6), data = data3)
summary(bfia)

bfie <- lm(scale(BFI_E) ~ scale(dominance6) + scale(prestige6) + scale(leadership6), data = data3)
summary(bfie)

bfin <- lm(scale(BFI_N) ~ scale(dominance6) + scale(prestige6) + scale(leadership6), data = data3)
summary(bfin)

bfio <- lm(scale(BFI_O) ~ scale(dominance6) + scale(prestige6) + scale(leadership6), data = data3)
summary(bfio)

bfic <- lm(scale(BFI_C) ~ scale(dominance6) + scale(prestige6) + scale(leadership6), data = data3)
summary(bfic)

narqa <- lm(scale(NARQ_A) ~ scale(dominance6) + scale(prestige6) + scale(leadership6), data = data3)
summary(narqa)

narqr <- lm(scale(NARQ_R) ~ scale(dominance6) + scale(prestige6) + scale(leadership6), data = data3)
summary(narqr)

sdo <- lm(scale(SDO) ~ scale(dominance6) + scale(prestige6) + scale(leadership6), data = data3)
summary(sdo)

aff <- lm(scale(affiliation) ~ scale(dominance6) + scale(prestige6) + scale(leadership6), data = data3)
summary(aff)

ach <- lm(scale(achievement) ~ scale(dominance6) + scale(prestige6) + scale(leadership6), data = data3)
summary(ach)

int <- lm(scale(intimacy) ~ scale(dominance6) + scale(prestige6) + scale(leadership6), data = data3)
summary(int)

folc <- lm(scale(FoLC) ~ scale(dominance6) + scale(prestige6) + scale(leadership6), data = data3)
summary(folc)

folr <- lm(scale(FoLR) ~ scale(dominance6) + scale(prestige6) + scale(leadership6), data = data3)
summary(folr)

vagg <- lm(scale(v.agression) ~ scale(dominance6) + scale(prestige6) + scale(leadership6), data = data3)
summary(vagg)

ang <- lm(scale(anger) ~ scale(dominance6) + scale(prestige6) + scale(leadership6), data = data3)
summary(ang)

alt <- lm(scale(altruism) ~ scale(dominance6) + scale(prestige6) + scale(leadership6), data = data3)
summary(alt)

porn <- lm(scale(porn) ~ scale(dominance6) + scale(prestige6) + scale(leadership6), data = data3)
summary(porn)

leadmodel <- glm(leadingpos ~ scale(dominance6) + scale(prestige6) + scale(leadership6), data = data3, family = 'quasipoisson')
summary(leadmodel)

rsq(leadmodel)


round(summary(leadmodel)$coefficients[,4]*18,3)







#####################
#SEM models of nomological network variables 

#DoPL and UMS motives
modelUMS <- ' 
# latent variable definitions
Dom  =~ X13 + X20 + X32 + X33 + X54 + X16
Pres =~ X26 + X30 + X45 + X69 + X77 + X23
Lead =~ X5 + X25 + X34 + X47 + X50 + X58
Ach  =~ X2 + X22 + X63 + X65 + X70 + X72 + X75 + X76 + X78 + X80
Aff  =~ X7 + X9 + X11 + X18 + X24 + X28 + X41 + X55 + X73 + X74
Int  =~ X14 + X31 + X35 + X38 + X44 + X48 + X59 + X82 + X84 + X85
FoLC =~ X4 + X21 + X57
FolR =~ X49 + X62 

# General =~ X13 + X20 + X32 + X33 + X54 + X16 + X26 + X30 + X45 + X69 + X77 + X23 + X5 + X25 + X34 + X47 + X50 + X58  
# 
# #Remove covariances among latent variables
# Dom ~~ 0*Pres
# Dom ~~ 0*Lead
# Dom ~~ 0*General
# 
# Pres ~~ 0*Lead
# Pres ~~ 0*General
# 
# Lead ~~ 0*General
'


cfa2 <- cfa(modelUMS, data=datpow2, )

fitMeasures(cfa2, c("chisq", "df", "pvalue", "cfi", "rmsea", 'srmr'))
summary(cfa2, fit.measures = TRUE)
semPaths(cfa2, what="std", layout = "spring", structural = T, edge.label.cex = 1) 


#DoPL and Big 5
modelBIG5 <- ' 
# latent variable definitions
Dom  =~ X13 + X20 + X32 + X33 + X54 + X16
Pres =~ X26 + X30 + X45 + X69 + X77 + X23
Lead =~ X5 + X25 + X34 + X47 + X50 + X58
O =~ BFI_O_X4 + BFI_O_X17 
C =~ BFI_C_X9 + BFI_C_X13
E =~ BFI_E_X7 + BFI_E_X11
A =~ BFI_A_X1 + BFI_A_X3 + BFI_A_X5 + BFI_A_X6 + BFI_A_X8 + BFI_A_X10 + BFI_A_X12 + BFI_A_X14 + BFI_A_X16
N =~ BFI_N_X2 + BFI_N_X15
'

cfa2 <- cfa(modelBIG5, data=datpow2, )
summary(cfa2, fit.measures = TRUE)
semPaths(cfa2, what="std", layout = "spring", structural = T, edge.label.cex = 1) 



#DoPL and narcissim & SDO
modelNARQ <- ' 
# latent variable definitions
Dom  =~ X13 + X20 + X32 + X33 + X54 + X16
Pres =~ X26 + X30 + X45 + X69 + X77 + X23
Lead =~ X5 + X25 + X34 + X47 + X50 + X58
NARQ_A =~ NARQ_A_X1 + NARQ_A_X4 + NARQ_A_X6 + NARQ_A_X8 + NARQ_A_X10 + NARQ_A_X12 + NARQ_A_X13 + NARQ_A_X15 + NARQ_A_X17
NARQ_R =~ NARQ_R_X2 + NARQ_R_X3 + NARQ_R_X5 + NARQ_R_X7 + NARQ_R_X9 + NARQ_R_X11 + NARQ_R_X14 + NARQ_R_X16 + NARQ_R_X18
SDO =~ SDO_X1 + SDO_X2 + SDO_X3 + SDO_X4 + SDO_X5 + SDO_X6 + SDO_X7 + SDO_X8

General =~ X13 + X20 + X32 + X33 + X54 + X16 + X26 + X30 + X45 + X69 + X77 + X23 + X5 + X25 + X34 + X47 + X50 + X58

#Remove covariances among latent variables
Dom ~~ 0*Pres
Dom ~~ 0*Lead
Dom ~~ 0*General

Pres ~~ 0*Lead
Pres ~~ 0*General

Lead ~~ 0*General
'

cfa2 <- cfa(modelNARQ, data=datpow2, )

fitMeasures(cfa2, c("chisq", "df", "pvalue", "cfi", "rmsea", 'srmr'))
summary(cfa2, fit.measures = TRUE)
semPaths(cfa2, what="std", layout = "spring", structural = T, edge.label.cex = 1) 


#DoPL and self-reported behaviour
modelB <- ' 
# latent variable definitions
Dom  =~ X13 + X20 + X32 + X33 + X54 + X16
Pres =~ X26 + X30 + X45 + X69 + X77 + X23
Lead =~ X5 + X25 + X34 + X47 + X50 + X58
anger =~ ANG_X2 + ANG_X3 + ANG_X5 + ANG_X6 + ANG_X7 + ANG_X10 + ANG_X12
agg =~ VERBA_X1 + VERBA_X4 + VERBA_X8 + VERBA_X9 + VERBA_X11
helping =~ ALT_X1 + ALT_X2 + ALT_X3 + ALT_X4 + ALT_X5 + ALT_X6 + ALT_X7 + ALT_X8 + ALT_X9 + ALT_X10 + ALT_X11 + ALT_X12 + ALT_X13 + ALT_X15
'

cfa2 <- cfa(modelB, data=datpow2, )
summary(cfa2, fit.measures = TRUE)
semPaths(cfa2, what="std", layout = "spring", structural = T, edge.label.cex = 1, edge.label.position = 0.2) 



