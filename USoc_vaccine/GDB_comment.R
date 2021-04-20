### extras for GDB

library(arm)
library(stargazer)



### Personality
## -see import.R for tables
m.p.n = glm(vax.cat ~ c_big5n_dv
                        , data = df
                        , family=binomial())

m.p.a = glm(vax.cat ~ c_big5a_dv
                        , data = df
                        , family=binomial())

m.p.e = glm(vax.cat ~ c_big5e_dv
                        , data = df
                        , family=binomial())

m.p.c = glm(vax.cat ~ c_big5c_dv
                        , data = df
                        , family=binomial())

m.p.o = glm(vax.cat ~ c_big5o_dv
                        , data = df
                        , family=binomial())




### Loneliness
table(df$cf_sclonely_cv, useNA='ifany')

m.lone = glm(vax.cat ~ as.numeric(cf_sclonely_cv)
            , data = df
            , family=binomial())



### Social isolation
table(df$j_scisolate, useNA='ifany')

m.isol = glm(vax.cat ~ as.numeric(j_scisolate)
                        , data = df
                        , family=binomial())



### Stargazer
ci.p.n = exp(confint(standardize(m.p.n)))
ci.p.a = exp(confint(standardize(m.p.a)))
ci.p.e = exp(confint(standardize(m.p.e)))
ci.p.c = exp(confint(standardize(m.p.c)))
ci.p.o = exp(confint(standardize(m.p.o)))
ci.lone = exp(confint(standardize(m.lone)))
ci.isol = exp(confint(standardize(m.isol)))

custom.gdb.cis = list(m.p.n, m.p.a, m.p.e,  m.p.c, m.p.o, m.lone, m.isol)   


## For the ORs and CIs
stargazer(standardize(m.p.n),
          standardize(m.p.a),standardize(m.p.e),
          standardize(m.p.c),standardize(m.p.o),
          standardize(m.lone),standardize(m.isol),
  type='html', out='GDB-mods.htm',
  apply.coef = exp,
  ci.custom = custom.cat.cis,
  single.row=TRUE, digits=2
  , omit.table.layout = "n"
  , star.char=NULL, star.cutoffs=NA
#  , report='vcsp' # for p vals
)
