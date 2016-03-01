### generalizeability theory 
### to see what's what with our ratings



swbwel=read.csv("Chimp welfare ratings.scrubbed.5.csv")




library(lme4)


# WHY HAS PHI STOPPED WORKING

## I think because of all the missing data for Time
## ^ seems not
##
## Maybe because Time only has two values?



  ################################################
  # Getting started
  ################################################
  

  # need to make this long, by Items

library(reshape2)

melted <- melt(swbwel[,c(1,2,10:22,26:29)], id.vars=c('Chimp','Rater','Time'))

melted.a <- melt(swbwel[,c(1,2,11:22,26:29)], id.vars=c('Chimp','Rater'))


colnames(melted) <- c('Chimp','Rater','Time','Item','Score')
colnames(melted.a)<- c('Chimp','Rater','Item','Score')
  

    # in case of "p x r x i"
  
      melted$Chimp <- factor(melted$Chimp)
      melted$Rater <- factor(melted$Rater)
      melted$Item <- factor(melted$Item)
      melted$Time <- factor(melted$Time)
      
      
      model.a <- lmer(Score ~ 1 + (1|Rater) + (1|Chimp) + (1|Item) + 
                      (1|Chimp:Rater) + (1|Chimp:Item) + (1|Item:Rater), data=melted.a)
      
      
    # in case of p x r x i x t
      
      # warning: takes forever
      model <- lmer(Score ~ 1 + (1|Rater) + (1|Chimp) + (1|Item) + (1|Time) +
                      (1|Chimp:Rater) + (1|Chimp:Item) + (1|Chimp:Time) + 
                      (1|Rater:Item) + (1|Rater:Time) + (1|Item:Time) +
                      (1|Rater:Time:Chimp) + (1|Rater:Time:Item) + 
                      (1|Time:Chimp:Item) + (1|Rater:Chimp:Item)
                    , data=melted)
      
    
    list(model = model) # To be used later
    

    
  ################################################
  # Variance components (Sorted)
  ################################################
  


   #   model <- lmer(Score ~ (1|Chimp) + (1|Rater) + (1|Item) + (1|Chimp:Rater) + (1|Chimp:Item) + (1|Item:Rater), melted)
      
      # 3 facets
      counts <- list(length(levels(melted.a$Rater)),length(levels(melted.a$Item)))
      names(counts) <- c("Rater","Item")
    
      vcomp <- VarCorr(model.a)
      vcompLbls <- c("Rater","Chimp","Item","Chimp:Rater","Chimp:Item","Item:Rater")
      
      # 4 facets      
      counts <- list(length(levels(melted$Rater)),length(levels(melted$Item)))
      names(counts) <- c("Rater","Item")
      
      vcomp <- VarCorr(model)
      vcompLbls <- c("Rater","Chimp","Item",'Time',
                     "Chimp:Rater","Chimp:Item",'Chimp:Time',
                     "Rater:Item",'Rater:Time','Item:Time',
                     'Rater:Time:Chimp','Rater:Time:Item',
                     'Time:Chimp:Item','Rater:Chimp:Item')
      
    
    
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
    

  
  
  
  ################################################
  # G-coefficient
  ################################################
  
   # in case of "pri"

      

    calcGCoefficient <- function(uniVal,vcomp,vcompLbls,ids,counts) {
      denoms <- c()
      denomsVal <- c()
      denoms[1] <- "as.numeric(vcomp[[uniVal]])"
      denomsVal[1] <- as.numeric(vcomp[[uniVal]])
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
    
    gcoeff <- calcGCoefficient("Chimp",vcomp,vcompLbls,grep(":Chimp\\b|\\bChimp:",vcompLbls),counts)
    
    cat("G =", substr(sprintf("%.3f", round(gcoeff, 3)), 2, 5))
    
  
  
  
  
  
  ################################################
  # Phi
  ################################################
  

    
    calcPhiCoefficient <- function(uniVal,vcomp,vcompLbls,counts) {
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
              ### this denominator below is where the problem is
            denomsVal[i] <- as.numeric(vcomp[[vcompLbls[i]]]) / counts[[gsub(paste(":",uniVal,"|",uniVal,":",sep=""),"",vcompLbls[i])]]
          }
        }
      } else {
        denoms[2] <- paste('(as.numeric(vcomp[[vcompLbls[2]]]) / ',prod(counts[[1]]),')',sep="")
        denomsVal[2] <- as.numeric(vcomp[[vcompLbls[2]]]) / prod(counts[[1]])
      }
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
    

  
    counts[[gsub(paste(":",uniVal,"|",uniVal,":",sep=""),"",vcompLbls[i])]]
  
  
  ################################################
  # D study
  ################################################
  
    
   # in case of "pri"
      
    
    length(unique(melted$Rater))
    
      n.raters <- length(unique(melted$Rater))
      n.items <- length(unique(melted$Item))
      
      ival <- 1:n.raters
      ival <- as.numeric(ival)
      jval <- 1:n.items
      jval <- as.numeric(jval)
      
      if(length(counts) > 1) {
        plotValsG <- matrix(nrow=length(ival),ncol=length(jval))
        for(i in 1:length(ival)) {
          for(j in 1:length(jval)) {
            counts[[1]] <- ival[i]
            counts[[2]] <- jval[j]
            plotValsG[i,j] <- calcGCoefficient("Chimp",vcomp,vcompLbls,grep(":Chimp\\b|\\bChimp:",vcompLbls),counts)
          }
        }
        
        cat("G-coefficients (row: Rater, column: Item)\n\n")
        gvals <- data.frame(substr(matrix(sprintf("%.3f",round(plotValsG,3)),ncol=ncol(plotValsG)),2,5))
        colnames(gvals) <- jval
        rownames(gvals) <- paste("Rater","=",ival)
        print(gvals)
        
      }
      

    

  
  
  
  
  ################################################
  # plot
  ################################################
  
  
      model <- mod()$model
      
      vcomp <- VarCorr(model)
      
      counts <- list(length(levels(melted$Rater)),length(levels(melted$Item)))
      names(counts) <- c("Rater","Item")
      
      vcompLbls <- c("Chimp","Rater","Item","Chimp:Rater","Chimp:Item","Item:Rater")
      
      varCompTable(vcomp, vcompLbls)
    
    
    
    
    
 
      
      plotValsG <- matrix(nrow=length(ival),ncol=length(jval))
      for(i in 1:length(ival)) {
        for(j in 1:length(jval)) {
          counts[[1]] <- ival[i]
          counts[[2]] <- jval[j]
          plotValsG[i,j] <- calcGCoefficient("Chimp",vcomp,vcompLbls,grep(":Chimp\\b|\\bChimp:",vcompLbls),counts)
        }
      }
      
      cat("G-coefficients (row: Rater, column: Item)\n\n")
      gvals <- data.frame(substr(matrix(sprintf("%.3f",round(plotValsG,3)),ncol=ncol(plotValsG)),2,5))
      colnames(gvals) <- jval
      rownames(gvals) <- paste("Rater","=",ival)
      
      lbls <- c()
      for (i in 1:n.raters) {
        lbls[i] <- paste("Rater =",i)
      }
      
      plot(c(0,0),xlim=c(min(jval),max(jval)),ylim=c(0, 1),type="n",xlab="Items",ylab="G-coefficients")
      axis(side=2, at=c(0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1))
      axis(side=1, at=jval)
      legend("topleft", cex=0.7, legend = lbls, lty = c(1:n.raters), pch = c(1:n.raters), col = c(1:n.raters))
      for(i in 1:nrow(plotValsG)) {
        points(plotValsG[i,], pch=i, col=i);lines(plotValsG[i,], col=i, lty=i)
      }
      

    

  

  
#### my additions
      
      randos <- ranef(model)
      
      randos$Item
  
      
## for the items, individually
      
      m.1 <- lmer(Score ~ 1 + (1|Rater) + (1|Chimp) + (1|Time) + 
                      (1|Chimp:Rater) + (1|Chimp:Time) + (1|Time:Rater), data=melted[melted$Item=='Q1',])
      counts <- list(length(levels(melted$Rater)),length(levels(melted$Time)))
      names(counts) <- c("Rater","Time")
      vcomp <- VarCorr(m.1)
      vcompLbls <- c("Rater","Chimp","Time","Chimp:Rater","Chimp:Time","Time:Rater")

      varCompTable(vcomp, vcompLbls)
      
      gcoeff <- calcGCoefficient("Chimp",vcomp,vcompLbls,grep(":Chimp\\b|\\bChimp:",vcompLbls),counts)
      cat("G =", substr(sprintf("%.3f", round(gcoeff, 3)), 2, 5))
      
      phi <- calcPhiCoefficient("Chimp",vcomp,vcompLbls,counts)
      cat("Φ =", substr(sprintf("%.3f",round(phi,3)),2,5))
      
      mduse = melted[melted$Item=='Q2',]
      m.2 <- lmer(Score ~ 1 + (1|Rater) + (1|Chimp) + (1|Time) + 
                    (1|Chimp:Rater) + (1|Chimp:Time) + (1|Time:Rater), data=mduse)
      counts <- list(length(levels(mduse$Rater)),length(levels(mduse$Time)))
      names(counts) <- c("Rater","Time")
      vcomp <- VarCorr(m.2)
      vcompLbls <- c("Rater","Chimp","Time","Chimp:Rater","Chimp:Time","Time:Rater")
      
      varCompTable(vcomp, vcompLbls)
      
      gcoeff <- calcGCoefficient("Chimp",vcomp,vcompLbls,grep(":Chimp\\b|\\bChimp:",vcompLbls),counts)
      cat("G =", substr(sprintf("%.3f", round(gcoeff, 3)), 2, 5))
      
      phi <- calcPhiCoefficient("Chimp",vcomp,vcompLbls,counts)
      cat("Φ =", substr(sprintf("%.3f",round(phi,3)),2,5))
  
      
      mduse = melted[melted$Item=='Q3',]
      m.3 <- lmer(Score ~ 1 + (1|Rater) + (1|Chimp) + (1|Time) + 
                    (1|Chimp:Rater) + (1|Chimp:Time) + (1|Time:Rater), data=mduse)
      counts <- list(length(levels(mduse$Rater)),length(levels(mduse$Time)))
      names(counts) <- c("Rater","Time")
      vcomp <- VarCorr(m.3)
      vcompLbls <- c("Rater","Chimp","Time","Chimp:Rater","Chimp:Time","Time:Rater")
      
      varCompTable(vcomp, vcompLbls)
      
      gcoeff <- calcGCoefficient("Chimp",vcomp,vcompLbls,grep(":Chimp\\b|\\bChimp:",vcompLbls),counts)
      cat("G =", substr(sprintf("%.3f", round(gcoeff, 3)), 2, 5))
      
      phi <- calcPhiCoefficient("Chimp",vcomp,vcompLbls,counts)
      cat("Φ =", substr(sprintf("%.3f",round(phi,3)),2,5))
      
      
      mduse = melted[melted$Item=='Q4.1',]
      m.4.1 <- lmer(Score ~ 1 + (1|Rater) + (1|Chimp) + (1|Time) + 
                    (1|Chimp:Rater) + (1|Chimp:Time) + (1|Time:Rater), data=mduse)
      counts <- list(length(levels(mduse$Rater)),length(levels(mduse$Time)))
      names(counts) <- c("Rater","Time")
      vcomp <- VarCorr(m.4.1)
      vcompLbls <- c("Rater","Chimp","Time","Chimp:Rater","Chimp:Time","Time:Rater")
      
      varCompTable(vcomp, vcompLbls)
      
      gcoeff <- calcGCoefficient("Chimp",vcomp,vcompLbls,grep(":Chimp\\b|\\bChimp:",vcompLbls),counts)
      cat("G =", substr(sprintf("%.3f", round(gcoeff, 3)), 2, 5))
      
      phi <- calcPhiCoefficient("Chimp",vcomp,vcompLbls,counts)
      cat("Φ =", substr(sprintf("%.3f",round(phi,3)),2,5))
      
      
      mduse = melted[melted$Item=='Q4.2',]
      m.4.2 <- lmer(Score ~ 1 + (1|Rater) + (1|Chimp) + (1|Time) + 
                      (1|Chimp:Rater) + (1|Chimp:Time) + (1|Time:Rater), data=mduse)
      counts <- list(length(levels(mduse$Rater)),length(levels(mduse$Time)))
      names(counts) <- c("Rater","Time")
      vcomp <- VarCorr(m.4.2)
      vcompLbls <- c("Rater","Chimp","Time","Chimp:Rater","Chimp:Time","Time:Rater")
      
      varCompTable(vcomp, vcompLbls)
      
      gcoeff <- calcGCoefficient("Chimp",vcomp,vcompLbls,grep(":Chimp\\b|\\bChimp:",vcompLbls),counts)
      cat("G =", substr(sprintf("%.3f", round(gcoeff, 3)), 2, 5))
      
      phi <- calcPhiCoefficient("Chimp",vcomp,vcompLbls,counts)
      cat("Φ =", substr(sprintf("%.3f",round(phi,3)),2,5))
  
      
      mduse = melted[melted$Item=='Q5',]
      m.5 <- lmer(Score ~ 1 + (1|Rater) + (1|Chimp) + (1|Time) + 
                    (1|Chimp:Rater) + (1|Chimp:Time) + (1|Time:Rater), data=mduse)
      counts <- list(length(levels(mduse$Rater)),length(levels(mduse$Time)))
      names(counts) <- c("Rater","Time")
      vcomp <- VarCorr(m.5)
      vcompLbls <- c("Rater","Chimp","Time","Chimp:Rater","Chimp:Time","Time:Rater")
      
      varCompTable(vcomp, vcompLbls)
      
      gcoeff <- calcGCoefficient("Chimp",vcomp,vcompLbls,grep(":Chimp\\b|\\bChimp:",vcompLbls),counts)
      cat("G =", substr(sprintf("%.3f", round(gcoeff, 3)), 2, 5))
      
      phi <- calcPhiCoefficient("Chimp",vcomp,vcompLbls,counts)
      cat("Φ =", substr(sprintf("%.3f",round(phi,3)),2,5))
      
      
      mduse = melted[melted$Item=='Q6.1',]
      m.6.1 <- lmer(Score ~ 1 + (1|Rater) + (1|Chimp) + (1|Time) + 
                    (1|Chimp:Rater) + (1|Chimp:Time) + (1|Time:Rater), data=mduse)
      counts <- list(length(levels(mduse$Rater)),length(levels(mduse$Time)))
      names(counts) <- c("Rater","Time")
      vcomp <- VarCorr(m.6.1)
      vcompLbls <- c("Rater","Chimp","Time","Chimp:Rater","Chimp:Time","Time:Rater")
      
      varCompTable(vcomp, vcompLbls)
      
      gcoeff <- calcGCoefficient("Chimp",vcomp,vcompLbls,grep(":Chimp\\b|\\bChimp:",vcompLbls),counts)
      cat("G =", substr(sprintf("%.3f", round(gcoeff, 3)), 2, 5))
      
      phi <- calcPhiCoefficient("Chimp",vcomp,vcompLbls,counts)
      cat("Φ =", substr(sprintf("%.3f",round(phi,3)),2,5))
      
      
      mduse = melted[melted$Item=='Q6.2',]
      m.6.2 <- lmer(Score ~ 1 + (1|Rater) + (1|Chimp) + (1|Time) + 
                      (1|Chimp:Rater) + (1|Chimp:Time) + (1|Time:Rater), data=mduse)
      counts <- list(length(levels(mduse$Rater)),length(levels(mduse$Time)))
      names(counts) <- c("Rater","Time")
      vcomp <- VarCorr(m.6.2)
      vcompLbls <- c("Rater","Chimp","Time","Chimp:Rater","Chimp:Time","Time:Rater")
      
      varCompTable(vcomp, vcompLbls)
      
      gcoeff <- calcGCoefficient("Chimp",vcomp,vcompLbls,grep(":Chimp\\b|\\bChimp:",vcompLbls),counts)
      cat("G =", substr(sprintf("%.3f", round(gcoeff, 3)), 2, 5))
      
      
      mduse = melted[melted$Item=='Q7',]
      m.7 <- lmer(Score ~ 1 + (1|Rater) + (1|Chimp) + (1|Time) + 
                    (1|Chimp:Rater) + (1|Chimp:Time) + (1|Time:Rater), data=mduse)
      counts <- list(length(levels(mduse$Rater)),length(levels(mduse$Time)))
      names(counts) <- c("Rater","Time")
      vcomp <- VarCorr(m.7)
      vcompLbls <- c("Rater","Chimp","Time","Chimp:Rater","Chimp:Time","Time:Rater")
      
      varCompTable(vcomp, vcompLbls)
      
      gcoeff <- calcGCoefficient("Chimp",vcomp,vcompLbls,grep(":Chimp\\b|\\bChimp:",vcompLbls),counts)
      cat("G =", substr(sprintf("%.3f", round(gcoeff, 3)), 2, 5))
      
      phi <- calcPhiCoefficient("Chimp",vcomp,vcompLbls,counts)
      cat("Φ =", substr(sprintf("%.3f",round(phi,3)),2,5))
      
      
      mduse = melted[melted$Item=='Q8',]
      m.8 <- lmer(Score ~ 1 + (1|Rater) + (1|Chimp) + (1|Time) + 
                    (1|Chimp:Rater) + (1|Chimp:Time) + (1|Time:Rater), data=mduse)
      counts <- list(length(levels(mduse$Rater)),length(levels(mduse$Time)))
      names(counts) <- c("Rater","Time")
      vcomp <- VarCorr(m.8)
      vcompLbls <- c("Rater","Chimp","Time","Chimp:Rater","Chimp:Time","Time:Rater")
      
      varCompTable(vcomp, vcompLbls)
      
      gcoeff <- calcGCoefficient("Chimp",vcomp,vcompLbls,grep(":Chimp\\b|\\bChimp:",vcompLbls),counts)
      cat("G =", substr(sprintf("%.3f", round(gcoeff, 3)), 2, 5))
      
      phi <- calcPhiCoefficient("Chimp",vcomp,vcompLbls,counts)
      cat("Φ =", substr(sprintf("%.3f",round(phi,3)),2,5))
      
      
      mduse = melted[melted$Item=='Q9',]
      m.9 <- lmer(Score ~ 1 + (1|Rater) + (1|Chimp) + (1|Time) + 
                    (1|Chimp:Rater) + (1|Chimp:Time) + (1|Time:Rater), data=mduse)
      counts <- list(length(levels(mduse$Rater)),length(levels(mduse$Time)))
      names(counts) <- c("Rater","Time")
      vcomp <- VarCorr(m.9)
      vcompLbls <- c("Rater","Chimp","Time","Chimp:Rater","Chimp:Time","Time:Rater")
      
      varCompTable(vcomp, vcompLbls)
      
      gcoeff <- calcGCoefficient("Chimp",vcomp,vcompLbls,grep(":Chimp\\b|\\bChimp:",vcompLbls),counts)
      cat("G =", substr(sprintf("%.3f", round(gcoeff, 3)), 2, 5))
      
      phi <- calcPhiCoefficient("Chimp",vcomp,vcompLbls,counts)
      cat("Φ =", substr(sprintf("%.3f",round(phi,3)),2,5))
      
      
      mduse = melted[melted$Item=='Q10',]
      m.10 <- lmer(Score ~ 1 + (1|Rater) + (1|Chimp) + (1|Time) + 
                    (1|Chimp:Rater) + (1|Chimp:Time) + (1|Time:Rater), data=mduse)
      counts <- list(length(levels(mduse$Rater)),length(levels(mduse$Time)))
      names(counts) <- c("Rater","Time")
      vcomp <- VarCorr(m.10)
      vcompLbls <- c("Rater","Chimp","Time","Chimp:Rater","Chimp:Time","Time:Rater")
      
      varCompTable(vcomp, vcompLbls)
      
      gcoeff <- calcGCoefficient("Chimp",vcomp,vcompLbls,grep(":Chimp\\b|\\bChimp:",vcompLbls),counts)
      cat("G =", substr(sprintf("%.3f", round(gcoeff, 3)), 2, 5))
      
      phi <- calcPhiCoefficient("Chimp",vcomp,vcompLbls,counts)
      cat("Φ =", substr(sprintf("%.3f",round(phi,3)),2,5))
      
      
      mduse = melted[melted$Item=='SWB.Q1',]
      m.wb.1 <- lmer(Score ~ 1 + (1|Rater) + (1|Chimp) + (1|Time) + 
                    (1|Chimp:Rater) + (1|Chimp:Time) + (1|Time:Rater), data=mduse)
      counts <- list(length(levels(mduse$Rater)),length(levels(mduse$Time)))
      names(counts) <- c("Rater","Time")
      vcomp <- VarCorr(m.wb.1)
      vcompLbls <- c("Rater","Chimp","Time","Chimp:Rater","Chimp:Time","Time:Rater")
      
      varCompTable(vcomp, vcompLbls)
      
      gcoeff <- calcGCoefficient("Chimp",vcomp,vcompLbls,grep(":Chimp\\b|\\bChimp:",vcompLbls),counts)
      cat("G =", substr(sprintf("%.3f", round(gcoeff, 3)), 2, 5))
      
      phi <- calcPhiCoefficient("Chimp",vcomp,vcompLbls,counts)
      cat("Φ =", substr(sprintf("%.3f",round(phi,3)),2,5))
      
      
      mduse = melted[melted$Item=='SWB.Q2',]
      m.wb.2 <- lmer(Score ~ 1 + (1|Rater) + (1|Chimp) + (1|Time) + 
                       (1|Chimp:Rater) + (1|Chimp:Time) + (1|Time:Rater), data=mduse)
      counts <- list(length(levels(mduse$Rater)),length(levels(mduse$Time)))
      names(counts) <- c("Rater","Time")
      vcomp <- VarCorr(m.wb.2)
      vcompLbls <- c("Rater","Chimp","Time","Chimp:Rater","Chimp:Time","Time:Rater")
      
      varCompTable(vcomp, vcompLbls)
      
      gcoeff <- calcGCoefficient("Chimp",vcomp,vcompLbls,grep(":Chimp\\b|\\bChimp:",vcompLbls),counts)
      cat("G =", substr(sprintf("%.3f", round(gcoeff, 3)), 2, 5))
      
      phi <- calcPhiCoefficient("Chimp",vcomp,vcompLbls,counts)
      cat("Φ =", substr(sprintf("%.3f",round(phi,3)),2,5))
 
      
      
      mduse = melted[melted$Item=='SWB.Q3',]
      m.wb.3 <- lmer(Score ~ 1 + (1|Rater) + (1|Chimp) + (1|Time) + 
                       (1|Chimp:Rater) + (1|Chimp:Time) + (1|Time:Rater), data=mduse)
      counts <- list(length(levels(mduse$Rater)),length(levels(mduse$Time)))
      names(counts) <- c("Rater","Time")
      vcomp <- VarCorr(m.wb.3)
      vcompLbls <- c("Rater","Chimp","Time","Chimp:Rater","Chimp:Time","Time:Rater")
      
      varCompTable(vcomp, vcompLbls)
      
      gcoeff <- calcGCoefficient("Chimp",vcomp,vcompLbls,grep(":Chimp\\b|\\bChimp:",vcompLbls),counts)
      cat("G =", substr(sprintf("%.3f", round(gcoeff, 3)), 2, 5))
      
      phi <- calcPhiCoefficient("Chimp",vcomp,vcompLbls,counts)
      cat("Φ =", substr(sprintf("%.3f",round(phi,3)),2,5))
      
      
      mduse = melted[melted$Item=='SWB.Q4',]
      m.wb.4 <- lmer(Score ~ 1 + (1|Rater) + (1|Chimp) + (1|Time) + 
                       (1|Chimp:Rater) + (1|Chimp:Time) + (1|Time:Rater), data=mduse)
      counts <- list(length(levels(mduse$Rater)),length(levels(mduse$Time)))
      names(counts) <- c("Rater","Time")
      vcomp <- VarCorr(m.wb.4)
      vcompLbls <- c("Rater","Chimp","Time","Chimp:Rater","Chimp:Time","Time:Rater")
      
      varCompTable(vcomp, vcompLbls)
      
      gcoeff <- calcGCoefficient("Chimp",vcomp,vcompLbls,grep(":Chimp\\b|\\bChimp:",vcompLbls),counts)
      cat("G =", substr(sprintf("%.3f", round(gcoeff, 3)), 2, 5))
      
      phi <- calcPhiCoefficient("Chimp",vcomp,vcompLbls,counts)
      cat("Φ =", substr(sprintf("%.3f",round(phi,3)),2,5))
      