### MIDUS and MIDJA, BSEM with cross-loadings

install.packages("blavaan", repos="http://faculty.missouri.edu/~merklee", type="source")
install.packages("blavaan")

library(blavaan)
library(runjags)
library(rjags)



### Test comparisons based on the website scripts

HS.model2 <- ' visual =~ x1 + prior("dnorm(0,.1)")*x2 + prior("dnorm(0,.1)")*x3 + x4 + x5 + x6 + x7 + x8 + x9
               textual =~ x4 + prior("dnorm(0,.1)")*x5 + prior("dnorm(0,.1)")*x6 + x1 + x2 + x3 + x7 + x8 + x9
               speed   =~ x7 + prior("dnorm(0,.1)")*x8 + prior("dnorm(0,.1)")*x9 + x1 + x2 + x3 + x4 + x5 + x6
             '

fit2 <- bcfa(HS.model2, data=HolzingerSwineford1939, dp=dpriors(lambda="dnorm(0,100)"))
fit2.prec10 <- bcfa(HS.model2, data=HolzingerSwineford1939, dp=dpriors(lambda="dnorm(0,50)"),
                    adapt=2000, burnin=5000, sample=10000,
                    bcontrol=list(method='rjparallel'))

summary(fit2)
summary(fit2.prec10)



### MIDUS

AEOvars = c('Selfconfident','Forceful','Assertive','Outspoken','Dominant',
            'Creative','Imaginative','Intelligent','Curious','Broadminded',
            'Sophisticated','Adventurous','Warm',
            'Outgoing','Friendly','Lively','Active','Talkative'
)

allNA = apply(m1con[,AEOvars], 1, function(x) sum(is.na(x)))
noNA = (allNA == 0)
allNA = !(allNA == 18)



fact2x <- '
E =~ Outgoing + prior("dnorm(0,.1)")*Friendly + prior("dnorm(0,.1)")*Lively +
prior("dnorm(0,.1)")*Talkative + prior("dnorm(0,.1)")*Warm +
prior("dnorm(0,.1)")*Forceful + prior("dnorm(0,.1)")*Assertive + 
prior("dnorm(0,.1)")*Outspoken + prior("dnorm(0,.1)")*Dominant + 
prior("dnorm(0,.1)")*Selfconfident + prior("dnorm(0,.1)")*Active +
Creative + Imaginative + Intelligent + Curious + Broadminded + 
Sophisticated + Adventurous

O =~ Curious + prior("dnorm(0,.1)")*Creative + prior("dnorm(0,.1)")*Imaginative + 
prior("dnorm(0,.1)")*Intelligent + prior("dnorm(0,.1)")*Broadminded +
prior("dnorm(0,.1)")*Sophisticated + prior("dnorm(0,.1)")*Adventurous + 
Active +
Selfconfident + Forceful + Assertive + Outspoken + Dominant+
Warm + Outgoing + Friendly + Lively + Talkative

'



fact3x <- '
A =~ Dominant + prior("dnorm(0,.1)")*Forceful + prior("dnorm(0,.1)")*Assertive + 
prior("dnorm(0,.1)")*Outspoken + prior("dnorm(0,.1)")*Selfconfident +
Warm + Outgoing + Friendly + Lively + Active + Talkative +
Creative + Imaginative + Intelligent + Curious + Broadminded +
Sophisticated + Adventurous

E =~ Outgoing + prior("dnorm(0,.1)")*Friendly + prior("dnorm(0,.1)")*Lively +
prior("dnorm(0,.1)")*Talkative + prior("dnorm(0,.1)")*Warm +
prior("dnorm(0,.1)")*Active + Selfconfident +
Creative + Imaginative + Intelligent + Curious + Broadminded + Sophisticated + Adventurous +
Forceful + Assertive + Outspoken + Dominant

O =~ Curious + prior("dnorm(0,.1)")*Creative + prior("dnorm(0,.1)")*Imaginative + 
prior("dnorm(0,.1)")*Intelligent + prior("dnorm(0,.1)")*Broadminded +
prior("dnorm(0,.1)")*Sophisticated + prior("dnorm(0,.1)")*Adventurous + 
Active + Selfconfident + 
Forceful + Assertive + Outspoken + Dominant +
Warm + Outgoing + Friendly + Lively + Talkative

'

#View(as.matrix(m1con)[allNA,AEOvars])

b.x.fit2 <- bcfa(fact2x, data=as.matrix(m1con)[noNA,AEOvars], 
                 dp=dpriors(lambda="dnorm(0,50)"),
                 #adapt=2000, burnin=5000, sample=10000,
                 adapt=500, burnin=500, sample=3000,
                 bcontrol=list(method='rjparallel'))

#summary(b.x.fit2)

b.x.fit3 <- bcfa(fact3x, data=as.matrix(m1con)[noNA,AEOvars], 
                 dp=dpriors(lambda="dnorm(0,50)"),
                 #adapt=2000, burnin=5000, sample=10000,
                 adapt=500, burnin=500, sample=3000,
                 bcontrol=list(method='rjparallel'))







allNAj = apply(midja1[,AEOvars], 1, function(x) sum(is.na(x)))
noNAj = (allNAj == 0)
allNAj = !(allNAj == 18)



b.x.fit2.j <- bcfa(fact2x, data=as.matrix(midja1)[noNAj,AEOvars], 
                 dp=dpriors(lambda="dnorm(0,50)"),
                 #adapt=2000, burnin=5000, sample=10000,
                 adapt=500, burnin=500, sample=3000,
                 bcontrol=list(method='rjparallel'))

start.time <- Sys.time()
b.x.fit3.j <- bcfa(fact3x, data=as.matrix(midja1)[noNAj,AEOvars], 
                   dp=dpriors(lambda="dnorm(0,50)"),
                   #adapt=2000, burnin=5000, sample=10000,
                   adapt=500, burnin=500, sample=3000,
                   bcontrol=list(method='rjparallel'))
end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken

     
                 


b.x.fit2.fm = fitMeasures(b.x.fit2)
b.x.fit3.fm = fitMeasures(b.x.fit3)

b.x.fit2.j.fm = fitMeasures(b.x.fit2.j)
b.x.fit3.j.fm = fitMeasures(b.x.fit3.j)


start.time <- Sys.time()
b.x.fit3.fm.new = blavFitIndices(b.x.fit3, pD="loo", rescale="devM")
#b.x.fit3.fm.new = blav_fit_measures(b.x.fit3)#, pD="loo", rescale="devM")
end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken



b.x.fit3.j.fm.new = blavFitIndices(b.x.fit3.j, pD="loo")
  

b.x.fit3.fm.new
b.x.fit3.j.fm.new

