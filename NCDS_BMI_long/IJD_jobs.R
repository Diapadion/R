### IJD job categories IQ 

library(ggplot2)
library(ggridges)
library(doBy)
library(viridis)

library(data.table)
library(psych)
library(lavaan)
library(xlsx)

library(LambertW)



ncds.jobs = merge(ncds0123[,c('ncdsid','n622','n914','n917','n920','n923','n926','n929','bmi16',
                              'n236','n190','n194','n195','n537','n200','n607',
                              'n1612','n2017')], 
                  ncds7, by.x="ncdsid", by.y="ncdsid", all=TRUE)



# ncds.jobs$n914 = as.numeric(ncds.jobs$n914)
# ncds.jobs$n917 = as.numeric(ncds.jobs$n917)
# ncds.jobs$n923 = as.numeric(ncds.jobs$n923)
# ncds.jobs$n926 = as.numeric(ncds.jobs$n926)
# ncds.jobs$n929 = as.numeric(ncds.jobs$n929)
# 
# m.g.ncds <- '
# g =~ n914 + n917 + n923 + n926 + n929
# 
# '
# f.g.ncds = cfa(m.g.ncds, data=ncds.jobs, estimator='ML', missing='fiml')
# 
# fitMeasures(f.g.ncds, c("chisq", "df", "pvalue", "cfi", "tli", "srmr", "rmsea"))
# summary(f.g.ncds)



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



## Remove numbers from lead of NCDS codes
ncds.jobs$job.lvl = ncds.jobs$n7xso000
levels(ncds.jobs$job.lvl) = sub(".*? ","", levels(ncds.jobs$job.lvl))


#print(table(ncds.jobs$job.lvl)[which(table(ncds.jobs$job.lvl) > 29)])
idx = ncds.jobs$job.lvl %in%  names(table(ncds.jobs$job.lvl))[table(ncds.jobs$job.lvl) > 29]

ncds.jobs.cut = ncds.jobs[idx,]

ncds.jobs.cut$job.lvl = droplevels(ncds.jobs.cut$job.lvl)

table(ncds.jobs.cut$job.lvl)

# table(ncds.jobs$job.lvl[table(ncds.jobs$job.lvl) > 19])

# ncds.jobs$job.lvl[table(ncds.jobs$job.lvl) > 19]
# 
# ncds.jobs[ ncds.jobs$job.lvl %in%  names(table(ncds.jobs$job.lvl))[table(ncds.jobs$job.lvl) > 19] , ]
# 
# dim(ncds.jobs[(table(ncds.jobs$job.lvl) > 19),])



## What of individuals who have no jobs listed?
ncds.jobs$anyJob = is.na(ncds.jobs$job.lvl)
table(ncds.jobs$anyJob)
summarySE(ncds.jobs, measurevar='g','anyJob', na.rm=TRUE)





ncds.jobs.aggr = summarySE(ncds.jobs.cut, measurevar='g','job.lvl', na.rm=TRUE)
ncds.jobs.aggr$ci.lower = ncds.jobs.aggr$g - ncds.jobs.aggr$ci
ncds.jobs.aggr$ci.upper = ncds.jobs.aggr$g + ncds.jobs.aggr$ci

ncds.jobs.aggr = ncds.jobs.aggr[-1,]
ncds.forest.order = order(ncds.jobs.aggr$g)
ncds.jobs.aggr = ncds.jobs.aggr[ncds.forest.order,]
ncds.jobs.aggr$job.lvl <- ordered(ncds.jobs.aggr$job.lvl, levels=levels(ncds.jobs.aggr$job.lvl)[unclass(ncds.jobs.aggr$job.lvl)])


My_Theme = theme(
  axis.title.x = element_text(size = 16),
  axis.text.x = element_text(size = 14)
  #axis.title.y = element_text(size = 16)
)


g = ggplot(data = ncds.jobs.aggr, aes(x=job.lvl, 
                                      y=g, ymin=ci.lower, ymax=ci.upper))+
  geom_pointrange() +
  #geom_point(aes(y=min, color='blue'))+
  #geom_point(aes(y=max, color='red'))+
  geom_hline(yintercept = 100, lty=2)+
  scale_y_continuous(breaks = c(60,70,80,90,100,110,120,130,140), limits=c(80,125))+
  coord_flip()+
  xlab('Job') + ylab('Mean (95% CI)')+
  theme_bw()+theme(legend.position = 'none')

g + My_Theme



### Ridgeline (Joy Division) plot

idx = ncds.jobs$job.lvl %in%  names(table(ncds.jobs$job.lvl))[table(ncds.jobs$job.lvl) > 99]

ncds.jobs.cut = ncds.jobs[idx,]

ncds.jobs.cut$job.lvl = droplevels(ncds.jobs.cut$job.lvl)

# ## What of individuals who have no jobs listed?
# ncds.jobs$anyJob = is.na(ncds.jobs$job.lvl)
# table(ncds.jobs$anyJob)
# summarySE(ncds.jobs, measurevar='g','anyJob', na.rm=TRUE)

ncds.jobs.ridge = summarySE(ncds.jobs.cut, measurevar='g','job.lvl', na.rm=TRUE)

ncds.jobs.ridge = ncds.jobs.ridge[order(ncds.jobs.ridge$g),]
ncds.jobs.ridge$job.lvl <- ordered(ncds.jobs.ridge$job.lvl, levels=levels(ncds.jobs.ridge$job.lvl)[unclass(ncds.jobs.ridge$job.lvl)])

ncds.jobs.cut$Job = factor(ncds.jobs.cut$job.lvl,
                           levels=levels(ncds.jobs.ridge$job.lvl)
                           )
ncds.jobs.cut$Job = ordered(ncds.jobs.cut$Job)

ncds.jobs.cut = ncds.jobs.cut[ncds.jobs.cut$Job!='Not applicable',]




ncds.jobs.cut$pot = 'point'

gjd = ggplot(data = ncds.jobs.cut, aes(x=g, y=Job, fill=0.5 - abs(0.5-..ecdf..)))+
  stat_density_ridges(aes(point_fill=pot,#point_shape=Sex
                          ),
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

# 
# ncds9.2 <- read.dta13("ncds_2013_employment.dta", generate.factors = FALSE)
# 
# table(ncds0123$dvht16)
# 
# table(ncds9.2$N9AS2010)
# 
# 
# ncds.jobs = merge(ncds0123[,c('ncdsid','n622','n914','n917','n920','n923','n926','bmi16',
#                               'n236','n190','n194','n195','n537','n200','n607',
#                               'n1612','n2017')], 
#                   ncds9.2, by.x="ncdsid", by.y="NCDSID", all=TRUE)
# 
# ncds.jobs$g = as.numeric(ncds.jobs$n920) - 2
# ncds.jobs$g[ncds.jobs$g==-1] = NA
# 
# ncds.jobs$N9AS2010[table(ncds.jobs$N9AS2010) > 19]
# 
# ncds.jobs[ ncds.jobs$N9AS2010 %in%  names(table(ncds.jobs$N9AS2010))[table(ncds.jobs$N9AS2010) > 19] , ]
# 
# dim(ncds.jobs[(table(ncds.jobs$N9AS2010) > 19),])
# 
# g = ggplot(data = ncds.jobs[ ncds.jobs$N9AS2010 %in%  names(table(ncds.jobs$N9AS2010))[table(ncds.jobs$N9AS2010) > 19] , ],
#            #data=ncds.jobs[(table(ncds.jobs$N9AS2010) > 19),], 
#            aes(y=n920)) + geom_boxplot() +
#   facet_grid(N9AS2010 ~ .)
# 
# g
# 
# 
# table(droplevels(ncds.jobs[ ncds.jobs$N9AS2010 %in%  names(table(ncds.jobs$N9AS2010))[table(ncds.jobs$N9AS2010) > 19] , ])$N9AS2010)
# 
# 
# 
# ncds.jobs.cut = ncds.jobs[ ncds.jobs$N9AS2000 %in%  names(table(ncds.jobs$N9AS2000))[table(ncds.jobs$N9AS2000) > 19] , ]
# 
# table(ncds.jobs.cut$N9AS2000)
# 
# ncds.jobs.cut$N9AS2000 = droplevels(ncds.jobs.cut$N9AS2000)
# 
# describeBy(as.integer(ncds.jobs.cut$g),
#            group=ncds.jobs.cut$N9AS2000)



### UKBB version

ukbb <- read.csv('ukbb_jobs.csv')
ukbb = as.data.table(ukbb)

## Need to remove certain individuals
ukbb_rm <- read.csv('w10279_20200204.csv')
ukbb = ukbb[(!ukbb$eid %in% ukbb_rm$X1033591),]



ukbb = ukbb[,c(2:16)]

colnames(ukbb) <- c('eid','sex','YoB','MoB','assessment.date','education',
                    'num.mem','vnr','RT','prosp.mem',
                    'matrices','trailsB2','digit.symbol','vis.mem',
                    'job.num.lvl4'#,'job.aux1','job.aux2','deduced.job'
                    )



## Processing (in accordance with Lyall et al.)
ukbb$prosp.mem[ukbb$prosp.mem==2] = 0 # making everything that was not correct on first try
ukbb$RT.log = log(ukbb$RT)
ukbb$vis.mem.log = log(ukbb$vis.mem+1)
ukbb$trails.log = log(ukbb$trailsB2)


## Only analyze individuals with 3 or more tests complete
ukbb$enoughTests = apply(ukbb[,c(7:9,11:14)], MARGIN=1, function(x) sum(is.na(x)))
table(ukbb$enoughTests, useNA='ifany')
## 7 is 0 tests, 6 is 1 test, 5 is 2, so we need 4 or less



m.g <- '
g =~ vnr + num.mem + RT.log + vis.mem.log + #prosp.mem
matrices + trails.log + digit.symbol

'

f.g = cfa(m.g, data=ukbb[ukbb$enoughTests<5,], estimator='ML', missing='fiml')

fitMeasures(f.g, c("chisq", "df", "pvalue", "cfi", "tli", "srmr", "rmsea"))
#summary(f.g)


ukbb$g[ukbb$enoughTests<5] = as.numeric(lavPredict(f.g, method='EBM')) # ML has a much wider distr, maybe should stick with EBM...

table(is.na(ukbb$g), useNA='ifany')
hist(ukbb$g)


#hist(scale(ukbb$g))
ukbb$g.IQ = ukbb$g*15
ukbb$g.IQ = ukbb$g.IQ + 100

# ukbb$vnr.IQ = scale(ukbb$vnr)*15
# ukbb$vnr.IQ = ukbb$vnr.IQ + 100
# 
# hist(ukbb$vnr.IQ)
 

## The factor g is highly kurtotic and maybe skewed. It needs to be transformed to look more like NCDS g.
test_norm(ukbb$g.IQ[!is.na(ukbb$g.IQ)]) # takes a long time to run
## skewness: -0.3
## kurtosis: 3.6
## there also appear to be 3 upper outliers and ~1to2 lower outlier
table(ukbb$g.IQ > 170)
table(ukbb$g.IQ < 30)
ukbb$g.IQ[ukbb$g.IQ < 30] = NA
ukbb$g.IQ[ukbb$g.IQ > 170] = NA

test_norm(ncds.jobs$g[!is.na(ncds.jobs$g)])
## skewness: -0.17
## kurtosis: 2.3


mod.Lh <- MLE_LambertW(ukbb$g.IQ[!is.na(ukbb$g.IQ)], distname='normal', type='hh')
summary(mod.Lh)

xx <- get_input(mod.Lh)
test_norm(xx)


par(mfrow=c(1,1))
hist(xx)

ukbb$g.IQ.LW[!is.na(ukbb$g.IQ)] = xx
ukbb$g.IQ.LW = scale(ukbb$g.IQ.LW)
ukbb$g.IQ.LW = ukbb$g.IQ.LW*15
ukbb$g.IQ.LW = ukbb$g.IQ.LW+100

hist(ukbb$g.IQ.LW)


## Declassifying job codes

decoder = read.table("coding2.tsv", sep='\t', header=TRUE)
jobs58 = read.xlsx("NCDS-UKBB_jobs_correspond.xlsx", sheetIndex=1)



## first, assign parent IDs
ukbb$job.num.lvl3 <- decoder$parent_id[match(unlist(ukbb$job.num.lvl4), decoder$coding)]
ukbb$job.num.lvl2 <- decoder$parent_id[match(unlist(ukbb$job.num.lvl3), decoder$coding)]
ukbb$job.num.lvl1 <- decoder$parent_id[match(unlist(ukbb$job.num.lvl2), decoder$coding)]
ukbb$job.num.lvl0 <- decoder$parent_id[match(unlist(ukbb$job.num.lvl1), decoder$coding)]

## second, find the text for each level of code
ukbb$job.lvl4 <- decoder$meaning[match(unlist(ukbb$job.num.lvl4), decoder$coding)]
ukbb$job.lvl3 <- decoder$meaning[match(unlist(ukbb$job.num.lvl3), decoder$coding)]
ukbb$job.lvl2 <- decoder$meaning[match(unlist(ukbb$job.num.lvl2), decoder$coding)]
ukbb$job.lvl1 <- decoder$meaning[match(unlist(ukbb$job.num.lvl1), decoder$coding)]
ukbb$job.lvl0 <- decoder$meaning[match(unlist(ukbb$job.num.lvl0), decoder$coding)]

#head(ukbb,10)


### TODO:

## Make two subsets of data (from here)
##
## 1. UKBB participants with enough tests (at least 3) to form a g factor
## 2. Individuals born in 1958, but not in March
## 
## With 2.
## - make 2 plots to match those we made with the NCDS
##
## With 1.
## - use the same criteria as with the NCDS to make Forest and Ridgeline plots
##
## Notes:
## - lvl 3 is the "sensible" level
## - > 29 was cutoff for NCDS jobs inclusion in Forest plot
## - > 99 was cutoff for inclusion in Ridgeline plot
## - age split UKBB in half and compare properties to see if there are systematic differences
## - leave accupuncturists etc in and give supplementary / limitation mention


### OLD:
## 1. Get the list of jobs from the NCDS ridge-line plot
## 2. Add van drivers and medical practicioners
## 3. Show off plots
## 4. Fill in the remainder





### UKBB selected by NCDS birth year
## the NCDS was "born in Great Britain between March 3 and March 9, 1958"

ukbb.1958 = ukbb[((ukbb$YoB=='1957')|(ukbb$YoB=='1956')|(ukbb$YoB=='1955')|
                    (ukbb$YoB=='1959')|(ukbb$YoB=='1960')|(ukbb$YoB=='1961')|
                  (ukbb$YoB=='1958'))&(ukbb$MoB!='3'),]

ukbb.1958 = ukbb.1958[(ukbb.1958$job.lvl3%in%jobs58$UKBB.name),] # for the Forest plot
ukbb.1958.ridge = ukbb.1958[(ukbb.1958$job.lvl3%in%jobs58$UKBB.name[jobs58$in.ridgeplot.=='Y']),] # for the Ridge plot



ukbb.1958.aggr = summarySE(ukbb.1958, measurevar='g.IQ','job.lvl3', na.rm=TRUE)
## something is a problem because of bricklayers
## oh, there was only 1 of them born in 1958...
#ukbb.1958[ukbb.1958$job.lvl3=='Bricklayers, masons'] ## currently with 1957 added

ukbb.1958.aggr$ci.lower = ukbb.1958.aggr$g.IQ - ukbb.1958.aggr$ci
ukbb.1958.aggr$ci.upper = ukbb.1958.aggr$g.IQ + ukbb.1958.aggr$ci

ukbb.1958.aggr = ukbb.1958.aggr[-1,]
ukbb.1958.aggr = ukbb.1958.aggr[order(ukbb.1958.aggr$g.IQ),] # try reordering this by 1958 order
#ukbb.1958.aggr = ukbb.1958.aggr[ncds.forest.order,] # 
ukbb.1958.aggr$job.lvl3 <- ordered(ukbb.1958.aggr$job.lvl3, levels=levels(ukbb.1958.aggr$job.lvl3)[unclass(ukbb.1958.aggr$job.lvl3)])





g.ukbb.forest = ggplot(data = ukbb.1958.aggr, aes(x=job.lvl3, 
                                      y=g.IQ, ymin=ci.lower, ymax=ci.upper))+
  geom_pointrange() +
  #geom_point(aes(y=min, color='blue'))+
  #geom_point(aes(y=max, color='red'))+
  geom_hline(yintercept = 100, lty=2)+
  scale_y_continuous(breaks = c(40,50,60,70,80,90,100,110,120,130,140), limits=c(80,125))+
  coord_flip()+
  xlab('Job') + ylab('Mean (95% CI)')+
  theme_bw()+theme(legend.position = 'none')

g.ukbb.forest + My_Theme



### Ridgeline plot

idbb = ukbb$job.lvl3 %in%  names(table(ukbb$job.lvl3))[table(ukbb$job.lvl3) > 99]

ukbb.cut = ukbb[idbb,]

ukbb.cut$job.lvl3 = droplevels(ukbb.cut$job.lvl3)

ukbb.cut.aggr = summarySE(ukbb.cut, measurevar='g.IQ','job.lvl3', na.rm=TRUE)

ukbb.cut.aggr = ukbb.cut.aggr[order(ukbb.cut.aggr$g.IQ),]
ukbb.cut.aggr$job.lvl3 <- ordered(ukbb.cut.aggr$job.lvl3, levels=levels(ukbb.cut.aggr$job.lvl3)[unclass(ukbb.cut.aggr$job.lvl3)])


# ncds.jobs.cut$Job = factor(ncds.jobs.cut$job.lvl,
#                            levels=levels(ncds.jobs.aggr$job.lvl)
# )
# ncds.jobs.cut$Job = ordered(ncds.jobs.cut$Job)
# 
# ncds.jobs.cut = ncds.jobs.cut[ncds.jobs.cut$Job!='Not applicable',]


ukbb.cut$Job = factor(ukbb.cut$job.lvl3,
                           levels=levels(ukbb.cut.aggr$job.lvl3)
)
ukbb.cut$Job = ordered(ukbb.cut$Job)

ukbb.cut = ukbb.cut[ukbb.cut$Job!='Not applicable',]



ukbb.cut$pot = 'point'

g.ukbb.ridge = ggplot(data = ukbb.cut, aes(x=g.IQ, y=Job, fill=0.5 - abs(0.5-..ecdf..)))+
  stat_density_ridges(aes(point_fill=pot,#point_shape=Sex
                          ),
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
  xlab("Adult IQ")+
  theme_bw()+theme(legend.position = 'none')


g.ukbb.ridge+My_Theme




### UKBB PUBLICATION TABLES ###

## 1. All UKBB jobs (above 30)

View(ukbb.cut.aggr)

# idx = ukbb$job.lvl3 %in%  names(table(ukbb$job.lvl3))[table(ukbb$job.lvl3) > 99]
# ukbb.tab = ukbb[idx,]
# ukbb.tab = summarySE(ukbb.tab, measurevar='g.IQ','job.lvl3', na.rm=TRUE)



## 2. All NCDS jobs above cut-off (30) /w UKBB jobs to the right

View(ncds.jobs.aggr)
View(ukbb.1958.aggr)


###



### Scattergram comparing NCDS with UKBB


scat = ncds.jobs.aggr[,c('job.lvl','g')]  # make sure this is the right version
scat$job.lvl = as.character(scat$job.lvl)
scat$job.lvl[77] = "Secondary education teaching professionals" # Error here - extra space
scat = scat[order(scat$job.lvl),] # alphabetize

scat.ukbb = ukbb.1958.aggr[,c('job.lvl3','g.IQ')]
scat.ukbb$job.lvl3 = as.character(scat.ukbb$job.lvl3)
scat.ukbb = scat.ukbb[order(scat.ukbb$job.lvl3),] # alphabetize

scat = scat[scat$job.lvl %in% scat.ukbb$job.lvl3,]

## Two are in the wrong order. No idea why or how.
scat.ukbb = rbind(scat.ukbb, scat.ukbb[26,])
scat.ukbb[26,] = scat.ukbb[27,]
scat.ukbb[27,] = scat.ukbb[68,]

scat$job.lvl[26]
scat.ukbb$job.lvl3[26]
scat$job.lvl[27]
scat.ukbb$job.lvl3[27]
## Checks out.


scat = cbind(scat, scat.ukbb[1:67,])
cor(scat$g, scat$g.IQ)
par(mfrow=c(1,1))
plot(scat$g, scat$g.IQ)



### Helper functions

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


