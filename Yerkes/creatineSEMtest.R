### Creatine-weight pseudo replication, inspired by ME Thompson et al. 2016

# attempting to use 'fullcast' df



# retain:
# Creatine
# Personality
# Weights
# age , time


# cw.df1 <- fullcast[,c(1,2,5,47,48,95:100)]
# 
# cw.df1 <- cw.df1[!(is.na(cw.df1$Creatine) & is.na(cw.df1$weight)),]
# # Agatha: beware dumb shit date entries

cw.df1 <- dmdob[,c(2,4,7,33,59,85,268,271,274)]

colnames(cw.df1) <- c('chimp','Year4','c4','c3','c2','c1','w3','w2','w1')

cw.df1 <- cw.df1[!(is.na(cw.df1$w3)),]



library(lavaan)
library(semPlot)
library(blavaan)


# a linear growth model with a time-varying covariate
mod.1 <- '
# intercept and slope with fixed coefficients
i =~ 1*w3 + 1*w2 + 1*w1
s =~ 1*w3 + 2*w2 + 3*w1

i.c =~ 1*c4 + 1*c3 + 1*c2 + 1*c1
s.c =~ 0*c4 + 1*c3 + 2*c2 + 3*c1
# regressions
#i ~ x1 + x2
#s ~ x1 + x2
# time-varying covariates
w1 ~ c2
w2 ~ c3
w3 ~ c4
#t4 ~ c4

# regs for earlier c LVs onto later w LVs
i ~ i.c + s.c
s ~ i.c + s.c
'
fit <- growth(mod.1, data = cw.df1, missing="ML")
semPaths(fit)
summary(fit)


# changing weight into a latent variable
mod.2 <- '
# intercept and slope with fixed coefficients
i.c =~ 1*c4 + 1*c3 + 1*c2 + 1*c1
s.c =~ 0*c4 + 1*c3 + 2*c2 + 3*c1

Wt =~ w3 + w2 + w1

# regressions
#i ~ x1 + x2
#s ~ x1 + x2
# time-varying covariates


# regs for earlier c LVs onto later w LV
Wt~ i.c + s.c
'
fit <- lavaan(mod.2, data = cw.df1, missing="ML", model.type='growth',
              int.ov.free = TRUE, int.lv.free = FALSE, auto.fix.first = TRUE, 
              auto.fix.single = TRUE, auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
              auto.cov.y = TRUE)

semPaths(fit, what='mod', whatLabels = 'par')
summary(fit)

bfit2.1 <- blavaan(mod.2, data = cw.df1, missing="ML", model.type='growth',
               int.ov.free = TRUE, int.lv.free = FALSE, auto.fix.first = TRUE, 
               auto.fix.single = TRUE, auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
               auto.cov.y = TRUE)
mod.2.2 <- '
# intercept and slope with fixed coefficients
i.c =~ 1*c4 + 1*c3 + 1*c2 + 1*c1
s.c =~ 0*c4 + 1*c3 + 2*c2 + 3*c1

Wt =~ w3 + w2 + w1

# regressions
#i ~ x1 + x2
#s ~ x1 + x2
# time-varying covariates

# regs for earlier c LVs onto later w LV
Wt~ i.c + 0*s.c
'

mod.2.3 <- '
# intercept and slope with fixed coefficients
i.c =~ 1*c4 + 1*c3 + 1*c2 + 1*c1
s.c =~ 0*c4 + 1*c3 + 2*c2 + 3*c1

Wt =~ w3 + w2 + w1

# regressions
#i ~ x1 + x2
#s ~ x1 + x2
# time-varying covariates

# regs for earlier c LVs onto later w LV
Wt~ 0*s.c + 0*i.c
'
fit2.2 <- lavaan(mod.2.2, data = cw.df1, missing="ML", model.type='growth',
                   int.ov.free = TRUE, int.lv.free = FALSE, auto.fix.first = TRUE, 
                   auto.fix.single = TRUE, auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
                   auto.cov.y = TRUE)
fit2.3 <- lavaan(mod.2.3, data = cw.df1, missing="ML", model.type='growth',
                 int.ov.free = TRUE, int.lv.free = FALSE, auto.fix.first = TRUE, 
                 auto.fix.single = TRUE, auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
                 auto.cov.y = TRUE)
semPaths(fit2.3)


mod.2.X <- '
# just the weight LV
Wt =~ w3 + w2 + w1
'
bfit2.X <- blavaan(mod.2.X, data = cw.df1, missing="ML", model.type='growth',
                   int.ov.free = TRUE, int.lv.free = FALSE, auto.fix.first = TRUE, 
                   auto.fix.single = TRUE, auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
                   auto.cov.y = TRUE)
summary(bfit2.2)

fitMeasures(fit, c("chisq", "df", "pvalue", "cfi", "rmsea"))
fitMeasures(fit2.2, baseline.model = fit,c("chisq", "df", "pvalue", "cfi", "rmsea"))
fitMeasures(fit2.3, baseline.model = fit,c("chisq", "df", "pvalue", "cfi", "rmsea"))
# I'm not sure this is all being done correctly


#fitMeasures(bfit2.1)


# add personality?




# not a growth model anymore
mod.3 <- '
# intercept and slope with fixed coefficients
i.c =~ c4 + c3 + c2 + c1

Wt =~ w3 + w2 + w1

# regressions
#i ~ x1 + x2
#s ~ x1 + x2
# time-varying covariates


# regs for earlier c LVs onto later w LV
Wt ~ i.c
'
# not currently functional
fit <- lavaan(mod.3, data = cw.df1, missing="ML",model.type='sem')
semPaths(fit)
summary(fit)

fit <- growth(mod.3, data = cw.df1, missing="ML")

