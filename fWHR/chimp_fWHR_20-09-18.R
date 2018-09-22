### Exploratory and confirmatory modeling of fWHR, personality, etc.

library(caret)
library(party)
library(rpart)
library(REEMtree)
library(lme4)


s <- function(x) {scale(x)}



### loading in composite sheet

chFP = read.csv('chimpFacesPersDemos.csv')
chFP = chFP[,-1]

# colnames(chFP)
# dim(chFP)
chFP = chFP[!is.na(chFP$fWHR),]
# dim(chFP)



### Descriptive Statistics

#levels(chFP$ID)
table(droplevels(chFP$ID[chFP$location=='Edinburgh'|chFP$location=='Edinburgh.VADW'])) # Number of Edi chimps and images/chimp
sum(table(droplevels(chFP$ID[chFP$location=='Bastrop']))) # Number of Bastrop chimps
table(droplevels(chFP$ID[chFP$location=='Japan'])) # NUmber of Japanese chimps and images/

table(chFP$Sex[!duplicated(chFP$ID)]) # Number of males and females

mean(chFP$Age[!duplicated(chFP$ID)], na.rm=TRUE) # Mean age
sd(chFP$Age[!duplicated(chFP$ID)], na.rm=TRUE) # SD age
min(chFP$Age[!duplicated(chFP$ID)], na.rm=TRUE) # Min age
max(chFP$Age[!duplicated(chFP$ID)], na.rm=TRUE) # Max age

# chFP$Age[chFP$location=='Edinburgh']
# !duplicated(chFP$ID)&chFP$location=='Edinburgh'
# chFP$ID[chFP$location=='Edinburgh']
## What is the below for?
#chFP$Age[!duplicated(chFP$ID[chFP$location=='Edinburgh'])] # WRONG
chFP$Age[!duplicated(chFP$ID)&chFP$location=='Edinburgh']
#chFP$Age[!duplicated(chFP$ID=='Liberius')] # WRONG
chFP$Age[!duplicated(chFP$ID=='Liberius')&chFP$location=='Edinburgh'] # this is just the first observation of Lib...

## Aggregate age across individuals then find the mean and SD for the group
Edi = chFP$location=='Edinburgh'|chFP$location=='Edinburgh.VADW'
aggEdi = aggregate(chFP[Edi,], by=list(chFP$ID[Edi]), FUN=mean)
mean(aggEdi$Age) # Mean age
sd(aggEdi$Age) # SD age

mean(table(chFP$ID)) # Mean number of useable images
sd(table(chFP$ID))   # SD of number of useable images

mean(table(droplevels(chFP$ID[chFP$location=='Edinburgh'|chFP$location=='Edinburgh.VADW'])))
sd(table(droplevels(chFP$ID[chFP$location=='Edinburgh'|chFP$location=='Edinburgh.VADW'])))

mean(table(droplevels(chFP$ID[chFP$location=='Japan'])))
sd(table(droplevels(chFP$ID[chFP$location=='Japan'])))


mean(aggregate(chFP$fWHR, by=list(chFP$ID), FUN=mean)[,'x'], na.rm=TRUE) # Mean fWHR
sd(aggregate(chFP$fWHR, by=list(chFP$ID), FUN=mean)[,'x'], na.rm=TRUE) # SD fWHR



chFP$fWHR[chFP$ID=='Lennon']
(chFP$fWHR[chFP$ID=='Lennon'][1] - mean(chFP$fWHR[!duplicated(chFP$ID)]) ) / sd(chFP$fWHR[!duplicated(chFP$ID)])


table(chFP$location[!duplicated(chFP$ID)])



### Zero-order correlation plots

#colnames(chFP)
corrplot(cor(chFP[,c(8,9,12,13,14,15,16,17,18,19),],use="pairwise.complete.obs")
         ,  method = 'number')

corrplot(cor(chFP[chFP$Sex==0,c(8,12,13,14,15,16,17,18,19),],use="pairwise.complete.obs"),  method = 'number')
corrplot(cor(chFP[chFP$Sex==1,c(8,12,13,14,15,16,17,18,19),],use="pairwise.complete.obs"),  method = 'number')



## Collapse subspecies random effects

#levels(chFP$Subspecies)
chFP$Subspecies[chFP$Subspecies=='hybrid'] = 'unknown'
table(chFP$Subspecies[!duplicated(chFP$ID)])

table(chFP$Sex[!duplicated(chFP$ID)&chFP$Subspecies=='verus'])
table(chFP$Sex[!duplicated(chFP$ID)&chFP$Subspecies=='schweinfurthii'])
table(chFP$Sex[!duplicated(chFP$ID)&chFP$Subspecies=='ellioti'])
table(chFP$Sex[!duplicated(chFP$ID)&chFP$Subspecies=='troglodytes'])
table(chFP$Sex[!duplicated(chFP$ID)&chFP$Subspecies=='unknown'])



# basic age,sex index:
adults = (chFP$Sex==0 & chFP$Age>7) | (chFP$Sex==1 & chFP$Age>9)
adults[is.na(adults)] = TRUE
adults = adults & (as.character(chFP$ID) != 'Gage') # 75
adults = adults & (as.character(chFP$ID) != 'Lennon') # This is a good place to pull out Lennon (130, 131)
count(adults)
#View(chFP[adults,])
chFP$ID[!adults]
chFP$Subspecies[!adults & !duplicated(chFP$ID)] # one of these is Lennon, who is verus



### Decision tress


set.seed(1234567890)
tree.p1 = REEMtree(fWHR ~ Sex + Age + I(Age^2) + I(Age^3) + 
                     Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ + 
                     Subspecies,
                   data=chFP[adults,],
                   #data=chFP[chFP$ID!='Lennon',],
                   #random=~1|ID/Subspecies
                   random = list(location =~ 1, ID =~ 1)#, Subspecies =~ 1)
                   ,cv=TRUE, method='ML'
                   
)
print(tree.p1)
plot(tree.p1)



gb.tree.A = lmer(fWHR ~ Agr_CZ +
                   (1 | location) +  (1 | ID),
                 data=chFP[adults,])
summary(gb.tree.A)
confint(gb.tree.A, method='profile')
## Small insignificant effect.


gb.tree.vs = lmer(fWHR ~ Dom_CZ * Neu_CZ +
                       + (1 | location) +  (1 | ID),
                     data=chFP[adults&(chFP$Subspecies=='verus'|chFP$Subspecies=='schweinfurthii'),]
)
summary(gb.tree.vs)
## Nothing till we add sex.

gb.tree.vs.sx = lmer(fWHR ~ Dom_CZ * Neu_CZ * Sex +
                          + (1 | location) +  (1 | ID),
                        data=chFP[adults&(chFP$Subspecies=='verus'|chFP$Subspecies=='schweinfurthii'),]
)
summary(gb.tree.vs.sx)


