### IJD job categories IQ 

library(ggplot2)
library(ggridges)
library(doBy)
library(viridis)



ncds.jobs = merge(ncds0123[,c('ncdsid','n622','n914','n917','n920','n923','n926','bmi16',
                              'n236','n190','n194','n195','n537','n200','n607',
                              'n1612','n2017')], 
                  ncds7, by.x="ncdsid", by.y="ncdsid", all=TRUE)

ncds.jobs$Sex = ncds.jobs$n622
ncds.jobs$Sex[ncds.jobs$Sex=='Not known'] = NA
#table(ncds.jobs$Sex, useNA='ifany')

ncds.jobs$g = as.numeric(ncds.jobs$n920) - 2
ncds.jobs$g[ncds.jobs$g==-1] = NA

#mean(ncds.jobs$g, na.rm=TRUE) #43
#sd(ncds.jobs$g, na.rm=TRUE) #16.144

ncds.jobs$g = scale(ncds.jobs$g)
ncds.jobs$g = ncds.jobs$g * 15
ncds.jobs$g = ncds.jobs$g + 100
ncds.jobs$g = as.numeric(ncds.jobs$g)

#print(table(ncds.jobs$n7xso000)[which(table(ncds.jobs$n7xso000) > 29)])
idx = ncds.jobs$n7xso000 %in%  names(table(ncds.jobs$n7xso000))[table(ncds.jobs$n7xso000) > 29]

ncds.jobs.cut = ncds.jobs[idx,]

ncds.jobs.cut$n7xso000 = droplevels(ncds.jobs.cut$n7xso000)



# table(ncds.jobs$n7xso000[table(ncds.jobs$n7xso000) > 19])

# ncds.jobs$n7xso000[table(ncds.jobs$n7xso000) > 19]
# 
# ncds.jobs[ ncds.jobs$n7xso000 %in%  names(table(ncds.jobs$n7xso000))[table(ncds.jobs$n7xso000) > 19] , ]
# 
# dim(ncds.jobs[(table(ncds.jobs$n7xso000) > 19),])



## What of individuals who have no jobs listed?
ncds.jobs$anyJob = is.na(ncds.jobs$n7xso000)
table(ncds.jobs$anyJob)
summarySE(ncds.jobs, measurevar='g','anyJob', na.rm=TRUE)



ncds.jobs.aggr = summarySE(ncds.jobs.cut, measurevar='g','n7xso000', na.rm=TRUE)
ncds.jobs.aggr$ci.lower = ncds.jobs.aggr$g - ncds.jobs.aggr$ci
ncds.jobs.aggr$ci.upper = ncds.jobs.aggr$g + ncds.jobs.aggr$ci

ncds.jobs.aggr = ncds.jobs.aggr[-1,]
ncds.jobs.aggr = ncds.jobs.aggr[order(ncds.jobs.aggr$g),]
ncds.jobs.aggr$n7xso000 <- ordered(ncds.jobs.aggr$n7xso000, levels=levels(ncds.jobs.aggr$n7xso000)[unclass(ncds.jobs.aggr$n7xso000)])


My_Theme = theme(
  axis.title.x = element_text(size = 16),
  axis.text.x = element_text(size = 14)
  #axis.title.y = element_text(size = 16)
)


g = ggplot(data = ncds.jobs.aggr, aes(x=n7xso000, 
                                      y=g, ymin=ci.lower, ymax=ci.upper))+
  geom_pointrange() +
  geom_point(aes(y=min, color='blue'))+
  geom_point(aes(y=max, color='red'))+
  geom_hline(yintercept = 100, lty=2)+
  scale_y_continuous(breaks = c(60,70,80,90,100,110,120,130,140), limits=c(60,135))+
  coord_flip()+
  xlab('Job') + ylab('Mean (95% CI)')+
  theme_bw()+theme(legend.position = 'none')

g + My_Theme





### Ridgeline (Joy Division) plot

idx = ncds.jobs$n7xso000 %in%  names(table(ncds.jobs$n7xso000))[table(ncds.jobs$n7xso000) > 99]

ncds.jobs.cut = ncds.jobs[idx,]

ncds.jobs.cut$n7xso000 = droplevels(ncds.jobs.cut$n7xso000)

# ## What of individuals who have no jobs listed?
# ncds.jobs$anyJob = is.na(ncds.jobs$n7xso000)
# table(ncds.jobs$anyJob)
# summarySE(ncds.jobs, measurevar='g','anyJob', na.rm=TRUE)

ncds.jobs.aggr = summarySE(ncds.jobs.cut, measurevar='g','n7xso000', na.rm=TRUE)

ncds.jobs.aggr = ncds.jobs.aggr[order(ncds.jobs.aggr$g),]
ncds.jobs.aggr$n7xso000 <- ordered(ncds.jobs.aggr$n7xso000, levels=levels(ncds.jobs.aggr$n7xso000)[unclass(ncds.jobs.aggr$n7xso000)])

ncds.jobs.cut$Job = factor(ncds.jobs.cut$n7xso000,
                           levels=levels(ncds.jobs.aggr$n7xso000)
                           )
ncds.jobs.cut$Job = ordered(ncds.jobs.cut$Job)

ncds.jobs.cut = ncds.jobs.cut[ncds.jobs.cut$Job!='Not applicable',]




ncds.jobs.cut$pot = 'point'

gjd = ggplot(data = ncds.jobs.cut, aes(x=g, y=Job, fill=0.5 - abs(0.5-..ecdf..)))+
  stat_density_ridges(aes(point_fill=pot,point_shape=Sex),
                      geom = "density_ridges_gradient", 
                      calc_ecdf = TRUE,
                      quantile_lines=TRUE, quantiles=c(0.025,0.5,0.975), alpha=0.5
                      , jittered_points = TRUE, point_alpha=0.5, position=position_points_sina()#position_raincloud()
                      # position = position_points_jitter(width = 0.05, height = 0),
                      # point_shape = '|', point_size = 3, point_alpha = 1, alpha=0.7
                      ) +
  scale_fill_viridis(name = "Tail probability", direction = -1, option='E')+
  #scale_discrete_manual(aesthetics = 'point_shape', values=c(1)) +
  #scale_x_continuous(breaks = c(60,70,80,90,100,110,120,130,140), limits=c(60,140))+
  xlab("Childhood IQ")+
  theme_bw()+theme(legend.position = 'none')


gjd+My_Theme










### Older attempt from from later age


ncds9.2 <- read.dta13("ncds_2013_employment.dta", generate.factors = FALSE)

table(ncds0123$dvht16)

table(ncds9.2$N9AS2010)


ncds.jobs = merge(ncds0123[,c('ncdsid','n622','n914','n917','n920','n923','n926','bmi16',
                              'n236','n190','n194','n195','n537','n200','n607',
                              'n1612','n2017')], 
                  ncds9.2, by.x="ncdsid", by.y="NCDSID", all=TRUE)

ncds.jobs$g = as.numeric(ncds.jobs$n920) - 2
ncds.jobs$g[ncds.jobs$g==-1] = NA

ncds.jobs$N9AS2010[table(ncds.jobs$N9AS2010) > 19]

ncds.jobs[ ncds.jobs$N9AS2010 %in%  names(table(ncds.jobs$N9AS2010))[table(ncds.jobs$N9AS2010) > 19] , ]

dim(ncds.jobs[(table(ncds.jobs$N9AS2010) > 19),])

g = ggplot(data = ncds.jobs[ ncds.jobs$N9AS2010 %in%  names(table(ncds.jobs$N9AS2010))[table(ncds.jobs$N9AS2010) > 19] , ],
           #data=ncds.jobs[(table(ncds.jobs$N9AS2010) > 19),], 
           aes(y=n920)) + geom_boxplot() +
  facet_grid(N9AS2010 ~ .)

g


table(droplevels(ncds.jobs[ ncds.jobs$N9AS2010 %in%  names(table(ncds.jobs$N9AS2010))[table(ncds.jobs$N9AS2010) > 19] , ])$N9AS2010)



ncds.jobs.cut = ncds.jobs[ ncds.jobs$N9AS2000 %in%  names(table(ncds.jobs$N9AS2000))[table(ncds.jobs$N9AS2000) > 19] , ]

table(ncds.jobs.cut$N9AS2000)

ncds.jobs.cut$N9AS2000 = droplevels(ncds.jobs.cut$N9AS2000)

describeBy(as.integer(ncds.jobs.cut$g),
           group=ncds.jobs.cut$N9AS2000)




summarySE <- function(data=NULL, measurevar, groupvars=NULL, na.rm=FALSE, conf.interval=.95) {
  library(doBy)
  
  # New version of length which can handle NA's: if na.rm==T, don't count them
  length2 <- function (x, na.rm=FALSE) {
    if (na.rm) sum(!is.na(x))
    else       length(x)
  }
  
  # Collapse the data
  formula <- as.formula(paste(measurevar, paste(groupvars, collapse=" + "), sep=" ~ "))
  datac <- summaryBy(formula, data=data, FUN=c(length2,mean,sd,min,max), na.rm=na.rm)
  
  # Rename columns
  names(datac)[ names(datac) == paste(measurevar, ".mean",    sep="") ] <- measurevar
  names(datac)[ names(datac) == paste(measurevar, ".sd",      sep="") ] <- "sd"
  names(datac)[ names(datac) == paste(measurevar, ".length2", sep="") ] <- "N"
  names(datac)[ names(datac) == paste(measurevar, ".min",     sep="") ] <- "min"
  names(datac)[ names(datac) == paste(measurevar, ".max",     sep="") ] <- "max"

  datac$se <- datac$sd / sqrt(datac$N)  # Calculate standard error of the mean
  
  # Confidence interval multiplier for standard error
  # Calculate t-statistic for confidence interval: 
  # e.g., if conf.interval is .95, use .975 (above/below), and use df=N-1
  ciMult <- qt(conf.interval/2 + .5, datac$N-1)
  datac$ci <- datac$se * ciMult
  
  return(datac)
}
