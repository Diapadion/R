# install.packages("QuantPsyc")
require("QuantPsyc")
require("aod"); require("car"); require("doBy"); require("gdata") # to read in xls files
require("ggplot2")
library("visreg") # (for anova plots)

# ========================
# = Paper 2: Personality =
# ========================
# Several measures of the face known.
# Among these, fWHR is related to dominance [cite paper 1]
# Two hypotheses
# 1. Is this associated with one or more personality traits?
# 2. Does some other measure of the face relate to personality?

# Read in data set
fWHR <- gdata::read.xls("~/Dropbox/shared folders/Blake/data/Capuchin_fWHR.xlsx")
# OR if dropbox is open
fWHR <- gdata::read.xls("Capuchin_fWHR.xlsx")
# rename DominanceZ to Dominance
fWHR <- plyr::rename(fWHR, replace=c("DominanceZ" = "Dominance")) 

# ===========
# = Results =
# ===========

# ============
# = Subjects =
# ============
doBy::summaryBy(Age ~ Sex, data = fWHR, FUN = function(x){c(n= length(x), mean = round(mean(x),2), sd = round(sd(x),1), min=min(x), max=max(x)) })
#      Sex Age.n Age.mean Age.sd Age.min Age.max
# 1 female    29    12.97   10.1       2      40
# 2   male    35     9.09    8.7       2      38

doBy::summaryBy(Age ~ Sex+set, data = fWHR, FUN = function(x){c(n= length(x), mean = round(mean(x),2), sd = round(sd(x),1), min=min(x), max=max(x)) })
#      Sex set Age.n Age.mean Age.sd Age.min Age.max
# 1 female GSU    13    15.31   12.3       4      40
# 2 female  LL     6     8.17    4.4       3      14
# 3 female NIH    10    12.80    9.2       2      31
# 4   male GSU     9    10.89    5.8       4      22
# 5   male  LL    10    11.40   14.2       2      38
# 6   male NIH    16     6.62    4.5       2      20

# Descriptives
sapply(fWHR[fWHR$Sex == "female",], mean, na.rm=TRUE)
sapply(fWHR[fWHR$Sex == "female",], sd, na.rm=TRUE)

# Add correlations to descriptives section
# Add correlations to descriptives section
# TODO the two width meausre correlate (,45 - may both be linked to assertiveness. the lower hight measure is largely independent (r = .02 and ))
cor.prob(fWHR[,c("fWHR", "face_lowerwidth_to_height", "face_lower_to_whole_height")])

#                                  fWHR face_lowerwidth_to_height face_lower_to_whole_height
# fWHR                               NA               <0.001                  p = 0.90
# face_lowerwidth_to_height  0.45                        NA                  p = 0.37
# face_lower_to_whole_height 0.02              -0.11                         NA


cor.prob <- function (X, dfr = nrow(X) - 2, digits=2) {
  R <- cor(X, use="pairwise.complete.obs")
  above <- row(R) < col(R)
  r2 <- R[above]^2
  Fstat <- r2 * dfr/(1 - r2)
  R[above] <- 1 - pf(Fstat, 1, dfr)
  R[row(R) == col(R)] <- NA
  return(R)
}

# Make correlation table for: Age, Age2, Sex, Dominance, Openness, Neuroticism, Sociability & Attentiveness, fWHR, face_lowerwidth_to_height, face_lower_to_whole_height


# Test Hypothesis 1: fWHR is specific for dominance, and will not correlate with personality
# traits other than dominance

# The remaining personality domains are: Openness + Neuroticism + Sociability + Attentiveness
# No link to these traits

m1 <- lm(fWHR ~ Age * Sex + I(Age^2) + Dominance + Openness + Neuroticism + Sociability + Attentiveness, data = fWHR); 
Anova(m1); summary(m1)

# Coefficients:
#                 Estimate Std. Error t value Pr(>|t|)    
# (Intercept)    2.2876103  0.3286531   6.961 4.77e-09 ***
# Age            0.0042239  0.0075856   0.557 0.579942    
# Sexmale       -0.0699298  0.0497658  -1.405 0.165696    
# I(Age^2)      -0.0002932  0.0001632  -1.796 0.078041 .  
# Dominance      0.0580897  0.0162918   3.566 0.000770 ***
# Openness      -0.0079257  0.0324700  -0.244 0.808085    
# Neuroticism   -0.0527590  0.0406849  -1.297 0.200224    
# Sociability    0.0181401  0.0315065   0.576 0.567171    
# Attentiveness -0.0394313  0.0358984  -1.098 0.276897    
# Age:Sexmale    0.0130861  0.0034537   3.789 0.000382 ***

# Residual standard error: 0.1173 on 54 degrees of freedom
# Multiple R-squared: 0.5266,	Adjusted R-squared: 0.4477 
# F-statistic: 6.675 on 9 and 54 DF,  p-value: 2.347e-06 

m1 <- lm(fWHR ~ Age * Sex + I(Age^2) + Dominance + Openness + Neuroticism + Sociability + Attentiveness, data = fWHR[fWHR$Age > 5,]); 

# Reportable result down to here is that personality does not explain the link between dominance to fWHR?
# (or perhaps it does when controlling age and sex?): Sociability? Bit of Neuroticism


# =============================
# face width/lower height: main models
# =============================
# Model 1: Full sample
m1 <- lm(face_lowerwidth_to_height ~ I(Age^2) + Age*Sex + Dominance + Openness + Attentiveness + Neuroticism + Sociability, data = fWHR); Anova(m1)
# Model 2: Adults only
m1 <- lm(face_lowerwidth_to_height ~ I(Age^2) + Age*Sex + Dominance + Openness + Attentiveness + Neuroticism + Sociability, data = fWHR[fWHR$Age > 5,]); Anova(m1)
# Model 3: Juveniles only
m1 <- lm(face_lowerwidth_to_height ~ I(Age^2) + Age*Sex + Dominance + Openness + Attentiveness + Neuroticism + Sociability, data = fWHR[fWHR$Age < 6,]); Anova(m1)
# Model 3: old age only
m1 <- lm(face_lowerwidth_to_height ~ I(Age^2) + Age*Sex, data = fWHR[fWHR$Age > 19,]); Anova(m1)
summary(m1)

# Model 4: Controlling for fWHR in full sample
m1 <- lm(face_lowerwidth_to_height ~ I(Age^2) + Age*Sex + Dominance + Openness + Attentiveness + Neuroticism + Sociability + fWHR, data = fWHR); Anova(m1)

## Table 3 for model 1, analysed using Type II Anova.

fWHR$FWHR_plus_lower_face = scale(fWHR$fWHR) + scale(fWHR$face_lowerwidth_to_height)
m1 <- lm(FWHR_plus_lower_face ~ I(Age^2) + Age*Sex + Dominance + Openness + Attentiveness + Neuroticism + Sociability, data = fWHR); Anova(m1)

# Response: FWHR_plus_lower_face
#               Sum Sq Df F value    Pr(>F)    
# I(Age^2)       0.173  1  0.1037 0.7486863    
# Age            0.062  1  0.0370 0.8481890    
# Sex           12.109  1  7.2469 0.0094372 ** 
# Dominance     23.758  1 14.2190 0.0004052 ***
# Openness       3.152  1  1.8867 0.1752468    
# Attentiveness  0.340  1  0.2033 0.6538893    
# Neuroticism    4.803  1  2.8745 0.0957518 .  
# Sociability    0.109  1  0.0651 0.7995647    
# Age:Sex       24.355  1 14.5764 0.0003489 ***
# Residuals     90.227 54

# ============================================================================================
# = In a simple model predicting dominance, without controlling neuroticism, fWHR kicks ass. =
# ============================================================================================
m1 <- lm(Dominance ~ I(Age^2) + Age*Sex + fWHR                     , data = fWHR) ; Anova(m1)
m2 <- lm(Dominance ~ I(Age^2) + Age*Sex + face_lowerwidth_to_height, data = fWHR) ; Anova(m2)
m3 <- lm(Dominance ~ I(Age^2) + Age*Sex + FWHR_plus_lower_face     , data = fWHR) ; Anova(m3)

## Plot
qplot(Age, face_lowerwidth_to_height, data=fWHR, geom=c("point", "smooth"), method="lm", formula=y~x, color=Sex, xlab="Age", ylab="Face width to lower-height ratio")


## Plot
scatterplot(face_lowerwidth_to_height ~ Age | Sex, smooth = FALSE, spread = TRUE, grid = FALSE, ylab = "face width/lower face height")
 
   xlab="Age", ylab="Miles Per Gallon ", pch=19)
abline(lm(mpg~wt), col="red") # regression line (y~x)

# ======================================
# Lower to whole face height: main models
# ======================================
# Model 1: Full sample
m1 <- lm(face_lower_to_whole_height ~ Age*Sex + I(Age^2) + set + Dominance + Openness +  Neuroticism + Attentiveness + Sociability, data = fWHR); Anova(m1)

m1 <- lm(face_lower_to_whole_height ~ set + Sex * Age , data = fWHR)

mx <- lm(m1$residuals ~ fWHR$Dominance + fWHR$Openness + fWHR$Neuroticism + fWHR$Attentiveness + fWHR$Sociability)

# males only
m1 <- lm(face_lower_to_whole_height ~ I(Age^2) + Age + Dominance + Openness +  Neuroticism + Attentiveness + Sociability, data = fWHR[fWHR$Sex == "male" | fWHR$Age > 5,])
Anova(m1)

# females only
m1 <- lm(face_lower_to_whole_height ~ I(Age^2) + Age + Dominance + Openness +  Neuroticism + Attentiveness + Sociability, data = fWHR[fWHR$Sex == "female" | fWHR$Age > 5,])
Anova(m1)


m1 <- lm(Neuroticism ~ I(Age^2) + Age * Sex + Openness, data = fWHR); Anova(m1)

## Plot Neuroticism with Face length
visreg(m1, ylab="Face lower-height to whole height ratio")
# Model 2: Adults only
m1 <- lm(face_lower_to_whole_height ~ I(Age^2) + Age*Sex + Dominance + Openness + Attentiveness + Neuroticism + Sociability, data = fWHR[fWHR$Age > 5,])


attach(fWHR)
plot(face_lower_to_whole_height, Neuroticism, xlab="Mean face lower to whole height ratio", ylab="Neuroticism", pch=19)
# Add regression line (y~x) 
abline(lm(Neuroticism~face_lower_to_whole_height), col="red") 

m1 <- lm(Neuroticism ~ Sex, data = fWHR)
Anova(m1)


## DIMORPHISM of fWLHR & fLHR

# fWLHR not dimorphic
m1 <- lm(face_lowerwidth_to_height ~ Sex, data = fWHR)
# Coefficients:
#             Estimate Std. Error t value Pr(>|t|)    
# (Intercept)  1.41079    0.01625  86.833   <2e-16 ***
# Sexmale      0.03857    0.02197   1.756   0.0841 .  

# but dimorphic in adults
m1 <- lm(face_lowerwidth_to_height ~ Sex, data = fWHR[fWHR$Age > 5,])# Coefficients:
#             Estimate Std. Error t value Pr(>|t|)    
# (Intercept)  1.41026    0.01759  80.171   <2e-16 ***
# Sexmale      0.05523    0.02646   2.087   0.0431 *  

# fLHR not dimorphic
m1 <- lm(face_lower_to_whole_height ~ Sex, data = fWHR)
# Coefficients:
#             Estimate Std. Error t value Pr(>|t|)    
# (Intercept)  0.74776    0.00744 100.500   <2e-16 ***
# Sexmale     -0.01234    0.01006  -1.227    0.225    

# adults
m1 <- lm(face_lower_to_whole_height ~ Sex, data = fWHR[fWHR$Age > 5,])
# Coefficients:
#              Estimate Std. Error t value Pr(>|t|)    
# (Intercept)  0.753663   0.008091  93.145   <2e-16 ***
# Sexmale     -0.008295   0.012172  -0.681    0.499    

# ======================
###  site differences ###
# ======================

## fWLHR: not sign. diff between sites
m1 <- lm(face_lowerwidth_to_height ~ set, data = fWHR)
anova(m1)
summary(m1)
plot(face_lowerwidth_to_height ~ set, data = fWHR)
m1 <- lm(face_lowerwidth_to_height ~ I(Age^2) + Age*Sex + set + Dominance + Openness + Attentiveness + Neuroticism + Sociability, data = fWHR); Anova(m1)


## fLHR
m1 <- lm(face_lower_to_whole_height ~ set, data = fWHR)
m1 <- lm(face_lower_to_whole_height ~ set, data = fWHR[fWHR$Age > 5,])

m1 <- lm(Neuroticism ~ set, data = fWHR)

plot(face_lower_to_whole_height ~ set, data = fWHR)
plot(face_lower_to_whole_height ~ set, data = fWHR[fWHR$Age > 5,])

m1 <- lm(face_lower_to_whole_height ~ I(Age^2) + Age * Sex + set + Dominance + Openness +  Neuroticism + Attentiveness + Sociability, data = fWHR); Anova(m1)

m1 <- lm(face_lower_to_whole_height ~ I(Age^2) + Age * Sex + set + Neuroticism, data = fWHR); Anova(m1)

# Model 2: Adults only
m1 <- lm(face_lower_to_whole_height ~ I(Age^2) + Age*Sex + set + Dominance + Openness + Attentiveness + Neuroticism + Sociability, data = fWHR[fWHR$Age > 5,]); Anova(m1)

# fLHR
m1 <- lm(Neuroticism ~ I(Age^2) + Age * Sex + set +face_lower_to_whole_height, data = fWHR); Anova(m1)

that also makes reporting them a lot simpler - ditch the big tables?
then just say “lower face/height ratio was not a significant predictor of (list dimensions), min p-value = X from a series of models like this:

m1 <- lm(Attentiveness ~ I(Age^2) + Age * Sex + set +face_lower_to_whole_height, data = fWHR); Anova(m1) 
m1 <- lm(Sociability ~ I(Age^2) + Age * Sex + set +face_lower_to_whole_height, data = fWHR); Anova(m1) 
m1 <- lm(Dominance ~ I(Age^2) + Age * Sex + set +face_lower_to_whole_height, data = fWHR); Anova(m1)
m1 <- lm(Openness ~ I(Age^2) + Age * Sex + set +face_lower_to_whole_height, data = fWHR); Anova(m1)


m1 = lm(Neuroticism ~ face_lower_to_whole_height, data = fWHR); Anova(m1)
# p = 0.1445
m2 = lm(Attentiveness ~ face_lower_to_whole_height, data = fWHR)
Anova(m2) # p = 0.0121
m3 = lm(Neuroticism ~ Attentiveness + face_lower_to_whole_height, data = fWHR); Anova(m3) # fLHR p = 0.8613
m4 = lm(Attentiveness ~ Neuroticism + face_lower_to_whole_height, data = fWHR); Anova(m4) # fLHR p = 0.0422
## In these 4 models, Attentiveness predicts N and fLHR, but N does not predict fLHR

# Add age & sex controls
m1 <- lm(Attentiveness ~ I(Age^2) + Age * Sex + set + face_lower_to_whole_height, data = fWHR); Anova(m1) # p = 0.0004
m2 <- lm(Neuroticism ~ I(Age^2) + Age * Sex + set + face_lower_to_whole_height, data = fWHR); Anova(m2) # p = 0.0059
m1 <- lm(Neuroticism ~ Attentiveness + I(Age^2) + Age * Sex + set + face_lower_to_whole_height, data = fWHR); Anova(m1) # p = 0.4457
m1 <- lm(Attentiveness ~ Neuroticism + I(Age^2) + Age * Sex + set + face_lower_to_whole_height, data = fWHR); Anova(m1) # p = 0.0179

scatterplot(Attentiveness ~ face_lower_to_whole_height | Sex, data = fWHR)


# fWLHR
m1 <- lm(Neuroticism ~ I(Age^2) + Age * Sex + set +face_lower_to_whole_height, data = fWHR); Anova(m1)

that also makes reporting them a lot simpler - ditch the big tables?
then just say “lower face/height ratio was not a significant predictor of (list dimensions), min p-value = X from a series of models like this:

m1 <- lm(Attentiveness ~ I(Age^2) + Age * Sex + set +face_lower_to_whole_height, data = fWHR); Anova(m1) 
m1 <- lm(Sociability ~ I(Age^2) + Age * Sex + set +face_lower_to_whole_height, data = fWHR); Anova(m1) 
m1 <- lm(DominanceZ ~ I(Age^2) + Age * Sex + set +face_lower_to_whole_height, data = fWHR); Anova(m1)
m1 <- lm(Openness ~ I(Age^2) + Age * Sex + set +face_lower_to_whole_height, data = fWHR); Anova(m1)


## multi-level model??
## or differentially-weighted factor scores?
# add weight to models?



## check for weight as a correlate of fLHR & fLWHR
# fLHR
m1 <- lm(face_lower_to_whole_height ~ Sex * Age + Weight + Dominance + Openness +  Neuroticism + Attentiveness + Sociability, data = fWHR); Anova(m1)
# Weight is  significant predictor of fLHR, related I believe to age - age falls out when you add weight in; N remains significant when adding weight as a co-variate. 

m1 <- lm(face_lower_to_whole_height ~ Weight, data = fWHR); Anova(m1)
scatterplot(face_lower_to_whole_height ~ Weight | Sex, data = fWHR)

# fLWHR
m1 <- lm(face_lowerwidth_to_height ~ I(Age^2) + Weight + Age*Sex + Dominance + Openness + Attentiveness + Neuroticism + Sociability, data = fWHR); Anova(m1)
# Adding weight to this model shows Neuroticism as significant and Assertiveness approaching significance.

m1 <- lm(face_lowerwidth_to_height ~ Weight, data = fWHR); Anova(m1)
scatterplot(face_lower_to_whole_height ~ Weight | Sex, data = fWHR)


cor.test(fWHR$Attentiveness, fWHR$Neuroticism) -0.5
cor.test(fWHR$Sociability, fWHR$Neuroticism) -0.4
cor.test(fWHR$Dominance, fWHR$Neuroticism)  -0.001
cor.test(fWHR$Openness, fWHR$Neuroticism)  0.34


