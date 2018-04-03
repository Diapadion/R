### Analysis of chimpanzee rearing history on longevity

library(survival)
library(psych)
library(rms)
library(parfm)



# Load file
rear <- read.csv(file = 'Yerkes aggregation/Yerkes-rearing.csv')


# Process data
rear$rearing = as.factor(rear$rearing)
levels(rear$rearing) <- c('Mother-reared','Nursery-reared','Wild-caught')

rear$sex = as.factor(rear$sex)

rear$DoB <- as.Date(rear$DoB,format='%m/%d/%Y')
rear$lastDate <- as.Date(rear$lastDate, format='%d/%m/%Y')

rear$age = as.numeric(difftime(rear$lastDate, rear$DoB, units = "weeks"))/52.25 

rear$status[(rear$status == 'LTF')] <- 'Alive' 

rear$stat.log <- droplevels(rear$status)

levels(rear$stat.log)[levels(rear$stat.log)=="Death"] <- TRUE
levels(rear$stat.log)[levels(rear$stat.log)=="Alive"] <- FALSE


rear = rear[!is.na(rear$age),]



### Checking for rearing, age confounding

summary(rear)
# chimp           ID                rearing   sex          DoB               status       lastDate         
# Abby   :  1   168    :  1   Mother-reared :94   0:114   Min.   :1940-02-24        :  0   Min.   :1992-09-22  
# Ada    :  1   170    :  1   Nursery-reared:91   1: 80   1st Qu.:1972-01-07   Alive: 87   1st Qu.:2007-02-17  
# Agatha :  1   188    :  1   Wild-caught   : 9           Median :1983-12-31   Death:107   Median :2015-01-23  
# Alice  :  1   190    :  1                               Mean   :1980-06-21   LTF  :  0   Mean   :2011-05-30  
# Alicia :  1   200    :  1                               3rd Qu.:1990-03-23               3rd Qu.:2016-02-09  
# Amanda :  1   (Other):165                               Max.   :2001-03-08               Max.   :2016-11-02  
# (Other):188   NA's   : 24                                                                                           

stripchart(DoB ~ rearing, data=rear, method='jitter', jitter = 0.2, offset = 0.1)

# Slightly greater variance in the distribution of DoBs among the mother-reared group, 
# but no discernable difference in means; no overt association with age.



### Survival analyses

survplot(npsurv(yR ~ rearing, data = rear), abbrev.label = T)
survplot(npsurv(yR ~ sex, data = rear), abbrev.label = T)
survplot(npsurv(yR ~ sex + rearing, data = rear), abbrev.label = T)

# Nursery-reared curve is shifted to the right (later mortality) of mother-reared.
# Too few individuals from the wild-caught group to say anything.
# Females live longer as well.

# Where the curves differ (particular re: sex), they aren't parallel, so a Cox model is not appropriate.



# Right censored survival object
rear$stat.log = as.numeric(rear$stat.log)
#table(rear$status)
rear$stat.log[rear$stat.log==3] = 1
rear$stat.log[rear$stat.log==2] = 0

yR = Surv(rear$age, rear$stat.log)
#attr(yR, 'type') <- 'right'

# Model 1: Just rearing characteristics
m.r.1 = survreg(yR ~ rearing, 
                data = rear, dist='weibull')
summary(m.r.1)
confint(m.r.1)




# Model 2: Add known predictor, sex
m.r.2 = survreg(yR ~ sex + rearing, 
                data = rear, dist='weibull')
summary(m.r.2)
confint(m.r.2)


anova(m.r.1,m.r.2)
# Model 2 is a better fit.



# Hazard ratios
HazRat1 = exp(coef(m.r.1) * -1 * 1/m.r.1$scale)

HazRat2 = exp(coef(m.r.2) * -1 * 1/m.r.2$scale)




