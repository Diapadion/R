require("aod"); require("car"); require("doBy"); require("gdata") # to read in xls files
require("ggplot2")
# Read in data set
fWHR      <- gdata::read.xls("~/Dropbox/shared folders/Blake/data/Capuchin_fWHR.xlsx")
FFM       <- gdata::read.xls("~/Dropbox/shared folders/Blake/data/Capuchin_personality.xlsx")
# NB 'shared folders' not required when run direct from folder.

FFM$ID    = as.character(FFM$ID)
fWHR$ID   = as.character(fWHR$ID)
fWHR$Status = as.character(fWHR$Alpha)
fWHR$Status[fWHR$Status=="YES "] = "Alpha"
fWHR$Status[fWHR$Status=="NO "] = "nonAlpha"
fWHR$Status = as.factor(fWHR$Status)
levels(fWHR$Status)
fWHR$DOB  = as.Date(as.character(fWHR$DOB))
str(fWHR)

# ID            Set           DOB           Sex           Age           Year_taken    No_of_photos 
# mean_fWHR     min_fWHR      max_fWHR      phys_fWHR     SD            DominanceZ    Alpha        
# Assertiveness Openness      Neuroticism   Sociability   Attentiveness

# =====================================
# = Old stuff to discover ID variants =
# =====================================
# fWHR$ID[!(fWHR$ID %in% FFM$ID)]
# FFM$ID[!(FFM$ID %in% fWHR$ID)]

# ============
# = subjects =
# ============
doBy::summaryBy(Age ~ Sex+set, data = fWHR, FUN = function(x){c(n= length(x), mean = mean(x), sd = sd(x), min=min(x), max=max(x)) })
#      Sex Age.n  Age.mean    Age.sd
# 1 female    29 12.965517 10.125931
# 2   male    35  9.085714  8.671696
# 
#      Sex set Age.n  Age.mean    Age.sd Age.min Age.max
# 1 female GSU    13 15.307692 12.263663       4      40
# 2 female  LL     6  8.166667  4.355074       3      14
# 3 female NIH    10 12.800000  9.199034       2      31
# 4   male GSU     9 10.888889  5.797509       4      22
# 5   male  LL    10 11.400000 14.159410       2      38
# 6   male NIH    16  6.625000  4.500000       2      20

# ===========
# = Results =
# ===========

# Are there differences in sex or age by site (called set in the datafile)?
# http://www.ats.ucla.edu/stat/r/dae/logit.htm
mylogit = glm(Sex ~ set, family=binomial(link="logit"), na.action=na.pass, data=fWHR)
summary(mylogit)
aod::wald.test(b=coef(mylogit), Sigma=vcov(mylogit), Terms=2:3)
# Χ^2(2)=2.5, p=.28

anova(lm(Age ~ set, data=fWHR))
# F(2,61)=1.4107, p=0.25

# Need a reliability section early on in the paper: So something like "For X animals multiple photos were available. Each of these were scored, and ICC computed to calculate the reliability of the mean_fWHR measure"
# TODO: ICCs for repeated measurements of single animals

with(fWHR,ftable(Status, Sex, Adult_status))
# ===================================================================
# = Hypothesis testing: Is fWHR sexually dimorphic? Are there age differences?
# ===================================================================

# Graph alpha and sex effects on fWHR × age
car::scatterplot(mean_fWHR ~ Age |  Status, data = fWHR[fWHR$Sex=="male",], ylim=c(1.9,2.6), xlim=c(0,40), legend.coords="topleft", xlab= "Age (years)", ylab="Mean facial width/height ratio (fWHR)")
car::scatterplot(mean_fWHR ~ Age |  Status, data = fWHR[fWHR$Sex=="female",], ylim=c(1.9,2.6), xlim=c(0,40), legend.coords="topleft", xlab= "Age (years)", ylab="Mean facial width/height ratio (fWHR)")
qplot(Age, mean_fWHR, shape=Status, color=Sex, geom=c("point","smooth"), method="lm", data = fWHR)

# Age has significant effects
m1 <- lm(fWHR ~ Age + I(Age^2) + I(Age^3), data=fWHR)
summary(m1); anova(m1)
#           Df  Sum Sq  Mean Sq F value  Pr(>F)  
# Age        1 0.00036 0.000361  0.0159 0.90001  
# I(Age^2)   1 0.15224 0.152238  6.7185 0.01197 *
# I(Age^3)   1 0.05694 0.056944  2.5130 0.11817  
# Residuals 60 1.35958 0.022660                  

# Linear models of age and sex
## Full sample
m3 <- lm(mean_fWHR ~ I(Age^2) + Age * Sex, data=fWHR); anova(m3)
#           Df  Sum Sq Mean Sq F value    Pr(>F)    
# I(Age^2)   1 0.00789 0.00789  0.4711  0.495158    
# Age        1 0.14471 0.14471  8.6366  0.004696 ** 
# Sex        1 0.10172 0.10172  6.0712  0.016674 *  
# Age:Sex    1 0.32626 0.32626 19.4722 4.404e-05 ***
# Residuals 59 0.98854 0.01675                      

# Adults age 6 and over
m3 <- lm(mean_fWHR ~ I(Age^2) + Age * Sex, data=fWHR[fWHR$Age > 6,]); anova(m3)
# Response: mean_fWHR
#           Df  Sum Sq  Mean Sq F value   Pr(>F)   
# I(Age^2)   1 0.07588 0.075882  3.7450 0.061574 . 
# Age        1 0.00068 0.000685  0.0338 0.855255   
# Sex        1 0.23342 0.233424 11.5201 0.001807 **
# Age:Sex    1 0.19645 0.196455  9.6956 0.003803 **
# Residuals 33 0.66866 0.020262                    

# Adults age 5 and over
m3 <- lm(mean_fWHR ~ I(Age^2) + Age * Sex, data=fWHR[fWHR$Adult_status=="YES",]); anova(m3)
# Response: mean_fWHR
#           Df  Sum Sq Mean Sq F value    Pr(>F)    
# I(Age^2)   1 0.03046 0.03046  1.6433 0.2067432    
# Age        1 0.06490 0.06490  3.5011 0.0681440 .  
# Sex        1 0.11841 0.11841  6.3877 0.0152483 *  
# Age:Sex    1 0.33029 0.33029 17.8172 0.0001234 ***
# Residuals 43 0.79712 0.01854          

# Age is significant; sex appears to differ as a result of age
# Effect of Sex and age for adults only
m5 <- lm(mean_fWHR ~ Age * Sex, data=fWHR[fWHR$Adult_status=="YES",])
Anova(m5)
#            Sum Sq Df F value    Pr(>F)    
# Age       0.00571  1  0.2889   0.59364    
# Sex       0.09130  1  4.6173   0.03719 *  
# Age:Sex   0.36683  1 18.5514 9.126e-05 ***
# Residuals 0.87005 44 
plot(mean_fWHR ~ Sex, data=fWHR)

# Age sex interaction is still strong but sex is not significant for adults
m6 <- lm(mean_fWHR ~ Age * Sex, data=fWHR[fWHR$Adult_status=="NO",])
anova(m6)
#  Response: mean_fWHR
#            Df   Sum Sq   Mean Sq F value Pr(>F)
# Age        1 0.009129 0.0091289  0.7501 0.4034
# Sex        1 0.001852 0.0018525  0.1522 0.7033
# Age:Sex    1 0.000544 0.0005439  0.0447 0.8361
# Residuals 12 0.146049 0.0121708    

## Differences in adults based on age, eg age 5 +, age 6 + .... age*sex interaction is stronger when including individuals in the age 5 bracket (classified as Adult="YES)
# Sex effect is stronger in age 6 and over.
# The age-sex classification for capuchins is Adult I = age 5 and over. Adult II = 6 and over, according to Izawa (1980). This suggests that by age 6 sexual dimporhism might begin to occur.

# Age 6 and over
m10 <- lm(mean_fWHR ~ Age * Sex, data=fWHR[fWHR$Age > 6,])
anova(m10)
#           Df  Sum Sq  Mean Sq F value   Pr(>F)   
# Age        1 0.07061 0.070611  3.5448 0.068312 . 
# Sex        1 0.22349 0.223485 11.2193 0.001991 **
# Age:Sex    1 0.20374 0.203737 10.2279 0.002989 **
# Residuals 34 0.67727 0.019920   

# Age 5 and over
m11 <- lm(mean_fWHR ~ Age * Sex, data=fWHR[fWHR$Adult_status=="YES",])
anova(m11) 
#           Df  Sum Sq Mean Sq F value    Pr(>F)    
# Age        1 0.01300 0.01300  0.6575   0.42181    
# Sex        1 0.09130 0.09130  4.6173   0.03719 *  
# Age:Sex    1 0.36683 0.36683 18.5514 9.126e-05 ***
# Residuals 44 0.87005 0.01977                      

### ============================= ###

# ============================
# = Alpha & Dominance scores =
# ============================

# Effect of alpha
# Alpha status is highly predictive of fWHR
m7 <- lm(mean_fWHR ~ Status, data=fWHR)
anova(m7)
# Response: mean_fWHR
#          Df  Sum Sq Mean Sq F value    Pr(>F)    
# Status     1 0.38494 0.38494  20.154 3.169e-05 ***
# Residuals 62 1.18418 0.01910                                 


# Binary DV ALpah needs a logistic regression model
mylogit <- glm(Status ~ DominanceZ*Sex, family=binomial(link="logit"), data=fWHR, na.action=na.pass)
anova(mylogit, test="Chisq")
confint(mylogit)
aod::wald.test(b=coef(mylogit), Sigma=vcov(mylogit), Terms=2:2)
# Dominance appears to have a significant interaction with Status
#           Df Deviance Resid. Df Resid. Dev  Pr(>Chi)    
# NULL                          63     76.049              
# DominanceZ  1   33.321        62     42.728 7.815e-09 ***
# Sex         1    1.775        61     40.953    0.1828    
# fWHR correlates with dominance


cor.test(fWHR$mean_fWHR, fWHR$DominanceZ)
# Pearson's product-moment correlation
# data:  fWHR$mean_fWHR and fWHR$DominanceZ 
# t = 4.8102, df = 62, p-value = 1.001e-05
# alternative hypothesis: true correlation is not equal to 0 
# 95 percent confidence interval:
# 0.3160028 0.6799901 
# sample estimates:
#    cor 
# 0.521318 

m8 <- lm(mean_fWHR ~ Age+ I(Age^2) + Sex*Alpha, data=fWHR)
# Response: mean_fWHR
#           Df  Sum Sq  Mean Sq F value    Pr(>F)    
# Age        1 0.00036 0.000361  0.0216 0.8835550    
# I(Age^2)   1 0.15224 0.152238  9.1328 0.0037328 ** 
# Sex        1 0.10172 0.101722  6.1023 0.0164622 *  
# Alpha      1 0.25555 0.255547 15.3303 0.0002401 ***
# Sex:Alpha  1 0.09243 0.092425  5.5446 0.0219437 *  
# Residuals 58 0.96683 0.016669              

# Most of these not so useful: Mixes the whole same (young and old) 
# and also with dominance and alpha it confounds two overlapping traits

m8 <- lm(mean_fWHR ~ Age+ I(Age^2) + Sex*Alpha + Sex*DominanceZ, data=fWHR[fWHR$Age > 6,])
Anova(m8)
#            Df  Sum Sq  Mean Sq F value   Pr(>F)    
# Age         1 0.00036 0.000361  0.0230 0.880116    
# I(Age^2)    1 0.15224 0.152238  9.6860 0.002901 ** 
# Sex         1 0.10172 0.101722  6.4720 0.013694 *  
# Alpha       1 0.25555 0.255547 16.2589 0.000166 ***
# DominanceZ  1 0.08149 0.081487  5.1845 0.026561 *  
# Sex:Alpha   1 0.08187 0.081874  5.2091 0.026220 *  
# Residuals  57 0.89589 0.015717                     

m12 <- lm(mean_fWHR ~ Age+ I(Age^2) + DominanceZ*Alpha, data=fWHR)
anova(m12)
# Response: mean_fWHR
#                  Df  Sum Sq Mean Sq F value    Pr(>F)    
# Age               1 0.00036 0.00036  0.0212  0.884700    
# I(Age^2)          1 0.15224 0.15224  8.9527  0.004064 ** 
# DominanceZ        1 0.33826 0.33826 19.8923 3.817e-05 ***
# Alpha             1 0.05897 0.05897  3.4679  0.067640 .  
# DominanceZ:Alpha  1 0.03302 0.03302  1.9418  0.168795    
# Residuals        58 0.98627 0.01700                       

m12 <- lm(mean_fWHR ~ Age+ I(Age^2) + DominanceZ*Sex, data=fWHR)
# Response: mean_fWHR
#                Df  Sum Sq Mean Sq F value    Pr(>F)    
# Age             1 0.00036 0.00036  0.0213  0.884495    
# I(Age^2)        1 0.15224 0.15224  8.9849  0.004003 ** 
# DominanceZ      1 0.33826 0.33826 19.9637 3.713e-05 ***
# Sex             1 0.06706 0.06706  3.9577  0.051379 .  
# DominanceZ:Sex  1 0.02846 0.02846  1.6795  0.200125    
# Residuals      58 0.98274 0.01694          
       

# ==========================================================
# = Take home message: fWHR is a function of Age^2, Sex, Status, and Sex*Status = ...needs further investigation in females??
# ==========================================================
m8 <- lm(mean_fWHR ~ Age+ I(Age^2) + Sex * Status, data = fWHR)
anova(m8)
#           Df  Sum Sq  Mean Sq F value    Pr(>F)    
# Age        1 0.00036 0.000361  0.0216 0.8835550    
# I(Age^2)   1 0.15224 0.152238  9.1328 0.0037328 ** 
# Sex        1 0.10172 0.101722  6.1023 0.0164622 *  
# Status      1 0.25555 0.255547 15.3303 0.0002401 ***
# Sex:Status  1 0.09243 0.092425  5.5446 0.0219437 *  
# Residuals 58 0.96683 0.016669    

### ================================ ###
# Body weights for NIH
#######################

fWHR      <- gdata::read.xls("~/Dropbox/Blake/data/Weights.data/Weights.xlsx")

# sex diff.s in weight-fWHR correlations
car::scatterplot(mean_fWHR ~ Weight..kg. |  Sex, data = fWHR, legend.coords="topleft", xlab= "Body weight", ylab="Mean facial width/height ratio (fWHR)")

# weight predicts fWHR... 
plot(fWHR$Weight..kg. ~ fWHR$mean_fWHR)
m1 <- lm(mean_fWHR ~ Weight..kg., data=fWHR)

# ...at NIH
# Response: mean_fWHR
#          Df  Sum Sq  Mean Sq F value  Pr(>F)  
# Weight     1 0.09282 0.092824  6.1887 0.02092 *
# Residuals 22 0.32998 0.014999      

# ...and at GSU
# Response: mean_fWHR
#             Df  Sum Sq  Mean Sq F value   Pr(>F)   
# Weight..kg.  1 0.27499 0.274992  11.441 0.002959 **
# Residuals   20 0.48072 0.024036            

# ...and at both sites
# Response: mean_fWHR
#             Df  Sum Sq Mean Sq F value    Pr(>F)    
# Weight..kg.  1 0.37002 0.37002  20.009 5.372e-05 ***
# Residuals   44 0.81368 0.01849    

## ===== !! edit here !!

scatterplot(Weight..kg. ~ Age | Sex, data=fWHR)
plot(Weight..kg. ~ Age, data=fWHR)
plot(mean_fWHR ~ Age, data=fWHR)
scatterplot(mean_fWHR ~ Age | Sex, data=fWHR)
scatterplot(mean_fWHR ~ Weight..kg. | Sex, data=fWHR)

scatterplot(mean_fWHR ~ Age | Sex, data=fWHR[fWHR$Age > 8,],)
m1 <- lm(mean_fWHR ~ Weight..kg.*Age, data=fWHR)

#            Df   Sum Sq  Mean Sq F value   Pr(>F)   
# Weight      1 0.092824 0.092824  8.1159 0.009922 **
# Age         1 0.009495 0.009495  0.8302 0.373069   
# Weight:Age  1 0.091737 0.091737  8.0209 0.010298 * 
# Residuals  20 0.228745 0.011437                    


m1 <- lm(mean_fWHR ~ Weight, data=fWHR[fWHR$Age > 6,],)
anova(m1)

# Response: mean_fWHR
#           Df  Sum Sq  Mean Sq F value Pr(>F)   
# Weight     1 0.19033 0.190327  15.657 0.0027 **
# Residuals 10 0.12156 0.012156                  

# From the plots, it appears that fWHR correlates with body weight for both sexes.  Weight decreases in individuals over age 20. 

m1 <- lm(mean_fWHR ~ Weight..kg.*Sex, data=fWHR)

# Response: mean_fWHR
#            Df   Sum Sq  Mean Sq F value  Pr(>F)  
# Weight      1 0.092824 0.092824  7.5525 0.01240 *
# Sex         1 0.000004 0.000004  0.0003 0.98622  
# Weight:Sex  1 0.084165 0.084165  6.8480 0.01651 *
# Residuals  20 0.245808 0.012290                

m1 <- lm(mean_fWHR ~ Weight*Sex, data=fWHR[fWHR$Age > 6,],)

#            Df   Sum Sq  Mean Sq F value    Pr(>F)    
# Weight      1 0.190327 0.190327 32.5623 0.0004511 ***
# Sex         1 0.010586 0.010586  1.8111 0.2152711    
# Weight:Sex  1 0.064215 0.064215 10.9864 0.0106256 *  
# Residuals   8 0.046760 0.005845                      

m1 <- lm(mean_fWHR ~ Weight*Sex, data=fWHR[fWHR$Age < 6,],)
# Response: mean_fWHR
#            Df   Sum Sq   Mean Sq F value Pr(>F)
# Weight      1 0.002696 0.0026963  0.2823 0.6180
# Sex         1 0.007228 0.0072278  0.7566 0.4242
# Weight:Sex  1 0.013558 0.0135578  1.4192 0.2870
# Residuals   5 0.047765 0.0095529               

m1 <- lm(mean_fWHR ~ Weight*DominanceZ, data=fWHR)

#                   Df   Sum Sq  Mean Sq F value   Pr(>F)   
# Weight             1 0.092824 0.092824  10.368 0.004296 **
# DominanceZ         1 0.033143 0.033143   3.702 0.068695 . 
# Weight:DominanceZ  1 0.117780 0.117780  13.156 0.001679 **
# Residuals         20 0.179054 0.008953                   

m1 <- lm(mean_fWHR ~ Weight..kg.*DominanceZ, data=fWHR[fWHR$Age > 5,],)
anova(m1)
# Response: mean_fWHR
#                        Df  Sum Sq Mean Sq F value    Pr(>F)    
# Weight..kg.             1 0.42881 0.42881 28.0674 1.004e-05 ***
# DominanceZ              1 0.14118 0.14118  9.2410  0.004874 ** 
# Weight..kg.:DominanceZ  1 0.03542 0.03542  2.3186  0.138306    
# Residuals              30 0.45833 0.01528          

Anova(m1)   
# Response: mean_fWHR
#                         Sum Sq Df F value    Pr(>F)    
# Weight..kg.            0.27331  1 17.8894 0.0002025 ***
# DominanceZ             0.14118  1  9.2410 0.0048740 ** 
# Weight..kg.:DominanceZ 0.03542  1  2.3186 0.1383062    
# Residuals              0.45833 30                          

m1 <- lm(mean_fWHR ~ Weight*Alpha, data=fWHR)

#              Df   Sum Sq  Mean Sq F value    Pr(>F)    
# Weight        1 0.092824 0.092824 11.3783 0.0030225 ** 
# Alpha         1 0.037017 0.037017  4.5376 0.0457638 *  
# Weight:Alpha  1 0.129801 0.129801 15.9110 0.0007221 ***
# Residuals    20 0.163159 0.008158                    

m1 <- lm(mean_fWHR ~ Weight*Alpha, data=fWHR[fWHR$Age > 6,],)

# Response: mean_fWHR
#              Df   Sum Sq  Mean Sq F value   Pr(>F)   
# Weight        1 0.190327 0.190327 21.9907 0.001563 **
# Alpha         1 0.034119 0.034119  3.9421 0.082348 . 
# Weight:Alpha  1 0.018204 0.018204  2.1033 0.185032   
# Residuals     8 0.069239 0.008655                    

m1 <- lm(Weight ~ DominanceZ, data=newdata[newdata$Age > 5,],)

anova(m1)
# Response: Weight..kg.
#            Df Sum Sq Mean Sq F value   Pr(>F)   
# DominanceZ  1  8.626  8.6258  8.0417 0.006883 **
# Residuals  44 47.196  1.0726    

t.test(Weight ~ Alpha, data = newdata)

m2 <- lm(mean_fWHR ~ I(Age^2) + Weight + DominanceZ + Age * Sex, data=newdata)
summary(m2)
# Coefficients:
#              Estimate Std. Error t value Pr(>|t|)    
# (Intercept)  1.9106987  0.1280677  14.919   <2e-16 ***
# I(Age^2)    -0.0001252  0.0002659  -0.471   0.6405    
# Weight       0.0442469  0.0225400   1.963   0.0570 .  
# DominanceZ   0.0411643  0.0189997   2.167   0.0366 *  
# Age         -0.0010341  0.0119171  -0.087   0.9313    
# Sexmale     -0.0784970  0.0895755  -0.876   0.3864    
# Age:Sexmale  0.0107363  0.0084108   1.276   0.2095    
# Residual standard error: 0.1231 on 38 degrees of freedom
# Multiple R-squared: 0.5134,	Adjusted R-squared: 0.4365 
# F-statistic: 6.681 on 6 and 38 DF,  p-value: 6.932e-05 
anova(m2)
# Response: mean_fWHR
#            Df  Sum Sq Mean Sq F value    Pr(>F)    
# I(Age^2)    1 0.11617 0.11617  7.6708  0.008633 ** 
# Weight      1 0.34220 0.34220 22.5952 2.859e-05 ***
# DominanceZ  1 0.10734 0.10734  7.0876  0.011315 *  
# Age         1 0.01290 0.01290  0.8516  0.361916    
# Sex         1 0.00384 0.00384  0.2535  0.617523    
# Age:Sex     1 0.02468 0.02468  1.6294  0.209528    
#Residuals  38 0.57550 0.01514               

m1 <- lm(Weight ~ DominanceZ, data=newdata[newdata$Age > 5,],)
summary(m1)
# Coefficients:
#             Estimate Std. Error t value Pr(>|t|)   
# (Intercept)   2.4086     0.6672   3.610  0.00103 **
# DominanceZ    0.2595     0.1566   1.657  0.10726   
# Residual standard error: 1.071 on 32 degrees of freedom
# Multiple R-squared: 0.07903,	Adjusted R-squared: 0.05025 
# F-statistic: 2.746 on 1 and 32 DF,  p-value: 0.1073 

anova(m1)
# Response: Weight..kg.
#            Df Sum Sq Mean Sq F value Pr(>F)
# DominanceZ  1  3.149  3.1494  2.7462 0.1073
# Residuals  32 36.699  1.1468        

# Weight predicts physical fWHR measurements, but only in whole sample
m1 <- lm(phys_fWHR ~ Weight, data=fWHR)

# Response: phys_fWHR
#           Df  Sum Sq Mean Sq F value  Pr(>F)  
# Weight     1 0.50928 0.50928  5.5754 0.02905 *
# Residuals 19 1.73553 0.09134        

m1 <- lm(phys_fWHR ~ Weight, data=fWHR[fWHR$Age > 6,],)

# Response: phys_fWHR
#           Df  Sum Sq  Mean Sq F value Pr(>F)
# Weight     1 0.28382 0.283817  3.1282 0.1107
# Residuals  9 0.81654 0.090727              




###### Adding weight data to original model
## Read in full data set:
fWHR      <- gdata::read.xls("~/Dropbox/Blake/data/Capuchin_fWHR.xlsx")
# Original model for Age & Sex
m1 <- lm(mean_fWHR ~ I(Age^2) + Age * Sex, data=fWHR)

anova(m1)
# Response: mean_fWHR
#           Df  Sum Sq Mean Sq F value    Pr(>F)    
# I(Age^2)   1 0.00789 0.00789  0.4711  0.495158    
# Age        1 0.14471 0.14471  8.6366  0.004696 ** 
# Sex        1 0.10172 0.10172  6.0712  0.016674 *  
# Age:Sex    1 0.32626 0.32626 19.4722 4.404e-05 ***
# Residuals 59 0.98854 0.01675                      

Anova(m1)
# Anova Table (Type II tests)

# Response: mean_fWHR
#            Sum Sq Df F value    Pr(>F)    
# I(Age^2)  0.12153  1  7.2535  0.009198 ** 
# Age       0.19868  1 11.8582  0.001062 ** 
# Sex       0.10172  1  6.0712  0.016674 *  
# Age:Sex   0.32626  1 19.4722 4.404e-05 ***
# Residuals 0.98854 59                      

# Subset model for Age & Sex
# Creating subset excluding NA Weight values
newdata <- subset(fWHR, Weight >= 1.5) 
m1 <- lm(mean_fWHR ~ I(Age^2) + Age * Sex, data=newdata)
anova(m1)

# Response: mean_fWHR
#           Df  Sum Sq  Mean Sq F value  Pr(>F)  
# I(Age^2)   1 0.11617 0.116171  6.2231 0.01684 *
# Age        1 0.13295 0.132950  7.1220 0.01095 *
# Sex        1 0.06130 0.061298  3.2836 0.07749 .
# Age:Sex    1 0.12549 0.125493  6.7225 0.01323 *
# Residuals 40 0.74671 0.018668                

# Original model for Age & Sex: over 5s
m1 <- lm(mean_fWHR ~ I(Age^2) + Age * Sex, data=fWHR[fWHR$Age > 5,],)
anova(m1)
# Response: mean_fWHR
#           Df  Sum Sq  Mean Sq F value  Pr(>F)  
# I(Age^2)   1 0.04774 0.047744  2.4593 0.125124   
# Age        1 0.02606 0.026058  1.3422 0.253869   
# Sex        1 0.19884 0.198841 10.2421 0.002771 **
# Age:Sex    1 0.23382 0.233818 12.0438 0.001310 **
# Residuals 38 0.73773 0.019414                    

Anova(m1)
# Response: mean_fWHR
#            Sum Sq Df F value  Pr(>F)  
# I(Age^2)  0.04483  1  2.3090 0.136901   
# Age       0.03762  1  1.9378 0.172001   
# Sex       0.19884  1 10.2421 0.002771 **
# Age:Sex   0.23382  1 12.0438 0.001310 **
# Residuals 0.73773 38              

# Subset model for Age & Sex: over 5s
m1 <- lm(mean_fWHR ~ I(Age^2) + Age * Sex, data=newdata[newdata$Age > 5,],)

anova(m1)
# Response: mean_fWHR
#           Df  Sum Sq  Mean Sq F value  Pr(>F)  
# I(Age^2)   1 0.15377 0.153768  7.0195 0.01291 *
# Age        1 0.09364 0.093643  4.2748 0.04771 *
# Sex        1 0.11448 0.114483  5.2262 0.02974 *
# Age:Sex    1 0.06658 0.066578  3.0393 0.09187 .
# Residuals 29 0.63527 0.021906               


# Add weight to model using subset
m2 <- lm(mean_fWHR ~ I(Age^2) + Weight + Age * Sex, data=newdata)
summary(m2)
# Coefficients:
#               Estimate Std. Error t value Pr(>|t|)    
# (Intercept)  2.076e+00  9.243e-02  22.459   <2e-16 ***
# I(Age^2)    -1.853e-05  2.518e-04  -0.074   0.9417    
# Weight       5.612e-02  2.236e-02   2.510   0.0162 *  
# Age         -6.357e-03  1.101e-02  -0.577   0.5670    
# Sexmale     -1.320e-01  8.100e-02  -1.630   0.1109    
# Age:Sexmale  1.624e-02  7.675e-03   2.115   0.0407 *  
# Residual standard error: 0.1271 on 40 degrees of freedom
# Multiple R-squared: 0.4537,	Adjusted R-squared: 0.3855 
# F-statistic: 6.645 on 5 and 40 DF,  p-value: 0.0001371 

install.packages("QuantPsyc")
require("QuantPsyc")
lm.beta(m2)
# output with warning messages!
#    I(Age^2)      Weight         Age     Sexmale Age:Sexmale 
# -0.04017063  0.38538179 -0.34134826          NA 35.20309843 

anova(m2)
# Response: mean_fWHR
#             Df  Sum Sq Mean Sq F value    Pr(>F)    
# I(Age^2)   1 0.11617 0.11617  7.0071   0.01165 *  
# Weight     1 0.34220 0.34220 20.6402 5.231e-05 ***
# Age        1 0.01332 0.01332  0.8036   0.37552    
# Sex        1 0.00298 0.00298  0.1798   0.67388    
# Age:Sex    1 0.06136 0.06136  3.7010   0.06170 .  
# Residuals 39 0.64659 0.01658                          

Anova(m2)
# Anova Table (Type II tests)
# Response: mean_fWHR
#            Sum Sq Df F value  Pr(>F)  
# I(Age^2)  0.00010  1  0.0058 0.93963  
# Weight    0.10012  1  6.0388 0.01854 *
# Age       0.01617  1  0.9753 0.32945  
# Sex       0.00298  1  0.1798 0.67388  
# Age:Sex   0.06136  1  3.7010 0.06170 .
# Residuals 0.64659 39                             

# Add weight to model using subset: for > 5s
m3 <- lm(mean_fWHR ~ I(Age^2) + Weight + Age * Sex, data=newdata[newdata$Age > 5,])
summary(m3)
# Coefficients:
#               Estimate Std. Error t value Pr(>|t|)    
# (Intercept)  1.9005174  0.1530096  12.421 6.58e-13 ***
# I(Age^2)    -0.0002888  0.0003223  -0.896   0.3778    
# Weight       0.0728532  0.0275012   2.649   0.0131 *  
# Age          0.0073133  0.0148668   0.492   0.6266    
# Sexmale     -0.1048538  0.1210316  -0.866   0.3937    
# Age:Sexmale  0.0125647  0.0100969   1.244   0.2237    
# Residual standard error: 0.1347 on 28 degrees of freedom
# Multiple R-squared: 0.5225,	Adjusted R-squared: 0.4372 
# F-statistic: 6.127 on 5 and 28 DF,  p-value: 0.0005931 

lm.beta(m3)
# Output with warning messages!
#   I(Age^2)      Weight         Age     Sexmale Age:Sexmale 
# -0.6290739   0.4458983   0.3604742          NA  27.3707509 
 
anova(m3)
# Response: mean_fWHR
#             Df  Sum Sq Mean Sq F value    Pr(>F)    
# I(Age^2)   1 0.15377 0.15377  8.4761 0.0069859 ** 
# Weight     1 0.32145 0.32145 17.7194 0.0002391 ***
# Age        1 0.04815 0.04815  2.6541 0.1144814    
# Sex        1 0.00432 0.00432  0.2381 0.6294113    
# Age:Sex    1 0.02809 0.02809  1.5486 0.2236645    
# Residuals 28 0.50796 0.01814                            
  

# Which model is best fit?
# Make new data subset which drops NA cases of Weight: use new subset to compare model fit.
newdata <- fWHR[ which(fWHR$Weight > 1.5), ]

m1 <- lm(mean_fWHR ~ I(Age^2) + Age * Sex, data= newdata[newdata$Age > 5,],)
m3 <- lm(mean_fWHR ~ I(Age^2) + Weight + Age * Sex, data= newdata[newdata$Age > 5,])
anova(m1, m3)

# Analysis of Variance Table
# Model 1: mean_fWHR ~ I(Age^2) + Age * Sex
# Model 2: mean_fWHR ~ I(Age^2) + Weight..kg. + Age * Sex
#   Res.Df     RSS Df Sum of Sq      F  Pr(>F)  
# 1     29 0.63527                              
# 2     28 0.50796  1   0.12731 7.0177 0.01312 *

## Model 3 - including weight - is a better fit.




###################
m3 <- lm(mean_fWHR ~ Weight + DominanceZ, data=fWHR[fWHR$Age > 6,])
anova
Response: mean_fWHR
           Df  Sum Sq Mean Sq F value   Pr(>F)    
Weight      1 0.40060 0.40060 23.5915  4.9e-05 ***
DominanceZ  1 0.16137 0.16137  9.5028 0.004811 ** 
Residuals  26 0.44150 0.01698                     

Anova Table (Type II tests)

Response: mean_fWHR
            Sum Sq Df F value   Pr(>F)   
Weight     0.21971  1 12.9390 0.001324 **
DominanceZ 0.16137  1  9.5028 0.004811 **
Residuals  0.44150 26                    

m3 <- lm(mean_fWHR ~ Weight + Alpha, data=fWHR[fWHR$Age > 6,])

Anova(m3)
Anova Table (Type II tests)

Response: mean_fWHR
           Sum Sq Df F value  Pr(>F)   
Weight    0.26028  1 13.0140 0.00129 **
Alpha     0.08286  1  4.1429 0.05212 . 
Residuals 0.52001 26                   

anova(m3)
Analysis of Variance Table

Response: mean_fWHR
          Df  Sum Sq Mean Sq F value    Pr(>F)    
Weight     1 0.40060 0.40060 20.0298 0.0001342 ***
Alpha      1 0.08286 0.08286  4.1429 0.0521215 .  
Residuals 26 0.52001 0.02000                      



### Running age-sex model for: 6 < age > 20

m3 <- lm(mean_fWHR ~ I(Age^2) + Age * Sex, data=fWHR[fWHR$Age <= 20 & fWHR$Age > 6,])

anova(m3)

Response: mean_fWHR
          Df  Sum Sq  Mean Sq F value  Pr(>F)  
I(Age^2)   1 0.06478 0.064776  3.4030 0.07696 .
Age        1 0.00359 0.003586  0.1884 0.66799  
Sex        1 0.07652 0.076524  4.0202 0.05590 .
Age:Sex    1 0.09912 0.099124  5.2075 0.03127 *
Residuals 25 0.47587 0.019035                  

m3 <- lm(mean_fWHR ~ I(Age^2) + Weight + Age * Sex, data=fWHR[fWHR$Age <= 20 & fWHR$Age > 6,])
anova(m3)
Response: mean_fWHR
          Df  Sum Sq  Mean Sq F value  Pr(>F)  
I(Age^2)   1 0.06804 0.068036  3.0427 0.09815 .
Weight     1 0.18383 0.183833  8.2212 0.01024 *
Age        1 0.00040 0.000400  0.0179 0.89506  
Sex        1 0.01280 0.012802  0.5725 0.45904  
Age:Sex    1 0.03082 0.030821  1.3784 0.25568  
Residuals 18 0.40249 0.022361               

scatterplot(mean_fWHR ~ Age | Sex, data=fWHR[fWHR$Age <= 20 & fWHR$Age > 6,])

### Compute icc.s

source ("icc.R")
photos <- read.csv("Photo-iccs.csv", header = T)
summary(photos)
Items <- photos$fWHR
icc.reliability <- icc3.reliability (photos, Items, "Monkey", "Rater")
