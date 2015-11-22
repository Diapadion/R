
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




#setwd("../Yerkes/")
#yp <- read.csv(file = "yerkes_dec2_traits.csv")