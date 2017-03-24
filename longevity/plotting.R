# Plots

library(ggplot2)
library(tidyr)
library(survival)
library(grid)
library(powerSurvEpi)


### Power curves

n = 200
pwr.df = data.frame(HR=1:n,Agreeableness=numeric(n),Conscientiousness=numeric(n), Dominance=numeric(n),
                    Extraversion=numeric(n), Neuroticism=numeric(n), Openness=numeric(n))
j = 0
for (i in  seq(0.01,2, length.out = n)){
  j = j + 1 
  pwr.df$HR[j] = i
  mod = powerEpiCont(formula = (age - age_pr) ~ as.factor(sex) + 
                 as.factor(origin) +  
                 Dom_CZ + Ext_CZ + Con_CZ +
                 Agr_CZ + Neu_CZ + Opn_CZ,
               dat=datX, 
               X1 = Agr_CZ
               ,failureFlag = datX$status  ,
               n = 538, theta = i)
  pwr.df$Agreeableness[j] = mod$power
  mod = powerEpiCont(formula = (age - age_pr) ~ as.factor(sex) + 
                       as.factor(origin) +  
                       Dom_CZ + Ext_CZ + Con_CZ +
                       Agr_CZ + Neu_CZ + Opn_CZ,
                     dat=datX, X1 = Con_CZ
                     ,failureFlag = datX$status ,
                     n = 538, theta = i)
  pwr.df$Conscientiousness[j] = mod$power
  mod = powerEpiCont(formula = (age - age_pr) ~ as.factor(sex) + 
                       as.factor(origin) +  
                       Dom_CZ + Ext_CZ + Con_CZ +
                       Agr_CZ + Neu_CZ + Opn_CZ,
                     dat=datX, X1 = Dom_CZ
                     ,failureFlag = datX$status ,
                     n = 538, theta = i)
  pwr.df$Dominance[j] = mod$power
  mod = powerEpiCont(formula = (age - age_pr) ~ as.factor(sex) + 
                       as.factor(origin) +  
                       Dom_CZ + Ext_CZ + Con_CZ +
                       Agr_CZ + Neu_CZ + Opn_CZ,
                     dat=datX, X1 = Ext_CZ
                     ,failureFlag = datX$status ,
                     n = 538, theta = i)
  pwr.df$Extraversion[j] = mod$power
  mod = powerEpiCont(formula = (age - age_pr) ~ as.factor(sex) + 
                       as.factor(origin) +  
                       Dom_CZ + Ext_CZ + Con_CZ +
                       Agr_CZ + Neu_CZ + Opn_CZ,
                     dat=datX, X1 = Neu_CZ
                     ,failureFlag = datX$status ,
                     n = 538, theta = i)
  pwr.df$Neuroticism[j] = mod$power
  mod = powerEpiCont(formula = (age - age_pr) ~ as.factor(sex) + 
                       as.factor(origin) +  
                       Dom_CZ + Ext_CZ + Con_CZ +
                       Agr_CZ + Neu_CZ + Opn_CZ,
                     dat=datX, X1 = Opn_CZ
                     ,failureFlag = datX$status ,
                     n = 538, theta = i)
  pwr.df$Openness[j] = mod$power
  
}
pdx = gather(pwr.df, Personality, Power, Agreeableness:Openness)

pwr.p = ggplot(pdx, aes(x = HR, y= Power, color = Personality)) +
  geom_line(size = 2) + theme_bw() + facet_wrap(facets = 'Personality') + theme(legend.position="none")

pwr.p  



pdx = gather(datX, Personality, Measurement, Dom:Opn)

### beans of their personalities

vpers<-data.frame(Sample=character(),Dimension=character(),Score=numeric(), Sex=factor)
vpers<-pdx[,c(98,99,2)]
colnames(vpers) = c('Dimension','Score','Sex')


library(beanplot)

svg(filename="PersCCACE.svg",            
    width=10, 
    height=8, 
    pointsize=12,
    bg='white')
# par(mfrow=c(2,3),
#     oma = c(5,4,0,0) + 0.3,
#     mar = c(0,0,1,1) + 0.5)
beanpersD <- with(data=vpers, beanplot(Score ~ Sex * Dimension, side = 'both',  cutmax = 7, cutmin = 1, #bw = 0.3,
                                                                      overallline = "median", beanlines = 'median', what = c(0,1,1,0), boxwex=0.9,
                                                                      col = list('salmon3','salmon1','gold3','gold1','green4','green2',
                                                                        "cadetblue3", "cadetblue1", "royalblue3", "royalblue1","slateblue","slateblue1"),
                                                                      main='Personality Distributions', show.names=TRUE)
)

beanpersA <- with(data=vpers[vpers$Dimension=='Agreeableness',], beanplot(Score, side = 'both', bw = 0.3, cutmax = 4, cutmin = 1,
                                                                          overallline = "median", beanlines = 'median', what = c(0,1,1,0), boxwex=0.9,
                                                                          col = list("cadetblue3", "cadetblue1", "royalblue3", "royalblue1","slateblue","slateblue1"),
                                                                          main='Agreeableness' , show.names=FALSE 
)
)
beanpersN <- with(data=vpers[vpers$Dimension=='Neuroticism',], beanplot(Score ~ Sex * Sample, side = 'both', bw = 0.3, cutmax = 4, cutmin = 1,
                                                                        overallline = "median", beanlines = 'median', what = c(0,1,1,0), boxwex=0.9,
                                                                        col = list("cadetblue3", "cadetblue1", "royalblue3", "royalblue1","slateblue","slateblue1"),
                                                                        main='Neuroticism' , show.names=FALSE)
)
beanpersO <- with(data=vpers[vpers$Dimension=='Openness',], beanplot(Score ~ Sex * Sample, side = 'both', bw = 0.3, cutmax = 4, cutmin = 1,
                                                                     overallline = "median", beanlines = 'median', what = c(0,1,1,0), boxwex=0.9,
                                                                     col = list("cadetblue3", "cadetblue1", "royalblue3", "royalblue1","slateblue","slateblue1"),
                                                                     main='Openness' 
))

beanpersC <- with(data=vpers[vpers$Dimension=='Conscientiousness',], beanplot(Score ~ Sex * Sample, side = 'both', bw = 0.3, cutmax = 4, cutmin = 1,
                                                                              overallline = "median", beanlines = 'median', what = c(0,1,1,0), boxwex=0.9,
                                                                              col = list("cadetblue3", "cadetblue1", "royalblue3", "royalblue1","slateblue","slateblue1")
                                                                              , main='Conscientiousness'
)
)

beanpersE <- with(data=vpers[vpers$Dimension=='Extraversion',], 
                  beanplot(Score ~ Sex * Sample, side = 'both', bw = 0.3, cutmax = 4, cutmin = 1,
                           overallline = "median", beanlines = 'median', what = c(0,1,1,0), boxwex=0.9,
                           col = list("cadetblue3", "cadetblue1", "royalblue3", "royalblue1","slateblue","slateblue1")
                           , main='Extraversion' #, yaxt=''
                  ))
dev.off()


### Deaths 

ggplot(data=datX, aes(age_pr)) + geom_histogram(binwidth=3) +
  theme_bw() + theme(legend.position="none") + labs(x='Age at Personality Rating')

ggplot(data=datX[datX$stat.log==T,], aes(age)) + geom_histogram(binwidth=3) +
  theme_bw() + theme(legend.position="none") + labs(x='Age at Death')
  


### personality all on one plot




### age * pers issues

pdx = gather(datX, Personality, Measurement, Dom:Opn)
pdx$Personality <- as.factor(pdx$Personality)
levels(pdx$Personality) <- c('Agreeableness','Conscientiousness','Dominance','Extraversion','Neuroticism','Openness')

p <- ggplot(pdx, aes(age_pr, Measurement, colour = factor(Personality))) + geom_point() + 
  theme_bw() + theme(legend.position="none") + labs(x='Age at Personality Rating')

p + facet_wrap(~ Personality, nrow = 2)


# LASSO adjusted
pdx = gather(datX, Personality, Measurement, N.cv.r:O.cv.r)

p <- ggplot(pdx, aes(age_pr, Measurement, colour = factor(Personality))) + geom_point() + 
  theme_bw() + theme(legend.position="none") + labs(x='Age at Personality Rating')

p + facet_wrap(~ Personality, nrow = 2)


### after correction

pdx = gather(datX, Personality, Measurement, c(87:90))

p <- ggplot(pdx, aes(age_pr, Measurement, colour = factor(Personality))) + geom_point() + 
  theme_bw() + theme(legend.position="none") + labs(x='Age at Personality Rating')

p + facet_wrap(~ Personality)



####### OLD ##########


plot(Dataset$Ext_CZ ~ Dataset$status)

plot(Dataset$Dom_CZ ~ Dataset$status)


plot(Dataset$origin ~ Dataset$status)
plot(Dataset$age ~ Dataset$origin)

# plot(Ext_CZ ~ age_pr, data=datX)
plot(Dom_CZ ~ age_pr, data=datX)
plot(Neu_CZ ~ age_pr, data=datX)
plot(Opn_CZ ~ age_pr, data=datX)


plot(Dataset$age_pr, Dataset$Agr_CZ)
cor.test(Dataset$age_pr, Dataset$Agr_CZ)

plot(Dataset$age_pr, Dataset$Dom_CZ)
cor.test(Dataset$age_pr, Dataset$Dom_CZ) # *

plot(Dataset$age_pr, Dataset$Opn_CZ)
cor.test(Dataset$age_pr, Dataset$Opn_CZ) # **

plot(Dataset$age_pr, Dataset$Con_CZ)
cor.test(Dataset$age_pr, Dataset$Con_CZ)

plot(Dataset$age_pr, Dataset$Neu_CZ)
cor.test(Dataset$age_pr, Dataset$Neu_CZ) # *

plot(Dataset$age_pr, Dataset$Ext_CZ)
cor.test(Dataset$age_pr, Dataset$Ext_CZ) # *

plot(Dataset$DoB, Dataset$Ext_CZ)
plot(Dataset$age, Dataset$Ext_CZ)
plot(Dataset$age_pr_adj, Dataset$Ext_CZ)

library(psych)

pxt.cors = corr.test(as.matrix(Dataset[,c(73:78)]),as.matrix(as.numeric(Dataset$DoB)), 
          method = "spearman", adjust='bonferroni'
          , ci=TRUE)
cor.ci(cbind(as.matrix(Dataset[,c(73:78)]),as.matrix(as.numeric(Dataset$DoB))),
       method = 'spearman', plot=T)
# Dom, Neu, Opn, Ext
# as of 28/03/16, with 529 data points, all are sig


### Residual EN correlations

corr.test(as.matrix(datX[,c(101:106)]), as.matrix(as.numeric(datX$DoB)),
          method = "pearson", adjust='holm'
          , ci=TRUE)


### Residual LM correlations (informed by stability)

corr.test(as.matrix(datX[,c('D.r2.DoB','C.r.DoB','A.r.DoB',
                    'N.r1.DoB','O.r1.DoB','E.r2.DoB')]), 
          as.matrix(as.numeric(datX$age_pr)),
          method = "pearson", adjust='holm'
          , ci=TRUE)




plot(Dataset$age_pr, Dataset$DoB-Dataset$age)


plot(Dataset$Ext_CZ, Dataset$Ext_CZ - scale(Dataset$age_pr))
plot(Dataset$Ext_CZ, Dataset$age_pr - 5 * Dataset$Ext_CZ)

# could one substract the max value to reverse the range?



# substraction is not quite the right operation
plot(1/Dataset$age_pr_adj, Dataset$Ext_CZ)
plot(scale(1/scale(Dataset$age_pr_adj)), Dataset$Ext_CZ)
plot(Dataset$Ext_CZ-scale(1/scale(Dataset$age_pr_adj)), Dataset$Ext_CZ)

# which of these two?
plot(Dataset$age_pr_adj, Dataset$Ext_CZ-scale(1/(1 + Dataset$age_pr_adj))) # former, this one
plot(Dataset$age_pr_adj, scale(1/scale(Dataset$age_pr_adj))-Dataset$Ext_CZ)

# also...
plot(Dataset$age_pr_adj, Dataset$Ext_CZ-scale(1/as.numeric(year(Dataset$DoB)))) # nope, no good



View(cbind(Dataset$age_pr_adj, Dataset$Ext_CZ,
           Dataset$Ext_CZ-scale(1/Dataset$age_pr_adj),
           scale(1/scale(Dataset$age_pr_adj))-Dataset$Ext_CZ     ))

# division?
plot(Dataset$Ext_CZ/scale(Dataset$age_pr_adj), Dataset$Ext_CZ)
plot(Dataset$age_pr_adj, Dataset$Ext_CZ/scale(Dataset$age_pr_adj)) # too condensed

Dataset$divE <- scale(Dataset$Ext_CZ/scale(Dataset$age_pr_adj))

fit.e <- lm(Ext_CZ ~ years(DoB)-age, data=Dataset)
plot(fit.e)

fit.e <- lm(Ext_CZ ~ age, data=Dataset)
plot(fit.e)


plot(datX$age_pr_adj, datX$Ext_CZ)
plot(datX$age_pr_adj, datX$E.resid)
#fit.e2 <- 






# Wild vs. Captive 
plot(datX$DoB, datX$origin)
plot(datX$age_pr_adj, datX$origin)
plot(datX$age, datX$origin)



