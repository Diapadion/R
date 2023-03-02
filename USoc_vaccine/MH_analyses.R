### Mental health analyses

library(arm)
library(stargazer)
library(effsize)



saveRDS(df, file='USoc.RDS')


MHcols = c('pidp','g','vax.cat','j_age_dv','female','non.white',
         'cmds' , 'cancer' , 'respir' , 'anyMorb',
         'Edu','shield','ghq.cat','cf_scghq2_dv','ghq.fact','ghq.bin',
         'anxiety','depress',#'schiz','manic','eating','ptsd',
         'otherMH','anyMH'
         #, 'j_scisolate','cf_sclonely_cv','j_sclfsato','cf_sclfsato', 'j_sclonely'
         )

ind = complete.cases(df[,..MHcols])
table(ind)

df.MH = df[ind,..MHcols]



### Saving df after processing - useful ###

#saveRDS(df.MH, file='df_MH-2.RDS')



### Test
# mh2test = glm(vax.cat ~ I(-1*g) + j_age_dv + female + non.white
#          , data = df.MH
#          , family=binomial())
# # summary(mh2test)



### Disorders

## Anxiety
anx.1 = glm(vax.cat ~ anxiety + j_age_dv + female + non.white
                    , data = df.MH
                    , family=binomial())
# summary(anx.1)


anx.2 = glm(vax.cat ~ anxiety + j_age_dv + female + non.white
            + cmds + cancer + respir
            , data = df.MH
            , family=binomial())
# summary(anx.2)


anx.3 = glm(vax.cat ~ anxiety + j_age_dv + female + non.white
            + shield
            , data = df.MH
            , family=binomial())
# summary(anx.3)


anx.4 = glm(vax.cat ~ anxiety + j_age_dv + female + non.white
            + Edu
            , data = df.MH
            , family=binomial())
# summary(anx.4)


anx.5 = glm(vax.cat ~ anxiety + j_age_dv + female + non.white
            + g
            , data = df.MH
            , family=binomial())
# summary(anx.5)


anx.6 = glm(vax.cat ~ anxiety + j_age_dv + female + non.white
            + cmds + cancer + respir 
            + shield + Edu + g
            , data = df.MH
            , family=binomial())
# summary(anx.6)



### Depression
dep.1 = glm(vax.cat ~ depress + j_age_dv + female + non.white
            , data = df.MH
            , family=binomial())
# summary(dep.1)


dep.2 = glm(vax.cat ~ depress + j_age_dv + female + non.white
            + cmds + cancer + respir
            , data = df.MH
            , family=binomial())
# summary(dep.2)


dep.3 = glm(vax.cat ~ depress + j_age_dv + female + non.white
            + shield
            , data = df.MH
            , family=binomial())
# summary(dep.3)


dep.4 = glm(vax.cat ~ depress + j_age_dv + female + non.white
            + Edu
            , data = df.MH
            , family=binomial())
# summary(dep.4)


dep.5 = glm(vax.cat ~ depress + j_age_dv + female + non.white
            + g
            , data = df.MH
            , family=binomial())
# summary(dep.5)


dep.6 = glm(vax.cat ~ depress + j_age_dv + female + non.white
            + cmds + cancer + respir 
            + shield + Edu + g
            , data = df.MH
            , family=binomial())
# summary(dep.6)



### Psychosis / schizophrenia
# scz.1 = glm(vax.cat ~ schiz + j_age_dv + female + non.white
#             , data = df.MH
#             , family=binomial())
# # summary(scz.1)
# 
# 
# scz.2 = glm(vax.cat ~ schiz + j_age_dv + female + non.white
#             + cmds + cancer + respir
#             , data = df.MH
#             , family=binomial())
# # summary(scz.2)
# 
# 
# scz.3 = glm(vax.cat ~ schiz + j_age_dv + female + non.white
#             + shield
#             , data = df.MH
#             , family=binomial())
# # summary(scz.3)
# 
# 
# scz.4 = glm(vax.cat ~ schiz + j_age_dv + female + non.white
#             + Edu
#             , data = df.MH
#             , family=binomial())
# # summary(scz.4)
# 
# 
# scz.5 = glm(vax.cat ~ schiz + j_age_dv + female + non.white
#             + g
#             , data = df.MH
#             , family=binomial())
# # summary(scz.5)
# 
# 
# scz.6 = glm(vax.cat ~ schiz + j_age_dv + female + non.white
#             + cmds + cancer + respir 
#             + shield + Edu + g
#             , data = df.MH
#             , family=binomial())
# # summary(scz.6)
# 
# 
# 
# ### Bipolar / manic-depressive
# bip.1 = glm(vax.cat ~ manic + j_age_dv + female + non.white
#             , data = df.MH
#             , family=binomial())
# # summary(bip.1)
# 
# 
# bip.2 = glm(vax.cat ~ manic + j_age_dv + female + non.white
#             + cmds + cancer + respir
#             , data = df.MH
#             , family=binomial())
# # summary(bip.2)
# 
# 
# bip.3 = glm(vax.cat ~ manic + j_age_dv + female + non.white
#             + shield
#             , data = df.MH
#             , family=binomial())
# # summary(bip.3)
# 
# 
# bip.4 = glm(vax.cat ~ manic + j_age_dv + female + non.white
#             + Edu
#             , data = df.MH
#             , family=binomial())
# # summary(bip.4)
# 
# 
# bip.5 = glm(vax.cat ~ manic + j_age_dv + female + non.white
#             + g
#             , data = df.MH
#             , family=binomial())
# # summary(bip.5)
# 
# 
# bip.6 = glm(vax.cat ~ manic + j_age_dv + female + non.white
#             + cmds + cancer + respir 
#             + shield + Edu + g
#             , data = df.MH
#             , family=binomial())
# # summary(bip.6)
# 
# 
# 
# ### Eating disorder
# eat.1 = glm(vax.cat ~ eating + j_age_dv + female + non.white
#             , data = df.MH
#             , family=binomial())
# # summary(eat.1)
# 
# 
# eat.2 = glm(vax.cat ~ eating + j_age_dv + female + non.white
#             + cmds + cancer + respir
#             , data = df.MH
#             , family=binomial())
# # summary(eat.2)
# 
# 
# eat.3 = glm(vax.cat ~ eating + j_age_dv + female + non.white
#             + shield
#             , data = df.MH
#             , family=binomial())
# # summary(eat.3)
# 
# 
# eat.4 = glm(vax.cat ~ eating + j_age_dv + female + non.white
#             + Edu
#             , data = df.MH
#             , family=binomial())
# # summary(eat.4)
# 
# 
# eat.5 = glm(vax.cat ~ eating + j_age_dv + female + non.white
#             + g
#             , data = df.MH
#             , family=binomial())
# # summary(eat.5)
# 
# 
# eat.6 = glm(vax.cat ~ eating + j_age_dv + female + non.white
#             + cmds + cancer + respir 
#             + shield + Edu + g
#             , data = df.MH
#             , family=binomial())
# # summary(eat.6)
# 
# 
# 
# ### PTSD
# pts.1 = glm(vax.cat ~ ptsd + j_age_dv + female + non.white
#             , data = df.MH
#             , family=binomial())
# # summary(pts.1)
# 
# 
# pts.2 = glm(vax.cat ~ ptsd + j_age_dv + female + non.white
#             + cmds + cancer + respir
#             , data = df.MH
#             , family=binomial())
# # summary(pts.2)
# 
# 
# pts.3 = glm(vax.cat ~ ptsd + j_age_dv + female + non.white
#             + shield
#             , data = df.MH
#             , family=binomial())
# # summary(pts.3)
# 
# 
# pts.4 = glm(vax.cat ~ ptsd + j_age_dv + female + non.white
#             + Edu
#             , data = df.MH
#             , family=binomial())
# # summary(pts.4)
# 
# 
# pts.5 = glm(vax.cat ~ ptsd + j_age_dv + female + non.white
#             + g
#             , data = df.MH
#             , family=binomial())
# # summary(pts.5)
# 
# 
# pts.6 = glm(vax.cat ~ ptsd + j_age_dv + female + non.white
#             + cmds + cancer + respir 
#             + shield + Edu + g
#             , data = df.MH
#             , family=binomial())
# # summary(pts.6)



### Other
oth.1 = glm(vax.cat ~ otherMH + j_age_dv + female + non.white
            , data = df.MH
            , family=binomial())
# summary(oth.1)


oth.2 = glm(vax.cat ~ otherMH + j_age_dv + female + non.white
            + cmds + cancer + respir
            , data = df.MH
            , family=binomial())
# summary(oth.2)


oth.3 = glm(vax.cat ~ otherMH + j_age_dv + female + non.white
            + shield
            , data = df.MH
            , family=binomial())
# summary(oth.3)


oth.4 = glm(vax.cat ~ otherMH + j_age_dv + female + non.white
            + Edu
            , data = df.MH
            , family=binomial())
# summary(oth.4)


oth.5 = glm(vax.cat ~ otherMH + j_age_dv + female + non.white
            + g
            , data = df.MH
            , family=binomial())
# summary(oth.5)


oth.6 = glm(vax.cat ~ otherMH + j_age_dv + female + non.white
            + cmds + cancer + respir 
            + shield + Edu + g
            , data = df.MH
            , family=binomial())
# summary(oth.6)


### any MH condition
any.1 = glm(vax.cat ~ anyMH + j_age_dv + female + non.white
            , data = df.MH
            , family=binomial())
# summary(any.1)


any.2 = glm(vax.cat ~ anyMH + j_age_dv + female + non.white
            + cmds + cancer + respir
            , data = df.MH
            , family=binomial())
# summary(any.2)


any.3 = glm(vax.cat ~ anyMH + j_age_dv + female + non.white
            + shield
            , data = df.MH
            , family=binomial())
# summary(any.3)


any.4 = glm(vax.cat ~ anyMH + j_age_dv + female + non.white
            + Edu
            , data = df.MH
            , family=binomial())
# summary(any.4)


any.5 = glm(vax.cat ~ anyMH + j_age_dv + female + non.white
            + g
            , data = df.MH
            , family=binomial())
# summary(any.5)


any.6 = glm(vax.cat ~ anyMH + j_age_dv + female + non.white
            + cmds + cancer + respir 
            + shield + Edu + g
            , data = df.MH
            , family=binomial())
# summary(any.6)



### Physical health morbities

## Carbiometabolic
cmds.1 = glm(vax.cat ~ cmds + j_age_dv + female + non.white
            , data = df.MH
            , family=binomial())
# summary(cmds.1)


cmds.2 = glm(vax.cat ~ cmds + j_age_dv + female + non.white
            + anyMH
            , data = df.MH
            , family=binomial())
# summary(cmds.2)


cmds.3 = glm(vax.cat ~ cmds + j_age_dv + female + non.white
            + shield
            , data = df.MH
            , family=binomial())
# summary(cmds.3)


cmds.4 = glm(vax.cat ~ cmds + j_age_dv + female + non.white
            + Edu
            , data = df.MH
            , family=binomial())
# summary(cmds.4)


cmds.5 = glm(vax.cat ~ cmds + j_age_dv + female + non.white
            + g
            , data = df.MH
            , family=binomial())
# summary(cmds.5)


cmds.6 = glm(vax.cat ~ cmds + j_age_dv + female + non.white
            + anyMH
            + shield + Edu + g
            , data = df.MH
            , family=binomial())
# summary(cmds.6)


## Cancer
cancer.1 = glm(vax.cat ~ cancer + j_age_dv + female + non.white
             , data = df.MH
             , family=binomial())
summary(cancer.1)


cancer.2 = glm(vax.cat ~ cancer + j_age_dv + female + non.white
             + anyMH
             , data = df.MH
             , family=binomial())
summary(cancer.2)


cancer.3 = glm(vax.cat ~ cancer + j_age_dv + female + non.white
             + shield
             , data = df.MH
             , family=binomial())
# summary(cancer.3)


cancer.4 = glm(vax.cat ~ cancer + j_age_dv + female + non.white
             + Edu
             , data = df.MH
             , family=binomial())
# summary(cancer.4)


cancer.5 = glm(vax.cat ~ cancer + j_age_dv + female + non.white
             + g
             , data = df.MH
             , family=binomial())
# summary(cancer.5)


cancer.6 = glm(vax.cat ~ cancer + j_age_dv + female + non.white
             + anyMH
             + shield + Edu + g
             , data = df.MH
             , family=binomial())
# summary(cancer.6)


## Respiratory
t.test(vax.cat~respir, data=df)
chisq.test(df$vax.cat,df$respir)
respir.0 = glm(vax.cat ~ respir
               , data = df
               , family=binomial())
respir.0a = glm(vax.cat ~ respir + j_age_dv
               , data = df.MH
               , family=binomial())
respir.0s = glm(vax.cat ~ respir + female
               , data = df.MH
               , family=binomial())
respir.0e = glm(vax.cat ~ respir + non.white
               , data = df.MH
               , family=binomial())
# summary(respir.0)


t.test(vax.cat~cancer, data=df)
chisq.test(df.MH$vax.cat,df.MH$cancer)
cancer.0 = glm(vax.cat ~ cancer, data=df.MH)
cancer.0as = glm(vax.cat ~ cancer + female, data=df.MH)
# summary(cancer.0as)



respir.1 = glm(vax.cat ~ respir + j_age_dv + female + non.white
             , data = df.MH
             , family=binomial())
# summary(respir.1)


respir.2 = glm(vax.cat ~ respir + j_age_dv + female + non.white
             + anyMH
             , data = df.MH
             , family=binomial())
# summary(respir.2)


respir.3 = glm(vax.cat ~ respir + j_age_dv + female + non.white
             + shield
             , data = df.MH
             , family=binomial())
# summary(respir.3)


respir.4 = glm(vax.cat ~ respir + j_age_dv + female + non.white
             + Edu
             , data = df.MH
             , family=binomial())
# summary(respir.4)


respir.5 = glm(vax.cat ~ respir + j_age_dv + female + non.white
             + g
             , data = df.MH
             , family=binomial())
# summary(respir.5)


respir.6 = glm(vax.cat ~ respir + j_age_dv + female + non.white
             + anyMH
             + shield + Edu + g
             , data = df.MH
             , family=binomial())
# summary(respir.6)


## Any morbidity
anyMorb.1 = glm(vax.cat ~ anyMorb + j_age_dv + female + non.white
             , data = df.MH
             , family=binomial())
# summary(anyMorb.1)


anyMorb.2 = glm(vax.cat ~ anyMorb + j_age_dv + female + non.white
             + anyMH
             , data = df.MH
             , family=binomial())
# summary(anyMorb.2)


anyMorb.3 = glm(vax.cat ~ anyMorb + j_age_dv + female + non.white
             + shield
             , data = df.MH
             , family=binomial())
# summary(anyMorb.3)


anyMorb.4 = glm(vax.cat ~ anyMorb + j_age_dv + female + non.white
             + Edu
             , data = df.MH
             , family=binomial())
# summary(anyMorb.4)


anyMorb.5 = glm(vax.cat ~ anyMorb + j_age_dv + female + non.white
             + g
             , data = df.MH
             , family=binomial())
# summary(anyMorb.5)


anyMorb.6 = glm(vax.cat ~ anyMorb + j_age_dv + female + non.white
             + anyMH
             + shield + Edu + g
             , data = df.MH
             , family=binomial())
# summary(anyMorb.6)


### Shielding
shield.1 = glm(vax.cat ~ shield + j_age_dv + female + non.white
               , data = df.MH
               , family=binomial())

shield.2 = glm(vax.cat ~ shield + j_age_dv + female + non.white
               + anyMH
               , data = df.MH
               , family=binomial())

shield.4 = glm(vax.cat ~ shield + j_age_dv + female + non.white
               + Edu
               , data = df.MH
               , family=binomial())

shield.5 = glm(vax.cat ~ shield + j_age_dv + female + non.white
               + g
               , data = df.MH
               , family=binomial())

shield.6 = glm(vax.cat ~ shield + j_age_dv + female + non.white
                + anyMH
                + Edu + g
                , data = df.MH
                , family=binomial())

# exp(coef(shield.6))
# exp(confint(shield.6))



### Psychological distress

### Age + sex + ethnicity
ghq.1 = glm(vax.cat ~ I(-1*cf_scghq2_dv) + j_age_dv + female + non.white
         , data = df.MH
         , family=binomial())

ghq.1cat = glm(vax.cat ~ ghq.cat + j_age_dv + female + non.white
            , data = df.MH
            , family=binomial())

ghq.1bin = glm(vax.cat ~ ghq.bin + j_age_dv + female + non.white
               , data = df.MH
               , family=binomial())

ghq.1q = glm(vax.cat ~ I(-1*cf_scghq2_dv^2) + j_age_dv + female + non.white
            , data = df.MH
            , family=binomial())

# summary(standardize(ghq.1))
# summary(standardize(ghq.1q))
exp(ghq.1q$coefficients)
# summary(standardize(ghq.1cat))


ghq.2 = glm(vax.cat ~ I(-1*cf_scghq2_dv) + j_age_dv + female + non.white
            + cmds + cancer + respir
            , data = df.MH
            , family=binomial())

ghq.2cat = glm(vax.cat ~ ghq.cat + j_age_dv + female + non.white
               + cmds + cancer + respir
               , data = df.MH
               , family=binomial())

# summary(standardize(ghq.2))
# summary(standardize(ghq.2cat))


ghq.3 = glm(vax.cat ~ I(-1*cf_scghq2_dv) + j_age_dv + female + non.white
            + shield
            , data = df.MH
            , family=binomial())

ghq.3cat = glm(vax.cat ~ ghq.cat + j_age_dv + female + non.white
               + shield
               , data = df.MH
               , family=binomial())

# summary(standardize(ghq.3))
# summary(standardize(ghq.3cat))


ghq.4 = glm(vax.cat ~ I(-1*cf_scghq2_dv) + j_age_dv + female + non.white
            + Edu
              , data = df.MH
            , family=binomial())

ghq.4cat = glm(vax.cat ~ ghq.cat + j_age_dv + female + non.white
               + Edu
                 , data = df.MH
               , family=binomial())

# summary(standardize(ghq.4))
# summary(standardize(ghq.4cat))


ghq.5 = glm(vax.cat ~ I(-1*cf_scghq2_dv) + j_age_dv + female + non.white
            + g
              , data = df.MH
            , family=binomial())

ghq.5cat = glm(vax.cat ~ ghq.cat + j_age_dv + female + non.white
               + g
                 , data = df.MH
               , family=binomial())

# summary(standardize(ghq.5))
# summary(standardize(ghq.5cat))


ghq.6 = glm(vax.cat ~ I(-1*cf_scghq2_dv) + j_age_dv + female + non.white
            + cmds + cancer + respir 
            + shield + Edu + g
              , data = df.MH
            , family=binomial())

ghq.6cat = glm(vax.cat ~ ghq.cat + j_age_dv + female + non.white
               + cmds + cancer + respir 
               + shield + Edu + g
                 , data = df.MH
               , family=binomial())

ghq.6q = glm(vax.cat ~ I(-1*cf_scghq2_dv^2) + j_age_dv + female + non.white
            + cmds + cancer + respir 
            + shield + Edu + g
            , data = df.MH
            , family=binomial())

# summary(standardize(ghq.6))
# summary(standardize(ghq.6q))
# summary(standardize(ghq.6cat))



######################


# ### Loneliness (before)
# lone.b.1 = glm(vax.cat ~ as.integer(j_sclonely) + j_age_dv + female + non.white
#              , data = df.MH
#              , family=binomial())
# lone.b.1cat = glm(vax.cat ~ j_sclonely + j_age_dv + female + non.white
#                 , data = df.MH
#                 , family=binomial())
# # summary(lone.b.1cat)
# confint(lone.b.1cat)
# 
# 
# lone.b.6 = glm(vax.cat ~ as.integer(j_sclonely) + j_age_dv + female + non.white
#              + cmds + cancer + respir 
#              + shield + Edu + g
#              , data = df.MH
#              , family=binomial())
# lone.b.6cat = glm(vax.cat ~ j_sclonely + j_age_dv + female + non.white
#                 + cmds + cancer + respir 
#                 + shield + Edu + g                
#                 , data = df.MH
#                 , family=binomial())
# # summary(lone.b.6cat)
# 
# 
# ### Loneliness (during)
# lone.1 = glm(vax.cat ~ as.integer(cf_sclonely_cv) + j_age_dv + female + non.white
#             , data = df.MH
#             , family=binomial())
# lone.1cat = glm(vax.cat ~ cf_sclonely_cv + j_age_dv + female + non.white
#              , data = df.MH
#              , family=binomial())
# # summary(lone.1cat)
# confint(lone.1cat)
# 
# 
# lone.6 = glm(vax.cat ~ as.integer(cf_sclonely_cv) + j_age_dv + female + non.white
#              + cmds + cancer + respir 
#              + shield + Edu + g
#              , data = df.MH
#              , family=binomial())
# lone.6cat = glm(vax.cat ~ cf_sclonely_cv + j_age_dv + female + non.white
#                 + cmds + cancer + respir 
#                 + shield + Edu + g                
#                 , data = df.MH
#                 , family=binomial())
# # summary(lone.6cat)
# 
# 
# 
# ### Social isolation
# iso.1 = glm(vax.cat ~ as.integer(j_scisolate) + j_age_dv + female + non.white
#              , data = df.MH
#              , family=binomial())
# iso.1cat = glm(vax.cat ~ j_scisolate + j_age_dv + female + non.white
#                 , data = df.MH
#                 , family=binomial())
# # summary(iso.1cat)
# 
# 
# iso.6 = glm(vax.cat ~ as.integer(j_scisolate) + j_age_dv + female + non.white
#             + cmds + cancer + respir 
#             + shield + Edu + g                
#             , data = df.MH
#             , family=binomial())
# iso.6cat = glm(vax.cat ~ j_scisolate + j_age_dv + female + non.white
#                + cmds + cancer + respir 
#                + shield + Edu + g                   
#                , data = df.MH
#                , family=binomial())
# # summary(iso.6cat)
# 
# 
# 
# ### Life satisfaction (before)
# lsb.1 = glm(vax.cat ~ as.integer(j_sclfsato) + j_age_dv + female + non.white
#             , data = df.MH
#             , family=binomial())
# lsb.1cat = glm(vax.cat ~ j_sclfsato + j_age_dv + female + non.white
#                , data = df.MH
#                , family=binomial())
# # summary(lsb.1)
# 
# 
# 
# ### Life satisfaction (during)
# lsd.1 = glm(vax.cat ~ as.integer(cf_sclfsato) + j_age_dv + female + non.white
#             , data = df.MH
#             , family=binomial())
# lsd.1cat = glm(vax.cat ~ cf_sclfsato + j_age_dv + female + non.white
#                , data = df.MH
#                , family=binomial())
# # summary(lsd.1)





