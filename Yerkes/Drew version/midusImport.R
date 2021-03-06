### MIDUS II data

setwd("M:/GitHub/R/Yerkes/Drew version/")
#midusIn <- read.table("midus-Data.csv")
# right now, the manual load of the .rda file is working best for the biomarkers
# tho I've no idea why
library(Hmisc)
library(SAScii)

midusP1 <- read.SAScii('04652-0001-Data.txt','04652-0001-Setup.sas')
#midusP1 <- read.table("midus-p1.tsv")

# load .rda first
midusBio <- da29282.0001[da29282.0001$B4ZBLOOD=='(3) COMPLETE',] # complete cases only
midusBio <- midusBio[midusBio$SAMPLMAJ!='(13) MILWAUKEE',] # don't have access to Milwaukee data

midusP1byBio <- midusP1[midusP1$M2ID %in% midusBio$M2ID,]
midusP1byBio <- midusP1byBio[match(midusBio$M2ID,midusP1byBio$M2ID),]

# let's put together what we need from the two
midus_c <- cbind(midusP1byBio,midusBio)

write.csv(midus_c, file='comboMIDUSpersBio.csv',sep=',')
midusP1$B1SOPEN[midusP1$B1SOPEN==8]<-NA
midusP1$B1SAGREE[midusP1$B1SAGREE==8]<-NA
midusP1$B1SCONS2[midusP1$B1SCONS2==8]<-NA
midusP1$B1SNEURO[midusP1$B1SNEURO==8]<-NA
midusP1$B1SEXTRA[midusP1$B1SEXTRA==8]<-NA
midusP1$B1SAGENC[midusP1$B1SAGENC==8]<-NA
write.csv(midusP1,file='midusP1cc.csv', sep=',')

rm(midusP1,midusBio,midusP1byBio)



### MIDJA

midja <- read.SAScii('30822-0001-Data.txt','30822-0001-Setup.sas')
midjaBio <- read.SAScii('34969-0001-Data.txt','34969-0001-Setup.sas')

#midjaBio <- midjaBio[midjaBio$BLooD ...?

midjaByBio <- midja[midja$MIDJA_IDS %in% midjaBio$MIDJA_IDS,]
midjaByBio <- midjaByBio[match(midjaBio$MIDJA_IDS,midjaByBio$MIDJA_IDS),]

midja_c <- cbind(midjaByBio,midjaBio)

write.csv(midja_c, file='comboMIDJApersBio.csv',sep=',')
midja$J1SAGENC[midja$J1SAGENC==8]<-NA
midja$J1SEXTRA[midja$J1SEXTRA==8]<-NA
midja$J1SCONS2[midja$J1SCONS2==8]<-NA
midja$J1SOPEN[midja$J1SOPEN==8]<-NA
midja$J1SAGREE[midja$J1SAGREE==8]<-NA
midja$J1SNEURO[midja$J1SNEURO==8]<-NA
write.csv(midja, file='midja_cc.csv')

rm(midja,midjaBio,midjaByBio)


### avoid these
midusP1 <- read.csv('midusP1cc.csv')
midja <- read.csv('midja_cc.csv')



midus_c <- read.csv('comboMIDUSpersBio.csv')

midja_c <- read.csv('comboMIDJApersBio.csv')


### Redesignating personality

# aligning MIDI items for better discriminability
# as informed by the HPQ and Weiss 2009

## This is probably not necessary.

# Outgoing - E
# Lively - E
# Active - E
# Talkative - E

# Friendly - E?

# 



library(psych)
library(xtable)



mid.out = xtable(describe(midja_c[
  ,c('J1SQ1', 'J2CAGE',
  'J1SAGENC','J1SEXTRA','J1SOPEN','J1SCONS2','J1SAGREE','J1SNEURO',
  'J2CBMI','J2BCHOL','J2BSCREA','J2CTRIG',
  'J2CBPS23','J2CBPD23')
])
)
print(mid.out, type='html', file='out.html')



mid.out = xtable(describe(midus_c[
  ,c('B1PRSEX', 'B4ZAGE',
     'B1SAGENC','B1SEXTRA','B1SOPEN','B1SCONS2','B1SAGREE','B1SNEURO',
     'B4PBMI','B4BCHOL','B4BSCREA','B4BTRIGL',
     'B4P1GS23','B4P1GD23')
  ])
)
print(mid.out, type='html', file='out.html')


describe(as.factor(midja_c[,'J1SQ1']))

