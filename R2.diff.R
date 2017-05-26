
R2.diff.ind.ci <- function(rsq1, rsq2, n1, n2=n1, k1, k2=k1, conf.level = 0.95, method='LeeZou', Random.Predictors=TRUE) {
  # Olkin Finn approximation for comparison only the Lee (1971) approach for input into the Zou (2007) equation is preferred
  if (method=='LeeZou') {
    require(gsl)
    require(MBESS)
    L1 <- ci.R2(R2=rsq1, N=n1, K=k1, conf.level=conf.level, Random.Predictors=TRUE)[[1]]
    U1 <- ci.R2(R2=rsq1, N=n1, K=k1, conf.level=conf.level, Random.Predictors=TRUE)[[3]]
    L2 <- ci.R2(R2=rsq2, N=n2, K=k2, conf.level=conf.level, Random.Predictors=TRUE)[[1]]
    U2 <- ci.R2(R2=rsq2, N=n2, K=k2, conf.level=conf.level, Random.Predictors=TRUE)[[3]]
  }
  if (method=='OlkinFinnZou') {
    require(psychometric)
    L1 <- CI.Rsq(rsq1, n1, k1, level = 0.95)[[3]]
    U1 <- CI.Rsq(rsq1, n1, k1, level = 0.95)[[4]]
    L2 <- CI.Rsq(rsq2, n2, k2, level = 0.95)[[3]]
    U2 <- CI.Rsq(rsq2, n2, k2, level = 0.95)[[4]]
  }       
  
  lower <- rsq1 - rsq2 - ((rsq1 - L1)^2 + (U2 - rsq2)^2)^0.5
  upper <- rsq1 - rsq2 + ((U1 - rsq1)^2 + (rsq2 - L2)^2)^0.5
  output <- list('CI for R square 1' = c(L1, rsq1, U1), 'CI for R square 2' = c(L2, rsq2, U2), 'Confidence level' = conf.level,
                 'CI for different in R square:' = c(lower, rsq1 - rsq2, upper))
  return(output)
} 