### Visualization

library(lme4)
library(lattice)
library(ggplot2)
library(jtools)




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



### Publication Figure 2

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



### Interaction plots with full sample ###

chFull = chFP

## Aggreagate into individuals
chFull$Sex = as.numeric(chFull$Sex)
chFull <- aggregate(chAgr, by=list(chAgr$ID), FUN=mean)


## Reattach subspecies
chFull <- merge(chFull[,c(1,8:26)],subsp[,c(1,2)], by.x='Group.1', by.y='Name')

colnames(chFull)[1] <- 'ID'



## Plotting

interact_plot(lm(fWHR ~ Dom_CZ * Neu_CZ * Sex, data=chFull)
  , pred='Dom_CZ', modx='Neu_CZ', mod2='Sex', plot.points=TRUE)

interact_plot(lm(fWHR ~ Dom_CZ * Neu_CZ * Sex,
                 data=chFull[(chFull$Subspecies=='verus'#|chFull$Subspecies=='schweinfurthii'
                              ),])
              , pred='Dom_CZ', modx='Neu_CZ', mod2='Sex', plot.points=TRUE)


## This one may be the only important one
colnames(chFull)[19] = 'Neuroticism'
interact_plot(lm(fWHR ~ Dom_CZ * Neuroticism * Sex,
                 data=chFull[(chFull$Subspecies=='troglodytes'),])
              , pred='Dom_CZ', modx='Neuroticism', mod2='Sex', plot.points=TRUE,
              x.label = 'Dominance'
              )

interact_plot(lm(fWHR ~ Dom_CZ * Neuroticism * Sex,
                 data=chFull[(chFull$Subspecies=='troglodytes')&(chFull$ID!='Cordova'),])
              , pred='Dom_CZ', modx='Neuroticism', mod2='Sex', plot.points=TRUE,
              x.label = 'Dominance'
)



chFP[(chFP$Sex==1&chFP$fWHR>1.7&chFP$Dom_CZ<(-1)),]

