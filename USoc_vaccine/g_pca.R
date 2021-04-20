### g factor calculation


library(psych)
library(forcats)
library(gtools)



g.pca = principal(df[,c('c_cgwri_dv','c_cgwrd_dv','c_cgvfc_dv','c_cgs7cs_dv','c_cgns_dv','c_cgna_dv')])

print(g.pca)

hist(g.pca$scores)

#table(is.na(g.pca$scores)) # 8803 missing from original, 633 missing from merged df


df$g = g.pca$scores

df$g = scale(df$g)*15 + 100


g.m = median(df$g, na.rm=TRUE)
g.sd = sd(df$g, na.rm=TRUE)

df$g.cut = cut(df$g, breaks = c(-500, g.m-0.5*g.sd, g.m+0.5*g.sd, 500))
df$g.cut = fct_rev(df$g.cut)
levels(df$g.cut) = c('3','2','1 (low)')

table(df$g.cut)

describe(df$g[df$g.cut=='3'])
describe(df$g[df$g.cut=='2'])
describe(df$g[df$g.cut=='1 (low)'])


df$g.dec = quantcut(df$g, q=10)
df$g.dec = fct_rev(df$g.dec)

table(df$g.dec)



### Saving df after processing - useful ###

saveRDS(df.MH, file='df_MH.RDS')
