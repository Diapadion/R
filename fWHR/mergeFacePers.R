### Formatting and joining for chimp faces
#
# Run from the top



s <- function(x) {scale(x)}


### Import face data
cPoints = read.csv(file = "ChimpfWHR.csv")

chFP <- cPoints[cPoints$fHWR!='N/A',]
chFP = chFP[,c(1:12)]

colnames(chFP)[8] <- 'Age'
chFP$Sex = as.factor(chFP$Sex)
chFP$fHWR = as.numeric(as.character(chFP$fHWR))



### Aggregate face measurements first?

chFP <- aggregate(cbind(fHWR,Age,Sex)~ID+location, chFP, mean) # need Yerkes ages, then Age can go back into LS

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



ind = (cPers$sample == 'Japan' | cPers$sample == 'Edinburgh') 

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


# Scale each dimension across cPers chimps
cPers$Dom_CZ <- scale(cPers$Dom)
cPers$Ext_CZ <- scale(cPers$Ext)
cPers$Con_CZ <- scale(cPers$Con)
cPers$Agr_CZ <- scale(cPers$Agr)
cPers$Neu_CZ <- scale(cPers$Neu)
cPers$Opn_CZ <- scale(cPers$Opn)






### Merge face with pers data

chFP <- merge(chFP,cPers, by.x= "ID", "chimp")





