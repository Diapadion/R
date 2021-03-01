### Testing out a prestige factor from IPIP data


library(psych)
library(lavaan)




items = c('x110','e60','p361','p434','p421','h974','x247','h2043','h1086','h1193','p436','h1203','h204','p410','p401','h743','h746')

table(complete.cases(df.ipip[,items]))


nfactors(df.ipip[,items])
fa.parallel(df.ipip[,items])
temp = fa(df.ipip[,items], nfactors=3, rotate = 'oblimin')
print(temp)




m.prstg = '
prestige =~ h1193+x110+e60+p361+p434+p421+h974+x247+h2043+h1086+p436+h1203+h204+p410+p401+h743+h746

'

f.prstg = cfa(m.prstg, df.ipip)

fitMeasures(f.prstg, c("chisq", "df", "pvalue", "cfi", "rmsea", "srmr"))
summary(f.prstg)


## remove p361 - "Don't let others take credit for my work."
m.prstg = '
prestige =~ h1193+x110+e60+p421+p434+h974+x247+h2043+h1086+p436+h1203+h204+p410+p401+h743+h746

'

f.prstg = cfa(m.prstg, df.ipip)

fitMeasures(f.prstg, c("chisq", "df", "pvalue", "cfi", "rmsea", "srmr"))
summary(f.prstg)


## remove p421 - "Let other people take the credit for my work."
m.prstg = '
prestige =~ h1193+x110+e60+p434+h974+x247+h2043+h1086+p436+h1203+h204+p410+p401+h743+h746

'

f.prstg = cfa(m.prstg, df.ipip)

fitMeasures(f.prstg, c("chisq", "df", "pvalue", "cfi", "rmsea", "srmr"))
summary(f.prstg)


##  remove h204 ### remove h743 - "Overestimate my achievements."
m.prstg = '
prestige =~ h1193+x110+e60+p434+h974+x247+h2043+h1086+p436+h1203+h743+p410+p401+h746

'

f.prstg = cfa(m.prstg, df.ipip)

fitMeasures(f.prstg, c("chisq", "df", "pvalue", "cfi", "rmsea", "srmr"))
summary(f.prstg)


## remove e60 - "Don't care what people think of me."
m.prstg = '
prestige =~ h1193+x110+p434+h974+x247+h2043+h1086+p436+h1203+h743+p410+p401+h746

'

f.prstg = cfa(m.prstg, df.ipip)

fitMeasures(f.prstg, c("chisq", "df", "pvalue", "cfi", "rmsea", "srmr"))
summary(f.prstg)


## remove p410   ### remove h204 - "Want to mean something to others."
m.prstg = '
prestige =~ h1193+x110+p434+h974+x247+h2043+h1086+p436+h1203+p401+h746

'

f.prstg = cfa(m.prstg, df.ipip)

fitMeasures(f.prstg, c("chisq", "df", "pvalue", "cfi", "rmsea", "srmr"))
summary(f.prstg)


## remove h974   
m.prstg = '
prestige =~ h1193+x110+p434+x247+h2043+h1086+p436+h1203+p401+h746

'

f.prstg = cfa(m.prstg, df.ipip)

fitMeasures(f.prstg, c("chisq", "df", "pvalue", "cfi", "rmsea", "srmr"))
summary(f.prstg)


## remove x247 - "Seldom toot my own horn."
m.prstg = '
prestige =~ h1193+x110+p434+h2043+h1086+p436+h1203+p401+h746

'

f.prstg = cfa(m.prstg, df.ipip)

fitMeasures(f.prstg, c("chisq", "df", "pvalue", "cfi", "rmsea", "srmr"))
summary(f.prstg)


## remove p436
m.prstg = '
prestige =~ h1193+x110+p434+h2043+h1086+h1203+p401+h746

'

f.prstg = cfa(m.prstg, df.ipip)

fitMeasures(f.prstg, c("chisq", "df", "pvalue", "cfi", "rmsea", "srmr"))
summary(f.prstg)


## remove x110
m.prstg = '
prestige =~ h1193+p434+h2043+h1086+h1203+p401+h746

'

f.prstg = cfa(m.prstg, df.ipip)

fitMeasures(f.prstg, c("chisq", "df", "pvalue", "cfi", "rmsea", "srmr"))
summary(f.prstg)


## remove h2043
m.prstg = '
prestige =~ h1193+p434+h1086+h1203+p401+h746

'

f.prstg = cfa(m.prstg, df.ipip)

fitMeasures(f.prstg, c("chisq", "df", "pvalue", "cfi", "rmsea", "srmr"))
summary(f.prstg)




omega(df.ipip[,c('h1193','p434','h1086','h1203','h746','p401')])




#######

## remove h974 - "Need the approval of others."
m.prstg = '
prestige =~ h1193+x110+p434+h2043+h1086+p436+h1203

'

f.prstg = cfa(m.prstg, df.ipip)

fitMeasures(f.prstg, c("chisq", "df", "pvalue", "cfi", "rmsea", "srmr"))
summary(f.prstg)


## remove p436 - "Want to amount to something special in others' eyes."
m.prstg = '
prestige =~ h1193+x110+p434+h2043+h1086+h1203

'

f.prstg = cfa(m.prstg, df.ipip)

fitMeasures(f.prstg, c("chisq", "df", "pvalue", "cfi", "rmsea", "srmr"))
summary(f.prstg)


## remove h2043 - "Think highly of myself."
m.prstg = '
prestige =~ h1193+x110+p434+h1086+h1203

'

f.prstg = cfa(m.prstg, df.ipip)

fitMeasures(f.prstg, c("chisq", "df", "pvalue", "cfi", "rmsea", "srmr"))
summary(f.prstg)


## remove x110 - "Am not highly motivated to succeed."
m.prstg = '
prestige =~ h1193+h1086+h1203+h746+p434

'

f.prstg = cfa(m.prstg, df.ipip)

fitMeasures(f.prstg, c("chisq", "df", "pvalue", "cfi", "rmsea", "srmr"))
summary(f.prstg)



### ...
m.prstg = '
prestige =~ h1193+p434+h1086+h1203+h746+p401

'

f.prstg = cfa(m.prstg, df.ipip)

fitMeasures(f.prstg, c("chisq", "df", "pvalue", "cfi", "rmsea", "srmr"))
summary(f.prstg)





###

m.prstg = '
prestige =~ p434+p401+p410+p436
'


f.prstg = cfa(m.prstg, df.ipip)

fitMeasures(f.prstg, c("chisq", "df", "pvalue", "cfi", "rmsea", "srmr"))
summary(f.prstg)



m.2prstg = '
p1 =~ p401+p436+p434+p410
p2 =~ h1086+h1203+h746+h1193
'


f.2prstg = cfa(m.2prstg, df.ipip)

fitMeasures(f.2prstg, c("chisq", "df", "pvalue", "cfi", "rmsea", "srmr"))
summary(f.2prstg)



omega(df.ipip[,c('h1193','p434','h1086','h1203','h746','p401','p410','p436')])

omega(df.ipip[,c('h1193','p434','h1086','h1203','h746','p401')])