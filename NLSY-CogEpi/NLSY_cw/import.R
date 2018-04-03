### Importing data (and possibly code) from SAS

library(readstata13)

#cw.df <- read.dta13(file = '0_NLSY_mainfile.dta')




ht.df <- read.csv(file = "HT.csv")

ht.df[indxs,]



### Descriptive stuff for publication

sum((ht.df$H0004700==-4)&(ht.df$H0017301==-4)) # Non-participants or normotensive
sum((ht.df$H0004700==-1)|(ht.df$H0017301==-1)) # Non-participants or normotensive



# H0004700 - age 40 HT Month
# H0004701 - age 40 HT Year

# H0017300 - age 50 HT Month
# H0017301 - age 50 HT Year

# months coded -2 -> 12
# years coded -2 -> 06/2015
# anything coded -1 or -4 -> NA



### Age 50 first
### GD revisions - UNDERWAY

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

### GD UNDERWAY

ht.df$hasHT = NA
ht.df$hasHT[(ht.df$H0004600==1 | ht.df$H0017200==1)] = TRUE
ht.df$hasHT[(ht.df$H0004600==0 & ht.df$H0017200==0)] = FALSE

table(ht.df$hasHT)

##ht.df$hasHT[is.na(ht.df$HTage50t)] = FALSE

##ht.df$HTage50t[is.na(ht.df$HTage50t)] = as.Date('2015-07-01')



colnames(ht.df)



### Merge with CW's df

ht.df = merge(cw.df, ht.df[c('R0000100','R0172500','R0172600','T3977400',"T3977500","T3977600",
                             "T3955000", # weight - 2012
                             "T3955100", # height (ft) - 2012
                             "T3955200", # height (in) - 2012
                             "T3955300", # How often... vigorous activity
                             "T3955400", # How frequently... vigorous activity (increasing = less frequent)
                             "T3955600", # Length of time... vigorous activity
                             "T3955800", # How often... light/moderate activity
                             "T3955900", # How frequently... light/moderate activity (increasing = less frequent)
                             "T3956100", # Length of time... light/moderate activity
                             "T3956300", # How often... strength training
                             "T3956400", # How frequently... strength training (increasing = less frequent)
                             "T3975300", # Smoked at least 100 cigarettes
                             "T3975500", # Ever a daily smoker
                             "T3976400", # Number of drinks on average
                             "T3958000", # Trying to lose weight?
                             "T3958100", # Read nutritional info on food?
                             "T3958200", # Read ingredients on food?
                             "T3958300", # Times ate fast food in past 7 days
                             "T3958500", # Times snacked between meals in past 7 days
                             "T3958700", # Times skipping meal in 7 days
                             "T3958900", # Times having sugary drink in past 7 days
                             "R1773900", # height (in) - 1985
                             "R1774000", # weight - 1985
                             "T0897300", # weight - 2006
                             "T0897400", # height (ft) - 2006
                             "T0897500", # height (in) - 2006
                             'HTage50t','hasHT')], by.x='CASEID_1979', by.y='R0000100')


sum(complete.cases(ht.df[,c('AFQT89','Adult_SES','Child_SES','hasHT','SAMPLE_SEX')]))


ht.df$age = 79 - as.numeric(levels(ht.df$DOB_year))[ht.df$DOB_year] ## Age assignment
# should this adjust for month too?
# see below for correct DOB calculation

ht.df$DOB = as.Date(paste3(paste0('19',as.numeric(levels(ht.df$DOB_year))[ht.df$DOB_year]),
                           as.numeric(levels(ht.df$DOB_month))[ht.df$DOB_month],
                           '01',sep='-'), format='%Y-%m-%d')
# and further down for correct age at 1979 survey calc

ht.df$HTdiagDate = ht.df$HTage50t
ht.df$HTage50t = as.numeric(ht.df$HTage50t)
ht.df$HTage50t = ht.df$HTage50t/365.25



### Remove 3 individuals who had HT from "birth"

indxs = which(as.numeric(as.Date("1970-01-01")) > as.numeric(ht.df$HTdiagDate))

ht.df = ht.df[-indxs,]



### Rename some columns

colnames(ht.df)[71:73] <- c('month_79','day_79','indiv_income') 
colnames(ht.df)[c(80,83,86,87:89)] <- c('H_activity','LM_activity','Str_training',
                                     'Smoked_atLeast100','Smoked_everDaily','Drinks_avgDay')
colnames(ht.df)[c(76:78,97:101)] <- c('weight_12','feet_12','inches_12',
                                      'height_85','weight_85','weight_06','feet_06','inches_06')
colnames(ht.df)[c(90:96)] <- c('Trying_to_lose','Read_nutrition','Read_ingredients',
                               'Fast_food','Snacked','Skipped_meal','Sugary_drink')
# Keep an eye on the above - numeric indices may need adjustment



### Create age at test var

pasteDate = as.Date(paste3('1979',
                           ht.df$month_79,
                           '01',sep='-'), format='%Y-%m-%d')
ht.df$age_1979 = (pasteDate-ht.df$DOB)/365.25



### Create BMI - 2012
ht.df$weight_12[ht.df$weight_12<0] = NA

ht.df$height_12 = -1
ht.df$feet_12 = ht.df$feet_12*12

ht.df$height_12[ht.df$inches_12<12&ht.df$inches_12>-0.1] = rowSums(ht.df[,c('feet_12','inches_12')], na.rm=T)[ht.df$inches_12<12&ht.df$inches_12>-0.1]

ht.df$height_12[ht.df$height_12<32] = NA

ht.df$height_12[ht.df$inches_12>12] = ht.df$inches_12[ht.df$inches_12>12]

ht.df$bmi_12 = ht.df$weight_12/(ht.df$height_12^2) * 703
#ht.df$bmi_12 = scale(ht.df$bmi_12)


## BMI - 1985
ht.df$weight_85[ht.df$weight_85<0] = NA
ht.df$height_85[ht.df$height_85<0] = NA

ht.df$bmi_85 = ht.df$weight_85/(ht.df$height_85^2) * 703


## BMI - 2006

ht.df$weight_06[ht.df$weight_06<0] = NA

ht.df$height_06 = -1
ht.df$feet_06 = ht.df$feet_06*12

ht.df$height_06[ht.df$inches_06<12&ht.df$inches_06>-0.1] = rowSums(ht.df[,c('feet_06','inches_06')], na.rm=T)[ht.df$inches_06<12&ht.df$inches_06>-0.1]

ht.df$height_06[ht.df$height_06<32] = NA

ht.df$height_06[ht.df$inches_06>12] = ht.df$inches_06[ht.df$inches_06>12]

ht.df$bmi_06 = ht.df$weight_06/(ht.df$height_06^2) * 703


## BMI differences

ht.df$bmi_diff = ht.df$bmi_06 - ht.df$bmi_85


# ht.df$bmi_06 = scaleht.df$bmi_06)
# ht.df$bmi_85 = scale(ht.df$bmi_85)
# ht.df$bmi_diff = scale(ht.df$bmi_diff)



### Individual income cleaning and transformation

ht.df$indiv_income[ht.df$indiv_income<0] = NA

## some stats before we scale this
aggregate(indiv_income ~ SAMPLE_SEX, data=ht.df, FUN=mean)


ht.df$indiv_income = scale(sqrt(ht.df$indiv_income))



### Health behaviours

ht.df$H_activity[ht.df$H_activity<0] = NA
ht.df$H_activity = scale(5 - ht.df$H_activity)

ht.df$LM_activity[ht.df$LM_activity<0] = NA
ht.df$LM_activity = scale(5 - ht.df$LM_activity)

ht.df$Str_training[ht.df$Str_training<0] = NA
ht.df$Str_training = scale(5 - ht.df$Str_training)

ht.df$Smoked_atLeast100[ht.df$Smoked_atLeast100<0] = NA
ht.df$Smoked_atLeast100 = as.factor(ht.df$Smoked_atLeast100)

ht.df$Smoked_everDaily[ht.df$Smoked_everDaily<0] = NA
ht.df$Smoked_everDaily = as.factor(ht.df$Smoked_everDaily)

ht.df$Drinks_avgDay[ht.df$Drinks_avgDay == -4] = 0
ht.df$Drinks_avgDay[ht.df$Drinks_avgDay < 0] = NA
ht.df$Drinks_avgDay = scale(ht.df$Drinks_avgDay)
# above is possibly not the best way to construct variable



### Diet variables

ht.df$Trying_to_lose[ht.df$Trying_to_lose<0] = NA
ht.df$Trying_to_lose[ht.df$Trying_to_lose==1] = -1 # consider dummy coding these
ht.df$Trying_to_lose[ht.df$Trying_to_lose==2] = 1
ht.df$Trying_to_lose[ht.df$Trying_to_lose==3] = 0
ht.df$Trying_to_lose[ht.df$Trying_to_lose==4] = 0

ht.df$Read_nutrition[ht.df$Read_nutrition<1] = NA
ht.df$Read_nutrition = scale(5 - ht.df$Read_nutrition)

ht.df$Read_ingredients[ht.df$Read_ingredients<1] = NA
ht.df$Read_ingredients = scale(5 - ht.df$Read_ingredients)

ht.df$Fast_food[ht.df$Fast_foods<0] = NA
ht.df$Fast_food = scale(ht.df$Fast_food)

ht.df$Snacked[ht.df$Snacked<0] = NA
ht.df$Snacked = scale(ht.df$Snacked)

ht.df$Skipped_meal[ht.df$Skipped_meal<0] = NA
ht.df$Skipped_meal = scale(ht.df$Skipped_meal)

ht.df$Sugary_drink[ht.df$Sugary_drink<0] = NA
ht.df$Sugary_drink = scale(ht.df$Sugary_drink)





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


