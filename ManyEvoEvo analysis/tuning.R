### Training by "knobs"
### (see https://www.kaggle.com/pelkoja/visual-xgboost-tuning-with-caret)



nrounds=5200

## Sample tuning grid
# tune_grid = expand.grid(
#   nrounds = seq(from = 200, to = nrounds, by = 1000),
#   eta = c(0.4, 0.2, 0.1, 0.05, 0.01, 0.001),
#   max_depth = c(2, 3, 4, 5, 6, 7),
#   gamma = 0,
#   colsample_bytree = 1,
#   min_child_weight = 1,
#   subsample = 1
# )



### TARSUS

set.seed(779)
start.time <- Sys.time()
xgb.t.tune.1 = train(x = train.mat,
                     y = tarsus,
                     method = "xgbTree", #metric = "Rsquared",
                     trControl = trainControl(method = "cv", number = 10, allowParallel=TRUE),
                     #tuneLength = 10,
                     tuneGrid = tune_grid
                    , objective='reg:squarederror', nthread=3, num.threads=3
                    , booster='gbtree'
)
end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken # Time difference of 24.71158 mins
gc()

tuneplot(xgb.t.tune.1)

xgb.t.tune.1$bestTune

xgb.t.tune.1$results[xgb.t.tune.1$results$Rsquared==max(xgb.t.tune.1$results$Rsquared),]
xgb.t.tune.1$results[xgb.t.tune.1$results$RMSE==min(xgb.t.tune.1$results$RMSE),] # use this for now
xgb.t.tune.1$results[xgb.t.tune.1$results$MAE==min(xgb.t.tune.1$results$MAE),]

ggplot(xgb.t.tune.1)
#eta = 0.010, max_depth = 3 to 5



tune_grid = expand.grid(
  nrounds = seq(from = 100, to = nrounds, by = 500),
  eta = 0.01,
  max_depth = c(3, 4, 5),
  gamma = 0,
  colsample_bytree = 1,
  min_child_weight = c(1,2,3),
  subsample = 1
)


set.seed(779)
start.time <- Sys.time()
xgb.t.tune.2 = train(x = train.mat,
                     y = tarsus,
                     method = "xgbTree", #metric = "Rsquared",
                     trControl = trainControl(method = "cv", number = 10, allowParallel=TRUE),
                     #tuneLength = 10,
                     tuneGrid = tune_grid
                     , objective='reg:squarederror', nthread=3, num.threads=3
                     , booster='gbtree'
)
end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken # Time difference of 8.94111 mins

ggplot(xgb.t.tune.2)
xgb.t.tune.2$bestTune
# max_depth = 4, min_child_weight = 2



tune_grid = expand.grid(
  nrounds = seq(from = 100, to = nrounds, by = 500),
  eta = 0.01,
  max_depth = 4,
  gamma = 0,
  colsample_bytree = c(0.2, 0.4, 0.6, 0.8),
  min_child_weight = 2,
  subsample = c(0.5, 0.6, 0.7, 0.8, 0.9)
)

set.seed(779)
start.time <- Sys.time()
xgb.t.tune.3 = train(x = train.mat,
                     y = tarsus,
                     method = "xgbTree", #metric = "Rsquared",
                     trControl = trainControl(method = "cv", number = 10, allowParallel=TRUE),
                     #tuneLength = 10,
                     tuneGrid = tune_grid
                     , objective='reg:squarederror', nthread=3, num.threads=3
                     , booster='gbtree'
)
end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken # Time difference of 12.20177 mins

ggplot(xgb.t.tune.3)
xgb.t.tune.3$bestTune
# subsample = 0.5, colsample_bytree = 0.2

 

tune_grid = expand.grid(
  nrounds = seq(from = 100, to = nrounds, by = 500),
  eta = 0.01,
  max_depth = 4,
  gamma = c(0, 0.01, 0.05, 0.1, 0.5, 0.7, 0.9, 1.0),
  colsample_bytree = 0.2,
  min_child_weight = 2,
  subsample = 0.5
)

set.seed(779)
start.time <- Sys.time()
xgb.t.tune.4 = train(x = train.mat,
                     y = tarsus,
                     method = "xgbTree", #metric = "Rsquared",
                     trControl = trainControl(method = "cv", number = 10, allowParallel=TRUE),
                     #tuneLength = 10,
                     tuneGrid = tune_grid
                     , objective='reg:squarederror', nthread=3, num.threads=3
                     , booster='gbtree'
)
end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken # Time difference of 5.375901 mins


ggplot(xgb.t.tune.4)
xgb.t.tune.4$bestTune
# gamma = 0.5



tune_grid = expand.grid(
  nrounds = seq(from = 100, to = 10000, by = 500),
  eta = c(0.001, 0.01, 0.015, 0.025, 0.05, 0.1),
  max_depth = 4,
  gamma = 0.5,
  colsample_bytree = 0.2,
  min_child_weight = 2,
  subsample = 0.5
)

set.seed(779)
start.time <- Sys.time()
xgb.t.tune.5 = train(x = train.mat,
                     y = tarsus,
                     method = "xgbTree", #metric = "Rsquared",
                     trControl = trainControl(method = "cv", number = 10, allowParallel=TRUE),
                     #tuneLength = 10,
                     tuneGrid = tune_grid
                     , objective='reg:squarederror', nthread=3, num.threads=3
                     , booster='gbtree'
)
end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken 

ggplot(xgb.t.tune.5)
xgb.t.tune.5$bestTune

xgb.t.tune.5$results[xgb.t.tune.5$results$Rsquared==max(xgb.t.tune.5$results$Rsquared),]
xgb.t.tune.5$results[xgb.t.tune.5$results$RMSE==min(xgb.t.tune.5$results$RMSE),] # use this for now
xgb.t.tune.5$results[xgb.t.tune.5$results$MAE==min(xgb.t.tune.5$results$MAE),]
#eta = 0.01, nround ~ 4600



### WEIGHT

set.seed(779)
start.time <- Sys.time()
xgb.w.tune.1 = train(x = train.mat,
                     y = weight,
                     method = "xgbTree", #metric = "Rsquared",
                     trControl = trainControl(method = "cv", number = 10, allowParallel=TRUE),
                     #tuneLength = 10,
                     tuneGrid = tune_grid
                     , objective='reg:squarederror', nthread=3, num.threads=3
                     , booster='gbtree'
)
end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken # Time difference of 
gc()

xgb.w.tune.1$bestTune

xgb.w.tune.1$results[xgb.w.tune.1$results$Rsquared==max(xgb.w.tune.1$results$Rsquared),]
xgb.w.tune.1$results[xgb.w.tune.1$results$RMSE==min(xgb.w.tune.1$results$RMSE),] # use this for now
xgb.w.tune.1$results[xgb.w.tune.1$results$MAE==min(xgb.w.tune.1$results$MAE),]

ggplot(xgb.w.tune.1)
#eta = , max_depth = 


tune_grid = expand.grid(
  nrounds = seq(from = 100, to = nrounds, by = 500),
  eta = 0.015,
  max_depth = c(2, 3, 4, 5),
  gamma = 0,
  colsample_bytree = 1,
  min_child_weight = c(1,2,3),
  subsample = 1
)

set.seed(779)
start.time <- Sys.time()
xgb.w.tune.2 = train(x = train.mat,
                     y = weight,
                     method = "xgbTree", #metric = "Rsquared",
                     trControl = trainControl(method = "cv", number = 10, allowParallel=TRUE),
                     #tuneLength = 10,
                     tuneGrid = tune_grid
                     , objective='reg:squarederror', nthread=3, num.threads=3
                     , booster='gbtree'
)
end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken # Time difference of 10.59765 mins

ggplot(xgb.w.tune.2)
xgb.w.tune.2$bestTune
# max_depth = 4, min_child_weight = 3



tune_grid = expand.grid(
  nrounds = seq(from = 100, to = nrounds, by = 500),
  eta = 0.015,
  max_depth = 4,
  gamma = 0,
  colsample_bytree = c(0.2, 0.4, 0.6, 0.8, 1.0),
  min_child_weight = 3,
  subsample = c(0.5, 0.6, 0.7, 0.8, 0.9, 1.0)
)

set.seed(779)
start.time <- Sys.time()
xgb.w.tune.3 = train(x = train.mat,
                     y = weight,
                     method = "xgbTree", #metric = "Rsquared",
                     trControl = trainControl(method = "cv", number = 10, allowParallel=TRUE),
                     #tuneLength = 10,
                     tuneGrid = tune_grid
                     , objective='reg:squarederror', nthread=3, num.threads=3
                     , booster='gbtree'
)
end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken # Time difference of

ggplot(xgb.w.tune.3)
xgb.w.tune.3$bestTune
# subsample = 0.6, colsample_bytree = 0.4



tune_grid = expand.grid(
  nrounds = seq(from = 100, to = nrounds, by = 500),
  eta = 0.015,
  max_depth = 4,
  gamma = c(0, 0.01, 0.05, 0.1, 0.5, 0.7, 0.9, 1.0),
  colsample_bytree = 0.4,
  min_child_weight = 3,
  subsample = 0.6
)

set.seed(779)
start.time <- Sys.time()
xgb.w.tune.4 = train(x = train.mat,
                     y = weight,
                     method = "xgbTree", #metric = "Rsquared",
                     trControl = trainControl(method = "cv", number = 10, allowParallel=TRUE),
                     #tuneLength = 10,
                     tuneGrid = tune_grid
                     , objective='reg:squarederror', nthread=3, num.threads=3
                     , booster='gbtree'
)
end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken # Time difference of 6.603596 mins


ggplot(xgb.w.tune.4)
xgb.w.tune.4$bestTune
# gamma = 0.05



tune_grid = expand.grid(
  nrounds = seq(from = 100, to = 10000, by = 500),
  eta = c(0.001, 0.01, 0.015, 0.025, 0.05, 0.1),
  max_depth = 4,
  gamma = 0.05,
  colsample_bytree = 0.4,
  min_child_weight = 3,
  subsample = 0.6
)

set.seed(779)
start.time <- Sys.time()
xgb.w.tune.5 = train(x = train.mat,
                     y = weight,
                     method = "xgbTree", #metric = "Rsquared",
                     trControl = trainControl(method = "cv", number = 10, allowParallel=TRUE),
                     #tuneLength = 10,
                     tuneGrid = tune_grid
                     , objective='reg:squarederror', nthread=3, num.threads=3
                     , booster='gbtree'
)
end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken 

ggplot(xgb.w.tune.5)
xgb.w.tune.5$bestTune

xgb.t.tune.5$results[xgb.t.tune.5$results$Rsquared==max(xgb.t.tune.5$results$Rsquared),]
xgb.t.tune.5$results[xgb.t.tune.5$results$RMSE==min(xgb.t.tune.5$results$RMSE),] # use this for now
xgb.t.tune.5$results[xgb.t.tune.5$results$MAE==min(xgb.t.tune.5$results$MAE),]
#eta = 0.01, nround ~ 5100
