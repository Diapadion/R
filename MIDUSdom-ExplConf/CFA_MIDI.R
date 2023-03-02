### MIDUS CFAs


library(lavaan)





### Initial single factor models

m.D.1 <-'
D =~ Dominant + Outspoken + Assertive + Forceful + Selfconfident 

'

f.D.1 = cfa(m.D.1, midus2,
            estimator="WLSMV"
            , ordered=TRUE
)

fitMeasures(f.D.1, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC','rmsea.ci.upper'))
#summary(f.D.1)


m.E.1 <-'
E =~ Lively + Friendly + Active + Talkative + Outgoing

'

f.E.1 = cfa(m.E.1, midus2,
            estimator="WLSMV"
            , ordered=TRUE
)

fitMeasures(f.E.1, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC','rmsea.ci.upper'))
summary(f.E.1)



m.O.1 <-'
O =~ Creative + Imaginative + Curious + Broadminded + Intelligent + Adventurous + Sophisticated

'

f.O.1 = cfa(m.O.1, midus2,
            estimator="WLSMV"
            , ordered=TRUE
)

fitMeasures(f.O.1, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC','rmsea.ci.upper'))
summary(f.O.1)



### M1 - combinded, 3 oblique factors 
m.M.1 <-'
D =~ Dominant + Outspoken + Assertive + Forceful + Selfconfident
E =~ Lively + Friendly + Active + Talkative + Outgoing
O =~ Creative + Imaginative + Curious + Broadminded + Sophisticated + Intelligent + Adventurous

'

f.M.1 = cfa(m.M.1, midus2,
              estimator="WLSMV"
              , ordered=TRUE
)

fitMeasures(f.M.1, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC','rmsea.ci.upper'))
#summary(f.DEO.1)


### M2 - only O and E
m.M.2 <-'
E =~ Lively + Friendly + Active + Talkative + Outgoing + Dominant + Outspoken + Assertive + Forceful + Selfconfident
O =~ Creative + Imaginative + Curious + Broadminded + Sophisticated + Intelligent + Adventurous

'

f.M.2 = cfa(m.M.2, midus2,
            estimator="WLSMV"
            , ordered=TRUE
)

fitMeasures(f.M.2, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC','rmsea.ci.upper'))
#summary(f.DEO.2)


### M3 - second order Beta
m.M.3 <-'
D =~ Dominant + Outspoken + Assertive + Forceful + Selfconfident
E =~ Lively + Friendly + Active + Talkative + Outgoing
O =~ Creative + Imaginative + Curious + Broadminded + Sophisticated + Intelligent + Adventurous
B =~ E + D + O
'

f.M.3 = cfa(m.M.3, midus2,
            estimator="WLSMV"
            , ordered=TRUE
)

fitMeasures(f.M.3, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC','rmsea.ci.upper'))


### M4 - bifactor Beta
m.M.4 <-'
D =~ Dominant + Outspoken + Assertive + Forceful + Selfconfident
E =~ Lively + Friendly + Active + Talkative + Outgoing
O =~ Creative + Imaginative + Curious + Broadminded + Sophisticated + Intelligent + Adventurous
B =~ Dominant + Outspoken + Assertive + Forceful + Selfconfident + Lively + Friendly + Active + Talkative + Outgoing + Creative + Imaginative + Curious + Broadminded + Sophisticated + Intelligent + Adventurous
D ~~ 0*E
O ~~ 0*E
O ~~ 0*D
B ~~ 0*E
B ~~ 0*D
B ~~ 0*O

'

f.M.4 = cfa(m.M.4, midus2,
            estimator="WLSMV"
            , ordered=TRUE
)

fitMeasures(f.M.4, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC','rmsea.ci.upper'))
summary(f.M.4)


### M5 - second order Beta-of-extraversion
m.M.5 <-'
D =~ Dominant + Outspoken + Assertive + Forceful + Selfconfident
E =~ Lively + Friendly + Active + Talkative + Outgoing
O =~ Creative + Imaginative + Curious + Broadminded + Sophisticated + Intelligent + Adventurous
Be =~ E + D
'

f.M.5 = cfa(m.M.5, midus2,
            estimator="WLSMV"
            , ordered=TRUE
)


### M6 - bifactor Beta-of-extraversion
m.M.6 <-'
D =~ Dominant + Outspoken + Assertive + Forceful + Selfconfident
E =~ Lively + Friendly + Active + Talkative + Outgoing
O =~ Creative + Imaginative + Curious + Broadminded + Sophisticated + Intelligent + Adventurous
Be =~ Dominant + Outspoken + Assertive + Forceful + Selfconfident + Lively + Friendly + Active + Talkative + Outgoing
D ~~ 0*E
Be ~~ 0*E
Be ~~ 0*D

'

f.M.6 = cfa(m.M.6, midus2,
            estimator="WLSMV"
            , ordered=TRUE
)


## Fit
fitMeasures(f.M.1, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC','rmsea.ci.upper'))
fitMeasures(f.M.2, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC','rmsea.ci.upper'))
fitMeasures(f.M.3, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC','rmsea.ci.upper'))
fitMeasures(f.M.4, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC','rmsea.ci.upper')) #***
fitMeasures(f.M.5, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC','rmsea.ci.upper'))
fitMeasures(f.M.6, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC','rmsea.ci.upper'))
