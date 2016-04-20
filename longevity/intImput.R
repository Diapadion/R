# For doing the multiple inputation and midpoints



### First, the midpoint replacement

# need to make a new column where the chimps who have died before 2016 
# are set to 'Dead' and have their date changed to...

as.Date("01/02/16", format="%d/%m/%y") - as.Date("18/03/11", format="%d/%m/%y") # 1781 days
as.Date("18/03/11", format="%d/%m/%y") + 1781/2

# ... 24/08/2013

# Midpoint replacement has been implemented in importProcess.R



### Second, we want to try imputing the values within the intervals 

# blargh, use Amelia
library(Amelia)

# require(MIICD)
#install.packages('./Icens_1.43.0.zip', repos=NULL)
#library(interval)

# Different types of intervals

# the left point can just be $lastDate
# but we need the var in the df
all$left <- as.numeric(all$lastDate)

all$right <- NA

# the known dead ones
all[all$status=='Death',]$right = all[all$status=='Death',]$lastDate

# the known live ones
all[all$status=='Alive',]$right = Inf

# the unknown dead ones
#all[all$chimp %in% y16changes,]$right = as.Date("01/02/16", format="%d/%m/%y")
all[all$chimp %in% y16changes,]$right = NA


# removing 'X' - take note
# all = all[,-61]



# I think a custom matrix would be better
datImp = all[,c(1,2,4,5,7:49,66,69,73:78)]
datImp$sex = as.numeric(datImp$sex)
datImp$status = as.numeric(datImp$status)
datImp$lastDate = as.numeric(datImp$lastDate)

# I don't think it likes those Inf's
datImp[datImp$chimp %in% y16changes,]$lastDate = NA

as.numeric(as.Date("01/02/16", format="%d/%m/%y")) # 15051
as.numeric(as.Date("18/03/11", format="%d/%m/%y")) # 16832


runs = 100
imput <- amelia(datImp, m = runs, p2s = 0, #ts = 'right', 
                idvars = c('chimp'),
                bounds=matrix(c(
                  4, #85 for 'right' 
                  15051,16832),nrow=1),
                max.resample = 1000
                # column numbers may change - watch out
                )



imput$imputations$imp8$lastDate[datImp$chimp %in% y16changes]
#View(imput$imputations$imp7)

#imput.1000 = imput

store <- NULL


for(i in 1:runs){
  store = cbind(store,imput$imputations[[i]]$lastDate[datImp$chimp %in% y16changes])
}
imp.m.sd.100 = data.frame(Means=rowMeans(store), SD=apply(store,1, sd, na.rm = TRUE))  
  
  

# 
# install.packages("ZeligChoice")
# source('http://bioconductor.org/biocLite.R')
# biocLite('graph')
# biocLite("Rgraphviz")
# library(Zelig)
# 
# 
# zim.AFT
# 
# 
# 
# zim.BMI3 = zelig(BMI ~ Dominance + Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion + age + sex + age2, 
#                  data = imp_mean$imputations, model="ls")
# 
# library(ZeligMultilevel)
# zimm3.BMI = zelig(BMI ~ dom + open + agree + cons + neuro + extra
#                   + age + sex + age2 + tag(1 | chimp), 
#                   data = imp_out$imputations, model="ls.mixed")




#################################

# imput = MI.surv(100, 10, all, T)
# uhhhhh maybe this isn't what we want


# error
# imp.cox.m1 <- MIICD.coxph(formula = ~ as.factor(sex) +
#                             as.factor(origin) +  
#                             Dom_CZ + E.r2.DoB + Con_CZ + 
#                             Agr_CZ + Neu_CZ + O.r2.DoB,
#                             k = 100, m = 10,
#                             data = datX,
#                             method = 'ANDA',
#                             verbose = FALSE)
