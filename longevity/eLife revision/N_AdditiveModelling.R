### GAM evaluation ###



library(mgcv)



### Dominance
gam.d = gamm(Dom ~ s(age_pr, k=20), data=datX)
# plot(gam.d$gam, residuals=TRUE)
gam.check(gam.d$gam)


### Extraversion
gam.e = gamm(Ext ~ s(age_pr, k=20), data=datX)
plot(gam.e$gam, residuals=TRUE)
gam.check(gam.e$gam)


### Conscientiousness
gam.c = gamm(Con ~ s(age_pr, k=20), data=datX)
plot(gam.c$gam, residuals=TRUE)
gam.check(gam.c$gam)


### Agreeableness
gam.a = gamm(Agr ~ s(age_pr, k=20), data=datX)
plot(gam.a$gam, residuals=TRUE)
gam.check(gam.a$gam)


### Neuroticism
gam.n = gamm(Neu ~ s(age_pr, k=20), data=datX)
plot(gam.n$gam, residuals=TRUE)
gam.check(gam.n$gam)


### Openness
gam.o = gamm(Opn ~ s(age_pr, k=20), data=datX)
plot(gam.o$gam, residuals=TRUE)
gam.check(gam.o$gam)


### Save residuals

datX$D.gr = gam.d$gam$residuals
datX$E.gr = gam.e$gam$residuals
datX$C.gr = gam.c$gam$residuals
datX$N.gr = gam.n$gam$residuals
datX$A.gr = gam.a$gam$residuals
datX$O.gr = gam.o$gam$residuals
