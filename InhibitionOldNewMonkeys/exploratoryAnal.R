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


###

library(cluster)
library(gplots)
library(fpc)


wss <- (nrow(t.bdf.1)-1)*sum(apply(t.bdf.1,2,var))
for (i in 2:15) wss[i] <- sum(kmeans(mydata,
                                     centers=i)$withinss)

pamk.best <- pamk(t.bdf.1[57:96,])




#f.cla = clara(t.bdf.1, 5, metric='gower')

#f.pam = pam(t.bdf.1, 5, metric='gower')
f.pam = pam(t.bdf.1[57:96,], 3, metric='gower')

summary(f.pam)

clusplot(f.pam, main='3 cluster plot',labels=3)

# Evans2012.1.1                3        1  0.29233954 # (5 foods)
# Addessi2013.accum5.          3        1  0.26682645 # more accumulation of items from waiting
# Beran2016.2.rotTray.1        3        1  0.23322528 # maximizing number of rewards
# Bramlett2012.2               3        1  0.21979715 # rotTray: early stage, better performance
# Addessi2013.accum50          3        1  0.19625454 # more accumulation of items from waiting
# Beran2016.2.accum.2          3        1  0.17949394 # accum
# Beran2016.2.accum.1          3        2  0.15147368 # accum
# Evans2012.1.2                3        1  0.12328902 # (50 foods)
# Evans2014.work.stbl.1        3        2  0.11950855 # how long it takes to reach stable behaviour, choosing both small and large rewards
# cap_Att                      3        1  0.11624533 # more accumulation of items from waiting
# Beran2016.2.rotTray.2        3        1  0.11225318 # maximizing number of rewards
# Evans2014.wait.stbl.2        3        1  0.08262895 # how long it takes to reach stable behaviour, waiting time
# Evans2014.wait.stbl.1        3        1 -0.03020213 # how long it takes to reach stable behaviour, waiting time

# Evans2014.wait.toler.2       2        1  0.30839157 # less tolerant of waiting (time)
# Evans2014.work.stbl.2        2        1  0.27553811 ## how long it takes to reach stable behaviour, choosing both small and large rewards
# Bramlett2012.5               2        1  0.21249953 # 2nd-to-last phase of rotTray task, after drop-put
# cap_Neu                      2        1  0.19890919
# Perdue2015.occ.1             2        1  0.14868122 # larger visible on second arm, baiting hidden; this was the best for group performance
# Bramlett2012.6               2        1  0.08830011 # last phase of rotTray task, after drop-out
# Evans2014.wait.toler.1       2        3  0.06118676 # less tolerant of waiting (time)
# Addessi2013.ITchoic          2        3 -0.01151464 # fewer larger later choices, less waiting time
# Beran2016.1.accum.1          2        1 -0.13737798 ## less likely for rewards to accumulate


# Accumulation vs. size choice
# size choice may depends on waiting time of behavioural actions



kmeans(na.omit(t(bdf.1)[-1]),4 )
View(na.omit(t(bdf.1)))

###


manc.1 <- manova(cbind(cap_Ast,cap_Opn,cap_Neu,cap_Soc,cap_Att) ~ 
                   Perdue2015.vis.1 + Perdue2015.vis.2 + Perdue2015.vis.3, data=bdf.1)

manc.1 <- manova(cbind(cap_Ast,cap_Opn,cap_Neu,cap_Soc,cap_Att) ~ 
                   Beran2016.1.accum.1 + Beran2016.1.accum.2 + Beran2016.2.rotTray.1 
                 #  Beran2016.2.rotTray.2 + Beran2016.2.accum.1 + Beran2016.2.accum.2 
                , data=bdf.1[-1,]) 


summary(manc.1, test='Wilks', tol=0)



k#compare two alternative solutions to the first 2 factors of the neo.
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
