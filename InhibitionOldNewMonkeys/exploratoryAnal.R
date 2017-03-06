### Analysis


# are there enough t1, t2 experiments to do some kind of latent difference curve?

library(psych)


colnames(bdf.1)

fa.parallel(bdf.1[,c(67,69:72,76:84,90:106)], fm='wls')
nfactors(bdf.1[,c(67,69:72,76:84,90:106)])

fa.parallel(cmat.p)
nfactors(cmat.p)


  bdf.1[,c(66:84,90:106)], fm='pa')

# Likely variables with missing values are  
# Bramlett2012.4 Perdue2015.vis.3 Bramlett2012.5 Perdue2015.vis.1 Bramlett2012.3  
b.pca.1 <- pca(bdf.1[,c(67,69:72,76:84,90:106)])

b.pca.4 <- pca(bdf.1[,c(69:72,76:84,90:106)], nfactors=2)





b.esem.1 = esem(cmat.p,60:90,1:54,1,5,rotate='varimax',fm='minres',plot=T)

b.esem.1 = esem(cmat.p,1:55,60:90,1,1,plot=T, rotate='varimax')

c(67,69:72,76:84,90:106)

colnames(cmat.p)

b.esem.1 = esem(cmat.p,1:54,55:85,1,1,fm='mle')
rotate='varimax',fm='wls',plot=T)

ib.0 = interbattery(cmat.p,1:54,60:90,5,1)
                        rotate='varimax',fm='wls',plot=T)

ib.1 = interbattery(cmat.p,55:59,60:90,1)
ib.2 = interbattery(cmat.p,55:59,60:90,2)
ib.3 = interbattery(cmat.p,55:59,60:90,3)
ib.4 = interbattery(cmat.p,55:59,60:90,4)
ib.5 = interbattery(cmat.p,55:59,60:90,5)

esem()


o.4 = omega(cmat, nfactors=4)
o.3 = omega(cmat, nfactors=3)
o.2 = omega(cmat, nfactors=2)
o.1 = omega(cmat, nfactors=1)




omegaSem(cmat, nfactors=4)




iclust(cmat.p[c(55:90),c(55:90)])


#compare two alternative solutions to the first 2 factors of the neo.
#solution 1 is the normal 2 factor solution.
#solution 2 is an esem with 1 factor for the first 6 variables, and 1 for the second 6.
f2 <- fa(neo[1:12,1:12],2)
es2 <- esem(bfi,1:12,13:24,1,1,plot=T,fm='pa')
summary(f2)
summary(es2)
fa.congruence(f2,es2)

test.esem <- esem(bfi,1:15,16:28,1,1,plot=T)





fx <-matrix(c( .9,.8,.6,rep(0,4),.6,.8,-.7),ncol=2)  
fy <- matrix(c(.6,.5,.4),ncol=1)
rownames(fx) <- c("V","Q","A","nach","Anx")
rownames(fy)<- c("gpa","Pre","MA")
Phi <-matrix( c(1,0,.7,.0,1,.7,.7,.7,1),ncol=3)
gre.gpa <- sim.structural(fx,Phi,fy)
print(gre.gpa)
