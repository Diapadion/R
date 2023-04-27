#### External validity testing

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



### Descriptives
table(midus2$Sex)
table(ipip$SEX)

mean(midus2$Age, na.rm=TRUE)
sd(midus2$Age, na.rm=TRUE)

mean(ipip$AGE, na.rm=TRUE)
sd(ipip$AGE, na.rm=TRUE)



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
ssol = standardizedSolution(f.DEO.age.1)
head(ssol[ssol$op=='~~',],9) # show standardized correlations only


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
ssol = standardizedSolution(f.AEOI.age.1)
head(ssol[ssol$op=='~~',],10) # show standardized correlations only


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

f.DEO.sex.1 = cfa(m.DEO.sex.1, midus2,
                   estimator="WLSMV"
                   , ordered=AEOvars
)
fitMeasures(f.DEO.sex.1, fit.measures = c('chisq','df','SRMR','CFI'))
ssol = standardizedSolution(f.DEO.sex.1)
ssol[ssol$op=='~',] # show standardized regressions only


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
ssol = standardizedSolution(f.AEOI.sex.1)
ssol[ssol$op=='~',] # show standardized regressions only



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

D ~~ positive_affect
E ~~ positive_affect
O ~~ positive_affect
'

f.DEO.affect.1 = cfa(m.DEO.affect.1, midus2,
                  estimator="WLSMV"
                  , ordered=AEOvars
)
fitMeasures(f.DEO.affect.1, fit.measures = c('chisq','df','SRMR','CFI'))
ssol = standardizedSolution(f.DEO.affect.1)
head(ssol[ssol$op=='~~',],9) # show standardized correlations only


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

D ~~ negative_affect
E ~~ negative_affect
O ~~ negative_affect
'

f.DEO.affect.2 = cfa(m.DEO.affect.2, midus2,
                     estimator="WLSMV"
                     , ordered=AEOvars
)

fitMeasures(f.DEO.affect.2, fit.measures = c('chisq','df','SRMR','CFI'))
ssol = standardizedSolution(f.DEO.affect.2)
head(ssol[ssol$op=='~~',],9) # show standardized correlations only


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
head(ssol[ssol$op=='~~',],9) # show standardized correlations only


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
ssol = standardizedSolution(f.DEO.spwb.2)
head(ssol[ssol$op=='~~',],9) # show standardized correlations only


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
head(ssol[ssol$op=='~~',],9) # show standardized correlations only


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
head(ssol[ssol$op=='~~',],9) # show standardized correlations only


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
head(ssol[ssol$op=='~~',],9) # show standardized correlations only


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
head(ssol[ssol$op=='~~',],9) # show standardized correlations only


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
head(ssol[ssol$op=='~~',],9) # show standardized correlations only


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
head(ssol[ssol$op=='~~',],9) # show standardized correlations only


m.DEO.soc.2a <-'
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

SoC_Constraints ~ D + E + O + Age + Sex
'

f.DEO.soc.2a = cfa(m.DEO.soc.2a, midus2,
                   estimator="WLSMV"
                   , ordered=AEOvars
)
fitMeasures(f.DEO.soc.2a, fit.measures = c('chisq','df','SRMR','CFI'))
ssol = standardizedSolution(f.DEO.soc.2a)
ssol[ssol$op=='~',] # show standardized regressions only



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
ssol = standardizedSolution(f.DEO.anger.1)
head(ssol[ssol$op=='~~',],9) # show standardized correlations only


m.DEO.anger.1a <-'
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

anger_in ~ D + E + O + Age + Sex
'

f.DEO.anger.1a = cfa(m.DEO.anger.1a, midus2,
               estimator="WLSMV"
               , ordered=AEOvars
)
fitMeasures(f.DEO.anger.1a, fit.measures = c('chisq','df','SRMR','CFI'))
ssol = standardizedSolution(f.DEO.anger.1a)
ssol[ssol$op=='~',] # show standardized regressions only


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
ssol = standardizedSolution(f.DEO.anger.2)
head(ssol[ssol$op=='~~',],9) # show standardized correlations only


m.DEO.anger.2a <-'
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

anger_out ~ D + E + O + Age + Sex
'

f.DEO.anger.2a = cfa(m.DEO.anger.2a, midus2,
               estimator="WLSMV"
               , ordered=AEOvars
)
fitMeasures(f.DEO.anger.2a, fit.measures = c('chisq','df','SRMR','CFI'))
ssol = standardizedSolution(f.DEO.anger.2a)
ssol[ssol$op=='~',] # show standardized regressions only


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
ssol = standardizedSolution(f.DEO.anger.3)
head(ssol[ssol$op=='~~',],9) # show standardized correlations only


m.DEO.anger.3a <-'
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

anger_control ~ D + E + O + Age + Sex
'

f.DEO.anger.3a = cfa(m.DEO.anger.3a, midus2,
               estimator="WLSMV"
               , ordered=AEOvars
)
fitMeasures(f.DEO.anger.3a, fit.measures = c('chisq','df','SRMR','CFI'))
ssol = standardizedSolution(f.DEO.anger.3a)
ssol[ssol$op=='~',] # show standardized regressions only



### Cognitive functions
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
ssol = standardizedSolution(f.DEO.ef.1)
head(ssol[ssol$op=='~~',],9) # show standardized correlations only


m.DEO.ef.1a <-'
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

executive_function ~ D + E + O + Age + Sex
'

f.DEO.ef.1a = cfa(m.DEO.ef.1a, midus2,
               estimator="WLSMV"
               , ordered=AEOvars
)
fitMeasures(f.DEO.ef.1a, fit.measures = c('chisq','df','SRMR','CFI'))
ssol = standardizedSolution(f.DEO.ef.1a)
ssol[ssol$op=='~',] # show standardized regressions only


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
ssol = standardizedSolution(f.DEO.ef.2)
head(ssol[ssol$op=='~~',],9) # show standardized correlations only


m.DEO.ef.2a <-'
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

memory ~ D + E + O + Age + Sex
'

f.DEO.ef.2a = cfa(m.DEO.ef.2a, midus2,
               estimator="WLSMV"
               , ordered=AEOvars
)
fitMeasures(f.DEO.ef.2a, fit.measures = c('chisq','df','SRMR','CFI'))
ssol = standardizedSolution(f.DEO.ef.2a)
ssol[ssol$op=='~',] # show standardized regressions only



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
ssol = standardizedSolution(f.DEO.relig.1)
head(ssol[ssol$op=='~~',],9) # show standardized correlations only


m.DEO.relig.1a <-'
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

spirituality ~ D + E + O + Age + Sex
'

f.DEO.relig.1a = cfa(m.DEO.relig.1a, midus2,
               estimator="WLSMV"
               , ordered=AEOvars
)
fitMeasures(f.DEO.relig.1a, fit.measures = c('chisq','df','SRMR','CFI'))
ssol = standardizedSolution(f.DEO.relig.1a)
ssol[ssol$op=='~',] # show standardized regressions only


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
ssol = standardizedSolution(f.DEO.relig.2)
head(ssol[ssol$op=='~~',],9) # show standardized correlations only


m.DEO.relig.2a <-'
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

religiosity ~ D + E + O + Age + Sex
'

f.DEO.relig.2a = cfa(m.DEO.relig.2a, midus2,
               estimator="WLSMV"
               , ordered=AEOvars
)
fitMeasures(f.DEO.relig.2a, fit.measures = c('chisq','df','SRMR','CFI'))
ssol = standardizedSolution(f.DEO.relig.2a)
ssol[ssol$op=='~',] # show standardized regressions only


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
ssol = standardizedSolution(f.DEO.relig.3)
head(ssol[ssol$op=='~~',],9) # show standardized correlations only


m.DEO.relig.3a <-'
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

religious_coping ~ D + E + O + Age + Sex
'

f.DEO.relig.3a = cfa(m.DEO.relig.3a, midus2,
               estimator="WLSMV"
               , ordered=AEOvars
)
fitMeasures(f.DEO.relig.3a, fit.measures = c('chisq','df','SRMR','CFI'))
ssol = standardizedSolution(f.DEO.relig.3a)
ssol[ssol$op=='~',] # show standardized regressions only



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
ssol = standardizedSolution(f.DEO.rs.1)
head(ssol[ssol$op=='~~',],9) # show standardized correlations only
 

m.DEO.rs.1a <-'
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

marital_risk ~ D + E + O + Age + Sex
'

f.DEO.rs.1a = cfa(m.DEO.rs.1a, midus2,
               estimator="WLSMV"
               , ordered=AEOvars
)
fitMeasures(f.DEO.rs.1a, fit.measures = c('chisq','df','SRMR','CFI'))
ssol = standardizedSolution(f.DEO.rs.1a)
ssol[ssol$op=='~',] # show standardized regressions only


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
ssol = standardizedSolution(f.DEO.rs.2)
head(ssol[ssol$op=='~~',],9) # show standardized correlations only


m.DEO.rs.2a <-'
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

sp_disagreement ~ D + E + O + Age + Sex
'

f.DEO.rs.2a = cfa(m.DEO.rs.2a, midus2,
                  estimator="WLSMV"
                  , ordered=AEOvars
)
fitMeasures(f.DEO.rs.2a, fit.measures = c('chisq','df','SRMR','CFI'))
ssol = standardizedSolution(f.DEO.rs.2a)
ssol[ssol$op=='~',] # show standardized regressions only


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
ssol = standardizedSolution(f.DEO.rs.3)
head(ssol[ssol$op=='~~',],9) # show standardized correlations only


m.DEO.rs.3a <-'
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

support_from_sp ~ D + E + O + Age + Sex
'

f.DEO.rs.3a = cfa(m.DEO.rs.3a, midus2,
                  estimator="WLSMV"
                  , ordered=AEOvars
)
fitMeasures(f.DEO.rs.3a, fit.measures = c('chisq','df','SRMR','CFI'))
ssol = standardizedSolution(f.DEO.rs.3a)
ssol[ssol$op=='~',] # show standardized regressions only


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
ssol = standardizedSolution(f.DEO.rs.4)
head(ssol[ssol$op=='~~',],9) # show standardized correlations only


m.DEO.rs.4a <-'
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

strain_from_sp ~ D + E + O + Age + Sex
'

f.DEO.rs.4a = cfa(m.DEO.rs.4a, midus2,
                  estimator="WLSMV"
                  , ordered=AEOvars
)
fitMeasures(f.DEO.rs.4a, fit.measures = c('chisq','df','SRMR','CFI'))
ssol = standardizedSolution(f.DEO.rs.4a)
ssol[ssol$op=='~',] # show standardized regressions only


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
ssol = standardizedSolution(f.DEO.rs.5)
head(ssol[ssol$op=='~~',],9) # show standardized correlations only


m.DEO.rs.5a <-'
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

affectual_solidarity ~ D + E + O + Age + Sex
'

f.DEO.rs.5a = cfa(m.DEO.rs.5a, midus2,
                  estimator="WLSMV"
                  , ordered=AEOvars
)
fitMeasures(f.DEO.rs.5a, fit.measures = c('chisq','df','SRMR','CFI'))
ssol = standardizedSolution(f.DEO.rs.5a)
ssol[ssol$op=='~',] # show standardized regressions only


