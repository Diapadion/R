library(psych)

cypcs <- read.csv(file = './GitHub/R/ETE young carers/CYPCS.csv', header=T)

dim(cypcs)

cypcs$happySum = cypcs$Q8 + (4 - cypcs$Q13)


for (i in 29:48){
  corobj = corr.test(as.data.frame(cypcs[,i]), as.data.frame(cypcs$happySum), method = 'spearman', adjust = 'BH')
  print(i)
  print(corobj$r)
  print(corobj$p)
}


# minus 28

# 29 -> 1 = a. shopping (-)
# 32 -> 4 = d. cooking (-)
# 37 -> 9 = i. help wash 
# 40 -> 12 = l. sit with, read to, talk to (-)
# 43 -> 15 = o. collecting medication (-)
# 44 -> 16 = p. reminding to take medication (-)

cypcs$jobTotal = rowSums(cypcs[,29:48])

print(
  corr.test(as.data.frame(cypcs$jobTotal), as.data.frame(cypcs$happySum), method = 'spearman', ci=T)
  , short=F)

