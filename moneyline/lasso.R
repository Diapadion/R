### new LASSO technique

# run the other files first:
# 

load("C:/Users/s1229179/GitHub/R/moneyline/.RData")

# one day, the above will not be necessary


library(glmnet)

# 2014

netform14 <- droplevels(kpDiffs14)

netform14 = model.matrix(~ . - 1, data=netform14)


net.diff.14 <- glmnet(netform14[,c(64:83)], netform14[,84], family="binomial",
                      standardize=T, alpha = 1,lambda.min.ratio=0.00001,  nlambda=1000)
  
 
net.diff.14.cv <- cv.glmnet(netform14[,c(64:83)], netform14[,84], family="binomial") 
plot(net.diff.14.cv)

coef(net.diff.14, 
     s=net.diff.14.cv$lambda.min
     #s=net.diff.14.cv$lambda.1se
)




# 2013

netform13 <- droplevels(kpDiffs13)

netform13 = model.matrix(~ . - 1, data=netform13)


net.diff.13 <- glmnet(netform13[,c(64:81)], netform13[,82], family="binomial",
                      standardize=T, alpha = 1,lambda.min.ratio=0.00001,  nlambda=1000)


net.diff.13.cv <- cv.glmnet(netform13[,c(64:81)], netform13[,82], family="binomial") 
plot(net.diff.13.cv)

coef(net.diff.13, 
     s=net.diff.13.cv$lambda.min
     #s=net.diff.14.cv$lambda.1se
)



# 2012

netform12 <- droplevels(kpDiffs12)

netform12 = model.matrix(~ . - 1, data=netform12)


net.diff.12 <- glmnet(netform12[,c(64:81)], netform12[,82], family="binomial",
                      standardize=T, alpha = 1,lambda.min.ratio=0.00001,  nlambda=1000)


net.diff.12.cv <- cv.glmnet(netform12[,c(64:81)], netform12[,82], family="binomial") 
plot(net.diff.12.cv)

coef(net.diff.12, 
     s=net.diff.12.cv$lambda.min
     #s=net.diff.14.cv$lambda.1se
)


