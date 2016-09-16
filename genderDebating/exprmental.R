# library(BayesFactor)











retrodesign(.013, 4.9)

retrodesign(1.2, 4.9/sqrt(2300), df=2312)


retrodesign(1.2, 4.9/sqrt(100), df=100) # prospective S and M errors?




retrodesign <- function(A, s, alpha=.05, df=Inf, n.sims=10000){
  z <- qt(1-alpha/2, df)
  p.hi <- 1 - pt(z-A/s, df)
  p.lo <- pt(-z-A/s, df)
  power <- p.hi + p.lo
  typeS <- p.lo/power
  estimate <- A + s*rt(n.sims,df)
  significant <- abs(estimate) > s*z
  exaggeration <- mean(abs(estimate)[significant])/A
  return(list(power=power, typeS=typeS, exaggeration=exaggeration))
}

# Example: true effect size of 0.1, standard error 3.28, alpha=0.05
retrodesign(.1, 3.28)
# Example: true effect size of 2, standard error 8.1, alpha=0.05
retrodesign(2, 8.1)
# Producing Figures 2a and 2b for the Gelman and Carlin paper
D_range <- c(seq(0,1,.01),seq(1,10,.1),100)
n <- length(D_range)
power <- rep(NA, n)
typeS <- rep(NA, n)
exaggeration <- rep(NA, n)
for (i in 1:n){
  a <- retrodesign(D_range[i], 1)
  power[i] <- a$power
  typeS[i] <- a$typeS
  exaggeration[i] <- a$exaggeration
}
pdf("pow1.pdf", height=2.5, width=3)
par(mar=c(3,3,0,0), mgp=c(1.7,.5,0), tck=-.01)
plot(power, typeS, type="l", xlim=c(0,1.05), ylim=c(0,0.54), xaxs="i", yaxs="i",
     xlab="Power", ylab="Type S error rate", bty="l", cex.axis=.9, cex.lab=.9)
dev.off()
pdf("pow2.pdf", height=2.5, width=3)
par(mar=c(3,3,0,0), mgp=c(1.7,.5,0), tck=-.01)
plot(power, exaggeration, type="l", xlim=c(0,1.05), ylim=c(0,12), xaxs="i", yaxs="i",
     xlab="Power", ylab="Exaggeration ratio", bty="l", yaxt="n", cex.axis=.9, cex.lab=.9)
axis(2, c(0,5,10))
segments(.05, 1, 1, 1, col="gray")
dev.off()