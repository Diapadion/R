### Import and process datasheet



datX = read.csv('eLife-chimpLong.csv')



### Convert numerics to factors
datX$sex = as.factor(datX$sex)
datX$sample = as.factor(datX$sample)



### Make centred and scaled variables
datX$Dom_CZ <- scale(datX$Dom)
datX$Ext_CZ <- scale(datX$Ext)
datX$Con_CZ <- scale(datX$Con)
datX$Agr_CZ <- scale(datX$Agr)
datX$Neu_CZ <- scale(datX$Neu)
datX$Opn_CZ <- scale(datX$Opn)


## Special


# y = Surv(age_pr, age, status)
