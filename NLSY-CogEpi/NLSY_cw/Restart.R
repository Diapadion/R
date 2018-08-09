### Restarting the importation process to figure out where things are going wrong

library(readstata13)
library(ggplot2)
library(survival)
library(survminer)



### Importing

cw.df <- read.dta13(file = '0_NLSY_mainfile.dta')
# head(cw.df)



ht.df <- read.csv(file = "HT.csv")
# head(ht.df)
table(ht.df$H0004600)
table(ht.df$H0017200)
table(ht.df$H0017400)




### Processing HT diagnoses

## Age 50

ht.df$H0017300[ht.df$H0017300 == -4 | ht.df$H0017300 == -1] = NA
ht.df$H0017301[ht.df$H0017301 == -4 | ht.df$H0017301 == -1] = NA

ht.df$H0017300[ht.df$H0017300 == -2] = 12
ht.df$H0017300[ht.df$H0017301 == -2] = 06
ht.df$H0017301[ht.df$H0017301 == -2] = 2015 # ought to replace with SOURCEYR vars

pasteDate = paste3(ht.df$H0017301,ht.df$H0017300,'01',sep='-')
pasteDate[pasteDate == '01'] = NA 

ht.df$HTage50t = as.Date(pasteDate,sep='-')

sum(!is.na(ht.df$HTage50t))
hist(ht.df$HTage50t, breaks = 30)



## Age 40
## This needs to account for good data already filled in from age 50

sum(is.na(ht.df$HTage50t))
ht.df$H0004700[is.na(ht.df$HTage50t) & (ht.df$H0004700 == -4 | ht.df$H0004700 == -1)] = NA
ht.df$H0004701[is.na(ht.df$HTage50t) & (ht.df$H0004701 == -4 | ht.df$H0004701 == -1)] = NA

ht.df$H0004700[is.na(ht.df$HTage50t) & ht.df$H0004700 == -2] = 12
ht.df$H0004700[is.na(ht.df$HTage50t) & ht.df$H0004701 == -2] = 09
ht.df$H0004701[is.na(ht.df$HTage50t) & ht.df$H0004701 == -2] = 2006

pasteDate = paste3(ht.df$H0004701,ht.df$H0004700,'01',sep='-')
pasteDate[pasteDate == '01'] = NA 

## The below line should protect age 50 data
ht.df$HTage50t[is.na(ht.df$HTage50t)] = as.Date(pasteDate[is.na(ht.df$HTage50t)],sep='-')

sum(!is.na(ht.df$HTage50t))
hist(ht.df$HTage50t, breaks = 30)



### Assign censoring values - IS THIS THE KEY DIFFERENCE?

## The block below was replaced with the block yet further down.
ht.df$hasHT = TRUE
ht.df$hasHT[is.na(ht.df$HTage50t)] = FALSE
ht.df$HTage50t[is.na(ht.df$HTage50t)] = as.Date('2015-07-01')

table(ht.df$hasHT)


ht.df$hasHT = NA
ht.df$hasHT[(ht.df$H0004600==1 | ht.df$H0017200==1)] = TRUE
ht.df$hasHT[(ht.df$H0004600==0 & ht.df$H0017200==0)] = FALSE

table(ht.df$hasHT)
## Cuts out the non-respondents.



### Merging dfs

ht.df = merge(cw.df, ht.df[c('R0000100','R0172500','R0172600','T3977400',"T3977500","T3977600",
                             "T3955000", # weight - 2012
                             "T3955100", # height (ft) - 2012
                             "T3955200", # height (in) - 2012
                             "T3955300", # How often... vigorous activity
                             "T3955400", # How frequently... vigorous activity (increasing = less frequent)
                             "T3955600", # Length of time... vigorous activity
                             "T3955800", # How often... light/moderate activity
                             "T3955900", # How frequently... light/moderate activity (increasing = less frequent)
                             "T3956100", # Length of time... light/moderate activity
                             "T3956300", # How often... strength training
                             "T3956400", # How frequently... strength training (increasing = less frequent)
                             "T3975300", # Smoked at least 100 cigarettes
                             "T3975500", # Ever a daily smoker
                             "T3976400", # Number of drinks on average
                             "T3958000", # Trying to lose weight?
                             "T3958100", # Read nutritional info on food?
                             "T3958200", # Read ingredients on food?
                             "T3958300", # Times ate fast food in past 7 days
                             "T3958500", # Times snacked between meals in past 7 days
                             "T3958700", # Times skipping meal in 7 days
                             "T3958900", # Times having sugary drink in past 7 days
                             "R1773900", # height (in) - 1985
                             "R1774000", # weight - 1985
                             "T0897300", # weight - 2006
                             "T0897400", # height (ft) - 2006
                             "T0897500", # height (in) - 2006
                             'HTage50t','hasHT')], by.x='CASEID_1979', by.y='R0000100')


sum(complete.cases(ht.df[,c('AFQT89','Adult_SES','Child_SES','hasHT','SAMPLE_SEX')]))


### Rename some columns

colnames(ht.df)[71:73] <- c('month_79','day_79','indiv_income') 
colnames(ht.df)[c(80,83,86,87:89)] <- c('H_activity','LM_activity','Str_training',
                                        'Smoked_atLeast100','Smoked_everDaily','Drinks_avgDay')
colnames(ht.df)[c(76:78,97:101)] <- c('weight_12','feet_12','inches_12',
                                      'height_85','weight_85','weight_06','feet_06','inches_06')
colnames(ht.df)[c(90:96)] <- c('Trying_to_lose','Read_nutrition','Read_ingredients',
                               'Fast_food','Snacked','Skipped_meal','Sugary_drink')
# Keep an eye on the above - numeric indices may need adjustment



### A few BMI calculations

## BMI - 1985
ht.df$weight_85[ht.df$weight_85<0] = NA
ht.df$height_85[ht.df$height_85<0] = NA

ht.df$bmi_85 = ht.df$weight_85/(ht.df$height_85^2) * 703

## trim implausible values
ht.df$bmi_85[ht.df$bmi_85 > 70] = NA
ht.df$bmi_85[ht.df$bmi_85 < 12] = NA

## BMI - 2006

ht.df$weight_06[ht.df$weight_06<0] = NA

ht.df$height_06 = -1
ht.df$feet_06 = ht.df$feet_06*12

ht.df$height_06[ht.df$inches_06<12&ht.df$inches_06>-0.1] = rowSums(ht.df[,c('feet_06','inches_06')], na.rm=T)[ht.df$inches_06<12&ht.df$inches_06>-0.1]

ht.df$height_06[ht.df$height_06<32] = NA

ht.df$height_06[ht.df$inches_06>12] = ht.df$inches_06[ht.df$inches_06>12]

ht.df$bmi_06 = ht.df$weight_06/(ht.df$height_06^2) * 703

#hist(ht.df$bmi_06)

## trim implausible values
ht.df$bmi_06[ht.df$bmi_06 > 70] = NA
ht.df$bmi_06[ht.df$bmi_06 < 12] = NA



### DoB etc


ht.df$DOB = as.Date(paste3(paste0('19',as.numeric(levels(ht.df$DOB_year))[ht.df$DOB_year]),
                           as.numeric(levels(ht.df$DOB_month))[ht.df$DOB_month],
                           '01',sep='-'), format='%Y-%m-%d')
hist(ht.df$DOB, breaks=30)
sum(is.na(ht.df$DOB)) ## seems good...

## and below creattes correct age at 1979 survey calc
pasteDate = as.Date(paste3('1979',
                           ht.df$month_79,
                           '01',sep='-'), format='%Y-%m-%d')
ht.df$age_1979 = (pasteDate-ht.df$DOB)/365.25
head(ht.df$age_1979)



### Setting AGE when hypertension was diagnosed
ht.df$HTdiagDate = ht.df$HTage50t
ht.df$HTage50t = as.numeric(ht.df$HTage50t)
ht.df$HTage50t = ht.df$HTage50t/365.25

hist(ht.df$HTage50t)
## See negatives?
## This isn't centered properly yet, its based on POSIX 0 point...



### Remove 3 individuals who had HT from "birth"

indxs = which(as.numeric(as.Date("1970-01-01")) > as.numeric(ht.df$HTdiagDate))

ht.df = ht.df[-indxs,]

hist(ht.df$HTage50t)




### Initiating the survival analyses setup
### GD and CG revised

# View(ht.df[(as.numeric(ht.df$HTdiagDate-as.Date("1970-01-01"))<0),])

## What is happening here to change the models and plots???
ht.df$recordTime = as.numeric(ht.df$HTdiagDate-as.Date("1970-01-01"))/365.25
ht.df$recordTime = as.numeric(ht.df$HTdiagDate-ht.df$DOB)/365.25
## Swapping between these two seems not to be the solution, though it does do some interesting stuff

hist(ht.df$recordTime)



# y = Surv()
# A = !is.na(ht.df$hasHT) ## includes Yes and No, just not missing individuals
# yA = Surv(ht.df$recordTime[A], ht.df$hasHT[A])

table(ht.df$hasHT)

ccs = complete.cases(ht.df[,c('SAMPLE_SEX','AFQT89','age_1979','Child_SES','Adult_SES',
                              'SES_Income_USE','SES_OccStatus_USE','SES_Education_USE',
                              'hasHT','recordTime'
)])
table(ccs)
table(ht.df$hasHT[ccs])


### Plotting functions

## Creating tertile variable

ccs.df = ht.df[ccs,]

ccs.df$IQtert <- with(ccs.df,cut(AFQT89,
                               breaks=quantile(AFQT89, probs=seq(0,1, by=1/3), na.rm=TRUE),
                               include.lowest=TRUE))

table(ccs.df$IQtert, ccs.df$SAMPLE_SEX)

ccs.df$sex_tert = interaction(ccs.df$SAMPLE_SEX, ccs.df$IQtert)

levels(ccs.df$sex_tert) <- c('M-Low','F-Low','M-Mid','F-Mid','M-High','F-High')

# ht.df$IQtert <- with(ht.df,cut(AFQT89,
#                                breaks=quantile(AFQT89, probs=seq(0,1, by=1/3), na.rm=TRUE),
#                                include.lowest=TRUE))
# 
# table(ht.df$IQtert, ht.df$SAMPLE_SEX)
# 
# ht.df$sex_tert = interaction(ht.df$SAMPLE_SEX,ht.df$IQtert)
# 
# levels(ht.df$sex_tert) <- c('M-Low','F-Low','M-Mid','F-Mid','M-High','F-High')




#ggfit = survfit(Surv(recordTime, hasHT) ~ sex_tert, data=ht.df[ccs,])
ggfit = survfit(Surv(recordTime, hasHT) ~ sex_tert, data=ccs.df)

g <- ggsurvplot(ggfit, conf.int=T,censor=F
            , linetype = c(1,1,2,2,3,3)
            #, color = c(1,2,1,2,1,2)
            , palette = c('dodgerblue','violetred1','dodgerblue','violetred1','dodgerblue','violetred1')
            , legend = c(0.2, 0.2) #'none'
            , xlim = c(19,55), ylim = c(0.5,1)
            , break.x.by = 5
) 

#g

## The below aren't working. No idea why... 
## but it isn't important right now
#g = g + coord_cartesian(xlim=c(15,58),ylim=c(0.1,1.0))
g = g + xlab('Age') +ylab('Proportion that remains normotensive')
#g = g + xlim(c(15,58))

#theme(axis.title.y='Risk of developing hypertension', axis.title.x='Age')

g



#### ggsurvplot diagnostics
# 
fit<- survfit(Surv(time, status) ~ sex, data = lung)
fit
# 
# # Basic survival curves
gg = ggsurvplot(fit, data = lung)

gg + coord_cartesian(xlim=c(15,58),ylim=c(0.1,1.0))
