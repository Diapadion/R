# extracting DoB from hematology spreadsheet



birthday <- as.double(hematology$date1) - (365*as.double(hematology$age))


hematology$date1[1] - as.difftime(hematology$age[1], unit = "years")

as.Date(hematology$date1[2],"%d/%m/%y%y") - days(as.integer(365*as.double(as.character(hematology$age[2]))))

birthday <- as.Date(hematology$date1,"%d/%m/%y%y") - days(as.integer(365*as.double(as.character(hematology$age))))


write.csv(data.frame(hematology$chimp,birthday),'hemExtNames.csv')


---
  
colnames(const) = c('chimp','DoB')
  
  
  const <- NULL
# some vars like personality, parentage, DoB,
# stay constant, no matter the measurement point.
names <- read.csv("matchNameBDates.csv")
const = names$final

# removes names with no DoB (i.e. NAs)
const = const[!is.na(names$DoB)]

# get all the DoB's in the same format
const$DoB = names$DoB[!is.na(names$DoB)]
# i.e. dd/mm/yyyy
const$DoB = as.Date(const$DoB, format="%d/%m/%Y")

### coercing the composite full data file to remove junk 
final_data$chimp %in% const$names # this logically select the values common to both names lists
sData <- final_data[final_data$chimp %in% const$names,]

# parentage
# merging dame, sire; maternity, paternity


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

