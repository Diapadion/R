




# there are some NaN, NA issues with the
# mean/sd matrices, this is hopefully only
# a temporary fix
nanwipe <- is.nan(chmcor)
chmcor[nanwipe] <- NA
nanwipe <- is.nan(chscor)
chscor[nanwipe] <- NA


cormmat <- array(NA,dim=c(35,35))
corsmat <- array(NA,dim=c(35,35))

for (i in 1:35){
  for (j in 1:35){
    cormmat[i,j]=cor(chmcor[i,],chmcor[j,],use="complete")
    corsmat[i,j]=cor(chscor[i,],chscor[j,],use="complete")
  }
}


pdsMinusN <- as.matrix(pDomainScr[2:7])

# personality cross-correlation
xpcor <- array(dim=c(6,6))
for (i in 2:7){
  for (j in 2:7){
    xpcor[i-1,j-1]=cor(pDomainScr[,i],pDomainScr[,j])
  }
}


# compare to personality
cormmat <- array(dim=c(dim(chcor)[1],dim(pdsMinusN)[2]))
pcormmat <- cormmat
corsmat <- cormmat
pcorsmat <- cormmat
for (i in 1:dim(chmcor)[1]){
  for (j in 1:dim(pdsMinusN)[2]){
    cormmat[i,j] = cor.test(chmcor[i,],pdsMinusN[,j],na.omit=TRUE,method="spearman")$estimate
    pcormmat[i,j] = cor.test(chmcor[i,],pdsMinusN[,j],na.omit=TRUE,method="spearman")$p.value
    corsmat[i,j] = cor.test(chscor[i,],pdsMinusN[,j],na.omit=TRUE,method="spearman")$estimate
    pcorsmat[i,j] = cor.test(chscor[i,],pdsMinusN[,j],na.omit=TRUE,method="spearman")$p.value
  }
}







# for (i in 1:100){
#   rho = 0.5
#   a1 = sample(500:600,30)
#   a2 = sample(500:600,30)
# 
#   b = rho*a1+sqrt(1-rho^2)*(a1*rnorm(30,1,0.01))
#   c[i] = cor(b,a1)
# }

