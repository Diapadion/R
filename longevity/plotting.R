# Plots

library(ggplot2)
library(tidyr)


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
  


### age * pers issues

pdx = gather(datX, Personality, Measurement, Dom:Opn)

p <- ggplot(pdx, aes(age_pr, Measurement, colour = factor(Personality))) + geom_point() + 
  theme_bw() + theme(legend.position="none") + labs(x='Age at Personality Rating')

p + facet_wrap(~ Personality, nrow = 2)


# LASSO adjusted
pdx = gather(datX, Personality, Measurement, N.cv.r:O.cv.r)

p <- ggplot(pdx, aes(age_pr, Measurement, colour = factor(Personality))) + geom_point() + 
  theme_bw() + theme(legend.position="none") + labs(x='Age at Personality Rating')

p + facet_wrap(~ Personality, nrow = 2)


### after correction

pdx = gather(datX, Personality, Measurement, c(96,99))

p <- ggplot(pdx, aes(age_pr, Measurement, colour = factor(Personality))) + geom_point() + 
  theme_bw() + theme(legend.position="none") + labs(x='Age at Personality Rating')

p + facet_grid(~ Personality)


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

corr.test(as.matrix(Dataset[,c(73:78)]),as.matrix(as.numeric(Dataset$DoB)), 
          method = "pearson", adjust='holm'
          , ci=TRUE)
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


# survfits

library(survival)
plot(survfit(y ~ age_pr, data=Dataset))

plot(survfit(yLt ~ Ext_CZ, data=datX))



# Wild vs. Captive 
plot(datX$DoB, datX$origin)
plot(datX$age_pr_adj, datX$origin)
plot(datX$age, datX$origin)





ggsurv <- function(s, CI = 'def', plot.cens = T, surv.col = 'gg.def',
                   cens.col = 'red', lty.est = 1, lty.ci = 2,
                   cens.shape = 3, back.white = F, xlab = 'Time',
                   ylab = 'Survival', main = ''){
  
  library(ggplot2)
  strata <- ifelse(is.null(s$strata) ==T, 1, length(s$strata))
  stopifnot(length(surv.col) == 1 | length(surv.col) == strata)
  stopifnot(length(lty.est) == 1 | length(lty.est) == strata)
  
  ggsurv.s <- function(s, CI = 'def', plot.cens = T, surv.col = 'gg.def',
                       cens.col = 'red', lty.est = 1, lty.ci = 2,
                       cens.shape = 3, back.white = F, xlab = 'Time',
                       ylab = 'Survival', main = ''){
    
    dat <- data.frame(time = c(0, s$time),
                      surv = c(1, s$surv),
                      up = c(1, s$upper),
                      low = c(1, s$lower),
                      cens = c(0, s$n.censor))
    dat.cens <- subset(dat, cens != 0)
    
    col <- ifelse(surv.col == 'gg.def', 'black', surv.col)
    
    pl <- ggplot(dat, aes(x = time, y = surv)) +
      xlab(xlab) + ylab(ylab) + ggtitle(main) +
      geom_step(col = col, lty = lty.est)
    
    pl <- if(CI == T | CI == 'def') {
      pl + geom_step(aes(y = up), color = col, lty = lty.ci) +
        geom_step(aes(y = low), color = col, lty = lty.ci)
    } else (pl)
    
    pl <- if(plot.cens == T & length(dat.cens) > 0){
      pl + geom_point(data = dat.cens, aes(y = surv), shape = cens.shape,
                      col = cens.col)
    } else if (plot.cens == T & length(dat.cens) == 0){
      stop ('There are no censored observations')
    } else(pl)
    
    pl <- if(back.white == T) {pl + theme_bw()
    } else (pl)
    pl
  }
  
  ggsurv.m <- function(s, CI = 'def', plot.cens = T, surv.col = 'gg.def',
                       cens.col = 'red', lty.est = 1, lty.ci = 2,
                       cens.shape = 3, back.white = F, xlab = 'Time',
                       ylab = 'Survival', main = '') {
    n <- s$strata
    
    groups <- factor(unlist(strsplit(names
                                     (s$strata), '='))[seq(2, 2*strata, by = 2)])
    gr.name <-  unlist(strsplit(names(s$strata), '='))[1]
    gr.df <- vector('list', strata)
    ind <- vector('list', strata)
    n.ind <- c(0,n); n.ind <- cumsum(n.ind)
    for(i in 1:strata) ind[[i]] <- (n.ind[i]+1):n.ind[i+1]
    
    for(i in 1:strata){
      gr.df[[i]] <- data.frame(
        time = c(0, s$time[ ind[[i]] ]),
        surv = c(1, s$surv[ ind[[i]] ]),
        up = c(1, s$upper[ ind[[i]] ]),
        low = c(1, s$lower[ ind[[i]] ]),
        cens = c(0, s$n.censor[ ind[[i]] ]),
        group = rep(groups[i], n[i] + 1))
    }
    
    dat <- do.call(rbind, gr.df)
    dat.cens <- subset(dat, cens != 0)
    
    pl <- ggplot(dat, aes(x = time, y = surv, group = group)) +
      xlab(xlab) + ylab(ylab) + ggtitle(main) +
      geom_step(aes(col = group, lty = group))
    
    col <- if(length(surv.col == 1)){
      scale_colour_manual(name = gr.name, values = rep(surv.col, strata))
    } else{
      scale_colour_manual(name = gr.name, values = surv.col)
    }
    
    pl <- if(surv.col[1] != 'gg.def'){
      pl + col
    } else {pl + scale_colour_discrete(name = gr.name)}
    
    line <- if(length(lty.est) == 1){
      scale_linetype_manual(name = gr.name, values = rep(lty.est, strata))
    } else {scale_linetype_manual(name = gr.name, values = lty.est)}
    
    pl <- pl + line
    
    pl <- if(CI == T) {
      if(length(surv.col) > 1 && length(lty.est) > 1){
        stop('Either surv.col or lty.est should be of length 1 in order
             to plot 95% CI with multiple strata')
      }else if((length(surv.col) > 1 | surv.col == 'gg.def')[1]){
        pl + geom_step(aes(y = up, color = group), lty = lty.ci) +
          geom_step(aes(y = low, color = group), lty = lty.ci)
      } else{pl +  geom_step(aes(y = up, lty = group), col = surv.col) +
          geom_step(aes(y = low,lty = group), col = surv.col)}
    } else {pl}
    
    
    pl <- if(plot.cens == T & length(dat.cens) > 0){
      pl + geom_point(data = dat.cens, aes(y = surv), shape = cens.shape,
                      col = cens.col)
    } else if (plot.cens == T & length(dat.cens) == 0){
      stop ('There are no censored observations')
    } else(pl)
    
    pl <- if(back.white == T) {pl + theme_bw()
    } else (pl)
    pl
  }
  pl <- if(strata == 1) {ggsurv.s(s, CI , plot.cens, surv.col ,
                                  cens.col, lty.est, lty.ci,
                                  cens.shape, back.white, xlab,
                                  ylab, main)
  } else {ggsurv.m(s, CI, plot.cens, surv.col ,
                   cens.col, lty.est, lty.ci,
                   cens.shape, back.white, xlab,
                   ylab, main)}
  pl
}
