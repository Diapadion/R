### BMI ###

library(ggplot2)
library(psych)
library(data.table)


bmi <- read.csv('./BMI/moreWtHt.csv')

colnames(bmi)[c(2,6:30)] <- c('CASEID_1979',
                              'height_81','weight_81','height_82','weight_82',
                              'weight_86','weight_88','weight_89','weight_90',
                              'weight_92','weight_93','weight_94','weight_96',
                              'weight_98','weight_00','weight_02','weight_04',
                              'weight_08','feet_08','inches_08',
                              'weight_10','feet_10','inches_10',
                              'weight_14','feet_14','inches_14'
                         )

bmi <- merge(bmi, ht.df,
  by.y='CASEID_1979', by.x='CASEID_1979')
  

bmi$weight_96[bmi$weight_96<0] <- NA
bmi$bmi_96 = bmi$weight_96/(bmi$height_85^2) * 703



###

cor(ht.df$AFQT89[ht.df$SAMPLE_SEX=='MALE'], ht.df$bmi_85[ht.df$SAMPLE_SEX=='MALE'], 'pairwise.complete.obs')
cor(ht.df$AFQT89[ht.df$SAMPLE_SEX=='FEMALE'], ht.df$bmi_85[ht.df$SAMPLE_SEX=='FEMALE'], 'pairwise.complete.obs')

cor(ht.df$AFQT89[ht.df$SAMPLE_SEX=='MALE'], ht.df$bmi_06[ht.df$SAMPLE_SEX=='MALE'], 'pairwise.complete.obs')
cor(ht.df$AFQT89[ht.df$SAMPLE_SEX=='FEMALE'], ht.df$bmi_06[ht.df$SAMPLE_SEX=='FEMALE'], 'pairwise.complete.obs')

cor(ht.df$AFQT89[ht.df$SAMPLE_SEX=='MALE'], ht.df$bmi_12[ht.df$SAMPLE_SEX=='MALE'], 'pairwise.complete.obs')
cor(ht.df$AFQT89[ht.df$SAMPLE_SEX=='FEMALE'], ht.df$bmi_12[ht.df$SAMPLE_SEX=='FEMALE'], 'pairwise.complete.obs')





### Exploratory plots


ht.df$IQtert <- with(ht.df,cut(AFQT89, 
                           breaks=quantile(AFQT89, probs=seq(0,1, by=1/3), na.rm=TRUE), 
                           include.lowest=TRUE))

ht.df$sextert = interaction(ht.df$SAMPLE_SEX,ht.df$IQtert)

#table(ht.df$IQtert, ht.df$bmi_85)



bmi.long = bmi

# Long format
bmi.long = rbindlist(list(
  cbind(bmi.long[,c('CASEID_1979','SAMPLE_SEX','IQtert','sextert','bmi_85')],24),
  cbind(bmi.long[,c('CASEID_1979','SAMPLE_SEX','IQtert','sextert','bmi_96')],35),
  cbind(bmi.long[,c('CASEID_1979','SAMPLE_SEX','IQtert','sextert','bmi_06')],45),
  cbind(bmi.long[,c('CASEID_1979','SAMPLE_SEX','IQtert','sextert','bmi_12')],51)
), use.names=FALSE
)
colnames(bmi.long) <- c('id','sex','IQ','sexIQ','BMI','time') 


# Try discretizing the times

bmi.long$time = as.factor(bmi.long$time)



ggplot(subset(bmi.long, !is.na(BMI)&!is.na(IQ)), aes(x=time, y=BMI, group=IQ, color=IQ)) + 
  stat_smooth(method='lm', se=TRUE)


# Allcomers
ggplot(subset(bmi.long, !is.na(BMI)&!is.na(IQ)), aes(x=time, y=BMI, group=sexIQ, color=sexIQ)
       # , linetype = c(1,1,2,2,3,3)
       # , palette = c('dodgerblue','violetred1','dodgerblue','violetred1','dodgerblue','violetred1')
) + 
  stat_smooth(aes(linetype=IQ, color=sex), method='loess', se=TRUE) +
  xlab('Average age')




# Completers only
bmi.long = bmi[complete.cases(bmi[,c('AFQT89','bmi_85','bmi_96','bmi_06','bmi_12')]),]

# Long format
bmi.long = rbindlist(list(
  cbind(bmi.long[,c('CASEID_1979','SAMPLE_SEX','IQtert','sextert','bmi_85')],24),
  cbind(bmi.long[,c('CASEID_1979','SAMPLE_SEX','IQtert','sextert','bmi_96')],35),
  cbind(bmi.long[,c('CASEID_1979','SAMPLE_SEX','IQtert','sextert','bmi_06')],45),
  cbind(bmi.long[,c('CASEID_1979','SAMPLE_SEX','IQtert','sextert','bmi_12')],51)
), use.names=FALSE
)
colnames(bmi.long) <- c('id','sex','IQ','sexIQ','BMI','time') 

bmi.long$time = as.factor(bmi.long$time)
ggplot(subset(bmi.long, !is.na(BMI)&!is.na(IQ)), aes(x=time, y=BMI, group=sexIQ, color=sexIQ)
       # , linetype = c(1,1,2,2,3,3)
       # , palette = c('dodgerblue','violetred1','dodgerblue','violetred1','dodgerblue','violetred1')
) + 
  stat_smooth(aes(linetype=IQ, color=sex), method='loess', se=TRUE) +
  xlab('Average age')



BMIQ <- ggplot(bmi, aes(AFQT89, bmi_85))
BMIQ + geom_hex() + facet_wrap(~ SAMPLE_SEX) +
  geom_smooth(aes(linetype=SAMPLE_SEX), method='gam', colour="black") +
#  scale_y_continuous(limits = c(10, 70)) + 
  theme_bw() + ylab('BMI in 1985')

BMIQ <- ggplot(bmi, aes(AFQT89, bmi_96))
BMIQ + geom_hex() + facet_wrap(~ SAMPLE_SEX) +
  geom_smooth(aes(linetype=SAMPLE_SEX), method='gam', colour="black") +
#  scale_y_continuous(limits = c(10, 70)) + 
  theme_bw() + ylab('BMI in 1996')

BMIQ <- ggplot(bmi, aes(AFQT89, bmi_06))
BMIQ + geom_hex(bins = 70) + facet_grid(~ SAMPLE_SEX) +
  geom_smooth(aes(linetype=SAMPLE_SEX), method='gam', colour="black") +
  scale_y_continuous(limits = c(10, 70)) + 
  theme_bw() + ylab('BMI in 2006')

BMIQ <- ggplot(bmi, aes(AFQT89, bmi_12))
BMIQ + geom_hex(bins = 50) + facet_grid(~ SAMPLE_SEX) +
  #stat_smooth(method='gam', se=TRUE) + 
  geom_smooth(aes(linetype=SAMPLE_SEX), method='gam', colour="black") +
#  scale_y_continuous(limits = c(10, 70)) + 
  theme_bw() + ylab('BMI in 2012') 



lm.test = lm(bmi_12 ~ AFQT89 * SAMPLE_SEX, data=bmi)
summary(lm.test)



### Descriptive Table(s)

#table(bmi$sextert, bmi$bmi_85)

aggregate(bmi_85 ~ sextert, data=bmi, FUN=mean)
aggregate(bmi_96 ~ sextert, data=bmi, FUN=mean)
aggregate(bmi_06 ~ sextert, data=bmi, FUN=mean)
aggregate(bmi_12 ~ sextert, data=bmi, FUN=mean)

aggregate(bmi_85 ~ sextert, data=bmi[complete.cases(bmi[,c('sextert','bmi_85','bmi_96','bmi_06','bmi_12')]),], FUN=mean)
aggregate(bmi_96 ~ sextert, data=bmi[complete.cases(bmi[,c('sextert','bmi_85','bmi_96','bmi_06','bmi_12')]),], FUN=mean)
aggregate(bmi_06 ~ sextert, data=bmi[complete.cases(bmi[,c('sextert','bmi_85','bmi_96','bmi_06','bmi_12')]),], FUN=mean)
aggregate(bmi_12 ~ sextert, data=bmi[complete.cases(bmi[,c('sextert','bmi_85','bmi_96','bmi_06','bmi_12')]),], FUN=mean)



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



