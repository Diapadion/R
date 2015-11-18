### following on from make data.R,
### these are DMA additions that
### build a data set with all values
### from the observation sheet

# i.e. its a giant data.frame full of NAs
# utility is questionable

const <- NULL
# some vars like personality, parentage, DoB,
# stay constant, no matter the measurement point.
names <- read.csv("matchNameBDates.csv")
const$chimp = names$final

# removes names with no DoB (i.e. NAs)
const$chimp = const$chimp[!is.na(names$DoB)]

# get all the DoB's in the same format
const$DoB = names$DoB[!is.na(names$DoB)]
# i.e. dd/mm/yyyy
const$DoB = as.Date(const$DoB, format="%d/%m/%Y")

### coercing the composite full data file to remove junk 
#final_data$chimp %in% const$chimp # this logically select the values common to both names lists
sData <- final_data[final_data$chimp %in% const$chimp,]

# parentage
# merging dame, sire; maternity, paternity
### TODO


# momage = the age of the mother at the chimp's birth
const$MomAge = sData$momage

# group size
const$GroupSize <- ifelse(!is.na(sData$Group.size.x), sData$Group.size.x,
                          ifelse(!is.na(sData$Group.size.y), sData$Group.size.y, NA))           

# sex
const$sex <- sData$sex

# personality - individual adjectives
# const$fear  <- sData$fear.z
# const$pers   <- sData$pers.z 
# const$caut   <- sData$caut.z 
# const$stbl   <- sData$stbl.z 
# const$aut   <- sData$aut.z 
# const$stngy  <- sData$stngy.z
# const$jeals  <- sData$jeals.z
# const$reckl  <- sData$reckl.z
# const$soc   <- sData$soc.z 
# const$tim   <- sData$tim.z 
# const$symp  <-  sData$symp.z 
# const$play  <-  sData$play.z 
# const$sol  <-  sData$sol.z 
# const$actv   <- sData$actv.z 
# const$help   <- sData$help.z 
# const$buly   <- sData$buly.z 
# const$aggr  <-  sData$aggr.z 
# const$manp  <-  sData$manp.z 
# const$gntl  <-  sData$gntl.z 
# const$affc   <- sData$affc.z 
# const$exct   <- sData$exct.z 
# const$impl   <- sData$impl.z 
# const$inqs   <- sData$inqs.z 
# const$subm   <- sData$subm.z 
# const$depd   <- sData$depd.z 
# const$irri   <- sData$irri.z 
# const$pred   <- sData$pred.z 
# const$decs   <- sData$decs.z 
# const$depr   <- sData$depr.z 
# const$sens   <- sData$sens.z 
# const$defn   <- sData$defn.z 
# const$intll  <- sData$intll.z
# const$prot   <- sData$prot.z 
# const$invt   <- sData$invt.z 
# const$clmy   <- sData$clmy.z 
# const$errc   <- sData$errc.z 
# const$frdy   <- sData$frdy.z 
# const$lazy   <- sData$lazy.z 
# const$dsor   <- sData$dsor.z 
# const$unem   <- sData$unem.z 
# const$imit   <- sData$imit.z 
# const$indp <-  sData$indp.z

const$fear  <- apply(cbind(sData$fear.x,sData$fear.y),1,mean,na.rm=TRUE)
const$dom <- apply(cbind(sData$dom.x,sData$dom.y),1,mean,na.rm=TRUE)
const$pers  <- apply(cbind(sData$pers.x,sData$pers.y),1,mean,na.rm=TRUE)
const$caut  <- apply(cbind(sData$caut.x,sData$caut.y),1,mean,na.rm=TRUE)
const$stbl  <- apply(cbind(sData$stbl.x,sData$stbl.y),1,mean,na.rm=TRUE)
const$aut   <- apply(cbind(sData$aut.x,sData$aut.y),1,mean,na.rm=TRUE)
const$stngy  <- apply(cbind(sData$stngy.x,sData$stngy.y),1,mean,na.rm=TRUE)
const$jeals  <- apply(cbind(sData$jeals.x,sData$jeals.y),1,mean,na.rm=TRUE)
const$reckl  <- apply(cbind(sData$reckl.x,sData$reckl.y),1,mean,na.rm=TRUE)
const$soc   <- apply(cbind(sData$soc.x,sData$soc.y),1,mean,na.rm=TRUE)
const$tim   <- apply(cbind(sData$tim.x,sData$tim.y),1,mean,na.rm=TRUE)
const$symp  <- apply(cbind(sData$symp.x,sData$symp.y),1,mean,na.rm=TRUE)
const$play <- apply(cbind(sData$play.x,sData$play.y),1,mean,na.rm=TRUE)
const$sol   <- apply(cbind(sData$sol.x,sData$sol.y),1,mean,na.rm=TRUE)
const$actv  <- apply(cbind(sData$actv.x,sData$actv.y),1,mean,na.rm=TRUE)
const$help  <- apply(cbind(sData$help.x,sData$help.y),1,mean,na.rm=TRUE)
const$buly  <- apply(cbind(sData$buly.x,sData$buly.y),1,mean,na.rm=TRUE)
const$aggr  <- apply(cbind(sData$aggr.x,sData$aggr.y),1,mean,na.rm=TRUE)
const$manp  <- apply(cbind(sData$manp.x,sData$manp.y),1,mean,na.rm=TRUE)
const$gntl  <- apply(cbind(sData$gntl.x,sData$gntl.y),1,mean,na.rm=TRUE)
const$affc  <- apply(cbind(sData$affc.x,sData$affc.y),1,mean,na.rm=TRUE)
const$exct  <- apply(cbind(sData$exct.x,sData$exct.y),1,mean,na.rm=TRUE)
const$impl  <- apply(cbind(sData$impl.x,sData$impl.y),1,mean,na.rm=TRUE)
const$inqs  <- apply(cbind(sData$inqs.x,sData$inqs.y),1,mean,na.rm=TRUE)
const$subm  <- apply(cbind(sData$subm.x,sData$subm.y),1,mean,na.rm=TRUE)
const$depd  <- apply(cbind(sData$depd.x,sData$depd.y),1,mean,na.rm=TRUE)
const$irri  <- apply(cbind(sData$irri.x,sData$irri.y),1,mean,na.rm=TRUE)
const$pred  <- apply(cbind(sData$pred.x,sData$pred.y),1,mean,na.rm=TRUE)
const$decs  <- apply(cbind(sData$decs.x,sData$decs.y),1,mean,na.rm=TRUE)
const$depr  <- apply(cbind(sData$depr.x,sData$depr.y),1,mean,na.rm=TRUE)
const$sens  <- apply(cbind(sData$sens.x,sData$sens.y),1,mean,na.rm=TRUE)
const$defn  <- apply(cbind(sData$defn.x,sData$defn.y),1,mean,na.rm=TRUE)
const$intll  <- apply(cbind(sData$intll.x,sData$intll.y),1,mean,na.rm=TRUE)
const$prot  <- apply(cbind(sData$prot.x,sData$prot.y),1,mean,na.rm=TRUE)
const$invt  <- apply(cbind(sData$invt.x,sData$invt.y),1,mean,na.rm=TRUE)
const$clmy  <- apply(cbind(sData$clmy.x,sData$clmy.y),1,mean,na.rm=TRUE)
const$errc  <- apply(cbind(sData$errc.x,sData$errc.y),1,mean,na.rm=TRUE)
const$frdy  <- apply(cbind(sData$frdy.x,sData$frdy.y),1,mean,na.rm=TRUE)
const$lazy  <- apply(cbind(sData$lazy.x,sData$lazy.y),1,mean,na.rm=TRUE)
const$dsor  <- apply(cbind(sData$dsor.x,sData$dsor.y),1,mean,na.rm=TRUE)
const$unem  <- apply(cbind(sData$unem.x,sData$unem.y),1,mean,na.rm=TRUE)
const$imit <- apply(cbind(sData$imit.x,sData$imit.y),1,mean,na.rm=TRUE)
const$indp <- apply(cbind(sData$indp.x,sData$indp.y),1,mean,na.rm=TRUE)

# domains
const$chimp_Dom_CZ <-
  (const$dom-const$subm-const$depd+const$indp-const$fear+const$decs-const$tim-const$caut+
     const$intll+const$pers+const$buly+const$stngy+40)/12

const$chimp_Ext_CZ <-
  (-const$sol-const$lazy+const$actv+const$play+const$soc-const$depr+const$frdy+const$affc+const$imit+24)/9

const$chimp_Con_CZ <-
  (-const$impl-const$defn-const$reckl-const$errc-const$irri+const$pred-const$aggr-const$jeals-const$dsor+64)/9

const$chimp_Agr_CZ <-
  (const$symp+const$help+const$sens+const$prot+const$gntl)/5

const$chimp_Neu_CZ <-
  (-const$stbl+const$exct-const$unem+16)/3

const$chimp_Opn_CZ <-
  (const$inqs+const$invt)/2


## other outside vars we want to keep constant
# mortality
#sData <- final_data[final_data$chimp %in% const$chimp]
# we can still use 'final_data' and thus sData from this

const$alive <- sData$status


# VERY IMPORTANT
# does the personality+ matrix (after DoB filtering) contain the entire 
# union of chimps from the subsidiary data files?


### and now the time dependent observations


## date nomralizing bs
# blood chemistry: mm/dd/??yy
# hematology: dd/mm/yyyy
# height: mm/dd/yyyy
# metabolic: mm/dd/??yy


## Blood chemistry
# split up measurements by time point
a = cbind(blood[,2],blood[,3:28])#),
b = cbind(blood[,2],blood[,29:54])#),
c = cbind(blood[,2],blood[,55:80])#),
d = cbind(blood[,2],blood[,81:106])#))

colnames(a) <- c( "chimp",   "date",         "Glucose",       "BUN"  ,         "Creatine"   ,  "Protein"    ,   "Albumn"       ,
                  "Bilirubn"   ,   "alkphos"      , "sgpt"   ,       "sgot"    ,      "cholesterol" ,  "calcium"    ,   "phosphate"   , 
                  "sodium"   ,     "potassium"   ,  "chloride"     , "ag_ratio"    ,  "bc_ratio"   ,   "globulin"  ,    "lipase" ,      
                  "amylase"     ,  "triglycerides" ,"cpk"    ,       "ggtp"     ,     "magnesium"   ,  "osmolal")      
colnames(b) <- colnames(a)
colnames(c) <- colnames(a)
colnames(d) <- colnames(a)

longBlood <- as.data.frame(rbind(a,b,c,d))
yeart <- NULL
for (i in 1:(dim(longBlood)[1])){
  yeart[i] <- longBlood$date[i]
  if(nchar(yeart[i])==10){
    yeart[i] <- as.Date(yeart[i],format = "%m/%d/%Y")
  }
  else yeart[i] <- as.Date(yeart[i],format = "%m/%d/%y")
}
class(yeart) <- "Date"
longBlood$date <- yeart


## Hematology
# split up measurements by time point
# 
a = cbind(hematology[,1],hematology[,11:21])
b = cbind(hematology[,1],hematology[,22:32])
c = cbind(hematology[,1],hematology[,33:43])

colnames(a) <- c('chimp','date',colnames(hematology)[12:21])
colnames(b) <- colnames(a)
colnames(c) <- colnames(a)

longHem <- as.data.frame(rbind(a,b,c))
yeart <- NULL
for (i in 1:(dim(longHem)[1])){
  yeart[i] <- longHem$date[i]
  yeart[i] <- as.Date(yeart[i],format = "%d/%m/%Y")
}
class(yeart) <- "Date"
longHem$date <- yeart


## Height, Weight, BMI
# a <- NULL
# b <- NULL
# c <- NULL
a = cbind(height[,2],height[,3:11])
b = cbind(height[,2],height[,14:22])
c = cbind(height[,2],height[,25:33])

colnames(a) <- c('chimp','date',colnames(height[,4:11]))
colnames(b) <- colnames(a)
colnames(c) <- colnames(a)

longHeight <- as.data.frame(rbind(a,b,c))

yeart <- NULL
for (i in 1:(dim(longHeight)[1])){
  yeart[i] <- longHeight$date[i]
  yeart[i] <- as.Date(yeart[i],format = "%m/%d/%Y")
  
}
class(yeart) <- "Date"
longHeight$date <- yeart



## Metabolic, blood pressure
a = cbind(blood_pressure[,1],blood_pressure[,4:6])
b = cbind(blood_pressure[,1],blood_pressure[,7:9])
c = cbind(blood_pressure[,1],blood_pressure[,10:12])

colnames(a) <- c('chimp','date','BP','weight')
colnames(b) <- colnames(a)
colnames(c) <- colnames(a)

longMetab <- as.data.frame(rbind(a,b,c))

yeart <- NULL
for (i in 1:(dim(longMetab)[1])){
  yeart[i] <- longMetab$date[i]
  if(nchar(yeart[i])==10){
    yeart[i] <- as.Date(yeart[i],format = "%m/%d/%Y")
  }
  else yeart[i] <- as.Date(yeart[i],format = "%m/%d/%y")
}
class(yeart) <- "Date"
longMetab$date <- yeart

#longMetab <- as.data.frame(cbind(longMetab[,1],sapply(longMetab[,2],as.character),longMetab[,3:4]), stringsAsFactors=FALSE)







# based on our other height data, going to want to calculate more BMI datapoints



#fixed  #???





### putting all the data together

# these don't work alone...
#const = do.call(rbind.data.frame,const)
#constant <- ldply(const, data.frame)
#constant <- as.data.frame(const
#                         , row.names = const$chimp)





fullcast <- 
  merge(
    merge(
      merge(
        merge(longBlood, longHem, by=c('chimp','date'), all = TRUE)
        , longHeight, by=c('chimp','date'), all = TRUE)
      , longMetab, by=c('chimp','date'), all = TRUE)
    , const, by=c('chimp'), all = TRUE)
# there are a bunch of NA filled rows that result from this (for certain chimps)
# this is not a problem, it is an artifact of how the 'heights' data needed
# to be processed.

fullcast <- fullcast[!is.na(fullcast$date),]
# there, fixed




### after merging all the data together, we want to make a new column for age
#   based on the DoB and the time point at which the obv was made


# we need to convert the date to the right format to do this

fullcast['ageDays'] <- NA
#fullcast$ageDays <- difftime(fullcast$date, fullcast$DoB, units = 'days')
fullcast$ageDays <- as.numeric(fullcast$date) - as.numeric(fullcast$DoB)


### 
# and we need to separate out the systolic and diastolic blood pressures and
# putting them in their own vars

fullcast["systolic"] <- NA
fullcast["diastolic"] <- NA

bps <- strsplit(as.character(fullcast$BP),"[/]")

for (i in 1:dim(fullcast)[1]){
  bps <- strsplit(as.character(fullcast$BP),"[/]")
  if (!is.na(bps)[[i]]){
    fullcast$systolic[i] = as.numeric(bps[[i]][1])
    fullcast$diastolic[i] = as.numeric(bps[[i]][2]) 
    
  }
  else{
    fullcast$systolic[i] = NA
    fullcast$diastolic[i] = NA    
  }
}




### an alternative way to categorize these is purely by age,
### specifically, age when the blood pressure is measured

# (Survey 1)

buff <- merge(const, a[1:2], all=TRUE)   # remember, 'a' is the first survey of metabolics...
colnames(buff)[55] <- 'age'

# some date formatting formalities
yeart <- NULL
for (i in 1:(dim(buff)[1])){
  yeart[i] <- buff$age[i]
  if(nchar(yeart[i])==10){
    yeart[i] <- as.Date(yeart[i],format = "%m/%d/%Y")
  }
  else yeart[i] <- as.Date(yeart[i],format = "%m/%d/%y")
}
class(yeart) <- "Date"
const$age <- as.numeric(yeart) - as.numeric(const$DoB)


