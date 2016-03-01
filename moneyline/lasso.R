### new LASSO technique

# run the other files first:
# 

load("C:/Users/s1229179/GitHub/R/moneyline/.RData")

# one day, the above will not be necessary


library(glmnet)

# 2014

netform14 <- droplevels(kpDiffs14)

netform14 = model.matrix(~ . - 1, data=netform14)


net.diff.14 <- glmnet(netform14[,c(64:83)], netform14[,84], family="binomial",
                      standardize=T, alpha = 1,lambda.min.ratio=0.00001,  nlambda=1000)
  
 
net.diff.14.cv <- cv.glmnet(netform14[,c(64:83)], netform14[,84], family="binomial") 
plot(net.diff.14.cv)

coef(net.diff.14, 
     s=net.diff.14.cv$lambda.min
     #s=net.diff.14.cv$lambda.1se
)




# 2013

netform13 <- droplevels(kpDiffs13)

netform13 = model.matrix(~ . - 1, data=netform13)


net.diff.13 <- glmnet(netform13[,c(64:81)], netform13[,82], family="binomial",
                      standardize=T, alpha = 1,lambda.min.ratio=0.00001,  nlambda=1000)


net.diff.13.cv <- cv.glmnet(netform13[,c(64:81)], netform13[,82], family="binomial") 
plot(net.diff.13.cv)

coef(net.diff.13, 
     s=net.diff.13.cv$lambda.min
     #s=net.diff.14.cv$lambda.1se
)



# 2012

netform12 <- droplevels(kpDiffs12)

netform12 = model.matrix(~ . - 1, data=netform12)


net.diff.12 <- glmnet(netform12[,c(64:81)], netform12[,82], family="binomial",
                      standardize=T, alpha = 1,lambda.min.ratio=0.00001,  nlambda=1000)


net.diff.12.cv <- cv.glmnet(netform12[,c(64:81)], netform12[,82], family="binomial") 
plot(net.diff.12.cv)

coef(net.diff.12, 
     s=net.diff.12.cv$lambda.min
     #s=net.diff.14.cv$lambda.1se
)



### This is the new shit

bracket11 <- read.csv('2011.csv')
bracket12 <- read.csv('2012.csv')
bracket13 <- read.csv('2013.csv')
bracket14 <- read.csv('2014.csv')


kp14 <- read.csv('KP2014.csv')
kp11 <- read.csv('KP2011.csv')
kp13 <- read.csv('KP2013.csv')
kp12 <- read.csv('KP2012.csv')

kp14$Team = gsub("\\ [0-9]*$", "", kp14$Team)
kp13$Team = gsub("\\ [0-9]*$", "", kp13$Team)
kp12$Team = gsub("\\ [0-9]*$", "", kp12$Team)
kp11$Team = gsub("\\ [0-9]*$", "", kp11$Team)


### need to add the winning columns all on top of each other

# this was is missing some final games... 
# I don't deem those important, if anything, we should cut out more later games

stack14 <- NULL
stack14 <- rbind(na.omit(bracket14[,4:5]),
                 setNames(na.omit(bracket14[,9:10]), names(bracket14[,4:5])),
                 setNames(na.omit(bracket14[,14:15]), names(bracket14[,4:5])),
                 setNames(na.omit(bracket14[,19:20]), names(bracket14[,4:5])),
                 setNames(na.omit(bracket14[,24:25]), names(bracket14[,4:5])))
stack14$year = 14   
stack14$rowID = 1:nrow(stack14)

stack14 <- merge(stack14, kp14, by="Team")
stack14 <- stack14[order(stack14$rowID), ]


stack13 <- NULL
stack13 <- rbind(na.omit(bracket13[,4:5]),
                 setNames(na.omit(bracket13[,9:10]), names(bracket13[,4:5])),
                 setNames(na.omit(bracket13[,14:15]), names(bracket13[,4:5])),
                 setNames(na.omit(bracket13[,19:20]), names(bracket13[,4:5])),
                 setNames(na.omit(bracket13[,24:25]), names(bracket13[,4:5])))
stack13$year = 13   
stack13$rowID = 1:nrow(stack13)

stack13 <- merge(stack13, kp13, by="Team")
stack13 <- stack13[order(stack13$rowID), ]


stack12 <- NULL
stack12 <- rbind(na.omit(bracket12[,4:5]),
                 setNames(na.omit(bracket12[,9:10]), names(bracket12[,4:5])),
                 setNames(na.omit(bracket12[,14:15]), names(bracket12[,4:5])),
                 setNames(na.omit(bracket12[,19:20]), names(bracket12[,4:5])),
                 setNames(na.omit(bracket12[,24:25]), names(bracket12[,4:5])))
stack12$year = 12   
stack12$rowID = 1:nrow(stack12)

stack12 <- merge(stack12, kp12, by="Team")
stack12 <- stack12[order(stack12$rowID), ]


stack11 <- NULL
stack11 <- rbind(na.omit(bracket11[,4:5]),
                 setNames(na.omit(bracket11[,9:10]), names(bracket11[,4:5])),
                 setNames(na.omit(bracket11[,14:15]), names(bracket11[,4:5])),
                 setNames(na.omit(bracket11[,19:20]), names(bracket11[,4:5])),
                 setNames(na.omit(bracket11[,24:25]), names(bracket11[,4:5])))
stack11$year = 11   
stack11$rowID = 1:nrow(stack11)

stack11 <- merge(stack11, kp11, by="Team")
stack11 <- stack11[order(stack11$rowID), ]


stacked <- rbind(stack14, stack13, stack12, stack11)

matchstack <- NULL
j = 1
for (i in seq(1,dim(stacked)[1],2)){
  matchstack = rbind(matchstack, cbind(stacked[i,c(1:4)],stacked[i,c(5:24)]-stacked[i+1,c(5:24)]))
  j = j + 1
  }
  
matchstack$wins <- ifelse(matchstack$Round.1.Results == 'W', matchstack$wins <- 1, matchstack$wins <- 0)



### okay it's model time

gm.stk <- glm(wins ~ 1 + SoS.Pyth + OppO + Rank + Pyth + AdjO +
                AdjD + AdjT + Luck + OppO + OppD + NCSoS.Pyth
                 , data = matchstack, family = binomial(logit))


library(lme4)
gmm.stk <- glmer(wins ~ 1 + SoS.Pyth + OppO + Rank + Pyth + AdjO +
                AdjD + AdjT + Luck + OppO + OppD + NCSoS.Pyth +
              ( 1 + SoS.Pyth + OppO + Rank + Pyth + AdjO +
                  AdjD + AdjT + Luck + OppO + OppD + NCSoS.Pyth | year)
              , data = matchstack, family = binomial(logit))
# convergence issues above



# LASSO prep

netf_stk <- droplevels(matchstack)

netf_stk = model.matrix(~ . - 1, data=netf_stk[,c(5,8:24)])


net.stk <- glmnet(netf_stk, matchstack$wins, family="binomial",
                      standardize=T, alpha = 1,lambda.min.ratio=0.00001,  nlambda=1000)


net.stk.cv <- cv.glmnet(netf_stk, matchstack$wins, family="binomial") 
plot(net.stk.cv)

coef(net.stk, 
     s=net.stk.cv$lambda.min
     #s=net.stk.cv$lambda.1se
)


gm2.stk <- glm(wins ~ 1 + OppO + AdjO +
                AdjD + Luck + OppD
               #+ SoS.Pyth # NahI don't think we need it
              , data = matchstack, family = binomial(logit))
# from this, AdjO and AdjD (plus Luck) seem to be the real power predictors

step(gm.stk)
step(gm2.stk)

gmm2.stk <- glmer(wins ~ 1 + OppO + AdjO + AdjD + Luck + OppD +
                               (1 + OppO + AdjO +
                                   AdjD + Luck + OppD | year)
                             , data = matchstack, family = binomial(logit))
