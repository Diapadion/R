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


## new Model 7
aft.gd.3 = aftreg(y ~ SAMPLE_SEX * AFQT89 + age_1979 + Child_SES + Adult_SES
                  + SES_Income_USE
                  ,data = ht.df[A,], dist='loglogistic')
extractAIC(aft.gd.3)
summary(aft.gd.3)


## new Model 8
aft.gd.4 = aftreg(y ~ SAMPLE_SEX * AFQT89 + age_1979 + Child_SES + Adult_SES
                  + SES_Income_USE*SAMPLE_SEX
                  ,data = ht.df[A,], dist='loglogistic')
extractAIC(aft.gd.4)
summary(aft.gd.4)


## new Model 9
aft.gd.5 = aftreg(y ~ SAMPLE_SEX * AFQT89 + age_1979 + Child_SES + Adult_SES
                  + SES_Income_USE*SAMPLE_SEX + indiv_income
                  ,data = ht.df[A,], dist='loglogistic')
extractAIC(aft.gd.5)
summary(aft.gd.5)


## model S?
aft.gd.6 = aftreg(y ~ SAMPLE_SEX * AFQT89 + age_1979 + Child_SES + Adult_SES
                  + SES_Income_USE*SAMPLE_SEX + indiv_income*SAMPLE_SEX
                  ,data = ht.df[A,], dist='loglogistic')
extractAIC(aft.gd.6)
summary(aft.gd.6)



### Round 3

aft.gd.7a = aftreg(y ~ SAMPLE_SEX * AFQT89 + age_1979 + Child_SES + Adult_SES
                   + SES_Income_USE
                   ,data = ht.df[A,], dist='loglogistic')

aft.gd.7b = aftreg(y ~ SAMPLE_SEX * AFQT89 + age_1979 + Child_SES + Adult_SES
                   + indiv_income
                   ,data = ht.df[A,], dist='loglogistic')

extractAIC(aft.gd.7a)
extractAIC(aft.gd.7b)

summary(aft.gd.7a)
summary(aft.gd.7b)



aft.gd.8a = aftreg(y ~ SAMPLE_SEX * AFQT89 + age_1979 + Child_SES + Adult_SES
                   + SES_Income_USE*SAMPLE_SEX
                   ,data = ht.df[A,], dist='loglogistic')

aft.gd.8b = aftreg(y ~ SAMPLE_SEX * AFQT89 + age_1979 + Child_SES + Adult_SES
                   + indiv_income*SAMPLE_SEX
                   ,data = ht.df[A,], dist='loglogistic')

extractAIC(aft.gd.8a)
extractAIC(aft.gd.8b)

summary(aft.gd.8a)
summary(aft.gd.8b)


## Justify keeping vars in by removing sex * cognitive function interaction

aft.gd.7c = aftreg(y ~ SAMPLE_SEX + AFQT89 + age_1979 + Child_SES + Adult_SES
                   + SES_Income_USE*SAMPLE_SEX
                   ,data = ht.df[A,], dist='loglogistic')

aft.gd.8c = aftreg(y ~ SAMPLE_SEX + AFQT89 + age_1979 + Child_SES + Adult_SES
                   + indiv_income*SAMPLE_SEX
                   ,data = ht.df[A,], dist='loglogistic')

summary(aft.gd.7c)
summary(aft.gd.8c)



    




### Rethining family vs other income

ht.df$other_income = ht.df$SES_Income_USE - ht.df$indiv_income

hist(ht.df$other_income)
hist(ht.df$indiv_income)






### SES, income, by sex chart

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





### explained variance of models, after Chan et al. 2018

##                scale^2 * Var(e) 
## R^2 = 1 - ---------------------------
##           Var(ZtB) + scale^2 * Var(e)  

## Var(e) == pi^2 / 3 for log-logistic
## Var(ZtB) == ?

library(survival)


### R-squared df
r.df = ht.df
r.df$SAMPLE_SEX = as.numeric(r.df$SAMPLE_SEX)-1
r.df$age_1979 = as.numeric(r.df$age_1979)
table(r.df$age_1979)



### AFT regression - gaussian and lognormal sample
aft.2.g.r2 = survreg(y ~ SAMPLE_SEX + AFQT89 + age_1979 + Child_SES + lvIQsex,
       data = r.df[A,], dist='gaussian') 
aft.2.ln.r2 = survreg(y ~ SAMPLE_SEX + AFQT89 + age_1979 + Child_SES + lvIQsex,
                     data = r.df[A,], dist='lognormal') 

summary(aft.2.ln.r2)

tst = cov(r.df[A,c('SAMPLE_SEX','AFQT89','Child_SES')]
          #,na.rm=TRUE
          ,use='pairwise.complete.obs'
          )
tst


# R^2 

betaz <- as.matrix(aft.2.ln.r2$coefficient[-1])                 # coeff

varz <- as.matrix(var(r.df[A, c('SAMPLE_SEX','AFQT89','age_1979','Child_SES','lvIQsex')],
                      use='pairwise.complete.obs'))      # Cov-matrix

vary <- t(betaz) %*% varz %*% (betaz)                   # Var(Y) = Var(Z beta)

sigsq <- aft.2.ln.r2$scale ^2                                                                     # Var(epsilon) 

R2 = 1- sigsq/ (vary + sigsq)

R2


### Log-logistic extension

aft.2.ll.r2 = survreg(y ~ SAMPLE_SEX + AFQT89 + age_1979 + Child_SES + lvIQsex,
                      data = r.df[A,], dist='loglogistic') 


betaz <- as.matrix(aft.2.ll.r2$coefficient[-1])     # coeff

varz <- as.matrix(var(r.df[A, c('SAMPLE_SEX','AFQT89','age_1979','Child_SES','lvIQsex')],
                      use='pairwise.complete.obs'))      # Cov-matrix

vary <- t(betaz) %*% varz %*% (betaz)    # Var(Y) = Var(Z beta)

sigsq <- aft.2.ll.r2$scale^2 * 3            # Var(epsilon) 

R2 = 1- sigsq/ (vary + sigsq)

R2


## Seems to be working fine!



### Now for the actual models

aft.ll.r2 = survreg(y ~ SAMPLE_SEX + AFQT89 + age_1979,
                      data = r.df[A,], dist='loglogistic') 
betaz <- as.matrix(aft.ll.r2$coefficient[-1])                 # coeff
varz <- as.matrix(var(r.df[A, c('SAMPLE_SEX','AFQT89','age_1979')],
                      use='pairwise.complete.obs'))      # Cov-matrix
vary <- t(betaz) %*% varz %*% (betaz)                   # Var(Y) = Var(Z beta)
sigsq <- aft.ll.r2$scale^2 * 3                                                                 # Var(epsilon) 
R2.0 = 1- sigsq/ (vary + sigsq)
R2.0

aft.ll.r2 = survreg(y ~ SAMPLE_SEX + AFQT89 + age_1979 + lvIQsex,
         data = r.df[A,], dist='loglogistic')
betaz <- as.matrix(aft.ll.r2$coefficient[-1])                 # coeff
varz <- as.matrix(var(r.df[A, c('SAMPLE_SEX','AFQT89','age_1979','lvIQsex')],
                      use='pairwise.complete.obs'))      # Cov-matrix
vary <- t(betaz) %*% varz %*% (betaz)                   # Var(Y) = Var(Z beta)
sigsq <- aft.ll.r2$scale^2 * 3                                                                 # Var(epsilon) 
R2.1 = 1- sigsq/ (vary + sigsq)
R2.1

aft.ll.r2 = survreg(y ~ SAMPLE_SEX + AFQT89 + age_1979 + lvIQsex + Child_SES,
                    data = r.df[A,], dist='loglogistic')
betaz <- as.matrix(aft.ll.r2$coefficient[-1])                 # coeff
varz <- as.matrix(var(r.df[A, c('SAMPLE_SEX','AFQT89','age_1979','lvIQsex','Child_SES')],
                      use='pairwise.complete.obs'))      # Cov-matrix
vary <- t(betaz) %*% varz %*% (betaz)                   # Var(Y) = Var(Z beta)
sigsq <- aft.ll.r2$scale^2 * 3                                                                 # Var(epsilon) 
R2.2 = 1- sigsq/ (vary + sigsq)
R2.2

aft.ll.r2 = survreg(y ~ SAMPLE_SEX + AFQT89 + age_1979 + lvIQsex + Child_SES + Adult_SES,
                    data = r.df[A,], dist='loglogistic')
betaz <- as.matrix(aft.ll.r2$coefficient[-1])                 # coeff
varz <- as.matrix(var(r.df[A, c('SAMPLE_SEX','AFQT89','age_1979','lvIQsex','Child_SES','Adult_SES')],
                      use='pairwise.complete.obs'))      # Cov-matrix
vary <- t(betaz) %*% varz %*% (betaz)                   # Var(Y) = Var(Z beta)
sigsq <- aft.ll.r2$scale^2 * 3                                                                 # Var(epsilon) 
R2.3 = 1- sigsq/ (vary + sigsq)
R2.3 ## Note the decline here - this is probably due to the sharp change in the dataset

aft.ll.r2 = survreg(y ~ SAMPLE_SEX + AFQT89 + age_1979 + lvIQsex + Child_SES + SES_Income_USE,
                    data = r.df[A,], dist='loglogistic')
betaz <- as.matrix(aft.ll.r2$coefficient[-1])                 # coeff
varz <- as.matrix(var(r.df[A, c('SAMPLE_SEX','AFQT89','age_1979','lvIQsex','Child_SES','SES_Income_USE')],
                      use='pairwise.complete.obs'))      # Cov-matrix
vary <- t(betaz) %*% varz %*% (betaz)                   # Var(Y) = Var(Z beta)
sigsq <- aft.ll.r2$scale^2 * 3                                                                 # Var(epsilon) 
R2.4inc = 1- sigsq/ (vary + sigsq)
R2.4inc ## decline is gone - that Adult SES var has some real issues...

aft.ll.r2 = survreg(y ~ SAMPLE_SEX + AFQT89 + age_1979 + lvIQsex + Child_SES + SES_Education_USE,
                    data = r.df[A,], dist='loglogistic')
betaz <- as.matrix(aft.ll.r2$coefficient[-1])                 # coeff
varz <- as.matrix(var(r.df[A, c('SAMPLE_SEX','AFQT89','age_1979','lvIQsex','Child_SES','SES_Education_USE')],
                      use='pairwise.complete.obs'))      # Cov-matrix
vary <- t(betaz) %*% varz %*% (betaz)                   # Var(Y) = Var(Z beta)
sigsq <- aft.ll.r2$scale^2 * 3                                                                 # Var(epsilon) 
R2.5edu = 1- sigsq/ (vary + sigsq)
R2.5edu

aft.ll.r2 = survreg(y ~ SAMPLE_SEX + AFQT89 + age_1979 + lvIQsex + Child_SES + SES_OccStatus_USE,
                    data = r.df[A,], dist='loglogistic')
betaz <- as.matrix(aft.ll.r2$coefficient[-1])                 # coeff
varz <- as.matrix(var(r.df[A, c('SAMPLE_SEX','AFQT89','age_1979','lvIQsex','Child_SES','SES_OccStatus_USE')],
                      use='pairwise.complete.obs'))      # Cov-matrix
vary <- t(betaz) %*% varz %*% (betaz)                   # Var(Y) = Var(Z beta)
sigsq <- aft.ll.r2$scale^2 * 3                                                                 # Var(epsilon) 
R2.6occ = 1- sigsq/ (vary + sigsq)
R2.6occ

aft.ll.r2 = survreg(y ~ SAMPLE_SEX + AFQT89 + age_1979 + lvIQsex + Child_SES + 
                      Adult_SES + SES_Income_USE, 
                    , data = r.df[A,], dist='loglogistic')
betaz <- as.matrix(aft.ll.r2$coefficient[-1])                 # coeff
varz <- as.matrix(var(r.df[A, c('SAMPLE_SEX','AFQT89','age_1979','lvIQsex','Child_SES',
                                'Adult_SES','SES_Income_USE')],
                      use='pairwise.complete.obs'))      # Cov-matrix
vary <- t(betaz) %*% varz %*% (betaz)                   # Var(Y) = Var(Z beta)
sigsq <- aft.ll.r2$scale^2 * 3                                                                 # Var(epsilon) 
R2.7 = 1- sigsq/ (vary + sigsq)
R2.7


r.df$lvIncSex = r.df$SES_Income_USE * (as.numeric(ht.df$SAMPLE_SEX)-1)
aft.ll.r2 = survreg(y ~ SAMPLE_SEX + AFQT89 + age_1979 + lvIQsex + Child_SES + Adult_SES + 
                      SES_Income_USE + lvIncSex 
                    , data = r.df[A,], dist='loglogistic')
betaz <- as.matrix(aft.ll.r2$coefficient[-1])                 # coeff
varz <- as.matrix(var(r.df[A, c('SAMPLE_SEX','AFQT89','age_1979','lvIQsex','Child_SES',
                                'Adult_SES','SES_Income_USE','lvIncSex')],
                      use='pairwise.complete.obs'))      # Cov-matrix
vary <- t(betaz) %*% varz %*% (betaz)                   # Var(Y) = Var(Z beta)
sigsq <- aft.ll.r2$scale^2 * 3                                                                 # Var(epsilon) 
R2.8 = 1- sigsq/ (vary + sigsq)
R2.8

