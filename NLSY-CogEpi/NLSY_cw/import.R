### Importing data (and possibly code) from SAS

library(readstata13)

#cw.df <- read.dta13(file = '0_NLSY_mainfile.dta')




ht.df <- read.csv(file = "HT.csv")

ht.df[indxs,]



# H0004700 - age 40 HT Month
# H0004701 - age 40 HT Year

# H0017300 - age 50 HT Month
# H0017301 - age 50 HT Year

# months coded -2 -> 12
# years coded -2 -> 06/2015
# anything coded -1 or -4 -> NA



### Age 50 first

ht.df$H0017300[ht.df$H0017300 == -4 | ht.df$H0017300 == -1] = NA
ht.df$H0017301[ht.df$H0017301 == -4 | ht.df$H0017301 == -1] = NA

ht.df$H0017300[ht.df$H0017300 == -2] = 12
ht.df$H0017300[ht.df$H0017301 == -2] = 06
ht.df$H0017301[ht.df$H0017301 == -2] = 2015

pasteDate = paste3(ht.df$H0017301,ht.df$H0017300,'01',sep='-')
pasteDate[pasteDate == '01'] = NA 

ht.df$HTage50t = as.Date(pasteDate,sep='-')

#sum(!is.na(ht.df$HTage50t))



### Then fill in from Age 40 where relevant

ht.df$H0004700[ht.df$H0004700 == -4 | ht.df$H0004700 == -1] = NA
ht.df$H0004701[ht.df$H0004701 == -4 | ht.df$H0004701 == -1] = NA

ht.df$H0004700[ht.df$H0004700 == -2] = 12
ht.df$H0004700[ht.df$H0004701 == -2] = 09
ht.df$H0004701[ht.df$H0004701 == -2] = 2006

pasteDate = paste3(ht.df$H0004701,ht.df$H0004700,'01',sep='-')
pasteDate[pasteDate == '01'] = NA 

ht.df$HTage50t[is.na(ht.df$HTage50t)] = as.Date(pasteDate[is.na(ht.df$HTage50t)],sep='-')

#sum(!is.na(ht.df$HTage50t))



### Assign censoring values

ht.df$hasHT = TRUE
ht.df$hasHT[is.na(ht.df$HTage50t)] = FALSE

ht.df$HTage50t[is.na(ht.df$HTage50t)] = as.Date('2015-07-01')



### Merge with CW's df

ht.df = merge(cw.df, ht.df[c('R0000100','HTage50t','hasHT')], by.x='CASEID_1979', by.y='R0000100')


sum(complete.cases(ht.df[,c('AFQT89','Adult_SES','Child_SES','hasHT','SAMPLE_SEX')]))


ht.df$age = 79 - as.numeric(levels(ht.df$DOB_year))[ht.df$DOB_year] ## Age assignment
# should this adjust for month too?
# see below for correct DOB calculation

ht.df$DOB = as.Date(paste3(paste0('19',as.numeric(levels(ht.df$DOB_year))[ht.df$DOB_year]),
                           as.numeric(levels(ht.df$DOB_month))[ht.df$DOB_month],
                           '01',sep='-'), format='%Y-%m-%d')



ht.df$HTdiagDate = ht.df$HTage50t
ht.df$HTage50t = as.numeric(ht.df$HTage50t)
ht.df$HTage50t = ht.df$HTage50t/365.25



### Remove 3 individuals who had HT from "birth"

indxs = which(as.numeric(ht.df$DOB) == as.numeric(ht.df$HTdiagDate))

ht.df = ht.df[-indxs,]



### Currently provisional - HT medication status and Dr visits ###

HTmed = read.csv('HTmed.csv')

colnames(HTmed)[c(6:21)] = 
  c('M.BPmeasured.2008','M.BPmeds.2008','F.BPmeasured.2008','F.BPmeds.2008',
    'M.BPmeasured.2010','M.BPmeds.2010','F.BPmeasured.2010','F.BPmeds.2010',
    'M.BPmeasured.2012','M.BPmeds.2012','F.BPmeasured.2012','F.BPmeds.2012',
    'M.BPmeasured.2014','M.BPmeds.2014','F.BPmeasured.2014','F.BPmeds.2014'
    )

# Measurements taken
HTmed$BP.measured.2008 = numeric(length=dim(HTmed)[1])
HTmed$BP.measured.2008[HTmed$R0214800==1] = HTmed$M.BPmeasured.2008[HTmed$R0214800==1]
HTmed$BP.measured.2008[HTmed$R0214800==2] = HTmed$F.BPmeasured.2008[HTmed$R0214800==2]
HTmed$BP.measured.2008[HTmed$BP.measured.2008<0] = NA

HTmed$BP.measured.2010 = numeric(length=dim(HTmed)[1])
HTmed$BP.measured.2010[HTmed$R0214800==1] = HTmed$M.BPmeasured.2010[HTmed$R0214800==1]
HTmed$BP.measured.2010[HTmed$R0214800==2] = HTmed$F.BPmeasured.2010[HTmed$R0214800==2]
HTmed$BP.measured.2010[HTmed$BP.measured.2010<0] = NA

HTmed$BP.measured.2012 = numeric(length=dim(HTmed)[1])
HTmed$BP.measured.2012[HTmed$R0214800==1] = HTmed$M.BPmeasured.2012[HTmed$R0214800==1]
HTmed$BP.measured.2012[HTmed$R0214800==2] = HTmed$F.BPmeasured.2012[HTmed$R0214800==2]
HTmed$BP.measured.2012[HTmed$BP.measured.2012<0] = NA

HTmed$BP.measured.2014 = numeric(length=dim(HTmed)[1])
HTmed$BP.measured.2014[HTmed$R0214800==1] = HTmed$M.BPmeasured.2014[HTmed$R0214800==1]
HTmed$BP.measured.2014[HTmed$R0214800==2] = HTmed$F.BPmeasured.2014[HTmed$R0214800==2]
HTmed$BP.measured.2014[HTmed$BP.measured.2014<0] = NA

# Taking medication
HTmed$BP.meds.2008 = numeric(length=dim(HTmed)[1])
HTmed$BP.meds.2008[HTmed$R0214800==1] = HTmed$M.BPmeds.2008[HTmed$R0214800==1]
HTmed$BP.meds.2008[HTmed$R0214800==2] = HTmed$F.BPmeds.2008[HTmed$R0214800==2]
HTmed$BP.meds.2008[HTmed$BP.meds.2008<0] = NA

HTmed$BP.meds.2010 = numeric(length=dim(HTmed)[1])
HTmed$BP.meds.2010[HTmed$R0214800==1] = HTmed$M.BPmeds.2010[HTmed$R0214800==1]
HTmed$BP.meds.2010[HTmed$R0214800==2] = HTmed$F.BPmeds.2010[HTmed$R0214800==2]
HTmed$BP.meds.2010[HTmed$BP.meds.2010<0] = NA

HTmed$BP.meds.2012 = numeric(length=dim(HTmed)[1])
HTmed$BP.meds.2012[HTmed$R0214800==1] = HTmed$M.BPmeds.2012[HTmed$R0214800==1]
HTmed$BP.meds.2012[HTmed$R0214800==2] = HTmed$F.BPmeds.2012[HTmed$R0214800==2]
HTmed$BP.meds.2012[HTmed$BP.meds.2012<0] = NA

HTmed$BP.meds.2014 = numeric(length=dim(HTmed)[1])
HTmed$BP.meds.2014[HTmed$R0214800==1] = HTmed$M.BPmeds.2014[HTmed$R0214800==1]
HTmed$BP.meds.2014[HTmed$R0214800==2] = HTmed$F.BPmeds.2014[HTmed$R0214800==2]
HTmed$BP.meds.2014[HTmed$BP.meds.2014<0] = NA


### Merge into ht.df

ht.df = merge(ht.df, HTmed[c(
  'BP.measured.2008','BP.measured.2010','BP.measured.2012','BP.measured.2014',
  'BP.meds.2008','BP.meds.2010','BP.meds.2012','BP.meds.2014','R0000100'
  )], 
              by.x='CASEID_1979', by.y='R0000100')







####### Functions #######

paste3 <- function(...,sep=", ") {
  L <- list(...)
  L <- lapply(L,function(x) {x[is.na(x)] <- ""; x})
  ret <-gsub(paste0("(^",sep,"|",sep,"$)"),"",
             gsub(paste0(sep,sep),sep,
                  do.call(paste,c(L,list(sep=sep)))))
  is.na(ret) <- ret==""
  ret
}


