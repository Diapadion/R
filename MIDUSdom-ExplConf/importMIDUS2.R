library(Hmisc)
library(data.table)
library(psych)

#library(SAScii)


sort( sapply(ls(),function(x){object.size(get(x))})) 


## this only works when connected to the VPN or on a UoE desktop
# setwd("M:/")
# midus2 <- read.SAScii('./data/04652-0001-Data.txt','./data/04652-0001-Setup.sas') # project 1
# load('./data/29282-0001-Data.rda') # project 4
# load('./data/25281-0001-Data.rda') # project 3
# 
# midus2 = merge(midus2, da25281.0001, by='M2ID', all=TRUE)
# midus2 = merge(midus2, da29282.0001, by='M2ID', all=TRUE)
# 
# midus2 = as.data.table(midus2)

#saveRDS(midus2, './data/merged.RDS')
midus2 <- readRDS('./data/merged.RDS')
#rm(da25281.0001, da29282.0001)
gc()



vars=c(
  'M2ID',
  # Personality
  'B1SAGENC','B1SEXTRA','B1SAGREE','B1SCONS2','B1SOPEN','B1SNEURO',
  
  'B1SE6A', #Outgoing'
  'B1SE6B', #Helpful'
  'B1SE6C', #Moody',
  'B1SE6D', #Organized'
  'B1SE6E', #Selfconfident'
  'B1SE6F', #Friendly'
  'B1SE6G', #Warm'
  'B1SE6H', #Worrying'
  'B1SE6I',#Responsible',
  'B1SE6J',#Forceful'
  'B1SE6K',#Lively',
  'B1SE6L',#Caring',
  'B1SE6M', #Nervous'
  'B1SE6N', #Creative'
  'B1SE6O', #Assertive',
  'B1SE6P', #Hardworking',
  'B1SE6Q', #Imaginative',
  'B1SE6R', #Softhearted',
  'B1SE6S', #Calm'
  'B1SE6T', #Outspoken',
  'B1SE6U', #Intelligent',
  'B1SE6V', #Curious',
  'B1SE6W', #Active',
  'B1SE6X', #Careless',
  'B1SE6Y', #Broadminded','
  'B1SE6Z', #Sympathetic',
  'B1SE6AA', #Talkative',
  'B1SE6BB', #Sophisticated',
  'B1SE6CC', #Adventurous',
  'B1SE6DD', #Dominant'
  'B1SE6EE', #Thorough
    #MPI EXTRAS
  'B1SE7E',
  'B1SE7J',
  'B1SE7N',
  'B1SE7DD',
  
  # Demographics
  'B1PAGE_M2.x', #age at M2P1 ----------> change in pre-reg
  'B1PRSEX', #sex
  
  # Affect
  'B1SPOSPA', #positive
  'B1SNEGPA', #negative
  
  # Psychological well-being
  'B1SPWBA1', #autonomy
  'B1SPWBE1', #environmental mastery
  'B1SPWBG1', #personal growth
  'B1SPWBR1', #Positive relations with others
  'B1SPWBU1', #Purpose in life
  'B1SPWBS1', #self acceptance
  
  'B1SMASTE', #Mastery
  'B1SCONST', #constraints
  
  'B4QAE_AI', # anger/in
  'B4QAE_AO', # anger/out
  'B4QAE_AC', # anger control
  
  'B3TEMZ3', #memory
  'B3TEFZ3', #executive function
   
  'B1SSPIRI', # spirituality
  'B1SRELID', # religiosity
  'B1SRELCB', # religious coping
  
  'B1SMARRS',  # marital risk
  'B1SSPDIS',  # s/p disagreement
  'B1SSPEMP', # support from s/p
  'B1SSPCRI', # strain from s/p
  'B1SSPSOL' # s/p affectual solidarity
  )
  
  
midus2 = midus2[,..vars]



### Cleaning

describe(midus2) # gives info on what sort of cleaning each var needs

midus2$B1SEXTRA[midus2$B1SEXTRA ==8] <- NA
midus2$B1SAGREE[midus2$B1SAGREE ==8] <- NA
midus2$B1SCONS2[midus2$B1SCONS2 ==8] <- NA
midus2$B1SOPEN[midus2$B1SOPEN ==8] <- NA
midus2$B1SNEURO[midus2$B1SNEURO ==8] <- NA
midus2$B1SAGENC[midus2$B1SAGENC ==8] <- NA

midus2$B1SE6A[midus2$B1SE6A ==8] <- NA
midus2$B1SE6B[midus2$B1SE6B ==8] <- NA
midus2$B1SE6C[midus2$B1SE6C ==8] <- NA
midus2$B1SE6D[midus2$B1SE6D ==8] <- NA
midus2$B1SE6E[midus2$B1SE6E ==8] <- NA
midus2$B1SE6F[midus2$B1SE6F ==8] <- NA
midus2$B1SE6G[midus2$B1SE6G ==8] <- NA
midus2$B1SE6H[midus2$B1SE6H ==8] <- NA
midus2$B1SE6I[midus2$B1SE6I ==8] <- NA
midus2$B1SE6J[midus2$B1SE6J ==8] <- NA
midus2$B1SE6K[midus2$B1SE6K ==8] <- NA
midus2$B1SE6L[midus2$B1SE6L ==8] <- NA
midus2$B1SE6M[midus2$B1SE6M ==8] <- NA
midus2$B1SE6N[midus2$B1SE6N ==8] <- NA
midus2$B1SE6O[midus2$B1SE6O ==8] <- NA
midus2$B1SE6P[midus2$B1SE6P ==8] <- NA
midus2$B1SE6Q[midus2$B1SE6Q ==8] <- NA
midus2$B1SE6R[midus2$B1SE6R ==8] <- NA
midus2$B1SE6S[midus2$B1SE6S ==8] <- NA
midus2$B1SE6T[midus2$B1SE6T ==8] <- NA
midus2$B1SE6U[midus2$B1SE6U ==8] <- NA
midus2$B1SE6V[midus2$B1SE6V ==8] <- NA
midus2$B1SE6W[midus2$B1SE6W ==8] <- NA
midus2$B1SE6X[midus2$B1SE6X ==8] <- NA
midus2$B1SE6Y[midus2$B1SE6Y ==8] <- NA
midus2$B1SE6Z[midus2$B1SE6Z ==8] <- NA
midus2$B1SE6AA[midus2$B1SE6AA ==8] <- NA
midus2$B1SE6BB[midus2$B1SE6BB ==8] <- NA
midus2$B1SE6CC[midus2$B1SE6CC ==8] <- NA
midus2$B1SE6DD[midus2$B1SE6DD==8] <- NA
midus2$B1SE6EE[midus2$B1SE6EE ==8] <- NA
midus2$B1SE7E[midus2$B1SE7E ==8] <- NA
midus2$B1SE7J[midus2$B1SE7J ==8] <- NA
midus2$B1SE7N[midus2$B1SE7N ==8] <- NA
midus2$B1SE7DD[midus2$B1SE7DD ==8] <- NA

midus2$B1PAGE_M2.x[midus2$B1PAGE_M2.x ==98] <- NA
midus2$B1PRSEX[midus2$B1PRSEX ==8] <- NA
midus2$B1PRSEX = -1*midus2$B1PRSEX + 2 # converts to 0 = female, 1 = male 

midus2$B1SPOSPA[midus2$B1SPOSPA ==8] <- NA
midus2$B1SNEGPA[midus2$B1SNEGPA ==8] <- NA

midus2$B1SPWBA1[midus2$B1SPWBA1 ==98] <- NA
midus2$B1SPWBE1[midus2$B1SPWBE1 ==98] <- NA
midus2$B1SPWBG1[midus2$B1SPWBG1 ==98] <- NA
midus2$B1SPWBR1[midus2$B1SPWBR1 ==98] <- NA
midus2$B1SPWBU1[midus2$B1SPWBU1 ==98] <- NA
midus2$B1SPWBS1[midus2$B1SPWBS1 ==98] <- NA

midus2$B1SMASTE[midus2$B1SMASTE ==8] <- NA
midus2$B1SCONST[midus2$B1SCONST ==8] <- NA

#table(midus2$B4QAE_AC,useNA = 'ifany')
## already cleaned
#midus2$B4QAE_AI[midus2$B4QAE_AI ==8] <- NA
#midus2$B4QAE_AO[midus2$B4QAE_AO ==8] <- NA
#midus2$B4QAE_AC[midus2$B4QAE_AC ==8] <- NA
#table(midus2$B3TEMZ3,useNA = 'ifany')
# 'B3TEMZ3', #memory
# 'B3TEFZ3 #executive function

table(midus2$B1SSPIRI, useNA='ifany') # on a weird scale for some reason
midus2$B1SSPIRI = midus2$B1SSPIRI*100
midus2$B1SSPIRI[midus2$B1SSPIRI ==98] <- NA
midus2$B1SRELID[midus2$B1SRELID ==98] <- NA
midus2$B1SRELCB[midus2$B1SRELCB ==98] <- NA
 
table(midus2$B1SMARRS, useNA = 'ifany') # same as SSPIRI
midus2$B1SMARRS = midus2$B1SMARRS*100
midus2$B1SMARRS[midus2$B1SMARRS ==98] <- NA
midus2$B1SMARRS[midus2$B1SMARRS ==99] <- NA

table(midus2$B1SSPDIS) #GOOD
midus2$B1SSPDIS[midus2$B1SSPDIS ==98] <- NA
midus2$B1SSPDIS[midus2$B1SSPDIS ==99] <- NA


midus2$B1SSPEMP[midus2$B1SSPEMP ==9] <- NA
midus2$B1SSPCRI[midus2$B1SSPCRI ==9] <- NA
midus2$B1SSPSOL[midus2$B1SSPSOL ==9] <- NA
midus2$B1SSPEMP[midus2$B1SSPEMP ==8] <- NA
midus2$B1SSPCRI[midus2$B1SSPCRI ==8] <- NA
midus2$B1SSPSOL[midus2$B1SSPSOL ==8] <- NA

describe(midus2)

#setnames(midus1, c('A1SAGENC','A1SEXTRA'),c('Agency','Extraversion'))
newnames = c('M2ID',
  'Agn','Ext','Agr','Con','Opn','Neu',
  'Outgoing','Helpful','Moody','Organized','Selfconfident','Friendly','Warm','Worrying',
  'Responsible','Forceful','Lively','Caring','Nervous','Creative','Assertive','Hardworking',
  'Imaginative','Softhearted','Calm','Outspoken','Intelligent','Curious','Active','Careless',
  'Broadminded','Sympathetic','Talkative','Sophisticated','Adventurous','Dominant','Thorough',
  'like_to_lead','talk_people_into','influencing','decisions',
  'Age','Sex',
  'positive_affect','negative_affect',
  'autonomy','environmental_mastery','personal_growth',
  'affectual_relations','purpose_in_life','self_acceptance',
  'SoC_Mastery','SoC_Constraints',
  'anger_in','anger_out','anger_control',
  'memory','executive_function',
  'spirituality','religiosity','religious_coping',
  'marital_risk','sp_disagreement','support_from_sp','strain_from_sp','affectual_solidarity'

  
)
  
setnames(midus2,vars,newnames)



## PANAS vars need to be inverted 
midus2$positive_affect = 6 - midus2$positive_affect
midus2$negative_affect = 6 - midus2$negative_affect


## personality items should be reverse coded       
persCols = c('Outgoing','Helpful','Moody','Organized','Selfconfident','Friendly','Warm','Worrying',
               'Responsible','Forceful','Lively','Caring','Nervous','Creative','Assertive','Hardworking',
               'Imaginative','Softhearted','Calm','Outspoken','Intelligent','Curious','Active','Careless',
               'Broadminded','Sympathetic','Talkative','Sophisticated','Adventurous','Dominant','Thorough',
               'like_to_lead','talk_people_into','influencing','decisions')

midus2[,(persCols):= 5 - midus2[,..persCols]]





