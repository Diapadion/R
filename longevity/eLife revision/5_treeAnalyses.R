### Conditional Inference (CI) survival trees

library(survival)
library(LTRCtrees)
library(rpart.plot)



### Trees

set.seed(123)



### Unadjusted

CI.u <- LTRCIT(Surv(age_pr, age, status) ~
                 sex + origin +  
                 Dom_CZ + Ext_CZ + Con_CZ +
                 Agr_CZ + Neu_CZ + Opn_CZ, 
                data = datX)



### Residualized

CI.r <- LTRCIT(Surv(age_pr, age, status) ~
                 sex + origin +  
                 D.gr + E.gr + C.gr +
                 A.gr + N.gr + O.gr, 
               data = datX)

## Figure 3:
plot(CI.u)

## Compare to:
plot(CI.r)
