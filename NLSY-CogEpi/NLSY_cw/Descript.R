### Descriptives



### TODO: Will need a table here...



colnames(ht.df)

sum(ht.df$SAMPLE_SEX=='MALE')
sum(ht.df$SAMPLE_SEX=='FEMALE')

# IQ
aggregate(AFQT89 ~ SAMPLE_SEX, data=ht.df, FUN=mean)
aggregate(AFQT89 ~ SAMPLE_SEX, data=ht.df, FUN=sd)
sum(ht.df$SAMPLE_SEX=='MALE'&!is.na(ht.df$AFQT89))
sum(ht.df$SAMPLE_SEX=='FEMALE'&!is.na(ht.df$AFQT89))

# Child SES
aggregate(Child_SES ~ SAMPLE_SEX, data=ht.df, FUN=mean)
aggregate(Child_SES ~ SAMPLE_SEX, data=ht.df, FUN=sd)
sum(ht.df$SAMPLE_SEX=='MALE'&!is.na(ht.df$Child_SES))
sum(ht.df$SAMPLE_SEX=='FEMALE'&!is.na(ht.df$Child_SES))

# Adult SES
aggregate(Adult_SES ~ SAMPLE_SEX, data=ht.df, FUN=mean)
aggregate(Adult_SES ~ SAMPLE_SEX, data=ht.df, FUN=sd)
sum(ht.df$SAMPLE_SEX=='MALE'&!is.na(ht.df$Adult_SES))
sum(ht.df$SAMPLE_SEX=='FEMALE'&!is.na(ht.df$Adult_SES))

# Income
aggregate(SES_Income_USE ~ SAMPLE_SEX, data=ht.df, FUN=mean)
aggregate(SES_Income_USE ~ SAMPLE_SEX, data=ht.df, FUN=sd)
sum(ht.df$SAMPLE_SEX=='MALE'&!is.na(ht.df$SES_Income_USE))
sum(ht.df$SAMPLE_SEX=='FEMALE'&!is.na(ht.df$SES_Income_USE))

# # Individual Income
aggregate(indiv_income ~ SAMPLE_SEX, data=ht.df, FUN=mean)
aggregate(indiv_income ~ SAMPLE_SEX, data=ht.df, FUN=sd)
sum(ht.df$SAMPLE_SEX=='MALE'&!is.na(ht.df$indiv_income))
sum(ht.df$SAMPLE_SEX=='FEMALE'&!is.na(ht.df$indiv_income))

# Education
aggregate(SES_Education_USE ~ SAMPLE_SEX, data=ht.df, FUN=mean)
aggregate(SES_Education_USE ~ SAMPLE_SEX, data=ht.df, FUN=sd)
sum(ht.df$SAMPLE_SEX=='MALE'&!is.na(ht.df$SES_Education_USE))
sum(ht.df$SAMPLE_SEX=='FEMALE'&!is.na(ht.df$SES_Education_USE))

# Occupation Status
aggregate(SES_OccStatus_USE ~ SAMPLE_SEX, data=ht.df, FUN=mean)
aggregate(SES_OccStatus_USE ~ SAMPLE_SEX, data=ht.df, FUN=sd)
sum(ht.df$SAMPLE_SEX=='MALE'&!is.na(ht.df$SES_OccStatus_USE))
sum(ht.df$SAMPLE_SEX=='FEMALE'&!is.na(ht.df$SES_OccStatus_USE))

# Hypertension
table(ht.df$hasHT,ht.df$SAMPLE_SEX)

hist(ht.df$HTage50t[ht.df$hasHT])

#aggregate(HTage50t ~ SAMPLE_SEX, data=ht.df[ht.df$hasHT,], FUN=mean)
#aggregate(HTage50t ~ SAMPLE_SEX, data=ht.df[ht.df$hasHT,], FUN=sd)

## FIXED:
aggregate(recordTime ~ SAMPLE_SEX, data=ht.df[ht.df$hasHT,], FUN=mean)
aggregate(recordTime ~ SAMPLE_SEX, data=ht.df[ht.df$hasHT,], FUN=sd)



## Questions of overlap

table(ht.df$hasHT,is.na(ht.df$Adult_SES))

table(ht.df$hasHT,is.na(ht.df$SES_Income_USE))
table(ht.df$hasHT,is.na(ht.df$SES_Income_a))
table(ht.df$hasHT,is.na(ht.df$SES_Income_b))

table(ht.df$hasHT,is.na(ht.df$SES_Education_USE))
table(ht.df$hasHT,is.na(ht.df$SES_Education_a))






table(ht.df$SAMPLE_SEX, ht.df$hasHT)

aggregate()


table(ht.df$SAMPLE_SEX, ht.df$hasHT)



table(ht.df$indiv_income[ht.df$SAMPLE_SEX=='FEMALE'])
table(ht.df$indiv_income[ht.df$SAMPLE_SEX=='MALE'])




## Analytic sample descriptives

sum(ht.df[ccs,]$SAMPLE_SEX=='MALE')
sum(ht.df[ccs,]$SAMPLE_SEX=='FEMALE')

# IQ
aggregate(AFQT89 ~ SAMPLE_SEX, data=ht.df[ccs,], FUN=mean)
aggregate(AFQT89 ~ SAMPLE_SEX, data=ht.df[ccs,], FUN=sd)

# Child SES
aggregate(Child_SES ~ SAMPLE_SEX, data=ht.df[ccs,], FUN=mean)
aggregate(Child_SES ~ SAMPLE_SEX, data=ht.df[ccs,], FUN=sd)

# Adult SES
aggregate(Adult_SES ~ SAMPLE_SEX, data=ht.df[ccs,], FUN=mean)
aggregate(Adult_SES ~ SAMPLE_SEX, data=ht.df[ccs,], FUN=sd)

# Income
aggregate(SES_Income_USE ~ SAMPLE_SEX, data=ht.df[ccs,], FUN=mean)
aggregate(SES_Income_USE ~ SAMPLE_SEX, data=ht.df[ccs,], FUN=sd)

# Education
aggregate(SES_Education_USE ~ SAMPLE_SEX, data=ht.df[ccs,], FUN=mean)
aggregate(SES_Education_USE ~ SAMPLE_SEX, data=ht.df[ccs,], FUN=sd)

# Occupation Status
aggregate(SES_OccStatus_USE ~ SAMPLE_SEX, data=ht.df[ccs,], FUN=mean)
aggregate(SES_OccStatus_USE ~ SAMPLE_SEX, data=ht.df[ccs,], FUN=sd)

# Hypertension
table(ht.df[ccs,]$hasHT,ht.df[ccs,]$SAMPLE_SEX)

hist(ht.df[ccs,]$HTage50t[ht.df[ccs,]$hasHT])

## FIXED:
aggregate(recordTime ~ SAMPLE_SEX, data=ht.df[ccs,][ht.df[ccs,]$hasHT,], FUN=mean)
aggregate(recordTime ~ SAMPLE_SEX, data=ht.df[ccs,][ht.df[ccs,]$hasHT,], FUN=sd)




### Revision 2, Table S2 - looking at analyzed and non-analyzed, collapsed by sex

## IQ
mean(ht.df$AFQT[ccs]) # analytic
sd(ht.df$AFQT[ccs])
mean(ht.df$AFQT[!ccs], na.rm=TRUE) # not
sd(ht.df$AFQT[!ccs], na.rm=TRUE)

## Youth SES
mean(ht.df$Child_SES[ccs]) # analytic
sd(ht.df$Child_SES[ccs])
mean(ht.df$Child_SES[!ccs], na.rm=TRUE) # not
sd(ht.df$Child_SES[!ccs], na.rm=TRUE)

## Adult SES
mean(ht.df$Adult_SES[ccs]) # analytic
sd(ht.df$Adult_SES[ccs])
mean(ht.df$Adult_SES[!ccs], na.rm=TRUE) # not
sd(ht.df$Adult_SES[!ccs], na.rm=TRUE)

## Family income
mean(ht.df$SES_Income_USE[ccs]) # analytic
sd(ht.df$SES_Income_USE[ccs])
mean(ht.df$SES_Income_USE[!ccs], na.rm=TRUE) # not
sd(ht.df$SES_Income_USE[!ccs], na.rm=TRUE)

## Education
mean(ht.df$SES_Education_USE[ccs]) # analytic
sd(ht.df$SES_Education_USE[ccs])
mean(ht.df$SES_Education_USE[!ccs], na.rm=TRUE) # not
sd(ht.df$SES_Education_USE[!ccs], na.rm=TRUE)

## Occupation
mean(ht.df$SES_OccStatus_USE[ccs]) # analytic
sd(ht.df$SES_OccStatus_USE[ccs])
mean(ht.df$SES_OccStatus_USE[!ccs], na.rm=TRUE) # not
sd(ht.df$SES_OccStatus_USE[!ccs], na.rm=TRUE)

## Hypertension diagnoses
table(ht.df$hasHT[ccs], useNA='ifany') # analytic
table(ht.df$hasHT[ccs],ht.df$SAMPLE_SEX[ccs], useNA='ifany')

table(ht.df$hasHT[!ccs], useNA='ifany') # analytic
table(ht.df$hasHT[!ccs],ht.df$SAMPLE_SEX[!ccs], useNA='ifany')

## Sample totals, table tops
table(ht.df$SAMPLE_SEX[ccs], useNA='ifany')
table(ht.df$SAMPLE_SEX[!ccs], useNA='ifany')





### Flow chart

## This needs to be run specially, without running the code before creating 'hasHT'

flow.df <- merge(cw.df, ht.df[c('R0000100','H0004600','H0017200','hasHT')],
  by.x='CASEID_1979', by.y='R0000100')

## Total sample
dim(flow.df)

## Complete Cases
flow.ccs = complete.cases(flow.df[,c('AFQT89','Adult_SES','Child_SES','hasHT','SAMPLE_SEX')])
table(flow.ccs)

## Odd cases
table(flow.df$H0017300[ht.df$H0017300 == -1 & flow.ccs]) # None, nor for -4 either.
table(flow.df$H0017301[ht.df$H0017301 == -1 & flow.ccs]) # None, nor for -4 either.

table(flow.df$H0004700[ht.df$H0004700 == -1 & flow.ccs]) # None, nor for -4 either.
table(flow.df$H0004701[ht.df$H0004701 == -4 & flow.ccs]) # None, nor for -4 either.

## Diagnoses before testing - again, needs to be run before removing 'indxs'

table(as.numeric(as.Date("1970-01-01")) > as.numeric(ht.df$HTdiagDate[flow.ccs]))


## Men and women, normo and hypertensive
table(ccs.df$hasHT)
table(ccs.df$hasHT[ccs.df$SAMPLE_SEX=='MALE'])
table(ccs.df$hasHT[ccs.df$SAMPLE_SEX=='FEMALE'])



### Some pub correlations

cor(ht.df$Child_SES, ht.df$AFQT89, use='complete.obs')

cor(ht.df$Adult_SES, ht.df$AFQT89, use='complete.obs')

cor(ht.df$indiv_income, ht.df$AFQT89, use='complete.obs')
cor(ht.df$SES_Income_USE, ht.df$AFQT89, use='complete.obs')


cor(ht.df$Adult_SES[ht.df$SAMPLE_SEX=='MALE'], ht.df$AFQT89[ht.df$SAMPLE_SEX=='MALE'], use='complete.obs')
cor(ht.df$Adult_SES[ht.df$SAMPLE_SEX=='FEMALE'], ht.df$AFQT89[ht.df$SAMPLE_SEX=='FEMALE'], use='complete.obs')


cor(as.numeric(ht.df$age_1979), ht.df$AFQT89, use='complete.obs')
