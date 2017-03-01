# Cox models instead

library(survival)

attr(y, 'type') <- 'right'
attr(y, 'type') <- 'mright'
cox.m <- coxph(themodel)


attr(yLt, 'type') <- 'counting'
#attr(yLt, 'type') <- 'mcounting'

cox.trunc <- coxph(yLt ~ as.factor(sex) + as.factor(origin) + #as.factor(LvZ) + 
                                    Dom_CZ + Ext_CZ + Con_CZ +
                                    Agr_CZ + Neu_CZ + Opn_CZ,  data=datX,
                   #control=list(maxiter = 1000)
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

# what is the best model for tt'ing extraversion?

plot(Dataset$Ext_CZ ~ Dataset$DoB)

fit.e2 <- lm(Ext_CZ ~ as.numeric(DoB) + I(as.numeric(DoB)^2), data=Dataset)

fit.e <- lm(Ext_CZ ~ age_pr_adj, data=Dataset)
summary(fit.e)
abline(fit.e)

fit.e2 <- lm(Ext_CZ ~ scale(age_pr_adj) + I(scale(age_pr_adj)^2), data=Dataset)
summary(fit.e2)
lines(predict(fit.e2, data.frame(age_pr_adj = 1:55)))


# Quadratic is the better model

# in general, E

# want to predict what E would have been if all were the same age

Dataset$adjE <- scale(Dataset$age_pr_adj) - Dataset$Ext_CZ 
plot(adjE ~ Ext_CZ, data=Dataset)
plot(adjE ~ age_pr_adj, data=Dataset)

plot(Ext_CZ ~ age_pr_adj, data=Dataset)

# try again 
# Dataset$adjE <- scale(Dataset$Ext_CZ-scale(1/(1 + Dataset$age_pr_adj)))
# which way?
# Dataset$adjE <- scale(1/scale(Dataset$age_pr_adj) - Dataset$Ext_CZ)




cox.trunc.adjE <- coxph(yLt ~ as.factor(sex) + as.factor(origin) + as.factor(LvZ) + 
                       Dom_CZ + adjE + Con_CZ +
                       Agr_CZ + Neu_CZ + Opn_CZ,  data=datX
                     
)

fit.e <- lm(Ext_CZ ~ adjE, data=Dataset)
summary(fit.e)
abline(fit.e)

fit.e2 <- lm(Ext_CZ ~ adjE + I(adjE^2), data=Dataset)
summary(fit.e2)
#plot(Ext_CZ, fitted(fit.e2), type="l", data=datX)
#abline(fit.e2)
lines(predict(fit.e2, data.frame(age_pr = scale(1:55), Ext_CZ = scale(1:55))))

predict(fit.e2, data.frame(adjE = 0:4))


fit.e3 <- lm(Ext_CZ ~ adjE + I(adjE^2) + I(adjE^3), data=Dataset)
summary(fit.e3)
lines(predict(fit.e3, data.frame(
  age_pr = 1:55)))

anova(fit.e, fit.e2, fit.e3)

cox.tt <- coxph(yLt ~ as.factor(sex) + as.factor(origin) + as.factor(LvZ) + 
                   Dom_CZ + tt(Ext_CZ) + Con_CZ +
                   Agr_CZ + Neu_CZ + Opn_CZ
                 , tt=function(x,t,...){
                   #Ext = x - scale(1/(t + 1))
                   #pspline(x + t, df= 2, nterm = 3)
                   cbind(x, x - t)
                 }
                 , data=datX
)

cox.tt2 <- coxph(yLt ~ as.factor(sex) + as.factor(origin) + as.factor(LvZ) + 
                   Dom_CZ +  tt(Ext_CZ) + Con_CZ +
                   Agr_CZ + Neu_CZ + Opn_CZ
                 , tt=function(x,t,...){
                   # Ext = x - scale(1/(t + 1))   # to scale or not to scale
                   # cbind(Ext = Ext, Ext2 = (Ext)^2)
                   
                   scale(pspline(x + t))
                 }
                 , data=datX, x=TRUE
)


zp <- cox.zph(cox.trunc)
#zp <- cox.zph(vfit, transform= function(time) log(time +20))
plot(zp[9])


coxme.tt <- coxph(yLt ~ as.factor(sex) +# as.factor(origin) + 
                   Dom_CZ +  tt(Ext_CZ) + Con_CZ +
                   Agr_CZ + Neu_CZ + Opn_CZ +
                  frailty.gamma(sample) #+ strata(strt)
                 , tt=function(x,t,...){
                   Ext = x - t   # to scale or not to scale
                   cbind(Ext = scale(Ext), Ext2 = scale(Ext^2)
                 }
                 , data=datX, x=TRUE
)

summary(coxme.tt)

zp <- cox.zph(coxme.tt)
zp <- cox.zph(vfit, transform= function(time) log(time +20))
plot(zp[8])
abline(coef(coxme.tt)[4:6], col=2)


cox.tt2$loglik
plot(cox.zph(cox.tt2))




cox.tt2.a <- coxph(yLt ~ as.factor(sex) + as.factor(origin) + as.factor(LvZ) + 
                   Dom_CZ +  E.resid + Con_CZ +
                   Agr_CZ + Neu_CZ + Opn_CZ
                 , tt=function(x,t,...){
                   Ext = scale(t) - x   # to scale or not to scale
                   #Ext = 1.74 + t * -0.15 + t^2 * 0.002 
                   #Ext = -0.086 + Ext * -0.532 + Ext^2 * 0.037 
                   cbind(Ext = -0.532 * Ext, Ext2 = 0.037 *(Ext)^2)
                   #pspline(x - t, method='aic', )
                 }
                 , data=datX, x=TRUE
)


cox.tt3 <- coxph(yLt ~ as.factor(sex) + as.factor(origin) + as.factor(LvZ) + 
                               Dom_CZ +  tt(Ext_CZ) + Con_CZ +
                               Agr_CZ + Neu_CZ + Opn_CZ
                 , tt=function(x,t,...){
                   Ext = x - t
                   cbind(Ext = Ext, Ext2 = (Ext-1)^2, Ext3 = (Ext-1)^3)
                }
                , data=datX, x=TRUE
)

summary(cox.tt2)
anova(cox.tt2.a)


cox.Er2 <- coxph(yLt ~ as.factor(sex) + 
                       as.factor(origin) + as.factor(LvZ) + 
                       Dom_CZ + E.r2.DoB + Con_CZ + #E.resid3 +
                       Agr_CZ + Neu_CZ + Opn_CZ
                     , data=datX)

cox.Er3 <- coxph(yLt ~ as.factor(sex) + 
                   as.factor(origin) + as.factor(LvZ) + 
                   Dom_CZ + E.resid3 + Con_CZ + #E.resid3 +
                   Agr_CZ + Neu_CZ + Opn_CZ
                 , data=datX)

cox.EODN.r <- coxph(yLt ~ as.factor(sex) + 
                        as.factor(origin) + as.factor(LvZ) + 
                        D.r3.DoB + E.r3.DoB + Con_CZ + #E.resid3 +
                        Agr_CZ + N.r1.DoB + O.r2.DoB
                      , data=datX)

cox.EODN.r.betr <- coxph(yLt ~ as.factor(sex) + 
                      as.factor(origin) + as.factor(LvZ) + 
                      D.r3 + E.r3 + Con_CZ + #E.resid3 +
                      Agr_CZ + N.r1 + O.r2
                    , data=datX)




ll = 2*(cox.tt$loglik - cox.trunc$loglik)[2]
ll = 2*(cox.tt2$loglik - cox.trunc$loglik)[2]
ll = 2*(cox.tt2$loglik - cox.tt2.a$loglik)[2]
ll = 2*(cox.tt3$loglik - cox.tt2$loglik)[2]
ll
dchisq(ll, 2)

### are the tt effects doing what I think they're doing?

tt.deets = coxph.detail(cox.tt2)

colnames(tt.deets$means)

plot(rownames(tt.deets$means), # these are the same as time
     tt.deets$means[,5]) # Ext1

plot(rownames(tt.deets$means), tt.deets$means[,6] + tt.deets$means[,5]) # Ext2

plot(rownames(tt.deets$means), tt.deets$means[,9]) # Opn, for comparison

View(cbind(tt.deets$means,scale(tt.deets$means[,5]),scale(tt.deets$means[,6])))

View(cbind(tt.deets$time,tt.deets$nevent,tt.deets$nrisk,tt.deets$score))



################

# What happens if we clip the ends?

table(Dataset$age_pr)

clipper <- Dataset$age_pr_adj < 46 & Dataset$age_pr_adj > 2.2

y.clip <- Surv(Dataset$age_pr_adj[clipper], Dataset$age[clipper],Dataset$status[clipper],
                 type='counting')

y.clip <- Surv(Dataset$age_pr_adj, Dataset$age, Dataset$status,
               type='counting')

# attr(y.Ltrunc, 'type') <- 'counting'

rmNAs = !is.na(y.clip) & clipper

y.clip = y.clip[rmNAs]
attr(y.clip, 'type') <- 'counting'
dx.clip = Dataset[rmNAs,]

plot(dx.clip$age_pr, dx.clip$Ext_CZ)

View(cbind(dx.clip$age_pr_adj[order(dx.clip$age_pr_adj)], dx.clip$Ext_CZ[order(dx.clip$age_pr_adj)],
           1/(1 + dx.clip$age_pr_adj[order(dx.clip$age_pr_adj)])))

plot(dx.clip$age_pr_adj, 1/(1 + dx.clip$age_pr_adj ))
plot(dx.clip$age_pr_adj, dx.clip$Ext_CZ - 1/(1 + dx.clip$age_pr_adj ))

plot(dx.clip$age_pr_adj, dx.clip$Ext_CZ - scale(1 - dx.clip$age_pr_adj))
plot(dx.clip$age_pr_adj, dx.clip$Ext_CZ  ))

cox.clip <- coxph(y.clip ~ as.factor(sex) + as.factor(origin) + as.factor(LvZ) + 
                  Dom_CZ + Ext_CZ + Con_CZ +
                  Agr_CZ + Neu_CZ + Opn_CZ
                , tt=function(x,t,...){
                  Ext = x - scale(1/(t + 1))
                  #pspline(x + t, df= 2, nterm = 3)
                  
                  Ext = x - scale(1/(t + 1))   # to scale or not to scale
                  #cbind(Ext = Ext, Ext2 = (Ext)^2)
                }
                , data=dx.clip
)

