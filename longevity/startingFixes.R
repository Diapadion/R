# This file should not need to be run
# it was used for getting the different sample in line for concatenation


trong <- read.csv(file = "Taronga Chimpanzees.csv")

# fiddling the Taronga DoBs
trong$bdate <- as.Date(trong$bdate, format = "%d/%m/%Y")

trong$formDoB <- format(trong$bdate, "%m/%d/%Y")
write.csv(trong$formDoB,"TarongaDoB.csv")

AZA <- read.csv("czoo.csv")
colnames(AZA)[c(11:53)]

Japan <- read.csv("japan_chimps_22_dec_2012.csv")
colnames(Japan)[c(5:58)]

yerk <- read.csv("Yerkes Mortality.csv")


all <- read.csv("long_all.csv")

# finding the differences between CPQ and HPQ
setdiff(tolower(colnames(Japan)[c(5:58)]),colnames(AZA)[c(11:53)])



# aggregating DOPR dates from Yerkes

# some were rated after their death... what should the DOPR be then? The date of death?

# No, they should be removed (and now have been).




#setwd("../Yerkes/")
#yp <- read.csv(file = "yerkes_dec2_traits.csv")



### lining up the newly dead Yerkes chimps
yerk16 <- read.csv("./Yerkes aggregation/sub+status.csv")

yerk16 <- merge(yerk16, yerk[c(1,11)])

y16changes = c(8,16,23,25,29,34,41,42,44,65,69,72,79,81,82,83,86,88,89,102,109,119)
y16changes = yerk16[y16changes,]$Subject # just find these individuals and replace their status's and DoD's


### determining the last date of info for the AZoos with LTF chimps

# find the LTFs first
ALTFs = ((all$status == 'LTF') & (all$sample =='AZA'))
which(ALTFs)
AZA$zoo[ALTFs]
# they're all at 20, 5, and 3
all$lastDate[AZA$zoo == 20]


### missing DoB's and other hints:
http://last1000chimps.com/
