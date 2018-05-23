### GAM residualizing

library(mgcv)



hist(ht.df$Youth_SES)

ySES.resid = gam(AFQT89 ~ s(Youth_SES), data=ht.df, na.action = na.exclude)
gam.check(ySES.resid)
plot(ySES.resid, residuals = TRUE)

ht.df$ySES.r = residuals(ySES.resid)

cor(ht.df$Youth_SES, ht.df$AFQT89, use='pairwise')

