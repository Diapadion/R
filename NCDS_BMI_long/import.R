### Import

library(readstata13)

setwd('M:/NCDS/')

ncds0123 <- read.dta13("ncds0123.dta", generate.factors = TRUE)


ncds4 <- read.dta13("ncds4.dta", generate.factors = FALSE)

ncds5 <- read.dta13("ncds5cmi.dta", generate.factors = FALSE)

ncds6 <- read.dta13("ncds6.dta", generate.factors = FALSE)

ncds7 <- read.dta13("ncds7.dta", generate.factors = FALSE)

ncds8 <- read.dta13("ncds_2008_followup.dta", generate.factors = FALSE)

#ncds9 <- read.dta13("ncds_2013_flatfile.dta", generate.factors = FALSE)
ncds9 <- read.dta13("ncds_2013_derived.dta", generate.factors = FALSE)


table(ncds0123$dvht16)


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

hist(ncds5$bmi33)

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

# Child SES sessionInfo
# + parental education
# + income
# + occupational status

## Social class = occupation
table(ncds0123$n1171)

## Pay
table(ncds0123$n2467)
table(ncds0123$n2465)
table(ncds0123$n2466)

table(ncds0123$n2462)

## School
table(ncds0123$n194)
table(ncds0123$n195) # *



### Merging them together

ncds = merge(ncds0123[,c('ncdsid','n622','n914','n917','n920','n923','n926',
                         'bmi16','n1171')], 
             ncds4[,c('ncdsid','bmi23')], by="ncdsid", all=TRUE)

ncds = merge(ncds,ncds5[,c('ncdsid','bmi33')], by="ncdsid", all=TRUE)
ncds = merge(ncds,ncds6[,c('ncdsid','bmi42')], by="ncdsid", all=TRUE)
ncds = merge(ncds,ncds9[,c('ncdsid','bmi55')], by="ncdsid", all=TRUE)


colnames(ncds)[2:7] <- c('sex','verbal','nonverbal','g','reading','maths')
colnames(ncds)[9] <- c('FatherSocialStatus')

ncds$g = as.numeric(ncds$g) - 2
ncds$g[ncds$g==-1] = NA

table(ncds$g)

ncds$sex[ncds$sex == 'Not known'] = NA
ncds$sex = droplevels(ncds$sex)

table(ncds$sex, useNA='ifany')


table(as.numeric(ncds$FatherSocialStatus))


### Getting rid of biologically implausible values
## seems like might be only necessary at ages 33 & 42
## Li et al. 2009: > 70, < 12

ncds$bmi33[ncds$bmi33 > 70] = NA
ncds$bmi33[ncds$bmi33 < 12] = NA

ncds$bmi42[ncds$bmi42 > 70] = NA
ncds$bmi42[ncds$bmi42 < 12] = NA

## some are also out of range for age 55
ncds$bmi55[ncds$bmi55 > 70] = NA
ncds$bmi55[ncds$bmi55 < 12] = NA



#######
hist(ncds9$ND9BMI)
sum(is.na(ncds9$ND9BMI))




View(ncds6[,'ht'])


max(ncds6$bmi42)


ncds6$ht = ncds6$htinches
  
  
ncds6$htmetre2 + ncds6$htcms


ncds4$dvwt23[ncds4$dvwt23==-1] = NA
ncds4$dvht23[ncds4$dvht23==-1] = NA
ncds4$bmi23 = ncds4$dvwt23 / (ncds4$dvht23^2)



hist(ncds4$bmi23)


#names(ncds4)[names(ncds4) == 'dvwt23'] <- 'weight'



table(ncds7$n7numwtr)

table(ncds9$N9HEIGHT)
