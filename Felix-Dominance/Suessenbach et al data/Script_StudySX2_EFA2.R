############
#R Script for Suessenbach et al. Study SX2 of supplementary material

#Packages needed for this R script
library(psych)


#Read in dataframe
data2 <- read.csv(file = "sample SUPP SX2.csv", header = T)
#names(data2)

#Variable containing index number for focal items: total

total <- c(1,3,4,5,7,8,10,11,13,14,15,17,
         18,20,21,22,24,25,27,28,29,30,31,
         33,34,36,37,38,40,41,43,44,46,47,48,50,51,52,
         54,56,57,58,60,61,62,64,65,66,67,69,71,74,76,
         82,84,86,88)

names(data2[total])



#Parallel analysis and MAP test
vss(data2[,total]) # Map suggests 5 factors. 

fa.parallel(data2[,total]) #PA suggests 5 components.



#############
#Factor analyses
#############

#Five factor solution
fa.5 = fa(data2[,total], nfactors=5, rotate="promax", fm="pa") 
print(fa.5$loadings, sort= TRUE, cutoff=.25)

#Four factor solution
fa.4 = fa(data2[,total], nfactors=4, rotate="promax", fm="pa") 
print(fa.4$loadings, sort= TRUE, cutoff=.25)

#Three factor solution
fa.3 = fa(data2[,total], nfactors=3, rotate="promax", fm="pa") 
print(fa.3$loadings, sort= TRUE, cutoff=.25)

#Two factor solution
fa.2 = fa(data2[,total], nfactors=2, rotate="promax", fm="pa") 
print(fa.2$loadings, sort= TRUE, cutoff=.25)

#One factor solution
fa.1 = fa(data2[,total], nfactors=1, rotate="promax", fm="pa") 
fa.1




#####
#Refined solution, excluding problematic items from three factor solution

#Indexes for excluded items
ex <- c(23,48,22,55,6,10,16,8,17,35,43,49,56,19)

#Item indexes without excluded items
total2 <- total[-ex]  
#names(data2[,total2])


#Refined three factor solution
fa.3r = fa(data2[,total2], nfactors=3, rotate="promax", fm="pa") 
print(fa.3r$loadings, sort= TRUE, cutoff=.25)





#####
#Factor analysis on selected items for preliminary 10-item DoPL scales

#Item indexes for preliminary DoPL scales
prelim <- c(13,14,21,25,31,  52,54,4,18,1, 
              2,7,11,15,26,27,33,42,53,12,
              3,5,20,28,29,38,39,44,45,51)

total3 <- total[prelim]
#names(data2[total3])


#Three factor solution
fa.3p = fa(data2[,total3], nfactors=3, rotate="promax", fm="pa") 
print(fa.3p$loadings, sort= TRUE, cutoff=.25)


#Post-hoc parallel analysis and MAP test
vss(data2[,total3]) # Map suggests 3 factors. 

fa.parallel(data2[,total3]) #PA suggests 3 components.








#####
#Factor analysis on selected items for final 10-item DoPL scales (on item selection of Study SX3)

#Item indexes for preliminary DoPL scales
final <- c(13,14,21,25,31,36,52,54,4,18, 
            2,7,11,15,26,27,33,42,53,12,
            3,5,20,28,29,38,39,44,45,51)

total4 <- total[final]
#names(data2[total4])


#Three factor solution
fa.3f = fa(data2[,total4], nfactors=3, rotate="promax", fm="pa") 
print(fa.3f$loadings, sort= TRUE, cutoff=.25)


#Post-hoc parallel analysis and MAP test
vss(data2[,total4]) # Map suggests 3 factors. 

fa.parallel(data2[,total4]) #PA suggests 3 components.



#Cronbach's alpha for final DoPL scales on basis of Study 2's data. 10-item, 6-item, 4-item:

#Indexes for long and short final DoPL scales
dom10 <- c(3,10,15,21,36,37,17,46,58,76)
dom6 <-  c(15,17,21,36,37,58)
dom4 <-  c(21,37,15,36)
pre10 <-  c(50,5,18,20,34,43,74,82,25,29)
pre6 <-  c(29,34,50,74,82,25)
pre4 <-  c(50,74,82,29)
lea10 <-  c(4,7,28,38,40,52,54,61,62,71)
lea6 <-  c(4,28,38,52,54,62)
lea4 <-  c(28,38,62,4)


#Dominance
alpha(data2[dom10])
alpha(data2[dom6])
alpha(data2[dom4])

#Prestige
alpha(data2[pre10])
alpha(data2[pre6])
alpha(data2[pre4])

#Leadership
alpha(data2[lea10])
alpha(data2[lea6])
alpha(data2[lea4])











