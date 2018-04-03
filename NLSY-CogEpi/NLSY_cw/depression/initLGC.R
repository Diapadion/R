### Depression growth curve tests



library(lavaan)
library(data.table)
library(ggplot2)



ces7 = read.csv('./depression/CES-7.csv')
  
colnames(ces7)[c(2:3,8:9)] <- c('CES.40','CES.50','CES_92','CES_94')

dep = merge(ht.df, ces7[,c('R0000100','CES.40','CES.50','CES_92','CES_94')],
            by.x='CASEID_1979', by.y='R0000100')

dep$CES_92[dep$CES_92<0] = NA
dep$CES_94[dep$CES_94<0] = NA
dep$CES.40[dep$CES.40<0] = NA
dep$CES.50[dep$CES.50<0] = NA



### Exploratory plots


dep$IQtert <- with(dep,cut(AFQT89, 
                               breaks=quantile(AFQT89, probs=seq(0,1, by=1/3), na.rm=TRUE), 
                               include.lowest=TRUE))

dep$sextert = interaction(dep$SAMPLE_SEX,dep$IQtert)

dep$ethtert = interaction(dep$SAMPLE_ethnicity,dep$IQtert)

table(dep$IQtert, dep$CES.40)
table(dep$ethtert, dep$CES.40)




# Completers only
dep.long = dep[complete.cases(dep[,c('AFQT89','CES_92','CES_94','CES.40','CES.50')]),]


# Long format

dep.long = rbindlist(list(
  cbind(dep[,c('CASEID_1979','SAMPLE_SEX','IQtert','sextert','ethtert','CES_92')],0),
  cbind(dep[,c('CASEID_1979','SAMPLE_SEX','IQtert','sextert','ethtert','CES_94')],2),
  cbind(dep[,c('CASEID_1979','SAMPLE_SEX','IQtert','sextert','ethtert','CES.40')],10),
  cbind(dep[,c('CASEID_1979','SAMPLE_SEX','IQtert','sextert','ethtert','CES.50')],20)
), use.names=FALSE

)
colnames(dep.long) <- c('id','sex','IQ','sexIQ','ethIQ','CES','time') 



# Try discretizing the times

dep.long$time = as.factor(dep.long$time)


### Sex

ggplot(subset(dep.long, !is.na(CES)&!is.na(IQ)), aes(x=time, y=CES, group=IQ, color=IQ)) + 
  stat_smooth(method='lm', se=TRUE)
  
ggplot(subset(dep.long, !is.na(CES)&!is.na(IQ)), aes(x=time, y=CES, group=sexIQ, color=sexIQ)
       # , linetype = c(1,1,2,2,3,3)
       # , palette = c('dodgerblue','violetred1','dodgerblue','violetred1','dodgerblue','violetred1')
       ) + 
  stat_smooth(aes(linetype=IQ, color=sex), method='loess', se=TRUE)



### Ethnicity

ggplot(subset(dep.long, !is.na(CES)&!is.na(IQ)), aes(x=time, y=CES, group=ethIQ, color=ethIQ)
       # , linetype = c(1,1,2,2,3,3)
       # , palette = c('dodgerblue','violetred1','dodgerblue','violetred1','dodgerblue','violetred1')
) + 
  stat_smooth(aes(linetype=IQ, color=ethIQ), method='loess', se=TRUE)

  




m1 <- '
d.i =~ 1*CES_92 + 1*CES_94 + 1*CES.40 + 1*CES.50
d.s =~ 0*CES_92 + 2*CES_94 + 10*CES.40 + 20*CES.50
d.q =~ 0*CES_92 + 4*CES_94 + 100*CES.40 + 400*CES.50

'



f1 = lavaan(m1, data = dep, 
            meanstructure = TRUE, int.ov.free = FALSE, int.lv.free = TRUE, 
            auto.fix.first = TRUE #std.lv = TRUE
            , auto.fix.single = TRUE, auto.var = TRUE, auto.cov.lv.x = TRUE, 
            auto.th = TRUE, auto.delta = TRUE, auto.cov.y = TRUE
)

fitMeasures(f1, c("chisq", "df", "pvalue", "cfi", 'srmr', "rmsea"))
summary(f1)






m2 <- '
d.i =~ 1*CES_92 + 1*CES_94 + 1*CES.40 + 1*CES.50
d.s =~ 0*CES_92 + 2*CES_94 + 10*CES.40 + 20*CES.50
d.q =~ 0*CES_92 + 4*CES_94 + 100*CES.40 + 400*CES.50

d.i ~ AFQT89 + SAMPLE_SEX + age_1979
d.s ~ AFQT89 + SAMPLE_SEX + age_1979
d.q ~ AFQT89 + SAMPLE_SEX + age_1979

'



f2 = lavaan(m2, data = dep, 
            meanstructure = TRUE, int.ov.free = FALSE, int.lv.free = TRUE, 
            auto.fix.first = TRUE #std.lv = TRUE
            , auto.fix.single = TRUE, auto.var = TRUE, auto.cov.lv.x = TRUE, 
            auto.th = TRUE, auto.delta = TRUE, auto.cov.y = TRUE
)

fitMeasures(f2, c("chisq", "df", "pvalue", "cfi", 'srmr', "rmsea"))
summary(f2)





dep$SexIQint = dep$AFQT89 * (as.numeric(dep$SAMPLE_SEX)-1)
#dep$childAgeIQint = dep$age_1979 * (as.numeric(dep$SAMPLE_SEX)-1)



m3 <- '
d.i =~ 1*CES_92 + 1*CES_94 + 1*CES.40 + 1*CES.50
d.s =~ 0*CES_92 + 2*CES_94 + 10*CES.40 + 20*CES.50
d.q =~ 0*CES_92 + 4*CES_94 + 100*CES.40 + 400*CES.50

d.i ~ AFQT89 + SAMPLE_SEX + age_1979 + SexIQint
d.s ~ AFQT89 + SAMPLE_SEX + age_1979 + SexIQint
d.q ~ AFQT89 + SAMPLE_SEX + age_1979 + SexIQint

'



f3 = lavaan(m3, data = dep, 
            meanstructure = TRUE, int.ov.free = FALSE, int.lv.free = TRUE, 
            auto.fix.first = TRUE #std.lv = TRUE
            , auto.fix.single = TRUE, auto.var = TRUE, auto.cov.lv.x = TRUE, 
            auto.th = TRUE, auto.delta = TRUE, auto.cov.y = TRUE
)

fitMeasures(f3, c("chisq", "df", "pvalue", "cfi", 'srmr', "rmsea"))
summary(f3)





m4 <- '
d.i =~ 1*CES_92 + 1*CES_94 + 1*CES.40 + 1*CES.50
d.s =~ 0*CES_92 + 2*CES_94 + 10*CES.40 + 20*CES.50
d.q =~ 0*CES_92 + 4*CES_94 + 100*CES.40 + 400*CES.50

d.i ~ AFQT89 + SAMPLE_SEX + age_1979 + SexIQint + Child_SES + Adult_SES
d.s ~ AFQT89 + SAMPLE_SEX + age_1979 + SexIQint + Child_SES + Adult_SES
d.q ~ AFQT89 + SAMPLE_SEX + age_1979 + SexIQint + Child_SES + Adult_SES

'



f4 = lavaan(m4, data = dep, 
            meanstructure = TRUE, int.ov.free = FALSE, int.lv.free = TRUE, 
            auto.fix.first = TRUE #std.lv = TRUE
            , auto.fix.single = TRUE, auto.var = TRUE, auto.cov.lv.x = TRUE, 
            auto.th = TRUE, auto.delta = TRUE, auto.cov.y = TRUE
)

fitMeasures(f4, c("chisq", "df", "pvalue", "cfi", 'srmr', "rmsea"))
summary(f4)




