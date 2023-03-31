
library(lavaan)
library(psych)
library(regsem)
library(semTools) #runMI for imputation to deal with missingness in categorical models




m.ipc.1 <- '
ad =~ Dominant + Assertive + Forceful + Selfconfident + Outspoken

'
f.ipc.1 = cfa(m.ipc.1, mid.e,
                estimator="WLSMV", ordered=TRUE
)
fitMeasures(f.ipc.1, fit.measures = c('chisq','df','SRMR','CFI','TLI'))
summary(f.ipc.1)


m.mpq.1 <- '
sp =~ like_to_lead + talk_people_into + influencing + decisions
'

f.mpq.1 = cfa(m.mpq.1, mid.e,
              estimator="WLSMV", ordered=TRUE
)
fitMeasures(f.mpq.1, fit.measures = c('chisq','df','SRMR','CFI','TLI'))
summary(f.mpq.1)


# rm selfconfident because of E, O overlap?
# seemed like 'influencing' caused issues earlier...
m.com.1 <-'
D =~  Dominant + Assertive + Forceful + Outspoken + #Selfconfident +
like_to_lead + talk_people_into + decisions + #influencing + 
not_afraid
'

f.com.1 = cfa(m.com.1, mid.e,
              estimator="WLSMV", ordered=TRUE
)
fitMeasures(f.com.1, fit.measures = c('chisq','df','SRMR','CFI','TLI'))
summary(f.com.1)

###############
### Alpha & Omega stats

## IPC
omega(mid.e[,c('Dominant','Assertive','Forceful','Selfconfident','Outspoken')], plot=FALSE)

## MPQ
omega(mid.e[,c('like_to_lead','talk_people_into','influencing','decisions')], plot=FALSE)

## composite
omega(mid.e[,c('Dominant','Assertive','Forceful','Outspoken',
                 'like_to_lead','talk_people_into','decisions',
                 'not_afraid')], plot=FALSE)


###############

?runMI

regsem(f.regt1.1)
