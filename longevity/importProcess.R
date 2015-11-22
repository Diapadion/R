### Importation and Processing

all <- read.csv("long_all.csv")

all[,c(7:60)] <- lapply((all[,c(7:60)]), as.character)
all[,c(7:60)] <- lapply((all[,c(7:60)]), as.numeric)

all$status[(all$status == '') & (all$sample == 'AZA')] <- 'Alive'
all$status[(all$status == 'LTF') & (all$sample == 'AZA')] <- 'rm'

all$status[(all$status == 'LTF') & (all$sample == 'Taronga')] <- 'Alive'

all$status[(all$status == 'LTF') & (all$sample == 'Yerkes')] <- 'Alive'

#levels(all$sample)

# remove the 'rm's until a better situation is realized
all <- all[!all$status == 'rm',]


# Dating shenanigans

all$DoB <- as.Date(all$DoB,format='%m/%d/%Y')
all$lastDate <- as.Date(all$lastDate, format='%d/%m/%Y')


### Ageing
# should be age at Personality rating

#head(all$lastDate - all$DoB)
all$age = as.numeric(difftime(all$lastDate, all$DoB, units = "weeks"))/52.25 
# The above is super useful. Remember that (it is here).

# making age at DOPR for Yerkes
# see other files - there may be an issue with death dates overlapping
all$DOPR = as.Date(all$DOPR,format='%m/%d/%Y')
all$DOPR2 = as.Date(all$DOPR2,format='%m/%d/%Y')
all$DOPRmin = pmin(all$DOPR, all$DOPR2, na.rm = TRUE)

# some death dates cut off
all$DOPRmin = pmin(all$DOPRmin, all$lastDate)




all$age_pr[all$sample == 'Yerkes'] = as.numeric(difftime(
  all$DOPRmin[all$sample == 'Yerkes'], all$DoB[all$sample == 'Yerkes'], units = "weeks"))/52.25 

library(lubridate)
all$DOPRmin[(all$sample == 'AZA') | (all$sample == 'Taronga')] <- 
  all$DoB[(all$sample == 'AZA') | (all$sample == 'Taronga')] + all$age_pr[(all$sample == 'AZA') | (all$sample == 'Taronga')]

yr = year(all$DoB[(all$sample == 'AZA') | (all$sample == 'Taronga')]) +
  all$age_pr[(all$sample == 'AZA') | (all$sample == 'Taronga')]

all$DOPRmin[(all$sample == 'AZA') | (all$sample == 'Taronga')] <- (as.Date(date_decimal(yr)))


month(all$DOPRmin)



### Origin
all$origin[all$sample == 'AZA' & all$origin == 'UNKNOWN'] <- 'CAPTIVE' # is this appropriate?

all$origin[(all$sample == 'Yerkes' | all$sample == 'Taronga') & all$origin == ''] <- 'CAPTIVE'
all$origin[(all$sample == 'Yerkes' | all$sample == 'Taronga') & all$origin == 'W'] <- 'WILD'

table(all$origin)
# library(dplyr) # needed?
all$origin = droplevels(all$origin)

### Lab vs. Zoo

all$LvZ[all$sample == 'AZA'] <- 'zoo'
all$LvZ[all$sample == 'Yerkes'] <- 'lab'
all$LvZ[all$sample == 'Taronga'] <- 'zoo'

###
# there're rearing styles in the AZA file...
# and the Yerkes hematology file...



### creating personality scores


# right now this is being applied to all
# will need to create HPQ composites later
# and compare the possibilities

all$Dom_CZ <-
  scale((all$dom-all$subm-all$depd+all$indp-all$fear+all$decs-all$tim-all$caut+
     all$intll+all$pers+all$buly+all$stngy+40)/12)

all$Ext_CZ <-
  scale((-all$sol-all$lazy+all$actv+all$play+all$soc-all$depr+all$frdy+all$affc+all$imit+24)/9)

all$Con_CZ <-
  scale((-all$impl-all$defn-all$reckl-all$errc-all$irri+all$pred-all$aggr-all$jeals-all$dsor+64)/9)

all$Agr_CZ <-
  scale((all$symp+all$help+all$sens+all$prot+all$gntl)/5)

all$Neu_CZ <-
  scale((-all$stbl+all$exct-all$unem+16)/3)

all$Opn_CZ <-
  scale((all$inqs+all$invt)/2)

