### code to run in talk ###

### standard regression section
library(glmnet)
  
#download.file("http://www.shatterline.com/MachineLearning/data/hiv.rda","hiv.rda", mode="wb") # Done.
load("hiv.rda")	

visualize.matrix <- function(mat) {
  print(names(mat))
  
  image(1:nrow(mat$x), 1:ncol(mat$x), z=mat$x,
        col = c("darkgreen", "white"),
        xlab = "Observations", ylab = "Attributes")
  
  title(main = "Visualizing the Sparse Binary Matrix",
        font.main = 4)
  return (dim(mat$x)) #returns the dimensions of the matrix
}

visualize.matrix(hiv.train)

# N.B. glmnet needs to work with data as a matrix or sprase.matrix, not a data.frame



### Initial fitting comparisons

dim(hiv.train$x)
indx = seq(1,200,by=10)


fit <- glmnet(hiv.train$x[,indx], hiv.train$y, alpha = 0)
plot(fit, "lambda")


fit <- glmnet(hiv.train$x[,indx], hiv.train$y, alpha = 1)
plot(fit, "lambda")


fit <- glmnet(hiv.train$x[,indx], hiv.train$y, alpha = 0.3)
plot(fit, "lambda")



### Cross validation

cv.f <- cv.glmnet(hiv.train$x[,indx], hiv.train$y, alpha = 0.3)
plot(cv.f)

# large error is due to restriction
cv.full <- cv.glmnet(hiv.train$x, hiv.train$y, alpha = 0.3)
plot(cv.full)

# these values are fine for this purpose:
cv.f$lambda.min
cv.f$lambda.1se

# if you're interested in parameter estimation, effect sizes
coef(fit,s=cv.f$lambda.1se)



### Prediction
fit.full = glmnet(hiv.train$x, hiv.train$y, alpha = 0.3) # return to the full set
pred.y <- predict(fit.full, hiv.test$x) # predict from the test data
mean.sq.test.error <- apply((pred.y - hiv.test$y)^2,2,mean)

#plot(cv.f)
points(log(fit.full$lambda), mean.sq.test.error, col="blue",pch="*")
legend("topleft",legend=c("10-fold Cross Validation","Test HIV Data"),pch="*",col=c("red","blue"))
# pretty good...










### Stability Selection

library(stabs)


stab.lasso <- stabsel(x = hiv.train$x[,indx], y = hiv.train$y,
                      fitfun = glmnet.lasso, cutoff = 0.75, PFER = 1)

# cutoff: Semi-arbitrary, hardline used for counting variables as in or out
#         guidelines: [0.6 to 0.9] (maybe even [0.5 to 1])
#
# PFER: Per-family error rate; the maximum number of acceptable false positives

plot(stab.lasso, main = "Lasso")



df = data.frame(hiv.train$y,hiv.train$x[,indx])
#form = as.formula(paste("roll_pct ~ ", paste(as.vector(colnames(hiv.train$x[,indx])), sep ="+"),sep = ""))

lm1 <- lm(hiv.train.y ~ . , data = df)
lm1.step <- step(lm1, direction = 'backward', trace = 0)
summary(lm1.step)

lm2 <- lm(hiv.train.y ~ 1, data = df)
lm2.step <- step(lm2, scope = formula(df), direction ='forward', trace=0)
summary(lm2.step)



