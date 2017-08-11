library(Hmisc)
library(SAScii)
library(data.table)



setwd("Z:/MIDUS I/DS0001/")


# midus1 <- read.SAScii('02760-0001-Data.txt','02760-0001-Setup.sas')
# 
# midus1.bak = midus1

midus1 = midus1.bak



vars=c(
  'M2ID',
  # Personality
  'A1SAGENC','A1SEXTRA','A1SAGREE','A1SCONS','A1SOPEN','A1SNEURO',
  # Demographics
  'A1PBYEAR','A1PRSEX','TOT_SIBS',
  'A1PC1','A1PC2','A1PC3','A1PC8','A1PC9',   # parents
  'A1PB19','A1PSAGE','A1PB27','A1PB28A',    # spouse
  'CNT_BK','CNT_NBK', #children
  'A1SE6','A1SE7','A1SE8','A1SE9','A1SE12',    # growing up - ALSO maternal/paternal constructs?
  # Education & Employment
  'A1PB1','A1PB2','A1PB3A','A1PB3B','A1PB3C','A1PB3D','A1PB3E','A1PB3F',
  'A1PB4A','A1PB4B',#'A1PB4C','A1PB4D','A1PB4E','A1PB4F','A1PB4G',
  'A1PB8_3','A1PB11','A1PB12',
  # Physical health
  'A1PA4','A1PA5','A1PA6',
  'A1PA11','A1PHRTRS',  # Heart health
  'A1PANGIN',   # chest pain ('A1PA23','A1PA24')
  'A1PA33','A1PA31','A1PA32S','A1PA32D',   # blood pressure
  'A1PA36','A1PCACRS',   # cancer
  'A1PA40','A1PA42','A1PA44','A1PA45', # smoking
  'A1PA53','A1PA53A', # drinking
  'A1SCHRON','A1SBMI','A1SWSTHI','A1SUSEMD','A1SUSEMH','A1SALTER',
  # Mental health
  'A1PA57','A1PDEPAF','A1PA69','A1PANHED','A1PDEPRE',   # mood
  'A1PA81','A1PANXIE','A1PA87','A1PPANIC',   # worry, anxiety, & panic
  'A1PE2',
  # Female health
  'A1SB1','A1SB8A','A1SB8B','A1SB9A',
  # Psychosocial constructs
  'A1SPOSAF','A1SNEGAF','A1SSATIS',#'A1SAMPLI', # Somatic aplicifation missing, don't know why - don't need it 
  'A1SPWBA','A1SPWBE','A1SPWBG','A1SPWBR','A1SPWBU','A1SPWBS','A1SMASTE','A1SCONST',
  'A1SFAM','A1SPOSWF','A1SNEGWF','A1SPOSFW','A1SNEGFW',
  'A1SJCSD','A1SJCDA','A1SJCDS','A1SJCCS','A1SJCSS','A1SPIWOR',
  'A1SGENER','A1SPRIOB','A1SCVOB5','A1SWKOB','A1SALTRU',
  'A1SPSUPE','A1SRSUPE','A1SPSUPI','A1SRSUIF','A1SRSUIO',  # also includes financial support constructs
  'A1SHOMET','A1SPIHOM','A1SKINPO','A1SKINNE','A1SFDSPO','A1SFDSNE','A1SPIFAM',
  'A1SMARRS','A1SSPDIS','A1SSPEMP','A1SSPCRI','A1SSPDEC',
  # Income
  'A1SJ8','A1SJ9','A1SJ15','A1SASSET','A1SJ16','A1SJ17','A1SJ18','A1SJ19',
  # Ethnicity stuff
  'A1SS3','A1SS4','A1SS5','A1SS8','A1SS9','A1SS10','A1SS11','A1SS12',
  # Sex
  'A1SQ1','A1SQ6','A1SQ8','A1SQ5','A1SQ7'

)
# add religion?
vars[!vars %in% names(midus1)]

midus1$A1SAGENC[midus1$A1SAGENC==9] <- NA
midus1$A1SEXTRA[midus1$A1SEXTRA==9] <- NA
midus1$A1SAGREE[midus1$A1SAGREE==9] <- NA
midus1$A1SCONS[midus1$A1SCONS==9] <- NA
midus1$A1SOPEN[midus1$A1SOPEN==9] <- NA
midus1$A1SNEURO[midus1$A1SNEURO==9] <-NA

midus1$A1PBYEAR[midus1$A1PBYEAR==9998] <- NA
midus1$Age = midus1$A1PI_YR - midus1$A1PBYEAR
midus1$A1PRSEX[midus1$A1PRSEX==8] <- NA
midus1$TOT_SIBS[midus1$TOT_SIBS==9] <- NA
midus1$A1PC1[midus1$A1PC1==7] <- NA
midus1$A1PC2[midus1$A1PC2%in%c(97,98,99)] <- NA
midus1$A1PC3[midus1$A1PC3%in%c(6,7,8,9)] <- NA
midus1$A1PC8[midus1$A1PC8%in%c(97,98,99)] <- NA
midus1$A1PC9[midus1$A1PC9%in%c(6,7,8,9)] <- NA
midus1$A1PB19[midus1$A1PB19%in%c(7,8,9)] <- NA
midus1$A1PB19[midus1$A1PB17==5] <- 0
midus1$A1PSAGE[midus1$A1PSAGE%in%c(97,98,99)] <- NA
midus1$A1PB27[midus1$A1PB27%in%c(97,98,99)] <- NA
midus1$A1PB28A[midus1$A1PB28A%in%c(7,8,9)] <- NA
midus1$CNT_BK[midus1$CNT_BK==99] <- NA
midus1$CNT_BK[midus1$A1PB35==0] <- 0
midus1$CNT_NBK[midus1$CNT_NBK==99] <- NA
midus1$CNT_NBK[midus1$A1PB37==0] <- 0

midus1$A1SE6[midus1$A1SE6==8] <- NA
midus1$A1SE7[midus1$A1SE7%in%c(6,8)] <- NA
midus1$A1SE8[midus1$A1SE8==98] <- NA
midus1$A1SE9[midus1$A1SE9==98] <- NA
midus1$A1SE12[midus1$A1SE12==8] <- NA

midus1$A1PB2[midus1$A1PB2%in%c(96,97)] <- NA
midus1$A1PB1[midus1$A1PB1==97] <- NA
midus1$A1PB3A[midus1$A1PB3A%in%c(7,9)] <- NA
midus1$A1PB3B[midus1$A1PB3B%in%c(7,9)] <- NA
midus1$A1PB3C[midus1$A1PB3C%in%c(7,9)] <- NA
midus1$A1PB3D[midus1$A1PB3D%in%c(7,9)] <- NA
midus1$A1PB3E[midus1$A1PB3E%in%c(7,9)] <- NA
midus1$A1PB3F[midus1$A1PB3F%in%c(7,9)] <- NA
midus1$A1PB4A[midus1$A1PB4A%in%c(7,8,9)] <- NA
midus1$A1PB4B[midus1$A1PB4B%in%c(7,8,9)] <- NA
midus1$A1PB8_3[midus1$A1PB8_3%in%c(9997,9999)] <- NA
midus1$A1PB8_3[midus1$A1PB8_2==2] <- 0
midus1$A1PB11[midus1$A1PB11%in%c(997,999)] <- NA
midus1$A1PB12[midus1$A1PB12%in%c(997,999)] <- NA

midus1$A1PA4[midus1$A1PA4==7] <- NA
midus1$A1PA5[midus1$A1PA5==7] <- NA
midus1$A1PA6[midus1$A1PA6==7] <- NA
midus1$A1PA11[midus1$A1PA11==7] <- NA
midus1$A1PHRTRS[midus1$A1PHRTRS==9] <- NA
midus1$A1PANGIN[midus1$A1PANGIN%in%c(6,9)] <- NA
midus1$A1PA33[midus1$A1PA33==7] <- NA
midus1$A1PA31[midus1$A1PA31%in%c(7,8,9)] <- NA
midus1$A1PA32S[midus1$A1PA32S%in%c(997,998,999)] <- NA
midus1$A1PA32D[midus1$A1PA32D%in%c(997,998,999)] <- NA
midus1$A1PA36[midus1$A1PA36==7] <- NA
midus1$A1PCACRS[midus1$A1PCACRS==9] <- NA

midus1$A1PA40[midus1$A1PA41==96] <- 2
midus1$A1PA40[midus1$A1PA40%in%c(7,9)] <- NA
midus1$A1PA41[midus1$A1PA41%in%c(96,97)] <- NA
midus1$A1PA44[midus1$A1PA44%in%c(997,999)] <- NA
midus1$A1PA45[midus1$A1PA45%in%c(7,9)] <- NA
midus1$A1PA53[midus1$A1PA53%in%c(7,9)] <- NA
midus1$A1PA53A[midus1$A1PA53A%in%c(97,99)] <- NA

midus1$A1SCHRON[midus1$A1SCHRON==99] <- NA
midus1$A1SBMI[midus1$A1SBMI==99] <- NA
midus1$A1SWSTHI[midus1$A1SWSTHI==9] <- NA
midus1$A1SUSEMD[midus1$A1SUSEMD==999] <- NA
midus1$A1SUSEMH[midus1$A1SUSEMH==999] <- NA
midus1$A1SALTER[midus1$A1SALTER==9] <- NA

midus1$A1PA57[midus1$A1PA57%in%c(6,7)] <- NA
#midus1$A1PDEPAF[midus1$A1PDEPAF] <- NA   # no issues with invalid values
midus1$A1PA69[midus1$A1PA69%in%c(6,7,8,9)] <- NA
#midus1$A1PANHED[midus1$A1PANHED] <- NA
#midus1$A1PDEPRE[midus1$A1PDEPRE] <- NA
midus1$A1PA81[midus1$A1PA81%in%c(7,8,9)] <- NA
#midus1$A1PANXIE[midus1$A1PANXIE] <- NA
midus1$A1PA87[midus1$A1PA87==7] <- NA
#midus1$A1PPANIC[midus1$A1PPANIC] <- NA
midus1$A1PE2[midus1$A1PE2==7] <- NA

midus1$A1SB1[midus1$A1SB1%in%c(1,98)] <- NA
midus1$A1SB8A[midus1$A1SB8A==8] <- NA
midus1$A1SB8B[midus1$A1SB8B==8] <- NA
midus1$A1SB9A[midus1$A1SB9A%in%c(0,98,99)] <- NA

midus1$A1SPOSAF[midus1$A1SPOSAF==9] <- NA
midus1$A1SNEGAF[midus1$A1SNEGAF==9] <- NA
midus1$A1SSATIS[midus1$A1SSATIS==99] <- NA
midus1$A1SPWBA[midus1$A1SPWBA==9] <- NA
midus1$A1SPWBE[midus1$A1SPWBE==9] <- NA
midus1$A1SPWBG[midus1$A1SPWBG==9] <- NA
midus1$A1SPWBR[midus1$A1SPWBR==9] <- NA
midus1$A1SPWBU[midus1$A1SPWBU==9] <- NA
midus1$A1SPWBS[midus1$A1SPWBS==9] <- NA
midus1$A1SMASTE[midus1$A1SMASTE==99] <- NA
midus1$A1SCONST[midus1$A1SCONST==99] <- NA
midus1$A1SFAM[midus1$A1SFAM==99] <- NA

midus1$A1SI27A[midus1$A1SI27A%in%c(7,8,9)] <- NA
midus1$A1SI27B[midus1$A1SI27B%in%c(7,8,9)] <- NA
midus1$A1SI27C[midus1$A1SI27C%in%c(7,8,9)] <- NA
midus1$A1SI27D[midus1$A1SI27D%in%c(7,8,9)] <- NA
midus1$A1SI27E[midus1$A1SI27E%in%c(7,8,9)] <- NA
midus1$A1SI27F[midus1$A1SI27F%in%c(7,8,9)] <- NA
midus1$A1SI27G[midus1$A1SI27G%in%c(7,8,9)] <- NA
midus1$A1SI27H[midus1$A1SI27H%in%c(7,8,9)] <- NA
midus1$A1SI27I[midus1$A1SI27I%in%c(7,8,9)] <- NA
midus1$A1SI27J[midus1$A1SI27J%in%c(7,8,9)] <- NA
midus1$A1SI27K[midus1$A1SI27K%in%c(7,8,9)] <- NA
midus1$A1SI27L[midus1$A1SI27L%in%c(7,8,9)] <- NA
midus1$A1SI27M[midus1$A1SI27M%in%c(7,8,9)] <- NA
midus1$A1SI27N[midus1$A1SI27N%in%c(7,8,9)] <- NA
midus1$A1SI27O[midus1$A1SI27O%in%c(7,8,9)] <- NA
midus1$A1SI27P[midus1$A1SI27P%in%c(7,8,9)] <- NA
midus1$A1SPOSWF = 4*5 - midus1$A1SI27E - midus1$A1SI27F - midus1$A1SI27G - midus1$A1SI27H
midus1$A1SNEGWF = 4*5 - midus1$A1SI27A - midus1$A1SI27B - midus1$A1SI27C - midus1$A1SI27D
midus1$A1SPOSFW = 4*5 - midus1$A1SI27M - midus1$A1SI27N - midus1$A1SI27O - midus1$A1SI27P
midus1$A1SNEGFW = 4*5 - midus1$A1SI27I - midus1$A1SI27J - midus1$A1SI27K - midus1$A1SI27L

midus1$A1SI28A[midus1$A1SI28A%in%c(7,8,9)] <- NA
midus1$A1SI28B[midus1$A1SI28B%in%c(7,8,9)] <- NA
midus1$A1SI28C[midus1$A1SI28C%in%c(7,8,9)] <- NA
midus1$A1SI28D[midus1$A1SI28D%in%c(7,8,9)] <- NA
midus1$A1SI28E[midus1$A1SI28E%in%c(7,8,9)] <- NA
midus1$A1SI28F[midus1$A1SI28F%in%c(7,8,9)] <- NA
midus1$A1SI28G[midus1$A1SI28G%in%c(7,8,9)] <- NA
midus1$A1SI28H[midus1$A1SI28H%in%c(7,8,9)] <- NA
midus1$A1SI28I[midus1$A1SI28I%in%c(7,8,9)] <- NA
midus1$A1SI28J[midus1$A1SI28J%in%c(7,8,9)] <- NA
midus1$A1SI29A[midus1$A1SI29A%in%c(7,8,9)] <- NA
midus1$A1SI29B[midus1$A1SI29B%in%c(7,8,9)] <- NA
midus1$A1SI29C[midus1$A1SI29C%in%c(7,8,9)] <- NA
midus1$A1SI29D[midus1$A1SI29D%in%c(7,8,9)] <- NA
midus1$A1SI30A[midus1$A1SI30A%in%c(7,8,9)] <- NA
midus1$A1SI30B[midus1$A1SI30B%in%c(7,8,9)] <- NA
midus1$A1SI30C[midus1$A1SI30C%in%c(7,8,9)] <- NA
midus1$A1SI30D[midus1$A1SI30D%in%c(7,8,9)] <- NA
midus1$A1SI30E[midus1$A1SI30E%in%c(7,8,9)] <- NA
midus1$A1SJCSD = 3*5 - midus1$A1SI28B - midus1$A1SI28C - midus1$A1SI28I
midus1$A1SJCDA = 6*5 - midus1$A1SI28D - midus1$A1SI28E - midus1$A1SI28F - midus1$A1SI28G - midus1$A1SI28H - midus1$A1SI29B
midus1$A1SJCDS = 5*5 - midus1$A1SI28A - midus1$A1SI28J - midus1$A1SI29A - midus1$A1SI29C - midus1$A1SI29D
midus1$A1SJCCS = 2*5 - midus1$A1SI30A - midus1$A1SI30B
midus1$A1SJCSS = 3*5 - midus1$A1SI30C - midus1$A1SI30D - midus1$A1SI30E
midus1$A1SPIWOR[midus1$A1SPIWOR==9] <- NA

midus1$A1SK6A[midus1$A1SK6A==8] <- NA
midus1$A1SK6B[midus1$A1SK6B==8] <- NA
midus1$A1SK6C[midus1$A1SK6C==8] <- NA
midus1$A1SK6D[midus1$A1SK6D==8] <- NA
midus1$A1SK6E[midus1$A1SK6E==8] <- NA
midus1$A1SK6F[midus1$A1SK6F==8] <- NA
midus1$A1SGENER = 6*4 - midus1$A1SK6A - midus1$A1SK6B - midus1$A1SK6C - midus1$A1SK6D - midus1$A1SK6E - midus1$A1SK6F

midus1$A1SPRIOB[midus1$A1SPRIOB==99] <- NA
midus1$A1SCVOB5[midus1$A1SCVOB5==99] <- NA
midus1$A1SWKOB[midus1$A1SWKOB==99] <- NA
midus1$A1SALTRU[midus1$A1SALTRU==99] <- NA
midus1$A1SPSUPE[midus1$A1SPSUPE==9999] <- NA
midus1$A1SRSUPE[midus1$A1SRSUPE==9999] <- NA
midus1$A1SRSUIF[midus1$A1SRSUIF==999] <- NA
midus1$A1SRSUIO[midus1$A1SRSUIO==99] <- NA

midus1$A1SK14A[midus1$A1SK14A==9998] <- NA
midus1$A1SK14B[midus1$A1SK14B==9998] <- NA
midus1$A1SK14C[midus1$A1SK14C==99998] <- NA
midus1$A1SK14D[midus1$A1SK14D==9998] <- NA
midus1$A1SK14E[midus1$A1SK14E==998] <- NA
midus1$A1SK14F[midus1$A1SK14F==99998] <- NA
midus1$A1SK14G[midus1$A1SK14G==9998] <- NA
midus1$A1SK14H[midus1$A1SK14H==99998] <- NA
midus1$A1SK15A[midus1$A1SK15A==99998] <- NA
midus1$A1SK15B[midus1$A1SK15B==9998] <- NA
midus1$A1SK15C[midus1$A1SK15E==9998] <- NA
midus1$A1SK15D[midus1$A1SK15D==9998] <- NA
midus1$A1SK15E[midus1$A1SK15E==998] <- NA
midus1$A1SK15F[midus1$A1SK15F==9998] <- NA
midus1$A1SK15G[midus1$A1SK15G==99998] <- NA
midus1$A1SK16A[midus1$A1SK16A==8] <- NA
midus1$A1SK16B[midus1$A1SK16B==8] <- NA
midus1$A1SK16C[midus1$A1SK16E==8] <- NA
midus1$A1SK16D[midus1$A1SK16D==8] <- NA
midus1$ProvideFinancialSupport = rowMeans(midus1[,c('A1SK14A','A1SK14B','A1SK14C','A1SK14D','A1SK14E','A1SK14F','A1SK14G','A1SK14H')],na.rm=T)
midus1$ReceiveFinancialSupport = rowMeans(midus1[,c('A1SK15A','A1SK15B','A1SK15C','A1SK15D','A1SK15E','A1SK15F','A1SK15G')],na.rm=T)
midus1$ProvideResidentialSupport = rowMeans(midus1[,c('A1SK16A','A1SK16B','A1SK16C','A1SK16D')],na.rm=T)

midus1$A1SHOMET[midus1$A1SHOMET==9] <- NA
midus1$A1SPIHOM[midus1$A1SPIHOM==9] <- NA
midus1$A1SKINPO[midus1$A1SKINPO==9] <- NA
midus1$A1SKINNE[midus1$A1SKINNE==9] <- NA
midus1$A1SFDSPO[midus1$A1SFDSPO==9] <- NA
midus1$A1SFDSNE[midus1$A1SFDSNE==9] <- NA
midus1$A1SPIFAM[midus1$A1SPIFAM==9] <- NA
midus1$A1SMARRS[midus1$A1SMARRS==9] <- NA
midus1$A1SP9A[midus1$A1SP9A%in%c(7,8,9)] <- NA
midus1$A1SP9B[midus1$A1SP9B%in%c(7,8,9)] <- NA
midus1$A1SP9C[midus1$A1SP9C%in%c(7,8,9)] <- NA
midus1$A1SSPDIS = 3*4 - midus1$A1SP9A - midus1$A1SP9B - midus1$A1SP9C
midus1$A1SSPEMP[midus1$A1SSPEMP==9] <- NA
midus1$A1SSPCRI[midus1$A1SSPCRI==9] <- NA
midus1$A1SP28A[midus1$A1SP28A%in%c(8,9)] <- NA
midus1$A1SP28B[midus1$A1SP28B%in%c(8,9)] <- NA
midus1$A1SP28C[midus1$A1SP28C%in%c(8,9)] <- NA
midus1$A1SP28D[midus1$A1SP28D%in%c(8,9)] <- NA
midus1$A1SSPDEC = 4*7 - midus1$A1SP28A - midus1$A1SP28B - midus1$A1SP28C - midus1$A1SP28D

midus1$A1SJ8[midus1$A1SJ8==98] <- NA
midus1$A1SJ9[midus1$A1SJ9==98] <- NA
midus1$A1SJ15[midus1$A1SJ15==98] <- NA
midus1$A1SASSET[midus1$A1SASSET==99999] <- NA
midus1$A1SJ16[midus1$A1SJ16%in%c(7,8)] <- NA
midus1$A1SJ17[midus1$A1SJ17%in%c(7,8)] <- NA
midus1$A1SJ18[midus1$A1SJ18%in%c(7,8)] <- NA
midus1$A1SJ19[midus1$A1SJ19%in%c(6,7,8)] <- NA

midus1$A1SS3[midus1$A1SS3==8] <- NA
midus1$A1SS4[midus1$A1SS4==8] <- NA
midus1$A1SS5[midus1$A1SS5==8] <- NA
midus1$A1SS8[midus1$A1SS8==8] <- NA
midus1$A1SS9[midus1$A1SS9==8] <- NA
midus1$A1SS10[midus1$A1SS10==8] <- NA
midus1$A1SS11[midus1$A1SS11==8] <- NA
midus1$A1SS12[midus1$A1SS12==8] <- NA

midus1$A1SQ1[midus1$A1SQ1==98] <- NA
midus1$A1SQ6[midus1$A1SQ6==98] <- NA
midus1$A1SQ8[midus1$A1SQ8==8] <- NA
midus1$A1SQ5[midus1$A1SQ5==98] <- NA
midus1$A1SQ7[midus1$A1SQ7%in%c(3,8)] <- 2




# table(midus1$A1SQ5)
# hist(midus1$ProvideFinancialSupport)
#        
# midus1$A1[midus1$A1] <- NA
# 
# 
# table(midus1$CNT_BK)
# midus1$A1PRSEX[midus1$A1PRSEX==8] <- NA


#setnames(midus1, c('A1SAGENC','A1SEXTRA'),c('Agency','Extraversion'))
newnames = c('M2ID',
  'Agn','Ext','Agr','Con','Opn','Neu',
  'Birth year','Sex','Total siblings',
  'Lived with bio parents','Father\'s education','Father\'s work',
  'Mother\'s education','Mother\'s work',
  'Number of marriages','Age of s/p','s/p education','s/p working',
  'Biological children','Non-biological children',
  'How important was religion','Are where raised','Times moved neighborhoods',
  'Financial level growing up','Rules growing up',
  'Education level','Age first worked',
  'Working now','Self-employed','Unemployed','Laid-off','Retired','Homemaker',
  'Not working - fired','Not working - laid-off','# supervised',
  'Hours worked per week','Days worked away from home',
  'Physical health','Mental health','Compared health',
  'Heart problems','Heart risk','Angina risk',
  'Taking BP meds','General BP','Systolic','Diastolic',
  'Had cancer','Cancer risk',
  'Smoked regularly','Age started smoking','Avg cigs per day','Ever tried qutting',
  'Time when drank 3+/week','Age when started drinking',
  'Chronic conditions','BMI','Waist-Hip Ratio',
  'Physician visits','Psychiatry visits','Alternatives used',
  'Felt sad','Depressed affect','Lost interest in pleasure','Anhedonia','Depression',
  'Worry','Anxiety','Anxiety attack','Panic attack',
  'Homeless',
  'Age of first period','Worry too old for kid','Worry less attractive','Age of last period',
  'Positive affect','Negative affect','Life satisfaction',
  'SWB autonomy','SWB environmental mastery','SWB personal growth',
  'SWB positive relations','SWB purpose in life','SWB self-acceptance',
  'SoC Mastery','SoC Constraints','Happy without family',
  '+ work-family spill','- work-family spill','+ family-work spill','- family-work spill',
  'Skill discretion','Decision authority','Demands','Coworker support','Supervis support',
  'Work inequality','Generativity',
  'Family obligation','Civic obligation','Work obligation','Altruism',
  'Give emotional support','Get emotional support',
  'Give instrum support','Get family/friends instrum support','Get other instrumental support',
  'Neighborhood quality','Inequality in home',
  'Family support','Family strain','Friend support','Friend strain',
  'Inequality in family','Martial risk',
  's/p diagree','Marital empathy','s/p strain','s/p decision making',
  'Personal income','s/p income','Leftover after debt','Total assets',
  'Pension?','IRA?','Other retirement plan?','s/p retirement plan?',
  'Identify with ethnicity','Prefer own ethnicity','Should marry own ethnic',
  'Identify with race','Prefer own race','Should marry own race',
  'US citizen','Identify as American',
  'Sexual aspects','# sex partners','How much sex','Thought into sex','Heterosexual?'
)


  
midus1 = as.data.table(midus1)

setnames(midus1,vars,newnames)
       

# table(midus1$Agn)
# tail(midus1$ProvideFinancialSupport)
# table(midus1$`Sexual aspects`)


newnames = c(newnames,c('Age','ProvideFinancialSupport','ReceiveFinancialSupport','ProvideResidentialSupport'))



### Split first
# Pairwise correlations can deal with missing data.
# But do be sure to:
## TODO - make the NAs!

m1split = midus1[,..newnames]

set.seed(12345)
ind <- sample(seq_len(nrow(m1split)),dim(m1split)[1]/2)

m1exp = m1split[ind,]
m1con = m1split[-ind,]





