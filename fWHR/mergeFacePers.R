### Formatting and joining for chimp faces
#
# Run from the top

library(dplyr)

s <- function(x) {scale(x)}


### Import face data
cPoints = read.csv(file = 'ChimpfWHR-LFFH.csv') #"ChimpfWHR.csv")

chFP <- cPoints[cPoints$fHWR!='N/A',]
chFP = chFP[,c(1:12,23)]

colnames(chFP)[8] <- 'Age'
chFP$Sex = as.factor(chFP$Sex)
chFP$fHWR = as.numeric(as.character(chFP$fHWR))
chFP$lffh = as.numeric(as.character(chFP$lffh))


#levels(chFP$ID) <- tolower(levels(chFP$ID))


### TODO this?
### Aggregate face measurements first

#chFP <- aggregate(cbind(fHWR,Sex)~ID+location, chFP, mean) # need Yerkes/Bastrop ages, then Age can go back into LS
# not strictly necessay with MLM, but averaging is better for consistency

#chFP <- aggregate(chFP, by = list(chFP$ID), FUN = mean)





### Import personality data and calculate dimensions
cPers = read.csv('long_all.csv')

# cutting off the bottom
cPers <- cPers[-c(558:dim(cPers)[1]),]

# removing row at 378, where the questionnaire changes
cPers <- cPers[-378,]

# removing AZA and Taronga
cPers <- cPers[(cPers$sample!='AZA')&(cPers$sample!='Taronga'),]

cPers[,c(7:60)] <- lapply((cPers[,c(7:60)]), as.character)
cPers[,c(7:60)] <- lapply((cPers[,c(7:60)]), as.numeric)

cPers$Dom = NA
cPers$Ext = NA
cPers$Con = NA
cPers$Agr = NA
cPers$Neu = NA
cPers$Opn = NA

ind = (cPers$sample == 'Yerkes')

cPers[ind,]$Dom <-
  (cPers[ind,]$dom-cPers[ind,]$subm-cPers[ind,]$depd+cPers[ind,]$indp-cPers[ind,]$fear+cPers[ind,]$decs
   -cPers[ind,]$tim-cPers[ind,]$caut+cPers[ind,]$intll+cPers[ind,]$pers+cPers[ind,]$buly+cPers[ind,]$stngy+40)/12

cPers[ind,]$Ext <-
  (-cPers[ind,]$sol-cPers[ind,]$lazy-cPers[ind,]$depr
   +cPers[ind,]$actv+cPers[ind,]$play+cPers[ind,]$soc+cPers[ind,]$frdy+cPers[ind,]$affc+cPers[ind,]$imit+24)/9

cPers[ind,]$Con <-
  (-cPers[ind,]$impl-cPers[ind,]$defn-cPers[ind,]$reckl-cPers[ind,]$errc-cPers[ind,]$irri
   +cPers[ind,]$pred-cPers[ind,]$aggr-cPers[ind,]$jeals-cPers[ind,]$dsor+64)/9

cPers[ind,]$Agr <-
  (cPers[ind,]$symp+cPers[ind,]$help+cPers[ind,]$sens+cPers[ind,]$prot+cPers[ind,]$gntl)/5

cPers[ind,]$Neu <-
  (-cPers[ind,]$stbl+cPers[ind,]$exct-cPers[ind,]$unem+16)/3

cPers[ind,]$Opn <-
  (cPers[ind,]$inqs+cPers[ind,]$invt) /2



ind = (cPers$sample == 'Japan' | cPers$sample == 'Edinburgh' | cPers$sample == 'Edinburgh.VADW' ) 

cPers[ind,]$Dom <-
  (cPers[ind,]$dom
   -cPers[ind,]$subm
   -cPers[ind,]$depd
   +cPers[ind,]$indp
   -cPers[ind,]$fear
   +cPers[ind,]$decs
   -cPers[ind,]$tim
   -cPers[ind,]$caut
   +cPers[ind,]$intll
   +cPers[ind,]$pers
   +cPers[ind,]$buly
   +cPers[ind,]$stngy
   -cPers[ind,]$Vuln - cPers[ind,]$Anx + cPers[ind,]$manp + 56)/15

cPers[ind,]$Ext <-
  (-cPers[ind,]$sol-cPers[ind,]$lazy-cPers[ind,]$depr
   +cPers[ind,]$actv+cPers[ind,]$play+cPers[ind,]$soc+cPers[ind,]$frdy+cPers[ind,]$affc+cPers[ind,]$imit
   -cPers[ind,]$Indv + 32)/10

cPers[ind,]$Con <-
  (-cPers[ind,]$impl-cPers[ind,]$defn-cPers[ind,]$reckl-cPers[ind,]$errc-cPers[ind,]$irri
   +cPers[ind,]$pred-cPers[ind,]$aggr-cPers[ind,]$jeals-cPers[ind,]$dsor
   - cPers[ind,]$Thot - cPers[ind,]$Dist - cPers[ind,]$Unper - cPers[ind,]$Quit - cPers[ind,]$clmy + 104)/14

cPers[ind,]$Agr <-
  (cPers[ind,]$symp+cPers[ind,]$help+cPers[ind,]$sens+cPers[ind,]$prot+cPers[ind,]$gntl
   + cPers[ind,]$Conv)/6

cPers[ind,]$Neu <-
  (-cPers[ind,]$stbl+cPers[ind,]$exct-cPers[ind,]$unem
   - cPers[ind,]$Cool + cPers[ind,]$aut + 24)/5

cPers[ind,]$Opn <-
  (cPers[ind,]$inqs+cPers[ind,]$invt
   + cPers[ind,]$Cur + cPers[ind,]$Innov) / 4



### Bastrop personality scoring

bPers <- read.csv('bastroppersonalitydata.csv')
bPers = bPers[1:143,]

bPers$Dom = NA
bPers$Ext = NA
bPers$Con = NA
bPers$Agr = NA
bPers$Neu = NA
bPers$Opn = NA



bPers$Dom <-
  (-bPers$meananxious-bPers$meancautious-bPers$meandependent-bPers$meantimid
   +bPers$meandominant+bPers$meanbold+bPers$meanbullying+bPers$meanstingy + 4*8
   )/8

bPers$Ext <-
  (-bPers$meandepressed-bPers$meansolitary
    +bPers$meanactive+bPers$meanaffectionatefriendly+bPers$meanaffiliative+bPers$meanplayful + 2*8
  )/6

bPers$Con <-
  (-bPers$meanaggressive-bPers$meandefiant-bPers$meanimpulsive-bPers$meanirritable
   -bPers$meanJealousattentionseeking-bPers$meantemperamentalmoody
   + 6*8 #+bPers$meanpredictable
  )/6
     
bPers$Agr <- 
  (bPers$meanconsideratekind+bPers$meanprotective)/2

bPers$Neu <- 
  (-bPers$meancalm
   +bPers$meaneccentric+bPers$meanexcitable + 1*8
   )/3

bPers$Opn <-
  (bPers$meaninquisitivecurious+bPers$meaninventive) /2




### Combine the two inventories

cPers = rbind(cPers[,c(1,69:74)],bPers[,c(1,49:54)])



# Scale each dimension across cPers chimps
cPers$Dom_CZ <- scale(cPers$Dom)
cPers$Ext_CZ <- scale(cPers$Ext)
cPers$Con_CZ <- scale(cPers$Con)
cPers$Agr_CZ <- scale(cPers$Agr)
cPers$Neu_CZ <- scale(cPers$Neu)
cPers$Opn_CZ <- scale(cPers$Opn)






### Merge face with pers data

#levels(cPers$chimp) <- tolower(levels(cPers$chimp))
chFP <- merge(chFP,cPers, by.x= "ID", "chimp")

# remove Yerkes
chFP <- chFP[chFP$location!='Yerkes',]



### Merge face with subspecies data

subsp = read.csv(file = "SPLambeth_species-DOB_JapanEdi.csv", header=T)

#chFPbak = chFP # 289 lines, 307 lines with Yerkes
#chFP = chFPbak

chFP <- merge(chFP,subsp[,c(1,2)], by.x='ID', by.y='Name')



### Renaming

colnames(chFP)[colnames(chFP) == 'fHWR'] <- 'fWHR'


chFP$instrument = 'HPQ'
chFP$instrument[chFP$location == 'Bastrop'] = 'Bas'



write.csv(chFP, 'chimpFacesPersDemos.csv')
