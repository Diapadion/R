# 3 group SEMs
# MiDUS, MIDJA, Yerkes




all1 <- midja_cs[,c(1:16)]
colnames(all1)[1] <- 'M2ID'
all1 <- cbind(all1,'Japan')
colnames(all1)[17] <- 'group'

all2 <- cbind(midus_cs[,c(1:16)],'USA')
colnames(all2)[17] <- 'group'

all3 <- rbind(all1,all2)
              


library(lavaan)
library(semPlot)
library(semTools)
library(blavaan)


sem.1 <- '

AL =~ 1*chol + 1*creat + 1*trig + 1*sys + 1*dias + 1*BMI

AL ~ sex + age + age2 + Dominance + Extraversion + Openness + Conscientiousness + Agreeableness + Neuroticism

sys ~~ dias
sys ~~ trig
sys ~~ creat
sys ~~ BMI
sys ~~ chol
dias ~~ trig
dias ~~ creat
dias ~~ BMI
dias ~~ chol
trig ~~ creat
trig ~~ BMI
trig ~~ chol
creat ~~ BMI
creat ~~ chol
BMI ~~ chol

'

f3.1 <- lavaan(sem.1, data = all3, missing="ML", model.type='sem', group = 'group',
               int.ov.free = TRUE, int.lv.free = FALSE, auto.fix.first = TRUE, 
               auto.fix.single = TRUE, auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, 
               auto.cov.y = TRUE
               )

semPaths(f3.1, what='mod', whatLabels = 'par')
summary(f3.1)
fitMeasures(f3.1, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))

mod_ind <- modificationindices(f3.1)
head(mod_ind[order(mod_ind$mi, decreasing=TRUE), ], 10)
subset(mod_ind[order(mod_ind$mi, decreasing=TRUE), ], mi > 5)

measurementInvariance(sem.1, data = all3, missing="ML", group = 'group')


