### Revisions

library(survival)
library(eha)
library(ggplot2)



### Missing sample descriptives
summary(ht.df[!ccs,c('AFQT89','SAMPLE_SEX','Child_SES','Adult_SES','SES_Education_USE','SES_OccStatus_USE','SES_Income_USE')])



### More details on education and income

summary(ht.df$SES_Education_a[ccs])
ht.df$Edu_int = as.integer(ht.df$SES_Education_a)
table(ht.df$Edu_int[ccs], useNA='ifany')
mean(ht.df$Edu_int[ccs])

summary(ht.df$SES_Income_a[ccs])
summary(ht.df$SES_Income_b[ccs]) # B seems to be higher in a few fringe cases
#ht.df$Inc_dollars = ht.df$


View(ht.df[ccs,c('SES_Income_a','SES_Income_b')
           ])


cor(ht.df[ccs,c('SES_Income_a','SES_Income_b')])

mean(ht.df[ccs,c('SES_Income_b')])




### Partner status - sensitivity models

partn.14 = read.csv('./PartnerStat2014.csv')

colnames(partn.14)[c(2,6)] = c('caseid','partner.status')

partn.df = merge(ht.df, partn.14[,c('caseid','partner.status')],
                 by.x='CASEID_1979',by.y='caseid')

table(partn.df$partner.status, useNA='ifany')
partn.df$partner.status[partn.df$partner.status==-999] = NA
partn.df$partner.status[partn.df$partner.status==33] = 1 # just 'partner's



aft.gd3.4.partn = aftreg(y.ccs ~ SAMPLE_SEX * AFQT89 + age_1979 + Child_SES
                   + SES_Income_USE + partner.status
                   ,data = partn.df[ccs,], dist='loglogistic')
extractAIC(aft.gd3.4.partn)
summary(aft.gd3.4.partn)
## nothing at all...


# aft.gd3.8.partn = aftreg(y.ccs ~ SAMPLE_SEX * AFQT89 + age_1979 + Child_SES + Adult_SES
#                   + SES_Income_USE*SAMPLE_SEX + partner.status
#                   ,data = partn.df[ccs,], dist='loglogistic')
# extractAIC(aft.gd3.8.partn)
# summary(aft.gd3.8.partn)



### Split by sex - sensitivity models

M.ccs = ((ht.df$SAMPLE_SEX=='MALE')&ccs)

head(y.ccs[ht.df[ccs,]$SAMPLE_SEX=='MALE'])


aft.gd3.3.M = aftreg(y.ccs[ht.df[ccs,]$SAMPLE_SEX=='MALE'] ~ AFQT89 + age_1979 + Child_SES +
                      + Adult_SES
                    , data = ht.df[ccs&(ht.df$SAMPLE_SEX=='MALE'),], 
                    dist='loglogistic')

aft.gd3.3.F = aftreg(y.ccs[ht.df[ccs,]$SAMPLE_SEX=='FEMALE'] ~ AFQT89 + age_1979 + Child_SES +
                       + Adult_SES
                     , data = ht.df[ccs&(ht.df$SAMPLE_SEX=='FEMALE'),], 
                     dist='loglogistic')


summary(aft.gd3.3.M)
summary(aft.gd3.3.F)



### Make Figure 2 *taller*

ggfit = survfit(Surv(recordTime, hasHT) ~ sex_tert, data=ccs.df)

g <- ggsurvplot(ggfit, conf.int=T,censor=F
                , linetype = c(1,1,2,2,3,3)
                #, color = c(1,2,1,2,1,2)
                , palette = c('dodgerblue','violetred1','dodgerblue','violetred1','dodgerblue','violetred1')
                , legend = 'none' #c(0.2, 0.2) #'none'
                , xlim = c(19,55), ylim = c(0.5,1)
                , break.x.by = 5
) 

g = g + xlab('Age') +ylab('Proportion that remains normotensive')

g
