### Descriptives



library(doBy)



## Total numbers
table(df$vax.cat, useNA='ifany')


## Age
summaryBy(df, formula = j_age_dv ~ vax.cat, FUN = c(mean,sd), na.rm=TRUE)
t.test(j_age_dv ~ vax.cat, df)


## Sex (female)
summaryBy(df, formula = female ~ vax.cat, FUN = c(sum), na.rm=TRUE)
#sum(!is.na(df$female))
#rev(table(df$vax.cat) )
summaryBy(df, formula = female ~ vax.cat, FUN = c(sum), na.rm=TRUE) / rev(table(df$vax.cat))
chisq.test(df$female, df$vax.cat)
  

## Non-white
summaryBy(df, formula = non.white ~ vax.cat, FUN = c(sum), na.rm=TRUE)
summaryBy(df, formula = non.white ~ vax.cat, FUN = c(sum), na.rm=TRUE) / rev(table(df$vax.cat))
chisq.test(df$non.white, df$vax.cat)


## Higher education
summaryBy(df, formula = HigherEd ~ vax.cat, FUN = c(sum), na.rm=TRUE)
summaryBy(df, formula = HigherEd ~ vax.cat, FUN = c(sum), na.rm=TRUE) / rev(table(df$vax.cat))
chisq.test(df$HigherEd, df$vax.cat)


## Occupational social class
summaryBy(df, formula = low.soc.class ~ vax.cat, FUN = c(sum), na.rm=TRUE)
summaryBy(df, formula = low.soc.class ~ vax.cat, FUN = c(sum), na.rm=TRUE) / rev(table(df$vax.cat))
chisq.test(df$low.soc.class, df$vax.cat) 


## Cardiometabolic conditions
df$cmds.int = as.integer(df$cmds)-1
summaryBy(df, formula = cmds.int ~ vax.cat, FUN = c(sum), na.rm=TRUE)
summaryBy(df, formula = cmds.int ~ vax.cat, FUN = c(sum), na.rm=TRUE) / rev(table(df$vax.cat))
chisq.test(df$cmds.int, df$vax.cat) 


## Respiratory conditions
df$respir.int = as.integer(df$respir)-1
summaryBy(df, formula = respir.int ~ vax.cat, FUN = c(sum), na.rm=TRUE)
summaryBy(df, formula = respir.int ~ vax.cat, FUN = c(sum), na.rm=TRUE) / rev(table(df$vax.cat))
chisq.test(df$respir.int, df$vax.cat) 


## Cancer
summaryBy(df, formula = cancer ~ vax.cat, FUN = c(sum), na.rm=TRUE)
summaryBy(df, formula = cancer ~ vax.cat, FUN = c(sum), na.rm=TRUE) / rev(table(df$vax.cat))
chisq.test(df$cancer, df$vax.cat) 


## Cognitive function
df$g.100 = scale(df$g)*15 + 100
summaryBy(df, formula = g.100 ~ vax.cat, FUN = c(mean,sd), na.rm=TRUE)
t.test(g.100 ~ vax.cat, df)


## Psychological distress
summaryBy(df, formula = cf_scghq1_dv ~ vax.cat, FUN = c(mean,sd), na.rm=TRUE)
t.test(cf_scghq1_dv ~ vax.cat, df)


