### Personality domains


library(arm)



### Age + sex
m1.p = glm(vax.cat ~ c_big5n_dv + c_big5c_dv + c_big5e_dv + c_big5a_dv + c_big5o_dv
         + j_age_dv + j_sex
         , data = df
         , family=binomial())
summary(standardize(m1))



### Age + sex + ethnicity
m2.p = glm(vax.cat ~ c_big5n_dv + c_big5c_dv + c_big5e_dv + c_big5a_dv + c_big5o_dv 
         + j_age_dv + j_sex + non.white
         , data = df
         , family=binomial())
summary(standardize(m2))



### Age + sex + ethnicity + comorbidity
m3.p = glm(vax.cat ~ c_big5n_dv + c_big5c_dv + c_big5e_dv + c_big5a_dv + c_big5o_dv
         + j_age_dv + j_sex + non.white +
           cmds + j_hcondever13
         , data = df
         , family=binomial())
summary(standardize(m3))



### Age + sex + ethnicity + comorbidity + SES (- education)
m4.p = glm(vax.cat ~ c_big5n_dv + c_big5c_dv + c_big5e_dv + c_big5a_dv + c_big5o_dv
         + j_age_dv + j_sex + non.white +
           cmds + j_hcondever13 +
           soc.class
         , data = df
         , family=binomial())
summary(standardize(m4))



### Age + sex + ethnicity + comorbidity + SES
m5.p = glm(vax.cat ~ c_big5n_dv + c_big5c_dv + c_big5e_dv + c_big5a_dv + c_big5o_dv
         + j_age_dv + j_sex + non.white +
           cmds + j_hcondever13 +
           soc.class + HigherEd
         , data = df
         , family=binomial())
summary(standardize(m5))



### All 
m6.p = glm(vax.cat ~ c_big5n_dv + c_big5c_dv + c_big5e_dv + c_big5a_dv + c_big5o_dv
         + j_age_dv + j_sex + non.white +
           cmds + j_hcondever13 +
           soc.class + HigherEd +
           cf_scghq1_dv
         , data = df
         , family=binomial())
summary(standardize(m6))

