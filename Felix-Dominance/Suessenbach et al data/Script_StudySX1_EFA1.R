############
#R Script for Suessenbach et al. Study SX1 of supplementary material

#Packages needed for this R script
library(psych)


#Read in dataframe
data1 <- read.csv(file = "sample SUPP SX1.csv", header = T)
names(data1)

#Variable containing index number for focal items: total
#Power/dominance-items:
p1 <- c(9,10,14,24,28,34,36,46,39,1,18,21,23,29,30)
#names(data1[p1])

#Status/Prestige-items:
s1 <- c(3,4,6,8,19,22,26,32,42,44,48,49,51)
#names(data1[s1])

total <- c(p1,s1)


#Parallel analysis and MAP test
vss(data1[,total]) # Map suggests 4 factors. 

fa.parallel(data1[,total]) #PA suggests 4 components.




#############
#Factor analyses
#############

#Four factor solution
fa.4 = fa(data1[,total], nfactors=4, rotate="promax", fm="pa") 
print(fa.4$loadings, sort= TRUE, cutoff=.25)

#Three factor solution
fa.3 = fa(data1[,total], nfactors=3, rotate="promax", fm="pa") 
print(fa.3$loadings, sort= TRUE, cutoff=.25)

#Two factor solution
fa.2 = fa(data1[,total], nfactors=2, rotate="promax", fm="pa") 
print(fa.2$loadings, sort= TRUE, cutoff=.25)

#One factor solution
fa.1 = fa(data1[,total], nfactors=1, rotate="promax", fm="pa") 
fa.1

#####
#Refined solution, excluding problematic items from three factor solution

#Item-indexes for excluded items
ex <- c(26,28,36,39,22,3,8,46,30)

#Item indexes without excluded items
total2 <- total[-which(total %in% ex)]  
#names(data1[,total2])

#Refined three factor solution
fa.3r = fa(data1[,total2], nfactors=3, rotate="promax", fm="pa") 
print(fa.3r$loadings, sort= TRUE, cutoff=.25)








