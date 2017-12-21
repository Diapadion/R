### Plots

library(ggplot2)
library(tidyr)
library(survival)
library(grid)
library(powerSurvEpi)
library(beanplot)
library(rms)



### Power curves, including full power analyses

n = 201
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
powerdx = gather(pwr.df, Personality, Power, Agreeableness:Openness)

dat.vline <- data.frame(
  Personality = c('Agreeableness','Conscientiousness','Dominance','Extraversion','Neuroticism','Openness'),
  xp = rep_len(0.7,6))

pwr.p = ggplot(pdx, aes(x = HR, y= Power, color = Personality)) +
  geom_line(size = 2) + theme_bw() + facet_wrap(facets = 'Personality') + 
  theme(legend.position="none") +
  geom_vline(aes(xintercept = xp), linetype='dashed', data = dat.vline)

pwr.p + labs(x = 'Hazard ratio')



pdx = gather(datX, Personality, Measurement, Dom:Opn)



### Beans of their personalities

vpers<-data.frame(Sample=character(),Dimension=character(),Score=numeric(), Sex=factor)
vpers<-pdx[,c('Personality','Measurement','sex')]
colnames(vpers) = c('Dimension','Score','Sex')

svg(filename="PersBeans.svg",            
    width=10, 
    height=8, 
    pointsize=12,
    bg='white')

beanpers <- with(data=vpers, 
                  beanplot(Score ~ Sex * Dimension, side = 'both',  cutmax = 7, cutmin = 1, #bw = 0.3,
                           overallline = "median", beanlines = 'median', what = c(0,1,1,0), boxwex=0.9,
                           col = list('salmon3','salmon1','gold3','gold1','green4','green2',
                                      "cadetblue3", "cadetblue1", "royalblue3", "royalblue1","slateblue","slateblue1"),
                           main='Personality Distributions', show.names=TRUE)
)

dev.off()



### Deaths 

ggplot(data=datX, aes(age_pr)) + geom_histogram(binwidth=3) +
  theme_bw() + theme(legend.position="none") + labs(x='Age at Personality Rating')

ggplot(data=datX[datX$stat.log==T,], aes(age)) + geom_histogram(binwidth=3) +
  theme_bw() + theme(legend.position="none") + labs(x='Age at Death')
  


### age * pers issues

pdx = gather(datX, Personality, Measurement, Dom:Opn)
pdx$Personality <- as.factor(pdx$Personality)
levels(pdx$Personality) <- c('Agreeableness','Conscientiousness','Dominance','Extraversion','Neuroticism','Openness')

p <- ggplot(pdx, aes(age_pr, Measurement, colour = factor(Personality))) + geom_point() + 
  theme_bw() + theme(legend.position="none") + 
  labs(x='Age at Personality Rating', y='Personality Dimension Value')

p + facet_wrap(~ Personality, nrow = 2)

### >>> Bean plots and scatterplots were combined using Inkscape to make Figure 2.



### Captive vs. wild survival curves
# Requires wildImport.R

npsf.1 = npsurv(y.wild ~ Sample, data=wch)

par(family = 'sans', cex.lab = 1.25, cex.axis = 1.1)

# Figure 1:
survplot(npsf.1, xlab = 'Age')
