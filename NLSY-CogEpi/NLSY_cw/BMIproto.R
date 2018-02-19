### BMI ###

library(ggplot2)
library(psych)





cor(ht.df$AFQT89[ht.df$SAMPLE_SEX=='MALE'], ht.df$bmi_85[ht.df$SAMPLE_SEX=='MALE'], 'pairwise.complete.obs')
cor(ht.df$AFQT89[ht.df$SAMPLE_SEX=='FEMALE'], ht.df$bmi_85[ht.df$SAMPLE_SEX=='FEMALE'], 'pairwise.complete.obs')

cor(ht.df$AFQT89[ht.df$SAMPLE_SEX=='MALE'], ht.df$bmi_06[ht.df$SAMPLE_SEX=='MALE'], 'pairwise.complete.obs')
cor(ht.df$AFQT89[ht.df$SAMPLE_SEX=='FEMALE'], ht.df$bmi_06[ht.df$SAMPLE_SEX=='FEMALE'], 'pairwise.complete.obs')

cor(ht.df$AFQT89[ht.df$SAMPLE_SEX=='MALE'], ht.df$bmi_12[ht.df$SAMPLE_SEX=='MALE'], 'pairwise.complete.obs')
cor(ht.df$AFQT89[ht.df$SAMPLE_SEX=='FEMALE'], ht.df$bmi_12[ht.df$SAMPLE_SEX=='FEMALE'], 'pairwise.complete.obs')








BMIQ <- ggplot(ht.df, aes(AFQT89, bmi_85))
BMIQ + geom_density_2d() + facet_wrap(~ SAMPLE_SEX)

BMIQ <- ggplot(ht.df, aes(AFQT89, bmi_06))
BMIQ + geom_density_2d() + facet_grid(~ SAMPLE_SEX)

BMIQ <- ggplot(ht.df, aes(AFQT89, bmi_12))
BMIQ + geom_density_2d() + facet_grid(~ SAMPLE_SEX)



### SEMs

library(lavaan)
library(semTools)



bmi.int.1 <-'
i =~ 1*bmi_85 + 1*bmi_06 + 1*bmi_12
s =~ 0*bmi_85 + 2.1*bmi_06 + 2.7*bmi_12

i ~ SAMPLE_SEX + AFQT89 + age_1979
s ~ SAMPLE_SEX + AFQT89 + age_1979

'


f1 = lavaan(bmi.int.1, data=ht.df, meanstructure = TRUE, int.ov.free = FALSE, 
            int.lv.free = TRUE, auto.fix.first = TRUE, auto.fix.single = TRUE, 
            auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
            auto.cov.y = TRUE)
  
summary(f1)
fitMeasures(f1, c("chisq", "df", "pvalue", "cfi", "tli", "srmr", "rmsea"))


ht.df$lvIQsex = ht.df$AFQT89 * (as.numeric(ht.df$SAMPLE_SEX)-1)

bmi.int.2 <-'
i =~ 1*bmi_85 + 1*bmi_06 + 1*bmi_12
s =~ 0*bmi_85 + 2.1*bmi_06 + 2.7*bmi_12

i ~ SAMPLE_SEX + AFQT89 + age_1979 + lvIQsex
s ~ SAMPLE_SEX + AFQT89 + age_1979 + lvIQsex

'


f2 = lavaan(bmi.int.2, data=ht.df, meanstructure = TRUE, int.ov.free = FALSE, 
            int.lv.free = TRUE, auto.fix.first = TRUE, auto.fix.single = TRUE, 
            auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
            auto.cov.y = TRUE)

summary(f2)
fitMeasures(f2, c("chisq", "df", "pvalue", "cfi", "tli", "srmr", "rmsea"))


bmi.int.3 <-'
i =~ 1*bmi_85 + 1*bmi_06 + 1*bmi_12
s =~ 0*bmi_85 + 2.1*bmi_06 + 2.7*bmi_12

i ~ AFQT89 + age_1979
s ~ AFQT89 + age_1979

'

f3 = lavaan(bmi.int.3, data=ht.df, group=c("SAMPLE_SEX"),
            meanstructure = TRUE, int.ov.free = FALSE, 
            int.lv.free = TRUE, auto.fix.first = TRUE, auto.fix.single = TRUE, 
            auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
            auto.cov.y = TRUE)

summary(f3)
fitMeasures(f3, c("chisq", "df", "pvalue", "cfi", "tli", "srmr", "rmsea"))

### Female
# Regressions:
#   Estimate  Std.Err  z-value  P(>|z|)
# i ~                                                 
#   AFQT89           -0.225    0.020  -11.299    0.000
# age_1979          0.046    0.009    5.257    0.000
# s ~                                                 
#   AFQT89            0.009    0.006    1.350    0.177
# age_1979         -0.014    0.003   -4.993    0.000
# 
# Covariances:
#   Estimate  Std.Err  z-value  P(>|z|)
# .i ~~                                                
#   .s                -0.060    0.019   -3.140    0.002

### Male
# Regressions:
#   Estimate  Std.Err  z-value  P(>|z|)
# i ~                                                 
#   AFQT89           -0.004    0.014   -0.292    0.770
# age_1979          0.056    0.007    8.059    0.000
# s ~                                                 
#   AFQT89           -0.013    0.005   -2.702    0.007
# age_1979         -0.019    0.002   -8.182    0.000
# 
# Covariances:
#   Estimate  Std.Err  z-value  P(>|z|)
# .i ~~                                                
#   .s                -0.021    0.015   -1.425    0.154



measurementInvariance(bmi.int.3, data=ht.df, group=c("SAMPLE_SEX"),
                      strict=TRUE)



