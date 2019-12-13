### Multiple comparison adjustments

library(lavaan)
library(boot)
library(R2HTML)
library(xlsx)



options(scipen = 999)
options(digits=7)


### Pre-adjustment outputs

write.xlsx()





## NLSY

fitMeasures(isq.f6, c("chisq", "df", "pvalue", "cfi", "tli", "srmr", "rmsea"))

nlsy6.out = as.data.frame( unclass( parameterEstimates(isq.f6, ci=TRUE, level=0.95,boot.ci.type='perc')[,c('lhs','op','rhs','est','se','pvalue','ci.lower','ci.upper')] ) )
write.xlsx(nlsy6.out, file='NLSY-fullGCparams.xlsx')

nlsy6.out = nlsy6.out[as.character(nlsy6.out$lhs)!=as.character(nlsy6.out$rhs),]
nlsy6.out = nlsy6.out[!is.na(nlsy6.out$pvalue),]
nlsy6.out = nlsy6.out[(nlsy6.out$op=='~')|nlsy6.out$op=='~~',]
# nlsy6.out = nlsy6.out[(nlsy6.out$lhs %in% c('gslop','dbi','dbs'))|(nlsy6.out$rhs %in% c('gslop','dbi','dbs')),]
nlsy6.out = nlsy6.out[!(nlsy6.out$rhs %in% c('age_1979','age.85','age.94','age.06','age.14')),]
nlsy6.out$padj = p.adjust(nlsy6.out$pvalue, 'fdr')

is.num <- sapply(nlsy6.out, is.numeric)
nlsy6.out = cbind(nlsy6.out$lhs, nlsy6.out$op, nlsy6.out$rhs,
                  data.frame(lapply(nlsy6.out[is.num], round, 7)))
nlsy6.out
write.xlsx(nlsy6.out, file='NLSY-GCparams.xlsx')



## NCDS

fitMeasures(isq.f5, c("chisq", "df", "pvalue", "cfi", "tli", "srmr", "rmsea"))

ncds5.out = as.data.frame( unclass( parameterEstimates(isq.f5, ci=TRUE, level=0.95,boot.ci.type='perc')[,c('lhs','op','rhs','est','se','pvalue','ci.lower','ci.upper')] ) )
write.xlsx(ncds5.out, file='NCDS-fullGCparams.xlsx')

ncds5.out = ncds5.out[as.character(ncds5.out$lhs)!=as.character(ncds5.out$rhs),]
ncds5.out = ncds5.out[!is.na(ncds5.out$pvalue),]
ncds5.out = ncds5.out[ncds5.out$op=='~'|ncds5.out$op=='~~',]
# ncds5.out = ncds5.out[(ncds5.out$lhs %in% c('gslop','dbi','dbs'))|(ncds5.out$rhs %in% c('gslop','dbi','dbs')),]
ncds5.out = ncds5.out[!(ncds5.out$rhs %in% c('age_1979','age.85','age.94','age.06','age.14')),]
ncds5.out$padj = p.adjust(ncds5.out$pvalue, 'fdr')

is.num <- sapply(ncds5.out, is.numeric)
ncds5.out = cbind(ncds5.out$lhs, ncds5.out$op, ncds5.out$rhs,
                    data.frame(lapply(ncds5.out[is.num], round, 7)))
ncds5.out
write.xlsx(ncds5.out, file='NCDS-GCparams.xlsx')




### for sensitivity analyses


## no income
nlsy.noInc.out = as.data.frame( unclass( parameterEstimates(nlsy.f.noInc, ci=TRUE, level=0.95,boot.ci.type='perc')[,c('lhs','op','rhs','est','se','pvalue','ci.lower','ci.upper')] ) )
nlsy.noInc.out = nlsy.noInc.out[as.character(nlsy.noInc.out$lhs)!=as.character(nlsy.noInc.out$rhs),]
nlsy.noInc.out = nlsy.noInc.out[!is.na(nlsy.noInc.out$pvalue),]
nlsy.noInc.out = nlsy.noInc.out[(nlsy.noInc.out$op=='~')|nlsy.noInc.out$op=='~~',]
# nlsy.noInc.out = nlsy.noInc.out[(nlsy.noInc.out$lhs %in% c('gslop','dbi','dbs'))|(nlsy.noInc.out$rhs %in% c('gslop','dbi','dbs')),]
nlsy.noInc.out = nlsy.noInc.out[!(nlsy.noInc.out$rhs %in% c('age_1979','age.85','age.94','age.06','age.14')),]
nlsy.noInc.out$padj = p.adjust(nlsy.noInc.out$pvalue, 'fdr')

is.num <- sapply(nlsy.noInc.out, is.numeric)
nlsy.noInc.out = cbind(nlsy.noInc.out$lhs, nlsy.noInc.out$op, nlsy.noInc.out$rhs,
                  data.frame(lapply(nlsy.noInc.out[is.num], round, 7)))
nlsy.noInc.out[,c(-5,-6)]
write.xlsx(nlsy.noInc.out, file='NLSY_noIncome-GCparams.xlsx')



ncds.noInc.out = as.data.frame( unclass( parameterEstimates(ncds.f.noInc, ci=TRUE, level=0.95,boot.ci.type='perc')[,c('lhs','op','rhs','est','se','pvalue','ci.lower','ci.upper')] ) )
ncds.noInc.out = ncds.noInc.out[as.character(ncds.noInc.out$lhs)!=as.character(ncds.noInc.out$rhs),]
ncds.noInc.out = ncds.noInc.out[!is.na(ncds.noInc.out$pvalue),]
ncds.noInc.out = ncds.noInc.out[ncds.noInc.out$op=='~'|ncds.noInc.out$op=='~~',]
# ncds.noInc.out = ncds.noInc.out[(ncds.noInc.out$lhs %in% c('gslop','dbi','dbs'))|(ncds.noInc.out$rhs %in% c('gslop','dbi','dbs')),]
ncds.noInc.out = ncds.noInc.out[!(ncds.noInc.out$rhs %in% c('age_1979','age.85','age.94','age.06','age.14')),]
ncds.noInc.out$padj = p.adjust(ncds.noInc.out$pvalue, 'fdr')

is.num <- sapply(ncds.noInc.out, is.numeric)
ncds.noInc.out = cbind(ncds.noInc.out$lhs, ncds.noInc.out$op, ncds.noInc.out$rhs,
                  data.frame(lapply(ncds.noInc.out[is.num], round, 7)))
ncds.noInc.out[,c(-5,-6)]
write.xlsx(ncds.noInc.out, file='NCDS_noIncome-GCparams.xlsx')



## no education
nlsy.noIncEd.out = as.data.frame( unclass( parameterEstimates(nlsy.f.noIncEd, ci=TRUE, level=0.95,boot.ci.type='perc')[,c('lhs','op','rhs','est','se','pvalue','ci.lower','ci.upper')] ) )
nlsy.noIncEd.out = nlsy.noIncEd.out[as.character(nlsy.noIncEd.out$lhs)!=as.character(nlsy.noIncEd.out$rhs),]
nlsy.noIncEd.out = nlsy.noIncEd.out[!is.na(nlsy.noIncEd.out$pvalue),]
nlsy.noIncEd.out = nlsy.noIncEd.out[(nlsy.noIncEd.out$op=='~')|nlsy.noIncEd.out$op=='~~',]
# nlsy.noIncEd.out = nlsy.noIncEd.out[(nlsy.noIncEd.out$lhs %in% c('gslop','dbi','dbs'))|(nlsy.noIncEd.out$rhs %in% c('gslop','dbi','dbs')),]
nlsy.noIncEd.out = nlsy.noIncEd.out[!(nlsy.noIncEd.out$rhs %in% c('age_1979','age.85','age.94','age.06','age.14')),]
nlsy.noIncEd.out$padj = p.adjust(nlsy.noIncEd.out$pvalue, 'fdr')

is.num <- sapply(nlsy.noIncEd.out, is.numeric)
nlsy.noIncEd.out = cbind(nlsy.noIncEd.out$lhs, nlsy.noIncEd.out$op, nlsy.noIncEd.out$rhs,
                       data.frame(lapply(nlsy.noIncEd.out[is.num], round, 7)))
nlsy.noIncEd.out[,c(-5,-6)]
write.xlsx(nlsy.noIncEd.out, file='NLSY_noIncomeOrEdu-GCparams.xlsx')


ncds.noIncEd.out = as.data.frame( unclass( parameterEstimates(ncds.f.noIncEd, ci=TRUE, level=0.95,boot.ci.type='perc')[,c('lhs','op','rhs','est','se','pvalue','ci.lower','ci.upper')] ) )
ncds.noIncEd.out = ncds.noIncEd.out[as.character(ncds.noIncEd.out$lhs)!=as.character(ncds.noIncEd.out$rhs),]
ncds.noIncEd.out = ncds.noIncEd.out[!is.na(ncds.noIncEd.out$pvalue),]
ncds.noIncEd.out = ncds.noIncEd.out[ncds.noIncEd.out$op=='~'|ncds.noIncEd.out$op=='~~',]
# ncds.noIncEd.out = ncds.noIncEd.out[(ncds.noIncEd.out$lhs %in% c('gslop','dbi','dbs'))|(ncds.noIncEd.out$rhs %in% c('gslop','dbi','dbs')),]
ncds.noIncEd.out = ncds.noIncEd.out[!(ncds.noIncEd.out$rhs %in% c('age_1979','age.85','age.94','age.06','age.14')),]
ncds.noIncEd.out$padj = p.adjust(ncds.noIncEd.out$pvalue, 'fdr')

is.num <- sapply(ncds.noIncEd.out, is.numeric)
ncds.noIncEd.out = cbind(ncds.noIncEd.out$lhs, ncds.noIncEd.out$op, ncds.noIncEd.out$rhs,
                       data.frame(lapply(ncds.noIncEd.out[is.num], round, 7)))
ncds.noIncEd.out[,c(-5,-6)]
write.xlsx(ncds.noIncEd.out, file='NCDS_noIncomeOrEdu-GCparams.xlsx')



### With all ethnic groups


## NLSY

fitMeasures(isq.all.us.f1, c("chisq", "df", "pvalue", "cfi", "tli", "srmr", "rmsea"))

nlsy.all.out = as.data.frame( unclass( parameterEstimates(isq.all.us.f1, ci=TRUE, level=0.95,boot.ci.type='perc')[,c('lhs','op','rhs','est','se','pvalue','ci.lower','ci.upper')] ) )

nlsy.all.out = nlsy.all.out[as.character(nlsy.all.out$lhs)!=as.character(nlsy.all.out$rhs),]
nlsy.all.out = nlsy.all.out[!is.na(nlsy.all.out$pvalue),]
nlsy.all.out = nlsy.all.out[(nlsy.all.out$op=='~')|nlsy.all.out$op=='~~',]
# nlsy.all.out = nlsy.all.out[(nlsy.all.out$lhs %in% c('gslop','dbi','dbs'))|(nlsy.all.out$rhs %in% c('gslop','dbi','dbs')),]
nlsy.all.out = nlsy.all.out[!(nlsy.all.out$rhs %in% c('age_1979','age.85','age.94','age.06','age.14')),]
nlsy.all.out$padj = p.adjust(nlsy.all.out$pvalue, 'fdr')

is.num <- sapply(nlsy.all.out, is.numeric)
nlsy.all.out = cbind(nlsy.all.out$lhs, nlsy.all.out$op, nlsy.all.out$rhs,
                  data.frame(lapply(nlsy.all.out[is.num], round, 7)))
nlsy.all.out
write.xlsx(nlsy.all.out, file='NLSY-allGCparams.xlsx')



## NCDS

fitMeasures(isq.all.uk.f1, c("chisq", "df", "pvalue", "cfi", "tli", "srmr", "rmsea"))

ncds.all.out = as.data.frame( unclass( parameterEstimates(isq.all.uk.f1, ci=TRUE, level=0.95,boot.ci.type='perc')[,c('lhs','op','rhs','est','se','pvalue','ci.lower','ci.upper')] ) )

ncds.all.out = ncds.all.out[as.character(ncds.all.out$lhs)!=as.character(ncds.all.out$rhs),]
ncds.all.out = ncds.all.out[!is.na(ncds.all.out$pvalue),]
ncds.all.out = ncds.all.out[ncds.all.out$op=='~'|ncds.all.out$op=='~~',]
# ncds.all.out = ncds.all.out[(ncds.all.out$lhs %in% c('gslop','dbi','dbs'))|(ncds.all.out$rhs %in% c('gslop','dbi','dbs')),]
ncds.all.out = ncds.all.out[!(ncds.all.out$rhs %in% c('age_1979','age.85','age.94','age.06','age.14')),]
ncds.all.out$padj = p.adjust(ncds.all.out$pvalue, 'fdr')

is.num <- sapply(ncds.all.out, is.numeric)
ncds.all.out = cbind(ncds.all.out$lhs, ncds.all.out$op, ncds.all.out$rhs,
                  data.frame(lapply(ncds.all.out[is.num], round, 7)))
ncds.all.out
write.xlsx(ncds.all.out, file='NCDS-allGCparams.xlsx')


