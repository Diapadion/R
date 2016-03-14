require(ahaz)

attr(yLt, 'type') <- 'counting'

netform = data.frame(cbind(as.factor(datX$sex), as.numeric(datX$DoB), 
                           as.factor(datX$sample=='Japan'),as.factor(datX$sample=='Yerkes'),
                           as.factor(datX$sample=='Edinburgh'),
                           as.factor(datX$origin=='CAPTIVE'),
                          # as.factor(datX$origin), 
                           datX$Dom_CZ, datX$Ext_CZ, datX$Con_CZ,
                           datX$Agr_CZ, datX$Neu_CZ, datX$Opn_CZ))
  
  
colnames(netform) = c("sex","DoB","Japan",'Yerkes','Edinburgh','origin',
                      'Dom','Ext','Con','Agr','Neu','Opn') 

rmatx = model.matrix( ~ sex + DoB + Japan + Yerkes + Edinburgh + origin + 
                        Dom + Ext + Con + Agr + Neu + Opn - 1, netform)

ahz.1 <- ahazpen(yLt, rmatx)

plot(ahz.1, labels=TRUE)

coef(ahz.1)


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

rmatx = model.matrix( ~ sex + Japan + Yerkes + Edinburgh + origin + 
                        Dom + Ext + Con + Agr + Neu + Opn - 1, netform)

ahz.2 <- ahazpen(yLt, rmatx)

plot(ahz.2, labels=TRUE)

coef(ahz.2)


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

rmatx = model.matrix( ~ sex + Japan + Yerkes + Edinburgh + origin + 
                        Dom + Ext + Con + Agr + Neu + Opn + 
                        D.r + E.r + N.r + O.r - 1, netform)

ahz.3 <- ahazpen(yLt, rmatx)

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

rmatx = model.matrix( ~ sex + Japan + Yerkes + Edinburgh + origin + 
                        Con + Agr + 
                        D.r + E.r + N.r + O.r - 1, netform)

ahz.3a <- ahazpen(yLt, rmatx)

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
                           datX$Neu,
                           datX$O.r2.DoB
))


colnames(netform) = c("sex","Japan",'Yerkes','Edinburgh','origin',
                      'Dom','E.r','Con','Agr',
                      'Neu','O.r') 

rmatx = model.matrix( ~ sex + Japan + Yerkes + Edinburgh + origin + 
                        Con + Agr + 
                        Dom + E.r + Neu + O.r - 1, netform)

ahz.3b <- ahazpen(yLt, rmatx)

plot(ahz.3b, labels=TRUE)

# and removing the cubic for E?
netform = data.frame(cbind(as.factor(datX$sex),
                           as.factor(datX$sample=='Japan'),as.factor(datX$sample=='Yerkes'),
                           as.factor(datX$sample=='Edinburgh'),
                           as.factor(datX$origin), 
                           datX$Dom_CZ,
                           datX$E.r2.DoB,
                           datX$Con_CZ, datX$Agr_CZ, 
                           datX$Neu,
                           datX$O.r2.DoB
))


colnames(netform) = c("sex","Japan",'Yerkes','Edinburgh','origin',
                      'Dom','E.r','Con','Agr',
                      'Neu','O.r') 

rmatx = model.matrix( ~ sex + Japan + Yerkes + Edinburgh + origin + 
                        Con + Agr + 
                        Dom + E.r + Neu + O.r - 1, netform)

ahz.3c <- ahazpen(yLt, rmatx, penalty = lasso.control(alpha=0.7))
#ahx.3c <- ahazpen(yLt, rmatx, penalty = sscad.control(a=30, nsteps=4, init.sol=NULL, c=NULL)) # I'm not sure what this does

plot(ahz.3c, labels=TRUE)

coef(ahz.3c)[,100]

# Without ORIGIN:
# Dom & Agr protect, Ext increases risk.

# With ORIGIN:
# Exactly the same. So leave ORIGIN in.

