### Geoff Der's suggested additons

library(eha)
library(ggplot2)



## Round 1


# Youth SES x sex

aft.2.gd = aftreg(y ~ SAMPLE_SEX * AFQT89 + age_1979 + Child_SES * SAMPLE_SEX,
                          data = ht.df, dist='loglogistic') 
extractAIC(aft.2.gd)
summary(aft.2.gd)
# No effect.



# Adult SES x sex

aft.3.gd = aftreg(y ~ SAMPLE_SEX * AFQT89 + age_1979 + Child_SES + Adult_SES * SAMPLE_SEX,
                  data = ht.df, dist='loglogistic') 
extractAIC(aft.3.gd)
summary(aft.3.gd)
# No effect. Income is better.



# SES x income interaction

aft.7.gd = aftreg(y ~ SAMPLE_SEX * AFQT89 + age_1979 + Child_SES + Adult_SES*indiv_income
                  + incIQint #+ indiv_income*SAMPLE_SEX
                  ,data = ht.df, dist='loglogistic')
extractAIC(aft.7.gd)
summary(aft.7.gd)
# Nothing for the Adult SES x Income interaction.



## Round 2

## This is mostly for including Income as a variable alongside Adult SES and the interaction with sex.

# ht.df$incSESint = ht.df$SES_Income_USE * ht.df$Adult_SES
# 
# aft.gd.2 = aftreg(y ~ SAMPLE_SEX * AFQT89 + age_1979 + Child_SES + Adult_SES
#                   + incSESint + incIQint #+ indiv_income*SAMPLE_SEX
#                   ,data = ht.df, dist='loglogistic')
# extractAIC(aft.gd.2)
# summary(aft.gd.2)
# 
# aft.gd.3 = aftreg(y ~ SAMPLE_SEX * AFQT89 + age_1979 + Child_SES + Adult_SES
#                   + incSESint + incIQint + indiv_income*SAMPLE_SEX
#                   ,data = ht.df, dist='loglogistic')
# extractAIC(aft.gd.3)
# summary(aft.gd.3)


aft.gd.4 = aftreg(y ~ SAMPLE_SEX * AFQT89 + age_1979 + Child_SES + Adult_SES
                  + SES_Income_USE*SAMPLE_SEX
                  ,data = ht.df[A,], dist='loglogistic')
extractAIC(aft.gd.4)
summary(aft.gd.4)








# Rethining family vs other income

ht.df$other_income = ht.df$SES_Income_USE - ht.df$indiv_income

hist(ht.df$other_income)



# SES, income, by sex chart

ggplot(ht.df, aes(Adult_SES, indiv_income)) +
  geom_hex() + facet_grid(. ~ SAMPLE_SEX)
ggplot(subset(ht.df, SAMPLE_SEX=='FEMALE'), aes(Adult_SES, indiv_income)) + geom_hex()

ggplot(ht.df, aes(Adult_SES, indiv_income)) +
  stat_density_2d(geom='polygon', aes(fill=..level..)) +
  facet_grid(. ~ SAMPLE_SEX) +
  theme_bw() + xlim(-1.7,1.7) + ylim(-1.5,2.1) +
  xlab('Adult SES') +
  ylab('Individual Income') + 
  stat_smooth(method='gam', se=FALSE)





