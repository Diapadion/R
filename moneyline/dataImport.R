### Data import script
#
# should be generalizable across files
# perhaps construct as function...


bracket11 <- read.csv('2011.csv')
bracket12 <- read.csv('2012.csv')
bracket13 <- read.csv('2013.csv')
bracket14 <- read.csv('2014.csv')


kp14 <- read.csv('KP2014.csv')
kp11 <- read.csv('KP2011.csv')
kp13 <- read.csv('KP2013.csv')


library(Hmisc)
library(car)

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

mod14 <- lm(log(bracket14$wins + 1) ~ kp14$Rank + kp14$Pyth + kp14$AdjO #+ kp14$Conf 
           + kp14$X + kp14$AdjD + kp14$X.1 + kp14$AdjT + kp14$X.2 + kp14$Luck + kp14$X.3
           + kp14$SoS.Pyth + kp14$X.4 + kp14$OppO + kp14$X.5 + kp14$OppD + kp14$X.6
           + kp14$NCSoS.Pyth + kp14$X.7)


mod14.st <- step(mod14)



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

bracket12 <- read.csv('2012.csv')
kp12 <- read.csv('KP2012.csv')


kp12$Team = gsub("\\ [0-9]*$", "", kp12$Team)

order12 = bracket12$Team




# tabulate wins for teams
for (i in 1 : dim(bracket12)[1]) {
  ifelse(bracket12$Round.1.Results[i] == 'W', bracket12$wins[i] <- 1, bracket12$wins[i] <- 0)
}

bracket12$Team.1 <- factor(bracket12$Team.1, levels=levels(bracket12$Team))
bracket12$Team.2 <- factor(bracket12$Team.2, levels=levels(bracket12$Team))
bracket12$Team.3 <- factor(bracket12$Team.3, levels=levels(bracket12$Team))
bracket12$Team.4 <- factor(bracket12$Team.4, levels=levels(bracket12$Team))
bracket12$Team.5 <- factor(bracket12$Team.5, levels=levels(bracket12$Team))



for (j in 1 : dim(bracket12)[1]) {
  if (bracket12$Round.2.Results[j] == 'W'){
    inc(bracket12$wins[bracket12$Team.1[j]==bracket12$Team]) <- 1
  }
  if (bracket12$Round.3.Results[j] == 'W'){
    inc(bracket12$wins[bracket12$Team.2[j]==bracket12$Team]) <- 1
  }
  if (bracket12$Round.4.Results[j] == 'W'){
    inc(bracket12$wins[bracket12$Team.3[j]==bracket12$Team]) <- 1
  }
  if (bracket12$Round.5.Results[j] == 'W'){
    inc(bracket12$wins[bracket12$Team.4[j]==bracket12$Team]) <- 1
  }
  if (bracket12$Round.6.Results[j] == 'W'){
    inc(bracket12$wins[bracket12$Team.5[j]==bracket12$Team]) <- 1
  }
  
}

#inc(bracket12$wins[bracket12$Team.1[2]==bracket12$Team])

# sort both df's

kp12 <- kp12[with(kp12, order(kp12$Team)),]
bracket12 <- bracket12[with(bracket12, order(bracket12$Team)),]

mod12 <- lm(log(bracket12$wins + 1) ~ kp12$Rank + kp12$Pyth + kp12$AdjO #+ kp12$Conf 
           + kp12$X + kp12$AdjD + kp12$X.1 + kp12$AdjT + kp12$X.2 + kp12$Luck + kp12$X.3
           + kp12$SoS.Pyth + kp12$X.4 + kp12$OppO + kp12$X.5 + kp12$OppD + kp12$X.6
           + kp12$NCSoS.Pyth + kp12$X.7)

mod12.st <- step(mod12)


# 2011

bracket11 <- read.csv('2011.csv')
kp11 <- read.csv('KP2011.csv')

kp11$Team = gsub("\\ [0-9]*$", "", kp11$Team)




# tabulate wins for teams
for (i in 1 : dim(bracket11)[1]) {
  ifelse(bracket11$Round.1.Results[i] == 'W', bracket11$wins[i] <- 1, bracket11$wins[i] <- 0)
}

bracket11$Team.1 <- factor(bracket11$Team.1, levels=levels(bracket11$Team))
bracket11$Team.2 <- factor(bracket11$Team.2, levels=levels(bracket11$Team))
bracket11$Team.3 <- factor(bracket11$Team.3, levels=levels(bracket11$Team))
bracket11$Team.4 <- factor(bracket11$Team.4, levels=levels(bracket11$Team))
bracket11$Team.5 <- factor(bracket11$Team.5, levels=levels(bracket11$Team))



for (j in 1 : dim(bracket11)[1]) {
  if (bracket11$Round.2.Results[j] == 'W'){
    inc(bracket11$wins[bracket11$Team.1[j]==bracket11$Team]) <- 1
  }
  if (bracket11$Round.3.Results[j] == 'W'){
    inc(bracket11$wins[bracket11$Team.2[j]==bracket11$Team]) <- 1
  }
  if (bracket11$Round.4.Results[j] == 'W'){
    inc(bracket11$wins[bracket11$Team.3[j]==bracket11$Team]) <- 1
  }
  if (bracket11$Round.5.Results[j] == 'W'){
    inc(bracket11$wins[bracket11$Team.4[j]==bracket11$Team]) <- 1
  }
  if (bracket11$Round.6.Results[j] == 'W'){
    inc(bracket11$wins[bracket11$Team.5[j]==bracket11$Team]) <- 1
  }
  
}

#inc(bracket11$wins[bracket11$Team.1[2]==bracket11$Team])

# sort both df's

kp11 <- kp11[with(kp11, order(kp11$Team)),]
bracket11 <- bracket11[with(bracket11, order(bracket11$Team)),]


mod11 <- lm(log(bracket11$wins + 1) ~ kp11$Rank + kp11$Pyth + kp11$AdjO #+ kp11$Conf 
            + kp11$X + kp11$AdjD + kp11$X.1 + kp11$AdjT + kp11$X.2 + kp11$Luck + kp11$X.3
            + kp11$SoS.Pyth + kp11$X.4 + kp11$OppO + kp11$X.5 + kp11$OppD + kp11$X.6
            + kp11$NCSoS.Pyth + kp11$X.7)

mod11.st <- step(mod11)

#mod11a <- lm(log(bracket11$wins * 1) ~ kp11$Rank * kp11$Pyth * kp11$AdjO #* kp11$Conf 
#            * kp11$X * kp11$AdjD * kp11$X.1 * kp11$AdjT * kp11$X.2 * kp11$Luck * kp11$X.3
#            * kp11$SoS.Pyth * kp11$X.4 * kp11$OppO * kp11$X.5 * kp11$OppD * kp11$X.6
#            * kp11$NCSoS.Pyth * kp11$X.7)



### more stats sources to include

# Jeff Goodman, pundit
# Jerry Palm, pundit
# Joe Lunardi, pundit
# Jeff Borzello, pundit
# Jay Bilas, pundit

# Jeff Sagarin, stats
# Massey, stats
# ESPN BPI, stats
# Nate Silver, stats
# Sonny Moore, stats
# LRMC Rank, stats

# scoring margin
# AdjO
# AdjD

### also compare predictions we make to
# Nate Silver
# TeamRankings
#   most likely upsets
# Massey



## add Sagarin stats
sag14 <- read.csv('sag2014.csv') # this has an issue with third digits in later columns being misplaced

sag14 <- sag14[sag14$Team %in% bracket14$Team,] 
sag14 <- sag14[with(sag14, order(sag14$Team)),]




