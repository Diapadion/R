# commit 3739dde45a6aa3bd65c134fc2b05830c43e08b3a
# Author: Mark James Adams <m.j.adams-2@sms.ed.ac.uk>
# Date:   Mon Apr 11 19:23:01 2011 +0100


unit.weight <- function(Loadings) {
  rows <- length(Loadings[,1])

  # unweigted loadings of +1, 0, -1
  for (i in 1:rows) {
    # replace the max of each row with 1
    len <- length(Loadings[1,])
    row <- Loadings[i,][1:len]
    
    where.maximum <- abs(row) >= max(abs(row));
    salient.loading <- row[where.maximum][1];
    
    if(salient.loading > 0) {
      fill <- 1;
    } else if(salient.loading < 0) {
      fill <- -1;
    } else {
      fill <- 0;
    }
    Loadings[i,][1:len][ where.maximum] <- fill;
    Loadings[i,][1:len][!where.maximum] <- 0
  }
  Loadings
}

ssq <- function(V) {
  sum(V^2);
}

# Based on SAS code from
# MCCRAE et al. Evaluating replicability of factors in the revised NEO 
# Personality Inventory: Confirmatory factor …. J Pers Soc Psychol (1996)
# loadings: factor loadings for a varimax matrix
# norm: loadings for the target matrix
# weight "unit" or "none". Unit weight the loadings before applying the rotation
#
# Last column and last row of the result gives variable and factor congruences.
procrustes <- function(loadings, norm, weight="none") {
  
  if(weight == "unit") {
    loadings <- unit.weight(loadings);
    norm <- unit.weight(norm);
  }

  S <- t(loadings) %*% norm;
  W <- eigen(S %*% t(S))$vectors;

  V <- eigen(t(S) %*% S)$vectors;

  O <- t(W) %*% S %*% V;
  K <- diag(diag(sign(O)));

  WW <- W %*% K;
  T <- WW %*% t(V);

  procrust <- loadings %*% T;

  #congruence coeffcients
  
  # A
  norm.diag.root <- sqrt(diag(t(norm) %*% norm));
  A <- matrix(norm.diag.root, ncol=1);
  
  #B 
  procrust.diag.root <- sqrt(diag(t(procrust) %*% procrust));
  B <- matrix(procrust.diag.root, ncol=1)
  
  # C
  norm.procrust.diag <- diag((t(norm) %*% procrust) / (A %*% t(B)));
  C <- matrix(norm.procrust.diag, ncol=1)
  
  # D
  D <- matrix(sqrt(diag(norm %*% t(norm))), ncol=1)
  
  E <- matrix(sqrt(diag(procrust %*% t(procrust))), ncol=1)
  
  congruence = diag((norm %*% t(procrust))/(D %*% t(E)));
  
  factor.congruence = sum(norm * procrust)/sqrt((ssq(norm)) * (ssq(procrust)));
  
  procrustes.congruence <- rbind(cbind(procrust, congruence), cbind(t(C), factor.congruence));

  return(procrustes.congruence);

} 


