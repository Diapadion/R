### Exploratory Factor Analyses

library(psych)
library(GPArotation)



### MIDUS2 ###


AEOvars = c('Selfconfident','Forceful','Assertive','Outspoken','Dominant',
            'Creative','Imaginative','Intelligent','Curious','Broadminded',
            'Sophisticated','Adventurous',
            'Outgoing','Friendly','Lively','Active','Talkative'
)



m.fa.2 = fa(midus2[,..AEOvars], 2, rotate = 'oblimin')
# The root mean square of the residuals (RMSR) is  0.07 
# The df corrected root mean square of the residuals is  0.08 
# 
# The harmonic number of observations is  3954 with the empirical chi square  4672.76  with prob <  0 
# The total number of observations was  5334  with Likelihood Chi Square =  6149.46  with prob <  0 
# 
# Tucker Lewis Index of factoring reliability =  0.737
# RMSEA index =  0.105  and the 90 % confidence intervals are  0.103 0.107
# BIC =  5265.53
# Fit based upon off diagonal values = 0.95

m.fa.3 = fa(midus2[,..AEOvars], 3, rotate = 'oblimin')
# The root mean square of the residuals (RMSR) is  0.04 
# The df corrected root mean square of the residuals is  0.05 
# 
# The harmonic number of observations is  3954 with the empirical chi square  1817.39  with prob <  6.501904e-321 
# The total number of observations was  5334  with Likelihood Chi Square =  3269.89  with prob <  0 
# 
# Tucker Lewis Index of factoring reliability =  0.838
# RMSEA index =  0.082  and the 90 % confidence intervals are  0.08 0.085
# BIC =  2514.69
# Fit based upon off diagonal values = 0.98

m.fa.4 = fa(midus2[,..AEOvars], 4, rotate = 'oblimin')
# The root mean square of the residuals (RMSR) is  0.03 
# The df corrected root mean square of the residuals is  0.04 
# 
# The harmonic number of observations is  3954 with the empirical chi square  797.12  with prob <  9.9e-122 
# The total number of observations was  5334  with Likelihood Chi Square =  1581.71  with prob <  2.1e-281 
# 
# Tucker Lewis Index of factoring reliability =  0.909
# RMSEA index =  0.062  and the 90 % confidence intervals are  0.059 0.064
# BIC =  946.66
# Fit based upon off diagonal values = 0.99




### IPIP ###

AEOIvars = c('I8','I68','I188','I128','I153','I183','I243', # Openness
             'I203','I23','I83','I113','I293', # Intellect
             'I12','I162','I72','I282', # Assertiveness
             'I2','I57','I32','I272','I152' # Enthusiasm
)


i.fa.2 = fa(ipip[,AEOIvars], 2, rotate = 'oblimin')
# The root mean square of the residuals (RMSR) is  0.07 
# The df corrected root mean square of the residuals is  0.08 
# 
# The harmonic number of observations is  5225 with the empirical chi square  11305.57  with prob <  0 
# The total number of observations was  5225  with Likelihood Chi Square =  7342.59  with prob <  0 
# 
# Tucker Lewis Index of factoring reliability =  0.643
# RMSEA index =  0.09  and the 90 % confidence intervals are  0.088 0.092
# BIC =  5895.75
# Fit based upon off diagonal values = 0.86

i.fa.3 = fa(ipip[,AEOIvars], 3, rotate = 'oblimin')
# The root mean square of the residuals (RMSR) is  0.04 
# The df corrected root mean square of the residuals is  0.05 
# 
# The harmonic number of observations is  5225 with the empirical chi square  3906.61  with prob <  0 
# The total number of observations was  5225  with Likelihood Chi Square =  3603.45  with prob <  0 
# 
# Tucker Lewis Index of factoring reliability =  0.806
# RMSEA index =  0.066  and the 90 % confidence intervals are  0.065 0.068
# BIC =  2319.27
# Fit based upon off diagonal values = 0.95

i.fa.4 = fa(ipip[,AEOIvars], 4, rotate = 'oblimin')
# The root mean square of the residuals (RMSR) is  0.03 
# The df corrected root mean square of the residuals is  0.04 
# 
# The harmonic number of observations is  5225 with the empirical chi square  2255.43  with prob <  0 
# The total number of observations was  5225  with Likelihood Chi Square =  2401.91  with prob <  0 
# 
# Tucker Lewis Index of factoring reliability =  0.855
# RMSEA index =  0.057  and the 90 % confidence intervals are  0.055 0.059
# BIC =  1271.83
# Fit based upon off diagonal values = 0.97

