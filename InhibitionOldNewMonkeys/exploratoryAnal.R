### Analysis


# are there enough t1, t2 experiments to do some kind of latent difference curve?

library(psych)


colnames(bdf.1)

fa.parallel(bdf.1[,c(67,69:72,76:84,90:106)], fm='minres')
  bdf.1[,c(66:84,90:106)], fm='pa')

# Likely variables with missing values are  
# Bramlett2012.4 Perdue2015.vis.3 Bramlett2012.5 Perdue2015.vis.1 Bramlett2012.3  
b.pca.1 <- pca(bdf.1[,c(67,69:72,76:84,90:106)])

b.pca.4 <- pca(bdf.1[,c(67,69:72,76:84,90:106)], nfactors=4)




b.esem.1 = esem(bdf.1,varsX=90:105,varsY=5:58,1,2,rotate='varimax',fm='mle',plot=T)

c(67,69:72,76:84,90:106)





fx <-matrix(c( .9,.8,.6,rep(0,4),.6,.8,-.7),ncol=2)  
fy <- matrix(c(.6,.5,.4),ncol=1)
rownames(fx) <- c("V","Q","A","nach","Anx")
rownames(fy)<- c("gpa","Pre","MA")
Phi <-matrix( c(1,0,.7,.0,1,.7,.7,.7,1),ncol=3)
gre.gpa <- sim.structural(fx,Phi,fy)
print(gre.gpa)
