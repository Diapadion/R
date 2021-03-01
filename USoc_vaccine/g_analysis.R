library(arm)
library(stargazer)



### Only complete cases for main analyses

ind = complete.cases(df[,c('g','j_age_dv','female','non.white',
                           'cmds' , 'cancer' , 'respir' ,
                            'Edu',
                           'cf_scghq1_dv' , 'shield'
                           )])
table(ind)



### Age + sex
m1 = glm(vax.cat ~ I(-1*g) + j_age_dv + female
         , data = df
         , family=binomial())
summary(standardize(m1))

m1cat = glm(vax.cat ~ g.cut + j_age_dv + female
            , data = df
            , family=binomial())

#summary(standardize(m1cat))


### Age + sex + ethnicity
m2 = glm(vax.cat ~ I(-1*g) + j_age_dv + female + non.white
         , data = df
         , family=binomial())

m2cat = glm(vax.cat ~ g.cut + j_age_dv + female + non.white
         , data = df
         , family=binomial())

#summary(standardize(m2))


## religion??



### Age + sex + ethnicity + comorbidity
m3 = glm(vax.cat ~ I(-1*g) + j_age_dv + female + non.white +
           cmds + cancer + respir
         , data = df
         , family=binomial())

m3cat = glm(vax.cat ~ g.cut + j_age_dv + female + non.white +
           cmds + cancer + respir
         , data = df
         , family=binomial())

#summary(standardize(m3))



### Age + sex + ethnicity + comorbidity + SES (- education)
m4 = glm(vax.cat ~ I(-1*g) + j_age_dv + female + non.white +
           cmds + cancer + respir +
           soc.class.w3
         , data = df
         , family=binomial())

m4cat = glm(vax.cat ~ g.cut + j_age_dv + female + non.white +
           cmds + cancer + respir +
           soc.class.w3
         , data = df
         , family=binomial())

summary(standardize(m4))



### Age + sex + ethnicity + comorbidity + SES
m5 = glm(vax.cat ~ I(-1*g) + j_age_dv + female + non.white +
           cmds + cancer + respir +
           soc.class.w3 + Edu
         , data = df
         , family=binomial())

m5cat = glm(vax.cat ~ g.cut + j_age_dv + female + non.white +
           cmds + cancer + respir +
           soc.class.w3 + Edu
         , data = df
         , family=binomial())

#summary(standardize(m5))



### All 
m6 = glm(vax.cat ~ I(-1*g) + j_age_dv + female + non.white +
           cmds + cancer + respir +
           #soc.class.w3 +
           Edu +
           cf_scghq1_dv
         , data = df
         , family=binomial())

m6cat = glm(vax.cat ~ g.cut + j_age_dv + female + non.white +
           cmds + cancer + respir +
           #soc.class.w3 + 
           Edu +
           cf_scghq1_dv
         , data = df
         , family=binomial())

#summary(standardize(m6cat))



### Tables


ci.1 = exp(confint(standardize(m1)))
ci.2 = exp(confint(standardize(m2)))
ci.3 = exp(confint(standardize(m3)))
ci.4 = exp(confint(standardize(m4)))
ci.5 = exp(confint(standardize(m5)))
ci.6 = exp(confint(standardize(m6)))
custom.cont.cis = list(ci.1,ci.2,ci.3,ci.4,ci.5,ci.6)

ci.1cat = exp(confint(standardize(m1cat)))
ci.2cat = exp(confint(standardize(m2cat)))
ci.3cat = exp(confint(standardize(m3cat)))
ci.4cat = exp(confint(standardize(m4cat)))
ci.5cat = exp(confint(standardize(m5cat)))
ci.6cat = exp(confint(standardize(m6cat)))
custom.cat.cis = list(ci.1,ci.2,ci.3,ci.4,ci.5,ci.6)


## For the ORs and CIs
stargazer(standardize(m1cat),standardize(m2cat),standardize(m3cat),
          standardize(m4cat),standardize(m5cat),standardize(m6cat),
          type='html', out='g-cat-mods.htm',
          apply.coef = exp,
          ci.custom = custom.cat.cis,
          single.row=TRUE, digits=2
          , omit.table.layout = "n"
          , star.char=NULL, star.cutoffs=NA
          )

## For P of trend and SD effect size
stargazer(standardize(m1),standardize(m2),standardize(m3),
          standardize(m4),standardize(m5),standardize(m6),
          type='html', out='g-cont-mods.htm',
          ## need to switch sign for exponential
          apply.coef = exp,
          ci.custom = custom.cis,
          single.row=TRUE, digits=2,
          report='vcsp'
          , omit.table.layout = "n"
          , star.char=NULL, star.cutoffs=NA
)




