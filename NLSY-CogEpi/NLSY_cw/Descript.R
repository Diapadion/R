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

aggregate(HTage50t ~ SAMPLE_SEX, data=ht.df[ht.df$hasHT,], FUN=mean)
aggregate(HTage50t ~ SAMPLE_SEX, data=ht.df[ht.df$hasHT,], FUN=sd)



# Questions of overlap

table(ht.df$hasHT,is.na(ht.df$Adult_SES))

table(ht.df$hasHT,is.na(ht.df$SES_Income_USE))
table(ht.df$hasHT,is.na(ht.df$SES_Income_a))
table(ht.df$hasHT,is.na(ht.df$SES_Income_b))

table(ht.df$hasHT,is.na(ht.df$SES_Education_USE))
table(ht.df$hasHT,is.na(ht.df$SES_Education_a))






table(ht.df$SAMPLE_SEX, ht.df$hasHT)

aggregate()


table(ht.df$SAMPLE_SEX, ht.df$hasHT)
