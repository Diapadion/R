# calculated per Shrout & Fleiss Psychol. Bul. 1979
icc31 <- function(BMS, EMS, k) {
  (BMS - EMS)/(BMS + (k - 1) * EMS)
}

icc3k <- function(BMS, EMS) {
  (BMS - EMS)/BMS
}

# Input a data.frame of individually judged, personality scores 
# with a list of quoted item column names for each monkey, including 
# monkey and rater name as columns
icc3.reliability <- function(.data, item.names, subject, judge) {
  
  icc.31s <- c();
  icc.3ks <- c();

  for(item in item.names) {

    anova.Factor <-
    anova(lm(as.formula(paste(item,(paste(paste("as.factor(",judge,")",sep=""),
                                          paste("as.factor(",subject,")",sep=""),
                                          sep="+")),sep="~")),data=.data))

    monkeys <- as.character(.data[,subject]);

    raters <- as.character(.data[,judge]);

    k <- mean(tapply(rep(1, length(monkeys)), monkeys, sum));

    n_subjects <- length(unique(monkeys))

    n_raters <- length(unique(raters))

    n_observations <- nrow(.data)
    
    BMS <- anova.Factor[2,3]
    EMS <- anova.Factor[3,3]

    icc.31s <- c(icc.31s, icc31(BMS, EMS, k=k));
    icc.3ks <- c(icc.3ks, icc3k(BMS, EMS));
  }
  
  return(data.frame(item=item.names, icc31=icc.31s, icc3k=icc.3ks, n_obs=n_observations, n_sub=n_subjects, n_rat=n_raters, k));
}

