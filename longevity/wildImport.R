# Wild chimp data

library(lubridate)

wch <- read.csv(file = 'WildChimp_biography.csv')

#colnames(wch)
#table(wch$departtype)
#head(as.integer(as.character(wch$departdate)))

wch$birthdate = as.Date(wch$birthdate,format='%Y-%m-%d')
wch$departdate = as.Date(wch$departdate,format='%Y-%m-%d')

wch$age = difftime(wch$departdate,wch$birthdate, units = 'weeks')/52.25

wch = wch[wch$age!=0,]
wch$departtype = (wch$departtype=='D')
wch$sample = 'Wild'
colnames(wch)[18] = 'status'
wch = wch[wch$status==TRUE,]

wch = rbind(datX[,c('age','status','sample')],wch[,c('age','status','sample')])
wch$sample[wch$sample!= 'Wild'] = 'Captive'
colnames(wch)[3] = 'Sample'

y.wild <- Surv(as.numeric(wch$age),wch$status)

                        