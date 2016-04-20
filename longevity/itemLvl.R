library(survival)
library(bbmle)


# Item level analyses

attr(yLt, 'type') <- 'mcounting'



f.E.items <- survreg(yLt ~ as.factor(sex) + 
                       as.factor(origin) +  
                       Dom_CZ + Con_CZ +
                       Agr_CZ + Neu_CZ + Opn_CZ
                     + actv + play + lazy + depr + sol + soc
                     + depr + frdy + affc + imit
                       + frailty.gaussian(sample)
                     + strata(strt)
                     , data=datX, dist='logistic')


f.A.items <- survreg(yLt ~ as.factor(sex) + 
                       as.factor(origin) +  
                       Dom_CZ + Con_CZ +
                       Ext_CZ + Neu_CZ + Opn_CZ
                     + symp + help + sens + prot + gntl + Conv
                     + frailty.gaussian(sample)
                     + strata(strt)
                     , data=datX, dist='logistic')



f.D.items <- survreg(yLt ~ as.factor(sex) + 
                       as.factor(origin) +  
                       Ext_CZ + Con_CZ +
                       Agr_CZ + Neu_CZ + Opn_CZ
                     + dom + subm + depd + indp + fear + decs + tim
                     + caut + intll + pers + buly + stngy + manp
                     + frailty.gaussian(sample)
                     + strata(strt)
                     , data=datX, dist='logistic')





