### Plotting

library(ggplot2)
library(data.table)

library(semPlot)





ncds$gtert <- with(ncds,cut(g,
                               breaks=quantile(g, probs=seq(0,1, by=1/3), na.rm=TRUE), 
                               include.lowest=TRUE))

ncds$sexG = interaction(as.factor(ncds$sex),ncds$gtert)

ncds$edtert <- with(ncds,cut(education,
                                    breaks=quantile(education, probs=seq(0,1, by=1/3), na.rm=TRUE), 
                                    include.lowest=TRUE))
ncds$ySEStert <- with(ncds,cut(Youth_SES,
                                      breaks=quantile(Youth_SES, probs=seq(0,1, by=1/3), na.rm=TRUE), 
                                      include.lowest=TRUE))

ncds$sexEd = interaction(ncds$sex, ncds$edtert)
ncds$sexYSES = interaction(ncds$sex, ncds$ySEStert)

bmi.long = ncds



### Descriptive Table(s)

#table(bmi$sextert, bmi$bmi_85)

aggregate(bmi16 ~ sextert, data=bmi.long, FUN=mean)
aggregate(bmi23 ~ sextert, data=bmi.long, FUN=mean)
aggregate(bmi33 ~ sextert, data=bmi.long, FUN=mean)
aggregate(bmi42 ~ sextert, data=bmi.long, FUN=mean)
aggregate(bmi55 ~ sextert, data=bmi.long, FUN=mean)

aggregate(bmi16 ~ sextert, data=bmi.long[complete.cases(bmi.long[,c('sextert','bmi16','bmi55')]),], FUN=mean)
aggregate(bmi23 ~ sextert, data=bmi.long[complete.cases(bmi.long[,c('sextert','bmi16','bmi55')]),], FUN=mean)
aggregate(bmi33 ~ sextert, data=bmi.long[complete.cases(bmi.long[,c('sextert','bmi16','bmi55')]),], FUN=mean)
aggregate(bmi42 ~ sextert, data=bmi.long[complete.cases(bmi.long[,c('sextert','bmi16','bmi55')]),], FUN=mean)
aggregate(bmi55 ~ sextert, data=bmi.long[complete.cases(bmi.long[,c('sextert','bmi16','bmi55')]),], FUN=mean)





# # Long format
# bmi.long = rbindlist(list(
#   cbind(bmi.long[,c('ncdsid','sex','gtert','sextert','bmi16')],16),
#   cbind(bmi.long[,c('ncdsid','sex','gtert','sextert','bmi23')],23),
#   cbind(bmi.long[,c('ncdsid','sex','gtert','sextert','bmi33')],33),
#   cbind(bmi.long[,c('ncdsid','sex','gtert','sextert','bmi42')],42),
#   cbind(bmi.long[,c('ncdsid','sex','gtert','sextert','bmi55')],55)
# ), use.names=FALSE
# )
# colnames(bmi.long) <- c('id','sex','IQ','sexIQ','BMI','age') 
# 
# 
# 
# # Try discretizing the times
# 
# bmi.long$age = as.factor(bmi.long$age)
# 
# 
# 
# ggplot(subset(bmi.long, !is.na(BMI)&!is.na(IQ)), aes(x=age, y=BMI, group=IQ, color=IQ)) + 
#   stat_smooth(method='gam', se=TRUE)
# 
# 
# # Allcomers
# ggplot(subset(bmi.long, !is.na(BMI)&!is.na(IQ)), aes(x=age, y=BMI, group=sexIQ, color=sexIQ)
#        # , linetype = c(1,1,2,2,3,3)
#        # , palette = c('dodgerblue','violetred1','dodgerblue','violetred1','dodgerblue','violetred1')
# ) + 
#   stat_smooth(aes(linetype=IQ, color=sex), method='loess', se=TRUE) +
#   xlab('Average age')




### Completers only 
### *** PUBLICATION PLOTS

bmi.long = ncds[complete.cases(ncds[,c('g','bmi55')]),]




## Long format
bmi.long = rbindlist(list(
  #cbind(bmi.long[,c('ncdsid','sex','gtert','sextert','bmi16')],16),
  
  cbind(bmi.long[,c('ncdsid','sex','gtert','edtert','ySEStert','sexG','sexEd','sexYSES','bmi23')],23),
  cbind(bmi.long[,c('ncdsid','sex','gtert','edtert','ySEStert','sexG','sexEd','sexYSES','bmi33')],33),
  cbind(bmi.long[,c('ncdsid','sex','gtert','edtert','ySEStert','sexG','sexEd','sexYSES','bmi42')],42),
  cbind(bmi.long[,c('ncdsid','sex','gtert','edtert','ySEStert','sexG','sexEd','sexYSES','bmi55')],55)
), use.names=FALSE
)
colnames(bmi.long) <- c('id','Sex','IQ','Education','Youth_SES','Sex.x.IQ','Sex.x.Edu','Sex.x.youth.SES','BMI','age') 



#bmi.long$age = as.factor(bmi.long$age)
table(bmi.long$Sex, useNA='ifany')

bmi.long$Sex = as.factor(bmi.long$Sex)



### This one:
ggplot(subset(bmi.long, !is.na(BMI)&!is.na(IQ)), aes(x=age, y=BMI, group=Sex.x.IQ, color=Sex.x.IQ)
       # , linetype = c(1,1,2,2,3,3)
       # , palette = c('dodgerblue','violetred1','dodgerblue','violetred1','dodgerblue','violetred1')
) + 
  stat_smooth(aes(linetype=IQ, color=Sex),  method='lm', formula=y~x+I(x^2), size=1) +
              #method='gam', formula = y~s(x, k=3), se=TRUE) +
  #stat_smooth(aes(linetype=IQ, color=sex), method='loess', se=TRUE) +
  xlab('Average age') + 
  coord_cartesian(xlim=c(25,53), ylim=c(21.5,30)) + 
  theme_bw() #+ theme(legend.position = 'none')




ggplot(subset(bmi.long, !is.na(BMI)&!is.na(Education)), aes(x=age, y=BMI, group=Sex.x.Edu, color=Sex.x.Edu)
       # , linetype = c(1,1,2,2,3,3)
       # , palette = c('dodgerblue','violetred1','dodgerblue','violetred1','dodgerblue','violetred1')
) + 
  stat_smooth(aes(linetype=Education, color=Sex), method='gam', formula = y~s(x, k=4), se=TRUE) +
  #stat_smooth(aes(linetype=IQ, color=sex), method='loess', se=TRUE) +
  xlab('Average age') + 
  coord_cartesian(xlim=c(23,55), ylim=c(21.5,30)) + 
  theme(legend.position = c(0.9,0.25))



ggplot(subset(bmi.long, !is.na(BMI)&!is.na(Youth_SES)), aes(x=age, y=BMI, group=Sex.x.youth.SES, color=Sex.x.youth.SES)
       # , linetype = c(1,1,2,2,3,3)
       # , palette = c('dodgerblue','violetred1','dodgerblue','violetred1','dodgerblue','violetred1')
) + 
  stat_smooth(aes(linetype=Youth_SES, color=Sex), method='gam', formula = y~s(x, k=4), se=TRUE) +
  #stat_smooth(aes(linetype=IQ, color=sex), method='loess', se=TRUE) +
  xlab('Average age') + 
  coord_cartesian(xlim=c(23,55), ylim=c(21.5,30)) + 
  theme(legend.position = c(0.9,0.25))




### now for NLSY

nlsy$gtert <- with(nlsy,cut(g,
                            breaks=quantile(g, probs=seq(0,1, by=1/3), na.rm=TRUE), 
                            include.lowest=TRUE))

nlsy$sexG = interaction(nlsy$sex,nlsy$gtert)

nlsy$edtert <- with(nlsy,cut(education,
                             breaks=quantile(education, probs=seq(0,1, by=1/3), na.rm=TRUE), 
                             include.lowest=TRUE))
nlsy$ySEStert <- with(nlsy,cut(Youth_SES,
                               breaks=quantile(Youth_SES, probs=seq(0,1, by=1/3), na.rm=TRUE), 
                               include.lowest=TRUE))

nlsy$sexEd = interaction(nlsy$sex, nlsy$edtert)
nlsy$sexYSES = interaction(nlsy$sex, nlsy$ySEStert)


bmi.nlsy = nlsy[complete.cases(nlsy[,c('g','bmi_14')]),]

bmi.nlsy = bmi.nlsy[bmi.nlsy$SAMPLE_ethnicity=='NON-BLACK, NON-HISPANIC',]

## Long format
bmi.nlsy = rbindlist(list(
  #cbind(bmi.long[,c('ncdsid','sex','gtert','sextert','bmi16')],16),
  
  cbind(bmi.nlsy[,c('CASEID_1979','sex','gtert','edtert','ySEStert','sexG','sexEd','sexYSES','bmi_85','age.85')]),#24),
  cbind(bmi.nlsy[,c('CASEID_1979','sex','gtert','edtert','ySEStert','sexG','sexEd','sexYSES','bmi_94','age.94')]),#33),
  cbind(bmi.nlsy[,c('CASEID_1979','sex','gtert','edtert','ySEStert','sexG','sexEd','sexYSES','bmi_06','age.06')]),#45),
  cbind(bmi.nlsy[,c('CASEID_1979','sex','gtert','edtert','ySEStert','sexG','sexEd','sexYSES','bmi_14','age.14')])#53)
), use.names=FALSE
)
colnames(bmi.nlsy) <- c('id','Sex','IQ','Education','Youth_SES','Sex.x.IQ','Sex.x.Edu','Sex.x.youth.SES','BMI','age') 



### This one:
ggplot(subset(bmi.nlsy, !is.na(BMI)&!is.na(IQ)), aes(x=age, y=BMI, group=Sex.x.IQ, color=Sex.x.IQ)
       # , linetype = c(1,1,2,2,3,3)
       # , palette = c('dodgerblue','violetred1','dodgerblue','violetred1','dodgerblue','violetred1')
) + 
  stat_smooth(aes(linetype=IQ, color=Sex), method='lm', formula=y~x+I(x^2), size=1) +
              #method='gam', formula = y~s(x, k=3), se=TRUE) +
  #stat_smooth(aes(linetype=IQ, color=sex), method='loess', se=TRUE) +
  xlab('Average age') + 
  coord_cartesian(xlim=c(25,53), ylim=c(21.5,30)) + 
  theme_bw() #+ theme(legend.position = 'none')



ggplot(subset(bmi.nlsy, !is.na(BMI)&!is.na(Education)), aes(x=age, y=BMI, group=Sex.x.Edu, color=Sex.x.Edu)
       # , linetype = c(1,1,2,2,3,3)
       # , palette = c('dodgerblue','violetred1','dodgerblue','violetred1','dodgerblue','violetred1')
) + 
  stat_smooth(aes(linetype=Education, color=Sex), method='gam', formula = y~s(x, k=4), se=TRUE) +
  #stat_smooth(aes(linetype=IQ, color=sex), method='loess', se=TRUE) +
  xlab('Average age') + 
  coord_cartesian(xlim=c(23,55), ylim=c(21.5,30)) + 
  theme(legend.position = c(0.9,0.25))



ggplot(subset(bmi.nlsy, !is.na(BMI)&!is.na(Youth_SES)), aes(x=age, y=BMI, group=Sex.x.youth.SES, color=Sex.x.youth.SES)
       # , linetype = c(1,1,2,2,3,3)
       # , palette = c('dodgerblue','violetred1','dodgerblue','violetred1','dodgerblue','violetred1')
) + 
  stat_smooth(aes(linetype=Youth_SES, color=Sex), method='gam', formula = y~s(x, k=4), se=TRUE) +
  #stat_smooth(aes(linetype=IQ, color=sex), method='loess', se=TRUE) +
  xlab('Average age') + 
  coord_cartesian(xlim=c(23,55), ylim=c(21.5,30)) + 
  theme(legend.position = c(0.9,0.25))






### Getting a handle on the differences in BMI slope ~ g

## NLSY
ggplot(subset(bmi.nlsy, !is.na(BMI)&!is.na(IQ)), aes(x=age, y=BMI, group=IQ, color=IQ)) + 
  stat_smooth(aes(linetype=IQ, color=IQ), method='lm', formula=y~x+I(x^2), size=1
  ) +
  xlab('Average age') + 
  coord_cartesian(xlim=c(25,53), ylim=c(21.5,30)) + 
  theme_bw() + theme(legend.position = 'none')

## NCDS
ggplot(subset(bmi.long, !is.na(BMI)&!is.na(IQ)), aes(x=age, y=BMI, group=IQ, color=IQ)) + 
  stat_smooth(aes(linetype=IQ, color=IQ), method='lm', formula=y~x+I(x^2), size=1
              ) +
  xlab('Average age') + 
  coord_cartesian(xlim=c(25,53), ylim=c(21.5,30)) + 
  theme_bw() + theme(legend.position = c(0.8,0.25))



### Non-Caucasian ethnic groups

## NLSY

nlsy.other$gtert <- with(nlsy.other,cut(g,
                            breaks=quantile(g, probs=seq(0,1, by=1/3), na.rm=TRUE), 
                            include.lowest=TRUE))
nlsy.other$sexG = interaction(nlsy.other$sex,nlsy.other$gtert)
bmi.nlsy.o = nlsy.other[complete.cases(nlsy.other[,c('g','bmi_14')]),]

bmi.nlsy.o = rbindlist(list(
  cbind(bmi.nlsy.o[,c('CASEID_1979','sex','gtert','sexG','bmi_85','age.85')]),#24),
  cbind(bmi.nlsy.o[,c('CASEID_1979','sex','gtert','sexG','bmi_94','age.94')]),#33),
  cbind(bmi.nlsy.o[,c('CASEID_1979','sex','gtert','sexG','bmi_06','age.06')]),#45),
  cbind(bmi.nlsy.o[,c('CASEID_1979','sex','gtert','sexG','bmi_14','age.14')])#53)
), use.names=FALSE
)
colnames(bmi.nlsy.o) <- c('id','Sex','IQ','Sex.x.IQ','BMI','age') 

ggplot(subset(bmi.nlsy.o, !is.na(BMI)&!is.na(IQ)), aes(x=age, y=BMI, group=Sex.x.IQ, color=Sex.x.IQ)) + 
  stat_smooth(aes(linetype=IQ, color=Sex), method='lm', formula=y~x+I(x^2), size=1
  ) +
  xlab('Average age') + 
  coord_cartesian(xlim=c(25,53), ylim=c(21.5,32)) + 
  theme(legend.position = c(0.9,0.25))


## NCDS
ncds.other$gtert <- with(ncds.other,cut(g,
                                        breaks=quantile(g, probs=seq(0,1, by=1/3), na.rm=TRUE), 
                                        include.lowest=TRUE))
ncds.other$sexG = interaction(ncds.other$sex,ncds.other$gtert)
bmi.ncds.o = ncds.other[complete.cases(ncds.other[,c('g','bmi55')]),]

bmi.ncds.o = rbindlist(list(
    cbind(bmi.ncds.o[,c('ncdsid','sex','gtert','sexG','bmi23')],23),
  cbind(bmi.ncds.o[,c('ncdsid','sex','gtert','sexG','bmi33')],33),
  cbind(bmi.ncds.o[,c('ncdsid','sex','gtert','sexG','bmi42')],42),
  cbind(bmi.ncds.o[,c('ncdsid','sex','gtert','sexG','bmi55')],55)
), use.names=FALSE
)
colnames(bmi.ncds.o) <- c('id','Sex','IQ','Sex.x.IQ','BMI','age') 

ggplot(subset(bmi.ncds.o, !is.na(BMI)&!is.na(IQ)), aes(x=age, y=BMI, group=Sex.x.IQ, color=Sex.x.IQ)
) + 
  stat_smooth(aes(linetype=IQ, color=Sex),  method='lm', formula=y~x+I(x^2), size=1) +
  #method='gam', formula = y~s(x, k=3), se=TRUE) +
  xlab('Average age') + 
  coord_cartesian(xlim=c(25,53), ylim=c(21.5,32)) + 
  theme(legend.position = c(0.9,0.25))



### IAN SEX PLOTS
## 'Caucasians'
## NLSY
ggplot(subset(bmi.nlsy, !is.na(BMI)&!is.na(Sex)), aes(x=age, y=BMI, group=Sex, color=Sex)) + 
  stat_smooth(aes(linetype=Sex, color=Sex), method='lm', formula=y~x+I(x^2), size=1
  ) +
  xlab('Average age') + 
  coord_cartesian(xlim=c(25,53), ylim=c(21.5,32)) + 
  theme_bw() + theme(legend.position = c(0.8,0.25))

## NCDS
ggplot(subset(bmi.long, !is.na(BMI)&!is.na(Sex)), aes(x=age, y=BMI, group=Sex, color=Sex)) + 
  stat_smooth(aes(linetype=Sex, color=Sex), method='lm', formula=y~x+I(x^2), size=1
  ) +
  xlab('Average age') + 
  coord_cartesian(xlim=c(25,53), ylim=c(21.5,32)) + 
  theme_bw() + theme(legend.position = 'none')



## minorities
## NLSY
ggplot(subset(bmi.nlsy.o, !is.na(BMI)&!is.na(Sex)), aes(x=age, y=BMI, group=Sex, color=Sex)) + 
  stat_smooth(aes(linetype=Sex, color=Sex), method='lm', formula=y~x+I(x^2), size=1
  ) +
  xlab('Average age') + 
  coord_cartesian(xlim=c(25,53), ylim=c(21.5,32)) + 
  theme_bw() + theme(legend.position = c(0.8,0.25))

## NCDS
ggplot(subset(bmi.ncds.o, !is.na(BMI)&!is.na(Sex)), aes(x=age, y=BMI, group=Sex, color=Sex)) + 
  stat_smooth(aes(linetype=Sex, color=Sex), method='lm', formula=y~x+I(x^2), size=1
  ) +
  xlab('Average age') + 
  coord_cartesian(xlim=c(25,53), ylim=c(21.5,32)) + 
  theme_bw() + theme(legend.position = 'none')





  





### Completers with IQ corrected for youth SES

bmi.long = ncds[complete.cases(ncds[,c('g','bmi16','bmi55')]),]

bmi.long$gtert.ySES.r <- with(bmi.long, cut(ySES.r,
                            breaks=quantile(ySES.r, probs=seq(0,1, by=1/3), na.rm=TRUE), 
                            include.lowest=TRUE))

bmi.long$sextert = interaction(bmi.long$sex,bmi.long$gtert.ySES.r)


## Long format
bmi.long = rbindlist(list(
  #cbind(bmi.long[,c('ncdsid','sex','gtert.ySES.r','sextert','bmi16')],16),
  cbind(bmi.long[,c('ncdsid','sex','gtert.ySES.r','sextert','bmi23')],23),
  cbind(bmi.long[,c('ncdsid','sex','gtert.ySES.r','sextert','bmi33')],33),
  cbind(bmi.long[,c('ncdsid','sex','gtert.ySES.r','sextert','bmi42')],42),
  cbind(bmi.long[,c('ncdsid','sex','gtert.ySES.r','sextert','bmi55')],55)
), use.names=FALSE
)
colnames(bmi.long) <- c('id','sex','IQ.res','sexIQ','BMI','age') 

#bmi.long$age = as.factor(bmi.long$age)

ggplot(subset(bmi.long, !is.na(BMI)&!is.na(IQ.res)), aes(x=age, y=BMI, group=sexIQ, color=sexIQ)
       # , linetype = c(1,1,2,2,3,3)
       # , palette = c('dodgerblue','violetred1','dodgerblue','violetred1','dodgerblue','violetred1')
) + 
  stat_smooth(aes(linetype=IQ.res, color=sex), method='gam', formula = y~s(x, k=4), se=TRUE) +
  #stat_smooth(aes(linetype=IQ, color=sex), method='loess', se=TRUE) +
  xlab('Average age')





BMIQ <- ggplot(ncds, aes(g, bmi33))
BMIQ + geom_hex() + facet_wrap(~ sex) +
  geom_smooth(aes(linetype=sex), method='gam', colour="black") +
  #scale_y_continuous(limits = c(10, 70)) + 
  theme_bw() + ylab('Age 33 BMI ')

BMIQ <- ggplot(ncds, aes(g, bmi42))
BMIQ + geom_hex() + facet_wrap(~ sex) +
  geom_smooth(aes(linetype=sex), method='gam', colour="black") +
  #scale_y_continuous(limits = c(10, 70)) + 
  theme_bw() + ylab('Age 42 BMI ')



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




### Income

income.long = ncds

#colnames(income.long)

income.long = income.long[complete.cases(income.long[,c('g','bmi23','bmi55')]),] # to get Completers

income.long = rbindlist(list(
  cbind(income.long[,c('ncdsid','sex','gtert','edtert','ySEStert','sexG','sexEd','sexYSES','income23')],23),
  cbind(income.long[,c('ncdsid','sex','gtert','edtert','ySEStert','sexG','sexEd','sexYSES','income33')],33),
  cbind(income.long[,c('ncdsid','sex','gtert','edtert','ySEStert','sexG','sexEd','sexYSES','income42')],42),
  cbind(income.long[,c('ncdsid','sex','gtert','edtert','ySEStert','sexG','sexEd','sexYSES','income50')],50)
  #,cbind(income.long[,c('ncdsid','sex','gtert','sextert','income55')],55)
), use.names=FALSE
)
colnames(income.long) <- c('id','Sex','IQ','Education','Youth_SES','Sex.x.IQ','Sex.x.Edu','Sex.x.youth.SES','income','age') 





ggplot(subset(income.long, !is.na(income)&!is.na(IQ)), aes(x=age, y=income, group=IQ, color=IQ)
       # , linetype = c(1,1,2,2,3,3)
       # , palette = c('dodgerblue','violetred1','dodgerblue','violetred1','dodgerblue','violetred1')
) + facet_grid(. ~ Sex) +
  stat_smooth(aes(linetype=IQ, color=IQ), method='gam', formula = y~s(x, k=4), se=TRUE) +
  #stat_smooth(aes(linetype=IQ, color=sex), method='loess', se=TRUE) +
  xlab('Average age')  
#coord_cartesian(xlim=c(23,55), ylim=c(21.5,30)) + 
#theme(legend.position = c(0.9,0.25))
  


ggplot(subset(income.long, !is.na(income)&!is.na(Education)), aes(x=age, y=income, group=Education, color=Education)
       # , linetype = c(1,1,2,2,3,3)
       # , palette = c('dodgerblue','violetred1','dodgerblue','violetred1','dodgerblue','violetred1')
) + facet_grid(. ~ Sex) +
  stat_smooth(aes(linetype=Education, color=Education), method='gam', formula = y~s(x, k=4), se=TRUE) +
  #stat_smooth(aes(linetype=IQ, color=sex), method='loess', se=TRUE) +
  xlab('Average age')  
#coord_cartesian(xlim=c(23,55), ylim=c(21.5,30)) + 
#theme(legend.position = c(0.9,0.25))



ggplot(subset(income.long, !is.na(income)&!is.na(Youth_SES)), aes(x=age, y=income, group=Youth_SES, color=Youth_SES)
       # , linetype = c(1,1,2,2,3,3)
       # , palette = c('dodgerblue','violetred1','dodgerblue','violetred1','dodgerblue','violetred1')
) + facet_grid(. ~ Sex) +
  stat_smooth(aes(linetype=Youth_SES, color=Youth_SES), method='gam', formula = y~s(x, k=4), se=TRUE) +
  #stat_smooth(aes(linetype=IQ, color=sex), method='loess', se=TRUE) +
  xlab('Average age')  



ggplot(subset(income.long, !is.na(income)&!is.na(gxEd)), aes(x=age, y=income, group=gxEd, color=gxEd)
       # , linetype = c(1,1,2,2,3,3)
       # , palette = c('dodgerblue','violetred1','dodgerblue','violetred1','dodgerblue','violetred1')
) + facet_grid(. ~ sex) +
  stat_smooth(aes(linetype=IQ, color=education), method='gam', formula = y~s(x, k=4), se=TRUE) +
  #stat_smooth(aes(linetype=IQ, color=sex), method='loess', se=TRUE) +
  xlab('Average age')  
#coord_cartesian(xlim=c(23,55), ylim=c(21.5,30)) + 
#theme(legend.position = c(0.9,0.25))



ggplot(subset(income.long, !is.na(income)&!is.na(ySESxEd)), aes(x=age, y=income, group=ySESxEd, color=ySESxEd)
       # , linetype = c(1,1,2,2,3,3)
       # , palette = c('dodgerblue','violetred1','dodgerblue','violetred1','dodgerblue','violetred1')
) + facet_grid(. ~ sex) +
  stat_smooth(aes(linetype=Youth_SES, color=education), method='gam', formula = y~s(x, k=4), se=TRUE) +
  #stat_smooth(aes(linetype=IQ, color=sex), method='loess', se=TRUE) +
  xlab('Average age')  







ggplot(subset(income.long, !is.na(income)&!is.na(IQ)), aes(x=age, y=income, group=sexIQ, color=sexIQ)
       # , linetype = c(1,1,2,2,3,3)
       # , palette = c('dodgerblue','violetred1','dodgerblue','violetred1','dodgerblue','violetred1')
) + 
  stat_smooth(aes(linetype=IQ, color=sex), method='gam', formula = y~s(x, k=4), se=TRUE) +
  #stat_smooth(aes(linetype=IQ, color=sex), method='loess', se=TRUE) +
  xlab('Average age')  
  #coord_cartesian(xlim=c(23,55), ylim=c(21.5,30)) + 
  #theme(legend.position = c(0.9,0.25))




### from the LGC SEMs

semPaths(isq.f6, "std")
