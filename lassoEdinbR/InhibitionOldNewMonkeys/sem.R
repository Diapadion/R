
colnames(bcp)

bdf.1.std = bdf.1
bdf.1.std[,c(5:106)] = scale(bdf.1[,c(5:106)])

cmat = cor(bdf.1.std[,c(67,69:72,76:84,90:106)], use = 'na.or.complete')
cmat.p = cor(bdf.1.std[,c(5:58,61:65,67,69:72,76:84,90:106)], use = 'na.or.complete')

cvmat = cov(bdf.1.std[,c(67,69:72,76:84,90:106)], use = 'na.or.complete')
cvmat.p = cov(bdf.1[,c(61:65,67,69:72,76:84,90:106)], use = 'na.or.complete')
cvmat.pAll = cov(bdf.1.std[,c(5:58,71:72,76:84,90:106)], use = 'na.or.complete')

c(67,69:72,76:84,90:106)

library(FactoMineR)

data(wine)
res <- MFA(wine, group=c(2,5,3,10,9,2), type=c("n",rep("s",5)),
           ncp=5, name.group=c("orig","olf","vis","olfag","gust","ens"),
           num.group.sup=c(1,6))
summary(res)
barplot(res$eig[,1],main="Eigenvalues",names.arg=1:nrow(res$eig))

# cc.1 = cc(bdf.1[,c(61:65)],bdf.1[,c(90:106)])
# 
# c(67,69:72,76:84,90:106)


res <- MFA(bdf.1[,c(61:65,90:10)],group=c(5,5,5))










library(lavaan)




m.1 <- '

Ast =~ Bullying + Aggressive + Submissive + Stingy.Greedy + Dominant + Jealous +
Gentle + Vulnerable + Timid + Irritable + Cautious + Dependent.Follower + Independent +
Manipulative + Fearful 

Opn =~ Inventive + Innovative + Inquisitive + Playful + Conventional + Active +
Curious + Lazy + Imitative + Persistent + Defiant + Quitting

Neu =~ Cool + Stable + Excitable + Predictable + Unemotional + Decisive + Impulsive +
Sympathetic

Soc =~ Sociable + Affectionate + Solitary + Depressed + Friendly + Anxious + Autistic

Atn =~ Disorganized + Unperceptive + Thoughtless + Clumsy + Distractible + Erratic +
Helpful

'


f.1 = lavaan(m.1,sample.cov=cvmat.pAll,sample.nobs=500,
             int.ov.free = TRUE, int.lv.free = FALSE, auto.fix.first = TRUE,
             std.lv = F, auto.fix.single = TRUE, auto.var = TRUE, 
             auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, auto.cov.y = TRUE
)

f.1 = cfa(m.1,bcp)



m.2 <- '

lv1 =~ 
#Perdue2015.vis.1 + 
Perdue2015.vis.2 + #Perdue2015.vis.3 +
Perdue2015.occ.1 + Perdue2015.occ.2 + Bramlett2012.1 + Bramlett2012.2 + #Bramlett2012.3 + 
#Bramlett2012.4 + Bramlett2012.5 + 
Bramlett2012.6 + Beran2016.1.rotTray.1 + Beran2016.1.rotTray.2 +
Beran2016.1.accum.1 + Beran2016.1.accum.2 + Beran2016.2.rotTray.1 +
Beran2016.2.rotTray.2 + Beran2016.2.accum.1 + Beran2016.2.accum.2 + 
# Beran2016.4.accum.pretest + Beran2016.4.rotTray.1 + Beran2016.4.rotTray.2 + 
# Beran2016.4.rotTray.3 + Beran2016.4.accum.posttest + 
Evans2012.1.1 +             
Evans2012.1.2 + Evans2012.1.3 + Evans2012.1.4 + Evans2012.2.foods + Evans2012.2.tokens +
Evans2014.wait.stbl.1 + Evans2014.wait.stbl.2 + Evans2014.wait.toler.1 + 
Evans2014.wait.toler.2 + Evans2014.work.stbl.1 + Evans2014.work.stbl.2 + 
Evans2014.work.toler.1 + Evans2014.work.toler.2 + Addessi2013.ITchoic +
Addessi2013.accum5. + Addessi2013.accum50    

'


colnames(cvmat)

f.2 = sem(m.2, sample.cov=cvmat, sample.nobs=200)



m.3 <- '

lv1 =~ 
#Perdue2015.vis.1 + 
Perdue2015.vis.2 + #Perdue2015.vis.3 +
Perdue2015.occ.1 + Perdue2015.occ.2 + Bramlett2012.1 + Bramlett2012.2 + #Bramlett2012.3 + 
#Bramlett2012.4 + Bramlett2012.5 + 
Bramlett2012.6 + Beran2016.1.rotTray.1 + Beran2016.1.rotTray.2 +
Beran2016.1.accum.1 + Beran2016.1.accum.2 + Beran2016.2.rotTray.1 +
Beran2016.2.rotTray.2 + Beran2016.2.accum.1 + Beran2016.2.accum.2 + 
# Beran2016.4.accum.pretest + Beran2016.4.rotTray.1 + Beran2016.4.rotTray.2 + 
# Beran2016.4.rotTray.3 + Beran2016.4.accum.posttest + 
Evans2012.1.1 +             
Evans2012.1.2 + Evans2012.1.3 + Evans2012.1.4 + Evans2012.2.foods + Evans2012.2.tokens +
Evans2014.wait.stbl.1 + Evans2014.wait.stbl.2 + Evans2014.wait.toler.1 + 
Evans2014.wait.toler.2 + Evans2014.work.stbl.1 + Evans2014.work.stbl.2 + 
Evans2014.work.toler.1 + Evans2014.work.toler.2 + Addessi2013.ITchoic +
Addessi2013.accum5. + Addessi2013.accum50

lv1 ~ cap_Ast + cap_Opn + cap_Soc + cap_Neu + cap_Att 
'

f.3 = sem(m.3, sample.cov=cvmat.p, sample.nobs=2000)



m.4 <- '
lv1 =~ Evans2012.1.1 +             
  Evans2012.1.2 + Evans2012.1.3 + Evans2012.1.4 + Evans2012.2.foods + Evans2012.2.tokens
'

f.4 = sem(m.4, sample.cov=cvmat, sample.nobs=200)


m.tst = '
Opn =~ O1 + O2 + O3 + O4 + O5 + N1
'
bfi.cv = cov(scale(bfi), use = 'na.or.complete')

f.tst = sem(m.tst, sample.cov=bfi.cv, sample.nobs=200)

bfi.cv = cov(scale(bfi), use = 'na.or.complete')
