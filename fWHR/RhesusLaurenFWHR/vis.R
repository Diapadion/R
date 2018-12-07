### Making plots of personality and fWHR

library(ggplot2)
library(viridis)



# fWHR.avg

fWHR.avg = fWHR.avg[fWHR.avg$agenum<20,]

# plot(fWHR.avg$agenum, fWHR.avg$fWHR)


g <- ggplot(data=fWHR.avg, aes(x=agenum, y=Short.dom)) +
  geom_point(aes(size=fWHR)) + #,color=fWHR, 
  #facet_grid(verus ~ Sex) +
  stat_smooth(method='gam', formula = y~s(x, bs='tp', k=5)) +
  #stat_smooth(method = "lm", formula = y ~ poly(x, 2)) +
  #stat_smooth(method = "loess") +
  scale_color_viridis(end=0.8) +
  theme_bw() + xlab('Age') + ylab('Dominance')

g




g <- ggplot(data=fWHR.avg, aes(x=Short.dom, y=fWHR)) +
  geom_point(aes(size=agenum)) + #,color=fWHR, 
  #facet_grid(verus ~ Sex) +
  stat_smooth(method='gam', formula = y~s(x, bs='tp')) +
  scale_color_viridis(end=0.8) +
  theme_bw() + xlab('Dominance')

g



fWHR.avg$agegroup = fWHR.avg$agenum>8

g <- ggplot(data=fWHR.avg, aes(x=Short.dom, y=fWHR)) +
  geom_point(aes(size=agenum)) + #,color=fWHR, 
  facet_grid(.~agegroup) +
  stat_smooth(method='gam', formula = y~s(x, bs='cr', k=2)) +
  scale_color_viridis(end=0.8) +
  theme_bw() + xlab('Dominance')

g




## Kurtosis...

library(psych)

describe(fWHR.avg[,c('fWHR','LFFH')])

## fWHR
sqrt(24/91)








maqAgr <- aggregate(maqAgr, by=list(maqAgr$Rhesus), FUN=mean)

maqAgr <- merge(fWHR[,c(1,24)],maqAgr[,c(1,2:24,26:104)],by.x='Rhesus',by.y='Group.1')


#chAgr <- merge(chAgr[,c(1,8:26)],subsp[,c(1,2)], by.x='Group.1', by.y='Name')


hist(maqAgr$LFFH)
hist(maqAgr$fWHR)

sd(maqAgr$LFFH, na.rm=TRUE)
sd(maqAgr$fWHR, na.rm=TRUE)

mean(maqAgr$LFFH, na.rm=TRUE)
mean(maqAgr$fWHR, na.rm=TRUE)



### Ranges for JPC
summary(fWHR$agenum[fWHR$Facility.x=='UQ6934'&!is.na(fWHR$agenum)])

summary(fWHR$agenum[fWHR$Facility.x=='ZX6012'&!is.na(fWHR$agenum)])


