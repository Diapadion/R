# segment for entering and sorting the 6 factor weighting matrix

# (dom, ext, con, agr, neur, open)
wmat <- rbind(cbind("FEARFUL",-1,0,0,0,0,0),cbind("SUBMISSIVE",-1,0,0,0,0,0),
              cbind("TIMID",-1,0,0,0,0,0),cbind("CAUTIOUS",-1,0,0,0,0,0),
              cbind("STABLE",0,0,0,0,-1,0),cbind("DISTRACTIBLE",0,0,-1,0,0,0),
              cbind("DISORGANIZED",0,0,-1,0,0,0),cbind("DEPENDENT/FOLLOWER",-1,0,0,0,0,0),
              cbind("VULNERABLE",-1,0,0,0,0,0),cbind("INQUISITIVE",0,0,0,0,0,1),
              cbind("THOUGHTLESS",0,0,-1,0,0,0),cbind("INNOVATIVE",0,0,0,0,0,1),
              cbind("INVENTIVE",0,0,0,0,0,1),cbind("CURIOUS",0,0,0,0,0,1),
              cbind("IMITATIVE",0,1,0,0,0,0),cbind("IMPULSIVE",0,0,-1,0,0,0),
              cbind("BULLYING",1,0,0,0,0,0),cbind("STINGY/GREEDY",1,0,0,0,0,0),
              cbind("AGRESSIVE",0,0,-1,0,0,0),cbind("IRRITABLE",0,0,-1,0,0,0),
              cbind("MANIPULATIVE",1,0,0,0,0,0),cbind("DEFIANT",0,0,-1,0,0,0),
              cbind("EXCITABLE",0,0,0,0,1,0),cbind("RECKLESS",0,0,-1,0,0,0),
              cbind("GENTLE",0,0,0,1,0,0),cbind("DOMINANT",1,0,0,0,0,0),
              cbind("INDEPENDENT",1,0,0,0,0,0),cbind("INDIVIDUALISTIC",0,-1,0,0,0,0),
              cbind("HELPFUL",0,0,0,1,0,0),cbind("FRIENDLY",0,1,0,0,0,0),
              cbind("AFFECTIONATE",0,1,0,0,0,0),cbind("SOCIABLE",0,1,0,0,0,0),
              cbind("SENSITIVE",0,0,0,1,0,0),cbind("DEPRESSED",0,-1,0,0,0,0),
              cbind("PROTECTIVE",0,0,0,1,0,0),cbind("SOLITARY",0,-1,0,0,0,0),
              cbind("SYMPATHETIC",0,0,0,1,0,0),cbind("INTELLIGENT",1,0,0,0,0,0),
              cbind("PERSISTENT",1,0,0,0,0,0),cbind("DECISIVE",1,0,0,0,0,0),
              cbind("CONVENTIONAL",0,0,0,1,0,0),cbind("PREDICTABLE",0,0,1,0,0,0),
              cbind("LAZY",0,-1,0,0,0,0),cbind("ACTIVE",0,1,0,0,0,0),
              cbind("CLUMSY",0,0,-1,0,0,0),cbind("PLAYFUL",0,1,0,0,0,0),
              cbind("COOL",0,0,0,0,-1,0),cbind("QUITTING",0,0,-1,0,0,0),
              cbind("ANXIOUS",-1,0,0,0,0,0),cbind("ERRATIC",0,0,-1,0,0,0),
              cbind("UNEMOTIONAL",0,0,0,0,0,0),cbind("JEALOUS",0,0,-1,0,0,0))

compare_data <- NULL

compare_data <- data.frame(chimp = pers$chimpname)
# 
# compare_data$dom <-
#   (pers$Dom - pers$Fear - pers$Subm - pers$Tim - pers$Caut - pers$Depd + pers$Indp - pers$Vuln + 
#      pers$Decs + pers$Intll + pers$Pers + pers$Buly + pers$Stngy + pers$Manp - pers$Anx 
#    + 7*8
#    ) / 15
# 
# compare_data$con <-
#   (pers$Pred - pers$Impl - pers$Defn - pers$Reckl - pers$Errc - pers$Irri - pers$Aggr - pers$Jeals
#    - pers$Dsor - pers$Thotl - pers$Dist - pers$Unper - pers$Quit - pers$Clmy
#    + 13*8
#   ) / 14
# #  (-dmdob$impl.z-dmdob$defn.z-dmdob$reckl.z-dmdob$errc.z-dmdob$irri.z+dmdob$pred.z-dmdob$aggr.z-dmdob$jeals.z-dmdob$dsor.z+64)/9
# 
# compare_data$opn <-
#   (pers$Inqs + pers$Invt + pers$Curious + pers$Innov
#   ) / 4
# #(dmdob$inqs.z+dmdob$invt.z)/2
# 
# compare_data$neu <-
#   (pers$Exct + pers$Aut - pers$Stbl - pers$Cool - pers$Unem
#    + 3*8
#   ) / 5
# #(-dmdob$stbl.z+dmdob$exct.z-dmdob$unem.z+16)/3
# 
# compare_data$agr <-
#   (pers$Symp + pers$Help + pers$Sens + pers$Prot + pers$Gntl + pers$Conv
#   ) / 6
# #(dmdob$symp.z+dmdob$help.z+dmdob$sens.z+dmdob$prot.z+dmdob$gntl.z)/5
# 
# compare_data$ext <-
#   (pers$Actv + pers$Play + pers$Soc + pers$Frdy + pers$Affc + pers$Imit 
#    - pers$Sol - pers$Lazy - pers$Indv - pers$Depr     
#    + 4*8
#      ) / 10
  
compare_data$raw_dom <- (pers$Dom+pers$Decs+pers$Pers+pers$Buly+pers$Stngy+
                           pers$Manp-pers$Subm-pers$Depd-pers$Fear-pers$Tim-
                           pers$Caut-pers$Anx+6*8)/12

compare_data$raw_ext <- (pers$Actv+pers$Play+pers$Soc+pers$Imit-pers$Sol-
                           pers$Lazy-pers$Indv+3*8)/7

compare_data$raw_con <- (9*8-pers$Impl-pers$Reckl-pers$Irri-pers$Aggr-
                           pers$Jeals-pers$Thotl-pers$Unper-pers$Quit-pers$Clmy)/9

compare_data$raw_agr <- (pers$Help+pers$Sens+pers$Prot+pers$Gntl+pers$Conv)/5

compare_data$raw_neu <- (pers$Exct+pers$Aut-pers$Cool+1*8)/3

compare_data$raw_opn <- (pers$Inqs+pers$Invt+pers$Curious)/3




# ddply(compare_data,~chimp,summarise,mean=
#           na.action = na.omit)

# remove data from 2005 sampling
compare_data = compare_data[25:99,]

aggPers <- aggregate(compare_data, by=list(compare_data$chimp), FUN=mean, na.rm=TRUE,na.action = na.omit)

# removing dead chimps :((((
rownames(aggPers) <- aggPers$Group.1
aggPers<-aggPers[c(-1,-2,-4,-17,-22),]
aggPers<-aggPers[,-2]

colnames(aggPers) <- c("Chimp",'Dominance','Extraversion','Conscientiousness',
                       'Agreeableness','Neuroticism','Openness')


### adding pers to trial by trial data
CIdata <- cbind.data.frame(CIdata,aggPers[1,])
EMdata <- cbind.data.frame(EMdata,aggPers[4,])
EDdata <- cbind.data.frame(EDdata,aggPers[3,])
EVdata <- cbind.data.frame(EVdata,aggPers[5,])
FKdata <- cbind.data.frame(FKdata,aggPers[6,])
KLdata <- cbind.data.frame(KLdata,aggPers[8,])
LOdata <- cbind.data.frame(LOdata,aggPers[12,])
LBdata <- cbind.data.frame(LBdata,aggPers[11,])
PAdata <- cbind.data.frame(PAdata,aggPers[14,])
Qdata <- cbind.data.frame(Qdata,aggPers[16,])
PEdata <- cbind.data.frame(PEdata,aggPers[15,])

cz_bin_pers <- rbind.data.frame(CIdata,EMdata,EDdata,EVdata,FKdata,KLdata,LOdata,LBdata,PAdata,Qdata,PEdata)
 
cz_bin_pers$Accuracy <- as.factor(cz_bin_pers$Accuracy)
cz_bin_pers$Trial <- as.integer(cz_bin_pers$Trial)


####### old code #######

wmat <- wmat[order(wmat[,1],decreasing=FALSE),]
wm <- apply(wmat[,2:7],1,as.numeric)

fullset = apply(pers,c(1,3),mean)



# autistic and unpredictable should both be removed from the data set
fullset = fullset[,c(-5,-53)]

# combine matrices to find components

scores1 <- wm %o% fullset
scores2 <- fullset %o% wm

scores=array(0,c(9,6))

for (i in 1:52){
  for (j in 1:6){
    scores[1:9,j] <- scores[1:9,j]+wm[j,i]*fullset[,i]
  }		
}





####
# stuff below is what I'd like to convert back over for macaques

# wmat <- rbind(cbind("FEARFUL",-1,0,0,0,0,0),cbind("SUBMISSIVE",-1,0,0,0,0,0),
#               cbind("TIMID",-1,0,0,0,0,0),cbind("CAUTIOUS",-1,0,0,0,0,0),
#               cbind("STABLE",0,0,0,0,-1,0),cbind("DISTRACTIBLE",0,0,-1,0,0,0),
#               cbind("DISORGANIZED",0,0,-1,0,0,0),cbind("DEPENDENT/FOLLOWER",-1,0,0,0,0,0),
#               cbind("VULNERABLE",-1,0,0,0,0,0),cbind("INQUISITIVE",0,0,0,0,0,1),
#               cbind("THOUGHTLESS",0,0,-1,0,0,0),cbind("INNOVATIVE",0,0,0,0,0,1),
#               cbind("INVENTIVE",0,0,0,0,0,1),cbind("CURIOUS",0,0,0,0,0,1),
#               cbind("IMITATIVE",0,1,0,0,0,0),cbind("IMPULSIVE",0,0,-1,0,0,0),
#               cbind("BULLYING",1,0,0,0,0,0),cbind("STINGY/GREEDY",1,0,0,0,0,0),
#               cbind("AGRESSIVE",0,0,-1,0,0,0),cbind("IRRITABLE",0,0,-1,0,0,0),
#               cbind("MANIPULATIVE",1,0,0,0,0,0),cbind("DEFIANT",0,0,-1,0,0,0),
#               cbind("EXCITABLE",0,0,0,0,1,0),cbind("RECKLESS",0,0,-1,0,0,0),
#               cbind("GENTLE",0,0,0,1,0,0),cbind("DOMINANT",1,0,0,0,0,0),
#               cbind("INDEPENDENT",1,0,0,0,0,0),cbind("INDIVIDUALISTIC",0,-1,0,0,0,0),
#               cbind("HELPFUL",0,0,0,1,0,0),cbind("FRIENDLY",0,1,0,0,0,0),
#               cbind("AFFECTIONATE",0,1,0,0,0,0),cbind("SOCIABLE",0,1,0,0,0,0),
#               cbind("SENSITIVE",0,0,0,1,0,0),cbind("DEPRESSED",0,-1,0,0,0,0),
#               cbind("PROTECTIVE",0,0,0,1,0,0),cbind("SOLITARY",0,-1,0,0,0,0),
#               cbind("SYMPATHETIC",0,0,0,1,0,0),cbind("INTELLIGENT",1,0,0,0,0,0),
#               cbind("PERSISTENT",1,0,0,0,0,0),cbind("DECISIVE",1,0,0,0,0,0),
#               cbind("CONVENTIONAL",0,0,0,1,0,0),cbind("PREDICTABLE",0,0,1,0,0,0),
#               cbind("LAZY",0,-1,0,0,0,0),cbind("ACTIVE",0,1,0,0,0,0),
#               cbind("CLUMSY",0,0,-1,0,0,0),cbind("PLAYFUL",0,1,0,0,0,0),
#               cbind("COOL",0,0,0,0,-1,0),cbind("QUITTING",0,0,-1,0,0,0),
#               cbind("ANXIOUS",-1,0,0,0,0,0),cbind("ERRATIC",0,0,-1,0,0,0),
#               cbind("UNEMOTIONAL",0,0,0,0,0,0),cbind("JEALOUS",0,0,-1,0,0,0))