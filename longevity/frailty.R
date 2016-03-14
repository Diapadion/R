### Frailty ###

### this script includes the most advanced, up-to-date models
  # ... or should




attr(yLt, 'type') <- 'mcounting'


frail.AFT <- survreg(yLt ~ as.factor(sex) + 
                          as.factor(origin) +  
                          Dom_CZ + Ext_CZ + Con_CZ + #E.resid3 +
                          Agr_CZ + Neu_CZ + Opn_CZ
                        + frailty(sample)
                        , data=datX, dist='t') # this model is NOT informed by LASSO

# O and E residulized

frail.AFT.EOr2 <- survreg(yLt ~ as.factor(sex) + # this model is informed by LASSO
                       as.factor(origin) +  
                       Dom_CZ + E.r2.DoB + Con_CZ + 
                       Agr_CZ + Neu_CZ + O.r2.DoB
                       + frailty(sample)
                     , data=datX, dist='t')  # 'logistic' , 'extreme' , 't'

frail.AFT.EAD <- survreg(yLt ~ as.factor(sex) + # this model is informed by LASSO(s)
                            as.factor(origin) +  
                            Dom_CZ + E.r2.DoB + Agr_CZ
                          + frailty(sample)
                          , data=datX, dist='logistic') 





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





# Cox is basically useless for all this
frail.cox.EOr2 <- coxph(yLt ~ as.factor(sex) + 
                          as.factor(origin) +  
                          Dom_CZ + E.r2.DoB + Con_CZ + #E.resid3 +
                          Agr_CZ + Neu_CZ + O.r2.DoB
                        + frailty(sample)
                        , data=datX) # this model is informed by LASSO

require(coxme)

attr(yLt, 'type') <- 'counting'
#attr(yLt, 'type') <- 'mcounting'

coxme.1 <- coxme(yLt ~ as.factor(sex) + 
                       as.factor(origin) +  
                       Dom_CZ + Ext_CZ + Con_CZ +
                       Agr_CZ + Neu_CZ + Opn_CZ
                     + (1 | sample)
                     , data=datX)

coxme.2 <- coxme(yLt ~ as.factor(sex) + 
                   as.factor(origin) +  
                   Dom_CZ + E.r2.DoB + Con_CZ + 
                   Agr_CZ + Neu_CZ + O.r2.DoB
                 + (1 | sample)
                 , data=datX)

coxme.3 <- coxme(yLt ~ as.factor(sex) + 
                   as.factor(origin) +  
                   Dom_CZ + E.r2.DoB + Agr_CZ + 
                 + (1 | sample)
                 , data=datX)
