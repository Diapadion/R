### Import and process datasheet




### TODO: move to proper location, wherever that is
datX$sex = as.factor(datX$sex)
datX$origin = as.factor(datX$origin)

# table(datX$origin)





y = Surv(age_pr, age, status)
