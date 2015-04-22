
# segment for entering and sorting the 6 factor weighting matrix

wmat <- rbind(cbind("FEARFUL",-.86,0,0,0,0,0),cbind("SUBMISSIVE",-.81,0,0,0,0,0),cbind("TIMID",-.73,0,0,0,0,0),cbind("CAUTIOUS",-.73,0,0,0,0,0),cbind("STABLE",.66,0,0,0,0,-.43),cbind("DISTRACTIBLE",-.56,0,-.41,0,0,0),cbind("DISORGANIZED",-.55,0,.41,0,0,0),cbind("DEPENDENT/FOLLOWER",-.54,0,0,0,0,0),cbind("VULNERABLE",-.5,.43,0,0,0,0),cbind("INQUISITIVE",0,.85,0,0,0,0),cbind("THOUGHTLESS",0,.81,0,0,0,0),cbind("INNOVATIVE",0,.66,0,0,.5,0),cbind("INVENTIVE",0,.64,0,0,.49,0),cbind("CURIOUS",0,.64,0,.42,0,0),cbind("IMITATIVE",0,.58,0,0,0,0),cbind("IMPULSIVE",0,.55,0,0,0,.43),cbind("BULLYING",0,0,.87,0,0,0),cbind("STINGY/GREEDY",0,0,.84,0,0,0),cbind("AGRESSIVE",0,0,.83,0,0,0),cbind("IRRITABLE",0,0,.78,0,0,0),cbind("MANIPULATIVE",0,0,.75,0,0,0),cbind("DEFIANT",0,0,.69,0,0,0),cbind("EXCITABLE",0,0,.67,0,0,0),cbind("RECKLESS",0,0,.61,0,0,0),cbind("GENTLE",0,0,-.6,.4,0,0),cbind("DOMINANT",.55,0,.57,0,0,0),cbind("INDEPENDENT",0,0,.51,0,0,0),cbind("INDIVIDUALISTIC",0,0,.41,0,0,0),cbind("HELPFUL",0,0,0,.81,0,0),cbind("FRIENDLY",0,0,0,.73,0,0),cbind("AFFECTIONATE",0,0,0,.73,0,0),cbind("SOCIABLE",0,0,0,.7,0,0),cbind("SENSITIVE",0,0,0,.67,0,0),cbind("DEPRESSED",-.48,0,0,-.64,0,0),cbind("PROTECTIVE",0,0,0,.63,0,0),cbind("SOLITARY",-.42,0,0,-.58,0,0),cbind("SYMPATHETIC",0,.45,-.42,.55,0,0),cbind("INTELLIGENT",0,0,0,.5,0,0),cbind("PERSISTENT",.4,0,0,.5,0,0),cbind("DECISIVE",0,0,.41,.44,0,0),cbind("CONVENTIONAL",0,0,0,0,-.75,0),cbind("PREDICTABLE",0,0,0,0,-.72,0),cbind("LAZY",0,0,0,0,-.71,0),cbind("ACTIVE",0,0,0,0,.69,0),cbind("CLUMSY",0,0,0,0,-.52,0),cbind("PLAYFUL",0,.42,0,.42,.48,0),cbind("COOL",.4,0,0,0,0,-.76),cbind("QUITTING",0,0,0,0,0,.66),cbind("ANXIOUS",-.48,0,0,0,0,.63),cbind("ERRATIC",0,.4,0,0,0,.59),cbind("UNEMOTIONAL",0,0,0,0,0,-.45),cbind("JEALOUS",0,0,0,0,0,.44))

wmat <- wmat[order(wmat[,1],decreasing=FALSE),]
wm <- apply(wmat[,2:7],1,as.numeric)

fullset = apply(pers,c(1,3),mean)

# autistic and unpredictable should both be removed from the data set
fullset = fullset[,c(-5,-53)]

# combine matrices to find components

scores1 <- wm %o% fullset
scores2 <- fullset %o% wm

scores=array(0,c(9,6))

for (i in 1:52){
	for (j in 1:6){
		scores[1:9,j] <- scores[1:9,j]+wm[j,i]*fullset[,i]
	}		
}



### 2015 revision on this approach

# let's get the mean scores across raters
mtrim = data.frame(apply(trimp,c(1,3),mean))

colnames(mtrim) <- srt
rownames(mtrim) <- c('Augustus','Benedict','Coltrane','Ebbinghaus','Horatio',
                     'Lashley','MacDuff','Oberon','Prospero')

mtrim = t(mtrim)
