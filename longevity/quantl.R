
# looks like this isn't going to work
 


library(ctqr)

qT.1 = ctqr(Surv(age_pr, age, status) ~ 
              as.factor(sex) + as.factor(origin) +  
              Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ,
            p = c(1:19/20), #CDF = pch.tst,
            data = datX)
summary(qT.1)
plot(qT.1)



library(qrcm)

qT.1 = iqr(Surv(age_pr, age, status) ~ 
             as.factor(sex) + as.factor(origin) +  
             Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ,
           #formula.p = ~ I(log(1 - p)), # misspecified
           #formula.p = ~ slp(p,1) , # okay
           #formula.p = ~plf(p, knots = c(1:4/5)), # okay
           formula.p = 
           data = datX)
summary(qT.1)

test.fit(qT.1)


# p <- seq(0,1, 0.1)
# a2 <- plf(p, knots = c(0.2,0.7))
# plot(p, 3 + 1*a2[,1] - 1*a2[,2] + 2*a2[,3], type = "l") 




require(quantreg)

attr(y, 'type') <- 'right'


           
           
           
           
           )

qm.1 <- crq (y ~ 1 + as.factor(sex) + as.factor(datX$origin=='WILD') 
             + age_pr +
             Dom_CZ + E.r2.DoB + Con_CZ +
             Agr_CZ + Neu_CZ + O.r2.DoB,
             #taus = 0.5 #c(0,1),
             , method = 'Portnoy' #, grid='pivot'
             , data=datX) 

Qfit = summary(qm.1,  1:19/20)

plot(Qfit)


qm.2 <- crq (y ~ 1 + as.factor(sex) +# as.factor(datX$origin) +
              # age_pr +
               Dom_CZ + Ext_CZ + Con_CZ +
               Agr_CZ + Neu_CZ + Opn_CZ,
             #taus = 0.5 #c(0,1),
             , method = 'Portnoy' #, grid='pivot'
             , data=datX) 

Qfit = summary(qm.2,  1:39/40, se='boot')#, bsmethod='mcmb')

plot(Qfit)


# 3 is the main model

qm.3 <- crq (y ~ 1 + as.factor(sex) + as.factor(datX$origin) 
             + age_pr +
               as.factor(datX$sample=='Japan') + as.factor(datX$sample=='Yerkes')
             + as.factor(datX$sample=='Edinburgh') + as.factor(datX$origin=='WILD')
             +  Dom_CZ +  E.r2.DoB + Con_CZ +
               Agr_CZ + Neu_CZ + O.r1.DoB,
             taus = c(0,1),
             , method = 'Portnoy' #, grid='pivot'
             , data=datX) 

Qfit = summary(qm.3,  1:39/40)

plot(Qfit)


### messing with Powell - this probably isn't valid

yQ = Curv(datX$age_pr, rep(0,529), ctype='left')

qm.4 <- crq (yQ ~ 1 + as.factor(sex) + as.factor(datX$origin=='WILD') 
             #+ age_pr
              + Dom_CZ + E.r2.DoB + Con_CZ +
               Agr_CZ + Neu_CZ + O.r2.DoB,
             taus = seq(0.05,0.9,0.05), #c(0.1,0.2,0.3,0.4,0.5,0.6),
             , method = 'Powell' #, grid='pivot'
             , data=datX) 

summary(qm.4)
Qfit = summary(qm.4,  1:19/20)
 
plot(Qfit)



qm.5 <- crq (yQ ~ 1 + as.factor(sex) + as.factor(datX$origin)
             #+ age_pr 
             + as.factor(datX$sample=='Japan') + as.factor(datX$sample=='Yerkes')
             + as.factor(datX$sample=='Edinburgh') + 
             + Dom_CZ + E.r2.DoB + Con_CZ +
               Agr_CZ + Neu_CZ + O.r1.DoB,
             taus = seq(0.05,0.9,0.05), #c(0.1,0.2,0.3,0.4,0.5,0.6),
             , method = 'Powell' #, grid='pivot'
             , data=datX) 

#summary(qm.5)
Qfit = summary(qm.5,  1:19/20)

plot(Qfit)



qm.6 <- crq (yQ ~ 1 + as.factor(sex) #+ as.factor(datX$origin)
             + age_pr 
             # + as.factor(datX$sample=='Japan') + as.factor(datX$sample=='Yerkes')
             # + as.factor(datX$sample=='Edinburgh') + 
             + D.r2.DoB + C.r.DoB + A.r.DoB 
             + N.r1.DoB + O.r1.DoB + E.r2.DoB
             #, taus = c(0,1) #seq(0.10,0.90,0.10) #c(0.1,0.2,0.3,0.4,0.5,0.6)
             , method = 'Portnoy' #, grid='pivot'
             , data=datX) 


Qfit = summary(qm.6,  1:39/40)

plot(Qfit)



#############################
# 
# x <- sqrt(rnorm(100)^2)
# y <-  -0.5 + x +(.25 + .25*x)*rnorm(100)
# plot(x,y, type="n")
# s <- (y > 0)
# points(x[s],y[s],cex=.9,pch=16)
# points(x[!s],y[!s],cex=.9,pch=1)
# yLatent <- y
# y <- pmax(0,y)
# yc <- rep(0,100)
# for(tau in (1:4)/5){
#   f <- crq(Curv(y,yc) ~ x, tau = tau, method = "Pow")
#   xs <- sort(x)
#   lines(xs,pmax(0,cbind(1,xs)%*%f$coef),col="red")
#   abline(rq(y ~ x, tau = tau), col="blue")
#   abline(rq(yLatent ~ x, tau = tau), col="green")
# }
# legend(.15,2.5,c("Naive QR","Censored QR","Omniscient QR"),
#        lty=rep(1,3),col=c("blue","red","green"))
