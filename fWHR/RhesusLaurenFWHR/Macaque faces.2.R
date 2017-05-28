Pers=read.csv("all personality ratings.csv")

source('~/Dropbox/PhD/R/R stats steps/ICC/icc3.R', chdir = TRUE)

#Items 'depressed' is called 'socially withdrawn' in this study

#ICC of shortened questionnaire items including Davis and newly rated animals
#For other items can refer to table in my Davis manuscript showing Affectionate, Stable, Solitary, and Prrotective to be unreliable
num_observations <- as.data.frame(table(Pers$Animal))
av <- mean(num_observations$Freq)
names(num_observations)[1] <- "Animal"
x <- merge(Pers,num_observations,by="Animal")
items <- names(x[5:16])
items
icc3.reliability(x[x$Freq!=1,], items, "Animal", "Rater")

#Removing three unreliable items (stable, solitary, and protective)
Persdata=x[,c(1:13,14:24,25:44,45:58)]

attach(Persdata)
Persagg=aggregate(Persdata, by=list(Animal), FUN = mean, na.rm = TRUE)
detach(Persdata)

#Shortened component scores

attach(Persagg)
Persagg$Short.con=scale((-Fearful -
               Submissive -
               Cautious +24)/3)

Persagg$Short.opn=scale((Innovative +
               Curious)/2)

Persagg$Short.dom=scale((Bullying +
               Dominant)/2)

Persagg$Short.anx=scale((Quitting +
               Anxious +
               Erratic -
               Cool +8)/4)

Persagg$Confidence= scale(( -Fearful - Submissive - Timid - Cautious -Distractible -Disorganized - Dependent.Follower - Vulnerable + 64 )/8)

Persagg$Openness = scale(( Inquisitive +Thoughtless + Innovative + Inventive + Curious + Imitative +Impulsive)/7 )

Persagg$Dominance = scale((Bullying + Stingy.Greedy + Aggressive + Irritable + Manipulative + Defiant + Excitable 
                                 + Reckless + Dominant + Independent + Individualistic - Gentle +8)/12)

Persagg$Friendliness= scale ((Helpful + Friendly + Sociable + Sensitive + Sympathetic + Intelligent + Persistent 
                                    +Decisive - Socially.withdrawn +8)/9) 

Persagg$Activity = scale((Active + Playful -Conventional - Predictable - Lazy -Clumsy +32 )/6 )

Persagg$Anxiety = scale ((Quitting + Anxious + Erratic + Jealous  -Cool - Unemotional+16)/6)


geninfo=read.csv("All general info.csv")
geninfo$Q.Date=as.Date(ISOdate(geninfo$Date.Year, geninfo$Date.Month, geninfo$Date.Day))
geninfo$dob.Date=as.Date(ISOdate(geninfo$Dob.year, geninfo$Dob.month, geninfo$Dob.day))
geninfo$age= geninfo$Q.Date - geninfo$dob.Date

geninfo$agenum=geninfo$age
geninfo$agenum=as.numeric(geninfo$agenum)
#Having in days tends to cause a fit so divide by (usual) number of days in a year
geninfo$agenum=geninfo$agenum/365

geninfo$Age = s(geninfo$age) # DMA
geninfo$Age2 = s(geninfo$agenum^2)
geninfo$Age3 = s(geninfo$agenum^3)

setdiff(geninfo$Rhesus, Persagg$Group.1)

names(geninfo)

persage=merge(geninfo,Persagg, by.x="Rhesus", by.y="Group.1")


### DMA from this point fwd ###

library(alphahull)
library(tidyr)


### Face import and final merge
faces=read.csv("coded faces.csv",header=T)

faces = faces[!faces$C=='',]
faces = faces[!is.na(faces$C),]


## Double check to make sure the face measures are all fine

faces <- separate(data = faces, col = A, into = c("A.x", "A.y"), sep = "\\,")
faces <- separate(data = faces, col = B, into = c("B.x", "B.y"), sep = "\\,")
faces <- separate(data = faces, col = C, into = c("C.x", "C.y"), sep = "\\,")
faces <- separate(data = faces, col = D, into = c("D.x", "D.y"), sep = "\\,")
faces <- separate(data = faces, col = E, into = c("E.x", "E.y"), sep = "\\,")
faces <- separate(data = faces, col = F, into = c("F.x", "F.y"), sep = "\\,")
faces <- separate(data = faces, col = G, into = c("G.x", "G.y"), sep = "\\,")

faces[,c(2:15)] <- as.numeric(unlist(faces[,c(2:15)]))

rownames(faces) <- NULL



### fWHR

faces$fWHR = NA


for (i in seq_len(dim(faces)[1])){
  points <- matrix(c(c(faces$C.x[i], faces$D.x[i], faces$E.x[i], faces$F.x[i], faces$G.x[i]), 
                     c(faces$C.y[i], faces$D.y[i], faces$E.y[i], faces$F.y[i], faces$G.y[i]))
                   ,nrow = 5, ncol = 2)
  
  
  faces$fWHR[i] = fWHR(points, i)
  
}

faces$Rhesus[c(210, 209, 106, 81)] #81? 106 is key
table(faces$Rhesus)
# Temporary:
faces = faces[c(-210, -209, -106, -81),]

sum(levels(faces$Rhesus)!=0)



### LFFH

# a: top of the forehead
# b: bottom of the chin
# c,d: tops of the eyes, it doesn't matter which one is which
# i: index from for loop

LFFH <- function(a,b,c,d){   # these arguments are coordinates
  
  # colnames(faces)
  # i = 70
  # a = faces[i,2:3]
  # b = faces[i,4:5]
  # c = faces[i,6:7]
  # d = faces[i,8:9]
  
  # Finding the intersection point of two lines:
  k.1 <- ((c[2]-a[2])/(c[1]-a[1]))
  k.2 <- ((b[2]-d[2])/(b[1]-d[1]))  
  # Reshaping the two functions you get a final form for y:
  y <- (((-k.1/k.2)*d[2]+k.1*d[1]-k.1*c[1]+d[2])/(1-k.1/k.2))
  # Can now calculate the x-value:
  x <- ((y-d[2])+d[1]*k.2)/k.2
  
  # From LeFevre et al. 2012,
  # LF/FH = c-b/a-b
  
  LFFH = dist(mapply(c,c(x,y),b)) / dist(mapply(c,a,b))
    
  return(LFFH)
  
}


for (i in seq_len(dim(faces)[1])){
  faces$LFFH[i] = LFFH(c(faces$A.x[i],faces$A.y[i]),
                       c(faces$B.x[i],faces$B.y[i]),
                       c(faces$C.x[i],faces$C.y[i]),
                       c(faces$D.x[i],faces$D.y[i]))
  }



## Merging:

fWHR = merge(faces, persage, by.x="Rhesus", by.y="Rhesus", all =T)



# ### Scaling:  # ??? Seemingly not necessary... except maybe for Dominance.status
# 
# s <- function(x) {scale(x)}
# 
# #colnames(dfall)
# 
# dfall[,c(24,29,89:98)] = s(dfall[,c(24,29,89:98)])



