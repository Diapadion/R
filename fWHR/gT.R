
# model <- lmer(Score ~ 1 + (1|Rater) + (1|Chimp) + (1|Item) + 
#                 (1|Chimp:Rater) + (1|Chimp:Item) + (1|Item:Rater), data=melted)
# 
# counts <- list(length(levels(melted$Rater)),length(levels(melted$Item)))
# names(counts) <- c("Rater","Item")
# #model <- lmer(Score ~ (1|Chimp) + (1|Rater) + (1|Item) + (1|Chimp:Rater) + (1|Chimp:Item) + (1|Item:Rater), melted)
# vcomp <- VarCorr(model)
# 
# vcompLbls <- c("Rater","Chimp","Item","Chimp:Rater","Chimp:Item","Item:Rater")
# 
# varCompTable(vcomp, vcompLbls)
# 
# 
# 
# phi <- calcPhiCoefficient("Chimp",vcomp,vcompLbls,counts)
# cat("Φ =", substr(sprintf("%.3f",round(phi,3)),2,5))


library(lme4)
library(data.table)



df_irr_cut = as.data.table(df_irr_cut)

df_irr_melt = melt(df_irr_cut)

colnames(df_irr_melt) <- c('Chimp','Location','Rater','Dimension','Score')

table(df_irr_melt$Location)


model <- lmer(Score ~ 1 + (1|Rater) + (1|Chimp) + (1|Dimension) + (1|Location) +
                (1|Chimp:Rater) + (1|Chimp:Dimension) + (1|Chimp:Location) + 
                (1|Rater:Dimension) + (1|Dimension:Location) + (1|Rater:Location) + 
                (1|Rater:Location:Dimension) + 
                (1|Location:Chimp:Dimension) #+ (1|Rater:Chimp:Dimension)
              , data=df_irr_melt, REML=FALSE
              )

list(model = model)

length(getME(m1,"theta"))
length(fixef(m1))


dat$Chimp <- factor(dat$Chimp)
dat$Rater <- factor(dat$Rater)
dat$Item <- factor(dat$Item)
dat$Time <- factor(dat$Time)

counts <- list(length(levels(df_irr_melt$Rater)),length(levels(df_irr_melt$Dimension)), length(levels(df_irr_melt$Location)))
names(counts) <- c("Rater","Dimension","Location")


vcomp <- VarCorr(model)
vcompLbls <- c("Rater","Chimp","Dimension",'Location',
               "Chimp:Rater","Chimp:Dimension",'Chimp:Location',
               "Rater:Dimension",'Dimension:Location','Rater:Location',
               'Rater:Location:Dimension','Location:Chimp:Dimension')







varCompTable <- function(vcomp,vcompLbls) {
  compOut <- c()
  lbl <- c()
  for(i in 1:length(vcomp)){
    compOut[i] <- vcomp[[vcompLbls[i]]][,1]
    lbl[i] <- vcompLbls[i]
  }
  compOut[length(vcomp)+1] <- attr(vcomp, "sc")[[1]]^2
  lbl[length(vcomp)+1] <- "Residual"
  
  compTbl <- data.frame(round(compOut,3),round(compOut/sum(compOut),3)*100)
  #rownames(compTbl) <- lbl
  rownames(compTbl) <- gsub(":","*",lbl)
  colnames(compTbl) <- c("VarComp","%")
  
  compTblTemp <- compTbl[1:(nrow(compTbl)-1),]
  compTblTemp <- compTblTemp[order(compTblTemp[,1],decreasing=T),]
  compTblOrderd <- rbind(compTblTemp,compTbl[nrow(compTbl),])
  cat("Variance components\n\n")
  print(compTbl)
  cat("\nVariance components (Sorted)\n\n")
  print(compTblOrderd)
}


varCompTable(vcomp, vcompLbls)




### G ###

calcGCoefficient <- function(uniVal,vcomp,vcompLbls,ids,counts) {
#             calcGCoefficient("Chimp",vcomp,vcompLbls,grep(":Chimp\\b|\\bChimp:",vcompLbls),counts)
  denoms <- c()
  denomsVal <- c()
  denoms[1] <- "as.numeric(vcomp[[uniVal]])"
  denomsVal[1] <- as.numeric(vcomp[[uniVal]])
  
#  ids = grep(":Chimp\\b|\\bChimp:",vcompLbls)
  
  if (length(ids) > 0) {
    for(i in 1:length(ids)) {
      denomItem <- gsub(paste(":",uniVal,"|",uniVal,":",sep=""),"",vcompLbls[ids[i]])
      if (length(grep(":",denomItem)) > 0){
        items <- strsplit(denomItem,":")
        countNums <- c()
        for (j in 1:length(items[[1]])) {
          countNums[j] <- counts[[items[[1]][j]]]
        }
        denoms[i+1] <- paste('(as.numeric(vcomp[[vcompLbls[ids[',i,']]]]) / ',prod(countNums),')',sep="")
        denomsVal[i+1] <- as.numeric(vcomp[[vcompLbls[ids[i]]]]) / prod(countNums)
      } else {
        denoms[i+1] <- paste('(as.numeric(vcomp[[vcompLbls[ids[',i,']]]]) / counts[[gsub(paste(":",uniVal,"|",uniVal,":",sep=""),"",vcompLbls[ids[',i,']])]])',sep="")
        ### this denominator below is where the problem is
        denomsVal[i+1] <- as.numeric(vcomp[[vcompLbls[ids[i]]]]) / counts[[gsub(paste(":",uniVal,"|",uniVal,":",sep=""),"",vcompLbls[ids[i]])]]
      }
    }
  }
  
  countNums <- c()
  for (i in 1:length(counts)) {
    countNums[i] <- counts[[i]]
  }
  denoms[length(denoms) + 1] <- '(attr(vcomp, "sc")[[1]]^2 / prod(countNums))'
  denomsVal[length(denomsVal) + 1] <- attr(vcomp, "sc")[[1]]^2 / prod(countNums)
  return(eval(parse(text=paste(denoms[1],"/ (",paste(denoms,collapse=" + "),")"))))
}

#  counts[[gsub(paste(":",uniVal,"|",uniVal,":",sep=""),"",vcompLbls[ids[i]])]]

gcoeff <- calcGCoefficient("Chimp",vcomp,vcompLbls,grep(":Chimp\\b|\\bChimp:",vcompLbls),counts)

cat("G =", substr(sprintf("%.3f", round(gcoeff, 3)), 2, 5))




counts <- list(length(levels(df_irr_melt$Rater)),length(levels(df_irr_melt$Dimension)), 
               length(levels(df_irr_melt$Location)),length(levels(df_irr_melt$Chimp)))
names(counts) <- c("Rater","Dimension","Location","Chimp")


calcPhiCoefficient <- function(uniVal,vcomp,vcompLbls,counts) {
  
#  uniVal = 'Chimp'
  
  denoms <- c()
  denomsVal <- c()
  denoms[1] <- "as.numeric(vcomp[[uniVal]])"
  denomsVal[1] <- as.numeric(vcomp[[uniVal]])
  if (length(vcompLbls) > 2) {
    for(i in 2:length(vcompLbls)) {
      denomItem <- gsub(paste(":",uniVal,"|",uniVal,":",sep=""),"",vcompLbls[i])
      if (length(grep(":",denomItem)) > 0){
        items <- strsplit(denomItem,":")
        countNums <- c()
        for (j in 1:length(items[[1]])) {
          countNums[j] <- counts[[items[[1]][j]]]
        }
        denoms[i] <- paste('(as.numeric(vcomp[[vcompLbls[',i,']]]) / ',prod(countNums),')',sep="")
        denomsVal[i] <- as.numeric(vcomp[[vcompLbls[i]]]) / prod(countNums)
      } else {
        denoms[i] <- paste('(as.numeric(vcomp[[vcompLbls[',i,']]]) / counts[[gsub(paste(":",uniVal,"|",uniVal,":",sep=""),"",vcompLbls[',i,'])]])',sep="")
        # this denominator below is the problem
        denomsVal[i] <- as.numeric(vcomp[[vcompLbls[i]]]) / counts[[gsub(paste(":",uniVal,"|",uniVal,":",sep=""),"",vcompLbls[i])]]
      }
    }
  } else {
    denoms[2] <- paste('(as.numeric(vcomp[[vcompLbls[2]]]) / ',prod(counts[[1]]),')',sep="")
    denomsVal[2] <- as.numeric(vcomp[[vcompLbls[2]]]) / prod(counts[[1]])
  }
  # break
  
  countNums <- c()
  for (i in 1:length(counts)) {
    countNums[i] <- counts[[i]]
  }
  denoms[length(denoms) + 1] <- '(attr(vcomp, "sc")[[1]]^2 / prod(countNums))'
  denomsVal[length(denomsVal) + 1] <- attr(vcomp, "sc")[[1]]^2 / prod(countNums)
  return(eval(parse(text=paste(denoms[1],"/ (",paste(denoms,collapse=" + "),")"))))
}

phi <- calcPhiCoefficient("Chimp",vcomp,vcompLbls,counts)
cat("Φ =", substr(sprintf("%.3f",round(phi,3)),2,5))

#counts[[gsub(paste(":",uniVal,"|",uniVal,":",sep=""),"",vcompLbls[i])]]



### Individual dimension Gs ###


mduse = df_irr_melt[df_irr_melt$Dimension=='Dominance',]
mg.D <- lmer(Score ~ 1 + (1|Rater) + (1|Chimp) + (1|Location) + 
              #(1|Chimp:Rater) + 
               (1|Chimp:Location) + (1|Location:Rater), 
             data=mduse, REML=FALSE,
             lmerControl(optimizer='nloptwrap',optCtrl=list(maxfun=2e5))
)

counts <- list(length(levels(mduse$Rater)),length(levels(mduse$Location)))
names(counts) <- c("Rater","Location")
vcomp <- VarCorr(mg.D)
vcompLbls <- c("Rater","Chimp","Location",#"Chimp:Rater",
               "Chimp:Location","Location:Rater")

varCompTable(vcomp, vcompLbls)

gcoeff <- calcGCoefficient("Chimp",vcomp,vcompLbls,grep(":Chimp\\b|\\bChimp:",vcompLbls),counts)
cat("G =", substr(sprintf("%.3f", round(gcoeff, 3)), 2, 5))



mduse = df_irr_melt[df_irr_melt$Dimension=='Conscientiousness',]
mg.C <- lmer(Score ~ 1 + (1|Rater) + (1|Chimp) + (1|Location) + 
               #(1|Chimp:Rater) + 
               (1|Chimp:Location) + (1|Location:Rater), 
             data=mduse, REML=FALSE,
             lmerControl(optimizer='nloptwrap',optCtrl=list(maxfun=2e5))
)

counts <- list(length(levels(mduse$Rater)),length(levels(mduse$Location)))
names(counts) <- c("Rater","Location")
vcomp <- VarCorr(mg.C)
vcompLbls <- c("Rater","Chimp","Location",#"Chimp:Rater",
               "Chimp:Location","Location:Rater")

varCompTable(vcomp, vcompLbls)

gcoeff <- calcGCoefficient("Chimp",vcomp,vcompLbls,grep(":Chimp\\b|\\bChimp:",vcompLbls),counts)
cat("G =", substr(sprintf("%.3f", round(gcoeff, 3)), 2, 5))



mduse = df_irr_melt[df_irr_melt$Dimension=='Extraversion',]
mg.E <- lmer(Score ~ 1 + (1|Rater) + (1|Chimp) + (1|Location) + 
               #(1|Chimp:Rater) + 
               (1|Chimp:Location) + (1|Location:Rater), 
             data=mduse, REML=FALSE,
             lmerControl(optimizer='nloptwrap',optCtrl=list(maxfun=2e5))
)

counts <- list(length(levels(mduse$Rater)),length(levels(mduse$Location)))
names(counts) <- c("Rater","Location")
vcomp <- VarCorr(mg.E)
vcompLbls <- c("Rater","Chimp","Location",#"Chimp:Rater",
               "Chimp:Location","Location:Rater")

varCompTable(vcomp, vcompLbls)

gcoeff <- calcGCoefficient("Chimp",vcomp,vcompLbls,grep(":Chimp\\b|\\bChimp:",vcompLbls),counts)
cat("G =", substr(sprintf("%.3f", round(gcoeff, 3)), 2, 5))



mduse = df_irr_melt[df_irr_melt$Dimension=='Neuroticism',]
mg.N <- lmer(Score ~ 1 + (1|Rater) + (1|Chimp) + (1|Location) + 
               #(1|Chimp:Rater) + 
               (1|Chimp:Location) + (1|Location:Rater), 
             data=mduse, REML=FALSE,
             lmerControl(optimizer='nloptwrap',optCtrl=list(maxfun=2e5))
             )

counts <- list(length(levels(mduse$Rater)),length(levels(mduse$Location)))
names(counts) <- c("Rater","Location")
vcomp <- VarCorr(mg.N)
vcompLbls <- c("Rater","Chimp","Location",#"Chimp:Rater",
               "Chimp:Location","Location:Rater")

varCompTable(vcomp, vcompLbls)

gcoeff <- calcGCoefficient("Chimp",vcomp,vcompLbls,grep(":Chimp\\b|\\bChimp:",vcompLbls),counts)
cat("G =", substr(sprintf("%.3f", round(gcoeff, 3)), 2, 5))



mduse = df_irr_melt[df_irr_melt$Dimension=='Agreeableness',]
mg.A <- lmer(Score ~ 1 + (1|Rater) + (1|Chimp) + (1|Location) + 
               #(1|Chimp:Rater) + 
               (1|Chimp:Location) + (1|Location:Rater), 
             data=mduse, REML=FALSE,
             lmerControl(optimizer='nloptwrap',optCtrl=list(maxfun=2e5))
)

counts <- list(length(levels(mduse$Rater)),length(levels(mduse$Location)))
names(counts) <- c("Rater","Location")
vcomp <- VarCorr(mg.A)
vcompLbls <- c("Rater","Chimp","Location",#"Chimp:Rater",
               "Chimp:Location","Location:Rater")

varCompTable(vcomp, vcompLbls)

gcoeff <- calcGCoefficient("Chimp",vcomp,vcompLbls,grep(":Chimp\\b|\\bChimp:",vcompLbls),counts)
cat("G =", substr(sprintf("%.3f", round(gcoeff, 3)), 2, 5))



mduse = df_irr_melt[df_irr_melt$Dimension=='Openness',]
mg.O <- lmer(Score ~ 1 + (1|Rater) + (1|Chimp) + (1|Location) + 
               #(1|Chimp:Rater) + 
               (1|Chimp:Location) + (1|Location:Rater), 
             data=mduse, REML=FALSE,
             lmerControl(optimizer='nloptwrap',optCtrl=list(maxfun=2e5))
)

counts <- list(length(levels(mduse$Rater)),length(levels(mduse$Location)))
names(counts) <- c("Rater","Location")
vcomp <- VarCorr(mg.O)
vcompLbls <- c("Rater","Chimp","Location",#"Chimp:Rater",
               "Chimp:Location","Location:Rater")

varCompTable(vcomp, vcompLbls)

gcoeff <- calcGCoefficient("Chimp",vcomp,vcompLbls,grep(":Chimp\\b|\\bChimp:",vcompLbls),counts)
cat("G =", substr(sprintf("%.3f", round(gcoeff, 3)), 2, 5))

