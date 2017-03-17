require(ahaz)

#options(digits = 7)

# attr(yLt, 'type') <- 'counting'

set.seed(10101)

y.ahaz <- Surv(Dataset$age_pr#+runif(nrow(datX))*1e-7
               , Dataset$age#+runif(nrow(datX))*1e-7
               ,Dataset$status)

y.ahaz <- Surv(Dataset$age_pr#+runif(nrow(datX))*1e-7
               , Dataset$age+runif(nrow(datX))*1e-7
               ,Dataset$stat.log)

attr(y.ahaz, 'type') <- 'counting'



###



netform = data.frame(cbind(as.factor(datX$sex), 
                           as.factor(datX$origin), 
                           datX$Dom_CZ, datX$Ext_CZ, datX$Con_CZ,
                           datX$Agr_CZ, datX$Neu_CZ, datX$Opn_CZ))

colnames(netform) = c("sex",'origin',
                      'Dom','Ext','Con','Agr','Neu','Opn') 

rmatx1 = model.matrix( ~ sex + origin + 
                         Dom + Ext + Con + Agr + Neu + Opn - 1, netform)

ahz.1 <- ahazpen(y.ahaz, rmatx1, penalty=lasso.control(alpha=0.3))

plot(ahz.1, labels=TRUE)

tune.ahz = tune.ahazpen(y.ahaz, rmatx1, 
                        penalty = lasso.control(alpha=0.3),  #seq(0,1,0.01)
                        lambda = lseq(0.0005, 10, 1000),
                        tune = cv.control(nfolds=10, reps=10)
)
plot(tune.ahz)

coef(ahz.1, lambda = tune.ahz$lambda.min)

az.1 <- ahaz(y.ahaz, rmatx1)
summary(az.1)



netform = data.frame(cbind(as.factor(datX$sex), 
                           as.factor(datX$origin), 
                           datX$D.r2.DoB, datX$E.r2.DoB, datX$Con_CZ, 
                           datX$Agr_CZ, datX$N.r1.DoB, datX$O.r2.DoB))

colnames(netform) = c("sex",'origin',
                      'Dom','Ext','Con','Agr','Neu','Opn') 

rmatx1.r = model.matrix( ~ sex + origin + 
                           Dom + Ext + Con + Agr + Neu + Opn - 1, netform)

ahz.1.r <- ahazpen(y.ahaz, rmatx1.r, penalty=lasso.control(alpha=0.3))

plot(ahz.1.r, labels=TRUE)

tune.ahz.r = tune.ahazpen(y.ahaz, rmatx1.r, 
                          penalty = lasso.control(alpha=0.3),  #seq(0,1,0.01)
                          lambda = lseq(0.0005, 10, 1000),
                          tune = cv.control(nfolds=10, reps=10)
)
plot(tune.ahz.r)

coef(ahz.1.r, lambda = tune.ahz.r$lambda.min)


###
# no DOB included

netform = data.frame(cbind(as.factor(datX$sex),
                           as.factor(datX$sample=='Japan'),as.factor(datX$sample=='Yerkes'),
                           as.factor(datX$sample=='Edinburgh'),
                           as.factor(datX$origin), 
                           datX$Dom_CZ, datX$Ext_CZ, datX$Con_CZ,
                           datX$Agr_CZ, datX$Neu_CZ, datX$Opn_CZ))


colnames(netform) = c("sex","Japan",'Yerkes','Edinburgh','origin',
                      'Dom','Ext','Con','Agr','Neu','Opn') 

rmatx2 = model.matrix( ~ sex + Japan + Yerkes + Edinburgh + origin + Dom +
                        Ext + Con + Agr + Neu + Opn - 1, netform)

ahz.2 <- ahazpen(y.ahaz, rmatx2, penalty=lasso.control(alpha=0.3),
                 lambda = lseq(0.0005, 10, 1000))

plot(ahz.2, labels=TRUE)
# > palette()[1:6]
# [1:,7:] "black"   "red"     "green3"  "blue"    "cyan"    "magenta" 

# 1 - sex {risk}
# 2 - Japan {protect}
# 3 - Yerkes
# 11 - O
# 5 - origin
# 9 - A
# 10 - N
# ...

tune.ahz = tune.ahazpen(y.ahaz, rmatx2, 
                        penalty = lasso.control(alpha=0.3),  #seq(0,1,0.01)
                        lambda = lseq(0.0005, 10, 1000),
                        tune = cv.control(nfolds=10, reps=10)
)
plot(tune.ahz)

coef(ahz.2, lambda = tune.ahz$lambda.min)

az.2 <- ahaz(y.ahaz, rmatx2)


coef(ahz.2)[,100]

netform = data.frame(cbind(as.factor(datX$sex),
                           as.factor(datX$sample=='Japan'),as.factor(datX$sample=='Yerkes'),
                           as.factor(datX$sample=='Edinburgh'),
                           datX$Dom_CZ, datX$Ext_CZ, datX$Con_CZ,
                           datX$Agr_CZ, datX$Neu_CZ, datX$Opn_CZ))
colnames(netform) = c("sex","Japan",'Yerkes','Edinburgh',
                      'Dom','Ext','Con','Agr','Neu','Opn') 
rmatx2a = model.matrix( ~ sex + Japan + Yerkes + Edinburgh + Dom +
                         Ext + Con + Agr + Neu + Opn - 1, netform)


### 
# adjusted for linear and curvilinear time effects

netform = data.frame(cbind(as.factor(datX$sex),
                           as.factor(datX$sample=='Japan'),as.factor(datX$sample=='Yerkes'),
                           as.factor(datX$sample=='Edinburgh'),
                           as.factor(datX$origin), 
                           datX$Dom_CZ, datX$D.r3.DoB,
                           datX$Ext_CZ, datX$E.r3.DoB,
                           datX$Con_CZ, datX$Agr_CZ, 
                           datX$Neu_CZ, datX$N.r1.DoB,
                           datX$Opn_CZ, datX$O.r2.DoB
                           ))


colnames(netform) = c("sex","Japan",'Yerkes','Edinburgh','origin',
                      'Dom','D.r','Ext','E.r','Con','Agr',
                      'Neu','N.r','Opn','O.r') 

rmatx3 = model.matrix( ~ sex + Japan + Yerkes + Edinburgh + origin + 
                        Dom + Ext + Con + Agr + Neu + Opn + 
                        D.r + E.r + N.r + O.r - 1, netform)

ahz.3 <- ahazpen(y.ahaz, rmatx3)

plot(ahz.3, labels=TRUE)


# keeping all the residualized guys doesn't help
# step(s) back:
netform = data.frame(cbind(as.factor(datX$sex),
                           as.factor(datX$sample=='Japan'),as.factor(datX$sample=='Yerkes'),
                           as.factor(datX$sample=='Edinburgh'),
                           as.factor(datX$origin), 
                           datX$D.r3.DoB,
                           datX$E.r3.DoB,
                           datX$Con_CZ, datX$Agr_CZ, 
                           datX$N.r1.DoB,
                           datX$O.r2.DoB
))


colnames(netform) = c("sex","Japan",'Yerkes','Edinburgh','origin',
                      'D.r','E.r','Con','Agr',
                      'N.r','O.r') 

rmatx3a = model.matrix( ~ sex + Japan + Yerkes + Edinburgh + origin + 
                        Con + Agr + 
                        D.r + E.r + N.r + O.r - 1, netform)

ahz.3a <- ahazpen(y.ahaz, rmatx3a)

plot(ahz.3a, labels=TRUE)

coef(ahz.3a)

# Does reverting D and N do anything?
netform = data.frame(cbind(as.factor(datX$sex),
                           as.factor(datX$sample=='Japan'),as.factor(datX$sample=='Yerkes'),
                           as.factor(datX$sample=='Edinburgh'),
                           as.factor(datX$origin), 
                           datX$Dom_CZ,
                           datX$E.r3.DoB,
                           datX$Con_CZ, datX$Agr_CZ, 
                           datX$Neu_CZ,
                           datX$O.r2.DoB
))


colnames(netform) = c("sex","Japan",'Yerkes','Edinburgh','origin',
                      'Dom','E.r','Con','Agr',
                      'Neu','O.r') 

rmatx3b = model.matrix( ~ sex + Japan + Yerkes + Edinburgh + origin + 
                        Con + Agr + 
                        Dom + E.r + Neu + O.r - 1, netform)

ahz.3b <- ahazpen(y.ahaz, rmatx3b)

plot(ahz.3b, labels=TRUE)

# and removing the cubic for E?
netform = data.frame(cbind(as.factor(datX$sex),
                           as.factor(datX$sample=='Japan'),as.factor(datX$sample=='Yerkes'),
                           as.factor(datX$sample=='Edinburgh'),
                           as.factor(datX$origin), 
                           datX$Dom_CZ,
                           datX$E.r2.DoB,
                           datX$Con_CZ, datX$Agr_CZ, 
                           datX$Neu_CZ,
                           datX$O.r1.DoB
))


colnames(netform) = c("sex","Japan",'Yerkes','Edinburgh','origin',
                      'Dom','E.r','Con','Agr',
                      'Neu','O.r') 

rmatx3c = model.matrix( ~ sex + Japan + Yerkes + Edinburgh + origin + Dom  #6
                      + E.r + Neu + Agr + O.r + Con - 1, netform) #11

ahz.3c <- ahazpen(y.ahaz, rmatx3c, penalty = lasso.control(alpha=0.3),
                  lambda = lseq(0.0005, 10, 1000))
#ahz.3c <- ahazpen(y.ahaz, rmatx, penalty = sscad.control(a=30, nsteps=20, init.sol=NULL, c=NULL)) # I'm not sure what this does
# for sake of diversity, I'd like to use SCAD
# ahz.3c <- ahazpen(yLt, rmatx, penalty = sscad.control(a=30, nsteps=20, init.sol=NULL, c=NULL))


plot(ahz.3c, labels=TRUE)
# > palette()[1:6]
# [1:,7:] "black"   "red"     "green3"  "blue"    "cyan"    "magenta" 

coef(ahz.3c)[,100]



### something fucked up the models so what it says below appears to no longer be valid
# Without ORIGIN:
# Dom & Agr protect, Ext increases risk.

# With ORIGIN:
# Exactly the same. So leave ORIGIN in.


### "revised" version:

# Ordered by how quickly they diverge
# O, 10 - blue 
# origin, 5 - cyan
# A, 9 - green
# N, 8 - red
# D, 6 + pink
# C, 11 + cyan
# E, 7 + black
# edi, 4 - blue

# find it very difficult to believe this is correct

# but it is a Cox model... so signs are reversed, for one



### With the new stability selected and residualized vars

netform = data.frame(cbind(as.factor(datX$sex),
                           as.factor(datX$sample=='Japan'),as.factor(datX$sample=='Yerkes'),
                           as.factor(datX$sample=='Edinburgh'),
                           as.factor(datX$origin), 
                           datX$D.r2.DoB,
                           datX$E.r2.DoB,
                           datX$C.r.DoB, datX$A.r.DoB, 
                           datX$N.r1.DoB,
                           datX$O.r1.DoB
))


colnames(netform) = c("sex","Japan",'Yerkes','Edinburgh','origin',
                      'D','E','C','A','N','O') 

rmatx4 = model.matrix( ~ sex + Japan + Yerkes + Edinburgh + origin + D  #6
                      + E + N + A + O + C - 1, netform) #11

ahz.4 <- ahazpen(y.ahaz, rmatx4, penalty = lasso.control(alpha=0.3),
                   lambda = lseq(0.0005, 10, 1000))
                   #sscad.control(a=30, nsteps=30, init.sol=NULL, c=NULL)) #lasso.control(alpha=1))

plot(ahz.4, labels=T)

# O, 10 - blue
# origin, 5 - cyan
# A, 9 - green
# N, 8 - red
# C, 11 + cyan
# D, 6 + pink
# E, 7 + black
# edi, 4 - blue

netform = data.frame(cbind(as.factor(datX$sex),
                           as.factor(datX$sample=='Japan'),as.factor(datX$sample=='Yerkes'),
                           as.factor(datX$sample=='Edinburgh'),
                           as.factor(datX$origin), 
                           datX$D.cv.r,
                           datX$E.cv.r,
                           datX$C.cv.r, 
                           datX$A.cv.r, 
                           datX$N.cv.r,
                           datX$O.cv.r
))


colnames(netform) = c("sex","Japan",'Yerkes','Edinburgh','origin',
                      'D','E','C','A','N','O') 

rmatx5 = model.matrix( ~ sex + Japan + Yerkes + Edinburgh + origin + D  #6
                      + E + N + A + O + C - 1, netform) #11

ahz.5 <- ahazpen(y.ahaz, rmatx5, penalty = sscad.control(a=30, nsteps=30, init.sol=NULL, c=NULL)) #lasso.control(alpha=1))

plot(ahz.5, labels=T)


### without Origin
netform = data.frame(cbind(as.factor(datX$sex),
                           as.factor(datX$sample=='Japan'),as.factor(datX$sample=='Yerkes'),
                           as.factor(datX$sample=='Edinburgh'),
                           datX$D.cv.r,
                           datX$E.cv.r,
                           datX$C.cv.r, 
                           datX$A.cv.r, 
                           datX$N.cv.r,
                           datX$O.cv.r
))


colnames(netform) = c("sex","Japan",'Yerkes','Edinburgh',
                      'D','E','C','A','N','O') 

rmatx5a = model.matrix( ~ sex + Japan + Yerkes + Edinburgh + #4
                      D + E + N + A + O + C - 1, netform) #10

ahz.5a <- ahazpen(y.ahaz, rmatx5a, penalty = lasso.control(alpha=0.3),
                 lambda = lseq(0.0005, 10, 1000))

plot(ahz.5a, labels=T)

### without Sites
netform = data.frame(cbind(as.factor(datX$sex),
                           datX$D.cv.r,
                           datX$E.cv.r,
                           datX$C.cv.r, 
                           datX$A.cv.r, 
                           datX$N.cv.r,
                           datX$O.cv.r
))


colnames(netform) = c("sex",'D','E','C','A','N','O') 

rmatx5b = model.matrix( ~ sex + D + E + N + A + O + C - 1, netform)

ahz.5b <- ahazpen(y.ahaz, rmatx5b, penalty = lasso.control(alpha=0.3),
                  lambda = lseq(0.0005, 10, 1000))

plot(ahz.5b, labels=T)
# this does NOT help



####### Tuning #######

tune.ahz = tune.ahazpen(y.ahaz, rmatx, 
             penalty = lasso.control(alpha=0.3),  #seq(0,1,0.01)
             lambda = lseq(0.0005, 10, 1000),
             tune = cv.control(nfolds=10, reps=3)
)
plot(tune.ahz)
             
coef(ahz.5b, lambda = tune.ahz$lambda.min)



cv.df <- NULL
form = NULL
j = 10

for (i in 1:j){
  #break # for stopping this process when sourcing etc.
  tune.ahz = tune.ahazpen(y.ahaz, rmatx5a, 
                          penalty = lasso.control(alpha=i/j),  #seq(0,1,0.01)
                          lambda = lseq(0.0005, 10, 1000),
                          tune = cv.control(nfolds=5, reps=3)
  )
  ahz = ahazpen(y.ahaz, rmatx, penalty = lasso.control(alpha=i/j), 
                 lambda = lseq(0.0005, 10, 1000))
  plot(tune.ahz)
  
  form = summary(coef(ahz, lambda = tune.ahz$lambda.min))
  minLoc = match(tune.ahz$lambda.min, tune.ahz$lambda) 
  form = cbind(t(form$x), tune.ahz$lambda.min, tune.ahz$tunem[minLoc], tune.ahz$tunesd[minLoc], i/20)
  cv.df = rbind(cv.df, form)
  
}
View(cv.df)


             
####### Stability Selection #######

ahazstab(rmatx4, y.ahaz, reps = 100, weakness = 0.3, a = 1,
         lambda = lseq(0.0001, 0.01, 10))

# none of this seems to change the entry of these vars much
# it goes O, then D or A



# c("sex","Japan",'Yerkes','Edinburgh',
# CYAN: 'D','E','C','A',
# BLACK: 'N','O') 

#palette()[1:9]
#[1] "black"   "red"     "green3"  "blue"    "cyan"    "magenta" "yellow"  "gray"    NA  


ahazstab <- function(data, y, lambda = lseq(0.0005, 0.05, 1000), reps = 100, weakness = 0.5, a = 1){
  
  n = nrow(data)
  
  P = 0
  B = 0
  for (j in 1:reps){
    perm <- sample(1:n)
    halfA <- perm[1:(n / 2)]
    halfB <- perm[(n / 2 + 1):n]
    mA <- ahazpen(y[halfA,],data[halfA,], 
                  penalty = lasso.control(alpha=a),
                  penalty.wgt= 1/runif(n/2,weakness,1),
                  #lambda = lambda,
                  standardize=FALSE)
    mB <- ahazpen(y[halfB,],data[halfB,], 
                  penalty = lasso.control(alpha=a),
                  penalty.wgt= 1/runif(n/2,weakness,1),
                  lambda = mA$lambda,
                  standardize=FALSE)
    P <- P + ((coef(mA) != 0) + (coef(mB) != 0)) / 2
    B <- B + (coef(mA) + coef(mB))/2
    
  }
  P = P/reps
  B = B/reps
  
  par(mfrow = c(2,1), xpd=NA, mar = c(2,2,2,2))
  
  toplot <- apply(B,1,function(x){any(x != 0)})
  matplot(log(mA$lambda),t(B[toplot,]),type = "l",col = rainbow(ncol(data))
          ,lty = 1)
  legend("bottomleft", inset=.05, legend=colnames(data), pch=15, col=rainbow(ncol(data)))
  toplot <- apply(P,1,function(x){any(x != 0)})
  matplot(log(mA$lambda),t(P[toplot,]),type = "l",col = rainbow(ncol(data))
          ,lty = 1#, ylim= c(0.5,1)
          )
  
  
}



#legend("bottomright", inset=.05, legend=colnames(rmatx1), pch=15, col=rainbow())#, horiz=TRUE)

#lambda = lseq(0.0005, 0.05, 1000)


 
