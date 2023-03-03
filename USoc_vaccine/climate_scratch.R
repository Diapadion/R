### Import for climate project

library(readstata13)
library(data.table)
library(forcats)

library(psych)

library(lavaan)





## Wave 1 - social class?
df.w1 = read.dta13("../../../../ownCloud/DocSyncUoE/data/UnderstandingSociety/stata/stata13_se/ukhls_w1/a_indresp.dta")



## Wave 4 - 
df.w4 = as.data.table(read.dta13("../../../../ownCloud/DocSyncUoE/data/UnderstandingSociety/stata/stata13_se/ukhls_w4/d_indresp.dta"))


## Wave 10 - same time as COVID
df.w10 = as.data.table(read.dta13("../../../../ownCloud/DocSyncUoE/data/UnderstandingSociety/stata/stata13_se/ukhls_w10/j_indresp.dta"))



## Merge
climate = merge(df.w1, df.w4, by.x='pidp', by.y='pidp', all=TRUE)
climate = merge(climate, df.w10, by.x='pidp', by.y='pidp', all=TRUE)


climate$d_scenv_bccc[climate$d_scenv_bccc=='missing'] <- NA
climate$d_scenv_bccc[climate$d_scenv_bccc=='inapplicable'] <- NA
climate$d_scenv_bccc[climate$d_scenv_bccc=='proxy'] <- NA
climate$d_scenv_bccc[climate$d_scenv_bccc=='refusal'] <- NA
climate$d_scenv_bccc[climate$d_scenv_bccc=='missing'] <- NA
climate$d_scenv_bccc[climate$d_scenv_bccc=='don\'t know'] <- NA
table(climate$d_scenv_bccc, useNA='ifany')
climate$w4behav = as.integer(climate$d_scenv_bccc) - 5
table(climate$w4behav) # + = disargee

climate$d_scenv_tlat[climate$d_scenv_tlat=='missing'] <- NA
climate$d_scenv_tlat[climate$d_scenv_tlat=='inapplicable'] <- NA
climate$d_scenv_tlat[climate$d_scenv_tlat=='proxy'] <- NA
climate$d_scenv_tlat[climate$d_scenv_tlat=='refusal'] <- NA
climate$d_scenv_tlat[climate$d_scenv_tlat=='missing'] <- NA
climate$d_scenv_tlat[climate$d_scenv_tlat=='don\'t know'] <- NA
table(climate$d_scenv_tlat, useNA='ifany')
climate$w4beyond = as.integer(climate$d_scenv_tlat) - 5
table(climate$w4beyond) # + = disagree

# binary
climate$d_scopecl30[climate$d_scopecl30=='missing'] <- NA
climate$d_scopecl30[climate$d_scopecl30=='inapplicable'] <- NA
climate$d_scopecl30[climate$d_scopecl30=='proxy'] <- NA
climate$d_scopecl30[climate$d_scopecl30=='refusal'] <- NA
climate$d_scopecl30[climate$d_scopecl30=='missing'] <- NA
climate$d_scopecl30[climate$d_scopecl30=='don\'t know'] <- NA
table(climate$d_scopecl30, useNA='ifany')
climate$w4scope30 = as.integer(climate$d_scopecl30) - 6
table(climate$w4scope30) # 1 = no

# binary
climate$d_scopecl200[climate$d_scopecl200=='missing'] <- NA
climate$d_scopecl200[climate$d_scopecl200=='inapplicable'] <- NA
climate$d_scopecl200[climate$d_scopecl200=='proxy'] <- NA
climate$d_scopecl200[climate$d_scopecl200=='refusal'] <- NA
climate$d_scopecl200[climate$d_scopecl200=='missing'] <- NA
climate$d_scopecl200[climate$d_scopecl200=='don\'t know'] <- NA
table(climate$d_scopecl200, useNA='ifany')
climate$w4scope200 = as.integer(climate$d_scopecl200) - 6
table(climate$w4scope200) # 1 = no

climate$d_scenv_nowo[climate$d_scenv_nowo=='missing'] <- NA
climate$d_scenv_nowo[climate$d_scenv_nowo=='inapplicable'] <- NA
climate$d_scenv_nowo[climate$d_scenv_nowo=='proxy'] <- NA
climate$d_scenv_nowo[climate$d_scenv_nowo=='refusal'] <- NA
climate$d_scenv_nowo[climate$d_scenv_nowo=='missing'] <- NA
climate$d_scenv_nowo[climate$d_scenv_nowo=='don\'t know'] <- NA
table(climate$d_scenv_nowo, useNA='ifany')
climate$w4futurefar = as.integer(climate$d_scenv_nowo) - 5
table(climate$w4futurefar) # + = disagree

clcols = c('w4beyond','w4futurefar','w4scope30'
           #,'w4scope200','w4behav'
           )


cor(climate[,clcols], use = 'pairwise')

alpha(climate[,clcols])
omega(climate[,clcols])





m.t1 <- '
cl =~ w4beyond + w4futurefar + w4behav + w4scope30 #+ w4behav

'


f.t1 = cfa(m.t1, data=climate, ordered=TRUE)

fitMeasures(f.t1, c("chisq", "df", "pvalue", "cfi", "srmr"))
summary(f.t1)
