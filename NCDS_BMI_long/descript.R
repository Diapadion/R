### Descriptive statistics
### (for the paper)
### run after importation



library(psych)



###

### People (Caucasians) in analytic samples

table(ncds$n2017) # NCDS

table(nlsy$SAMPLE_ethnicity)



### Descriptive table - run before income standardization

describe(ncds[,c('bmi23','bmi33','bmi42','bmi55','sex','g','Youth_SES',#'actagel2',
                 'education',
                 'income23','income33','income42','income50')])
table(ncds$sex)


nlsy$weekl.i.85 = nlsy$income.85 / 52
nlsy$weekl.i.94 = nlsy$income.94 / 52
nlsy$weekl.i.06 = nlsy$income.06 / 52
nlsy$weekl.i.14 = nlsy$income.14 / 52
describe(nlsy[,c('bmi_85','bmi_94','bmi_06','bmi_14','weekl.i.85','weekl.i.94','weekl.i.06','weekl.i.14','g','Youth_SES','education','sex')])
table(nlsy$sex)




hist(ncds$income23)
hist(ncds$income33)
hist(ncds$income42)
hist(ncds$income50)
hist(ncds$income55)



hist(nlsy$income.85)
hist(nlsy$income.94)
hist(nlsy$income.06)
hist(nlsy$income.14)

median(nlsy$income.85 / 52, na.rm=TRUE)
median(nlsy$income.94 / 52, na.rm=TRUE)
median(nlsy$income.06 / 52, na.rm=TRUE)
median(nlsy$income.14 / 52, na.rm=TRUE)


median(ncds$income42, na.rm=TRUE)


### NCDS age 50 vs 55 income discrepancies

#hist(income.42$income42)
hist(income.50$income50)
hist(income.55$income55)

summary(income.50$income50)
summary(income.55$income55)


## 9789 values at 50
## 9137 values at 55








### Some incidental math stuff
### Deaths in 2015, due to high BMI
## source: World Bank


## US (source: IMF)
US.wom = 162221534
US.men = 158818305

72.67 * US.men/100000 + 50.08 * US.wom/100000



## UK (source: World Bank)
UK.wom = 33029518
UK.men = 32099343

51.32 * UK.men/100000 + 30.13 * UK.wom/100000
