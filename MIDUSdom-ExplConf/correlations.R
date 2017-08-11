library(psych)

getOption("max.print")
options(max.print=100000)
options(scipen=999)
options(digits=3)




cord = corr.test(m1exp, method='spearman',adjust='none')
cbind(cord$r[,c(1:2)],cord$p[,c(1:2)])
#cbind(cord$r[,c(1:2,5)],cord$p[,c(1:2,5)])


### Filter all variables correlated > p = 0.05 with Agn

filt.ind = cord$p[,'Agn']<0.051
m1exp.filt = m1exp[,..filt.ind]
m1con.filt = m1con[,..filt.ind]



#table(cord$p[,'Agn']<0.05)


con.cord = corr.test(m1con.filt, method='spearman',adjust='none')
cbind(con.cord$r[,c(1:2,5)],con.cord$p[,c(1:2,5)])





### DO NOT RUN

# con.cord.temp = corr.test(m1con, method='spearman',adjust='none')
# cbind(con.cord.temp$r[,c(1:2)],con.cord.temp$p[,c(1:2)])
# 
#  
# x.male = corr.test(m1exp[m1exp$Sex==1,newnames], method='spearman',adjust='none')
# x.fema = corr.test(m1exp[m1exp$Sex==2,newnames], method='spearman',adjust='none')
# 
# cbind(x.male$r[,c(1:2,5)],x.male$p[,c(1:2,5)])
# cbind(x.fema$r[,c(1:2,5)],x.fema$p[,c(1:2,5)])
  
  
#'   'A1PA25BS','A1PA25BD','A1SBMI',
#' 'A1PA26','A1PA30A',
#' 'A1PA1','A1PB3C','A1PB4M','A1PTSEI','A1PB20','A1PC2',
#' 'A1PF4','A1PF5','A1PF6','A1PF9','A1PF10','A1PF11',    # Ethnicity Qs
#' 'A1SE11S','A1SE11T','A1SE11U', # Assault, Prison
#' 
#' 'A1PDEPAF','A1PDEPAF','A1PANHED','A1PANXIE','A1PPANIC','A1SSATIS2','A1SHLOCS','A1SHLOCO','A1SAMPLI',
#' 'A1SNEGAF','A1SNEGPA','A1SPOSAF','A1SPOSPA','A1SINTAG','A1SPWBA1','A1SPWBE1','A1SPWBG1','A1SPWBR1',
#' 'A1SPWBU1','A1SPWBS1','A1SPWBA2','A1SPWBE2','A1SPWBG2','A1SPWBR2','A1SPWBU2','A1SMASTE','A1SCONST',
#' 'A1SCTRL','A1SESTEE','A1SINTER','A1SINDEP',
#' 'A1SMPQWB','A1SMPQSP','A1SMPQAC','A1SMPQSC','A1SMPQSR','A1SMPQAG','A1SMPQAL','A1SMPQCN','A1SMPQTR',
#' 'A1SMPQHA','A1SOPTIM','A1SPESSI','A1SPERSI','A1SREAPP','A1SCHANG','A1SDIREC','A1STODAY','A1SINSGH','A1SFORSG',
#' 'A1SSUFFI','A1SPOSWF','A1SNEGWF','A1SPOSFW','A1SNEGFW','A1SJCSD','A1SJCDA','A1SJCDS','A1SJCCS','A1SJCSS',
#' 'A1SJOBDI','A1SPIWOR','A1SGENER','A1SSWBMS','A1SSWBSI','A1SSWBAO','A1SSWBSC','A1SSWBSA','A1SSYMP',
#' 'A1SHOMET','A1SPIHOM','A1SKINPO','A1SKINNE','A1SFDSPO','A1SFDSNE','A1SFDSOL','A1SPIFAM',
#' 'A1SMARRS','A1SSPDIS','A1SSPEMP','A1SSPCRI','A1SSPSOL','A1SSPDEC','A1SSPIRI',
#' 'A1SRELSU','A1SSPRTE',
#' 'A1SLFEDI','A1SDAYDI',
#' #'A1SEMA'...
#' 'A1PCHM1N',
#' 'A1SCHRON',
#' 'A1SRXMED',
#' 'A1SBADL2','A1SIADL','A1SDYSPN','A1SWSTHI','A1SBMI','A1SUSEMD','A1SUSEMH','A1SALCOH',
#' 'A1SG8A','A1SG8B','A1SG8C','A1SRINC1',#'A1SG9AX','A1SG9BX','A1SG9CX','A1SSINC1',
#' 'A1SEARN1','A1SPNSN1','A1SSEC1','A1STINC1',
#' 
#' )