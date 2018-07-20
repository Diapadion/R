### Coefficient and CI values for publication

## Acceleration factor is exponentiated coefficient
## Use second LogLik

library(eha)



### Revised from GD edits

## Base model (S1)
exp(coefficients(aft.gd3.0)[1])
exp(confint(aft.gd3.0)[1,1])
exp(confint(aft.gd3.0)[1,2])

exp(coefficients(aft.gd3.0)[2])
exp(confint(aft.gd3.0)[2,1])
exp(confint(aft.gd3.0)[2,2])

exp(coefficients(aft.gd3.0)[3])
exp(confint(aft.gd3.0)[3,1])
exp(confint(aft.gd3.0)[3,2])

extractAIC(aft.gd3.0)
aft.gd3.0$loglik



## First interaction model (1)
exp(coefficients(aft.gd3.1)[1])
exp(confint(aft.gd3.1)[1,1])
exp(confint(aft.gd3.1)[1,2])

exp(coefficients(aft.gd3.1)[2])
exp(confint(aft.gd3.1)[2,1])
exp(confint(aft.gd3.1)[2,2])

exp(coefficients(aft.gd3.1)[3])
exp(confint(aft.gd3.1)[3,1])
exp(confint(aft.gd3.1)[3,2])

exp(coefficients(aft.gd3.1)[4])
exp(confint(aft.gd3.1)[4,1])
exp(confint(aft.gd3.1)[4,2])

extractAIC(aft.gd3.1)
aft.gd3.1$loglik[2]


## Adding childhood SES (2)
exp(coefficients(aft.gd3.2)[1])
exp(confint(aft.gd3.2)[1,1])
exp(confint(aft.gd3.2)[1,2])

exp(coefficients(aft.gd3.2)[2])
exp(confint(aft.gd3.2)[2,1])
exp(confint(aft.gd3.2)[2,2])

exp(coefficients(aft.gd3.2)[3])
exp(confint(aft.gd3.2)[3,1])
exp(confint(aft.gd3.2)[3,2])

exp(coefficients(aft.gd3.2)[4])
exp(confint(aft.gd3.2)[4,1])
exp(confint(aft.gd3.2)[4,2])

exp(coefficients(aft.gd3.2)[5])
exp(confint(aft.gd3.2)[5,1])
exp(confint(aft.gd3.2)[5,2])

extractAIC(aft.gd3.2)
aft.gd3.2$loglik


## Adding adult SES (3)
exp(coefficients(aft.gd3.3)[1])
exp(confint(aft.gd3.3)[1,1])
exp(confint(aft.gd3.3)[1,2])

exp(coefficients(aft.gd3.3)[2])
exp(confint(aft.gd3.3)[2,1])
exp(confint(aft.gd3.3)[2,2])

exp(coefficients(aft.gd3.3)[3])
exp(confint(aft.gd3.3)[3,1])
exp(confint(aft.gd3.3)[3,2])

exp(coefficients(aft.gd3.3)[4])
exp(confint(aft.gd3.3)[4,1])
exp(confint(aft.gd3.3)[4,2])

exp(coefficients(aft.gd3.3)[5])
exp(confint(aft.gd3.3)[5,1])
exp(confint(aft.gd3.3)[5,2])

exp(coefficients(aft.gd3.3)[6])
exp(confint(aft.gd3.3)[6,1])
exp(confint(aft.gd3.3)[6,2])

extractAIC(aft.gd3.3)
aft.gd3.3$loglik


## Just income component (4)
exp(coefficients(aft.gd3.4)[1])
exp(confint(aft.gd3.4)[1,1])
exp(confint(aft.gd3.4)[1,2])

exp(coefficients(aft.gd3.4)[2])
exp(confint(aft.gd3.4)[2,1])
exp(confint(aft.gd3.4)[2,2])

exp(coefficients(aft.gd3.4)[3])
exp(confint(aft.gd3.4)[3,1])
exp(confint(aft.gd3.4)[3,2])

exp(coefficients(aft.gd3.4)[4])
exp(confint(aft.gd3.4)[4,1])
exp(confint(aft.gd3.4)[4,2])

exp(coefficients(aft.gd3.4)[5])
exp(confint(aft.gd3.4)[5,1])
exp(confint(aft.gd3.4)[5,2])

exp(coefficients(aft.gd3.4)[6])
exp(confint(aft.gd3.4)[6,1])
exp(confint(aft.gd3.4)[6,2])

extractAIC(aft.gd3.4)
aft.gd3.4$loglik


## Just education component (5)
exp(coefficients(aft.gd3.5)[1])
exp(confint(aft.gd3.5)[1,1])
exp(confint(aft.gd3.5)[1,2])

exp(coefficients(aft.gd3.5)[2])
exp(confint(aft.gd3.5)[2,1])
exp(confint(aft.gd3.5)[2,2])

exp(coefficients(aft.gd3.5)[3])
exp(confint(aft.gd3.5)[3,1])
exp(confint(aft.gd3.5)[3,2])

exp(coefficients(aft.gd3.5)[4])
exp(confint(aft.gd3.5)[4,1])
exp(confint(aft.gd3.5)[4,2])

exp(coefficients(aft.gd3.5)[5])
exp(confint(aft.gd3.5)[5,1])
exp(confint(aft.gd3.5)[5,2])

exp(coefficients(aft.gd3.5)[6])
exp(confint(aft.gd3.5)[6,1])
exp(confint(aft.gd3.5)[6,2])

extractAIC(aft.gd3.5)
aft.gd3.5$loglik



## Just occupation component (6)
exp(coefficients(aft.gd3.6)[1])
exp(confint(aft.gd3.6)[1,1])
exp(confint(aft.gd3.6)[1,2])

exp(coefficients(aft.gd3.6)[2])
exp(confint(aft.gd3.6)[2,1])
exp(confint(aft.gd3.6)[2,2])

exp(coefficients(aft.gd3.6)[3])
exp(confint(aft.gd3.6)[3,1])
exp(confint(aft.gd3.6)[3,2])

exp(coefficients(aft.gd3.6)[4])
exp(confint(aft.gd3.6)[4,1])
exp(confint(aft.gd3.6)[4,2])

exp(coefficients(aft.gd3.6)[5])
exp(confint(aft.gd3.6)[5,1])
exp(confint(aft.gd3.6)[5,2])

exp(coefficients(aft.gd3.6)[6])
exp(confint(aft.gd3.6)[6,1])
exp(confint(aft.gd3.6)[6,2])

extractAIC(aft.gd3.6)
aft.gd3.6$loglik



## Adult SES + Income
exp(coefficients(aft.gd3.7)[1])
exp(confint(aft.gd3.7)[1,1])
exp(confint(aft.gd3.7)[1,2])

exp(coefficients(aft.gd3.7)[2])
exp(confint(aft.gd3.7)[2,1])
exp(confint(aft.gd3.7)[2,2])

exp(coefficients(aft.gd3.7)[3])
exp(confint(aft.gd3.7)[3,1])
exp(confint(aft.gd3.7)[3,2])

exp(coefficients(aft.gd3.7)[4])
exp(confint(aft.gd3.7)[4,1])
exp(confint(aft.gd3.7)[4,2])

exp(coefficients(aft.gd3.7)[5])
exp(confint(aft.gd3.7)[5,1])
exp(confint(aft.gd3.7)[5,2])

exp(coefficients(aft.gd3.7)[6])
exp(confint(aft.gd3.7)[6,1])
exp(confint(aft.gd3.7)[6,2])

exp(coefficients(aft.gd3.7)[7])
exp(confint(aft.gd3.7)[7,1])
exp(confint(aft.gd3.7)[7,2])

extractAIC(aft.gd3.7)
aft.gd3.7$loglik[2]


## Adult SES + Income interaction
exp(coefficients(aft.gd3.8)[1])
exp(confint(aft.gd3.8)[1,1])
exp(confint(aft.gd3.8)[1,2])

exp(coefficients(aft.gd3.8)[2])
exp(confint(aft.gd3.8)[2,1])
exp(confint(aft.gd3.8)[2,2])

exp(coefficients(aft.gd3.8)[3])
exp(confint(aft.gd3.8)[3,1])
exp(confint(aft.gd3.8)[3,2])

exp(coefficients(aft.gd3.8)[4])
exp(confint(aft.gd3.8)[4,1])
exp(confint(aft.gd3.8)[4,2])

exp(coefficients(aft.gd3.8)[5])
exp(confint(aft.gd3.8)[5,1])
exp(confint(aft.gd3.8)[5,2])

exp(coefficients(aft.gd3.8)[6])
exp(confint(aft.gd3.8)[6,1])
exp(confint(aft.gd3.8)[6,2])

exp(coefficients(aft.gd3.8)[7])
exp(confint(aft.gd3.8)[7,1])
exp(confint(aft.gd3.8)[7,2])

exp(coefficients(aft.gd3.8)[8])
exp(confint(aft.gd3.8)[8,1])
exp(confint(aft.gd3.8)[8,2])

extractAIC(aft.gd3.8)
aft.gd3.8$loglik[2]


## Adult SES + Income interaction (ALTERN)
exp(coefficients(aft.gd3.8b)[1])
exp(confint(aft.gd3.8b)[1,1])
exp(confint(aft.gd3.8b)[1,2])

exp(coefficients(aft.gd3.8b)[2])
exp(confint(aft.gd3.8b)[2,1])
exp(confint(aft.gd3.8b)[2,2])

exp(coefficients(aft.gd3.8b)[3])
exp(confint(aft.gd3.8b)[3,1])
exp(confint(aft.gd3.8b)[3,2])

exp(coefficients(aft.gd3.8b)[4])
exp(confint(aft.gd3.8b)[4,1])
exp(confint(aft.gd3.8b)[4,2])

exp(coefficients(aft.gd3.8b)[5])
exp(confint(aft.gd3.8b)[5,1])
exp(confint(aft.gd3.8b)[5,2])

exp(coefficients(aft.gd3.8b)[6])
exp(confint(aft.gd3.8b)[6,1])
exp(confint(aft.gd3.8b)[6,2])

exp(coefficients(aft.gd3.8b)[7])
exp(confint(aft.gd3.8b)[7,1])
exp(confint(aft.gd3.8b)[7,2])

exp(coefficients(aft.gd3.8b)[8])
exp(confint(aft.gd3.8b)[8,1])
exp(confint(aft.gd3.8b)[8,2])

extractAIC(aft.gd3.8b)
aft.gd3.8b$loglik[2]


## Adult SES + Income interaction - Sex * IQ
exp(coefficients(aft.gd3.8c)[1])
exp(confint(aft.gd3.8c)[1,1])
exp(confint(aft.gd3.8c)[1,2])

exp(coefficients(aft.gd3.8c)[2])
exp(confint(aft.gd3.8c)[2,1])
exp(confint(aft.gd3.8c)[2,2])

exp(coefficients(aft.gd3.8c)[3])
exp(confint(aft.gd3.8c)[3,1])
exp(confint(aft.gd3.8c)[3,2])

exp(coefficients(aft.gd3.8c)[4])
exp(confint(aft.gd3.8c)[4,1])
exp(confint(aft.gd3.8c)[4,2])

exp(coefficients(aft.gd3.8c)[5])
exp(confint(aft.gd3.8c)[5,1])
exp(confint(aft.gd3.8c)[5,2])

exp(coefficients(aft.gd3.8c)[6])
exp(confint(aft.gd3.8c)[6,1])
exp(confint(aft.gd3.8c)[6,2])

extractAIC(aft.gd3.8c)
aft.gd3.8c$loglik[2]






### Original output

## Base model (S1)
exp(coefficients(aft.0.ll)[1])
exp(confint(aft.0.ll)[1,1])
exp(confint(aft.0.ll)[1,2])

exp(coefficients(aft.0.ll)[2])
exp(confint(aft.0.ll)[2,1])
exp(confint(aft.0.ll)[2,2])

exp(coefficients(aft.0.ll)[3])
exp(confint(aft.0.ll)[3,1])
exp(confint(aft.0.ll)[3,2])

extractAIC(aft.0.ll)
aft.0.ll$loglik


## First interaction model (1)
exp(coefficients(aft.1.ll)[1])
exp(confint(aft.1.ll)[1,1])
exp(confint(aft.1.ll)[1,2])

exp(coefficients(aft.1.ll)[2])
exp(confint(aft.1.ll)[2,1])
exp(confint(aft.1.ll)[2,2])

exp(coefficients(aft.1.ll)[3])
exp(confint(aft.1.ll)[3,1])
exp(confint(aft.1.ll)[3,2])

exp(coefficients(aft.1.ll)[4])
exp(confint(aft.1.ll)[4,1])
exp(confint(aft.1.ll)[4,2])

extractAIC(aft.1.ll)
aft.1.ll$loglik[2]


## Adding childhood SES (2)
exp(coefficients(aft.2)[1])
exp(confint(aft.2)[1,1])
exp(confint(aft.2)[1,2])

exp(coefficients(aft.2)[2])
exp(confint(aft.2)[2,1])
exp(confint(aft.2)[2,2])

exp(coefficients(aft.2)[3])
exp(confint(aft.2)[3,1])
exp(confint(aft.2)[3,2])

exp(coefficients(aft.2)[4])
exp(confint(aft.2)[4,1])
exp(confint(aft.2)[4,2])

exp(coefficients(aft.2)[5])
exp(confint(aft.2)[5,1])
exp(confint(aft.2)[5,2])

extractAIC(aft.2)
aft.2$loglik


## Adding adult SES (3)
exp(coefficients(aft.3)[1])
exp(confint(aft.3)[1,1])
exp(confint(aft.3)[1,2])

exp(coefficients(aft.3)[2])
exp(confint(aft.3)[2,1])
exp(confint(aft.3)[2,2])

exp(coefficients(aft.3)[3])
exp(confint(aft.3)[3,1])
exp(confint(aft.3)[3,2])

exp(coefficients(aft.3)[4])
exp(confint(aft.3)[4,1])
exp(confint(aft.3)[4,2])

exp(coefficients(aft.3)[5])
exp(confint(aft.3)[5,1])
exp(confint(aft.3)[5,2])

exp(coefficients(aft.3)[6])
exp(confint(aft.3)[6,1])
exp(confint(aft.3)[6,2])

extractAIC(aft.3)
aft.3$loglik


## Just income component (4)
exp(coefficients(aft.4)[1])
exp(confint(aft.4)[1,1])
exp(confint(aft.4)[1,2])

exp(coefficients(aft.4)[2])
exp(confint(aft.4)[2,1])
exp(confint(aft.4)[2,2])

exp(coefficients(aft.4)[3])
exp(confint(aft.4)[3,1])
exp(confint(aft.4)[3,2])

exp(coefficients(aft.4)[4])
exp(confint(aft.4)[4,1])
exp(confint(aft.4)[4,2])

exp(coefficients(aft.4)[5])
exp(confint(aft.4)[5,1])
exp(confint(aft.4)[5,2])

exp(coefficients(aft.4)[6])
exp(confint(aft.4)[6,1])
exp(confint(aft.4)[6,2])

extractAIC(aft.4)
aft.4$loglik


## Just education component (5)
exp(coefficients(aft.5)[1])
exp(confint(aft.5)[1,1])
exp(confint(aft.5)[1,2])

exp(coefficients(aft.5)[2])
exp(confint(aft.5)[2,1])
exp(confint(aft.5)[2,2])

exp(coefficients(aft.5)[3])
exp(confint(aft.5)[3,1])
exp(confint(aft.5)[3,2])

exp(coefficients(aft.5)[4])
exp(confint(aft.5)[4,1])
exp(confint(aft.5)[4,2])

exp(coefficients(aft.5)[5])
exp(confint(aft.5)[5,1])
exp(confint(aft.5)[5,2])

exp(coefficients(aft.5)[6])
exp(confint(aft.5)[6,1])
exp(confint(aft.5)[6,2])

extractAIC(aft.5)
aft.5$loglik



## Just education component (6)
exp(coefficients(aft.6)[1])
exp(confint(aft.6)[1,1])
exp(confint(aft.6)[1,2])

exp(coefficients(aft.6)[2])
exp(confint(aft.6)[2,1])
exp(confint(aft.6)[2,2])

exp(coefficients(aft.6)[3])
exp(confint(aft.6)[3,1])
exp(confint(aft.6)[3,2])

exp(coefficients(aft.6)[4])
exp(confint(aft.6)[4,1])
exp(confint(aft.6)[4,2])

exp(coefficients(aft.6)[5])
exp(confint(aft.6)[5,1])
exp(confint(aft.6)[5,2])

exp(coefficients(aft.6)[6])
exp(confint(aft.6)[6,1])
exp(confint(aft.6)[6,2])

extractAIC(aft.6)
aft.6$loglik



## Adult SES + Income
exp(coefficients(aft.gd.3)[1])
exp(confint(aft.gd.3)[1,1])
exp(confint(aft.gd.3)[1,2])

exp(coefficients(aft.gd.3)[2])
exp(confint(aft.gd.3)[2,1])
exp(confint(aft.gd.3)[2,2])

exp(coefficients(aft.gd.3)[3])
exp(confint(aft.gd.3)[3,1])
exp(confint(aft.gd.3)[3,2])

exp(coefficients(aft.gd.3)[4])
exp(confint(aft.gd.3)[4,1])
exp(confint(aft.gd.3)[4,2])

exp(coefficients(aft.gd.3)[5])
exp(confint(aft.gd.3)[5,1])
exp(confint(aft.gd.3)[5,2])

exp(coefficients(aft.gd.3)[6])
exp(confint(aft.gd.3)[6,1])
exp(confint(aft.gd.3)[6,2])

exp(coefficients(aft.gd.3)[7])
exp(confint(aft.gd.3)[7,1])
exp(confint(aft.gd.3)[7,2])

extractAIC(aft.gd.3)
aft.gd.3$loglik[2]


## Adult SES + Income interaction
## aft.4.i is equivalent to aft.gd.4
exp(coefficients(aft.4.i)[1])
exp(confint(aft.4.i)[1,1])
exp(confint(aft.4.i)[1,2])

exp(coefficients(aft.4.i)[2])
exp(confint(aft.4.i)[2,1])
exp(confint(aft.4.i)[2,2])

exp(coefficients(aft.4.i)[3])
exp(confint(aft.4.i)[3,1])
exp(confint(aft.4.i)[3,2])

exp(coefficients(aft.4.i)[4])
exp(confint(aft.4.i)[4,1])
exp(confint(aft.4.i)[4,2])

exp(coefficients(aft.4.i)[5])
exp(confint(aft.4.i)[5,1])
exp(confint(aft.4.i)[5,2])

exp(coefficients(aft.4.i)[6])
exp(confint(aft.4.i)[6,1])
exp(confint(aft.4.i)[6,2])

exp(coefficients(aft.4.i)[7])
exp(confint(aft.4.i)[7,1])
exp(confint(aft.4.i)[7,2])

exp(coefficients(aft.4.i)[8])
exp(confint(aft.4.i)[8,1])
exp(confint(aft.4.i)[8,2])

extractAIC(aft.4.i)
aft.4.i$loglik[2]



## adding Individual income
## aft.4.i is equivalent to aft.gd.5
exp(coefficients(aft.7)[1])
exp(confint(aft.7)[1,1])
exp(confint(aft.7)[1,2])

exp(coefficients(aft.7)[2])
exp(confint(aft.7)[2,1])
exp(confint(aft.7)[2,2])

exp(coefficients(aft.7)[3])
exp(confint(aft.7)[3,1])
exp(confint(aft.7)[3,2])

exp(coefficients(aft.7)[4])
exp(confint(aft.7)[4,1])
exp(confint(aft.7)[4,2])

exp(coefficients(aft.7)[5])
exp(confint(aft.7)[5,1])
exp(confint(aft.7)[5,2])

exp(coefficients(aft.7)[6])
exp(confint(aft.7)[6,1])
exp(confint(aft.7)[6,2])

exp(coefficients(aft.7)[7])
exp(confint(aft.7)[7,1])
exp(confint(aft.7)[7,2])

exp(coefficients(aft.7)[8])
exp(confint(aft.7)[8,1])
exp(confint(aft.7)[8,2])

exp(coefficients(aft.7)[9])
exp(confint(aft.7)[9,1])
exp(confint(aft.7)[9,2])

extractAIC(aft.7)
aft.7$loglik



## adding Individual income * sex
## follows on from GD revisions... (Table S?)
exp(coefficients(aft.7.i)[1])
exp(confint(aft.7.i)[1,1])
exp(confint(aft.7.i)[1,2])

exp(coefficients(aft.7.i)[2])
exp(confint(aft.7.i)[2,1])
exp(confint(aft.7.i)[2,2])

exp(coefficients(aft.7.i)[3])
exp(confint(aft.7.i)[3,1])
exp(confint(aft.7.i)[3,2])

exp(coefficients(aft.7.i)[4])
exp(confint(aft.7.i)[4,1])
exp(confint(aft.7.i)[4,2])

exp(coefficients(aft.7.i)[5])
exp(confint(aft.7.i)[5,1])
exp(confint(aft.7.i)[5,2])

exp(coefficients(aft.7.i)[6])
exp(confint(aft.7.i)[6,1])
exp(confint(aft.7.i)[6,2])

exp(coefficients(aft.7.i)[7])
exp(confint(aft.7.i)[7,1])
exp(confint(aft.7.i)[7,2])

exp(coefficients(aft.7.i)[8])
exp(confint(aft.7.i)[8,1])
exp(confint(aft.7.i)[8,2])

exp(coefficients(aft.7.i)[9])
exp(confint(aft.7.i)[9,1])
exp(confint(aft.7.i)[9,2])

exp(coefficients(aft.7.i)[10])
exp(confint(aft.7.i)[10,1])
exp(confint(aft.7.i)[10,2])


extractAIC(aft.7.i)
aft.7.i$loglik







###----------------------------------

## adding BMI '85
exp(coefficients(aft.8)[1])
exp(confint(aft.8)[1,1])
exp(confint(aft.8)[1,2])

exp(coefficients(aft.8)[2])
exp(confint(aft.8)[2,1])
exp(confint(aft.8)[2,2])

exp(coefficients(aft.8)[3])
exp(confint(aft.8)[3,1])
exp(confint(aft.8)[3,2])

exp(coefficients(aft.8)[4])
exp(confint(aft.8)[4,1])
exp(confint(aft.8)[4,2])

exp(coefficients(aft.8)[5])
exp(confint(aft.8)[5,1])
exp(confint(aft.8)[5,2])

exp(coefficients(aft.8)[6])
exp(confint(aft.8)[6,1])
exp(confint(aft.8)[6,2])

exp(coefficients(aft.8)[7])
exp(confint(aft.8)[7,1])
exp(confint(aft.8)[7,2])

exp(coefficients(aft.8)[8])
exp(confint(aft.8)[8,1])
exp(confint(aft.8)[8,2])

extractAIC(aft.8)
aft.8$loglik


## adding BMI '06
exp(coefficients(aft.9)[1])
exp(confint(aft.9)[1,1])
exp(confint(aft.9)[1,2])

exp(coefficients(aft.9)[2])
exp(confint(aft.9)[2,1])
exp(confint(aft.9)[2,2])

exp(coefficients(aft.9)[3])
exp(confint(aft.9)[3,1])
exp(confint(aft.9)[3,2])

exp(coefficients(aft.9)[4])
exp(confint(aft.9)[4,1])
exp(confint(aft.9)[4,2])

exp(coefficients(aft.9)[5])
exp(confint(aft.9)[5,1])
exp(confint(aft.9)[5,2])

exp(coefficients(aft.9)[6])
exp(confint(aft.9)[6,1])
exp(confint(aft.9)[6,2])

exp(coefficients(aft.9)[7])
exp(confint(aft.9)[7,1])
exp(confint(aft.9)[7,2])

exp(coefficients(aft.9)[8])
exp(confint(aft.9)[8,1])
exp(confint(aft.9)[8,2])

exp(coefficients(aft.9)[9])
exp(confint(aft.9)[9,1])
exp(confint(aft.9)[9,2])

extractAIC(aft.9)
aft.9$loglik

