### NHANES III data
library(SAScii)
library(psych)

nhanes.bm <- read.SAScii('Z:/NHANES III/DS0010/02231-0010-Data.txt',
                         'Z:/NHANES III/DS0010/02231-0010-Setup.sas')

nhanes.ex <- read.SAScii('Z:/NHANES III/exam/DS0002/02231-0002-Data.txt',
                         'Z:/NHANES III/exam/DS0002/02231-0002-Setup.sas')

sort( sapply(ls(),function(x){object.size(get(x))}))


### Chimps

c.bm <- read.csv(file = 'cNHANES.csv')
c.bm$wbc = c.bm$wbc/1000
c.bm$lymph = c.bm$lymph*1000



# Vars of interest

hist(nhanes.bm$HSSEX) # sex
hist(nhanes.bm$HSAGEIR) # age at 'interview'



HEMATOLOGY
WCP - WBC count - I think this needs to be /1000 in the chimps
RCP - RBC count
HTP - Hematocrit (%)
HGP - Hemaglobin
MVPSI - Mean corpuscular / cell volume (SI)
MCPSI - mean corpuscular / cell hemaglobin (SI)
MHP - mean cell hemaglobin concentration
LMPDIF - lymphocytes (% of 100 cells) - I think this need to be *1000 in chimps
MOPDIF - monocytes (% of 100 cells)
EOP - eosinophils (% of 100 cells)
#BOP - basophils (% of 100 cells) # not in chimps

SERUM BIOCHEMISTRY
SGP - Glucose
BUP - Blood Urea Nitrogen
CEP - Creatinine
TPP - (total) Protein
AMP - Albumin
TBP - (total) Bilirubin
APPSI - Alkaline Phosphatase
ATPSI - Alanine Aminotransferase (SGPT)
ASPSI - Aspartate aminotransferase (SGOT)
TCP - (total) Cholesterol
SCP - (total) Calcium
PSP - Phosphorus
NAPSI - Sodium
SKPSI - Potassium
CLPSI - Chloride
- AG ratio?
- BC ratio?
GBP - Globulin
! - Lipase
! - Amylase 
TBP - Triglycerides
! - Creatine Phosphokinase
GGPSI - Gamma-glutamyl transpeptidase (GGTP)
! - Magnesium
OSPSI - Osmolality

EXAM DATA (*NEW* - from different file)
BMPBMI - BMI
PEPMNK1R - Systolic BP (avg)
PEPMNK5R - Diastolic BP (avg)







# selecting out which variable we want to work with

# temp: for now, using the vars in common with the chimp set


bmlabels = c('SEQN',"HSSEX","HSAGEIR", 
             'WCP','RCP','HTP','HGP','MVPSI','MCPSI','MHP',
             'LMPDIF','MOPDIF','EOP',#'BOP', not in chimps
             'SGP','BUP','CEP','TPP','AMP','TBP','APPSI','ATPSI','ASPSI',
             'TCP','SCP','PSP','NAPSI','SKPSI','CLPSI','GBP','TGP','GGPSI',
             'OSPSI')
# bmlabels %in% colnames(nhanes.bm)


sel.nbm = nhanes.bm[,bmlabels]

sel.nx = nhanes.ex[,c('SEQN','BMPBMI','PEPMNK1R','PEPMNK5R')]

sel.nbm = merge(sel.nbm, sel.nx, by = c('SEQN'))
# can rm the original files past this point
#rm(nhanes.bm)
#rm(nhanes.ex)


# fixing the NA coding
#table(sel.nbm[,'SGP'])

sel.nbm$WCP[sel.nbm$WCP == 88888] = NA

sel.nbm$RCP[sel.nbm$RCP == 8888] = NA

sel.nbm$HTP[sel.nbm$HTP == 88888] = NA

sel.nbm$HGP[sel.nbm$HGP == 88888] = NA

sel.nbm$MVPSI[sel.nbm$MVPSI == 88888] = NA

sel.nbm$MCPSI[sel.nbm$MCPSI == 88888] = NA

sel.nbm$MHP[sel.nbm$MHP == 88888] = NA

sel.nbm$LMPDIF[sel.nbm$LMPDIF == 888] = NA

sel.nbm$MOPDIF[sel.nbm$MOPDIF == 88] = NA

sel.nbm$EOP[sel.nbm$EOP == 88] = NA

sel.nbm$BOP[sel.nbm$BOP == 88] = NA

sel.nbm$SGP[sel.nbm$SGP == 888] = NA

sel.nbm$BUP[sel.nbm$BUP == 888] = NA

sel.nbm$CEP[sel.nbm$CEP == 8888] = NA

sel.nbm$TPP[sel.nbm$TPP == 8888] = NA

sel.nbm$AMP[sel.nbm$AMP == 888] = NA

sel.nbm$TBP[sel.nbm$TBP == 8888] = NA

sel.nbm$APPSI[sel.nbm$APPSI == 8888] = NA

sel.nbm$ATPSI[sel.nbm$ATPSI == 888] = NA

sel.nbm$ASPSI[sel.nbm$ASPSI == 888] = NA

sel.nbm$TCP[sel.nbm$TCP == 888] = NA

sel.nbm$SCP[sel.nbm$SCP == 8888] = NA

sel.nbm$PSP[sel.nbm$PSP == 8888] = NA

sel.nbm$NAPSI[sel.nbm$NAPSI == 88888] = NA

sel.nbm$SKPSI[sel.nbm$SKPSI == 8888] = NA

sel.nbm$CLPSI[sel.nbm$CLPSI == 88888] = NA

sel.nbm$GBP[sel.nbm$GBP == 888] = NA

sel.nbm$TGP[sel.nbm$TGP == 8888] = NA

sel.nbm$GGPSI[sel.nbm$GGPSI == 8888] = NA

sel.nbm$OSPSI[sel.nbm$OSPSI == 888] = NA

sel.nbm$PEPMNK1R[sel.nbm$PEPMNK1R == 888] = NA

sel.nbm$PEPMNK5R[sel.nbm$PEPMNK5R == 888] = NA

sel.nbm$BMPBMI[sel.nbm$BMPBMI == 8888] = NA


# remove rows with all NAs for non-demographic data
# 35 vars, 32 of which are BMs

sel.nbm <- sel.nbm[(rowSums(is.na(sel.nbm))<32),]

colnames(c.bm)[c(2,4)] = c('subject','age')

colnames(sel.nbm)[1:35] <- colnames(c.bm)[2:36]

c.bm$species = as.factor('chimp')
sel.nbm$species = as.factor('human')


### Set a seed and split the data into exploration and conformation batches

set.seed(12345)
sampl.nbm <- sample(29314)  
sampl.pca <- sampl.nbm[1:9000]
sampl.cfa <- sampl.nbm[9001:18000]

### Chimp data -
### What about an averaged version?

c.bm.m = aggregate(c.bm, by = list(c.bm$subject), FUN=mean, na.rm=T
                   , na.action=na.pass)
# head(c.bm.m)
c.bm.m$subject = c.bm.m$Group.1
c.bm.m$species = 'chimp'
c.bm.m = c.bm.m[,c(-1,-2)]

# in NHANES males are 1 and females are 2 so we change to that
c.bm.m$sex[c.bm.m$sex==0] <- 2



### Scaling

# Independent for BMI

c.bm.m.s = c.bm.m
c.bm.m.s$BMI = scale(c.bm.m.s$BMI, center=T)
#c.bm.m.s[,c(3:35)] = data.frame(lapply(c.bm.m.s[,c(3:35)], function(x) scale(x, center = T)))



# Age adjustment for chimps

c.bm.m.s$age = c.bm.m.s$age * 1.5




all.bm = sel.nbm[sampl.cfa,]
all.bm$BMI = scale(all.bm$BMI, center=T)

# Composite df

all.bm = rbind(all.bm,
               c.bm.m.s)
                 #complete.cases(sel.nbm),])

max(complete.cases)

# Non-independent scaling for everything else

all.bm[,c(3:35)] = data.frame(lapply(all.bm[,c(3:35)], function(x) scale(x, center = T)))

all.bm$sex = as.factor(all.bm$sex)

describe(all.bm)



