# Load following package first
library(party)
#
#-------------------------start of main function----------------------------------------------------
REEMctree <- function (formula, data, random, subset = NULL, initialRandomEffects = rep(0, 
                                                                                        TotalObs), ErrorTolerance = 0.001, MaxIterations = 1000, 
                       verbose = FALSE, lme.control = lmeControl(returnObject = TRUE), ctree.control = party::ctree_control(mincriterion = 0.95),
                       method = "REML", correlation = NULL) 
{
  TotalObs <- dim(data)[1]
  if (identical(subset, NULL)) {
    subs <- rep(TRUE, dim(data)[1])
  }
  else {
    subs <- subset
  }
  Predictors <- paste(attr(terms(formula), "term.labels"), 
                      collapse = "+")
  TargetName <- formula[[2]]
  if (length(TargetName) > 1) 
    TargetName <- TargetName[3]
  if (verbose) 
    print(paste("Target variable: ", TargetName))
  Target <- data[, toString(TargetName)]
  ContinueCondition <- TRUE
  iterations <- 0
  AdjustedTarget <- Target - initialRandomEffects
  oldlik <- -Inf
  newdata <- data
  newdata[, "SubsetVector"] <- subs
  while (ContinueCondition) {
    newdata[, "AdjustedTarget"] <- AdjustedTarget
    iterations <- iterations + 1
    
    tree <- party::ctree(formula(paste(c("AdjustedTarget", Predictors), collapse = "~")), data = newdata, subset = subs, controls = ctree.control)  
    
    if (verbose) 
      print(tree)
    newdata[, "nodeInd"] <- 0
    newdata[subs, "nodeInd"] <- where(tree)
    if (min(where(tree)) == max(where(tree))) { #it doesn't split on root
      lmefit <- lme(formula(paste(c(toString(TargetName), 
                                    1), collapse = "~")), data = newdata, random = random, 
                    subset = SubsetVector, method = method, control = lme.control, 
                    correlation = correlation)
    }
    else {
      lmefit <- lme(formula(paste(c(toString(TargetName), 
                                    "as.factor(nodeInd)"), collapse = "~")), data = newdata, 
                    random = random, subset = SubsetVector, method = method, 
                    control = lme.control, correlation = correlation)
    }
    if (verbose) {
      print(lmefit)
      print(paste("Estimated Error Variance = ", lmefit$sigma))
      print("Estimated Random Effects Variance = ")
      print(as.matrix(lmefit$modelStruct$reStruct[[1]]) * 
              lmefit$sigma^2)
    }
    newlik <- logLik(lmefit)
    if (verbose) 
      print(paste("Log likelihood: ", newlik))
    ContinueCondition <- (newlik - oldlik > ErrorTolerance & 
                            iterations < MaxIterations)
    oldlik <- newlik
    AllEffects <- lmefit$residuals[, 1] - lmefit$residuals[, 
                                                           dim(lmefit$residuals)[2]]
    AdjustedTarget[subs] <- Target[subs] - AllEffects
  }
  residuals <- rep(NA, length = length(Target))
  residuals[subs] <- Target[subs] - predict(lmefit)
  attr(residuals, "label") <- NULL 
  
  result <- list(Tree = tree, EffectModel = lmefit, RandomEffects = ranef(lmefit), 
                 BetweenMatrix = as.matrix(lmefit$modelStruct$reStruct[[1]]) * 
                   lmefit$sigma^2, ErrorVariance = lmefit$sigma^2, data = data, 
                 logLik = newlik, IterationsUsed = iterations, Formula = formula, 
                 Random = random, Subset = subs, ErrorTolerance = ErrorTolerance, 
                 correlation = correlation, residuals = residuals, method = method, 
                 lme.control = lme.control, ctree.control = ctree.control)
  class(result) <- "REEMctree"
  return(result)
}
#-------------------------end of main function----------------------------------------------------
#--------------------------------------------------------------------------------------------------
# Example to use unbiased RE-EM tree
library(REEMtree) # Only needed to access data set
library(party)
data(simpleREEMdata)
REEM.ctree.result<-REEMctree(Y~D+t+X, data=simpleREEMdata, random=~1|ID)
plot(REEM.ctree.result$Tree)

### Some functions in the original RE-EM tree may be lost or need different treatment such as using the predict() function
### to predict the fixed effect of testing data from a fitted tree. In particular, if a correlation structure other than
### independence is assumed for errors within individuals, the predicted response values at the terminal nodes of the tree
### will not be correct, and need to be obtained from the associated mixed model fit; that is,
###          unique(cbind(where(REEM.ctree.result$Tree), predict(REEM.ctree.result$Tree)))
### will NOT give the correct responses at the terminal nodes, but
###          unique(cbind(where(REEM.ctree.result$Tree), predict(REEM.ctree.result$EffectModel, level = 0)))
### will. Note that this means that the estimated responses at the terminal nodes when the tree is plotted will be (slightly)
### incorrect as well.


