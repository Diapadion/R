# Frailty




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

