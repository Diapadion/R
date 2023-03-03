### External validity testing

library(lavaan)



AEOvars = c('Selfconfident','Forceful','Assertive','Outspoken','Dominant',
            'Creative','Imaginative','Intelligent','Curious','Broadminded',
            'Sophisticated','Adventurous',
            'Outgoing','Friendly','Lively','Active','Talkative'
)


AEOIvars = c('I8','I68','I188','I128','I153','I183', # Openness
             'I203','I23','I83','I113','I293', # Intellect
             'I12','I162','I72','I282', # Assertiveness
             'I2','I57','I32','I272','I152' # Enthusiasm
)



### Age

m.DEO.age.1 <-'
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

f.DEO.age.1 = cfa(m.DEO.age.1, midus2,
              estimator="WLSMV" #, missing='fiml'
              #, optim.method='L-BFGS-B', check.gradient = FALSE
              , ordered=c('Dominant','Outspoken','Assertive','Forceful','Selfconfident',
                          'Lively','Friendly','Active','Talkative','Outgoing',
                          'Creative','Imaginative','Curious','Broadminded','Sophisticated',
                          'Intelligent','Adventurous')
                
)

fitMeasures(f.DEO.age.1, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC','rmsea.ci.upper'))
summary(f.DEO.age.1)


m.AEOI.age.1 <- '
O =~ I8 + I68 + I188 + I128 + I153 + I183
I =~ I203 + I23 + I83 + I113 + I293
A =~ I12 + I162 + I72 + I282 
E =~ I2 + I57 + I32 + I272 + I152
Bo =~ I8 + I68 + I188 + I128 + I153 + I183 +I203 + I23 + I83 + I113 + I293 
Be =~ I12 + I162 + I72 + I282 + I2 + I57 + I32 + I272 + I152
O ~~ 0*I
O ~~ 0*Bo
A ~~ 0*E
A ~~ 0*Be
E ~~ 0*Be
I ~~ 0*Bo

A ~~ AGE
E ~~ AGE
O ~~ AGE
I ~~ AGE

'


f.AEOI.age.1 = cfa(m.AEOI.age.1, data=ipip, estimator="WLSMV", 
                   ordered=AEOIvars
                   #, optim.method='L-BFGS-B', check.gradient = FALSE
                   )

fitMeasures(f.AEOI.age.1, fit.measures = c('chisq','df','SRMR','CFI'))
summary(f.AEOI.age.1)


### Sex
m.DEO.sex.1 <-'
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

f.DEO.sex.1 = cfa(m.DEO.sex.2, midus2,
                   estimator="WLSMV" #, missing='fiml'
                   #, optim.method='L-BFGS-B', check.gradient = FALSE
                   , ordered=AEOvars
)

fitMeasures(f.DEO.sex.1, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC','rmsea.ci.upper'))
summary(f.DEO.sex.1)


m.AEOI.sex.1 <- '
O =~ I8 + I68 + I188 + I128 + I153 + I183
I =~ I203 + I23 + I83 + I113 + I293
A =~ I12 + I162 + I72 + I282 
E =~ I2 + I57 + I32 + I272 + I152
Bo =~ I8 + I68 + I188 + I128 + I153 + I183 +I203 + I23 + I83 + I113 + I293 
Be =~ I12 + I162 + I72 + I282 + I2 + I57 + I32 + I272 + I152
O ~~ 0*I
O ~~ 0*Bo
A ~~ 0*E
A ~~ 0*Be
E ~~ 0*Be
I ~~ 0*Bo

A ~ SEX
E ~ SEX
O ~ SEX
I ~ SEX

'


f.AEOI.sex.1 = cfa(m.AEOI.sex.1, data=ipip, estimator="WLSMV", 
                   ordered=AEOIvars
                   #, optim.method='L-BFGS-B', check.gradient = FALSE
)

fitMeasures(f.AEOI.sex.1, fit.measures = c('chisq','df','SRMR','CFI'))
summary(f.AEOI.sex.1)


### Affect

m.DEO.affect.1 <-'
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

D ~~ positive_affect # low numbers are high PA
E ~~ positive_affect
O ~~ positive_affect
'


f.DEO.affect.1 = cfa(m.DEO.affect.1, midus2,
                  estimator="WLSMV"
                  , ordered=AEOvars
)

fitMeasures(f.DEO.affect.1, fit.measures = c('chisq','df','SRMR','CFI'))
summary(f.DEO.affect.1)


m.DEO.affect.2 <-'
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

D ~~ negative_affect # low values are high NA
E ~~ negative_affect
O ~~ negative_affect
'

f.DEO.affect.2= cfa(m.DEO.affect.2, midus2,
                     estimator="WLSMV"
                     , ordered=AEOvars
)

fitMeasures(f.DEO.affect.2, fit.measures = c('chisq','df','SRMR','CFI'))
summary(f.DEO.affect.2)




### Subjective psychological well-being

m.DEO.spwb.1 <-'
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
'

f.DEO.spwb.1 = cfa(m.DEO.spwb.1, midus2,
              estimator="WLSMV"
              ,ordered=c('Dominant','Outspoken','Assertive','Forceful','Selfconfident',
                                  'Lively','Friendly','Active','Talkative','Outgoing',
                                  'Creative','Imaginative','Curious','Broadminded','Sophisticated',
                                  'Intelligent','Adventurous')
)

fitMeasures(f.DEO.spwb.1, fit.measures = c('chisq','df','RMSEA','SRMR','CFI','TLI','AIC','BIC','rmsea.ci.upper'))
summary(f.DEO.spwb.1)


m.DEO.spwb.2 <- '
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
'




### Sense of Control

m.DEO.soc.1 <- '
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
'

f.DEO.soc.1 = cfa(m.DEO.soc.1, midus2,
                   estimator="WLSMV"
                   ,ordered=c('Dominant','Outspoken','Assertive','Forceful','Selfconfident',
                              'Lively','Friendly','Active','Talkative','Outgoing',
                              'Creative','Imaginative','Curious','Broadminded','Sophisticated',
                              'Intelligent','Adventurous')
)

fitMeasures(f.DEO.soc.1, fit.measures = c('chisq','df','SRMR','CFI'))
summary(f.DEO.soc.1)


m.DEO.soc.2 <- '
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

D ~~ SoC_Constraints 
E ~~ SoC_Constraints
O ~~ SoC_Constraints
'

f.DEO.soc.2 = cfa(m.DEO.soc.2, midus2,
                   estimator="WLSMV"
                   ,ordered=c('Dominant','Outspoken','Assertive','Forceful','Selfconfident',
                              'Lively','Friendly','Active','Talkative','Outgoing',
                              'Creative','Imaginative','Curious','Broadminded','Sophisticated',
                              'Intelligent','Adventurous')
)

fitMeasures(f.DEO.soc.2, fit.measures = c('chisq','df','SRMR','CFI'))
summary(f.DEO.soc.2)



### Anger

m.DEO.anger.1 <- '
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


### Exective functions

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


### Religiosity & spirituality

m.DEO.relig.1 <- '
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

D ~~ spirituality
E ~~ spirituality
O ~~ spirituality
'

f.DEO.relig.1 = cfa(m.DEO.relig.1, midus2,
                   estimator="WLSMV"
                   ,ordered=c('Dominant','Outspoken','Assertive','Forceful','Selfconfident',
                              'Lively','Friendly','Active','Talkative','Outgoing',
                              'Creative','Imaginative','Curious','Broadminded','Sophisticated',
                              'Intelligent','Adventurous')
)
fitMeasures(f.DEO.relig.1, fit.measures = c('chisq','df','SRMR','CFI'))
summary(f.DEO.relig.1)


m.DEO.relig.2 <- '
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

D ~~ religiosity
E ~~ religiosity
O ~~ religiosity
'

f.DEO.relig.2 = cfa(m.DEO.relig.2, midus2,
                    estimator="WLSMV"
                    ,ordered=c('Dominant','Outspoken','Assertive','Forceful','Selfconfident',
                               'Lively','Friendly','Active','Talkative','Outgoing',
                               'Creative','Imaginative','Curious','Broadminded','Sophisticated',
                               'Intelligent','Adventurous')
)
fitMeasures(f.DEO.relig.2, fit.measures = c('chisq','df','SRMR','CFI'))
summary(f.DEO.relig.2)



m.DEO.relig.3 <- '
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

D ~~ religious_coping
E ~~ religious_coping
O ~~ religious_coping
'

f.DEO.relig.3 = cfa(m.DEO.relig.3, midus2,
                    estimator="WLSMV"
                    ,ordered=c('Dominant','Outspoken','Assertive','Forceful','Selfconfident',
                               'Lively','Friendly','Active','Talkative','Outgoing',
                               'Creative','Imaginative','Curious','Broadminded','Sophisticated',
                               'Intelligent','Adventurous')
)
fitMeasures(f.DEO.relig.3, fit.measures = c('chisq','df','SRMR','CFI'))
summary(f.DEO.relig.3)



### Relationship Satisfaction

m.DEO.rs.1 <- '
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

D ~~ marital_risk 
E ~~ marital_risk
O ~~ marital_risk
'

f.DEO.rs.1 = cfa(m.DEO.rs.1, midus2,
                   estimator="WLSMV"
                   ,ordered=c('Dominant','Outspoken','Assertive','Forceful','Selfconfident',
                              'Lively','Friendly','Active','Talkative','Outgoing',
                              'Creative','Imaginative','Curious','Broadminded','Sophisticated',
                              'Intelligent','Adventurous')
)
fitMeasures(f.DEO.rs.1, fit.measures = c('chisq','df','SRMR','CFI'))
summary(f.DEO.rs.1)


m.DEO.rs.2 <- '
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

D ~~ sp_disagreement
E ~~ sp_disagreement
O ~~ sp_disagreement
'

f.DEO.rs.2 = cfa(m.DEO.rs.2, midus2,
                 estimator="WLSMV"
                 ,ordered=c('Dominant','Outspoken','Assertive','Forceful','Selfconfident',
                            'Lively','Friendly','Active','Talkative','Outgoing',
                            'Creative','Imaginative','Curious','Broadminded','Sophisticated',
                            'Intelligent','Adventurous')
)
fitMeasures(f.DEO.rs.2, fit.measures = c('chisq','df','SRMR','CFI'))
summary(f.DEO.rs.2)


m.DEO.rs.3 <- '
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

D ~~ support_from_sp
E ~~ support_from_sp
O ~~ support_from_sp
'

f.DEO.rs.3 = cfa(m.DEO.rs.3, midus2,
                 estimator="WLSMV"
                 ,ordered=c('Dominant','Outspoken','Assertive','Forceful','Selfconfident',
                            'Lively','Friendly','Active','Talkative','Outgoing',
                            'Creative','Imaginative','Curious','Broadminded','Sophisticated',
                            'Intelligent','Adventurous')
)
fitMeasures(f.DEO.rs.3, fit.measures = c('chisq','df','SRMR','CFI'))
summary(f.DEO.rs.3)


m.DEO.rs.4 <- '
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

D ~~ strain_from_sp
E ~~ strain_from_sp
O ~~ strain_from_sp
'

f.DEO.rs.4 = cfa(m.DEO.rs.4, midus2,
                 estimator="WLSMV"
                 ,ordered=c('Dominant','Outspoken','Assertive','Forceful','Selfconfident',
                            'Lively','Friendly','Active','Talkative','Outgoing',
                            'Creative','Imaginative','Curious','Broadminded','Sophisticated',
                            'Intelligent','Adventurous')
)
fitMeasures(f.DEO.rs.4, fit.measures = c('chisq','df','SRMR','CFI'))
summary(f.DEO.rs.4)


m.DEO.rs.5 <- '
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

D ~~ affectual_solidarity
E ~~ affectual_solidarity
O ~~ affectual_solidarity
'

f.DEO.rs.5 = cfa(m.DEO.rs.5, midus2,
                 estimator="WLSMV"
                 ,ordered=c('Dominant','Outspoken','Assertive','Forceful','Selfconfident',
                            'Lively','Friendly','Active','Talkative','Outgoing',
                            'Creative','Imaginative','Curious','Broadminded','Sophisticated',
                            'Intelligent','Adventurous')
)
fitMeasures(f.DEO.rs.5, fit.measures = c('chisq','df','SRMR','CFI'))
summary(f.DEO.rs.5)





