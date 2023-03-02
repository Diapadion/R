### Tables

library(doBy)
library(stargazer)
library(arm)




options(scipen=999)



### Table 1
## Total numbers
table(df$vax.cat, useNA='ifany')
prop.table(table(df$vax.cat))


## Age
summaryBy(df, formula = j_age_dv ~ vax.cat, FUN = c(mean,sd), na.rm=TRUE)
t.test(j_age_dv ~ vax.cat, df)



### Code transfer from earlier descript.R isn't working right... or is it? ###



## Sex (female)
summaryBy(df, formula = female ~ vax.cat, FUN = c(sum), na.rm=TRUE)
#sum(!is.na(df$female))
#rev(table(df$vax.cat) )
summaryBy(df, formula = female ~ vax.cat, FUN = c(sum), na.rm=TRUE) / rev(table(df$vax.cat))
chisq.test(df$female, df$vax.cat)


## Non-white
summaryBy(df, formula = non.white ~ vax.cat, FUN = c(sum), na.rm=TRUE)
summaryBy(df, formula = non.white ~ vax.cat, FUN = c(sum), na.rm=TRUE) / rev(table(df$vax.cat))
chisq.test(df$non.white, df$vax.cat)


## Higher education
table(df$HigherEd, useNA='')
summaryBy(df, formula = NoHigherEd ~ vax.cat, FUN = c(sum), na.rm=TRUE)
summaryBy(df, formula = NoHigherEd ~ vax.cat, FUN = c(sum), na.rm=TRUE) / rev(table(df$vax.cat))
chisq.test(df$NoHigherEd, df$vax.cat)


## Occupational social class
# summaryBy(df, formula = low.soc.class ~ vax.cat, FUN = c(sum), na.rm=TRUE)
# summaryBy(df, formula = low.soc.class ~ vax.cat, FUN = c(sum), na.rm=TRUE) / rev(table(df$vax.cat))
# chisq.test(df$low.soc.class, df$vax.cat) 


## Cardiometabolic conditions
df$cmds.int = as.integer(df$cmds)-1
summaryBy(df, formula = cmds.int ~ vax.cat, FUN = c(sum), na.rm=TRUE)
summaryBy(df, formula = cmds.int ~ vax.cat, FUN = c(sum), na.rm=TRUE) / rev(table(df$vax.cat))
chisq.test(df$cmds.int, df$vax.cat) 


## Respiratory conditions
df$respir.int = as.integer(df$respir)-1
summaryBy(df, formula = respir.int ~ vax.cat, FUN = c(sum), na.rm=TRUE)
summaryBy(df, formula = respir.int ~ vax.cat, FUN = c(sum), na.rm=TRUE) / rev(table(df$vax.cat))
chisq.test(df$respir.int, df$vax.cat) 


## Cancer
summaryBy(df, formula = cancer ~ vax.cat, FUN = c(sum), na.rm=TRUE)
summaryBy(df, formula = cancer ~ vax.cat, FUN = c(sum), na.rm=TRUE) / rev(table(df$vax.cat))
chisq.test(df$cancer, df$vax.cat) 


df$anx.int = as.integer(df$anxiety)-1
df$dep.int = as.integer(df$depress)-1
#df$ptsd.int = as.integer(df$ptsd)-1
df$oth.int = as.integer(df$otherMH)-1
df$any.int = as.integer(df$anyMH)-1

## Anxiety
summaryBy(df, formula = anx.int ~ vax.cat, FUN = c(sum), na.rm=TRUE)
summaryBy(df, formula = anx.int ~ vax.cat, FUN = c(sum), na.rm=TRUE) / rev(table(df$vax.cat))
chisq.test(df$anxiety, df$vax.cat) 

## Depression
summaryBy(df, formula = dep.int ~ vax.cat, FUN = c(sum), na.rm=TRUE)
summaryBy(df, formula = dep.int ~ vax.cat, FUN = c(sum), na.rm=TRUE) / rev(table(df$vax.cat))
chisq.test(df$depress, df$vax.cat) 

## PTSD
# summaryBy(df, formula = ptsd.int ~ vax.cat, FUN = c(sum), na.rm=TRUE)
# summaryBy(df, formula = ptsd.int ~ vax.cat, FUN = c(sum), na.rm=TRUE) / rev(table(df$vax.cat))
# chisq.test(df$ptsd, df$vax.cat) 

## Other
summaryBy(df, formula = oth.int ~ vax.cat, FUN = c(sum), na.rm=TRUE)
summaryBy(df, formula = oth.int ~ vax.cat, FUN = c(sum), na.rm=TRUE) / rev(table(df$vax.cat))
chisq.test(df$otherMH, df$vax.cat) 

## Any
summaryBy(df, formula = any.int ~ vax.cat, FUN = c(sum), na.rm=TRUE)
summaryBy(df, formula = any.int ~ vax.cat, FUN = c(sum), na.rm=TRUE) / rev(table(df$vax.cat))
chisq.test(df$anyMH, df$vax.cat) 


## Cognitive function
df$g.100 = scale(df$g)*15 + 100
summaryBy(df, formula = g.100 ~ vax.cat, FUN = c(mean,sd), na.rm=TRUE)
t.test(g.100 ~ vax.cat, df)


## Psychological distress
summaryBy(df, formula = cf_scghq2_dv ~ vax.cat, FUN = c(mean,sd), na.rm=TRUE)
t.test(cf_scghq2_dv ~ vax.cat, df)
 
## accurate counts:
table(df$ghq.cat, df$vax.cat) 

## percentages: 
df$ghq.sympt = (df$ghq.cat=='Asymptomatic')
summaryBy(df, formula = ghq.sympt ~ vax.cat, FUN = c(sum), na.rm=TRUE) / rev(table(df$vax.cat))
chisq.test(df$ghq.sympt, df$vax.cat) 
df$ghq.sympt = (df$ghq.cat=='Subclinical')
summaryBy(df, formula = ghq.sympt ~ vax.cat, FUN = c(sum), na.rm=TRUE) / rev(table(df$vax.cat))
chisq.test(df$ghq.sympt, df$vax.cat) 
df$ghq.sympt = (df$ghq.cat=='Symptomatic')
summaryBy(df, formula = ghq.sympt ~ vax.cat, FUN = c(sum), na.rm=TRUE) / rev(table(df$vax.cat))
chisq.test(df$ghq.sympt, df$vax.cat) 
df$ghq.sympt = (df$ghq.cat=='High symptomatic')
summaryBy(df, formula = ghq.sympt ~ vax.cat, FUN = c(sum), na.rm=TRUE) / rev(table(df$vax.cat))
chisq.test(df$ghq.sympt, df$vax.cat) 



## Shielding
summaryBy(df, formula = shield ~ vax.cat, FUN = c(sum), na.rm=TRUE)
summaryBy(df, formula = shield ~ vax.cat, FUN = c(sum), na.rm=TRUE) / rev(table(df$vax.cat))
chisq.test(df$cancer, df$vax.cat) 







### and the first column of Table 2 from here
table(df.MH$vax.cat, df.MH$anxiety, useNA='ifany')
table(df.MH$vax.cat, df.MH$depress, useNA='ifany')
# table(df.MH$vax.cat, df.MH$schiz, useNA='ifany')
# table(df.MH$vax.cat, df.MH$manic, useNA='ifany')
# table(df.MH$vax.cat, df.MH$eat, useNA='ifany')
# table(df.MH$vax.cat, df.MH$ptsd, useNA='ifany')
table(df.MH$vax.cat, df.MH$otherMH, useNA='ifany')
table(df.MH$vax.cat, df.MH$anyMH, useNA='ifany')

#table(df.MH$vax.cat, df.MH$ghq.bin, useNA='ifany')
table(df.MH$vax.cat, df.MH$ghq.cat, useNA='ifany')

table(df.MH$vax.cat, df.MH$cmds, useNA='ifany')
table(df.MH$vax.cat, df.MH$respir, useNA='ifany')
table(df.MH$vax.cat, df.MH$cancer, useNA='ifany')
table(df.MH$vax.cat, df.MH$anyMorb, useNA='ifany')



### Table 2
### (stargazer)



ci.anx.1 = exp(confint(standardize(anx.1)))
ci.anx.2 = exp(confint(standardize(anx.2)))
ci.anx.3 = exp(confint(standardize(anx.3)))
ci.anx.4 = exp(confint(standardize(anx.4)))
ci.anx.5 = exp(confint(standardize(anx.5)))
ci.anx.6 = exp(confint(standardize(anx.6)))
anx.cis = list(ci.anx.1,
               ci.anx.2,ci.anx.3,ci.anx.4,ci.anx.5,
               ci.anx.6)

ci.dep.1 = exp(confint(standardize(dep.1)))
ci.dep.2 = exp(confint(standardize(dep.2)))
ci.dep.3 = exp(confint(standardize(dep.3)))
ci.dep.4 = exp(confint(standardize(dep.4)))
ci.dep.5 = exp(confint(standardize(dep.5)))
ci.dep.6 = exp(confint(standardize(dep.6)))
dep.cis = list(ci.dep.1,
               ci.dep.2,ci.dep.3,ci.dep.4,ci.dep.5,
               ci.dep.6)

# ci.scz.1 = exp(confint(standardize(scz.1)))
# # ci.scz.2 = exp(confint(standardize(scz.2)))
# # ci.scz.3 = exp(confint(standardize(scz.3)))
# # ci.scz.4 = exp(confint(standardize(scz.4)))
# # ci.scz.5 = exp(confint(standardize(scz.5)))
# ci.scz.6 = exp(confint(standardize(scz.6)))
# scz.cis = list(ci.scz.1,
#                # ci.scz.2,ci.scz.3,ci.scz.4,ci.scz.5,
#                ci.scz.6)
# 
# ci.bip.1 = exp(confint(standardize(bip.1)))
# # ci.bip.2 = exp(confint(standardize(bip.2)))
# # ci.bip.3 = exp(confint(standardize(bip.3)))
# # ci.bip.4 = exp(confint(standardize(bip.4)))
# # ci.bip.5 = exp(confint(standardize(bip.5)))
# ci.bip.6 = exp(confint(standardize(bip.6)))
# bip.cis = list(ci.bip.1,
#                # ci.bip.2,ci.bip.3,ci.bip.4,ci.bip.5,
#                ci.bip.6)
# 
# ci.eat.1 = exp(confint(standardize(eat.1)))
# # ci.eat.2 = exp(confint(standardize(eat.2)))
# # ci.eat.3 = exp(confint(standardize(eat.3)))
# # ci.eat.4 = exp(confint(standardize(eat.4)))
# # ci.eat.5 = exp(confint(standardize(eat.5)))
# ci.eat.6 = exp(confint(standardize(eat.6)))
# eat.cis = list(ci.eat.1,
#                # ci.eat.2,ci.eat.3,ci.eat.4,ci.eat.5,
#                ci.eat.6)
# 
# ci.pts.1 = exp(confint(standardize(pts.1)))
# # ci.pts.2 = exp(confint(standardize(pts.2)))
# # ci.pts.3 = exp(confint(standardize(pts.3)))
# # ci.pts.4 = exp(confint(standardize(pts.4)))
# # ci.pts.5 = exp(confint(standardize(pts.5)))
# ci.pts.6 = exp(confint(standardize(pts.6)))
# pts.cis = list(ci.pts.1,
#                # ci.pts.2,ci.pts.3,ci.pts.4,ci.pts.5,
#                ci.pts.6)

ci.oth.1 = exp(confint(standardize(oth.1)))
ci.oth.2 = exp(confint(standardize(oth.2)))
ci.oth.3 = exp(confint(standardize(oth.3)))
ci.oth.4 = exp(confint(standardize(oth.4)))
ci.oth.5 = exp(confint(standardize(oth.5)))
ci.oth.6 = exp(confint(standardize(oth.6)))
oth.cis = list(ci.oth.1,
               ci.oth.2,ci.oth.3,ci.oth.4,ci.oth.5,
               ci.oth.6)

ci.any.1 = exp(confint(standardize(any.1)))
ci.any.2 = exp(confint(standardize(any.2)))
ci.any.3 = exp(confint(standardize(any.3)))
ci.any.4 = exp(confint(standardize(any.4)))
ci.any.5 = exp(confint(standardize(any.5)))
ci.any.6 = exp(confint(standardize(any.6)))
any.cis = list(ci.any.1,
               ci.any.2,ci.any.3,ci.any.4,ci.any.5,
               ci.any.6)



## For the MH ORs and CIs
stargazer(
  standardize(anx.1),
  standardize(anx.2),
  standardize(anx.3),standardize(anx.4),
  standardize(anx.5),
  standardize(anx.6),
  type='html', out='anx-mods.htm',
  apply.coef = exp,
  ci.custom = anx.cis,
  single.row=TRUE, digits=2
  , omit.table.layout = "n"
  , star.char=NULL, star.cutoffs=NA
)

stargazer(
  standardize(dep.1),
  standardize(dep.2),
  standardize(dep.3),standardize(dep.4),
  standardize(dep.5),
  standardize(dep.6),
  type='html', out='dep-mods.htm',
  apply.coef = exp,
  ci.custom = dep.cis,
  single.row=TRUE, digits=2
  , omit.table.layout = "n"
  , star.char=NULL, star.cutoffs=NA
)

# stargazer(
#   standardize(scz.1),
#   # standardize(scz.2),
#   # standardize(scz.3),standardize(scz.4),
#   # standardize(scz.5),
#   standardize(scz.6),
#   type='html', out='scz-mods.htm',
#   apply.coef = exp,
#   ci.custom = scz.cis,
#   single.row=TRUE, digits=2
#   , omit.table.layout = "n"
#   , star.char=NULL, star.cutoffs=NA
# )
# 
# stargazer(
#   standardize(bip.1),
#   # standardize(bip.2),
#   # standardize(bip.3),standardize(bip.4),
#   # standardize(bip.5),
#   standardize(bip.6),
#   type='html', out='bip-mods.htm',
#   apply.coef = exp,
#   ci.custom = bip.cis,
#   single.row=TRUE, digits=2
#   , omit.table.layout = "n"
#   , star.char=NULL, star.cutoffs=NA
# )
# 
# stargazer(
#   standardize(eat.1),
#   # standardize(eat.2),
#   # standardize(eat.3),standardize(eat.4),
#   # standardize(eat.5),
#   standardize(eat.6),
#   type='html', out='eat-mods.htm',
#   apply.coef = exp,
#   ci.custom = eat.cis,
#   single.row=TRUE, digits=2
#   , omit.table.layout = "n"
#   , star.char=NULL, star.cutoffs=NA
# )
# 
# stargazer(
#   standardize(pts.1),
#   # standardize(pts.2),
#   # standardize(pts.3),standardize(pts.4),
#   # standardize(pts.5),
#   standardize(pts.6),
#   type='html', out='pts-mods.htm',
#   apply.coef = exp,
#   ci.custom = pts.cis,
#   single.row=TRUE, digits=2
#   , omit.table.layout = "n"
#   , star.char=NULL, star.cutoffs=NA
# )

stargazer(
  standardize(oth.1),
  standardize(oth.2),
  standardize(oth.3),standardize(oth.4),
  standardize(oth.5),
  standardize(oth.6),
  type='html', out='oth-mods.htm',
  apply.coef = exp,
  ci.custom = oth.cis,
  single.row=TRUE, digits=2
  , omit.table.layout = "n"
  , star.char=NULL, star.cutoffs=NA
)

stargazer(
  standardize(any.1),
  standardize(any.2),
  standardize(any.3),standardize(any.4),
  standardize(any.5),
  standardize(any.6),
  type='html', out='any-mods.htm',
  apply.coef = exp,
  ci.custom = any.cis,
  single.row=TRUE, digits=2
  , omit.table.layout = "n"
  , star.char=NULL, star.cutoffs=NA
)



### Psychological distress

ci.ghq.1 = exp(confint(standardize(ghq.1)))
ci.ghq.2 = exp(confint(standardize(ghq.2)))
ci.ghq.3 = exp(confint(standardize(ghq.3)))
ci.ghq.4 = exp(confint(standardize(ghq.4)))
ci.ghq.5 = exp(confint(standardize(ghq.5)))
ci.ghq.6 = exp(confint(standardize(ghq.6)))
ghq.cis = list(ci.ghq.1,
               ci.ghq.2,ci.ghq.3,ci.ghq.4,ci.ghq.5,
               ci.ghq.6)

ci.ghqCat1 = exp(confint(standardize(ghq.1cat)))
ci.ghqCat2 = exp(confint(standardize(ghq.2cat)))
ci.ghqCat3 = exp(confint(standardize(ghq.3cat)))
ci.ghqCat4 = exp(confint(standardize(ghq.4cat)))
ci.ghqCat5 = exp(confint(standardize(ghq.5cat)))
ci.ghqCat6 = exp(confint(standardize(ghq.6cat)))
ghqCat.cis = list(ci.ghqCat1,
                  ci.ghqCat2,ci.ghqCat3,ci.ghqCat4,ci.ghqCat5,
                  ci.ghqCat6)


stargazer(
  standardize(ghq.1),
  standardize(ghq.2),
  standardize(ghq.3),standardize(ghq.4),
  standardize(ghq.5),
  standardize(ghq.6),
  type='html', out='ghq-mods.htm',
  apply.coef = exp,
  ci.custom = ghq.cis,
  #report='vcsp',
  single.row=TRUE, digits=2
  , omit.table.layout = "n"
  , star.char=NULL, star.cutoffs=NA
)

stargazer(
  standardize(ghq.1cat),
  standardize(ghq.2cat),
  standardize(ghq.3cat),standardize(ghq.4cat),
  standardize(ghq.5cat),
  standardize(ghq.6cat),
  type='html', out='ghqCat-mods.htm',
  apply.coef = exp,
  ci.custom = ghqCat.cis,
  single.row=TRUE, digits=2
  #, report='vcsp'
  , omit.table.layout = "n"
  , star.char=NULL, star.cutoffs=NA
)



### Physical morbidities

ci.cmds.1 = exp(confint(standardize(cmds.1)))
ci.cmds.2 = exp(confint(standardize(cmds.2)))
ci.cmds.3 = exp(confint(standardize(cmds.3)))
ci.cmds.4 = exp(confint(standardize(cmds.4)))
ci.cmds.5 = exp(confint(standardize(cmds.5)))
ci.cmds.6 = exp(confint(standardize(cmds.6)))
cmds.cis = list(ci.cmds.1,
                ci.cmds.2,ci.cmds.3,ci.cmds.4,ci.cmds.5,
                ci.cmds.6)

ci.cancer.1 = exp(confint(standardize(cancer.1)))
ci.cancer.2 = exp(confint(standardize(cancer.2)))
ci.cancer.3 = exp(confint(standardize(cancer.3)))
ci.cancer.4 = exp(confint(standardize(cancer.4)))
ci.cancer.5 = exp(confint(standardize(cancer.5)))
ci.cancer.6 = exp(confint(standardize(cancer.6)))
cancer.cis = list(ci.cancer.1,
                  ci.cancer.2,ci.cancer.3,ci.cancer.4,ci.cancer.5,
                  ci.cancer.6)

ci.respir.1 = exp(confint(standardize(respir.1)))
ci.respir.2 = exp(confint(standardize(respir.2)))
ci.respir.3 = exp(confint(standardize(respir.3)))
ci.respir.4 = exp(confint(standardize(respir.4)))
ci.respir.5 = exp(confint(standardize(respir.5)))
ci.respir.6 = exp(confint(standardize(respir.6)))
respir.cis = list(ci.respir.1,
                  ci.respir.2,ci.respir.3,ci.respir.4,ci.respir.5,
                  ci.respir.6)

ci.anyMorb.1 = exp(confint(standardize(anyMorb.1)))
ci.anyMorb.2 = exp(confint(standardize(anyMorb.2)))
ci.anyMorb.3 = exp(confint(standardize(anyMorb.3)))
ci.anyMorb.4 = exp(confint(standardize(anyMorb.4)))
ci.anyMorb.5 = exp(confint(standardize(anyMorb.5)))
ci.anyMorb.6 = exp(confint(standardize(anyMorb.6)))
anyMorb.cis = list(ci.anyMorb.1,
                   ci.anyMorb.2,ci.anyMorb.3,ci.anyMorb.4,ci.anyMorb.5,
                   ci.anyMorb.6)


stargazer(
  standardize(cmds.1),
  standardize(cmds.2),
  standardize(cmds.3),standardize(cmds.4),
  standardize(cmds.5),
  standardize(cmds.6),
  type='html', out='cmds-mods.htm',
  apply.coef = exp,
  ci.custom = cmds.cis,
  single.row=TRUE, digits=2
  , omit.table.layout = "n"
  , star.char=NULL, star.cutoffs=NA
)

stargazer(
  standardize(cancer.1),
  standardize(cancer.2),
  standardize(cancer.3),standardize(cancer.4),
  standardize(cancer.5),
  standardize(cancer.6),
  type='html', out='cancer-mods.htm',
  apply.coef = exp,
  ci.custom = cancer.cis,
  single.row=TRUE, digits=2
  , omit.table.layout = "n"
  , star.char=NULL, star.cutoffs=NA
)

stargazer(
  standardize(anyMorb.1),
  standardize(anyMorb.2),
  standardize(anyMorb.3),standardize(anyMorb.4),
  standardize(anyMorb.5),
  standardize(anyMorb.6),
  type='html', out='anyMorb-mods.htm',
  apply.coef = exp,
  ci.custom = anyMorb.cis,
  single.row=TRUE, digits=2
  , omit.table.layout = "n"
  , star.char=NULL, star.cutoffs=NA
)

stargazer(
  standardize(respir.1),
  standardize(respir.2),
  standardize(respir.3),standardize(respir.4),
  standardize(respir.5),
  standardize(respir.6),
  type='html', out='respir-mods.htm',
  apply.coef = exp,
  ci.custom = respir.cis,
  single.row=TRUE, digits=2
  , omit.table.layout = "n"
  , star.char=NULL, star.cutoffs=NA
)



# ci.shield.1 = exp(confint(standardize(cmds.1)))
# ci.shield.2 = exp(confint(standardize(cmds.2)))
# ci.shield.3 = exp(confint(standardize(cmds.3)))
# ci.cmds.4 = exp(confint(standardize(cmds.4)))
# ci.cmds.5 = exp(confint(standardize(cmds.5)))
# ci.cmds.6 = exp(confint(standardize(cmds.6)))
# cmds.cis = list(ci.cmds.1,
#                 # ci.cmds.2,ci.cmds.3,ci.cmds.4,ci.cmds.5,
#                 ci.cmds.6)




### Extras ###

## Shielding
ci.shield.1 = exp(confint(standardize(shield.1)))
ci.shield.2 = exp(confint(standardize(shield.2)))
ci.shield.4 = exp(confint(standardize(shield.4)))
ci.shield.5 = exp(confint(standardize(shield.5)))
ci.shield.6 = exp(confint(standardize(shield.6)))
shield.cis = list(ci.shield.1,
                   ci.shield.2,ci.shield.4,ci.shield.5,
                   ci.shield.6)


stargazer(
  standardize(shield.1),
  standardize(shield.2),
  standardize(shield.4),
  standardize(shield.5),
  standardize(shield.6),
  type='html', out='shield-mods.htm',
  apply.coef = exp,
  ci.custom = shield.cis,
  single.row=TRUE, digits=2
  , omit.table.layout = "n"
  , star.char=NULL, star.cutoffs=NA
)


## Quadratic trend p's

summary(glm(vax.cat ~ I(-1*cf_scghq2_dv^2) + j_age_dv + female + non.white
                     + cmds + cancer + respir
             , data = df.MH
             , family=binomial()))

summary(glm(vax.cat ~ I(-1*cf_scghq2_dv^2) + j_age_dv + female + non.white
            + shield
            , data = df.MH
            , family=binomial()))

summary(glm(vax.cat ~ I(-1*cf_scghq2_dv^2) + j_age_dv + female + non.white
            + Edu
            , data = df.MH
            , family=binomial()))

summary(glm(vax.cat ~ I(-1*cf_scghq2_dv^2) + j_age_dv + female + non.white
            + g
            , data = df.MH
            , family=binomial()))

summary(glm(vax.cat ~ I(-1*cf_scghq2_dv^2) + j_age_dv + female + non.white
            + g
            , data = df.MH
            , family=binomial()))



##########################

# ### Extra MH (i.e. loneliness)
# ci.lone.b.1 = exp(confint(standardize(lone.b.1cat)))
# ci.lone.b.6 = exp(confint(standardize(lone.b.6cat)))
# 
# ci.lone.1 = exp(confint(standardize(lone.1cat)))
# ci.lone.6 = exp(confint(standardize(lone.6cat)))
# 
# lone.cis = list(ci.lone.b.1, ci.lone.b.6, ci.lone.1, ci.lone.6)
# 
# 
# stargazer(
#   standardize(lone.b.1cat),standardize(lone.b.6cat),
#   standardize(lone.1cat),standardize(lone.6cat),
#   type='html', out='lonely-mods.htm',
#   apply.coef = exp,
#   ci.custom = cmds.cis,
#   single.row=TRUE, digits=2
#   , omit.table.layout = "n"
#   , star.char=NULL, star.cutoffs=NA
# )
# 
