# processing for regression and (gg?)plot'ing

#df <- 

bunl<-cbind(c(1:153),c(bun[,]),c(rep(1,153),rep(2,153),rep(3,153),rep(4,153)))
colors = rainbow(153)

# plot(bunl[,3],bunl[,2])
# 
# for (i in 1:153){
#   lines(bunl[(bunl[,1]==i),2], type='b',col=colors[i])
# }

# remove NAs from chmcor for some processing
chmcor_lessna <- t(chmcor)
chmcor_lessna <- chmcor_lessna[-144,]
# chmcor_lessna[is.na(chmcor_lessna)] <- mean(chmcor) #...



rlmbun <- NULL
rlmchol <- NULL
rlmtrgl <- NULL
rlmlym <- NULL
rlmmon <- NULL

for (i in 1:153){
  #rlmbun[i] <-summary(lm(bun[i,]~c(1:4)))$coefficients[2,4]
  rlmchol[i] <-summary(lm(chol[i,]~poly(c(1:4), 2, raw = TRUE)))$coefficients[3,4]
  rlmtrgl[i] <-summary(lm(trgl[i,]~poly(c(1:4), 2, raw = TRUE)))$coefficients[3,4]
  rlmlym[i] <-summary(lm(lym[i,]~poly(c(1:3), 2, raw = TRUE)))$coefficients[3,4]
  rlmmon[i] <-summary(lm(mon[i,]~poly(c(1:3), 2, raw = TRUE)))$coefficients[3,4]
  
}

BtoCr <- bun/creat

mbtc <- apply(BtoCr,1,mean,na.rm=TRUE)
sbtc <- apply(BtoCr,1,sd,na.rm=TRUE)

for (i in 1:dim(pdsMinusN)[2]){
  psbtc = cor.test(sbtc,pdsMinusN[,i],na.omit=TRUE)
}

