### Coefficient and CI values for publication

# Accleration factor is exponentiated coefficient

# Base model (1)
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


# First interaction model (2)
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
aft.1.ll$loglik


# Adding childhood SES (3)
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


# Adding adult SES (4)
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


# Just income component (5)
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


# Just education component (6)
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


# Just education component (7)
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


## Adult SES + Income interaction
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

extractAIC(aft.4.i)
aft.4.i$loglik


## adding Individual income
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

extractAIC(aft.7)
aft.7$loglik


## adding Individual income * sex
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

extractAIC(aft.7.i)
aft.7.i$loglik


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

