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
  

bmi$weight_81[bmi$weight_81<0] <- NA

split_h81 = read.fwf(file = textConnection(as.character(bmi$height_81)), 
               widths = c(1, 2), colClasses = "character", 
               col.names = c("feet", "inches"))
# head(cbind(bmi$height_81, split_h81),30)
# head(as.numeric(split_h81$feet))
bmi$height_81[bmi$height_81>0] = as.numeric(split_h81$feet[bmi$height_81>0])*12 + 
  as.numeric(split_h81$inches[bmi$height_81>0])

bmi$height_81[bmi$height_81<0] <- NA

head(bmi$height_81, 30)
bmi$bmi_81 = bmi$weight_81/(bmi$height_81^2) * 703

bmi$weight_85[bmi$weight_85<0] <- NA
bmi$bmi_85 = bmi$weight_85/(bmi$height_85^2) * 703

bmi$weight_94[bmi$weight_94<0] <- NA
bmi$bmi_94 = bmi$weight_94/(bmi$height_85^2) * 703

### Create BMI - 2014
bmi$weight_14[bmi$weight_14<0] = NA

bmi$height_14 = -1
bmi$feet_14 = bmi$feet_14*12

bmi$height_14[bmi$inches_14<12&bmi$inches_14>-0.1] = rowSums(bmi[,c('feet_14','inches_14')], na.rm=T)[bmi$inches_14<12&bmi$inches_14>-0.1]

bmi$height_14[bmi$height_14<32] = NA

bmi$height_14[bmi$inches_14>12] = bmi$inches_14[bmi$inches_14>12]

bmi$bmi_14 = bmi$weight_14/(bmi$height_14^2) * 703



## trim implausible values
bmi$bmi_81[bmi$bmi_81 > 70] = NA
bmi$bmi_81[bmi$bmi_81 < 12] = NA

bmi$bmi_94[bmi$bmi_94 > 70] = NA
bmi$bmi_94[bmi$bmi_94 < 12] = NA

bmi$bmi_14[bmi$bmi_14 > 70] = NA
bmi$bmi_14[bmi$bmi_14 < 12] = NA


hist(bmi$bmi_81)
hist(bmi$bmi_85)
hist(bmi$bmi_94)
hist(bmi$bmi_06)
hist(bmi$bmi_14)
      


## Weirdly, BMI'06 and '12 need to be multiplied by 100?
## keep an eye on this
#bmi$bmi_12 = bmi$bmi_12*100
#bmi$bmi_06 = bmi$bmi_06*100
### Fixed - unclear why this was happening



###

cor(ht.df$AFQT89[ht.df$SAMPLE_SEX=='MALE'], ht.df$bmi_85[ht.df$SAMPLE_SEX=='MALE'], 'pairwise.complete.obs')
cor(ht.df$AFQT89[ht.df$SAMPLE_SEX=='FEMALE'], ht.df$bmi_85[ht.df$SAMPLE_SEX=='FEMALE'], 'pairwise.complete.obs')

cor(ht.df$AFQT89[ht.df$SAMPLE_SEX=='MALE'], ht.df$bmi_06[ht.df$SAMPLE_SEX=='MALE'], 'pairwise.complete.obs')
cor(ht.df$AFQT89[ht.df$SAMPLE_SEX=='FEMALE'], ht.df$bmi_06[ht.df$SAMPLE_SEX=='FEMALE'], 'pairwise.complete.obs')

cor(ht.df$AFQT89[ht.df$SAMPLE_SEX=='MALE'], ht.df$bmi_12[ht.df$SAMPLE_SEX=='MALE'], 'pairwise.complete.obs')
cor(ht.df$AFQT89[ht.df$SAMPLE_SEX=='FEMALE'], ht.df$bmi_12[ht.df$SAMPLE_SEX=='FEMALE'], 'pairwise.complete.obs')



### Age and net family income vars for the relevant waves

## Import

ageIncome = read.csv('./BMI/AgeIncome.csv')

colnames(ageIncome)[c(2,6:14)] <- c('CASEID_1979','income.hhi.85','income.85','age.85',
                                    'income.94','age.94','income.06','age.06','income.14','age.14'
)
                              

bmi <- merge(bmi, ageIncome,
             by.y='CASEID_1979', by.x='CASEID_1979')

## Processing

bmi$age.85[bmi$age.85<1] = NA
bmi$age.94[bmi$age.94<1] = NA
bmi$age.06[bmi$age.06<1] = NA
bmi$age.14[bmi$age.14<1] = NA

#table(bmi$age.06, useNA='ifany')

bmi$income.85[bmi$income.85<0] = NA
bmi$income.94[bmi$income.94<0] = NA
bmi$income.06[bmi$income.06<0] = NA
bmi$income.14[bmi$income.14<0] = NA

temp = scale(bmi[,c('income.85','income.94','income.06','income.14')])

bmi$income.85 = temp[,'income.85']
bmi$income.94 = temp[,'income.94']
bmi$income.06 = temp[,'income.06']
bmi$income.14 = temp[,'income.14']

table(bmi$income.hhi.85, useNA='ifany')
table(bmi$income.85, useNA='ifany')



## plots below have not been checked to see if these additions break anything



### Exploratory plots


bmi$IQtert <- with(bmi,cut(AFQT89, 
                           breaks=quantile(AFQT89, probs=seq(0,1, by=1/3), na.rm=TRUE), 
                           include.lowest=TRUE))
bmi$sextert = interaction(bmi$SAMPLE_SEX,bmi$IQtert)

#table(ht.df$IQtert, ht.df$bmi_85)



bmi.long = bmi

# Long format
bmi.long = rbindlist(list(
  cbind(bmi.long[,c('CASEID_1979','SAMPLE_SEX','IQtert','sextert','bmi_81')],20),
  cbind(bmi.long[,c('CASEID_1979','SAMPLE_SEX','IQtert','sextert','bmi_85')],24),
  cbind(bmi.long[,c('CASEID_1979','SAMPLE_SEX','IQtert','sextert','bmi_94')],33),
  cbind(bmi.long[,c('CASEID_1979','SAMPLE_SEX','IQtert','sextert','bmi_06')],45),
  cbind(bmi.long[,c('CASEID_1979','SAMPLE_SEX','IQtert','sextert','bmi_14')],53)
), use.names=FALSE
)
colnames(bmi.long) <- c('id','sex','IQ','sexIQ','BMI','time') 


# Try discretizing the times

#bmi.long$time = as.factor(bmi.long$time)



ggplot(subset(bmi.long, !is.na(BMI)&!is.na(IQ)), aes(x=time, y=BMI, group=IQ, color=IQ)) + 
  stat_smooth(method='gam', se=TRUE)


# Allcomers
ggplot(subset(bmi.long, !is.na(BMI)&!is.na(IQ)), aes(x=time, y=BMI, group=sexIQ, color=sexIQ)
       # , linetype = c(1,1,2,2,3,3)
       # , palette = c('dodgerblue','violetred1','dodgerblue','violetred1','dodgerblue','violetred1')
) + 
  stat_smooth(aes(linetype=IQ, color=sex), method='gam', formula = y~s(x, k=4), se=TRUE) +
  #stat_smooth(aes(linetype=IQ, color=sex), method='loess', se=TRUE) +
  xlab('Average age')



# Completers only
bmi.long = bmi[complete.cases(bmi[,c('AFQT89','bmi_81','bmi_85','bmi_94','bmi_06','bmi_14')]),]

# Long format
bmi.long = rbindlist(list(
  cbind(bmi.long[,c('CASEID_1979','SAMPLE_SEX','SAMPLE_ethnicity','IQtert','sextert','bmi_81')],20),
  cbind(bmi.long[,c('CASEID_1979','SAMPLE_SEX','SAMPLE_ethnicity','IQtert','sextert','bmi_85')],24),
  cbind(bmi.long[,c('CASEID_1979','SAMPLE_SEX','SAMPLE_ethnicity','IQtert','sextert','bmi_94')],33),
  cbind(bmi.long[,c('CASEID_1979','SAMPLE_SEX','SAMPLE_ethnicity','IQtert','sextert','bmi_06')],45),
  cbind(bmi.long[,c('CASEID_1979','SAMPLE_SEX','SAMPLE_ethnicity','IQtert','sextert','bmi_14')],53)
), use.names=FALSE
)
colnames(bmi.long) <- c('id','sex','ethnicity','IQ','sexIQ','BMI','time') 

#bmi.long$time = as.factor(bmi.long$time)
ggplot(subset(bmi.long, !is.na(BMI)&!is.na(IQ)), aes(x=time, y=BMI, group=sexIQ, color=sexIQ)
       # , linetype = c(1,1,2,2,3,3)
       # , palette = c('dodgerblue','violetred1','dodgerblue','violetred1','dodgerblue','violetred1')
) + 
  stat_smooth(aes(linetype=IQ, color=sex), method='gam', formula = y~s(x, k=4), se=TRUE) +
  #stat_smooth(aes(linetype=IQ, color=sex), method='loess', se=TRUE) +
  xlab('Average age')



### Completers with IQ corrected for youth SES

# bmi.long = bmi[complete.cases(bmi[,c('AFQT89','bmi_85','bmi_14')]),]
# 
# m.ySESg = lm(AFQT89 ~ Youth_SES, data=bmi.long)
# plot(m.ySESg)
# bmi.long$ySES.r = m.ySESg$residuals
# 
# bmi.long$gtert.ySES.r <- with(bmi.long, cut(ySES.r,
#                                             breaks=quantile(ySES.r, probs=seq(0,1, by=1/3), na.rm=TRUE),
#                                             include.lowest=TRUE))
# 
# bmi.long$sextert = interaction(bmi.long$SAMPLE_SEX,bmi.long$gtert.ySES.r)
# 
# 
# ## Long format
# bmi.long = rbindlist(list(
#   cbind(bmi.long[,c('CASEID_1979','SAMPLE_SEX','gtert.ySES.r','sextert','bmi_85')],24),
#   cbind(bmi.long[,c('CASEID_1979','SAMPLE_SEX','gtert.ySES.r','sextert','bmi_94')],35),
#   cbind(bmi.long[,c('CASEID_1979','SAMPLE_SEX','gtert.ySES.r','sextert','bmi_06')],45),
#   cbind(bmi.long[,c('CASEID_1979','SAMPLE_SEX','gtert.ySES.r','sextert','bmi_14')],51)
# ), use.names=FALSE
# )
# colnames(bmi.long) <- c('id','sex','IQ.res','sexIQ','BMI','time')
# 
# #bmi.long$age = as.factor(bmi.long$age)
# 
# ggplot(subset(bmi.long, !is.na(BMI)&!is.na(IQ.res)), aes(x=time, y=BMI, group=sexIQ, color=sexIQ)
#        # , linetype = c(1,1,2,2,3,3)
#        # , palette = c('dodgerblue','violetred1','dodgerblue','violetred1','dodgerblue','violetred1')
# ) +
#   stat_smooth(aes(linetype=IQ.res, color=sex), method='gam', formula = y~s(x, k=7), se=TRUE) +
#   #stat_smooth(aes(linetype=IQ, color=sex), method='loess', se=TRUE) +
#   xlab('Average age')




### Plot of allcomers, caucasians only - after IJD

## Block for pre-removing Blacks and Hispanics, and recalculating relative IQ tertiles
bmi.long = bmi[bmi$SAMPLE_ethnicity=='NON-BLACK, NON-HISPANIC',]
bmi.long$IQtert <- with(bmi.long,cut(AFQT89, 
                           breaks=quantile(AFQT89, probs=seq(0,1, by=1/3), na.rm=TRUE), 
                           include.lowest=TRUE))
bmi.long$sextert = interaction(bmi.long$SAMPLE_SEX,bmi.long$IQtert)

bmi.long = bmi.long[complete.cases(bmi.long[,c('AFQT89','bmi_85','bmi_14')]),]

# Long format
bmi.long = rbindlist(list(
  #cbind(bmi.long[,c('CASEID_1979','SAMPLE_SEX','SAMPLE_ethnicity','IQtert','sextert','bmi_81')],20),
  cbind(bmi.long[,c('CASEID_1979','SAMPLE_SEX','SAMPLE_ethnicity','IQtert','sextert','bmi_85')],24),
  cbind(bmi.long[,c('CASEID_1979','SAMPLE_SEX','SAMPLE_ethnicity','IQtert','sextert','bmi_94')],33),
  cbind(bmi.long[,c('CASEID_1979','SAMPLE_SEX','SAMPLE_ethnicity','IQtert','sextert','bmi_06')],45),
  cbind(bmi.long[,c('CASEID_1979','SAMPLE_SEX','SAMPLE_ethnicity','IQtert','sextert','bmi_14')],53)
), use.names=FALSE
)
colnames(bmi.long) <- c('id','sex','ethnicity','IQ','sexIQ','BMI','time') 


ggplot(subset(bmi.long, !is.na(BMI)&!is.na(IQ)), 
       aes(x=time, y=BMI, group=sexIQ, color=sexIQ)
       # , linetype = c(1,1,2,2,3,3)
       # , palette = c('dodgerblue','violetred1','dodgerblue','violetred1','dodgerblue','violetred1')
) + 
  stat_smooth(aes(linetype=IQ, color=sex), method='gam', formula = y~s(x, k=4), se=TRUE) +
  #stat_smooth(aes(linetype=IQ, color=sex), method='loess', se=TRUE) +
  xlab('Average age') + 
  coord_cartesian(xlim=c(23,55), ylim=c(21.5,30)) + 
  theme(legend.position = c(0.9,0.25))






### Divisions by sex, ethnicity, and IQ - after IJD

## rerun earlier reshaping code for all completers (line 154+)

ggplot(subset(bmi.long, !is.na(BMI)&!is.na(IQ)), aes(x=time, y=BMI, group=IQ, color=IQ)
       # , linetype = c(1,1,2,2,3,3)
       # , palette = c('dodgerblue','violetred1','dodgerblue','violetred1','dodgerblue','violetred1')
) + 
  stat_smooth(aes(linetype=IQ, color=sex), method='gam', formula = y~s(x, k=4), se=TRUE) +
  facet_wrap(. ~ sex) + 
  #stat_smooth(aes(linetype=IQ, color=sex), method='loess', se=TRUE) +
  xlab('Average age')


ggplot(subset(bmi.long, !is.na(BMI)&!is.na(IQ)), aes(x=time, y=BMI, group=IQ, color=IQ)
       # , linetype = c(1,1,2,2,3,3)
       # , palette = c('dodgerblue','violetred1','dodgerblue','violetred1','dodgerblue','violetred1')
) + 
  stat_smooth(aes(linetype=IQ, color=sex), method='gam', formula = y~s(x, k=4), se=TRUE) +
  facet_wrap(sex ~ ethnicity) + 
#stat_smooth(aes(linetype=IQ, color=sex), method='loess', se=TRUE) +
xlab('Average age')
  
  

  
  
  
  


  





BMIQ <- ggplot(bmi, aes(AFQT89, bmi_85))
BMIQ + geom_hex() + facet_wrap(~ SAMPLE_SEX) +
  geom_smooth(aes(linetype=SAMPLE_SEX), method='gam', colour="black") +
  scale_y_continuous(limits = c(10, 70)) + 
  theme_bw() + ylab('BMI in 1985')

BMIQ <- ggplot(bmi, aes(AFQT89, bmi_96))
BMIQ + geom_hex() + facet_wrap(~ SAMPLE_SEX) +
  geom_smooth(aes(linetype=SAMPLE_SEX), method='gam', colour="black") +
  scale_y_continuous(limits = c(10, 70)) + 
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

bmi.lv = bmi[bmi$SAMPLE_ethnicity=='NON-BLACK, NON-HISPANIC',]

bmi.lv$lvIQsex = bmi.lv$AFQT89 * (as.numeric(bmi.lv$SAMPLE_SEX)-1)



bmi.is.m1 <- '
i =~ 1*bmi_85 + 1*bmi_94 + 1*bmi_06 + 1*bmi_14
s =~ 0*bmi_85 + 1.1*bmi_94 + 2.1*bmi_06 + 2.7*bmi_14
'

is.f1 = lavaan(bmi.is.m1, data=bmi.lv, meanstructure = TRUE, int.ov.free = FALSE, 
               int.lv.free = TRUE, auto.fix.first = TRUE, auto.fix.single = TRUE, 
               auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
               auto.cov.y = TRUE,
               missing = 'fiml', information='observed'
)

fitMeasures(is.f1, c("chisq", "df", "pvalue", "cfi", "tli", "srmr", "rmsea"))
summary(is.f1)


summary(bmi$age.85) # mean = 23.6
summary(bmi$age.94) # mean = 32.98
summary(bmi$age.06) # mean = 44.73
summary(bmi$age.14) # mean = 53.48



bmi.isq.m1 <- '
i =~ 1*bmi_85 + 1*bmi_94 + 1*bmi_06 + 1*bmi_14
s =~ 0*bmi_85 + 0.9*bmi_94 + 2.1*bmi_06 + 2.9*bmi_14
q =~ 0*bmi_85 + 0.81*bmi_94 + 4.41*bmi_06 + 8.41*bmi_14

bmi_85 ~ age.85
bmi_94 ~ age.94
bmi_06 ~ age.06
bmi_14 ~ age.14

'

isq.f1 = lavaan(bmi.isq.m1, data=bmi.lv, meanstructure = TRUE, int.ov.free = FALSE, 
                int.lv.free = TRUE, auto.fix.first = TRUE, auto.fix.single = TRUE, 
                auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
                auto.cov.y = TRUE,
                missing = 'fiml', information='observed'
)

fitMeasures(isq.f1, c("chisq", "df", "pvalue", "cfi", "tli", "srmr", "rmsea"))
summary(isq.f1)



bmi.isq.m2 <- '
i =~ 1*bmi_85 + 1*bmi_94 + 1*bmi_06 + 1*bmi_14
s =~ 0*bmi_85 + 0.9*bmi_94 + 2.1*bmi_06 + 2.9*bmi_14
q =~ 0*bmi_85 + 0.81*bmi_94 + 4.41*bmi_06 + 8.41*bmi_14

i ~ SAMPLE_SEX + AFQT89 + age_1979
s ~ SAMPLE_SEX + AFQT89 + age_1979
q ~ SAMPLE_SEX + AFQT89 + age_1979

bmi_85 ~ age.85
bmi_94 ~ age.94
bmi_06 ~ age.06
bmi_14 ~ age.14

'


isq.f2 = lavaan(bmi.isq.m2, data=bmi.lv, meanstructure = TRUE, int.ov.free = FALSE, 
            int.lv.free = TRUE, auto.fix.first = TRUE, auto.fix.single = TRUE, 
            auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
            auto.cov.y = TRUE)

fitMeasures(isq.f2, c("chisq", "df", "pvalue", "cfi", "tli", "srmr", "rmsea"))
summary(isq.f2)



bmi.isq.m3 <- '
i =~ 1*bmi_85 + 1*bmi_94 + 1*bmi_06 + 1*bmi_14
s =~ 0*bmi_85 + 0.9*bmi_94 + 2.1*bmi_06 + 2.9*bmi_14
q =~ 0*bmi_85 + 0.81*bmi_94 + 4.41*bmi_06 + 8.41*bmi_14

i ~ SAMPLE_SEX + AFQT89 + age_1979 + lvIQsex
s ~ SAMPLE_SEX + AFQT89 + age_1979 + lvIQsex 
q ~ SAMPLE_SEX + AFQT89 + age_1979 + lvIQsex

bmi_85 ~ age.85
bmi_94 ~ age.94
bmi_06 ~ age.06
bmi_14 ~ age.14

'


isq.f3 = lavaan(bmi.isq.m3, data=bmi.lv, meanstructure = TRUE, int.ov.free = FALSE, 
            int.lv.free = TRUE, auto.fix.first = TRUE, auto.fix.single = TRUE, 
            auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
            auto.cov.y = TRUE)


fitMeasures(isq.f3, c("chisq", "df", "pvalue", "cfi", "tli", "srmr", "rmsea"))
summary(isq.f3)



bmi.isq.m4 <- '
bm.i =~ 1*bmi_85 + 1*bmi_94 + 1*bmi_06 + 1*bmi_14
bm.s =~ 0*bmi_85 + 0.9*bmi_94 + 2.1*bmi_06 + 2.9*bmi_14
bm.q =~ 0*bmi_85 + 0.81*bmi_94 + 4.41*bmi_06 + 8.41*bmi_14

bm.i ~ SAMPLE_SEX + AFQT89 + age_1979 + lvIQsex + Child_SES + SES_Education_USE
bm.s ~ SAMPLE_SEX + AFQT89 + age_1979 + lvIQsex + Child_SES + SES_Education_USE 
bm.q ~ SAMPLE_SEX + AFQT89 + age_1979 + lvIQsex + Child_SES + SES_Education_USE

bmi_85 ~ age.85
bmi_94 ~ age.94
bmi_06 ~ age.06
bmi_14 ~ age.14

'

isq.f4 = lavaan(bmi.isq.m4, data=bmi.lv, meanstructure = TRUE, int.ov.free = FALSE, 
                int.lv.free = TRUE, auto.fix.first = TRUE, auto.fix.single = TRUE, 
                auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
                auto.cov.y = TRUE)


fitMeasures(isq.f4, c("chisq", "df", "pvalue", "cfi", "tli", "srmr", "rmsea"))
summary(isq.f4)



### Incorportating income

inc.isq.m1 <- '
i =~ 1*income.85 + 1*income.94 + 1*income.06 + 1*income.14
s =~ 0*income.85 + 0.9*income.94 + 2.1*income.06 + 2.9*income.14
q =~ 0*income.85 + 0.81*income.94 + 4.41*income.06 + 8.41*income.14

'

inc.isq.f1 = lavaan(inc.isq.m1, data=bmi.lv, meanstructure = TRUE, int.ov.free = FALSE, 
                    int.lv.free = TRUE, auto.fix.first = TRUE, auto.fix.single = TRUE, 
                    auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
                    auto.cov.y = TRUE,
                    missing = 'fiml', information='observed'
)

fitMeasures(inc.isq.f1, c("chisq", "df", "pvalue", "cfi", "tli", "srmr", "rmsea"))
summary(inc.isq.f1)



bmi.isq.m5 <- '
bm.i =~ 1*bmi_85 + 1*bmi_94 + 1*bmi_06 + 1*bmi_14
bm.s =~ 0*bmi_85 + 0.9*bmi_94 + 2.1*bmi_06 + 2.9*bmi_14
bm.q =~ 0*bmi_85 + 0.81*bmi_94 + 4.41*bmi_06 + 8.41*bmi_14

inc.i =~ 1*income.85 + 1*income.94 + 1*income.06 + 1*income.14
inc.s =~ 0*income.85 + 0.9*income.94 + 2.1*income.06 + 2.9*income.14
inc.q =~ 0*income.85 + 0.81*income.94 + 4.41*income.06 + 8.41*income.14

bm.i ~ SAMPLE_SEX + AFQT89 + age_1979 + lvIQsex + Child_SES + SES_Education_USE
bm.s ~ SAMPLE_SEX + AFQT89 + age_1979 + lvIQsex + Child_SES + SES_Education_USE + inc.i  
bm.q ~ SAMPLE_SEX + AFQT89 + age_1979 + lvIQsex + Child_SES + SES_Education_USE + inc.i + inc.s

bm.i ~~ inc.i
bm.s ~~ inc.s
bm.q ~~ inc.q

bmi_85 ~ age.85
bmi_94 ~ age.94
bmi_06 ~ age.06
bmi_14 ~ age.14

'

isq.f5 = lavaan(bmi.isq.m5, data=bmi.lv, meanstructure = TRUE, int.ov.free = FALSE, 
                int.lv.free = TRUE, auto.fix.first = TRUE, auto.fix.single = TRUE, 
                auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
                auto.cov.y = TRUE)


fitMeasures(isq.f5, c("chisq", "df", "pvalue", "cfi", "tli", "srmr", "rmsea"))
summary(isq.f5)













########

bmi.int.3 <-'
i =~ 1*bmi_85 + 1*bmi_96 + 1*bmi_06 + 1*bmi_12
s =~ 0*bmi_85 + 1.1*bmi_96 + 2.1*bmi_06 + 2.7*bmi_12

i ~ SAMPLE_SEX + AFQT89 + age_1979 + lvIQsex + Child_SES
s ~ SAMPLE_SEX + AFQT89 + age_1979 + lvIQsex + Child_SES

'

f3 = lavaan(bmi.int.3, data=bmi, meanstructure = TRUE, int.ov.free = FALSE, 
            int.lv.free = TRUE, auto.fix.first = TRUE, auto.fix.single = TRUE, 
            auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
            auto.cov.y = TRUE)

fitMeasures(f3, c("chisq", "df", "pvalue", "cfi", "tli", "srmr", "rmsea"))
summary(f3)



bmi.int.4 <-'
i =~ 1*bmi_85 + 1*bmi_96 + 1*bmi_06 + 1*bmi_12
s =~ 0*bmi_85 + 1.1*bmi_96 + 2.1*bmi_06 + 2.7*bmi_12

i ~ SAMPLE_SEX + AFQT89 + age_1979 + lvIQsex + Child_SES + 
s ~ SAMPLE_SEX + AFQT89 + age_1979 + lvIQsex + Child_SES + Adult_SES

'

f4 = lavaan(bmi.int.4, data=bmi, meanstructure = TRUE, int.ov.free = FALSE, 
            int.lv.free = TRUE, auto.fix.first = TRUE, auto.fix.single = TRUE, 
            auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
            auto.cov.y = TRUE)

fitMeasures(f4, c("chisq", "df", "pvalue", "cfi", "tli", "srmr", "rmsea"))
summary(f4)





### Old...



bmi.int.X <-'
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



