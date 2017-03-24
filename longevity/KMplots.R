### Kaplan-Meier survfit curves

library(ggplot2)
library(tidyr)
library(survival)
library(grid)



plot1 <- ggsurv(survfit(y ~ 1)) + theme_bw() + theme(axis.title.y=element_blank(),
                                                     axis.title.x=element_blank())

cuto = 0.5

datX$Etert = 2
E.sd = sd(datX$Ext_CZ)
for (i in 1:dim(datX)[1]){
  if (datX$Ext_CZ[i] > (cuto * E.sd)){
    datX$Etert[i] = 3
  }
  if (datX$Ext_CZ[i] < (-cuto * E.sd)){
    datX$Etert[i] = 1
  }
}
sf.E = survfit(y ~ Etert, data=datX)
plot5 <- ggsurv(sf.E) + theme_bw() + theme(axis.title.y=element_blank(),
                                           axis.title.x=element_blank(),
                                           legend.position="none") +
  labs(title = 'Extraversion')


datX$Atert = 2
A.sd = sd(datX$Agr_CZ)
for (i in 1:dim(datX)[1]){
  if (datX$Agr_CZ[i] > (cuto * A.sd)){
    datX$Atert[i] = 3
  }
  if (datX$Agr_CZ[i] < (-cuto * A.sd)){
    datX$Atert[i] = 1
  }
}
sf.A = survfit(y ~ Atert, data=datX)
plot7 <- ggsurv(sf.A) + theme_bw() + theme(axis.title.y=element_blank(),
                                           axis.title.x=element_blank(),
                                           legend.position="none") +
  labs(title = 'Agreeableness')

datX$Dtert = 2
D.sd = sd(datX$Dom_CZ)
for (i in 1:dim(datX)[1]){
  if (datX$Dom_CZ[i] > (cuto * D.sd)){
    datX$Dtert[i] = 3
  }
  if (datX$Dom_CZ[i] < (-cuto * D.sd)){
    datX$Dtert[i] = 1
  }
}
sf.D = survfit(y ~ Dtert, data=datX)
plot4 <- ggsurv(sf.D) + theme_bw() + theme(axis.title.y=element_blank(),
                                           axis.title.x=element_blank()
                                           ,legend.position="none" 
                                           ) +
  labs(title = 'Dominance')

datX$Ntert = 2
N.sd = sd(datX$Neu_CZ)
for (i in 1:dim(datX)[1]){
  if (datX$Neu_CZ[i] > (cuto * N.sd)){
    datX$Ntert[i] = 3
  }
  if (datX$Neu_CZ[i] < (-cuto * N.sd)){
    datX$Ntert[i] = 1
  }
}
sf.N = survfit(y ~ Ntert, data=datX)
plot8 <- ggsurv(sf.N) + theme_bw() + theme(axis.title.y=element_blank(),
                                           axis.title.x=element_blank(),
                                           legend.position="none") +
  labs(title = 'Neuroticism')

datX$Ctert = 2
C.sd = sd(datX$Con_CZ)
for (i in 1:dim(datX)[1]){
  if (datX$Con_CZ[i] > (cuto * C.sd)){
    datX$Ctert[i] = 3
  }
  if (datX$Con_CZ[i] < (-cuto * C.sd)){
    datX$Ctert[i] = 1
  }
}
sf.C = survfit(y ~ Ctert, data=datX)
plot6 <- ggsurv(sf.C) + theme_bw() + theme(axis.title.y=element_blank(),
                                           axis.title.x=element_blank(),
                                           legend.position="none") +
  labs(title = 'Conscientiousness')

datX$Otert = 2
O.sd = sd(datX$Opn_CZ)
for (i in 1:dim(datX)[1]){
  if (datX$Opn_CZ[i] > (cuto * O.sd)){
    datX$Otert[i] = 3
  }
  if (datX$Opn_CZ[i] < (-cuto * O.sd)){
    datX$Otert[i] = 1
  }
}
sf.O = survfit(y ~ Otert, data=datX)
plot9 <- ggsurv(sf.O) + theme_bw() + theme(axis.title.y=element_blank(),
                                           axis.title.x=element_blank(),
                                           legend.position="none") +
  labs(title = "Openness")


### non personality
sf.Sex = survfit(y ~ sex, data=datX)
plot2 <- ggsurv(sf.Sex) + theme_bw() + theme(axis.title.y=element_blank(),
                                             axis.title.x=element_blank(),
                                             legend.position="none")

sf.Wild = survfit(y ~ origin, data=datX)
plot3 <- ggsurv(sf.Wild) + theme_bw() + theme(axis.title.y=element_blank(),
                                              axis.title.x=element_blank(),
                                              legend.position="none")

# facet_wrap(nrow = 2) # can't be done...?
# Not that way. This way:



### Paper figure ###

# return to later

# grid.newpage()
# pushViewport(viewport(layout = grid.layout(3, 3)))
# print(plot1, vp = vplayout(1, 1))
# print(plot2, vp = vplayout(1, 2))
# print(plot3, vp = vplayout(1, 3))
# print(plot4, vp = vplayout(2, 1))
# print(plot5, vp = vplayout(2, 2))
# print(plot6, vp = vplayout(2, 3))
# print(plot7, vp = vplayout(3, 1))
# print(plot8, vp = vplayout(3, 2))
# print(plot9, vp = vplayout(3, 3))



### Publication plot(s)!
library(rms)

npsf.1 = npsurv(y.wild ~ Sample, data=wch)

par(family = 'serif', cex.lab = 1.25, cex.axis = 1.1)
survplot(npsf.1, xlab = 'Age')


# 
# par(mfrow=c(1,1))
# 
# npsf.Wild = npsurv(y ~ origin + strata(strt), data=datX) # stratification doesn't really work
# survplot(npsf.Wild)
# 
# npsf.N = npsurv(y ~ Ntert, data=datX)
# survplot(npsf.N)
# 
# 
# 
# ##
# par(mfrow=c(3,3),
#     oma = c(5,4,0,0) + 0.3,
#     mar = c(0,0,1,1) + 0.5)
# 
# survplot(npsurv(y ~ 1))
# survplot(npsurv(y ~ datX$origin))
# 
# survplot(npsurv(y ~ datX$Etert ))
# 
# 
# 
# plot(survfit(y ~ age_pr, data=Dataset))
# 
# plot(survfit(yLt ~ Ext_CZ, data=datX))



### for Alex APS presentation ###

#1. just the basic curve

plot1 <- ggsurv(survfit(y ~ 1)) + theme_bw() #+ theme(axis.title.y=element_blank(),
#       axis.title.x=element_blank())
plot1


plot1a <- ggsurv(survfit(y.wild ~ Sample, data=wch), CI=T, xlab='Age') + theme_bw() 
plot1a



#2. sex and wild-born

survplot(npsurv(y ~ origin, data=datX), loglog=T)
survplot(npsurv(y ~ sex, data=datX), loglog=T)
survplot(npsurv(y ~ Etert, data=datX), loglog=T)


plot2 <- ggsurv(sf.Sex) + theme_bw() + theme(legend.position="none")
plot3 <- ggsurv(sf.Wild) + theme_bw() + theme(axis.title.y=element_blank(),legend.position="none")#,
# axis.title.x=element_blank())
grid.newpage()
pushViewport(viewport(layout = grid.layout(1, 2)))
print(plot2, vp = vplayout(1, 1))
print(plot3, vp = vplayout(1, 2))
# fix labels externally


#3. personality curves
grid.newpage()
pushViewport(viewport(layout = grid.layout(2, 3)))
print(plot4 + coord_cartesian(xlim = c(0, 65)), vp = vplayout(1, 1))
print(plot5 + coord_cartesian(xlim = c(0, 65)), vp = vplayout(1, 2))
print(plot6 + coord_cartesian(xlim = c(0, 65)), vp = vplayout(1, 3))
print(plot7 + coord_cartesian(xlim = c(0, 65)), vp = vplayout(2, 1))
print(plot8 + coord_cartesian(xlim = c(0, 65)), vp = vplayout(2, 2))
print(plot9 + coord_cartesian(xlim = c(0, 65)), vp = vplayout(2, 3))




####### Functions #######



vplayout <- function(x, y) viewport(layout.pos.row = x, layout.pos.col = y)



ggsurv <- function(s, CI = 'def', plot.cens = T, surv.col = 'gg.def',
                   cens.col = 'lightgrey', lty.est = 1, lty.ci = 2,
                   cens.shape = 5, back.white = F, xlab = 'Time',
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
      xlab(xlab) + ylab(ylab) + ggtitle(main)
    
    pl <- if(plot.cens == T & length(dat.cens) > 0){
      pl + geom_point(data = dat.cens, aes(y = surv), shape = cens.shape,
                      col = cens.col)
    } else if (plot.cens == T & length(dat.cens) == 0){
      stop ('There are no censored observations')
    } else(pl)
    
    pl <- pl + geom_step(col = col, lty = lty.est)
    
    pl <- if(CI == T | CI == 'def') {
      pl + geom_step(aes(y = up), color = col, lty = lty.ci) +
        geom_step(aes(y = low), color = col, lty = lty.ci)
    } else (pl)
    

    pl <- if(back.white == T) {pl + theme_bw()
    } else (pl)
    pl
  }
  
  ggsurv.m <- function(s, CI = 'def', plot.cens = T, surv.col = 'gg.def',
                       cens.col = 'lightgrey', lty.est = 1, lty.ci = 2,
                       cens.shape = 5, back.white = F, xlab = 'Time',
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
      xlab(xlab) + ylab(ylab) + ggtitle(main)
      
    
    # point section (moved)
    pl <- if(plot.cens == T & length(dat.cens) > 0){
      pl + geom_point(data = dat.cens, aes(y = surv), shape = cens.shape,
                      col = cens.col)
    } else if (plot.cens == T & length(dat.cens) == 0){
      stop ('There are no censored observations')
    } else(pl)
    
    
    pl <- pl + geom_step(aes(col = group, lty = group))
    
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