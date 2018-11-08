### Plotting

library(ggplot2)
library(data.table)






ncds$gtert <- with(ncds,cut(g,
                               breaks=quantile(g, probs=seq(0,1, by=1/3), na.rm=TRUE), 
                               include.lowest=TRUE))

ncds$sextert = interaction(ncds$sex,ncds$gtert)

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





# Long format
bmi.long = rbindlist(list(
  cbind(bmi.long[,c('ncdsid','sex','gtert','sextert','bmi16')],16),
  cbind(bmi.long[,c('ncdsid','sex','gtert','sextert','bmi23')],23),
  cbind(bmi.long[,c('ncdsid','sex','gtert','sextert','bmi33')],33),
  cbind(bmi.long[,c('ncdsid','sex','gtert','sextert','bmi42')],42),
  cbind(bmi.long[,c('ncdsid','sex','gtert','sextert','bmi55')],55)
), use.names=FALSE
)
colnames(bmi.long) <- c('id','sex','IQ','sexIQ','BMI','age') 



# Try discretizing the times

bmi.long$age = as.factor(bmi.long$age)



ggplot(subset(bmi.long, !is.na(BMI)&!is.na(IQ)), aes(x=age, y=BMI, group=IQ, color=IQ)) + 
  stat_smooth(method='gam', se=TRUE)


# Allcomers
ggplot(subset(bmi.long, !is.na(BMI)&!is.na(IQ)), aes(x=age, y=BMI, group=sexIQ, color=sexIQ)
       # , linetype = c(1,1,2,2,3,3)
       # , palette = c('dodgerblue','violetred1','dodgerblue','violetred1','dodgerblue','violetred1')
) + 
  stat_smooth(aes(linetype=IQ, color=sex), method='loess', se=TRUE) +
  xlab('Average age')




## Completers only
bmi.long = ncds[complete.cases(ncds[,c('g','bmi23','bmi55')]),]


## Long format
bmi.long = rbindlist(list(
  #cbind(bmi.long[,c('ncdsid','sex','gtert','sextert','bmi16')],16),
  cbind(bmi.long[,c('ncdsid','sex','gtert','sextert','bmi23')],23),
  cbind(bmi.long[,c('ncdsid','sex','gtert','sextert','bmi33')],33),
  cbind(bmi.long[,c('ncdsid','sex','gtert','sextert','bmi42')],42),
  cbind(bmi.long[,c('ncdsid','sex','gtert','sextert','bmi55')],55)
), use.names=FALSE
)
colnames(bmi.long) <- c('id','sex','IQ','sexIQ','BMI','age') 

#bmi.long$age = as.factor(bmi.long$age)

ggplot(subset(bmi.long, !is.na(BMI)&!is.na(IQ)), aes(x=age, y=BMI, group=sexIQ, color=sexIQ)
       # , linetype = c(1,1,2,2,3,3)
       # , palette = c('dodgerblue','violetred1','dodgerblue','violetred1','dodgerblue','violetred1')
) + 
  stat_smooth(aes(linetype=IQ, color=sex), method='gam', formula = y~s(x, k=4), se=TRUE) +
  #stat_smooth(aes(linetype=IQ, color=sex), method='loess', se=TRUE) +
  xlab('Average age') + 
  coord_cartesian(xlim=c(23,55), ylim=c(21.5,30)) + 
  theme(legend.position = c(0.9,0.25))



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

income.long$edtert <- with(ncds,cut(education,
                            breaks=quantile(education, probs=seq(0,1, by=1/3), na.rm=TRUE), 
                            include.lowest=TRUE))
income.long$ySEStert <- with(ncds,cut(Youth_SES,
                                    breaks=quantile(Youth_SES, probs=seq(0,1, by=1/3), na.rm=TRUE), 
                                    include.lowest=TRUE))

income.long$gxEd = interaction(income.long$edtert, income.long$gtert)
income.long$ySESxEd = interaction(income.long$edtert, income.long$ySEStert)

colnames(income.long)

income.long = income.long[complete.cases(income.long[,c('g','bmi23','bmi55')]),] # to get Completers

income.long = rbindlist(list(
  cbind(income.long[,c('ncdsid','sex','gtert','edtert','ySEStert','gxEd','ySESxEd','income23')],23),
  cbind(income.long[,c('ncdsid','sex','gtert','edtert','ySEStert','gxEd','ySESxEd','income33')],33),
  cbind(income.long[,c('ncdsid','sex','gtert','edtert','ySEStert','gxEd','ySESxEd','income42')],42),
  cbind(income.long[,c('ncdsid','sex','gtert','edtert','ySEStert','gxEd','ySESxEd','income50')],50)
  #,cbind(income.long[,c('ncdsid','sex','gtert','sextert','income55')],55)
), use.names=FALSE
)
colnames(income.long) <- c('id','sex','IQ','education','Youth_SES','gxEd','ySESxEd','income','age') 





ggplot(subset(income.long, !is.na(income)&!is.na(IQ)), aes(x=age, y=income, group=IQ, color=IQ)
       # , linetype = c(1,1,2,2,3,3)
       # , palette = c('dodgerblue','violetred1','dodgerblue','violetred1','dodgerblue','violetred1')
) + facet_grid(. ~ sex) +
  stat_smooth(aes(linetype=IQ, color=IQ), method='gam', formula = y~s(x, k=4), se=TRUE) +
  #stat_smooth(aes(linetype=IQ, color=sex), method='loess', se=TRUE) +
  xlab('Average age')  
#coord_cartesian(xlim=c(23,55), ylim=c(21.5,30)) + 
#theme(legend.position = c(0.9,0.25))
  


ggplot(subset(income.long, !is.na(income)&!is.na(education)), aes(x=age, y=income, group=education, color=education)
       # , linetype = c(1,1,2,2,3,3)
       # , palette = c('dodgerblue','violetred1','dodgerblue','violetred1','dodgerblue','violetred1')
) + facet_grid(. ~ sex) +
  stat_smooth(aes(linetype=education, color=education), method='gam', formula = y~s(x, k=4), se=TRUE) +
  #stat_smooth(aes(linetype=IQ, color=sex), method='loess', se=TRUE) +
  xlab('Average age')  
#coord_cartesian(xlim=c(23,55), ylim=c(21.5,30)) + 
#theme(legend.position = c(0.9,0.25))



ggplot(subset(income.long, !is.na(income)&!is.na(Youth_SES)), aes(x=age, y=income, group=Youth_SES, color=Youth_SES)
       # , linetype = c(1,1,2,2,3,3)
       # , palette = c('dodgerblue','violetred1','dodgerblue','violetred1','dodgerblue','violetred1')
) + facet_grid(. ~ sex) +
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


