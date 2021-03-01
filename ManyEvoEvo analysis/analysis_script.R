### 

### Analysis plan:
## - split df into training and test sets
## - find optimal GBM parameters to minimize RMSE, apply parameters and fit best GBMs
## - examine Importance of variables and interactions
## - look at univariate associations with outcomes (includes 2- and 3-way interactions)
##   - models are LMMs, with random intercepts for measurer and rear_area
##   - Univariate LMMs will go through all possible predictors, by important rank
##   - 2 and 3-way interactions will only be examined if they include a predictor of interest
##     - 'net_rearing_manipulation'
##     - 'rear_Cs_at_start_of_rearing'
## - build "full" model with significant predictors (|T|>2)
##     - including their main effects as well, if including an interaction is called for
## - reduce model by eliminating predictors with |T|<2
##    - same principle as above, main effects will be left in if interactions are left in
## - refit models in test set



## “To what extent is the growth of nestling blue tits (Cyanistes caeruleus) 
## influenced by competition with siblings?” 

## Thus, key vars are
# day_14_tarsus_length 	# Length of chick tarsometatarus in mm at day 14 after hatching
# day_14_weight       	# mass of chick in grams at day 14 after hatching



library(MASS)
library(caret)
library(xgboost)
library(OpenMPController)
library(doParallel)
library(lme4)
library(car)
library(MuMIn)
library(interactions)
library(ggplot2)
library(stargazer)

registerDoParallel(parallel::detectCores() - 3)




### Import & process data
df = read.csv("blue_tit_data_updated_2020-04-18_NAs.csv") # . were replaced with NAs in excel


## some processing must be done before scaling
df$hatch_nest_breed_ID = as.factor(df$hatch_nest_breed_ID)
df$rear_nest_breed_ID = as.factor(df$rear_nest_breed_ID) 
df$rear_nest_trt = as.factor(df$rear_nest_trt)

df$rear_unmanip = 0
df$rear_unmanip[df$rear_nest_trt==7] = 1


df.s = df
ind = sapply(df.s, is.numeric)
df.s[ind] = lapply(df.s[ind], scale)



### Split data into testing and training halves
set.seed(779)
splits = createFolds(y=df$hatch_nest_breed_ID, k=2)

train = df.s[splits$Fold1,]
test = df.s[splits$Fold2,]


vars = c('hatch_year',
         'Extra.pair_paternity',
         'hatch_nest_LD','hatch_nest_CS','hatch_nest_OH',
         'd0_hatch_nest_brood_size','d14_hatch_nest_brood_size',
         'rear_area','home_or_away',
         'rear_nest_LD','rear_nest_CS','rear_nest_OH',
         'rear_d0_rear_nest_brood_size',
         #'rear_Cs_out','rear_Cs_in',
         'net_rearing_manipulation','rear_unmanip',
         'rear_Cs_at_start_of_rearing','d14_rear_nest_brood_size',
         #'number_chicks_fledged_from_rear_nest','chick_survival_to_first_breed_season',
         'Date_of_day14','chick_sex_molec'
         )


  
complete.tars.wt = (!is.na(train$day_14_tarsus_length)&!is.na(train$day_14_weight))
train.mat = data.matrix(train[complete.tars.wt,vars])
tarsus = train$day_14_tarsus_length[complete.tars.wt]
weight = train$day_14_weight[complete.tars.wt]



### Explore training data

## make parameter space grid
xgb_grid_1 = expand.grid(
  nrounds = 1000,
  eta = c(0.4, 0.2, 0.1, 0.05, 0.01, 0.001),
  max_depth = c(2, 3, 4, 5, 6, 7, 8, 9, 10),
  min_child_weight = c(1, 2, 3),
  colsample_bytree = c(0.4, 0.6, 0.8, 1.0),
  subsample = c(0.5, 0.6, 0.7, 0.8, 0.9, 1.0),
  gamma = c(0, 0.05, 0.1, 0.5, 0.7, 0.9, 1.0)
)




## TARSUS LENGTH ##

## Getting optimal parameters for tarsus length training GBM
set.seed(779)
start.time <- Sys.time()
tarsus.gbm.params = train(x = train.mat,
                      y = tarsus,
                      method = "xgbTree", #metric = "Rsquared",
                      trControl = trainControl(method = "cv", number = 10, allowParallel=TRUE),
                      #tuneLength = 10,
                      tuneGrid = xgb_grid_1
                      , objective='reg:squarederror', nthread=3, num.threads=3
                      , booster='gbtree'
)
end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken # Time difference of 2.903887 hours

print(tarsus.gbm.params$bestTune)
max(tarsus.gbm.params$results$Rsquared)
min(tarsus.gbm.params$results$RMSE)
min(tarsus.gbm.params$results$MAE)
## R^2 and RMSE get the same parameters
tarsus.gbm.params$results[tarsus.gbm.params$results$Rsquared==max(tarsus.gbm.params$results$Rsquared),]
tarsus.gbm.params$results[tarsus.gbm.params$results$RMSE==min(tarsus.gbm.params$results$RMSE),] # use this for now
tarsus.gbm.params$results[tarsus.gbm.params$results$MAE==min(tarsus.gbm.params$results$MAE),]

param = list(booster='gbtree',mx_depth=5, objective='reg:squarederror', nthread=3, silent=0)



## Fitting the optimal GBM
xgb.t.tune.5$bestTune
xgb.t.tune.5$results[xgb.t.tune.5$results$RMSE==min(xgb.t.tune.5$results$RMSE),]

set.seed(779)
tarsus.gbm = xgboost(param, label = tarsus,
                        data = train.mat, verbose=0,
                     eta=0.01, max_depth=4, gamma=0.5, colsample_bytree=0.2,
                        min_child_weight=2, subsample=0.5, nrounds=4600
                        ,objective='reg:squarederror'
)

# xgb.plot.multi.trees(tarsus.gbm)
# xgb.plot.deepness(tarsus.gbm)
# xgb.plot.shap(train.mat, model=tarsus.gbm)
# xgb.plot.tree(tarsus.gbm)


importance.tarsus <- xgb.importance(feature_names=colnames(train.mat), model=tarsus.gbm)
importance.tarsus

g.tarsus.vi <- xgb.ggplot.importance(importance.tarsus)
g.tarsus.vi + theme_bw()


## write output for interaction processing
featureList <- colnames(train.mat)
featureVector <- c() 
for (i in 1:length(featureList)) { 
  featureVector[i] <- paste(i-1, featureList[i], "q", sep="\t") 
}
write.table(featureVector, "fmap.txt", row.names=FALSE, quote = FALSE, col.names = FALSE)
xgb.dump(model = tarsus.gbm, fname = 'xgb.dump', fmap = "fmap.txt", with_stats = TRUE)





## WEIGHT ##

## getting optimal parameters for weight training GBM
set.seed(779)
start.time <- Sys.time()
weight.gbm.params = train(x = train.mat,
                   y = weight,
                   method = "xgbTree", #metric = "Rsquared",
                   trControl = trainControl(method = "cv", number = 10, allowParallel=TRUE),
                   tuneLength = 10
                   , objective='reg:squarederror', nthread=3, booster='gbtree'
)
end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken # Time difference of 1.212428 hours


print(weight.gbm.params$bestTune)
max(weight.gbm.params$results$Rsquared)
min(weight.gbm.params$results$RMSE)
min(weight.gbm.params$results$MAE)
## R^2 and RMSE get the same parameters
weight.gbm.params$results[weight.gbm.params$results$Rsquared==max(weight.gbm.params$results$Rsquared),]
weight.gbm.params$results[weight.gbm.params$results$RMSE==min(weight.gbm.params$results$RMSE),] # use this for now
weight.gbm.params$results[weight.gbm.params$results$MAE==min(weight.gbm.params$results$MAE),]


## Fitting the optimal GBM
xgb.w.tune.5$bestTune
xgb.w.tune.5$results[xgb.w.tune.5$results$RMSE==min(xgb.w.tune.5$results$RMSE),]

set.seed(779)
weight.gbm = xgboost(param, label = weight,
                     data = train.mat, verbose=0,
                     eta=0.01, max_depth=4, gamma=0.05, colsample_bytree=0.4,
                     min_child_weight=3, subsample=0.6, nrounds=5100
                     ,objective='reg:squarederror'
)

importance.weight <- xgb.importance(feature_names=colnames(train.mat), model=weight.gbm)
importance.weight

g.weight.vi <- xgb.ggplot.importance(importance.weight)
g.weight.vi + theme_bw()


## write output for interaction processing
featureList <- colnames(train.mat)
featureVector <- c() 
for (i in 1:length(featureList)) { 
  featureVector[i] <- paste(i-1, featureList[i], "q", sep="\t") 
}
write.table(featureVector, "fmap.txt", row.names=FALSE, quote = FALSE, col.names = FALSE)
xgb.dump(model = weight.gbm, fname = 'xgb.dump', fmap = "fmap.txt", with_stats = TRUE)







## TARSUS LMMs 

t.1.HnL = lmer(day_14_tarsus_length ~ hatch_nest_LD
               + (1|day14_measurer) + (1|rear_area)
               , data=train)
summary(t.1.HnL)

t.1.RnL = lmer(day_14_tarsus_length ~ rear_nest_LD
               + (1|day14_measurer) + (1|rear_area)
               , data=train)
summary(t.1.RnL)

t.1.HnO = lmer(day_14_tarsus_length ~ hatch_nest_OH
               + (1|day14_measurer) + (1|rear_area)
               , data=train)
summary(t.1.HnO)

t.1.RCsStR = lmer(day_14_tarsus_length ~ rear_Cs_at_start_of_rearing
                  + (1|day14_measurer) + (1|rear_area)
                  , data=train)
summary(t.1.RCsStR)

t.1.RnO = lmer(day_14_tarsus_length ~ rear_nest_OH
               + (1|day14_measurer) + (1|rear_area)
               , data=train)
summary(t.1.RnO)

t.1.sex = lmer(day_14_tarsus_length ~ chick_sex_molec 
                    + (1|day14_measurer) + (1|rear_area)
                    , data=train)
summary(t.1.sex)

t.1.d14RnBS = lmer(day_14_tarsus_length ~ d14_rear_nest_brood_size
                   + (1|day14_measurer) + (1|rear_area)
                   , data=train)
summary(t.1.d14RnBS)

t.1.d14 = lmer(day_14_tarsus_length ~ Date_of_day14
               + (1|day14_measurer) + (1|rear_area)
               , data=train)
summary(t.1.d14)

t.1.nrm = lmer(day_14_tarsus_length ~ net_rearing_manipulation
               + (1|day14_measurer) + (1|rear_area)
               , data=train)
summary(t.1.nrm)

### *** Next predictor is not significant *** Cut off predictors ***

# t.1.d14HnBS = lmer(day_14_tarsus_length ~ d14_hatch_nest_brood_size
#                    + (1|day14_measurer) + (1|rear_area)
#                    , data=train)
# summary(t.1.d14HnBS)
# 



## 2-way interactions - only those featuring
## rear_Cs_at_start_of_rearing
## net_rearing_manipulation

t.2.a = lmer(day_14_tarsus_length ~ chick_sex_molec * net_rearing_manipulation
             + (1|day14_measurer) + (1|rear_area)
             , data=train)
summary(t.2.a)

t.2.b = lmer(day_14_tarsus_length ~ I(rear_Cs_at_start_of_rearing^2) + rear_Cs_at_start_of_rearing
             + (1|day14_measurer) + (1|rear_area)
             , data=train)v
summary(t.2.b)
# add I(rear_Cs_at_start_of_rearing^2)

t.2.c = lmer(day_14_tarsus_length ~ d14_rear_nest_brood_size * rear_Cs_at_start_of_rearing
             + (1|day14_measurer) + (1|rear_area)
             , data=train)
summary(t.2.c)
# add d14_rear_nest_brood_size * rear_Cs_at_start_of_rearing

t.2.d = lmer(day_14_tarsus_length ~ rear_Cs_at_start_of_rearing * rear_nest_LD
             + (1|day14_measurer) + (1|rear_area)
             , data=train)
summary(t.2.d)
# add rear_nest_LD * rear_Cs_at_start_of_rearing

t.2.e = lmer(day_14_tarsus_length ~ I(net_rearing_manipulation^2) + net_rearing_manipulation
             + (1|day14_measurer) + (1|rear_area)
             , data=train)
summary(t.2.e)
# add I(net_rearing_manipulation^2)

### *** cutoff

# t.2.f = lmer(day_14_tarsus_length ~ d14_hatch_nest_brood_size * rear_Cs_at_start_of_rearing
#              + (1|day14_measurer) + (1|rear_area)
#              , data=train)
# summary(t.2.f)



## 3-way interactions
t.3.a = lmer(day_14_tarsus_length ~ rear_nest_LD * rear_Cs_at_start_of_rearing + I(rear_nest_LD^2) * rear_Cs_at_start_of_rearing
             + (1|day14_measurer) + (1|rear_area)
             , data=train)
summary(t.3.a)

t.3.b = lmer(day_14_tarsus_length ~ chick_sex_molec * net_rearing_manipulation + I(net_rearing_manipulation^2) * chick_sex_molec
             + (1|day14_measurer) + (1|rear_area)
             , data=train)
summary(t.3.b) 

t.3.c = lmer(day_14_tarsus_length ~ hatch_nest_LD * net_rearing_manipulation + I(hatch_nest_LD^2) * net_rearing_manipulation
             + (1|day14_measurer) + (1|rear_area)
             , data=train)
summary(t.3.c) 
# add net_rearing_manipulation:I(hatch_nest_LD^2)

t.3.d = lmer(day_14_tarsus_length ~ d0_hatch_nest_brood_size * net_rearing_manipulation + I(d0_hatch_nest_brood_size^2) * net_rearing_manipulation
             + (1|day14_measurer) + (1|rear_area)
             , data=train)
summary(t.3.d)
# add d0_hatch_nest_brood_size

t.3.e = lmer(day_14_tarsus_length ~ chick_sex_molec * hatch_nest_LD * net_rearing_manipulation
             + (1|day14_measurer) + (1|rear_area)
             , data=train)
summary(t.3.e)




## "Full" model
lme.t.full = lmer(day_14_tarsus_length ~ 
                    hatch_nest_LD + rear_nest_LD + hatch_nest_OH +
                    rear_Cs_at_start_of_rearing + rear_nest_OH + chick_sex_molec +
                    d14_rear_nest_brood_size + Date_of_day14 +
                    net_rearing_manipulation + 
                    I(rear_Cs_at_start_of_rearing^2) + 
                    d14_rear_nest_brood_size * rear_Cs_at_start_of_rearing +
                    rear_nest_LD * rear_Cs_at_start_of_rearing +
                    I(net_rearing_manipulation^2) +
                    net_rearing_manipulation*I(hatch_nest_LD^2) +
                    d0_hatch_nest_brood_size
              + (1|day14_measurer) + (1|rear_area)
               , data=train
               )
summary(lme.t.full)
vif(lme.t.full)
plot(lme.t.full)
r.squaredGLMM(lme.t.full)

lme.t.reduce = lmer(day_14_tarsus_length ~ 
                      rear_Cs_at_start_of_rearing + chick_sex_molec +
                      d14_rear_nest_brood_size + Date_of_day14 +
                      net_rearing_manipulation + 
                      I(net_rearing_manipulation^2) +
                      net_rearing_manipulation*I(hatch_nest_LD^2)
                    + (1|day14_measurer) + (1|rear_area)
                    , data=train
)
summary(lme.t.reduce)
r.squaredGLMM(lme.t.reduce)



## WEIGHT LMMs

w.1.nrm = lmer(day_14_weight ~ net_rearing_manipulation
               + (1|day14_measurer) + (1|rear_area)
               , data=train)
summary(w.1.nrm)

w.1.RCsStR = lmer(day_14_weight ~ rear_Cs_at_start_of_rearing
               + (1|day14_measurer) + (1|rear_area)
               , data=train)
summary(w.1.RCsStR)

w.1.rnL = lmer(day_14_weight ~ rear_nest_LD
                  + (1|day14_measurer) + (1|rear_area)
                  , data=train)
summary(w.1.rnL)



## 2-way interactions - only those featuring
## rear_Cs_at_start_of_rearing
## net_rearing_manipulation
w.2.a = lmer(day_14_weight ~ d14_rear_nest_brood_size * net_rearing_manipulation
             + (1|day14_measurer) + (1|rear_area)
             , data=train)
summary(w.2.a)
# add d14_rear_nest_brood_size

w.2.b = lmer(day_14_weight ~ d14_rear_nest_brood_size * rear_Cs_at_start_of_rearing
             + (1|day14_measurer) + (1|rear_area)
             , data=train)
summary(w.2.b)

w.2.c = lmer(day_14_weight ~ chick_sex_molec * net_rearing_manipulation
             + (1|day14_measurer) + (1|rear_area)
             , data=train)
summary(w.2.c)
# add chick_sex_molec

w.2.d = lmer(day_14_weight ~ net_rearing_manipulation
             + (1|day14_measurer) + (1 + net_rearing_manipulation|rear_area)
             , data=train)
summary(w.2.d)
# add rear_area RE 

w.2.e = lmer(day_14_weight ~ net_rearing_manipulation * hatch_nest_LD
             + (1|day14_measurer) + (1|rear_area)
             , data=train)
summary(w.2.e)

w.2.f = lmer(day_14_weight ~ rear_nest_LD * rear_Cs_at_start_of_rearing
             + (1|day14_measurer) + (1|rear_area)
             , data=train)
summary(w.2.f)
# add rear_nest_LD + rear_nest_LD:rear_Cs_at_start_of_rearing

w.2.g = lmer(day_14_weight ~ rear_nest_LD * net_rearing_manipulation
             + (1|day14_measurer) + (1|rear_area)
             , data=train)
summary(w.2.g)



## 3-way interactions
w.3.a = lmer(day_14_weight ~ d14_rear_nest_brood_size * rear_Cs_at_start_of_rearing * net_rearing_manipulation
             + (1|day14_measurer) + (1|rear_area)
             , data=train)
summary(w.3.a)

w.3.b = lmer(day_14_weight ~ hatch_nest_LD * net_rearing_manipulation * chick_sex_molec
             + (1|day14_measurer) + (1|rear_area)
             , data=train)
summary(w.3.b)

w.3.c = lmer(day_14_weight ~ d14_rear_nest_brood_size * rear_Cs_at_start_of_rearing + d14_rear_nest_brood_size * I(rear_Cs_at_start_of_rearing^2)
             + (1|day14_measurer) + (1|rear_area)
             , data=train)
summary(w.3.c)
# add I(rear_Cs_at_start_of_rearing^2) + d14_rear_nest_brood_size:rear_Cs_at_start_of_rearing

w.3.d = lmer(day_14_weight ~ hatch_nest_LD * net_rearing_manipulation + I(hatch_nest_LD^2) * net_rearing_manipulation 
             + (1|day14_measurer) + (1|rear_area)
             , data=train)
summary(w.3.d)
# add I(hatch_nest_LD^2) + net_rearing_manipulation:I(hatch_nest_LD^2)

w.3.e = lmer(day_14_weight ~  d14_rear_nest_brood_size * net_rearing_manipulation * rear_d0_rear_nest_brood_size
             + (1|day14_measurer) + (1|rear_area)
             , data=train)
summary(w.3.e)
# add rear_d0_rear_nest_brood_size + net_rearing_manipulation:rear_d0_rear_nest_brood_size

w.3.f = lmer(day_14_weight ~  d14_rear_nest_brood_size * net_rearing_manipulation + d14_rear_nest_brood_size * I(net_rearing_manipulation)^2
             + (1|day14_measurer) + (1|rear_area)
             , data=train)
summary(w.3.f)
# singular fit, groups dropped ~ none of the included variables merit additional inclusion



## "Full" model
lme.weight = lmer(day_14_weight ~ 
                    rear_Cs_at_start_of_rearing + net_rearing_manipulation +
                    rear_nest_LD*rear_Cs_at_start_of_rearing + 
                    chick_sex_molec + 
                    hatch_nest_LD + 
                    I(hatch_nest_LD^2)*net_rearing_manipulation +
                    d14_rear_nest_brood_size + 
                    I(rear_Cs_at_start_of_rearing^2) + d14_rear_nest_brood_size*rear_Cs_at_start_of_rearing +
                    net_rearing_manipulation*rear_d0_rear_nest_brood_size
                  + (1|day14_measurer) + (1|rear_area)
                  , data=train
)
summary(lme.weight)
plot(lme.weight)
r.squaredGLMM(lme.weight)



lme.w.reduce = lmer(day_14_weight ~ 
                      rear_Cs_at_start_of_rearing + net_rearing_manipulation +
                      rear_nest_LD*rear_Cs_at_start_of_rearing + 
                      chick_sex_molec + 
                      I(hatch_nest_LD^2)*net_rearing_manipulation +
                      d14_rear_nest_brood_size + 
                      I(rear_Cs_at_start_of_rearing^2)
                       + (1|day14_measurer) + (1|rear_area)
                       , data=train
)
summary(lme.w.reduce)
r.squaredGLMM(lme.w.reduce)


### Confirmatory analyses run in test subset

## for final results, run models from here


### Tarsus test model
lme.t.reduce.test = lmer(day_14_tarsus_length ~ 
                           rear_Cs_at_start_of_rearing + net_rearing_manipulation + chick_sex_molec +
                           net_rearing_manipulation*I(hatch_nest_LD^2) +
                           d14_rear_nest_brood_size + Date_of_day14 +
                           I(net_rearing_manipulation^2) +
                           + (1|day14_measurer) + (1|rear_area)
                         , data=test
)
summary(lme.t.reduce.test)
#                                               Estimate Std. Error t value
# (Intercept)                                  0.089141   0.160136   0.557
# rear_Cs_at_start_of_rearing                 -0.398716   0.071593  -5.569 *
# chick_sex_molec                              0.346877   0.024985  13.883 *
# d14_rear_nest_brood_size                     0.257641   0.054824   4.699 *
# Date_of_day14                                0.127399   0.028989   4.395 *
# net_rearing_manipulation                    -0.086031   0.055780  -1.542
# I(net_rearing_manipulation^2)               -0.005360   0.042589  -0.126
# I(hatch_nest_LD^2)                          -0.006759   0.028089  -0.241
# net_rearing_manipulation:I(hatch_nest_LD^2) -0.018301   0.024065  -0.760
r.squaredGLMM(lme.t.reduce.test)



### Weight test model
lme.w.reduce.test = lmer(day_14_weight ~ 
                      rear_Cs_at_start_of_rearing + net_rearing_manipulation +
                      chick_sex_molec + 
                      I(hatch_nest_LD^2)*net_rearing_manipulation +
                      d14_rear_nest_brood_size + 
                      I(rear_Cs_at_start_of_rearing^2) +
                      rear_nest_LD*rear_Cs_at_start_of_rearing + 
                    + (1|day14_measurer) + (1|rear_area)
                    , data=test
)
summary(lme.w.reduce.test)
#                                               Estimate Std. Error t value
# (Intercept)                                 -0.046554   0.086652  -0.537
# rear_Cs_at_start_of_rearing                 -0.619738   0.068228  -9.083 *
# net_rearing_manipulation                    -0.242515   0.047854  -5.068 *
# rear_nest_LD                                -0.052688   0.030213  -1.744 
# chick_sex_molec                              0.192534   0.024909   7.730 *
# I(hatch_nest_LD^2)                           0.008959   0.028046   0.319 
# d14_rear_nest_brood_size                     0.405193   0.054256   7.468 *
# I(rear_Cs_at_start_of_rearing^2)             0.022691   0.025716   0.882
# rear_Cs_at_start_of_rearing:rear_nest_LD     0.044414   0.029148   1.524
# net_rearing_manipulation:I(hatch_nest_LD^2)  0.079022   0.024621   3.210 *
r.squaredGLMM(lme.w.reduce.test)



### Table

stargazer(lme.t.reduce.test, lme.w.reduce.test, type='text', ci=TRUE, single.row=TRUE)

### below is not in the original submission

stargazer(lme.t.reduce.test, lme.w.reduce.test, type='html', ci=TRUE, single.row=TRUE, out='./Table1.htm')

