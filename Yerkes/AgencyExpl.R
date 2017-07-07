library(psych)

getwd()
setwd("Drew version/")
midus <- read.csv('midusP1cc.csv')

load('Z:/MIDUS II (cognitive project)/DS0001/25281-0001-Data.rda')

midus.cog = merge(midus,da25281.0001, by='M2ID')



# fixing some dimensions

table(midus$B1SE11U)

midus$B1SMPQAG[midus$B1SMPQAG==98] = NA
midus$B1SE11U[midus$B1SE11U==8] = NA


# x = corr.test(data.frame(Dom=midus$B1SAGENC), 
#           midus[,sapply(midus, is.numeric)],
#           #data.frame(Agr=midus$B1SAGREE,YoB=midus$B1PBYEAR), 
#           use='pairwise.complete.obs', method = 'spearman', adjust = 'none')

getOption("max.print")
options(max.print=100000)
options(scipen=999)
options(digits=3)

#print(x$ci, digits = 2)

vars=c('B1SAGENC','B1SEXTRA','B1SAGREE','B1SCONS2','B1SOPEN','B1SNEURO',
'B1PA1','B1PA2','B1PA5',
'B1PA9','B1PA10A','B1PA11','B1PA25A','B1PA25BS','B1PA25BD','B1SBMI',
'B1PA26','B1PA30A',
'B1PB1','B1PB3C','B1PB4M','B1PTSEI','B1PB20','B1PC2',
'B1PF4','B1PF5','B1PF6','B1PF9','B1PF10','B1PF11',    # Ethnicity Qs
'B1SE11S','B1SE11T','B1SE11U', # Assault, Prison

'B1PDEPAF','B1PDEPAF','B1PANHED','B1PANXIE','B1PPANIC','B1SSATIS2','B1SHLOCS','B1SHLOCO','B1SAMPLI',
'B1SNEGAF','B1SNEGPA','B1SPOSAF','B1SPOSPA','B1SINTAG','B1SPWBA1','B1SPWBE1','B1SPWBG1','B1SPWBR1',
'B1SPWBU1','B1SPWBS1','B1SPWBA2','B1SPWBE2','B1SPWBG2','B1SPWBR2','B1SPWBU2','B1SMASTE','B1SCONST',
'B1SCTRL','B1SESTEE','B1SINTER','B1SINDEP',
'B1SMPQWB','B1SMPQSP','B1SMPQAC','B1SMPQSC','B1SMPQSR','B1SMPQAG','B1SMPQAL','B1SMPQCN','B1SMPQTR',
'B1SMPQHA','B1SOPTIM','B1SPESSI','B1SPERSI','B1SREAPP','B1SCHANG','B1SDIREC','B1STODAY','B1SINSGH','B1SFORSG',
'B1SSUFFI','B1SPOSWF','B1SNEGWF','B1SPOSFW','B1SNEGFW','B1SJCSD','B1SJCDA','B1SJCDS','B1SJCCS','B1SJCSS',
'B1SJOBDI','B1SPIWOR','B1SGENER','B1SSWBMS','B1SSWBSI','B1SSWBAO','B1SSWBSC','B1SSWBSA','B1SSYMP',
'B1SHOMET','B1SPIHOM','B1SKINPO','B1SKINNE','B1SFDSPO','B1SFDSNE','B1SFDSOL','B1SPIFAM',
'B1SMARRS','B1SSPDIS','B1SSPEMP','B1SSPCRI','B1SSPSOL','B1SSPDEC','B1SSPIRI',
'B1SRELSU','B1SSPRTE',
'B1SLFEDI','B1SDAYDI',
#'A1SEMA'...
'B1PCHM1N',
'B1SCHRON',
'B1SRXMED',
'B1SBADL2','B1SIADL','B1SDYSPN','B1SWSTHI','B1SBMI','B1SUSEMD','B1SUSEMH','B1SALCOH',
'B1SG8A','B1SG8B','B1SG8C','B1SRINC1',#'B1SG9AX','B1SG9BX','B1SG9CX','B1SSINC1',
'B1SEARN1','B1SPNSN1','B1SSEC1','B1STINC1',
# require cognitive project:
'B3TEMZ3','B3TEFZ3'
)
vars[!vars %in% names(midus.cog)]


x = corr.test(midus.cog[,vars], method='spearman',adjust='none')
cbind(x$r[,c(1:2,5)],x$p[,c(1:2,5)])



head(midus[,c('B1SAGENC','B1SEXTRA')])
head(midus[,vars])




library(corpcor)

part = cor2pcor(x$r)
cbind(rownames(x$r),part[,c(1,2,5)])


library(ppcor)

ppart = pcor(midus.cog[complete.cases(midus.cog[,vars]),vars], method = 'spearman')

cbind(rownames(x$r),round(cbind(ppart$estimate[,c(1:4,5)],ppart$p.value[,c(1:4,5)]),3))


library(qgraph)

qgraph(x$r,graph = 'pcor', minimum = 'sig', threshold = 'fdr', alpha=0.05, bonf=T,sampleSize=max(x$n), layout='spring')


















Dom  <-
  ( dom - depd - fear + decs - tim - caut +
      intll + pers + buly + stngy +32)/10
# - subm 
# + indp 

  Ext  <-
  (- sol - lazy + actv + play + soc - depr + frdy + affc + imit +24)/9

  Con  <-
  (- impl - defn - reckl - errc - irri + pred - aggr - jeals - dsor +64)/9

  Agr  <-
  ( symp + help + sens + prot + gntl )/5

  Neu  <-
  (- stbl + exct - unem +16)/3

  Opn  <-
  ( inqs + invt )/2
  