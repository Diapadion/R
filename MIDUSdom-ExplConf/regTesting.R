

library(regsem)
library(semTools) #runMI for imputation to deal with missingness in categorical models




m.regt.1 <-'
D =~  B1SE6O + B1SE6T + B1SE6J + B1SE6DD + B1SE6E 
+ B1SE7J 
#+ B1SE7N 
+ B1SE7DD 
+ B1SE7E
'



f.regt1.1 = cfa(m.regt.1, midus2,
                estimator="WLSMV" #, missing='fiml'
                , ordered=TRUE
                )

fitMeasures(f.regt1.1, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC','rmsea.ci.upper'))
summary(f.regt1.1)



?runMI

regsem(f.regt1.1)
