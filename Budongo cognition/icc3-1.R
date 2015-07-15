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




setwd('C:/Users/s1229179/GitHub/R/Budongo cognition/')
pers <- read.csv('EDIpersonality.csv',header=TRUE)

p2010 <- pers[25:95,]

#gsub("^.*\\.",".",x)
#gsub("^.*? \\","",levels(p2010$Rater))
#     substring(x)
     
library(plyr)
levels(p2010$Rater) = revalue(levels(p2010$Rater), c("Betsy Herrelko"="betsy", "Jo Richardson"="jo",
                               "Martijn Menting"='martijn','Wouter Bruijn'='wouter',
                               'Sarah Gregory'='sarahG','Sarah Romer'='sarahR',
                               'Jon Klein Hofmeijer'='jon'
                               ))


awICC <- icc3.reliability(p2010[!is.na(p2010$Sex),], item.names = colnames(p2010)[16:69],
                 subject = 'chimpname',
                   #levels(p2010$chimpname),
                 judge = 'Rater'
                   #levels(p2010$Rater)
                 )

# Impulsive, Predictable, Clumsy
# from Weiss et al. 2009, Unemotional is not in the table, but fine


# item       icc31       icc3k n_obs n_sub n_rat k
# 1     Fear  0.52962716  0.77158099    66    22     6 3
# 2      Dom  0.82189065  0.93263083    66    22     6 3
# 3     Pers  0.24169304  0.48880000    66    22     6 3
# 4     Caut  0.21959459  0.45774648    66    22     6 3
# 5     Stbl  0.26976351  0.52567479    66    22     6 3
# 6      Aut  0.69880319  0.87437604    66    22     6 3
# 7  Curious  0.31288820  0.57736390    66    22     6 3
# 8    Thotl  0.12572254  0.30138568    66    22     6 3
# 9    Stngy  0.43996711  0.70209974    66    22     6 3
# 10   Jeals  0.23242188  0.47600000    66    22     6 3
# 11    Indv  0.03078818  0.08700696    66    22     6 3
# 12   Reckl  0.46353354  0.72161506    66    22     6 3
# 13     Soc  0.31956290  0.58487805    66    22     6 3
# 14    Dist  0.49970167  0.74977619    66    22     6 3
# 15     Tim  0.70847751  0.87938440    66    22     6 3
# 16    Symp  0.43897059  0.70125294    66    22     6 3
# 17    Play  0.47656250  0.73200000    66    22     6 3
# 18     Sol  0.76580278  0.90749064    66    22     6 3
# 19    Vuln  0.35013624  0.61778846    66    22     6 3
# 20   Innov  0.56648575  0.79675573    66    22     6 3
# 21    Actv  0.65975336  0.85331078    66    22     6 3
# 22    Help  0.18750000  0.40909091    66    22     6 3
# 23    Buly  0.65011962  0.84789392    66    22     6 3
# 24    Aggr  0.72563177  0.88807069    66    22     6 3
# 25    Manp  0.39221219  0.65939279    66    22     6 3
# 26    Gntl  0.62322555  0.83228015    66    22     6 3
# 27    Affc  0.19909794  0.42718894    66    22     6 3
# 28    Exct  0.33082845  0.59728657    66    22     6 3
# 29    Impl -0.05141287 -0.17191601    66    22     6 3
# 30    Inqs  0.45605023  0.71552239    66    22     6 3
# 31    Subm  0.77982797  0.91398374    66    22     6 3
# 32    Cool  0.38089102  0.64858934    66    22     6 3
# 33    Depd  0.49466127  0.74597446    66    22     6 3
# 34    Irri  0.21801839  0.45545852    66    22     6 3
# 35   Unper  0.37268128  0.64057971    66    22     6 3
# 36    Pred -0.01132404 -0.03475936    66    22     6 3
# 37    Decs  0.46969697  0.72656250    66    22     6 3
# 38    Depr  0.44157609  0.70346320    66    22     6 3
# 39    Conv  0.17005368  0.38068670    66    22     6 3
# 40    Sens  0.01745380  0.05059524    66    22     6 3
# 41    Defn  0.53317308  0.77408097    66    22     6 3
# 42   Intll  0.48893805  0.74161074    66    22     6 3
# 43    Prot  0.61926995  0.82992036    66    22     6 3
# 44    Quit  0.50448350  0.75334762    66    22     6 3
# 45    Invt  0.62603448  0.83394580    66    22     6 3
# 46    Clmy -0.01170960 -0.03597122    66    22     6 3
# 47    Errc  0.43783304  0.70028409    66    22     6 3
# 48    Frdy  0.06190852  0.16526316    66    22     6 3
# 49     Anx  0.63284221  0.83794840    66    22     6 3
# 50    Lazy  0.42779292  0.69162996    66    22     6 3
# 51    Dsor  0.31334459  0.57788162    66    22     6 3
# 52    Unem  0.49579016  0.74682927    66    22     6 3
# 53    Imit  0.46990085  0.72672508    66    22     6 3
# 54    Indp  0.51865672  0.76373626    66    22     6 3







library(psych)

#ICC(p2010,missing=TRUE)
