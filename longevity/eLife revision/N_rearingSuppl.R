### Analysis of chimpanzee rearing history on longevity

library(survival)
library(psych)
library(rms)
library(parfm)


### Load file
rear <- read.csv(file = 'eLife-chimpRear.csv')



### Process data
rear$rearing = as.factor(rear$rearing)
levels(rear$rearing) <- c('Mother-reared','Nursery-reared','Wild-caught')

rear$sex = as.factor(rear$sex)



### Checking for rearing, age confounding

summary(rear)
#      X                    rearing   sex         status            age        
#Min.   :  1.00   Mother-reared :94   0:114   Min.   :0.0000   Min.   : 8.427  
#1st Qu.: 49.25   Nursery-reared:91   1: 80   1st Qu.:0.0000   1st Qu.:22.899  
#Median : 97.50   Wild-caught   : 9           Median :1.0000   Median :27.964  
#Mean   : 97.59                               Mean   :0.5515   Mean   :30.897  
#3rd Qu.:145.75                               3rd Qu.:1.0000   3rd Qu.:38.688  
#Max.   :195.00                               Max.   :1.0000   Max.   :61.846                                                                                        

stripchart(age ~ rearing, data=rear, method='jitter', jitter = 0.2, offset = 0.1)

## Slightly greater variance in the distribution of DoBs among the mother-reared group, 
## but no discernable difference in means; no overt association with age.



## Make a right censored survival object
yR = Surv(rear$age, rear$status)


### Survival plots and analyses

survplot(npsurv(yR ~ rearing, data = rear), abbrev.label = T)
survplot(npsurv(yR ~ sex, data = rear), abbrev.label = T)
survplot(npsurv(yR ~ sex + rearing, data = rear), abbrev.label = T)

## Nursery-reared curve overlaps and twice crosses the mother-reared curve.
## There are too few individuals from the wild-caught group to say anything.
## Females live longer as well.

## Where the curves differ, they aren't parallel, so a Cox model is not appropriate.



## Model 1: Just rearing characteristics
m.r.1 = survreg(yR ~ rearing, 
                data = rear, dist='weibull')
summary(m.r.1)
confint(m.r.1)



## Model 2: Add known predictor, sex
m.r.2 = survreg(yR ~ sex + rearing, 
                data = rear, dist='weibull')
summary(m.r.2)
confint(m.r.2)


anova(m.r.1,m.r.2)
## Model 2 is a better fit.



## Hazard ratios
HazRat1 = exp(coef(m.r.1) * -1 * 1/m.r.1$scale)

HazRat2 = exp(coef(m.r.2) * -1 * 1/m.r.2$scale)




