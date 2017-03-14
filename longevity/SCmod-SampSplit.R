
cpq = datX$sample == 'Yerkes' | datX$sample == 'AZA'
hpq = datX$sample == 'Japan' | datX$sample == 'Edinburgh'


# Sig table for just CPQ chimps
# 
#           D   E   C   A   N   O
#   
# 6 U i l       *       *
#       t       *       *
#       e       *       *       
#     x l   *   *       *
#       t   *   *       *
#       e       *       *       *

#   S i l   
#       X

#   R i l       *       *
#       t       *       *
#       e       *       *
#     x l       *       *
#       t       *       *
#       e       *       *
#   

# Sig table for just HPQ chimps
# 
#           D   E   C   A   N   O
#   
# 6 U i l       *       *
#       t       *       *
#       e       *       *       *
#     x l   *   *       *
#       t   *   *       *
#       e       *       *       *

#   S i l   
#       X

#   R i l       *       *
#       t       *       *
#       e       *       *
#     x l       *       *
#       t       *       *
#       e       *       *
#   


AFT.r.i.l.6.h <- survreg(yLt[hpq,] ~ as.factor(sex) + as.factor(origin) +  
                         D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB
                       + frailty.gaussian(sample)
                       , data=datX[hpq,], dist='logistic')
AFT.r.i.t.6.h <- survreg(yLt[hpq,] ~ as.factor(sex) + as.factor(origin) +  
                         D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB
                       + frailty.gaussian(sample)
                       , data=datX[hpq,], dist='t')
AFT.r.i.e.6.h <- survreg(yLt[hpq,] ~ as.factor(sex) + as.factor(origin) +  
                         D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB
                       + frailty.gaussian(sample)
                       , data=datX[hpq,], dist='extreme')
AFT.r.x.l.6.h <- survreg(yLt[hpq,] ~ as.factor(sex) +  
                         D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB
                       + frailty.gaussian(sample)
                       , data=datX[hpq,], dist='logistic')
AFT.r.x.t.6.h <- survreg(yLt[hpq,] ~ as.factor(sex) +  
                         D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB
                       + frailty.gaussian(sample)
                       , data=datX[hpq,], dist='t')
AFT.r.x.e.6.h <- survreg(yLt[hpq,] ~ as.factor(sex) +  
                         D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB
                       + frailty.gaussian(sample)
                       , data=datX[hpq,], dist='extreme') 

AFT.u.i.l.6.h <- survreg(yLt[hpq,] ~ as.factor(sex) + as.factor(origin) +  
                         Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ
                       + frailty.gaussian(sample)
                       , data=datX[hpq,], dist='logistic')
AFT.u.i.t.6.h <- survreg(yLt[hpq,] ~ as.factor(sex) + as.factor(origin) +  
                         Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ
                       + frailty.gaussian(sample)
                       , data=datX[hpq,], dist='t')
AFT.u.i.e.6.h <- survreg(yLt[hpq,] ~ as.factor(sex) + as.factor(origin) +  
                         Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ
                       + frailty.gaussian(sample)
                       , data=datX[hpq,], dist='extreme')
AFT.u.x.l.6.h <- survreg(yLt[hpq,] ~ as.factor(sex) +  
                         Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ
                       + frailty.gaussian(sample)
                       , data=datX[hpq,], dist='logistic')
AFT.u.x.t.6.h <- survreg(yLt[hpq,] ~ as.factor(sex) +  
                         Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ
                       + frailty.gaussian(sample)
                       , data=datX[hpq,], dist='t')
AFT.u.x.e.6.h <- survreg(yLt[hpq,] ~ as.factor(sex) +  
                         Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ
                       + frailty.gaussian(sample)
                       , data=datX[hpq,], dist='extreme') 


AFT.r.i.l.6.c <- survreg(yLt[cpq,] ~ as.factor(sex) + as.factor(origin) +  
                           D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB
                         + frailty.gaussian(sample)
                         , data=datX[cpq,], dist='logistic')
AFT.r.i.t.6.c <- survreg(yLt[cpq,] ~ as.factor(sex) + as.factor(origin) +  
                           D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB
                         + frailty.gaussian(sample)
                         , data=datX[cpq,], dist='t')
AFT.r.i.e.6.c <- survreg(yLt[cpq,] ~ as.factor(sex) + as.factor(origin) +  
                           D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB
                         + frailty.gaussian(sample)
                         , data=datX[cpq,], dist='extreme')
AFT.r.x.l.6.c <- survreg(yLt[cpq,] ~ as.factor(sex) +  
                           D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB
                         + frailty.gaussian(sample)
                         , data=datX[cpq,], dist='logistic')
AFT.r.x.t.6.c <- survreg(yLt[cpq,] ~ as.factor(sex) +  
                           D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB
                         + frailty.gaussian(sample)
                         , data=datX[cpq,], dist='t')
AFT.r.x.e.6.c <- survreg(yLt[cpq,] ~ as.factor(sex) +  
                           D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB
                         + frailty.gaussian(sample)
                         , data=datX[cpq,], dist='extreme') 

AFT.u.i.l.6.c <- survreg(yLt[cpq,] ~ as.factor(sex) + as.factor(origin) +  
                           Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ
                         + frailty.gaussian(sample)
                         , data=datX[cpq,], dist='logistic')
AFT.u.i.t.6.c <- survreg(yLt[cpq,] ~ as.factor(sex) + as.factor(origin) +  
                           Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ
                         + frailty.gaussian(sample)
                         , data=datX[cpq,], dist='t')
AFT.u.i.e.6.c <- survreg(yLt[cpq,] ~ as.factor(sex) + as.factor(origin) +  
                           Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ
                         + frailty.gaussian(sample)
                         , data=datX[cpq,], dist='extreme')
AFT.u.x.l.6.c <- survreg(yLt[cpq,] ~ as.factor(sex) +  
                           Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ
                        # + frailty.gaussian(sample)
                         , data=datX[cpq,], dist='logistic')
AFT.u.x.t.6.c <- survreg(yLt[cpq,] ~ as.factor(sex) +  
                           Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ
                         + frailty.gaussian(sample)
                         , data=datX[cpq,], dist='t')
AFT.u.x.e.6.c <- survreg(yLt[cpq,] ~ as.factor(sex) +  
                           Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ
                         + frailty.gaussian(sample)
                         , data=datX[cpq,], dist='extreme') 


