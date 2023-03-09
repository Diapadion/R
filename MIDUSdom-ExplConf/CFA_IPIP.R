### IPIP CFAs


library(lavaan)

options(max.print=10000)



### Initial single factor models
m.Ast.1 <- '
A =~ I12 + # Take charge. (BFI)
I162 + # Wait for others to lead the way. (BFI)
I72 + # Can talk others into doing things. (BFI)
I282 #+ # Hold back my opinions. (BFI)

'

f.Ast.1 = cfa(m.Ast.1, data=ipip, estimator="WLSMV", ordered=TRUE)

fitMeasures(f.Ast.1, fit.measures = c('chisq','df','SRMR','CFI'))



m.Ent.1 <- '
E =~ I2 + I57 + I32 + I272 + I152
'

f.Ent.1 = cfa(m.Ent.1, data=ipip, estimator="WLSMV", ordered=TRUE)

fitMeasures(f.Ent.1, fit.measures = c('chisq','df','SRMR','CFI'))


m.Opn.1 <- '
O =~ I8 + I68 + I188 + I128 + I153 + I183 #+ I243
' # best way to improve unacceptable fit was to cut I243 "Seldom get lost in thought."

f.Opn.1 = cfa(m.Opn.1, data=ipip, estimator="WLSMV", ordered=TRUE)

fitMeasures(f.Opn.1, fit.measures = c('chisq','df','SRMR','CFI'))


m.Int.1 <- '
I =~ I203 + I23 + I83 + I113 + I293
'

f.Int.1 = cfa(m.Int.1, data=ipip, estimator="WLSMV", ordered=TRUE)

fitMeasures(f.Int.1, fit.measures = c('chisq','df','SRMR','CFI'))


### M1 - combined, 4 oblique factors
m.I.1 <- '
O =~ I8 + I68 + I188 + I128 + I153 + I183
I =~ I203 + I23 + I83 + I113 + I293
A =~ I12 + I162 + I72 + I282 
E =~ I2 + I57 + I32 + I272 + I152
'

f.I.1 = cfa(m.I.1, data=ipip, estimator="WLSMV", ordered=TRUE)

fitMeasures(f.I.1, fit.measures = c('chisq','df','SRMR','CFI'))


### M2 - second order Beta
m.I.2 <- '
O =~ I8 + I68 + I188 + I128 + I153 + I183
I =~ I203 + I23 + I83 + I113 + I293
A =~ I12 + I162 + I72 + I282 
E =~ I2 + I57 + I32 + I272 + I152
B=~ E + A + I + O
'

f.I.2 = cfa(m.I.2, data=ipip, estimator="WLSMV", ordered=TRUE, optim.method='L-BFGS-B', check.gradient = FALSE)

fitMeasures(f.I.2, fit.measures = c('chisq','df','SRMR','CFI'))
#summary(f.I.2)


### M3 - bifactor Beta
m.I.3 <- '
O =~ I8 + I68 + I188 + I128 + I153 + I183
I =~ I203 + I23 + I83 + I113 + I293
A =~ I12 + I162 + I72 + I282 
E =~ I2 + I57 + I32 + I272 + I152
B =~ I8 + I68 + I188 + I128 + I153 + I183 +I203 + I23 + I83 + I113 + I293 + I12 + I162 + I72 + I282 + I2 + I57 + I32 + I272 + I152
O ~~ 0*I
O ~~ 0*A
O ~~ 0*E
O ~~ 0*B
A ~~ 0*E
A ~~ 0*I
A ~~ 0*B
E ~~ 0*I
E ~~ 0*B
I ~~ 0*B
'

f.I.3 = cfa(m.I.3, data=ipip, estimator="WLSMV", ordered=TRUE, optim.method='L-BFGS-B', check.gradient = FALSE)

fitMeasures(f.I.3, fit.measures = c('chisq','df','SRMR','CFI'))



### M4 - second order Betas (E & O)
m.I.4 <- '
O =~ I8 + I68 + I188 + I128 + I153 + I183
I =~ I203 + I23 + I83 + I113 + I293
A =~ I12 + I162 + I72 + I282 
E =~ I2 + I57 + I32 + I272 + I152
Be =~ E + A
Bo =~ O + I
'

f.I.4 = cfa(m.I.4, data=ipip, estimator="WLSMV", ordered=TRUE, optim.method='L-BFGS-B', check.gradient = FALSE)

fitMeasures(f.I.4, fit.measures = c('chisq','df','SRMR','CFI'))


### M5 - bifactor Betas (E & O)
m.I.5 <- '
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
'

f.I.5 = cfa(m.I.5, data=ipip, estimator="WLSMV", ordered=TRUE#, optim.method='L-BFGS-B', check.gradient = FALSE
            )

fitMeasures(f.I.5, fit.measures = c('chisq','df','SRMR','CFI'))
#summary(f.I.5)


### M6 - second order Beta (O)
m.I.6 <- '
O =~ I8 + I68 + I188 + I128 + I153 + I183
I =~ I203 + I23 + I83 + I113 + I293
A =~ I12 + I162 + I72 + I282 
E =~ I2 + I57 + I32 + I272 + I152
Bo =~ O + I
'

f.I.6 = cfa(m.I.6, data=ipip, estimator="WLSMV", ordered=TRUE, optim.method='L-BFGS-B', check.gradient = FALSE
            )
fitMeasures(f.I.6, fit.measures = c('chisq','df','SRMR','CFI'))



### M7 - bifactor Beta (O)
m.I.7 <- '
O =~ I8 + I68 + I188 + I128 + I153 + I183
I =~ I203 + I23 + I83 + I113 + I293
A =~ I12 + I162 + I72 + I282 
E =~ I2 + I57 + I32 + I272 + I152
Bo =~ I8 + I68 + I188 + I128 + I153 + I183 +I203 + I23 + I83 + I113 + I293 
O ~~ 0*I
O ~~ 0*Bo
I ~~ 0*Bo
'

f.I.7 = cfa(m.I.7, data=ipip, estimator="WLSMV", ordered=TRUE#, optim.method='L-BFGS-B', check.gradient = FALSE
)

fitMeasures(f.I.7, fit.measures = c('chisq','df','SRMR','CFI'))
summary(f.I.7)


### note: even numbered (secord order) fits have negative variances for LVs

###
fitMeasures(f.I.1, fit.measures = c('chisq','df','SRMR','CFI'))
fitMeasures(f.I.2, fit.measures = c('chisq','df','SRMR','CFI'))
fitMeasures(f.I.3, fit.measures = c('chisq','df','SRMR','CFI'))
fitMeasures(f.I.4, fit.measures = c('chisq','df','SRMR','CFI'))
fitMeasures(f.I.5, fit.measures = c('chisq','df','SRMR','CFI')) #***
fitMeasures(f.I.6, fit.measures = c('chisq','df','SRMR','CFI'))
fitMeasures(f.I.7, fit.measures = c('chisq','df','SRMR','CFI'))

standardizedsolution(f.I.5)
