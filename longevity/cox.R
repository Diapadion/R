# Cox models instead

library(survival)

attr(y, 'type') <- 'right'
cox.m <- coxph(themodel)



attr(yLt, 'type')

cox.trunc <- coxph(yLt ~ as.factor(sex) + as.factor(origin) + as.factor(LvZ) + 
                                    Dom_CZ + Ext_CZ + Con_CZ +
                                    Agr_CZ + Neu_CZ + Opn_CZ,  data=datX
                                  #dist = "t"
)

anova(cox.trunc)

cox.trunc.x <- coxph(yLt ~ as.factor(sex) + as.factor(origin) + as.factor(LvZ) + 
                     Dom_CZ + Ext_CZ + Con_CZ +
                     Agr_CZ + Neu_CZ + Opn_CZ + Ext_CZ:DoB,  data=datX
             
)

anova(cox.trunc.x,cox.trunc)

# predictable time-dependent covariate: Extraversion

pfit1 <- coxph(Surv(time, status==2) ~ log(bili) + ascites + age, pbc)
pfit2 <- coxph(Surv(time, status==2) ~ log(bili) + ascites + tt(age),
                 data=pbc,
                 tt=function(x, t, ...) {
                   age <- x + t/365.25
                   cbind(age=age, age2= (age-50)^2, age3= (age-50)^3)
                 })

# what is the best model for tt'ing extraversion

plot(Ext_CZ ~ age_pr, data=datX)
fit.e <- lm(Ext_CZ ~ age_pr, data=Dataset)
summary(fit.e)

fit.e2 <- lm(Ext_CZ ~ age_pr + I(age_pr^2), data=Dataset)
summary(fit.e2)

anova(fit.e, fit.e2)

cox.tt <- coxph(yLt ~ as.factor(sex) + as.factor(origin) + as.factor(LvZ) + 
                   Dom_CZ + tt(Ext_CZ) + Con_CZ +
                   Agr_CZ + Neu_CZ + Opn_CZ
                 , tt=function(x,t,...){
                   Ext = x - 2*t
                   
                   #pspline(x + t)
                 }
                 
                 , data=datX
)

cox.tt2 <- coxph(yLt ~ as.factor(sex) + as.factor(origin) + as.factor(LvZ) + 
                               Dom_CZ +  tt(Ext_CZ) + Con_CZ +
                               Agr_CZ + Neu_CZ + Opn_CZ
                 , tt=function(x,t,...){
                   Ext = x - t
                   cbind(Ext = Ext, Ext2 = (Ext-1)^2)
                   
                   #pspline(x + t)
                 }
                   
                , data=datX, x=TRUE
)

tt.deets = coxph.detail(cox.tt2)

summary(cox.tt2)
anova(cox.tt2)

ll = 2*(cox.tt$loglik - cox.trunc$loglik)[2]
ll = 2*(cox.tt2$loglik - cox.trunc$loglik)[2]
ll
dchisq(ll, 2)


