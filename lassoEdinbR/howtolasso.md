How to lasso: Least Absolute Shrinkage and Selection Operator
========================================================
author: Drew Altschul, Department of Psychology
date: 
autosize: true
transition: none


  
The Problem of Model Building
========================================================


The Problem of Model Building
========================================================

- How can we eliminate the subjectivity of model selection?
  
  
The Problem of Model Building
========================================================

- How can we eliminate the subjectivity of model selection?
  - Inherently subjective stepwise procedures
  
  
The Problem of Model Building
========================================================

- How can we eliminate the subjectivity of model selection?
  - Inherently subjective stepwise procedures
  - which aren't even good!


The Problem of Model Building
========================================================

- How can we eliminate the subjectivity of model selection?
  - Inherently subjective stepwise procedures
  - which aren't even good!
- Can modern computing power improve model selection procedures?


The Problem of Model Building
========================================================

- How can we eliminate the subjectivity of model selection?
  - Inherently subjective stepwise procedures
  - which aren't even good!
- Can modern computing power improve model selection procedures?
- The lasso


The Problem of Model Building
========================================================

- How can we eliminate the subjectivity of model selection?
  - Inherently subjective stepwise procedures
  - which aren't even good!
- Can modern computing power improve model selection procedures?
- The lasso
  - shrinking variable estimates to zero


What is the lasso?
========================================================


What is the lasso?
========================================================

- Regularization method


What is the lasso?
========================================================

- Regularization method
- Penalizes estimates 


What is the lasso?
========================================================

- Regularization method
- Penalizes estimates 
  - reduce complexity


What is the lasso?
========================================================

- Regularization method
- Penalizes estimates 
  - reduce complexity
  - increase generalizability


What is the lasso?
========================================================

- Regularization method
- Penalizes estimates 
  - reduce complexity
  - increase generalizability
- Similar to ridge regression


What is the lasso?
========================================================

- Regularization method
- Penalizes estimates 
  - reduce complexity
  - increase generalizability
- Similar to ridge regression
  - but lasso can shrink to zero


What is the lasso?
========================================================

- Regularization method
- Penalizes estimates 
  - reduce complexity
  - increase generalizability
- Similar to ridge regression
  - but lasso can shrink to zero
  - and usually fits better

  
What does the lasso do?
========================================================

Basic linear model: $\hat{y} = b_0 + b_1*x_1+ b_2*x_2 + ... b_p*x_p$


What does the lasso do?
========================================================

Basic linear model: $\hat{y} = b_0 + b_1*x_1+ b_2*x_2 + ... b_p*x_p$

The lasso fits this with criteria
* minimize: $\sum (y - \hat{y})^2$
* such that: $\sum |b_j| \leq \lambda$


What does the lasso do?
========================================================

Basic linear model: $\hat{y} = b_0 + b_1*x_1+ b_2*x_2 + ... b_p*x_p$

The lasso fits this with criteria
* minimize: $\sum (y - \hat{y})^2$
* such that: $\sum |b_j| \leq \lambda$

- when $\lambda$ is large, the constraint has no effect and the solution is the usual multiple regression
- and $\lambda$ becomes small, the coefficients are shrunk, sometimes even to 0

  
Features of the lasso
========================================================
- Estimates are biased due to penalization


Features of the lasso
========================================================
- Estimates are biased due to penalization
  - Bias-variance trade-off
  

Features of the lasso
========================================================
![optional caption text](biasEst.png)


Features of the lasso
========================================================
- Estimates are biased due to penalization
  - Bias-variance trade-off
  - lasso estimates usually more accurate, if biased


Features of the lasso
========================================================
- Estimates are biased due to penalization
  - Bias-variance trade-off
  - lasso estimates usually more accurate, if biased
  - Does not produce standard errors


Features of the lasso
========================================================
- Estimates are biased due to penalization
  - Bias-variance trade-off
  - lasso estimates usually more accurate, if biased
  - Does not produce standard errors
- Preforms well when data are sparse


Features of the lasso
========================================================
- Estimates are biased due to penalization
  - Bias-variance trade-off
  - lasso estimates usually more accurate, if biased
  - Does not produce standard errors
- Preforms well when data are sparse
- Copes with correlated variables


Features of the lasso
========================================================
- Estimates are biased due to penalization
  - Bias-variance trade-off
  - lasso estimates usually more accurate, if biased
  - Does not produce standard errors
- Preforms well when data are sparse
- Copes with correlated variables
- Can fit data with more variables than observations


Features of the lasso
========================================================
- Estimates are biased due to penalization
  - Bias-variance trade-off
  - lasso estimates usually more accurate, if biased
  - Does not produce standard errors
- Preforms well when data are sparse
- Copes with correlated variables
- Can fit data with more variables than observations
  - particularly good at this is a variant called the Elastic Net


Working with the elastic net
========================================================


Working with the elastic net
========================================================
Elastic nets use a mixing parameter $\alpha$ to combine lasso and ridge regression


Working with the elastic net
========================================================
Elastic nets use a mixing parameter $\alpha$ to combine lasso and ridge regression

1. Parameter optimization


Working with the elastic net
========================================================
Elastic nets use a mixing parameter $\alpha$ to combine lasso and ridge regression

1. Parameter optimization
2. Prediction


Working with the elastic net
========================================================
Elastic nets use a mixing parameter $\alpha$ to combine lasso and ridge regression

1. Parameter optimization
2. Prediction

Package `glmnet`


Working with the elastic net
========================================================
Elastic nets use a mixing parameter $\alpha$ to combine lasso and ridge regression

1. Parameter optimization
2. Prediction

Package `glmnet`

glmnet works with binomial, multinomial, poisson, & cox models


Related Packages
========================================================
* Cross Validation
  - `tune {e1071}`
* Mixed Models
  - `glmmLasso`
* Genomics
  - `LDlasso`
* Bayesian
  - `EBglmnet`
* Hazard models
  - `ahaz`
  
***

* Significance testing
  - `covTest`
* SEM
  - `regSEM`
  - `sparseSEM`
  - `qgraph`
* Variable, or rather, stability selection
  - `stabs`
  - `c060`
  

Stability selection
========================================================



Stability selection
========================================================
If you're using glmnet to its fullest potential, 
  in many cases you won't really need variable selection anymore


Stability selection
========================================================
If you're using glmnet to its fullest potential, 
  in many cases you won't really need variable selection anymore

But if you do


Stability selection
========================================================
If you're using glmnet to its fullest potential, 
  in many cases you won't really need variable selection anymore

But if you do

Stability selection will allow you to use these regularization techniques to identify which variables consistently contribute to the model


Summary
========================================================


Summary
========================================================
* the lasso is a flexible, effective tool
  

Summary
========================================================
* the lasso is a flexible, effective tool
  * for both prediction modeling
  
  
Summary
========================================================
* the lasso is a flexible, effective tool
  * for both prediction modeling
  * and variable selection


Summary
========================================================
* the lasso is a flexible, effective tool
  * for both prediction modeling
  * and variable selection
* highly generalizable   


Summary
========================================================
* the lasso is a flexible, effective tool
  * for both prediction modeling
  * and variable selection
* highly generalizable   
* good support in R


Summary
========================================================
* the lasso is a flexible, effective tool
  * for both prediction modeling
  * and variable selection
* highly generalizable   
* good support in R
* not hard to get the hang of 


Questions
========================================================

* dremalt@gmail.com

* @dremalt
