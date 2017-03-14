### Specification Curve analyses

# from Simonsohn, Simmons, Nelson, 2015

library(broom)

### How can the specification vary?


# x2
# In/exclude Origin

# x2 [FOR EACH CURVE]
# with and without other personality covariates

# x4
# Residulaize data by DoB
# Use time-varying covars
# Stratifying by age group
# Leave confounded

# x3
# Distribution used
# t
# logistic
# extreme



# Model sytax
#
# [1-3] ___ : either AFT or COX
# [5] _ : unconfounding, either s(tratified), r(esidualized), t(ime varied), u(nadjusted)
# [7] _ : origin, i(including), x(cluding)
# [9] _ : distribution, t, l(ogistic), e(xtreme)
# [11] _ : personality covars, the usual abbrvs + 6 (all 6)
# [13] _ : sub-sample restriction, a(ll), c(PQ), h(PQ), (a)z(a), j(apan), y(erkes)

CPQ = datX$sample == 'Yerkes' | datX$sample == 'AZA'
HPQ = datX$sample == 'Japan' | datX$sample == 'Edinburgh'


# Independent pers dims in models?

attr(yLt, 'type') <- 'mcounting'

# All
AFT.s.i.l.6 <- frail.AFT.wild
AFT.s.i.t.6 <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +  
                         Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ
                       + frailty.gaussian(sample) + strata(datX$strt)
                       , data=datX, dist='t')
AFT.s.i.e.6 <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +  
                         Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ
                       + frailty.gaussian(sample) + strata(datX$strt)
                       , data=datX, dist='extreme')
AFT.s.x.l.6 <- frail.AFT
AFT.s.x.t.6 <- survreg(yLt ~ as.factor(sex) +  
                         Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ
                       + frailty.gaussian(sample) + strata(datX$strt)
                       , data=datX, dist='t')
AFT.s.x.e.6 <- survreg(yLt ~ as.factor(sex) +  
                         Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ
                       + frailty.gaussian(sample) + strata(datX$strt)
                       , data=datX, dist='extreme')

AFT.u.i.l.6 <- frail.AFT.unstrat
AFT.u.i.t.6 <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +  
                         Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ
                       + frailty.gaussian(sample)
                       , data=datX, dist='t')
AFT.u.i.e.6 <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +  
                         Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ
                       + frailty.gaussian(sample)
                       , data=datX, dist='extreme')
AFT.u.x.l.6 <- survreg(yLt ~ as.factor(sex) +  
                         Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ
                       + frailty.gaussian(sample)
                       , data=datX, dist='logistic')
AFT.u.x.t.6 <- survreg(yLt ~ as.factor(sex) +  
                         Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ
                       + frailty.gaussian(sample)
                       , data=datX, dist='t')
AFT.u.x.e.6 <- survreg(yLt ~ as.factor(sex) +  
                         Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ
                       + frailty.gaussian(sample)
                       , data=datX, dist='extreme') 

AFT.r.i.l.6 <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +  
                         D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB
                       + frailty.gaussian(sample)
                       , data=datX, dist='logistic')
AFT.r.i.t.6 <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +  
                         D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB
                       + frailty.gaussian(sample)
                       , data=datX, dist='t')
AFT.r.i.e.6 <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +  
                         D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB
                       + frailty.gaussian(sample)
                       , data=datX, dist='extreme')
AFT.r.x.l.6 <- survreg(yLt ~ as.factor(sex) +  
                         D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB
                       + frailty.gaussian(sample)
                       , data=datX, dist='logistic')
AFT.r.x.t.6 <- survreg(yLt ~ as.factor(sex) +  
                         D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB
                       + frailty.gaussian(sample)
                       , data=datX, dist='t')
AFT.r.x.e.6 <- survreg(yLt ~ as.factor(sex) +  
                         D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB
                       + frailty.gaussian(sample)
                       , data=datX, dist='extreme') 



# TODO 
# time dependent covariates?
# AFT.t.i.l.6 <- survreg(yLt ~ as.factor(sex) + as.factor(origin) + 
#                          
#                        + frailty.gaussian(sample)
#                        , data=datX, dist='logistic')
#                          )


# Sig table for regs with all vars
# 
#           D   E   C   A   N   O
#   
# 6 U i l       *       *
#       t       *       *
#       e       *       *       *
#     x l   *   *       *
#       t   *   *       *
#       e       *       *       *
#   S i l   *   *       *
#       t   *   *       *
#       e   *   *       *   *
#     x l   *   *       *
#       t   *   *       *
#       e   *   *       *   *
#   R i l       *       *
#       t       *       *
#       e       *       *
#     x l       *       *
#       t       *       *
#       e       *       *
#   
# 1 U i l       *               *           
#       t       *               *           
#       e       *       *              
#     x l       *       *       *      
#       t       *       *       *      
#       e       *       *              
#   S i l       *               *      
#       t       *               *      
#       e       *               *         
#     x l       *      
#       t       *      
#       e                
#   R i l       *   X   X   
#       t       *   X   X   
#       e           X   X   
#     x l           X   X
#       t           X   X
#       e           X   X  
#               
#           8  31   0  22   2   9
#           
#           36        30
#
#         .22 .86     .61 .06 .25


dtxc = datX[CPQ,]
yltc = yLt[CPQ,]
# All predictors, with subsamples
AFT.s.i.l.6.y <- survreg(yltc ~ as.factor(sex) + as.factor(origin) +  
                           Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ
                         + frailty.gaussian(sample) + strata(strt)
                         , data=dtxc, dist='logistic')
AFT.s.i.t.6.y <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +  
                         Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ
                       + frailty.gaussian(sample) + strata(datX$strt)
                       , data=datX[datX$sample=='Yerkes',], dist='t')
AFT.s.i.e.6.y <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +  
                         Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ
                       + frailty.gaussian(sample) + strata(datX$strt)
                       , data=datX[datX$sample=='Yerkes',], dist='extreme')
AFT.s.x.l.6.y <- survreg(yLt ~ as.factor(sex) +  
                         Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ
                       + frailty.gaussian(sample) + strata(datX$strt)
                       , data=datX[datX$sample=='Yerkes',], dist='logistic')
AFT.s.x.t.6.y <- survreg(yLt ~ as.factor(sex) +  
                         Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ
                       + frailty.gaussian(sample) + strata(datX$strt)
                       , data=datX[datX$sample=='Yerkes',], dist='t')
AFT.s.x.e.6.y <- survreg(yLt ~ as.factor(sex) +  
                         Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ
                       + frailty.gaussian(sample) + strata(datX$strt)
                       , data=datX[datX$sample=='Yerkes',], dist='extreme')

AFT.u.i.l.6.y <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +  
                         Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ
                       + frailty.gaussian(sample)
                       , data=datX[datX$sample=='Yerkes',], dist='logistic')
AFT.u.i.t.6.y <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +  
                         Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ
                       + frailty.gaussian(sample)
                       , data=datX[datX$sample=='Yerkes',], dist='t')
AFT.u.i.e.6.y <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +  
                         Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ
                       + frailty.gaussian(sample)
                       , data=datX[datX$sample=='Yerkes',], dist='extreme')
AFT.u.x.l.6.y <- survreg(yLt ~ as.factor(sex) +  
                         Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ
                       + frailty.gaussian(sample)
                       , data=datX[datX$sample=='Yerkes',], dist='logistic')
AFT.u.x.t.6.y <- survreg(yLt ~ as.factor(sex) +  
                         Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ
                       + frailty.gaussian(sample)
                       , data=datX[datX$sample=='Yerkes',], dist='t')
AFT.u.x.e.6.y <- survreg(yLt ~ as.factor(sex) +  
                         Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ
                       + frailty.gaussian(sample)
                       , data=datX[datX$sample=='Yerkes',], dist='extreme') 

AFT.r.i.l.6.y <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +  
                         D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB
                       + frailty.gaussian(sample)
                       , data=datX[datX$sample=='Yerkes',], dist='logistic')
AFT.r.i.t.6.y <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +  
                         D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB
                       + frailty.gaussian(sample)
                       , data=datX[datX$sample=='Yerkes',], dist='t')
AFT.r.i.e.6.y <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +  
                         D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB
                       + frailty.gaussian(sample)
                       , data=datX[datX$sample=='Yerkes',], dist='extreme')
AFT.r.x.l.6.y <- survreg(yLt ~ as.factor(sex) +  
                         D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB
                       + frailty.gaussian(sample)
                       , data=datX[datX$sample=='Yerkes',], dist='logistic')
AFT.r.x.t.6.y <- survreg(yLt ~ as.factor(sex) +  
                         D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB
                       + frailty.gaussian(sample)
                       , data=datX[datX$sample=='Yerkes',], dist='t')
AFT.r.x.e.6.y <- survreg(yLt ~ as.factor(sex) +  
                         D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB
                       + frailty.gaussian(sample)
                       , data=datX[datX$sample=='Yerkes',], dist='extreme') 




## Dominance
AFT.u.i.l.d <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +
                        Dom_CZ
                       + frailty.gaussian(sample)
                      , data=datX, dist='logistic')
AFT.u.i.t.d <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +
                         Dom_CZ
                       + frailty.gaussian(sample)
                       , data=datX, dist='t')
AFT.u.i.e.d <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +
                         Dom_CZ
                       + frailty.gaussian(sample)
                       , data=datX, dist='extreme')
AFT.u.x.l.d <- survreg(yLt ~ as.factor(sex) +
                         Dom_CZ
                       + frailty.gaussian(sample)
                       , data=datX, dist='logistic')
AFT.u.x.t.d <- survreg(yLt ~ as.factor(sex) + 
                         Dom_CZ
                       + frailty.gaussian(sample)
                       , data=datX, dist='t')
AFT.u.x.e.d <- survreg(yLt ~ as.factor(sex) +
                         Dom_CZ
                       + frailty.gaussian(sample)
                       , data=datX, dist='extreme')

AFT.s.i.l.d <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +
                         Dom_CZ
                       + strata(strt)
                       + frailty.gaussian(sample)
                       , data=datX, dist='logistic')
AFT.s.i.t.d <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +
                         Dom_CZ
                       + strata(strt)
                       + frailty.gaussian(sample)
                       , data=datX, dist='t')
AFT.s.i.e.d <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +
                         Dom_CZ
                       + strata(strt)
                       + frailty.gaussian(sample)
                       , data=datX, dist='extreme')
AFT.s.x.l.d <- survreg(yLt ~ as.factor(sex) +
                         Dom_CZ
                       + strata(strt)
                       + frailty.gaussian(sample)
                       , data=datX, dist='logistic')
AFT.s.x.t.d <- survreg(yLt ~ as.factor(sex) + 
                         Dom_CZ
                       + strata(strt)
                       + frailty.gaussian(sample)
                       , data=datX, dist='t')
AFT.s.x.e.d <- survreg(yLt ~ as.factor(sex) +
                         Dom_CZ
                       + strata(strt)
                       + frailty.gaussian(sample)
                       , data=datX, dist='extreme')

AFT.r.i.l.d <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +
                         D.r2.DoB
                       + frailty.gaussian(sample)
                       , data=datX, dist='logistic')
AFT.r.i.t.d <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +
                         D.r2.DoB
                       + frailty.gaussian(sample)
                       , data=datX, dist='t')
AFT.r.i.e.d <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +
                         D.r2.DoB
                       + frailty.gaussian(sample)
                       , data=datX, dist='extreme')
AFT.r.x.l.d <- survreg(yLt ~ as.factor(sex) +
                         D.r2.DoB
                       + frailty.gaussian(sample)
                       , data=datX, dist='logistic')
AFT.r.x.t.d <- survreg(yLt ~ as.factor(sex) + 
                         D.r2.DoB
                       + frailty.gaussian(sample)
                       , data=datX, dist='t')
AFT.r.x.e.d <- survreg(yLt ~ as.factor(sex) +
                         D.r2.DoB
                       + frailty.gaussian(sample)
                       , data=datX, dist='extreme')
                    

## Extraversion
AFT.u.i.l.e <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +
                         Ext_CZ
                       + frailty.gaussian(sample)
                       , data=datX, dist='logistic')
AFT.u.i.t.e <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +
                         Ext_CZ
                       + frailty.gaussian(sample)
                       , data=datX, dist='t')
AFT.u.i.e.e <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +
                         Ext_CZ
                       + frailty.gaussian(sample)
                       , data=datX, dist='extreme')
AFT.u.x.l.e <- survreg(yLt ~ as.factor(sex) +
                         Ext_CZ
                       + frailty.gaussian(sample)
                       , data=datX, dist='logistic')
AFT.u.x.t.e <- survreg(yLt ~ as.factor(sex) + 
                         Ext_CZ
                       + frailty.gaussian(sample)
                       , data=datX, dist='t')
AFT.u.x.e.e <- survreg(yLt ~ as.factor(sex) +
                         Ext_CZ
                       + frailty.gaussian(sample)
                       , data=datX, dist='extreme')

AFT.s.i.l.e <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +
                         Ext_CZ
                       + strata(strt)
                       + frailty.gaussian(sample)
                       , data=datX, dist='logistic')
AFT.s.i.t.e <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +
                         Ext_CZ
                       + strata(strt)
                       + frailty.gaussian(sample)
                       , data=datX, dist='t')
AFT.s.i.e.e <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +
                         Ext_CZ
                       + strata(strt)
                       + frailty.gaussian(sample)
                       , data=datX, dist='extreme')
AFT.s.x.l.e <- survreg(yLt ~ as.factor(sex) +
                         Ext_CZ
                       + strata(strt)
                       + frailty.gaussian(sample)
                       , data=datX, dist='logistic')
AFT.s.x.t.e <- survreg(yLt ~ as.factor(sex) + 
                         Ext_CZ
                       + strata(strt)
                       + frailty.gaussian(sample)
                       , data=datX, dist='t')
AFT.s.x.e.e <- survreg(yLt ~ as.factor(sex) +
                         Ext_CZ
                       + strata(strt)
                       + frailty.gaussian(sample)
                       , data=datX, dist='extreme')

AFT.r.i.l.e <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +
                         E.r2.DoB
                       + frailty.gaussian(sample)
                       , data=datX, dist='logistic')
AFT.r.i.t.e <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +
                         E.r2.DoB
                       + frailty.gaussian(sample)
                       , data=datX, dist='t')
AFT.r.i.e.e <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +
                         E.r2.DoB
                       + frailty.gaussian(sample)
                       , data=datX, dist='extreme')
AFT.r.x.l.e <- survreg(yLt ~ as.factor(sex) +
                         E.r2.DoB
                       + frailty.gaussian(sample)
                       , data=datX, dist='logistic')
AFT.r.x.t.e <- survreg(yLt ~ as.factor(sex) + 
                         E.r2.DoB
                       + frailty.gaussian(sample)
                       , data=datX, dist='t')
AFT.r.x.e.e <- survreg(yLt ~ as.factor(sex) +
                         E.r2.DoB
                       + frailty.gaussian(sample)
                       , data=datX, dist='extreme')
                      
                   

## Agreeableness
AFT.u.i.l.a <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +
                         Agr_CZ
                       + frailty.gaussian(sample)
                       , data=datX, dist='logistic')
AFT.u.i.t.a <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +
                         Agr_CZ
                       + frailty.gaussian(sample)
                       , data=datX, dist='t')
AFT.u.i.e.a <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +
                         Agr_CZ
                       + frailty.gaussian(sample)
                       , data=datX, dist='extreme')
AFT.u.x.l.a <- survreg(yLt ~ as.factor(sex) +
                         Agr_CZ
                       + frailty.gaussian(sample)
                       , data=datX, dist='logistic')
AFT.u.x.t.a <- survreg(yLt ~ as.factor(sex) + 
                         Agr_CZ
                       + frailty.gaussian(sample)
                       , data=datX, dist='t')
AFT.u.x.e.a <- survreg(yLt ~ as.factor(sex) +
                         Agr_CZ
                       + frailty.gaussian(sample)
                       , data=datX, dist='extreme')

AFT.s.i.l.a <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +
                         Agr_CZ
                       + strata(strt)
                       + frailty.gaussian(sample)
                       , data=datX, dist='logistic')
AFT.s.i.t.a <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +
                         Agr_CZ
                       + strata(strt)
                       + frailty.gaussian(sample)
                       , data=datX, dist='t')
AFT.s.i.e.a <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +
                         Agr_CZ
                       + strata(strt)
                       + frailty.gaussian(sample)
                       , data=datX, dist='extreme')
AFT.s.x.l.a <- survreg(yLt ~ as.factor(sex) +
                         Agr_CZ
                       + strata(strt)
                       + frailty.gaussian(sample)
                       , data=datX, dist='logistic')
AFT.s.x.t.a <- survreg(yLt ~ as.factor(sex) + 
                         Agr_CZ
                       + strata(strt)
                       + frailty.gaussian(sample)
                       , data=datX, dist='t')
AFT.s.x.e.a <- survreg(yLt ~ as.factor(sex) +
                         Agr_CZ
                       + strata(strt)
                       + frailty.gaussian(sample)
                       , data=datX, dist='extreme')


## Neuroticism
AFT.u.i.l.n <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +
                         Neu_CZ
                       + frailty.gaussian(sample)
                       , data=datX, dist='logistic')
AFT.u.i.t.n <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +
                         Neu_CZ
                       + frailty.gaussian(sample)
                       , data=datX, dist='t')
AFT.u.i.e.n <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +
                         Neu_CZ
                       + frailty.gaussian(sample)
                       , data=datX, dist='extreme')
AFT.u.x.l.n <- survreg(yLt ~ as.factor(sex) +
                         Neu_CZ
                       + frailty.gaussian(sample)
                       , data=datX, dist='logistic')
AFT.u.x.t.n <- survreg(yLt ~ as.factor(sex) + 
                         Neu_CZ
                       + frailty.gaussian(sample)
                       , data=datX, dist='t')
AFT.u.x.e.n <- survreg(yLt ~ as.factor(sex) +
                         Neu_CZ
                       + frailty.gaussian(sample)
                       , data=datX, dist='extreme')

AFT.s.i.l.n <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +
                         Neu_CZ
                       + strata(strt)
                       + frailty.gaussian(sample)
                       , data=datX, dist='logistic')
AFT.s.i.t.n <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +
                         Neu_CZ
                       + strata(strt)
                       + frailty.gaussian(sample)
                       , data=datX, dist='t')
AFT.s.i.e.n <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +
                         Neu_CZ
                       + strata(strt)
                       + frailty.gaussian(sample)
                       , data=datX, dist='extreme')
AFT.s.x.l.n <- survreg(yLt ~ as.factor(sex) +
                         Neu_CZ
                       + strata(strt)
                       + frailty.gaussian(sample)
                       , data=datX, dist='logistic')
AFT.s.x.t.n <- survreg(yLt ~ as.factor(sex) + 
                         Neu_CZ
                       + strata(strt)
                       + frailty.gaussian(sample)
                       , data=datX, dist='t')
AFT.s.x.e.n <- survreg(yLt ~ as.factor(sex) +
                         Neu_CZ
                       + strata(strt)
                       + frailty.gaussian(sample)
                       , data=datX, dist='extreme')

AFT.r.i.l.n <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +
                         N.r1.DoB
                       + frailty.gaussian(sample)
                       , data=datX, dist='logistic')
AFT.r.i.t.n <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +
                         N.r1.DoB
                       + frailty.gaussian(sample)
                       , data=datX, dist='t')
AFT.r.i.e.n <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +
                         N.r1.DoB
                       + frailty.gaussian(sample)
                       , data=datX, dist='extreme')
AFT.r.x.l.n <- survreg(yLt ~ as.factor(sex) +
                         N.r1.DoB
                       + frailty.gaussian(sample)
                       , data=datX, dist='logistic')
AFT.r.x.t.n <- survreg(yLt ~ as.factor(sex) + 
                         N.r1.DoB
                       + frailty.gaussian(sample)
                       , data=datX, dist='t')
AFT.r.x.e.n <- survreg(yLt ~ as.factor(sex) +
                         N.r1.DoB
                       + frailty.gaussian(sample)
                       , data=datX, dist='extreme')



## Conscientiousness
AFT.u.i.l.c <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +
                         Con_CZ
                       + frailty.gaussian(sample)
                       , data=datX, dist='logistic')
AFT.u.i.t.c <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +
                         Con_CZ
                       + frailty.gaussian(sample)
                       , data=datX, dist='t')
AFT.u.i.e.c <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +
                         Con_CZ
                       + frailty.gaussian(sample)
                       , data=datX, dist='extreme')
AFT.u.x.l.c <- survreg(yLt ~ as.factor(sex) +
                         Con_CZ
                       + frailty.gaussian(sample)
                       , data=datX, dist='logistic')
AFT.u.x.t.c <- survreg(yLt ~ as.factor(sex) + 
                         Con_CZ
                       + frailty.gaussian(sample)
                       , data=datX, dist='t')
AFT.u.x.e.c <- survreg(yLt ~ as.factor(sex) +
                         Con_CZ
                       + frailty.gaussian(sample)
                       , data=datX, dist='extreme')

AFT.s.i.l.c <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +
                         Con_CZ
                       + strata(strt)
                       + frailty.gaussian(sample)
                       , data=datX, dist='logistic')
AFT.s.i.t.c <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +
                         Con_CZ
                       + strata(strt)
                       + frailty.gaussian(sample)
                       , data=datX, dist='t')
AFT.s.i.e.c <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +
                         Con_CZ
                       + strata(strt)
                       + frailty.gaussian(sample)
                       , data=datX, dist='extreme')
AFT.s.x.l.c <- survreg(yLt ~ as.factor(sex) +
                         Con_CZ
                       + strata(strt)
                       + frailty.gaussian(sample)
                       , data=datX, dist='logistic')
AFT.s.x.t.c <- survreg(yLt ~ as.factor(sex) + 
                         Con_CZ
                       + strata(strt)
                       + frailty.gaussian(sample)
                       , data=datX, dist='t')
AFT.s.x.e.c <- survreg(yLt ~ as.factor(sex) +
                         Con_CZ
                       + strata(strt)
                       + frailty.gaussian(sample)
                       , data=datX, dist='extreme')


## Openness
AFT.u.i.l.o <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +
                         Opn_CZ
                       + frailty.gaussian(sample)
                       , data=datX, dist='logistic')
AFT.u.i.t.o <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +
                         Opn_CZ
                       + frailty.gaussian(sample)
                       , data=datX, dist='t')
AFT.u.i.e.o <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +
                         Opn_CZ
                       + frailty.gaussian(sample)
                       , data=datX, dist='extreme')
AFT.u.x.l.o <- survreg(yLt ~ as.factor(sex) +
                         Opn_CZ
                       + frailty.gaussian(sample)
                       , data=datX, dist='logistic')
AFT.u.x.t.o <- survreg(yLt ~ as.factor(sex) + 
                         Opn_CZ
                       + frailty.gaussian(sample)
                       , data=datX, dist='t')
AFT.u.x.e.o <- survreg(yLt ~ as.factor(sex) +
                         Opn_CZ
                       + frailty.gaussian(sample)
                       , data=datX, dist='extreme')

AFT.s.i.l.o <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +
                         Opn_CZ
                       + strata(strt)
                       + frailty.gaussian(sample)
                       , data=datX, dist='logistic')
AFT.s.i.t.o <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +
                         Opn_CZ
                       + strata(strt)
                       + frailty.gaussian(sample)
                       , data=datX, dist='t')
AFT.s.i.e.o <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +
                         Opn_CZ
                       + strata(strt)
                       + frailty.gaussian(sample)
                       , data=datX, dist='extreme')
AFT.s.x.l.o <- survreg(yLt ~ as.factor(sex) +
                         Opn_CZ
                       + strata(strt)
                       + frailty.gaussian(sample)
                       , data=datX, dist='logistic')
AFT.s.x.t.o <- survreg(yLt ~ as.factor(sex) + 
                         Opn_CZ
                       + strata(strt)
                       + frailty.gaussian(sample)
                       , data=datX, dist='t')
AFT.s.x.e.o <- survreg(yLt ~ as.factor(sex) +
                         Opn_CZ
                       + strata(strt)
                       + frailty.gaussian(sample)
                       , data=datX, dist='extreme')

AFT.r.i.l.o <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +
                         O.r2.DoB
                       + frailty.gaussian(sample)
                       , data=datX, dist='logistic')
AFT.r.i.t.o <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +
                         O.r2.DoB
                       + frailty.gaussian(sample)
                       , data=datX, dist='t')
AFT.r.i.e.o <- survreg(yLt ~ as.factor(sex) + as.factor(origin) +
                         O.r2.DoB
                       + frailty.gaussian(sample)
                       , data=datX, dist='extreme')
AFT.r.x.l.o <- survreg(yLt ~ as.factor(sex) +
                         O.r2.DoB
                       + frailty.gaussian(sample)
                       , data=datX, dist='logistic')
AFT.r.x.t.o <- survreg(yLt ~ as.factor(sex) + 
                         O.r2.DoB
                       + frailty.gaussian(sample)
                       , data=datX, dist='t')
AFT.r.x.e.o <- survreg(yLt ~ as.factor(sex) +
                         O.r2.DoB
                       + frailty.gaussian(sample)
                       , data=datX, dist='extreme')



##########################################################

# frail.AFT.wild <- survreg(yLt ~ as.factor(sex) + 
#                             as.factor(origin) +  
#                             Dom_CZ + Ext_CZ + Con_CZ +
#                             Agr_CZ + Neu_CZ + Opn_CZ
#                           + frailty.gaussian(sample)
#                           + strata(strt)
#                           , data=datX, dist='logistic')



glance(AFT.r.x.e.o)
