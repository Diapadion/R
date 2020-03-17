library(data.table)
library(psych)
library(lavaan)



df1 = read.csv("./Suessenbach et al data/sample1.csv")
df1 = as.data.table(df1)

df2 = read.csv("./Suessenbach et al data/sample2.csv")
df2 = as.data.table(df2)




nfactors(df1[,c(1:85)]) # Felix's (?) scales only
fa.parallel(df1[,c(1:85)])



nfactors(df1[,c(1:153)]) # Everything thru Altruism
fa.parallel(df1[,c(1:153)]) # Felix's (?) scales only




### following Script_Study1 CFA.R ###



m.Hierarch <- '
Pres =~ X26 + X30 + X45 + X69 + X77 + X23
Dom  =~ X13 + X20 + X32 + X33 + X54 + X16
Lead =~ X5 + X25 + X34 + X47 + X50 + X58

General =~ Dom + Pres + Lead


'


cfaHierarch <- cfa(m.Hierarch, data=datpow2, )

fitMeasures(cfaHierarch, c("chisq", "df", "pvalue", "cfi", "rmsea", 'srmr'))
summary(cfaHierarch, fit.measures = TRUE)
semPaths(cfaHierarch, what="par") 




m.Bi2 <- '
Dom  =~ X13 + X3 + X10 + X16 + X20 + X32 + X33 + X42 + X54 + X71
Pres =~ X26 + X6 + X17 + X19 + X23 + X30 + X39 + X45 + X69 + X77
Lead =~ X5 + X8 + X25 + X34 + X36 + X47 + X50 + X56 + X58 + X66

General =~ X13 + X3 + X10 + X16 + X20 + X32 + X33 + X42 + X54 + X71 + X26 + X6 + X17 + X19 + X23 + X30 + X39 + X45 + X69 + X77 + X5 + X8 + X25 + X34 + X36 + X47 + X50 + X56 + X58 + X66

Dom ~~ 0*Pres
Dom ~~ 0*Lead
Dom ~~ 0*General

Pres ~~ 0*Lead
Pres ~~ 0*General

Lead ~~ 0*General

'


cfaBi2 <- cfa(m.Bi2, data=datpow2, )

fitMeasures(cfaBi2, c("chisq", "df", "pvalue", "cfi", "rmsea", 'srmr'))
summary(cfaBi2, fit.measures = TRUE)
semPaths(cfaBi2, what="par") 




###

library(relaimpo)

lm.test.aggr = lm(v.agression ~ dominance6 + prestige6 + leadership6 + BFI_A + gender, data=df1)
calc.relimp(lm.test.aggr, rela=TRUE)



lm.test.anger= lm(anger ~ dominance6 + prestige6 + leadership6 + BFI_A + gender, data=df1)
calc.relimp(lm.test.anger, rela=TRUE)

