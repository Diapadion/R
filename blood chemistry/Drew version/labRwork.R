install.packages(ggplot2)
library(ggplot2)
data(diamonds)

require(Lock5Data)
data(RestaurantTips)

fit = lm(Tip ~ Bill, data = RestaurantTips)

d = data.frame(RestaurantTips, predict(fit, interval="prediction"))


ggplot(d,aes(x=Bill,y=Tip)) + geom_point() + geom_smooth(method="lm")


ggplot(d,aes(x=Bill,y=Tip)) +
  geom_smooth(aes(ymin=lwr,ymax=upr,fill='confidence'),alpha=0.5) #+
  #geom_smooth(method="lm",aes(fill='confidence'),alpha=0.3) +
  geom_smooth(method="lm",se=FALSE,color='blue') +
  geom_point() +
  scale_fill_manual('Interval', values = c('green', 'yellow')) +
  ylab('Tip (dollars)') +
  xlab('Bill (dollars)')
#  geom_point() + geom_smooth(method="lm")




library(lme4)
fit1 <- lmer(price ~ carat + depth + clarity + (1 | cut), data = diamonds)
fit2 <- lm(price ~ carat, data = diamonds)  
fit3 <- lm(price ~ depth + carat, data = diamonds)

merfit = predict(fit1, newdata = diamonds)

Designmat <- model.matrix(eval(eval(fit1$call$fixed)[-2]), merfit[-ncol(merfit)])

dd = data.frame(diamonds, predict(fit1,interval='confidence'),predict(fit2,interval='confidence'),predict(fit3,interval='confidence'))

library(effects)

Effect("carat",fit1)




library(ez)
preds1<-ezPredict(fit1)


# -------s
  
ggplot(dd, aes(x=carat, y=price)) + 
  geom_smooth(method=lm)


  # Smoothers for subsets
  c <- ggplot(dd, aes(y=carat, x=price)) + facet_grid(. ~ cut)
c + stat_smooth(method=lm, fullrange = TRUE) + geom_point()
c + stat_smooth(method=lm) + geom_point