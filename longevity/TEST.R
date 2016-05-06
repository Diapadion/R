#### TESTING



  surv.col = 'gg.def'
  plot.cens = T
  cens.shape = 5
  cens.col = 'lightgrey'
  lty.est=1
  
  n <- sf.O$strata   # s$strata
  strata <- ifelse(is.null(strata) ==T, 1, length(strata))

  groups <- factor(unlist(strsplit(names
                                   (n), '='))[seq(2, 2*strata, by = 2)])
  gr.name <-  unlist(strsplit(names(n), '='))[1]
  gr.df <- vector('list', strata)
  ind <- vector('list', strata)
  n.ind <- c(0,n); n.ind <- cumsum(n.ind)
  for(i in 1:strata) ind[[i]] <- (n.ind[i]+1):n.ind[i+1]
  
  for(i in 1:strata){
    gr.df[[i]] <- data.frame(
      time = c(0, sf.O$time[ ind[[i]] ]),
      surv = c(1, sf.O$surv[ ind[[i]] ]),
      up = c(1, sf.O$upper[ ind[[i]] ]),
      low = c(1, sf.O$lower[ ind[[i]] ]),
      cens = c(0, sf.O$n.censor[ ind[[i]] ]),
      group = rep(groups[i], n[i] + 1))
  }
  
  dat <- do.call(rbind, gr.df)
  dat.cens <- subset(dat, cens != 0)
  
  main = 'test'
  
  pl <- ggplot(dat, aes(x = time, y = surv, group = group)) +
    #xlab(xlab) + ylab(ylab) + ggtitle(main) +
    geom_step(aes(col = group, lty = group))
  
  col <- if(length(surv.col == 1)){
    scale_colour_manual(name = gr.name, values = rep(surv.col, strata))
  } else{
    scale_colour_manual(name = gr.name, values = surv.col)
  }
  
  pl <- if(surv.col[1] != 'gg.def'){
    pl + col
  } else {pl + scale_colour_discrete(name = gr.name)}
  
  
  # point section (moved)
  pl <- if(plot.cens == T & length(dat.cens) > 0){
    pl + geom_point(data = dat.cens, aes(y = surv), shape = cens.shape,
                    col = cens.col)
  } else if (plot.cens == T & length(dat.cens) == 0){
    stop ('There are no censored observations')
  } else(pl)
  
  pl
  
  line <- if(length(lty.est) == 1){
    scale_linetype_manual(name = gr.name, values = rep(lty.est, strata))
  } else {scale_linetype_manual(name = gr.name, values = lty.est)}
  
  pl <- pl + line
  pl
  
  
  




ggsurv.m <- function(s, CI = 'def', plot.cens = T, surv.col = 'gg.def',
                     cens.col = 'lightgrey', lty.est = 1, lty.ci = 2,
                     cens.shape = 5, back.white = F, xlab = 'Time',
                     ylab = 'Survival', main = '') {
  strata <- ifelse(is.null(s$strata) ==T, 1, length(s$strata))
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
  
  
  # point section (moved)
  pl <- if(plot.cens == T & length(dat.cens) > 0){
    pl + geom_point(data = dat.cens, aes(y = surv), shape = cens.shape,
                    col = cens.col)
  } else if (plot.cens == T & length(dat.cens) == 0){
    stop ('There are no censored observations')
  } else(pl)
  
  pl
  
  line <- if(length(lty.est) == 1){
    scale_linetype_manual(name = gr.name, values = rep(lty.est, strata))
  } else {scale_linetype_manual(name = gr.name, values = lty.est)}
  
  pl <- pl + line
  pl
  
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


###

sf.O = survfit(y ~ Otert, data=datX)
plot9 <- ggsurv.m(sf.O) + theme_bw() + theme(axis.title.y=element_blank(),
                                             axis.title.x=element_blank(),
                                             legend.position="none") +
  labs(title = "Openness")

plot9

###

