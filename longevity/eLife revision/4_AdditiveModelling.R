### GAM evaluation ###

library(mgcv)



### Dominance
gam.d = gamm(Dom ~ s(age_pr, k=20), data=datX)
gam.check(gam.d$gam)
## Figure 2 - figure supplement 1
plot(gam.d$gam, residuals=TRUE, 
     xlab = "Age at personality rating",
     ylab = "Dominance (scaled & centered)")


### Extraversion
gam.e = gamm(Ext ~ s(age_pr, k=20), data=datX)
gam.check(gam.e$gam)
plot(gam.e$gam, residuals=TRUE,
     xlab = "Age at personality rating",
     ylab = "Extraversion (scaled & centered)")


### Conscientiousness
gam.c = gamm(Con ~ s(age_pr, k=20), data=datX)
gam.check(gam.c$gam)
plot(gam.c$gam, residuals=TRUE,
     xlab = "Age at personality rating",
     ylab = "Conscientiousness (scaled & centered)")


### Agreeableness
gam.a = gamm(Agr ~ s(age_pr, k=20), data=datX)
gam.check(gam.a$gam)
plot(gam.a$gam, residuals=TRUE,
     xlab = "Age at personality rating",
     ylab = "Agreeableness (scaled & centered)")


### Neuroticism
gam.n = gamm(Neu ~ s(age_pr, k=20), data=datX)
gam.check(gam.n$gam)
plot(gam.n$gam, residuals=TRUE,
     xlab = "Age at personality rating",
     ylab = "Neuroticism (scaled & centered)")


### Openness
gam.o = gamm(Opn ~ s(age_pr, k=20), data=datX)
gam.check(gam.o$gam)
plot(gam.o$gam, residuals=TRUE,
     xlab = "Age at personality rating",
     ylab = "Openness (scaled & centered)")



### Save residuals

datX$D.gr = gam.d$gam$residuals
datX$E.gr = gam.e$gam$residuals
datX$C.gr = gam.c$gam$residuals
datX$N.gr = gam.n$gam$residuals
datX$A.gr = gam.a$gam$residuals
datX$O.gr = gam.o$gam$residuals
