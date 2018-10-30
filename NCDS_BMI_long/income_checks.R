### Income examinations

## pay is weekly


hist(ncds$income23, breaks=20)
hist(ncds$income33, breaks=20)
hist(ncds$income42, breaks=20)
hist(ncds$income50, breaks=20)
hist(ncds$income55, breaks=20)



table(is.na(ncds$income23))
table(is.na(ncds$income33))
table(is.na(ncds$income42))
table(is.na(ncds$income50))
table(is.na(ncds$income55))


table(income.23$flag_me)
table(income.33$flag_me)
table(income.42$flag_me)
table(income.50$flag_me)
table(income.55$flag_me)



cor(ncds[c('g','Youth_SES','education','income23','income33','income42','income50','income55')]
    , use='pairwise.complete.obs')
