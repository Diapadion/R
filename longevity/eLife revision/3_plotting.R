### Plots

library(ggplot2)
library(tidyr)
library(survival)
library(grid)
library(beanplot)
library(rms)



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

ggplot(data=datX[datX$status==TRUE,], aes(age)) + geom_histogram(binwidth=3) +
  theme_bw() + theme(legend.position="none") + labs(x='Age at Death')
  


### Age & personality issues

pdx = gather(datX, Personality, Measurement, Dom:Opn)
pdx$Personality <- as.factor(pdx$Personality)
levels(pdx$Personality) <- c('Agreeableness','Conscientiousness','Dominance','Extraversion','Neuroticism','Openness')

p <- ggplot(pdx, aes(age_pr, Measurement, colour = factor(Personality))) + geom_point() + 
  theme_bw() + theme(legend.position="none") + 
  labs(x='Age at Personality Rating', y='Personality Dimension Value')

p + facet_wrap(~ Personality, nrow = 2)

### >>> Bean plots and scatterplots were combined using Inkscape to make Figure 2.



### Captive vs. wild survival curves
## Requires wildImport.R

npsf.1 = npsurv(y.wild ~ Sample, data=wch)


par(family = 'sans', cex.lab = 1.25, cex.axis = 1.1)

# Figure 1:
survplot(npsf.1, xlab = 'Age')
