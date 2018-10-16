### Sample descriptive statistics

library(psych)



describe(chFP)




#levels(chFP$ID)
## Number of chimps and images/chimp
table(droplevels(chFP$ID[chFP$location=='Edinburgh'|chFP$location=='Edinburgh.VADW'])) 
table(droplevels(chFP$ID[chFP$location=='Japan']))  # Number of Japanese chimps and images
table(droplevels(chFP$ID[chFP$location=='Bastrop']))  # Bastrop has one image per chimp

## Number of chimps by subsample
length(levels(droplevels(chFP$ID[chFP$location=='Edinburgh'|chFP$location=='Edinburgh.VADW'])))
length(levels(droplevels(chFP$ID[chFP$location=='Japan'])))
length(levels(droplevels(chFP$ID[chFP$location=='Bastrop']))) 

## Sex of individuals across and within sample
table(chFP$Sex[!duplicated(chFP$ID)]) # Number of males and females
table(chFP$Sex[!duplicated(chFP$ID)&(chFP$location=='Edinburgh'|chFP$location=='Edinburgh.VADW')])
table(chFP$Sex[!duplicated(chFP$ID)&(chFP$location=='Japan')])
table(chFP$Sex[!duplicated(chFP$ID)&(chFP$location=='Bastrop')])

## Subspecies of individuals across and within sample
table(chFP$Subspecies[!duplicated(chFP$ID)]) # Number of males and females
table(chFP$Subspecies[!duplicated(chFP$ID)&(chFP$location=='Edinburgh'|chFP$location=='Edinburgh.VADW')])
table(chFP$Subspecies[!duplicated(chFP$ID)&(chFP$location=='Japan')])
table(chFP$Subspecies[!duplicated(chFP$ID)&(chFP$location=='Bastrop')])



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




### Where are the non-adults 
## BEWARE OF LENNON

## Who
table(droplevels(chFP$ID[!adults]))
## What (subspecies)
table(chFP$Subspecies[!adults], droplevels(chFP$ID[!adults]))
## Where
table(chFP$location[!adults], droplevels(chFP$ID[!adults]))



table(chFP$Subspecies[!duplicated(chFP$ID[!adults])]) 


