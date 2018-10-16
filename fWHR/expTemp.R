### Alt - Alex approach

Sys.getenv('PATH')


system('g++ -v')

system('where make')

dotR <- file.path(Sys.getenv("HOME"), ".R")
if (!file.exists(dotR)) 
  dir.create(dotR)
M <- file.path(dotR, "Makevars")
if (!file.exists(M)) 
  file.create(M)
cat("\nCXXFLAGS=-O3 -Wno-unused-variable -Wno-unused-function", 
    file = M, sep = "\n", append = TRUE)

cat('Sys.setenv(BINPREF = "C:/RBuildTools/3.4/mingw_$(WIN)/bin/")',
    file = file.path(Sys.getenv("HOME"), ".Rprofile"), 
    sep = "\n", append = TRUE)

cat(readLines(M), sep = "\n")
cat(M)


install.packages("rstan", repos = "http://cloud.r-project.org/", dependencies=TRUE)


fx <- inline::cxxfunction( signature(x = "integer", y = "numeric" ) , '
	return ScalarReal( INTEGER(x)[0] * REAL(y)[0] ) ;
' )
fx( 2L, 5 ) # should be 10

library(rstan)
library(brms)


set.seed(1234567)
b0.fw <- brm(fWHR ~ 1 +
             (1 | location) + (1 | Subspecies) + (1 | ID:Subspecies)
           ,data=chFP[adults,],
           warmup = 3000, iter = 7000,
           control = list(adapt_delta = 0.9)
)
summary(b0.fw)
pairs(b0.fw)


set.seed(1234567)
bp1.fw <- brm(fWHR ~ Age + Sex + Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ +
              (1 | location) + (1 | Subspecies) + (1 | ID:Subspecies)
            ,data = chFP[adults,],
           warmup = 3000, iter = 7000,
           control = list(adapt_delta = 0.9)
)
summary(bp1.fw)






library(devtools)
install_github("patr1ckm/mvtboost")




#########
library(lme4)
library(bbmle)


summary(mp1)



## Split by sex

set.seed(1234567)
mp2.sx <- lmer(fWHR ~  Sex*Dom_CZ + 
                # Sex*Ext_CZ + Sex*Con_CZ + Sex*Agr_CZ + Sex*Neu_CZ + Sex*Opn_CZ +
                 Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ +
                (1 | location) + (1 | Subspecies) + (1 | ID:Subspecies)
              ,data = chFP[adults,]
              )

summary(mp2.sx)
confint(mp2.sx)



ICtab(mp1, mp2.sx,
       type='AIC',
       weights=TRUE, logLik=TRUE, sort=TRUE
       )





mp3.v.sx = lmer(fWHR ~ Sex*Dom_CZ +
                  # Sex*Ext_CZ + Sex*Con_CZ + Sex*Agr_CZ + Sex*Neu_CZ + Sex*Opn_CZ +
                  Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ +
               (1 | location) + (1 | ID)
             ,data = chFP[adults&chFP$Subspecies=='verus',]
)
summary(mp3.v.sx)


ICtab(mp3.v, mp3.v.sx,
      type='qAICc',
      weights=TRUE, logLik=TRUE, sort=TRUE
)






library(mgcv)

gam.p1 <- gamm(fWHR ~  s(Dom_CZ, bs='cs') + s(Ext_CZ, bs='cs') + s(Con_CZ, bs='cs') +
                 s(Agr_CZ, bs='cs') + s(Neu_CZ, bs='cs') + s(Opn_CZ, bs='cs'),
               random = list(location =~ 1, ID =~ 1, Subspecies =~ 1)
               ,data = chFP[adults,])
summary(gam.p1$gam)
plot(gam.p1$gam)


gam.p2 <- gamm(fWHR ~  s(Dom_CZ, by = Sex) + s(Ext_CZ) + s(Con_CZ) + 
                 s(Agr_CZ) + s(Neu_CZ) + s(Opn_CZ)
               ,random = list(location =~ 1, ID =~ 1, Subspecies =~ 1)
               ,data = chFP[adults,])
summary(gam.p2$gam)



gam.p3 <- gamm(fWHR ~  s(Agr_CZ, bs='tp')
               ,random = list(location =~ 1, ID =~ 1, Subspecies =~ 1)
               ,data = chFP[adults,])
plot(gam.p3$gam)

##
gam.p4 <- gam(fWHR ~  s(Agr_CZ, bs='cr') + s(location, bs='re') + s(ID, bs='re') +
                s(Agr_CZ, location, bs='re') + s(Agr_CZ, ID, bs='re') + s(Agr_CZ, Subspecies, bs='re')
               ,data = chFP[adults,])
gam.check(gam.p4)
summary(gam.p4)
plot(gam.p4)


gam.p5 <- gam(fWHR ~  ti(Neu_CZ, bs='cr') + ti(Dom_CZ, bs='cr') + ti(Neu_CZ, Dom_CZ, bs='cr')
              + s(Neu_CZ, bs='re') + s(Neu_CZ, location, bs='re') 
              + s(Neu_CZ, ID, bs='re') #+ s(Neu_CZ, Subspecies, bs='re')
              + s(Dom_CZ, bs='re') + s(Dom_CZ, location, bs='re') 
              + s(Dom_CZ, ID, bs='re') #+ s(Dom_CZ, Subspecies, bs='re')
              ,data = chFP[adults&(chFP$Subspecies=='verus'|chFP$Subspecies=='schweinfurthii'),])
gam.check(gam.p5)
summary(gam.p5)
plot(gam.p5)






library(blmeco)

WAIC(mp1)

WAIC(mp2)

WAIC(mp2.sx)



### Trees for publication ###


library(caret)
library(party)
library(rpart)
library(REEMtree)
library(lme4)



sort( sapply(ls(),function(x){object.size(get(x))})) 



chFP$Sex = as.factor(chFP$Sex)

set.seed(12345678)
tree.p1 = REEMtree(fWHR ~ Sex + Age + I(Age^2) + I(Age^3) + 
                     Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ + 
                     Subspecies,
                   #data=chFP[adults,],
                   data=chFP[chFP$ID!='Lennon',],
                   #random=~1|ID/Subspecies
                   random = list(location =~ 1, ID =~ 1)#, Subspecies =~ 1)
                   ,cv=TRUE, method='ML'
                   
                   )
print(tree.p1)
plot(tree.p1)



gb.tree.A = lmer(fWHR ~ Agr_CZ +
                    (1 | location) +  (1 | ID),
                  data=chFP[adults,])
summary(gb.tree.A)
plot(gb.tree.A)
## Small, insignificant effect.





gb.tree.vs.woA = lmer(fWHR ~ Dom_CZ * Neu_CZ +
                    + (1 | location) +  (1 | ID),
                  data=chFP[adults&(chFP$Subspecies=='verus'|chFP$Subspecies=='schweinfurthii')&chFP$Agr_CZ<1.051,]
)
summary(gb.tree.vs.woA)
confint(gb.tree.vs.woA, method='profile')


gb.tree.vs.wA = lmer(fWHR ~ Dom_CZ * Neu_CZ +
                    + (1 | location) +  (1 | ID),
                  data=chFP[adults&(chFP$Subspecies=='verus'|chFP$Subspecies=='schweinfurthii'),]
)
summary(gb.tree.vs.wA)


## Testing...
gb.tree.vs.woA.sx = lmer(fWHR ~ Dom_CZ * Sex * Neu_CZ * Sex +
                       + (1 | location) +  (1 | ID),
                     data=chFP[adults&(chFP$Subspecies=='verus'|chFP$Subspecies=='schweinfurthii')&chFP$Agr_CZ<1.051,]
)
summary(gb.tree.vs.woA.sx)


gb.tree.vs.wA.sx = lmer(fWHR ~ Dom_CZ * Sex * Neu_CZ * Sex +
                           + (1 | location) +  (1 | ID),
                         data=chFP[adults&(chFP$Subspecies=='verus'|chFP$Subspecies=='schweinfurthii'),]
)
summary(gb.tree.vs.wA.sx)


## Paper recreations
gb.tree.v.wA.sx = lmer(scale(fWHR) ~ Dom_CZ * Neu_CZ * Sex +
                           + (1 | location) +  (1 | ID),
                       #data=chFP[adults&(chFP$Subspecies=='verus'),]
                       data=chFP[(chFP$ID!='Lennon')&&(chFP$Subspecies=='verus'),]
)
summary(gb.tree.v.wA.sx)
confint(gb.tree.v.wA.sx, method='profile')



gb.tree.all.wA.sx = lmer(scale(fWHR) ~ Dom_CZ * Neu_CZ * Sex +
                          + (1 | location) +  (1 | ID),
                        data=chFP[adults,]
                        #data=chFP[chFP$ID!='Lennon',]
)
summary(gb.tree.all.wA.sx)
confint(gb.tree.all.wA.sx, method='profile')






## Old
gb.tree.vs = lmer(fWHR ~ Dom_CZ * Sex + Neu_CZ * Sex +
                 (1 | location) +  (1 | ID),
                 data=chFP[adults&(chFP$Subspecies=='verus'|chFP$Subspecies=='schweinfurthii'),]
)
summary(gb.tree.vs)



gb.tree.teo = lmer(fWHR ~ Age + Sex + Dom_CZ + Neu_CZ + Agr_CZ + Ext_CZ + Con_CZ + Opn_CZ +
                    (1 | location) +  (1 | ID),
                  data=chFP[adults&(chFP$Subspecies=='troglodytes'|chFP$Subspecies=='ellioti'|chFP$Subspecies=='unknown'),]
)
summary(gb.tree.teo)



gb.tree.vs.x = lmer(fWHR ~ Age + Sex + Dom_CZ + Neu_CZ + Agr_CZ + Ext_CZ + Con_CZ + Opn_CZ +
                    (1 | location) +  (1 | ID),
                  data=chFP[adults&(chFP$Subspecies=='verus'|chFP$Subspecies=='schweinfurthii'),]
)
summary(gb.tree.vs.x)




### CI tree version

set.seed(1234567)
cit.p1 = REEMctree(fWHR ~ Sex + Age + I(Age^2) + I(Age^3) + 
                     Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ + 
                     Subspecies,
                   #data=chFP[adults,],
                   data=chFP[chFP$ID!='Lennon',],
                   #random=~1|ID/Subspecies
                   random = list(instrument =~ 1, location =~1, ID =~ 1)#, Subspecies =~ 1)
                   , method='ML'
)
print(cit.p1$Tree)
plot(cit.p1$Tree)




Treelffhdf = adults & (!is.na(chFP$lffh))

set.seed(1234567)
treelf.p1 = REEMctree(lffh ~ Sex + Age + I(Age^2) + I(Age^3) + 
                       Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ + 
                       Subspecies,
                     data=chFP[lffhdf,],
                     #random=~1|ID/Subspecies
                     random = list(location =~ 1, ID =~ 1)#, Subspecies =~ 1)
                     , method='REML'
                     
)
plot(treelf.p1$Tree)



### Confirmatory regs

mp3.tree.1 = lmer(fWHR ~ Sex +
                  (1 | location) + (1 | ID),
                data = chFP[adults&(chFP$Subspecies=='verus'|chFP$Subspecies=='schweinfurthii'|chFP$Subspecies=='unknown'),]
)
summary(mp3.tree.1)
extractAIC(mp3.tree.1)


mp3.tree.2 = lmer(fWHR ~ Sex + Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ +
                    (1 | location) + (1 | ID),
                  data = chFP[adults&(chFP$Subspecies=='verus'|chFP$Subspecies=='schweinfurthii'|chFP$Subspecies=='unknown'),]
)
summary(mp3.tree.2)
extractAIC(mp3.tree.2)


mp3.tree.3 = lmer(fWHR ~ Sex * Dom_CZ + Sex * Ext_CZ + Sex * Con_CZ + 
                    Sex * Agr_CZ + Sex * Neu_CZ + Sex * Opn_CZ +
                    (1 | location) + (1 | ID),
                  #data = chFP[adults&(chFP$Subspecies=='verus'|chFP$Subspecies=='schweinfurthii'|chFP$Subspecies=='unknown'),]
                  data = chFP[adults&(chFP$Subspecies=='verus'|chFP$Subspecies=='schweinfurthii'),]
                  data = chFP[adults&(chFP$Subspecies=='verus'),]
)
summary(mp3.tree.3)
extractAIC(mp3.tree.3)



mp3.tree = lmer(fWHR ~ Sex * Dom_CZ * Neu_CZ +
                    (1 | location) + (1 | ID),
                  #data = chFP[adults&(chFP$Subspecies=='verus'|chFP$Subspecies=='schweinfurthii'|chFP$Subspecies=='unknown'),]
                #data = chFP[adults&(chFP$Subspecies=='verus'|chFP$Subspecies=='schweinfurthii'),]
                data = chFP[adults&(chFP$Subspecies=='verus'),]
)
summary(mp3.tree)
set.seed(1234567)
confint(mp3.tree, method='boot')


mp3.tree.both = lmer(fWHR ~ Sex * Dom_CZ * Neu_CZ +
                  (1 | location) + (1 | ID),
                data = chFP[adults,]
)
summary(mp3.tree.both)
set.seed(1234567)
ci.mptree = confint(mp3.tree.all, method='boot')
ci.mptree


mp3.all = lmer(fWHR ~ Age + Sex + Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ +
                       (1 | location) + (1 | ID),
                     data = chFP[adults,]
)
summary(mp3.all)




#######

library(glmertree)

tree.p1 <- lmertree(fWHR ~ Sex + Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ +
              (1 | location) + (1 | Subspecies) + (1 | ID:Subspecies)
            ,data = chFP[adults,]
)




### CV approach attempt ###

set.seed(1234567)
testIndx = createDataPartition(chFP$ID[adults], p= 0.5, list=FALSE, times=1)

chFP$ID[testIndx]
chFP$ID[-testIndx]



set.seed(1234567)
tree.p1 = REEMtree(fWHR ~ Sex + Age + I(Age^2) + I(Age^3) + 
                     Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ + 
                     Subspecies,
                   data=chFP[-testIndx,],
                   #random=~1|ID/Subspecies
                   random = list(location =~ 1, ID =~ 1)#, Subspecies =~ 1)
                   ,cv=TRUE, method='ML'
                   
)
print(tree.p1)
plot(tree.p1)



set.seed(1234567)
cit.p1 = REEMctree(fWHR ~ Sex + Age + I(Age^2) + I(Age^3) + 
                     Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ + 
                     Subspecies,
                   data=chFP[-testIndx,],
                   #random=~1|ID/Subspecies
                   random = list(location =~ 1, ID =~ 1)#, Subspecies =~ 1)
                   , method='REML'
                   
)
plot(cit.p1$Tree)







### GBM (CV and normal)


library(gbm)

gbm.test = gbm(fWHR ~ Sex + Age + I(Age^2) + I(Age^3) + 
                 Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ + 
                 Subspecies,
               data=chFP[adults,],
               distribution = 'gaussian',
               interaction.depth=2, n.trees=10000)

summary(gbm.test)
pretty.gbm.tree(gbm.test)



library(dismo)

set.seed(1234567)
gbmi.test = gbm.step(chFP, c(8:9,20:26), 12,
                     family='gaussian',n.trees=1000, step.size = 100, max.trees=20000,
                     tree.complexity=5, learning.rate=0.001, bag.fraction=0.5,
                     verbose=FALSE
                     )
summary(gbmi.test)

set.seed(12345)
find.int = gbm.interactions(gbmi.test)

find.int$rank.list
find.int$interactions



chFP$verus = 0
chFP$verus[chFP$Subspecies=='verus'] = 1

gb.mm.1 = lmer(fWHR ~ verus + Neu_CZ * Age + Dom_CZ * Age + Ext_CZ * Age + Opn_CZ * Age + 
                 (1 | location) +  (1 | ID), data=chFP
               )
summary(gb.mm.1)


gb.mm.1 = lmer(fWHR ~ Age + Sex * Dom_CZ + Ext_CZ + Con_CZ + Opn_CZ + Agr_CZ + Neu_CZ +
       (1 | location) +  (1 | ID:Subspecies) + (1 | ID:Subspecies), data=chFP[-testIndx,]
)
summary(gb.mm.1)



library(randomForest)
library(gamclass)

RFcluster(fWHR ~ Sex + Age + #I(Age^2) + I(Age^3) + 
            Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ + 
            Subspecies, id=ID#+location
          ,data=chFP,seed=1234567)







library(gbm)
library(mvtboost)


set.seed(1234567)
met.1 = metb(chFP$fWHR, chFP[,c(8:9,20:26)], id=c("ID"),#,"location"),
    distribution = 'gaussian', cv.folds=10,
    interaction.depth=3, n.trees=10000,
    indep=TRUE, mc.cores=1
    )

met.1 = metb(chFP$fWHR, chFP[,c(1,8:9,20:26)], id="ID",
         distribution = 'gaussian', cv.folds=1,
         interaction.depth=3, n.trees=3000,
         indep=TRUE, mc.cores=1
)
summary(met.1)

met.2 = metb(chFP$fWHR, chFP[,c(2,8:9,20:26)], id="location",
             distribution = 'gaussian', cv.folds=1,
             interaction.depth=3, n.trees=3000,
             indep=TRUE, mc.cores=1
)
summary(met.2)



data(wellbeing)

metest.auton = metb(wellbeing$autonomy, wellbeing[,c(1:20,22:26)],id=('educ'),
              distribution = 'gaussian', cv.folds=1,
              interaction.depth=3, n.trees=100,
              indep=TRUE, mc.cores=1   
              )
summary(metest)



metest.lonli = metb(wellbeing$lonlnes[!is.na(wellbeing$lonlnes)], 
                    wellbeing[!is.na(wellbeing$lonlnes),c(1:19,21:26)],
                    id=c('educ'),
                    distribution = 'gaussian', cv.folds=1,
                    interaction.depth=3, n.trees=100,
                    indep=TRUE, mc.cores=1   
)
summary(metest.lonli)







library(MuMIn)


drg.1 = dredge(mp1, beta='none', evaluate=TRUE)











library(LMERConvenienceFunctions)


m0r1 <- lmer(fWHR ~ 1 + (1|ID),data=chFP[adults,])

raneval <- ffRanefLMER.fnc(m0r1, 
                ran.effects=c("1|Subspecies"))




# library(psych)
# 
# nfactors(wellbeing[,c(5:26)])





### Random things ###


