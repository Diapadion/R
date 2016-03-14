### Frailty ###

### this script includes the most advanced, up-to-date models
  # ... or should



frail.AFT <- survreg(yLt ~ as.factor(sex) + 
                          as.factor(origin) +  
                          Dom_CZ + Ext_CZ + Con_CZ + #E.resid3 +
                          Agr_CZ + Neu_CZ + Opn_CZ
                        + frailty(sample)
                        , data=datX, dist='t') # this model is NOT informed by LASSO

# O and E residulized

frail.AFT.EOr2 <- survreg(yLt ~ as.factor(sex) + 
                       as.factor(origin) +  
                       Dom_CZ + E.r2.DoB + Con_CZ + #E.resid3 +
                       Agr_CZ + Neu_CZ + O.r2.DoB
                       + frailty(sample)
                     , data=datX, dist='t') # this model is informed by LASSO


frail.cox.EOr2 <- coxph(yLt ~ as.factor(sex) + 
                            as.factor(origin) +  
                            Dom_CZ + E.r2.DoB + Con_CZ + #E.resid3 +
                            Agr_CZ + Neu_CZ + O.r2.DoB
                          + frailty(sample)
                          , data=datX) # this model is informed by LASSO


### No left truncation, but intervalized stuff instead

f.10.DoB <-  survreg(y ~ as.factor(sex) + 
                         as.factor(origin) + DoB +
                         Dom_CZ + Ext_CZ + Con_CZ +
                         Agr_CZ + Neu_CZ + Opn_CZ
                       + frailty(sample), data=Dataset,
                       dist = 'weibull')
                         
                         

f.10.age_pr <-  survreg(y ~ as.factor(sex) + 
                       as.factor(origin) + age_pr +
                     Dom_CZ + Ext_CZ + Con_CZ +
                       Agr_CZ + Neu_CZ + Opn_CZ
                     + frailty(sample), data=Dataset,
                     dist = 'weibull')

f.10.age <-  survreg(y ~ as.factor(sex) + 
                                as.factor(origin) + age +
                              Dom_CZ + Ext_CZ + Con_CZ +
                                Agr_CZ + Neu_CZ + Opn_CZ
                              + frailty(sample), data=Dataset,
                              dist = 'weibull')



### with the Japanese and Edi data included, we're having trouble with the basic frailty functions
require(coxme)

attr(yLt, 'type') <- 'counting'
#attr(yLt, 'type') <- 'mcounting'

coxme.1 <- coxme(yLt ~ as.factor(sex) + 
                       as.factor(origin) +  
                       Dom_CZ + Ext_CZ + Con_CZ + #E.resid3 +
                       Agr_CZ + Neu_CZ + Opn_CZ
                     + (1 | sample)
                     , data=datX)
