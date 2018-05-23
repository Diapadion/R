### GAM residualizing

library(mgcv)



hist(ncds$Youth_SES)

ySES.resid = gam(g ~ s(Youth_SES), data=ncds, na.action = na.exclude)
gam.check(ySES.resid)
plot(ySES.resid, residuals = TRUE)

ncds$ySES.r = residuals(ySES.resid)

cor(ncds$Youth_SES, ncds$g, use='pairwise')
