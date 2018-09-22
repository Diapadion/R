### Visualization

library(lme4)
library(lattice)
library(ggplot2)




## Determine Carmen vs. us offset - unnecessary?
set.seed(1234567)
m0.00 <- lmer(fWHR ~ 1 + (1|instrument), data=chFP)
summary(m0.00)
ranef(m0.00)$instrument[2,1] - ranef(m0.00)$instrument[1,1] # this value should be added to Bas
# [1] 0.2313963

chAgr = chFP
#chAgr$fWHR[chAgr$instrument=='Bas'] = chAgr$fWHR[chAgr$instrument=='Bas'] + 0.2313963


## Aggreagate into individuals
chAgr$Sex = as.numeric(chAgr$Sex)
chAgr <- aggregate(chAgr[adults,], by=list(chAgr$ID[adults]), FUN=mean)


## Reattach subspecies
chAgr <- merge(chAgr[,c(1,8:26)],subsp[,c(1,2)], by.x='Group.1', by.y='Name')

colnames(chAgr)[1] <- 'ID'





###

plot(chAgr$fWHR ~ chAgr$Dom)
plot(chAgr$fWHR ~ chAgr$Agr)

cor(chAgr$fWHR, chAgr$Dom)
cor(chAgr$fWHR, chAgr$Agr)

xyplot(data=chAgr, fWHR ~ Dom | Sex)



## 

chAgr$verus = 'other'
chAgr$verus[chAgr$Subspecies=='verus'] = 'verus'
chAgr$verus[chAgr$Subspecies=='troglodytes'] = 'troglodytes'
#chAgr$verus[chAgr$verus=='other'] = NA

chAgr$Sex = as.factor(chAgr$Sex)
levels(chAgr$Sex) <- c('Female','Male')


### Publication Figure 2?

g <- ggplot(data=chAgr, aes(x=Agr, y=fWHR)) + geom_point() +
  #facet_grid(verus ~ Sex) +
  stat_smooth(method='gam') +
  theme_bw() + xlab('Agreeableness')

g


### Publication Figure 2?

g <- ggplot(data=subset(chAgr, chAgr$Agr_CZ<='other'))
              chAgr, 
              aes(x=Neu, y=fWHR)) + geom_point() +
  facet_grid(. ~ verus) +
  stat_smooth(method='gam') +
  theme_bw() + xlab('Neuroticism')

g



### Publication Figure 3?

g <- ggplot(data=subset(chAgr, !(chAgr$verus=='other')), 
            aes(x=Dom, y=fWHR)) + geom_point() +
  facet_grid(verus ~ Sex) +
  stat_smooth(method='gam') +
  theme_bw() + xlab('Dominance')

g



# g <- ggplot(data=chAgr,
#             aes(x=Dom, y=fWHR)) + geom_point() +
#   facet_grid(verus ~ Sex) +
#   stat_smooth(method='gam') +
#   theme_bw() + xlab('Dominance')





### Publication Figure S2

g <- ggplot(data=subset(chAgr, !(chAgr$verus=='other')), 
            aes(x=Neu, y=fWHR)) + geom_point() +
  facet_grid(verus ~ Sex) +
  stat_smooth(method='gam') +
  theme_bw() + xlab('Neuroticism')

g



