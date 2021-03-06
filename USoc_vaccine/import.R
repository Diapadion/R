### Importing and processing

library(readstata13)
library(data.table)
library(forcats)



sort( sapply(ls(),function(x){object.size(get(x))})) 

object.size(x=lapply(ls(), get))
print(object.size(x=lapply(ls(), get)), units="Mb")



### post-processed import
df.MH = readRDS('df_MH.RDS')



## Wave 10 - COVID



#df.bl = read.dta13("../../../../ownCloud/DocSyncUoE/data/UnderstandingSociety/stata/stata13_se/xbaseline.dta")

#df.samp = read.dta13("../../../../ownCloud/DocSyncUoE/data/UnderstandingSociety/stata/stata13_se/xsample.dta")


df.apr = as.data.table(read.dta13("../../../../ownCloud/DocSyncUoE/data/UnderstandingSociety/stata/stata13_se/ca_indresp_w.dta"))

df.may = as.data.table(read.dta13("../../../../ownCloud/DocSyncUoE/data/UnderstandingSociety/stata/stata13_se/cb_indresp_w.dta"))

df.june = as.data.table(read.dta13("../../../../ownCloud/DocSyncUoE/data/UnderstandingSociety/stata/stata13_se/cc_indresp_w.dta")) # extra shielding info

df.july = as.data.table(read.dta13("../../../../ownCloud/DocSyncUoE/data/UnderstandingSociety/stata/stata13_se/cd_indresp_w.dta"))

df.sept = as.data.table(read.dta13("../../../../ownCloud/DocSyncUoE/data/UnderstandingSociety/stata/stata13_se/ce_indresp_w.dta"))

df.apr = df.apr[,c('pidp','ca_nhsshield')] 
df.may = df.may[,c('pidp','cb_nhsshield')] 
df.june = df.june[,c('pidp','cc_nhsshield','cc_hhshield')]
df.july = df.july[,c('pidp','cd_nhsshield')]
df.sept = df.sept[,c('pidp','ce_nhsshield')]


## this one for vaccine vars
df.nov = read.dta13("../../../../ownCloud/DocSyncUoE/data/UnderstandingSociety/stata/stata13_se/cf_indresp_w.dta")



## Wave 1 - social class?
#df.w1 = read.dta13("../../../../ownCloud/DocSyncUoE/data/UnderstandingSociety/stata/stata13_se/ukhls_w1/a_indresp.dta")

## Wave 3 - personality and cognitive function
df.w3 = as.data.table(read.dta13("../../../../ownCloud/DocSyncUoE/data/UnderstandingSociety/stata/stata13_se/ukhls_w3/c_indresp.dta"))


## Wave 10 - same time as COVID
df.w10 = as.data.table(read.dta13("../../../../ownCloud/DocSyncUoE/data/UnderstandingSociety/stata/stata13_se/ukhls_w10/j_indresp.dta"))



## Merge
df = merge(df.w3, df.w10, by.x='pidp', by.y='pidp', all=TRUE)

## needed? <
df = merge(df, df.apr, by.x='pidp', by.y='pidp', all=TRUE)
df = merge(df, df.may, by.x='pidp', by.y='pidp', all=TRUE)
df = merge(df, df.june, by.x='pidp', by.y='pidp', all=TRUE)
df = merge(df, df.july, by.x='pidp', by.y='pidp', all=TRUE)
df = merge(df, df.sept, by.x='pidp', by.y='pidp', all=TRUE)
## >
df = merge(df, df.nov, by.x='pidp', by.y='pidp', all=FALSE)


rm(df.w10)
#...



### Processing ###

### Vaccination
table(df$cf_vaxxer, useNA='ifany')

table(df$cf_vaxno, useNA='ifany')
table(df$cf_vaxwhy, useNA='ifany')
# table(df.nov$cf_vaxpush1, useNA='ifany')

df$vax.cat = df$cf_vaxxer
df$vax.cat[df$vax.cat%in%c('missing','inapplicable','refusal','don\'t know')] = NA
df$vax.cat[df$vax.cat%in%c('Very likely','Likely')] = 'Likely'
df$vax.cat[df$vax.cat%in%c('Very unlikely','Unlikely')] = 'Unlikely'
#table(as.integer(df$vax.cat))
df$vax.cat = as.integer(df$vax.cat) - 6



### Shielding
table(df$ca_nhsshield,df$cb_nhsshield, useNA='ifany')

df$shield = df$ca_nhsshield

ind=NULL

for (i in 1:dim(df)[1]){
ind[i] = isTRUE(df$cc_hhshield[i] == 'Yes')|isTRUE(df$cb_nhsshield[i] == 'Yes')|
  isTRUE(df$cc_nhsshield[i] == 'Yes')|isTRUE(df$cd_nhsshield[i] == 'Yes')|
  isTRUE(df$ce_nhsshield[i] == 'Yes')
}
#table(ind, useNA='ifany')

df$shield[ind] = 'Yes'

df$shield[df$shield=='Don\'t know'] = NA
df$shield = -1 *(as.integer(df$shield) - 6)

table(df$shield, useNA='ifany')

# table(df$cc_hhshield, useNA='ifany')
# df$shield.hh = df$cc_hhshield
# df$shield.hh[df$shield.hh %in% c('Missing','Inapplicable','Refusal','Don\'t know')] = NA
# df$shield.hh = -1 * (as.numeric(df$shield.hh) - 6)
# table(df$shield.hh, useNA='ifany')



### Age
table(df$j_age_dv, useNA='ifany')
#df.w3$c_age_dv[df.w3$c_age_dv==-9] = NA
# table(df.w10$c_age_dv, useNA='ifany')
# df.w3$c_age_dv[df.w3$c_age_dv==-9] = NA



### Sex
table(df$j_sex, useNA='ifany') # other levels already eliminated
df$female = 0
df$female[df$j_sex=='female'] = 1
df$female[is.na(df$j_sex)] = NA
table(df$female, useNA='ifany')



## Ethnicity
table(df$j_ethn_dv, useNA='ifany')
df$j_ethn_dv[df$j_ethn_dv==-9] = NA
## > 4 are non-white bkgd
df$non.white = df$j_ethn_dv
df$non.white[df$non.white<=4] = 0
df$non.white[df$non.white>4] = 1
#table(df$non.white)



## Education
table(df$j_qfhigh_dv, useNA='ifany')
## University ed = Higher degree, 1st degree..., thru Other higher degree
# table(df.w3$c_qfhighfl_dv, useNA='ifany') #?
# table(df.w3$c_qfhigh, useNA='ifany') #?

df$Edu = df$j_qfhigh_dv
df$Edu[df$Edu%in%c('missing','inapplicable')] = NA
df$Edu[df$Edu%in%c(' Higher degree','1st degree or equivalent',
                             'Diploma in he','Teaching qual not pgce',
                             'Nursing/other med qual','Other higher degree')] = 
  'Higher degree'
df$Edu[df$Edu%in%c('A level','Welsh baccalaureate',
                             'I\'nationl baccalaureate','AS level',
                             'Highers (scot)','Cert 6th year studies')] = 
  'AS level'
df$Edu[df$Edu%in%c('GCSE/O level','CSE','Standard/o/lower')] = 
  'GCSE/O level'
df$Edu[df$Edu%in%c('Other school cert','None of the above')] = 
  'Other school cert'
df$Edu = droplevels(fct_rev(df$Edu))

table(df$Edu, useNA='ifany')

df$HigherEd = 0
df$HigherEd[df$Edu=='Higher degree'] = 1
df$HigherEd[is.na(df$Edu)] = NA
table(df$HigherEd, useNA='ifany')

df$NoHigherEd = (df$HigherEd - 1) * -1
table(df$NoHigherEd, useNA='ifany')



## Neighborhood deprivation - NA 


## Low occupational social class
# table(df.w3$c_j1nssec8_dv, useNA='ifany') # mostly missing
table(df$j_jbrgsc_dv, useNA='ifany') # slightly better

table(df$j_jbnssec3_dv, useNA='ifany') # slightly better
##  (4735, 21639) seems to always be 'inapplicable'

## Use
table(df$j_jbnssec8_dv, useNA='ifany')
## for now
df$soc.class = df$j_jbnssec8_dv
df$soc.class[df$soc.class %in% c('missing','inapplicable')] = NA

df$low.soc.class = df$j_jbnssec3_dv
df$low.soc.class[df$low.soc.class %in% c('missing','inapplicable')] = NA
df$low.soc.class[df$low.soc.class == 'Management & professional'] = 'Intermediate'
df$low.soc.class = as.numeric(df$low.soc.class) - 7
table(df$low.soc.class)

## Wave 3?
table(df$c_jbnssec8_dv, useNA='ifany')
df$soc.class.w3 = df$c_jbnssec8_dv
df$soc.class.w3[df$soc.class.w3 %in% c('missing','inapplicable')] = NA
table(df$soc.class.w3, useNA='ifany')

## Wave 1?
# table(df$a_jbnssec8_dv, useNA='ifany')
# df$soc.class.w1 = df$a_jbnssec8_dv
# df$soc.class.w1[df$soc.class.w1 %in% c('missing','inapplicable')] = NA
# table(df$soc.class.w1, useNA='ifany')



## Accommodation statuses?
table(df$j_hsowned)



## Cardiometabolic disease(s)
table(df$j_hcondever3, useNA='ifany') # congestive heart failure
table(df$j_hcondever4, useNA='ifany') # coronary heart disease
table(df$j_hcondever5, useNA='ifany') # angina
table(df$j_hcondever6, useNA='ifany') # heart attack or infarction
table(df$j_hcondever7, useNA='ifany') # stroke
table(df$j_hcondever14, useNA='ifany') # diabetes
table(df$j_hcondever16, useNA='ifany') # high BP

df$cmds = df$j_hcondever16 
df$cmds[df$cmds %in% c('inapplicable','proxy','refusal','don\'t know')] = NA
df$cmds = droplevels(df$cmds)
levels(df$cmds) = c('No','Yes')
df$cmds[df$j_hcondever3=='Yes mentioned'] = 'Yes'
df$cmds[df$j_hcondever4=='Yes mentioned'] = 'Yes'
df$cmds[df$j_hcondever5=='Yes mentioned'] = 'Yes'
df$cmds[df$j_hcondever6=='Yes mentioned'] = 'Yes'
df$cmds[df$j_hcondever7=='Yes mentioned'] = 'Yes'
df$cmds[df$j_hcondever14=='Yes mentioned'] = 'Yes'
df$cmds[df$j_hcondever16=='Yes mentioned'] = 'Yes'

table(df$cmds)



## Cancers
table(df$j_hcondever13, useNA='ifany') # "cancer or malignancy"

table(df$j_hconds27)
table(df$j_hconds28)
table(df$j_hconds29)
table(df$j_hconds30)
table(df$j_hconds31)

table(df$j_hcondcode27)
table(df$j_hcondcode28)
table(df$j_hcondcode29)

df$cancer = 0
df$cancer[df$j_hcondever13=='Yes mentioned'] = 1
df$cancer[df$j_hcondever13 %in% c('inapplicable','proxy','refusal','don\'t know')] = NA
df$cancer[is.na(df$j_hcondever13)] = NA          
table(df$cancer)
  

## Respiratory disease
table(df$j_hcondever11, useNA='ifany') # chronic bronchitis
table(df$j_hcondever1, useNA='ifany') # asthma
table(df$j_hcondever8, useNA='ifany') # emphysema
table(df$j_hcondever21, useNA='ifany') # COPD

df$respir = df$j_hcondever1
df$respir[df$respir %in% c('inapplicable','proxy','refusal','don\'t know')] = NA
df$respir = droplevels(df$respir)
levels(df$respir) = c('No','Yes')
df$respir[df$j_hcondever11=='Yes mentioned'] = 'Yes'
df$respir[df$j_hcondever8=='Yes mentioned'] = 'Yes'
df$respir[df$j_hcondever21=='Yes mentioned'] = 'Yes'

table(df$respir)


## Any of the above physical health morbidities
df$anyMorb = df$respir
df$anyMorb[df$cmds=='Yes'] = 'Yes'
df$anyMorb[df$cancer=='Yes'] = 'Yes'
table(df$anyMorb)



### Mental health diagnoses
table(df$j_hcondncode37, useNA='ifany') # anxiety
df$anxiety = df$j_hcondncode37
df$anxiety[df$anxiety %in% c('inapplicable','proxy','refusal','don\'t know')] = NA
df$anxiety = droplevels(df$anxiety)
levels(df$anxiety) = c('No','Yes')

table(df$j_hcondncode38, useNA='ifany') # depression
df$depress = df$j_hcondncode38
df$depress[df$depress %in% c('inapplicable','proxy','refusal','don\'t know')] = NA
df$depress = droplevels(df$depress)
levels(df$depress) = c('No','Yes')

table(df$j_hcondncode39, useNA='ifany') # psychosis/schiz
df$schiz = df$j_hcondncode39
df$schiz[df$schiz %in% c('inapplicable','proxy','refusal','don\'t know')] = NA
df$schiz = droplevels(df$schiz)
levels(df$schiz) = c('No','Yes')

table(df$j_hcondncode40, useNA='ifany') # bipolar/manic
df$manic = df$j_hcondncode40
df$manic[df$manic %in% c('inapplicable','proxy','refusal','don\'t know')] = NA
df$manic = droplevels(df$manic)
levels(df$manic) = c('No','Yes')

table(df$j_hcondncode41, useNA='ifany') # eating
df$eating = df$j_hcondncode41
df$eating[df$eating %in% c('inapplicable','proxy','refusal','don\'t know')] = NA
df$eating = droplevels(df$eating)
levels(df$eating) = c('No','Yes')

table(df$j_hcondncode42, useNA='ifany') # PTSD
df$ptsd = df$j_hcondncode42
df$ptsd[df$ptsd %in% c('inapplicable','proxy','refusal','don\'t know')] = NA
df$ptsd = droplevels(df$ptsd)
levels(df$ptsd) = c('No','Yes')

table(df$j_hcondncode43, useNA='ifany') # other
df$otherMH = df$j_hcondncode43
df$otherMH[df$otherMH %in% c('inapplicable','proxy','refusal','don\'t know')] = NA
df$otherMH = droplevels(df$otherMH)
levels(df$otherMH) = c('No','Yes')
df$otherMH[df$schiz=='Yes'] = 'Yes'
df$otherMH[df$manic=='Yes'] = 'Yes'
df$otherMH[df$eating=='Yes'] = 'Yes'
df$otherMH[df$ptsd=='Yes'] = 'Yes'
table(df$otherMH)

df$anyMH = df$anxiety
df$anyMH[df$depress=='Yes'] = 'Yes'
df$anyMH[df$schiz=='Yes'] = 'Yes'
df$anyMH[df$manic=='Yes'] = 'Yes'
df$anyMH[df$eating=='Yes'] = 'Yes'
df$anyMH[df$ptsd=='Yes'] = 'Yes'
df$anyMH[df$otherMH=='Yes'] = 'Yes'
table(df$anyMH)



### Psychological distress
## GHQ
table(df$cf_scghq1_dv, useNA='ifany')
table(df$cf_scghq2_dv, useNA='ifany')

df$cf_scghq1_dv[df$cf_scghq1_dv==-9] = NA
df$cf_scghq2_dv[df$cf_scghq2_dv==-9] = NA

df$ghq.bin = df$cf_scghq2_dv 
df$ghq.bin[df$ghq.bin<=0] = 0 
df$ghq.bin[df$ghq.bin>0.5] = 1 
table(df$ghq.bin, useNA='ifany')

df$ghq.cat = cut(df$cf_scghq2_dv, c(-1,0.5,3.5,6.5,12.5))
levels(df$ghq.cat) = c('Asymptomatic','Subclinical','Symptomatic','High symptomatic')
table(df$ghq.cat)

df$ghq.fact = as.factor(df$cf_scghq2_dv)
table(df$ghq.fact)


# Life satisfaction
# Loneliness



### Personality

## Neuroticism
df$c_big5n_dv[df$c_big5n_dv %in% c(-9,-7,-8)] = NA
table(df$c_big5n_dv, useNA='ifany')

## Extraversion
df$c_big5e_dv[df$c_big5e_dv %in% c(-9,-7,-8)] = NA
table(df$c_big5e_dv, useNA='ifany')

## Conscientiousness
df$c_big5c_dv[df$c_big5c_dv %in% c(-9,-7,-8)] = NA
table(df$c_big5c_dv, useNA='ifany')

## Openness
df$c_big5o_dv[df$c_big5o_dv %in% c(-9,-7,-8)] = NA
table(df$c_big5o_dv, useNA='ifany')

## Agreeableness
df$c_big5a_dv[df$c_big5a_dv %in% c(-9,-7,-8)] = NA
table(df$c_big5a_dv, useNA='ifany')

  

### Cognitive variables

## Immediate recall
df$c_cgwri_dv[df$c_cgwri_dv %in% c(-2,-7,-8)] = NA
table(df$c_cgwri_dv, useNA='ifany')


## Delayed recall
df$c_cgwrd_dv[df$c_cgwrd_dv %in% c(-2,-7,-8)] = NA
table(df$c_cgwrd_dv, useNA='ifany')


## Verbal fluency
table(df$c_cgvfc_dv, useNA='ifany')
df$c_cgvfc_dv[df$c_cgvfc_dv %in% c(-9,-7,-8)] = NA


## Serial 7s
table(df$c_cgs7cs_dv, useNA='ifany')
df$c_cgs7cs_dv[df$c_cgs7cs_dv %in% c(-1,-2,-7,-8,-9)] = NA


## Number series
df$c_cgns1sc10_dv[df$c_cgns1sc10_dv %in% c(-1,-2,-7,-8,-9)] = NA
table(df$c_cgns1sc10_dv, useNA='ifany')

df$c_cgns2sc10_dv[df$c_cgns2sc10_dv %in% c(-1,-2,-7,-8,-9)] = NA
table(df$c_cgns2sc10_dv, useNA='ifany')

df$c_cgns_dv = df$c_cgns1sc10_dv
df$c_cgns_dv[is.na(df$c_cgns1sc10_dv)] = df$c_cgns2sc10_dv[is.na(df$c_cgns1sc10_dv)]

table(df$c_cgns_dv)


## Numerical problem solving
df$c_cgna_dv[df$c_cgna_dv %in% c(-1,-2,-7,-8,-9)] = NA
table(df$c_cgna_dv, useNA='ifany')




### Loneliness
df$cf_sclonely_cv[df$cf_sclonely_cv %in% c('missing','inapplicable','refusal','don\'t know')] = NA
df$cf_sclonely_cv = droplevels(df$cf_sclonely_cv)
levels(df$cf_sclonely_cv) 

## (Before)
df$j_sclonely[df$j_sclonely %in% c('proxy','missing','inapplicable','refusal','don\'t know')] = NA
df$j_sclonely = droplevels(df$j_sclonely)
levels(df$j_sclonely) 



### Social isolation (before)
df$j_scisolate[df$j_scisolate %in% c('missing','inapplicable','refusal','don\'t know','proxy')] = NA
df$j_scisolate = droplevels(df$j_scisolate)
levels(df$j_scisolate) 


### Life satisfaction (before and during)
table(df$j_sclfsato, useNA='ifany')
df$j_sclfsato[df$j_sclfsato %in% c('proxy','missing','inapplicable','refusal','don\'t know')] = NA
df$j_sclfsato = droplevels(df$j_sclfsato)
levels(df$j_sclfsato) 

table(df$cf_sclfsato, useNA='ifany')
df$cf_sclfsato[df$cf_sclfsato %in% c('proxy','missing','inapplicable','refusal','don\'t know')] = NA
df$cf_sclfsato = droplevels(df$cf_sclfsato)
levels(df$cf_sclfsato) 



### Area deprivation - Carstairs index
## https://bmcpublichealth.biomedcentral.com/articles/10.1186/s12889-018-5667-3
## would need to link to census


