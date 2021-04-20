library(arm)
library(stargazer)
library(effsize)



### Only complete cases for main analyses

cols = c('g','g.cut','g.dec','vax.cat','j_age_dv','female','non.white',
           'cmds' , 'cancer' , 'respir' ,
           'Edu',
           'cf_scghq2_dv' , 'shield')

ind = complete.cases(df[,..cols])
table(ind)

df.sub = df[ind,..cols]



### Age + sex + ethnicity
m2 = glm(vax.cat ~ I(-1*g) + j_age_dv + female + non.white
         , data = df.sub
         , family=binomial())

m2cat = glm(vax.cat ~ g.cut + j_age_dv + female + non.white
         , data = df.sub
         , family=binomial())

summary(standardize(m2))




### Age + sex + ethnicity + comorbidity
m3 = glm(vax.cat ~ I(-1*g) + j_age_dv + female + non.white +
           cmds + cancer + respir
         , data = df.sub
         , family=binomial())

m3cat = glm(vax.cat ~ g.cut + j_age_dv + female + non.white +
           cmds + cancer + respir
         , data = df.sub
         , family=binomial())

#summary(standardize(m3))



### Age + sex + ethnicity + shielding
m4 = glm(vax.cat ~ I(-1*g) + j_age_dv + female + non.white +
           shield
         , data = df.sub
         , family=binomial())

m4cat = glm(vax.cat ~ g.cut + j_age_dv + female + non.white +
           shield
         , data = df.sub
         , family=binomial())

#summary(standardize(m4))



### Age + sex + ethnicity + education
m5 = glm(vax.cat ~ I(-1*g) + j_age_dv + female + non.white +
          Edu
         , data = df.sub
         , family=binomial())

m5cat = glm(vax.cat ~ g.cut + j_age_dv + female + non.white +
          Edu
         , data = df.sub
         , family=binomial())

#summary(standardize(m5))



### Age + sex + ethnicity + psychological distress
m6 = glm(vax.cat ~ I(-1*g) + j_age_dv + female + non.white +
           cf_scghq2_dv
         , data = df.sub
         , family=binomial())

m6cat = glm(vax.cat ~ g.cut + j_age_dv + female + non.white +
              cf_scghq2_dv
            , data = df.sub
            , family=binomial())

#summary(standardize(m6cat))



### All 
m7 = glm(vax.cat ~ I(-1*g) + j_age_dv + female + non.white +
           cmds + cancer + respir +
           shield +
           Edu +
           cf_scghq2_dv
         , data = df.sub
         , family=binomial())

m7cat = glm(vax.cat ~ g.cut + j_age_dv + female + non.white +
           cmds + cancer + respir +
           shield +
           Edu +
           cf_scghq2_dv
         , data = df.sub
         , family=binomial())

summary(standardize(m7cat))




### Hedge's g for g
cohen.d(g ~ vax.cat, data=df.sub, hedges.correction=TRUE)



### g x Edu correlation
cor.test(df.sub$g, as.numeric(df.sub$Edu), method='kendall')




### Tables


## how many "cases" by g group?
table(df.sub$g.cut, df.sub$vax.cat)

table(df.sub$g.dec, df.sub$vax.cut, useNA='ifany')



#ci.1 = exp(confint(standardize(m1)))
ci.2 = exp(confint(standardize(m2)))
ci.3 = exp(confint(standardize(m3)))
ci.4 = exp(confint(standardize(m4)))
ci.5 = exp(confint(standardize(m5)))
ci.6 = exp(confint(standardize(m6)))
ci.7 = exp(confint(standardize(m7)))
custom.cont.cis = list(ci.2,ci.3,ci.4,ci.5,ci.6,ci.7)

#ci.1cat = exp(confint(standardize(m1cat)))
ci.2cat = exp(confint(standardize(m2cat)))
ci.3cat = exp(confint(standardize(m3cat)))
ci.4cat = exp(confint(standardize(m4cat)))
ci.5cat = exp(confint(standardize(m5cat)))
ci.6cat = exp(confint(standardize(m6cat)))
ci.7cat = exp(confint(standardize(m7cat)))
custom.cat.cis = list(ci.2cat,ci.3cat,ci.4cat,ci.5cat,ci.6cat,ci.7cat)


## For the ORs and CIs
stargazer(#standardize(m1cat),
          standardize(m2cat),standardize(m3cat),
          standardize(m4cat),standardize(m5cat),
          standardize(m6cat),standardize(m7cat),
          type='html', out='g-cat-mods.htm',
          apply.coef = exp,
          ci.custom = custom.cat.cis,
          single.row=TRUE, digits=2
          , omit.table.layout = "n"
          , star.char=NULL, star.cutoffs=NA
          )

## For P of trend and SD effect size
stargazer(#standardize(m1),
          standardize(m2),standardize(m3),
          standardize(m4),standardize(m5),
          standardize(m6),standardize(m7),
          type='html', out='g-cont-mods.htm',
          ## need to switch sign for exponential
          apply.coef = exp,
          ci.custom = custom.cis,
          single.row=TRUE, digits=2,
          report='vcsp'
          , omit.table.layout = "n"
          , star.char=NULL, star.cutoffs=NA
)



ci.dec.2 = exp(confint(standardize(m2g10cat)))
ci.dec.7 = exp(confint(standardize(m7g10cat)))
custom.dec.cis = list(ci.dec.2, ci.dec.7)


## For the ORs and CIs
stargazer(standardize(m2g10cat),standardize(m7g10cat),
  type='html', out='g-dec-mods.htm',
  apply.coef = exp,
  ci.custom = custom.dec.cis,
  single.row=TRUE, digits=2
  , omit.table.layout = "n"
  , star.char=NULL, star.cutoffs=NA
)




