### team vs. team match-up analysis approach
#


full14 <- cbind.data.frame(full14, result=bracket14$Round.1.Results)

### Adding Sagerin stats into the mix

full14 <- full14[with(full14, order(full14$Team)),]
full14 <- cbind(full14, sagRank=sag14$sagRank, sagRating=sag14$RATING)

 # this needs to use the unreordered... order
# to preserve matchings

full14 <- full14[match(order14,full14$Team),]
#full14 <- full14[match(order14,full14$Team),]

### now to compute differences

victDiffs14 <- NULL

dataOverV <- c(1,5:21,23:24)

for (i in seq(1,dim(full14)[1],2)){
  if (full14$result[i] == 'W'){
    kpdat = full14[i,dataOverV]-full14[i+1,dataOverV]
    vdrow = cbind.data.frame(winner=full14$Team[i], loser=full14$Team[i+1],kpdat)
  }
  else {
    kpdat = full14[i+1,dataOverV]-full14[i,dataOverV]
    vdrow = cbind.data.frame(winner=full14$Team[i+1], loser=full14$Team[i],kpdat)
  }
  
  victDiffs14 <- rbind.data.frame(victDiffs14, vdrow)
  
}


### some t-tests to see if any of these difference vars differ from null, and by how much

library(lsr)
# 
t.test(victDiffs14$Pyth) # p < 0.00005
cohensD(victDiffs14$Pyth) # 0.844

t.test(victDiffs14$AdjO) # p < 0.0002 
cohensD(victDiffs14$AdjO) # 0.772

t.test(victDiffs14$AdjD) # p < 0.01
cohensD(victDiffs14$AdjD) # 0.489

t.test(victDiffs14$AdjT) # p = 0.111    
#cohensD(victDiffs14$AdjT)

t.test(victDiffs14$Luck) # p = 0.9434 ... surprise fucking surprise

t.test(victDiffs14$SoS.Pyth) # p < 0.01
cohensD(victDiffs14$SoS.Pyth) # 0.506

t.test(victDiffs14$OppO) # p < 0.005
cohensD(victDiffs14$OppO)
    
t.test(victDiffs14$OppD) # p < 0.05
cohensD(victDiffs14$OppD)

t.test(victDiffs14$NCSoS.Pyth) # p = 0.9116


### now model pairwise victory with a glm
#     select the lower team, and subtract the first
#     will help pick out some upsets (?)


kpDiffs14 <- NULL

for (i in seq(1,dim(full14)[1],2)){
  kpdat = full14[i+1,dataOverV]-full14[i,dataOverV]
  vdrow = cbind.data.frame(ref.team=full14$Team[i+1], opponent=full14$Team[i],kpdat,result=full14$result[i+1])
    
  kpDiffs14 <- rbind.data.frame(kpDiffs14, vdrow)
  
}

gm.diff14 <- glm(result ~ SoS.Pyth + OppO
                 # + AdjO + AdjD 
                 # + Pyth + OppD
                 #+ AdjT + NCSoS.Pyth
                 + sagRating #+ sagRank               
                 + Rank
                 , data = kpDiffs14, family = "binomial")

gm.diff14.stp <- step(gm.diff14)

gm.diff14_2 <- glm(result ~ Pyth + AdjO + AdjD + SoS.Pyth + OppO, data = kpDiffs14, family = "binomial")

gm.diff14_3 <- glm(result ~ Rank, data=kpDiffs14, family = 'binomial')

gm.diff14_4 <- glm(result ~ Rank + sagRating, data=kpDiffs14, family = 'binomial')



# 2013

kp13 <- cbind.data.frame(kp13, result=bracket13$Round.1.Results)


# this needs to use the unreordered... order
# to preserve matchings

kp13 <- kp13[match(order13,kp13$Team),]

### now to compute differences

victDiffs13 <- NULL

for (i in seq(1,dim(kp13)[1],2)){
  if (kp13$result[i] == 'W'){
    kpdat = kp13[i,dataOverV]-kp13[i+1,dataOverV]
    vdrow = cbind.data.frame(winner=kp13$Team[i], loser=kp13$Team[i+1],kpdat)
  }
  else {
    kpdat = kp13[i+1,dataOverV]-kp13[i,dataOverV]
    vdrow = cbind.data.frame(winner=kp13$Team[i+1], loser=kp13$Team[i],kpdat)
  }
  
  victDiffs13 <- rbind.data.frame(victDiffs13, vdrow)
  
}

kpDiffs13 <- NULL

for (i in seq(1,dim(kp13)[1],2)){
  kpdat = kp13[i+1,dataOverV]-kp13[i,dataOverV]
  vdrow = cbind.data.frame(ref.team=kp13$Team[i+1], opponent=kp13$Team[i],kpdat,result=kp13$result[i+1])
  
  kpDiffs13 <- rbind.data.frame(kpDiffs13, vdrow)
  
}

gm.diff13 <- glm(result ~ Rank + Pyth + AdjO + AdjD + AdjT + SoS.Pyth + OppO + OppD + NCSoS.Pyth, data = kpDiffs13, family = "binomial")

gm.diff13.sp <- step(gm.diff13)

#gm.diff2 <- glm(result ~ Pyth + AdjO + AdjD + SoS.Pyth + OppO, data = kpDiffs14, family = "binomial")



t.test(victDiffs13$Pyth) # p < 0.005
cohensD(victDiffs13$Pyth)

# - OppO      1   22.749 30.749
# - AdjD      1   24.102 32.102
# - SoS.Pyth  1   25.273 33.273
# - AdjO      1   33.315 41.315
# 
# - Pyth      1   13.592 23.592
# - OppD      1   14.780 24.780
# - Rank      1   15.343 25.343
# - SoS.Pyth  1   16.254 26.254
# - OppO      1   16.404 26.404
# 
## notable predictors appear to be OppO, Rank, SoS.Pyth...

gm.diff13_z <- glm(result ~ SoS.Pyth + OppO
                   #  + Pyth + AdjO + AdjD + OppD
                   #+ AdjT + NCSoS.Pyth
                   + Rank
                   , data = kpDiffs13, family = "binomial")
gm.diff13_z.stp <- step(gm.diff13_z)


# 2012

kp12 <- cbind.data.frame(kp12, result=bracket12$Round.1.Results)


# this needs to use the unreordered... order
# to preserve matchings

kp12 <- kp12[match(order12,kp12$Team),]

### now to compute differences...

kpDiffs12 <- NULL

for (i in seq(1,dim(kp12)[1],2)){
  kpdat = kp12[i+1,dataOverV]-kp12[i,dataOverV]
  vdrow = cbind.data.frame(ref.team=kp12$Team[i+1], opponent=kp12$Team[i],kpdat,result=kp12$result[i+1])
  
  kpDiffs12 <- rbind.data.frame(kpDiffs12, vdrow)
  
}


gm.diff12 <- glm(result ~ 
                   #Rank + # won't bloody converge with rank
                 Pyth + AdjO + AdjD + AdjT + SoS.Pyth + OppO + OppD + NCSoS.Pyth, data = kpDiffs12, family = "binomial")

gm.diff12.stp = step(gm.diff12)

gm.diff12_z <- glm(result ~ Rank + OppO + SoS.Pyth, data = kpDiffs12, family = "binomial")

### Interactions testing

gmi.diff14 <- glm(result ~ Rank * SoS.Pyth * OppO, data = kpDiffs14, family = "binomial")
gmi.diff14.stp <- step(gmi.diff14)



