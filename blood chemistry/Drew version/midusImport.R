### MIDUS II data

setwd("C:/Users/s1229179/git-repos/R/blood chemistry/Drew version/")
#midusIn <- read.table("midus-Data.csv")
# right now, the manual load of the .rda file is working best for the biomarkers
# tho I've no idea why
library(Hmisc)
library(SAScii)
midusP1 <- read.SAScii('04652-0001-Data.txt','04652-0001-Setup.sas')
#midusP1 <- read.table("midus-p1.tsv")

midusBio <- da29282.0001[da29282.0001$B4ZBLOOD=='(3) COMPLETE',] # complete cases only
midusBio <- midusBio[midusBio$SAMPLMAJ!='(13) MILWAUKEE',] # don't have access to Milwaukee data

midusP1byBio <- midusP1[midusP1$M2ID %in% midusBio$M2ID,]
midusP1byBio <- midusP1byBio[match(midusBio$M2ID,midusP1byBio$M2ID),]

# let's put together what we need from the two
midus_c <- cbind(midusP1byBio,midusBio)

write.csv(midus_c, file='comboMIDUSpersBio.csv',sep=',')

rm(midusBio,midusIn,midusP1,midusP1byBio)



### MIDJA

midja <- read.SAScii('30822-0001-Data.txt','30822-0001-Setup.sas')
midjaBio <- read.SAScii('34969-0001-Data.txt','34969-0001-Setup.sas')

#midjaBio <- midjaBio[midjaBio$BLooD ...?

midjaByBio <- midja[midja$MIDJA_IDS %in% midjaBio$MIDJA_IDS,]
midjaByBio <- midjaByBio[match(midjaBio$MIDJA_IDS,midjaByBio$MIDJA_IDS),]

midja_c <- cbind(midjaByBio,midjaBio)

write.csv(midja_c, file='comboMIDJApersBio.csv',sep=',')

rm(midja,midjaBio,midjaByBio)
