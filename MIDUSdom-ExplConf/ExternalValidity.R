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
              , ordered=AEOvars
              )

fitMeasures(f.DEO.age.1, fit.measures = c('chisq','df','SRMR','CFI'))
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

fitMeasures(f.DEO.sex.1, fit.measures = c('chisq','df','SRMR','CFI'))
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
ssol = standardizedSolution(f.DEO.affect.1)
ssol[ssol$op=='~~',] # show standardized correlations only


m.DEO.affect.1a <-'
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

positive_affect ~ D + E + O + Age + Sex
'

f.DEO.affect.1a = cfa(m.DEO.affect.1a, midus2,
                     estimator="WLSMV"
                     , ordered=AEOvars
)
fitMeasures(f.DEO.affect.1a, fit.measures = c('chisq','df','SRMR','CFI'))
ssol = standardizedSolution(f.DEO.affect.1a)
ssol[ssol$op=='~',] # show standardized regressions only


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
ssol = standardizedSolution(f.DEO.affect.2)
ssol[ssol$op=='~~',] # show standardized correlations only


m.DEO.affect.2a <-'
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

negative_affect ~ D + E + O + Age + Sex
'

f.DEO.affect.2a = cfa(m.DEO.affect.2a, midus2,
                    estimator="WLSMV"
                    , ordered=AEOvars
)

fitMeasures(f.DEO.affect.2a, fit.measures = c('chisq','df','SRMR','CFI'))
ssol = standardizedSolution(f.DEO.affect.2a)
ssol[ssol$op=='~',] # show standardized regressions only


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
              , ordered=AEOvars
)
fitMeasures(f.DEO.spwb.1, fit.measures = c('chisq','df','SRMR','CFI'))
ssol = standardizedSolution(f.DEO.spwb.1)
ssol[ssol$op=='~~',] # show standardized correlations only


m.DEO.spwb.1a <-'
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

autonomy ~ D + E + O + Age + Sex
'

f.DEO.spwb.1a = cfa(m.DEO.spwb.1a, midus2,
                   estimator="WLSMV"
                   , ordered=AEOvars
)
fitMeasures(f.DEO.spwb.1a, fit.measures = c('chisq','df','SRMR','CFI'))
ssol = standardizedSolution(f.DEO.spwb.1a)
ssol[ssol$op=='~',] # show standardized regressions only


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
'

f.DEO.spwb.2 = cfa(m.DEO.spwb.2, midus2,
                   estimator="WLSMV"
                   , ordered=AEOvars
)
fitMeasures(f.DEO.spwb.2, fit.measures = c('chisq','df','SRMR','CFI'))
summary(f.DEO.spwb.2)
ssol = standardizedSolution(f.DEO.spwb.2)
ssol[ssol$op=='~~',] # show standardized correlations only


m.DEO.spwb.2a <-'
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

environmental_mastery ~ D + E + O + Age + Sex
'

f.DEO.spwb.2a = cfa(m.DEO.spwb.2a, midus2,
                   estimator="WLSMV"
                   , ordered=AEOvars
)
fitMeasures(f.DEO.spwb.2a, fit.measures = c('chisq','df','SRMR','CFI'))
ssol = standardizedSolution(f.DEO.spwb.2a)
ssol[ssol$op=='~',] # show standardized regressions only


m.DEO.spwb.3 <-'
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

D ~~ personal_growth
E ~~ personal_growth
O ~~ personal_growth
'

f.DEO.spwb.3 = cfa(m.DEO.spwb.3, midus2,
                   estimator="WLSMV"
                   , ordered=AEOvars
)
fitMeasures(f.DEO.spwb.3, fit.measures = c('chisq','df','SRMR','CFI'))
ssol = standardizedSolution(f.DEO.spwb.3)
ssol[ssol$op=='~~',] # show standardized correlations only


m.DEO.spwb.3a <-'
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

personal_growth ~ D + E + O + Age + Sex
'

f.DEO.spwb.3a = cfa(m.DEO.spwb.3a, midus2,
                   estimator="WLSMV"
                   , ordered=AEOvars
)
fitMeasures(f.DEO.spwb.3a, fit.measures = c('chisq','df','SRMR','CFI'))
ssol = standardizedSolution(f.DEO.spwb.3a)
ssol[ssol$op=='~',] # show standardized regressions only


m.DEO.spwb.4 <-'
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

D ~~ affectual_relations
E ~~ affectual_relations
O ~~ affectual_relations
'

f.DEO.spwb.4 = cfa(m.DEO.spwb.4, midus2,
                   estimator="WLSMV"
                   , ordered=AEOvars
)
fitMeasures(f.DEO.spwb.4, fit.measures = c('chisq','df','SRMR','CFI'))
ssol = standardizedSolution(f.DEO.spwb.4)
ssol[ssol$op=='~~',] # show standardized correlations only


m.DEO.spwb.4a <-'
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

affectual_relations ~ D + E + O + Age + Sex
'

f.DEO.spwb.4a = cfa(m.DEO.spwb.4a, midus2,
                   estimator="WLSMV"
                   , ordered=AEOvars
)
fitMeasures(f.DEO.spwb.4a, fit.measures = c('chisq','df','SRMR','CFI'))
ssol = standardizedSolution(f.DEO.spwb.4a)
ssol[ssol$op=='~',] # show standardized regressions only


m.DEO.spwb.5 <-'
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

D ~~ purpose_in_life
E ~~ purpose_in_life
O ~~ purpose_in_life
'

f.DEO.spwb.5 = cfa(m.DEO.spwb.5, midus2,
                   estimator="WLSMV"
                   , ordered=AEOvars
)
fitMeasures(f.DEO.spwb.5, fit.measures = c('chisq','df','SRMR','CFI'))
ssol = standardizedSolution(f.DEO.spwb.5)
ssol[ssol$op=='~~',] # show standardized correlations only


m.DEO.spwb.5a <-'
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

purpose_in_life ~ D + E + O + Age + Sex
'

f.DEO.spwb.5a = cfa(m.DEO.spwb.5a, midus2,
                   estimator="WLSMV"
                   , ordered=AEOvars
)
fitMeasures(f.DEO.spwb.5a, fit.measures = c('chisq','df','SRMR','CFI'))
ssol = standardizedSolution(f.DEO.spwb.5a)
ssol[ssol$op=='~',] # show standardized regressions only


m.DEO.spwb.6 <-'
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

D ~~ self_acceptance
E ~~ self_acceptance
O ~~ self_acceptance
'

f.DEO.spwb.6 = cfa(m.DEO.spwb.6, midus2,
                   estimator="WLSMV"
                   , ordered=AEOvars
)
fitMeasures(f.DEO.spwb.6, fit.measures = c('chisq','df','SRMR','CFI'))
ssol = standardizedSolution(f.DEO.spwb.6)
ssol[ssol$op=='~~',] # show standardized correlations only


m.DEO.spwb.6a <-'
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

self_acceptance ~ D + E + O + Age + Sex
'

f.DEO.spwb.6a = cfa(m.DEO.spwb.6a, midus2,
                   estimator="WLSMV"
                   , ordered=AEOvars
)
fitMeasures(f.DEO.spwb.6a, fit.measures = c('chisq','df','SRMR','CFI'))
ssol = standardizedSolution(f.DEO.spwb.6a)
ssol[ssol$op=='~',] # show standardized regressions only



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
                   ,ordered=AEOvars
)
fitMeasures(f.DEO.soc.1, fit.measures = c('chisq','df','SRMR','CFI'))
ssol = standardizedSolution(f.DEO.soc.1)
ssol[ssol$op=='~~',] # show standardized correlations only


m.DEO.soc.1a <-'
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

SoC_Mastery ~ D + E + O + Age + Sex
'

f.DEO.soc.1a = cfa(m.DEO.soc.1a, midus2,
                   estimator="WLSMV"
                   , ordered=AEOvars
)
fitMeasures(f.DEO.soc.1a, fit.measures = c('chisq','df','SRMR','CFI'))
ssol = standardizedSolution(f.DEO.soc.1a)
ssol[ssol$op=='~',] # show standardized regressions only


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
                   ,ordered=AEOvars
)
fitMeasures(f.DEO.soc.2, fit.measures = c('chisq','df','SRMR','CFI'))
ssol = standardizedSolution(f.DEO.soc.2)
ssol[ssol$op=='~~',] # show standardized correlations only



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
'

f.DEO.anger.1 = cfa(m.DEO.anger.1, midus2,
                   estimator="WLSMV"
                   ,ordered=AEOvars
)
fitMeasures(f.DEO.anger.1, fit.measures = c('chisq','df','SRMR','CFI'))
summary(f.DEO.anger.1, standardize=TRUE)


m.DEO.anger.2 <- '
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

D ~~ anger_out
E ~~ anger_out
O ~~ anger_out
'

f.DEO.anger.2 = cfa(m.DEO.anger.2, midus2,
                    estimator="WLSMV"
                    ,ordered=AEOvars
)
fitMeasures(f.DEO.anger.2, fit.measures = c('chisq','df','SRMR','CFI'))
summary(f.DEO.anger.2, standardize=TRUE)


m.DEO.anger.3 <- '
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

D ~~ anger_control
E ~~ anger_control
O ~~ anger_control
'

f.DEO.anger.3 = cfa(m.DEO.anger.3, midus2,
                    estimator="WLSMV"
                    ,ordered=AEOvars
)
fitMeasures(f.DEO.anger.3, fit.measures = c('chisq','df','SRMR','CFI'))
summary(f.DEO.anger.3, standardize=TRUE)



### Exective functions
m.DEO.ef.1 <- '
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

D ~~ executive_function
E ~~ executive_function
O ~~ executive_function
'

f.DEO.ef.1 = cfa(m.DEO.ef.1, midus2,
                   estimator="WLSMV" #, missing='fiml'
                   ,ordered=AEOvars
)
fitMeasures(f.DEO.ef.1, fit.measures = c('chisq','df','SRMR','CFI'))
summary(f.DEO.ef.1, standardize=TRUE)


m.DEO.ef.2 <- '
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
'

f.DEO.ef.2 = cfa(m.DEO.ef.2, midus2,
                 estimator="WLSMV" #, missing='fiml'
                 ,ordered=AEOvars
)
fitMeasures(f.DEO.ef.2, fit.measures = c('chisq','df','SRMR','CFI'))
summary(f.DEO.ef.2, standardize=TRUE)



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
                   ,ordered=AEOvars
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
                    ,ordered=AEOvars
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
                    ,ordered=AEOvars
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
                   ,ordered=AEOvars
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
                 ,ordered=AEOvars
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
                 ,ordered=AEOvars
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
                 ,ordered=AEOvars
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
                 ,ordered=AEOvars
)
fitMeasures(f.DEO.rs.5, fit.measures = c('chisq','df','SRMR','CFI'))
summary(f.DEO.rs.5)





