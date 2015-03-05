### team vs. team match-up analysis approach
#


kp14 <- cbind.data.frame(kp14, result=bracket14$Round.1.Results)


# this needs to use the unreordered... order
# to preserve matchings

kp14 <- kp14[match(order14,kp14$Team),]

### now to compute differences

victDiffs14 <- NULL

for (i in seq(1,dim(kp14)[1],2)){
  if (kp14$result[i] == 'W'){
    kpdat = kp14[i,5:21]-kp14[i+1,5:21]
    vdrow = cbind.data.frame(winner=kp14$Team[i], loser=kp14$Team[i+1],kpdat)
  }
  else {
    kpdat = kp14[i+1,5:21]-kp14[i,5:21]
    vdrow = cbind.data.frame(winner=kp14$Team[i+1], loser=kp14$Team[i],kpdat)
  }
  
  victDiffs14 <- rbind.data.frame(victDiffs14, vdrow)
  
}


### some t-tests to see if any of these difference vars differ from null, and by how much

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

for (i in seq(1,dim(kp14)[1],2)){
  kpdat = kp14[i+1,5:21]-kp14[i,5:21]
  vdrow = cbind.data.frame(ref.team=kp14$Team[i+1], opponent=kp14$Team[i],kpdat,result=kp14$result[i+1])
    
  kpDiffs14 <- rbind.data.frame(kpDiffs14, vdrow)
  
}

gm.diff <- glm(result ~ Pyth + AdjO + AdjD + AdjT + SoS.Pyth + OppO + OppD + NCSoS.Pyth, data = kpDiffs14, family = "binomial")

gm.diff.sp <- step(gm.diff)

gm.diff2 <- glm(result ~ Pyth + AdjO + AdjD + SoS.Pyth + OppO, data = kpDiffs14, family = "binomial")




# 2013

kp13 <- cbind.data.frame(kp13, result=bracket13$Round.1.Results)


# this needs to use the unreordered... order
# to preserve matchings

kp13 <- kp13[match(order13,kp13$Team),]

### now to compute differences

victDiffs13 <- NULL

for (i in seq(1,dim(kp13)[1],2)){
  if (kp13$result[i] == 'W'){
    kpdat = kp13[i,5:21]-kp13[i+1,5:21]
    vdrow = cbind.data.frame(winner=kp13$Team[i], loser=kp13$Team[i+1],kpdat)
  }
  else {
    kpdat = kp13[i+1,5:21]-kp13[i,5:21]
    vdrow = cbind.data.frame(winner=kp13$Team[i+1], loser=kp13$Team[i],kpdat)
  }
  
  victDiffs13 <- rbind.data.frame(victDiffs13, vdrow)
  
}

kpDiffs13 <- NULL

for (i in seq(1,dim(kp13)[1],2)){
  kpdat = kp13[i+1,5:21]-kp13[i,5:21]
  vdrow = cbind.data.frame(ref.team=kp13$Team[i+1], opponent=kp13$Team[i],kpdat,result=kp13$result[i+1])
  
  kpDiffs13 <- rbind.data.frame(kpDiffs13, vdrow)
  
}

gm.diff13 <- glm(result ~ Pyth + AdjO + AdjD + AdjT + SoS.Pyth + OppO + OppD + NCSoS.Pyth, data = kpDiffs13, family = "binomial")

gm.diff13.sp <- step(gm.diff13)

#gm.diff2 <- glm(result ~ Pyth + AdjO + AdjD + SoS.Pyth + OppO, data = kpDiffs14, family = "binomial")



t.test(victDiffs13$Pyth) # p < 0.005
cohensD(victDiffs13$Pyth)
