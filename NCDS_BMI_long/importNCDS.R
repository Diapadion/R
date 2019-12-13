### Import

library(readstata13)
library(psych)
library(dplyr)
library(magrittr)
library(ggplot2)
source("https://raw.githubusercontent.com/janhove/janhove.github.io/master/RCode/sortLvls.R")


options(max.print=10000)



setwd('C:/Users/daltschu/Dropbox/NCDS data/')

ncds0123 <- read.dta13("ncds0123.dta", generate.factors = TRUE)

ncds4 <- read.dta13("ncds4.dta", generate.factors = FALSE)

ncds5 <- read.dta13("ncds5cmi.dta", generate.factors = FALSE)

ncds6 <- read.dta13("ncds6.dta", generate.factors = FALSE)

ncds7 <- read.dta13("ncds7.dta", generate.factors = FALSE)

ncds8 <- read.dta13("ncds_2008_followup.dta", generate.factors = FALSE)

#ncds9 <- read.dta13("ncds_2013_flatfile.dta", generate.factors = FALSE)
ncds9 <- read.dta13("ncds_2013_derived.dta", generate.factors = FALSE)
ncds9.1 <- read.dta13("ncds_2013_flatfile.dta", generate.factors = FALSE)



### Basic BMI (etc) pre-processing

## Note: ultimately, we will only be using ages
## 23 (swp.4), 33 (swp.5), 42 (swp.6), and 55 (swp.9)


## Age 16
ncds0123$dvwt16[ncds0123$dvwt16==-1] = NA
ncds0123$dvht16[ncds0123$dvht16==-1] = NA
ncds0123$bmi16 = ncds0123$dvwt16 / (ncds0123$dvht16^2)

## Age 23
ncds4$dvwt23[ncds4$dvwt23==-1] = NA
ncds4$dvht23[ncds4$dvht23==-1] = NA
ncds4$bmi23 = ncds4$dvwt23 / (ncds4$dvht23^2)

## Age 33
ncds5$n504731[ncds5$n504731<50] = NA
ncds5$n504731[ncds5$n504731>250] = NA
ncds5$n504731 = ncds5$n504731 / 100
ncds5$n504734[ncds5$n504734<30] = NA # this needs review - would 40 be better?
ncds5$n504734[ncds5$n504734>400] = NA
ncds5$bmi33 = ncds5$n504734 / (ncds5$n504731^2)

hist(ncds5$bmi33, breaks=20)

table(ncds6$htfeet)
table(ncds6$htmetres)

## Feet + inches (2) 
## then proxy # second feet doesn't need NA fixing
## (Centi)meters (2) # doesn't need NA fixing
  
## Age 42
ncds6$htinche2[ncds6$htinche2==99] = NA
ncds6$htinches[ncds6$htinches==99] = NA
ncds6$htfeet2[ncds6$htfeet2==8] = NA
ncds6$ht = 0.3048 * (ncds6$htinche2/12 + ncds6$htfeet2)
ncds6$ht[is.na(ncds6$ht)] = 0.3048 * (ncds6$htinches[is.na(ncds6$ht)]/12 + ncds6$htfeet[is.na(ncds6$ht)])
ncds6$ht[is.na(ncds6$ht)] = ncds6$htcms2[is.na(ncds6$ht)]/100 + ncds6$htmetre2[is.na(ncds6$ht)]

ncds6$wtstone2[ncds6$wtstone2>98] = NA
ncds6$wtpound2[ncds6$wtpound2>98] = NA
ncds6$wt = 0.4536 * (ncds6$wtstone2 * 14 + ncds6$wtpound2)
ncds6$wt[is.na(ncds6$wt)] = 0.4536 * (ncds6$wtstones[is.na(ncds6$wt)] * 14 + ncds6$wtpounds[is.na(ncds6$wt)])
ncds6$wt[is.na(ncds6$wt)] = ncds6$wtkilos2[is.na(ncds6$wt)]
ncds6$wt[is.na(ncds6$wt)] = ncds6$wtkilos[is.na(ncds6$wt)]

ncds6$bmi42 = ncds6$wt / (ncds6$ht^2)

sum(is.na(ncds6$bmi42))

hist(ncds6$bmi42)



## no weight/height data for sweep 7


## Age 50
## very few observations here, probably skip
table(ncds8$N8HTINES)



## Age 55
ncds9$ND9BMI[ncds9$ND9BMI<0] = NA
ncds9$ND9BMI[ncds9$ND9BMI>80] = NA
names(ncds9)[names(ncds9) == 'ND9BMI'] <- 'bmi55'
names(ncds9)[names(ncds9) == 'NCDSID'] <- 'ncdsid'



### COVARIATES

### Education
ncds6$actagel2[ncds6$actagel2==99] = NA
hist(ncds6$actagel2)


### Early life: birth to age 7 (possibly 11) 

## Child SES sessionInfo
## + parental education
## + income
## + occupational status

## Bridger & Daly, 2017
## + F social class at birth
table(ncds0123$n236)

## + F social class, age 7
table(ncds0123$n190)

## + when F left education
table(ncds0123$n194)
table(ncds0123$n195)
sum(ncds0123$n194=='No' & ncds0123$n195=='0', na.rm=TRUE)

## + when M left education
table(ncds0123$n537) # represents current age also, I believe
## can't seem to get more detail

## + housing tenure, age 7
table(ncds0123$n200)

## + persons per room, age 7
table(ncds0123$n607)


## Social class = occupation
#table(ncds0123$n1171)

## Pay - not enough datapoints
# table(ncds0123$n2467)
# table(ncds0123$n2465)
# table(ncds0123$n2466)
# table(ncds0123$n2462)


### Later life SES

## Income
## These are the derived variables from Bozena and Alissa at UCL ##

income.23 = read.dta13("./UCL-income/NCDS1981_final.dta", generate.factors = TRUE)
income.33 = read.dta13("./UCL-income/NCDS1991_final.dta", generate.factors = TRUE)
income.42 = read.dta13("./UCL-income/NCDS2000_final.dta", generate.factors = TRUE)
income.50 = read.dta13("./UCL-income/NCDS2008_final.dta", generate.factors = TRUE)
income.55 = read.dta13("./UCL-income/NCDS2013_final.dta", generate.factors = TRUE)

colnames(income.23)[c(1,16)] = c("ncdsid","income23")
colnames(income.33)[c(1,20)] = c("ncdsid","income33")
colnames(income.42)[c(1,20)] = c("ncdsid","income42")
colnames(income.50)[c(1,20)] = c("ncdsid","income50")
colnames(income.55)[c(1,12)] = c("ncdsid","income55")



# ## Age 23
# head(table(ncds4$famnet, useNA='ifany'))
# hist(ncds4$famnet) # net family income per *week*
# 
# 
# ## Age 33
# 
# ## have to make myself, which sucks
# table(ncds5$n500536, useNA='ifany') # usual take home pay
# table(ncds5$n500542, useNA='ifany') # usual take home pay period
# 
# table(ncds5$n501060) # partner usual take home pay
# table(ncds5$n501066) # partner take home pay period
# 
# 
# 
# 
# ## Age 42
# 
# ## unclear if the data are available
# hist(ncds6$cnetpay)
# 
# table(ncds6$cnetpay, useNA='ifany')
# hist(ncds6$cnetpay)
# sum(table(ncds6$cnetpay))
# 
# table(ncds6$cnetprd, useNA='ifany')
# 
# table(ncds6$pnetpay, useNA='ifany')
# table(ncds6$pnetprd, useNA='ifany')
# 
# 
# 
# ## Age 55
# 
# hist(ncds9.1$N9INCAMT)
# table(ncds9.1$N9INCAMT, useNA='ifany')
# table(ncds9.1$N9INCADR, useNA='ifany')
# 
# table(ncds9.1$N9INCPER, useNA='ifany')
# table(ncds9.1$N9INCP2, useNA='ifany')



### Merging them together
### - can restart from here 

ncds = merge(ncds0123[,c('ncdsid','n622','n914','n917','n920','n923','n926','bmi16',
                         'n236','n190','n194','n195','n537','n200','n607',
                         'n1612','n2017')], 
             ncds4[,c('ncdsid','bmi23','famnet')], by="ncdsid", all=TRUE)
ncds = merge(ncds,ncds5[,c('ncdsid','bmi33','n500536','n500542','n501060','n501066')], by="ncdsid", all=TRUE)
ncds = merge(ncds,ncds6[,c('ncdsid','bmi42','actagel2',
                           'cnetpay','cnetprd','pnetpay','pnetprd')], by="ncdsid", all=TRUE)
ncds = merge(ncds,ncds9[,c('ncdsid','bmi55')], by="ncdsid", all=TRUE)
names(ncds9.1)[names(ncds9.1) == 'NCDSID'] <- 'ncdsid'
ncds = merge(ncds,ncds9.1[,c('ncdsid','N9INCAMT')], by='ncdsid', all=TRUE)

ncds = merge(ncds,income.23[,c('ncdsid','income23')], by='ncdsid', all=TRUE)
ncds = merge(ncds,income.33[,c('ncdsid','income33')], by='ncdsid', all=TRUE)
ncds = merge(ncds,income.42[,c('ncdsid','income42')], by='ncdsid', all=TRUE)
ncds = merge(ncds,income.50[,c('ncdsid','income50')], by='ncdsid', all=TRUE)
ncds = merge(ncds,income.55[,c('ncdsid','income55')], by='ncdsid', all=TRUE)



colnames(ncds)[2:7] <- c('sex','verbal','nonverbal','g','reading','maths')



### Processing - move down?




### Filtering

## Sex

#table(ncds$sex)
ncds$sex[ncds$sex == 'Not known'] = NA
ncds$sex = droplevels(ncds$sex)

# table(ncds$sex, useNA='ifany')







## Getting rid of biologically implausible values:
## seems like might be only necessary at ages 33 & 42
## Li et al. 2009: > 70, < 12

## How many?
length(which((ncds$bmi23 > 70) | (ncds$bmi23 < 12)))
length(which((ncds$bmi33 > 70) | (ncds$bmi33 < 12)))
length(which((ncds$bmi42 > 70) | (ncds$bmi42 < 12)))
length(which((ncds$bmi55 > 70) | (ncds$bmi55 < 12)))


ncds$bmi23[ncds$bmi23 > 70] = NA
ncds$bmi23[ncds$bmi23 < 12] = NA

ncds$bmi33[ncds$bmi33 > 70] = NA
ncds$bmi33[ncds$bmi33 < 12] = NA

ncds$bmi42[ncds$bmi42 > 70] = NA
ncds$bmi42[ncds$bmi42 < 12] = NA

## some are also out of range for age 55
ncds$bmi55[ncds$bmi55 > 70] = NA
ncds$bmi55[ncds$bmi55 < 12] = NA



# ncds = ncds[!(ncds$bmi23 > 70),]
# ncds = ncds[!(ncds$bmi23 < 12),]
# 
# ncds = ncds[!(ncds$bmi33 > 70),]
# ncds = ncds[!(ncds$bmi33 < 12),]
# 
# ncds = ncds[!(ncds$bmi42 > 70),]
# ncds = ncds[!(ncds$bmi42 < 12),]
# 
# ncds = ncds[!(ncds$bmi55 > 70),]
# ncds = ncds[!(ncds$bmi55 < 12),]



### Post-processing covariates

## IQ
# table(ncds$verbal, useNA='ifany')
# table(ncds$nonverbal, useNA='ifany')
# table(ncds$reading, useNA='ifany')
# table(ncds$maths, useNA='ifany')
# tail(table(ncds$verbal, ncds$nonverbal, useNA='ifany'))
# table(ncds$g, useNA='ifany')

# omega(as.numeric(ncds[,c('verbal','nonverbal','reading','maths')]))

ncds$g = as.numeric(ncds$g) - 2
ncds$g[ncds$g==-1] = NA
 
table(ncds$g, useNA='ifany')
sum(table(ncds$g))



## Adult education

table(ncds$actagel2)



## Adult income





# ## -Age 23
# # 'n4262','n4267','n5164','n5169')
# table(ncds$famnet, useNA='ifany') # per WEEK
# 
# summary(ncds$famnet)
# 
# 
# 
# ## - Age 33 -
# 
# ## - usual take home pay
# table(ncds$n500536, useNA='ifany') 
# ncds$n500536[ncds$n500536 > 900000] = NA
# 
# ## - usual take home pay period
# table(ncds$n500542, useNA='ifany') 
# ## scale income by pay period:
# ncds$n500536[ncds$n500542=='1 week'&!is.na(ncds$n500542)] = 
#   ncds$n500536[ncds$n500542=='1 week'&!is.na(ncds$n500542)]/7
# ncds$n500536[ncds$n500542=='Fortnight'&!is.na(ncds$n500542)] = 
#   ncds$n500536[ncds$n500542=='Fortnight'&!is.na(ncds$n500542)]/14
# ncds$n500536[ncds$n500542=='Four weeks'&!is.na(ncds$n500542)] = 
#   ncds$n500536[ncds$n500542=='Four weeks'&!is.na(ncds$n500542)]/28
# ncds$n500536[ncds$n500542=='Calendar month'&!is.na(ncds$n500542)] = 
#   ncds$n500536[ncds$n500542=='Calendar month'&!is.na(ncds$n500542)]/30.44
# ncds$n500536[ncds$n500542=='Year'&!is.na(ncds$n500542)] = 
#   ncds$n500536[ncds$n500542=='Year'&!is.na(ncds$n500542)]/365.25
# ncds$n500536[ncds$n500542=='Other'&!is.na(ncds$n500542)] = NA
# ## income is now per DAY
# 
# table(ncds$n500536[!is.na(ncds$n500542)])
# 
# 
# 
# table(ncds$n501060) # partner usual take home pay
# ncds$n501060[ncds$n501060 > 900000] = NA
# 
# 
# table(ncds$n501066) # partner take home pay period
# 
# ncds$n501060[ncds$n501066=='1 week'&!is.na(ncds$n501066)] = 
#   ncds$n501060[ncds$n501066=='1 week'&!is.na(ncds$n501066)]/7
# ncds$n501060[ncds$n501066=='Fortnight'&!is.na(ncds$n501066)] = 
#   ncds$n501060[ncds$n501066=='Fortnight'&!is.na(ncds$n501066)]/14
# ncds$n501060[ncds$n501066=='Four weeks'&!is.na(ncds$n501066)] = 
#   ncds$n501060[ncds$n501066=='Four weeks'&!is.na(ncds$n501066)]/28
# ncds$n501060[ncds$n501066=='Calendar month'&!is.na(ncds$n501066)] = 
#   ncds$n501060[ncds$n501066=='Calendar month'&!is.na(ncds$n501066)]/30.44
# ncds$n501060[ncds$n501066=='Year'&!is.na(ncds$n501066)] = 
#   ncds$n501060[ncds$n501066=='Year'&!is.na(ncds$n501066)]/365.25
# ncds$n501060[ncds$n501066=='Other'&!is.na(ncds$n501066)] = NA
# 
# tail(table(ncds$n501060[!is.na(ncds$n501066)]))
# hist(ncds$n501060[!is.na(ncds$n501066)])
# 
# 
# names(ncds)[names(ncds) == 'n500536'] <- 'usual.income.33'
# names(ncds)[names(ncds) == 'n501060'] <- 'partner.income.33'
# 
# ncds$usual.income.33 = ncds$usual.income.33 * 7 # making it per WEEK
# ncds$partner.income.33 = ncds$partner.income.33 * 7 # making it per WEEK
# 
# tail(table(ncds$partner.income.33))
# 
# ncds$net.income.33 = apply(ncds[c('usual.income.33','partner.income.33')],1,sum,na.rm=TRUE)
# ncds$net.income.33[ncds$net.income.33==0] = NA
#   
# sum(table(ncds$net.income.33,useNA='ifany'))
# 
# tail(table(ncds$net.income.33,useNA='ifany'))
# 
# summary(ncds$net.income.33)
# 
# 
# 
# ## - Age 42 -
# ## - take home (net) pay
# table(ncds$cnetpay, useNA='ifany')
# ncds$cnetpay[ncds$cnetpay > 900000] = NA
# #hist(ncds$cnetpay)
# #sum(table(ncds$cnetpay))
# 
# table(ncds$cnetprd, useNA='ifany')
# 
# ncds$cnetpay[ncds$cnetprd=='One week'&!is.na(ncds$cnetprd)] = 
#   ncds$cnetpay[ncds$cnetprd=='One week'&!is.na(ncds$cnetprd)]/7
# ncds$cnetpay[ncds$cnetprd=='A fortnight'&!is.na(ncds$cnetprd)] = 
#   ncds$cnetpay[ncds$cnetprd=='A fortnight'&!is.na(ncds$cnetprd)]/14
# ncds$cnetpay[ncds$cnetprd=='Four weeks'&!is.na(ncds$cnetprd)] = 
#   ncds$cnetpay[ncds$cnetprd=='Four weeks'&!is.na(ncds$cnetprd)]/28
# ncds$cnetpay[ncds$cnetprd=='A calendar month'&!is.na(ncds$cnetprd)] = 
#   ncds$cnetpay[ncds$cnetprd=='A calendar month'&!is.na(ncds$cnetprd)]/30.44
# ncds$cnetpay[ncds$cnetprd=='A year or'&!is.na(ncds$cnetprd)] = 
#   ncds$cnetpay[ncds$cnetprd=='A year or'&!is.na(ncds$cnetprd)]/365.25
# ncds$cnetpay[ncds$cnetprd=='Other period'&!is.na(ncds$cnetprd)] = NA
# 
# tail(table(ncds$cnetpay)) #[!is.na(ncds$cnetprd)])
# 
# 
# 
# ## partner's take home (net) pay
# 
# table(ncds6$pnetpay, useNA='ifany')
# table(ncds6$pnetprd, useNA='ifany')
# 
# ## - Age 55 - 
# ## 
# tail(table(ncds$N9INCAMT))





## SES

# table(ncds$n236)
ncds$SoClass0 = sortLvls.fnc(ncds$n236, c(8,7,6,5,4,3,2,1))
ncds$SoClass0[ncds$SoClass0=='Unemployed,sick'] = NA
ncds$SoClass0[ncds$SoClass0=='NA,NMH'] = NA
ncds$SoClass0 <- droplevels(ncds$SoClass0)
ncds$SoClass0 <- as.ordered(ncds$SoClass0)
# table(ncds$SoClass0)

# table(ncds$n190)
ncds$SoClass7 = sortLvls.fnc(ncds$n190, c(2,9,8,7,6,5,4,3,1))
ncds$SoClass7[ncds$SoClass7=='NA, unclear'] = NA
ncds$SoClass7 <- droplevels(ncds$SoClass7)
ncds$SoClass7 <- as.ordered(ncds$SoClass7)
# table(ncds$SoClass7)

# table(ncds$n194)
ncds$Fleave = sortLvls.fnc(ncds$n194, c(4,3,1,2))
ncds$Fleave[ncds$Fleave=='NA'] = NA
ncds$Fleave[ncds$Fleave=='Dont know'] = NA
ncds$Fleave <- droplevels(ncds$Fleave)
ncds$Fleave <- as.ordered(ncds$Fleave)
# table(ncds$Fleave)

# table(ncds$n537)
ncds$Mleave = ncds$n537
levels(ncds$Mleave) = c(NA,'No','No','Yes','Yes','No','Yes',NA,NA)
# table(ncds$Mleave)

ncds$Fleave = sortLvls.fnc(ncds$n194, c(4,3,1,2))
ncds$Fleave[ncds$Fleave=='NA'] = NA
ncds$Fleave[ncds$Fleave=='Dont know'] = NA
ncds$Fleave <- droplevels(ncds$Fleave)
ncds$Fleave <- as.ordered(ncds$Fleave)
# table(ncds$Fleave)

# table(ncds0123$n200)
ncds$Housing = sortLvls.fnc(ncds$n200, c(6,4,5,3,1,2,7))
levels(ncds$Housing)[5:7] <- c(NA,NA,NA)
ncds$Housing = as.ordered(ncds$Housing)
# table(ncds$Housing)

# table(ncds$n607)
ncds$PpRoom7 = ncds$n607
levels(ncds$PpRoom7)[1] = NA
ncds$PpRoom7 = sortLvls.fnc(ncds$PpRoom7, c(4,3,2,1))
ncds$PpRoom7 = as.ordered(ncds$PpRoom7)
# table(ncds$PpRoom7)



## Making Youth SES

ncds$Youth_SES = rowMeans(cbind(scale(as.numeric(ncds$SoClass0)),scale(as.numeric(ncds$SoClass7)), 
                         scale(as.numeric(ncds$Fleave)),scale(as.numeric(ncds$Mleave)), 
                         scale(as.numeric(ncds$PpRoom7)),scale(as.numeric(ncds$Housing)))
                      , na.rm=TRUE)
ncds$Youth_SES = scale(ncds$Youth_SES)
hist(ncds$Youth_SES)



### Remaining standardizations

ncds$g = scale(ncds$g)

ncds$education = scale(ncds$actagel2)
table(ncds$education, useNA='ifany')



### Ethnicity

## Set aside full df
ncds.all = ncds

# n1612
# n2017
table(ncds.all$n1612, useNA='ifany')
table(ncds.all$n2017, useNA='ifany')
table(ncds.all$n1612, ncds.all$n2017, useNA='ifany')



## 'Others' - not used
# ncds.other = ncds[ncds$n2017!='Euro-Caucasian',] 
# ncds.other = ncds.other[ncds.other$n2017!='NA',] 
# ncds.other = ncds.other[!is.na(ncds.other$n2017),] 
# table(ncds.other$n2017, useNA='ifany')

ncds = ncds[ncds$n2017!='African-Negroid',]
ncds = ncds[ncds$n1612!='African,negroid',]
ncds = ncds[ncds$n2017!='Indian-Pakistan',]
ncds = ncds[ncds$n1612!='Indian,Pakistani',]
ncds = ncds[ncds$n2017!='Other Asian',]
ncds = ncds[ncds$n1612!='Other Asian',]
ncds = ncds[ncds$n2017!='Other or unsure',]
ncds = ncds[ncds$n1612!='Other',]
ncds = ncds[ncds$n2017!='Mixed race',]

ncds = ncds[(ncds$n2017!='NA')|(ncds$n1612!='NA'),]
# still need to take out NAs
ncds = ncds[!is.na(ncds$n2017),]

table(ncds$n1612, ncds$n2017, useNA='ifany')


table(!is.na(ncds$bmi55))



### Where are the missing values?

summary(ncds[,c("bmi23","bmi33","bmi42","bmi55","sex","g","Youth_SES","education","income23","income33","income42","income50","income55")])




#######
# hist(ncds9$ND9BMI)
# sum(is.na(ncds9$ND9BMI))
# 
# 
# 
# 
# View(ncds6[,'ht'])
# 
# 
# max(ncds6$bmi42)
# 
# 
# ncds6$ht = ncds6$htinches
#   
#   
# ncds6$htmetre2 + ncds6$htcms
# 
# 
# ncds4$dvwt23[ncds4$dvwt23==-1] = NA
# ncds4$dvht23[ncds4$dvht23==-1] = NA
# ncds4$bmi23 = ncds4$dvwt23 / (ncds4$dvht23^2)
# 
# 
# 
# hist(ncds4$bmi23)
# 
# 
# #names(ncds4)[names(ncds4) == 'dvwt23'] <- 'weight'
# 
# 
# 
# table(ncds7$n7numwtr)
# 
# table(ncds9$N9HEIGHT)
