### Data import script
#
# should be generalizable across files
# perhaps construct as function...


bracket12 <- read.csv('2012.csv')
bracket13 <- read.csv('2013.csv')
bracket14 <- read.csv('2014.csv')

kp14 <- read.csv('KP2014.csv')
kp13 <- read.csv('KP2013.csv')

library(Hmisc)

# strip some stuff out of the KP data

# kp14 <- kp14[grepl(' ',kp14$Team),]
# 
# c("USDZAR Curncy", "R157 Govt", "SPX Index")
kp14$Team = gsub("\\ [0-9]*$", "", kp14$Team)

order14 = bracket14$Team


# tabulate wins for teams
for (i in 1 : dim(bracket14)[1]) {
  ifelse(bracket14$Round.1.Results[i] == 'W', bracket14$wins[i] <- 1, bracket14$wins[i] <- 0)
}

bracket14$Team.1 <- factor(bracket14$Team.1, levels=levels(bracket14$Team))
bracket14$Team.2 <- factor(bracket14$Team.2, levels=levels(bracket14$Team))
bracket14$Team.3 <- factor(bracket14$Team.3, levels=levels(bracket14$Team))
bracket14$Team.4 <- factor(bracket14$Team.4, levels=levels(bracket14$Team))
bracket14$Team.5 <- factor(bracket14$Team.5, levels=levels(bracket14$Team))



for (j in 1 : dim(bracket14)[1]) {
  if (bracket14$Round.2.Results[j] == 'W'){
    inc(bracket14$wins[bracket14$Team.1[j]==bracket14$Team]) <- 1
  }
  if (bracket14$Round.3.Results[j] == 'W'){
    inc(bracket14$wins[bracket14$Team.2[j]==bracket14$Team]) <- 1
  }
  if (bracket14$Round.4.Results[j] == 'W'){
    inc(bracket14$wins[bracket14$Team.3[j]==bracket14$Team]) <- 1
  }
  if (bracket14$Round.5.Results[j] == 'W'){
    inc(bracket14$wins[bracket14$Team.4[j]==bracket14$Team]) <- 1
  }
  if (bracket14$Round.6.Results[j] == 'W'){
    inc(bracket14$wins[bracket14$Team.5[j]==bracket14$Team]) <- 1
  }
  
}

#inc(bracket14$wins[bracket14$Team.1[2]==bracket14$Team])

# sort both df's

kp14 <- kp14[with(kp14, order(kp14$Team)),]
bracket14 <- bracket14[with(bracket14, order(bracket14$Team)),]

mod1 <- lm(log(bracket14$wins + 1) ~ kp14$Rank + kp14$Pyth + kp14$AdjO #+ kp14$Conf 
           + kp14$X + kp14$AdjD + kp14$X.1 + kp14$AdjT + kp14$X.2 + kp14$Luck + kp14$X.3
           + kp14$SoS.Pyth + kp14$X.4 + kp14$OppO + kp14$X.5 + kp14$OppD + kp14$X.6
           + kp14$NCSoS.Pyth + kp14$X.7)

#mod1.st <- step(mod1)

#mod2.st <- step(mod2)


# 2013

kp13$Team = gsub("\\ [0-9]*$", "", kp13$Team)

order13 = bracket13$Team


# tabulate wins for teams
for (i in 1 : dim(bracket13)[1]) {
  ifelse(bracket13$Round.1.Results[i] == 'W', bracket13$wins[i] <- 1, bracket13$wins[i] <- 0)
}

bracket13$Team.1 <- factor(bracket13$Team.1, levels=levels(bracket13$Team))
bracket13$Team.2 <- factor(bracket13$Team.2, levels=levels(bracket13$Team))
bracket13$Team.3 <- factor(bracket13$Team.3, levels=levels(bracket13$Team))
bracket13$Team.4 <- factor(bracket13$Team.4, levels=levels(bracket13$Team))
bracket13$Team.5 <- factor(bracket13$Team.5, levels=levels(bracket13$Team))


for (j in 1 : dim(bracket13)[1]) {
  if (bracket13$Round.2.Results[j] == 'W'){
    inc(bracket13$wins[bracket13$Team.1[j]==bracket13$Team]) <- 1
  }
  if (bracket13$Round.3.Results[j] == 'W'){
    inc(bracket13$wins[bracket13$Team.2[j]==bracket13$Team]) <- 1
  }
  if (bracket13$Round.4.Results[j] == 'W'){
    inc(bracket13$wins[bracket13$Team.3[j]==bracket13$Team]) <- 1
  }
  if (bracket13$Round.5.Results[j] == 'W'){
    inc(bracket13$wins[bracket13$Team.4[j]==bracket13$Team]) <- 1
  }
  if (bracket13$Round.6.Results[j] == 'W'){
    inc(bracket13$wins[bracket13$Team.5[j]==bracket13$Team]) <- 1
  }
  
}

#inc(bracket13$wins[bracket13$Team.1[2]==bracket13$Team])

# sort both df's

kp13 <- kp13[with(kp13, order(kp13$Team)),]
bracket13 <- bracket13[with(bracket13, order(bracket13$Team)),]



# 2012

