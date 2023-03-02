### SEM scratchpad
### might be turned into something else

library(lavaan)



### ordered CFA models for D, E, O


m.D.1 <-'
D =~ Dominant + Outspoken + Assertive + Forceful + Selfconfident 
#+ like_to_lead + talk_people_into + decisions

'


f.D.1 = cfa(m.D.1, midus2,
                estimator="WLSMV" #, missing='fiml'
                , ordered=TRUE
)

fitMeasures(f.D.1, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC','rmsea.ci.upper'))
summary(f.D.1)




m.E.1 <-'
E =~ Lively + Friendly + Active + Talkative + Outgoing

'

f.E.1 = cfa(m.E.1, midus2,
            estimator="WLSMV" #, missing='fiml'
            , ordered=TRUE
)

fitMeasures(f.E.1, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC','rmsea.ci.upper'))
summary(f.E.1)



m.O.1 <-'
O =~ Creative + Imaginative + Curious + Broadminded + Sophisticated + Intelligent + Adventurous

'

f.O.1 = cfa(m.O.1, midus2,
            estimator="WLSMV" #, missing='fiml'
            , ordered=TRUE
)

fitMeasures(f.O.1, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC','rmsea.ci.upper'))
summary(f.O.1)



### Together

m.DEO.1 <-'
D =~ Dominant + Outspoken + Assertive + Forceful + Selfconfident
E =~ Lively + Friendly + Active + Talkative + Outgoing
O =~ Creative + Imaginative + Curious + Broadminded + Sophisticated + Intelligent + Adventurous

'

f.DEO.1 = cfa(m.DEO.1, midus2,
            estimator="WLSMV" #, missing='fiml'
            , ordered=TRUE
)

fitMeasures(f.DEO.1, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC','rmsea.ci.upper'))
summary(f.DEO.1)




### Correlations

m.DEO.corr.1 <-'
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

D ~~ Age
E ~~ Age
O ~~ Age

'

f.DEO.corr.1 = cfa(m.DEO.corr.1, midus2,
              estimator="WLSMV" #, missing='fiml'
              , optim.method='L-BFGS-B', check.gradient = FALSE
              , ordered=c('Dominant','Outspoken','Assertive','Forceful','Selfconfident',
                          'Lively','Friendly','Active','Talkative','Outgoing',
                          'Creative','Imaginative','Curious','Broadminded','Sophisticated',
                          'Intelligent','Adventurous')
                
)

fitMeasures(f.DEO.corr.1, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC','rmsea.ci.upper'))
summary(f.DEO.corr.1)


m.DEO.corr.2 <-'
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

D ~ Sex
E ~ Sex
O ~ Sex

'

f.DEO.corr.2 = cfa(m.DEO.corr.2, midus2,
                   estimator="WLSMV" #, missing='fiml'
                   , optim.method='L-BFGS-B', check.gradient = FALSE
                   , ordered=c('Dominant','Outspoken','Assertive','Forceful','Selfconfident',
                               'Lively','Friendly','Active','Talkative','Outgoing',
                               'Creative','Imaginative','Curious','Broadminded','Sophisticated',
                               'Intelligent','Adventurous')
                   
)

fitMeasures(f.DEO.corr.2, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC','rmsea.ci.upper'))
summary(f.DEO.corr.2)



m.DEO.corr.3 <-'
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

D ~~ autonomy
E ~~ autonomy
O ~~ autonomy

D ~~ environmental_mastery
E ~~ environmental_mastery
O ~~ environmental_mastery

D ~~ personal_growth
E ~~ personal_growth
O ~~ personal_growth

D ~~ affectual_relations
E ~~ affectual_relations
O ~~ affectual_relations

D ~~ purpose_in_life
E ~~ purpose_in_life
O ~~ purpose_in_life

D ~~ self_acceptance
E ~~ self_acceptance
O ~~ self_acceptance

# D ~~
# E ~~
# O ~~
# D ~~
# E ~~
# O ~~
# D ~~
# E ~~
# O ~~
# D ~~
# E ~~
# O ~~
# D ~~
# E ~~
# O ~~
# D ~~
# E ~~
# O ~~
# D ~~
# E ~~
# O ~~
# D ~~
# E ~~
# O ~~
# D ~~
# E ~~
# O ~~
# D ~~
# E ~~
# O ~~
# D ~~
# E ~~
# O ~~
# D ~~
# E ~~
# O ~~
# D ~~
# E ~~
# O ~~
# D ~~
# E ~~
# O ~~





'

f.DEO.corr.3 = cfa(m.DEO.corr.3, midus2,
              estimator="WLSMV" #, missing='fiml'
              ,ordered=c('Dominant','Outspoken','Assertive','Forceful','Selfconfident',
                                  'Lively','Friendly','Active','Talkative','Outgoing',
                                  'Creative','Imaginative','Curious','Broadminded','Sophisticated',
                                  'Intelligent','Adventurous')
)

fitMeasures(f.DEO.corr.3, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC','rmsea.ci.upper'))
summary(f.DEO.corr.3)




m.DEO.corr.N <- '
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

D ~~ SoC_Mastery
E ~~ SoC_Mastery
O ~~ SoC_Mastery

D ~~ SoC_Constraints 
E ~~ SoC_Constraints
O ~~ SoC_Constraints

'

f.DEO.corr.N = cfa(m.DEO.corr.N, midus2,
                   estimator="WLSMV" #, missing='fiml'
                   ,ordered=c('Dominant','Outspoken','Assertive','Forceful','Selfconfident',
                              'Lively','Friendly','Active','Talkative','Outgoing',
                              'Creative','Imaginative','Curious','Broadminded','Sophisticated',
                              'Intelligent','Adventurous')
)

fitMeasures(f.DEO.corr.N, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC','rmsea.ci.upper'))
summary(f.DEO.corr.N)



m.DEO.corr.M <- '
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

D ~~ memory
E ~~ memory
O ~~ memory

D ~~ executive_function
E ~~ executive_function
O ~~ executive_function

'

f.DEO.corr.M = cfa(m.DEO.corr.M, midus2,
                   estimator="WLSMV" #, missing='fiml'
                   ,ordered=c('Dominant','Outspoken','Assertive','Forceful','Selfconfident',
                              'Lively','Friendly','Active','Talkative','Outgoing',
                              'Creative','Imaginative','Curious','Broadminded','Sophisticated',
                              'Intelligent','Adventurous')
)

fitMeasures(f.DEO.corr.M, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC','rmsea.ci.upper'))
summary(f.DEO.corr.M)


m.DEO.corr.P <- '
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

D ~~ anger_in
E ~~ anger_in
O ~~ anger_in

D ~~ anger_out
E ~~ anger_out
O ~~ anger_out

D ~~ anger_control
E ~~ anger_control
O ~~ anger_control
'

f.DEO.corr.P = cfa(m.DEO.corr.P, midus2,
                   estimator="WLSMV" #, missing='fiml'
                   ,ordered=c('Dominant','Outspoken','Assertive','Forceful','Selfconfident',
                              'Lively','Friendly','Active','Talkative','Outgoing',
                              'Creative','Imaginative','Curious','Broadminded','Sophisticated',
                              'Intelligent','Adventurous')
)

fitMeasures(f.DEO.corr.P, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC','rmsea.ci.upper'))
summary(f.DEO.corr.P)

