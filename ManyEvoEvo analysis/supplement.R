### Supplemental analysis

library(tibble)
library(lme4)

remotes::install_github("RemkoDuursma/bootpredictlme4")
library(bootpredictlme4)



blue_tit_prediction_data <- readr::read_csv(here::here("./blue_tit_percentiles_for_supplement_wide.csv"))

glimpse(blue_tit_prediction_data)



all(names(df %>% dplyr::select(-chick_ring_number))  %in% 
      names(blue_tit_prediction_data %>%  dplyr::select(-scenario))) 

all(names(blue_tit_prediction_data %>% dplyr::select(-scenario)) %in% names(df))


names(df[,-39]) == names(blue_tit_prediction_data)    
#[1] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE FALSE FALSE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
#[20]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
# 8, 9, 10

names(blue_tit_prediction_data)[c(8,9,10)] = c("Extra.pair_paternity", "Extra.pair_dad_ring", "genetic_dad_ring_.WP_or_EP.")


### Variable processing matching original
blue_tit_prediction_data$hatch_nest_breed_ID = as.factor(blue_tit_prediction_data$hatch_nest_breed_ID)
blue_tit_prediction_data$rear_nest_breed_ID = as.factor(blue_tit_prediction_data$rear_nest_breed_ID) 
blue_tit_prediction_data$rear_nest_trt = as.factor(blue_tit_prediction_data$rear_nest_trt)

## Which variables were scaled?
psych::describe(df.s)

#v2_scl <- (v2 - attr(v1_scl, 'scaled:center')) / attr(v1_scl, 'scaled:scale')

blue_tit_prediction_data$hatch_year = (blue_tit_prediction_data$hatch_year - attr(df.s$hatch_year, 'scaled:center'))/attr(df.s$hatch_year, 'scaled:scale')
blue_tit_prediction_data$Extra.pair_paternity = (blue_tit_prediction_data$Extra.pair_paternity - attr(df.s$Extra.pair_paternity, 'scaled:center'))/attr(df.s$Extra.pair_paternity, 'scaled:scale')
blue_tit_prediction_data$hatch_nest_CS = (blue_tit_prediction_data$hatch_nest_CS - attr(df.s$hatch_nest_CS, 'scaled:center'))/attr(df.s$hatch_nest_CS, 'scaled:scale')
blue_tit_prediction_data$hatch_nest_OH = (blue_tit_prediction_data$hatch_nest_OH - attr(df.s$hatch_nest_OH, 'scaled:center'))/attr(df.s$hatch_nest_OH, 'scaled:scale')
blue_tit_prediction_data$hatch_nest_LD = (blue_tit_prediction_data$hatch_nest_LD - attr(df.s$hatch_nest_LD, 'scaled:center'))/attr(df.s$hatch_nest_LD, 'scaled:scale')
blue_tit_prediction_data$d0_hatch_nest_brood_size = (blue_tit_prediction_data$d0_hatch_nest_brood_size - attr(df.s$d0_hatch_nest_brood_size, 'scaled:center'))/attr(df.s$d0_hatch_nest_brood_size, 'scaled:scale')
blue_tit_prediction_data$d14_hatch_nest_brood_size = (blue_tit_prediction_data$d14_hatch_nest_brood_size - attr(df.s$d14_hatch_nest_brood_size, 'scaled:center'))/attr(df.s$d14_hatch_nest_brood_size, 'scaled:scale')
blue_tit_prediction_data$home_or_away = (blue_tit_prediction_data$home_or_away - attr(df.s$home_or_away, 'scaled:center'))/attr(df.s$home_or_away, 'scaled:scale')
blue_tit_prediction_data$rear_nest_LD = (blue_tit_prediction_data$rear_nest_LD - attr(df.s$rear_nest_LD, 'scaled:center'))/attr(df.s$rear_nest_LD, 'scaled:scale')
blue_tit_prediction_data$rear_nest_OH = (blue_tit_prediction_data$rear_nest_OH - attr(df.s$rear_nest_OH, 'scaled:center'))/attr(df.s$rear_nest_OH, 'scaled:scale')
blue_tit_prediction_data$rear_nest_CS = (blue_tit_prediction_data$rear_nest_CS - attr(df.s$rear_nest_CS, 'scaled:center'))/attr(df.s$rear_nest_CS, 'scaled:scale')
blue_tit_prediction_data$rear_d0_rear_nest_brood_size = (blue_tit_prediction_data$rear_d0_rear_nest_brood_size - attr(df.s$rear_d0_rear_nest_brood_size, 'scaled:center'))/attr(df.s$rear_d0_rear_nest_brood_size, 'scaled:scale')
blue_tit_prediction_data$rear_Cs_out = (blue_tit_prediction_data$rear_Cs_out - attr(df.s$rear_Cs_out, 'scaled:center'))/attr(df.s$rear_Cs_out, 'scaled:scale')
blue_tit_prediction_data$rear_Cs_in = (blue_tit_prediction_data$rear_Cs_in - attr(df.s$rear_Cs_in, 'scaled:center'))/attr(df.s$rear_Cs_in, 'scaled:scale')
blue_tit_prediction_data$net_rearing_manipulation = (blue_tit_prediction_data$net_rearing_manipulation - attr(df.s$net_rearing_manipulation, 'scaled:center'))/attr(df.s$net_rearing_manipulation, 'scaled:scale')
blue_tit_prediction_data$rear_Cs_at_start_of_rearing = (blue_tit_prediction_data$rear_Cs_at_start_of_rearing - attr(df.s$rear_Cs_at_start_of_rearing, 'scaled:center'))/attr(df.s$rear_Cs_at_start_of_rearing, 'scaled:scale')
blue_tit_prediction_data$d14_rear_nest_brood_size = (blue_tit_prediction_data$d14_rear_nest_brood_size - attr(df.s$d14_rear_nest_brood_size, 'scaled:center'))/attr(df.s$d14_rear_nest_brood_size, 'scaled:scale')
blue_tit_prediction_data$number_chicks_fledged_from_rear_nest = (blue_tit_prediction_data$number_chicks_fledged_from_rear_nest - attr(df.s$number_chicks_fledged_from_rear_nest, 'scaled:center'))/attr(df.s$number_chicks_fledged_from_rear_nest, 'scaled:scale')
blue_tit_prediction_data$Date_of_day14 = (blue_tit_prediction_data$Date_of_day14 - attr(df.s$Date_of_day14, 'scaled:center'))/attr(df.s$Date_of_day14, 'scaled:scale')
blue_tit_prediction_data$day_14_tarsus_length = (blue_tit_prediction_data$day_14_tarsus_length - attr(df.s$day_14_tarsus_length, 'scaled:center'))/attr(df.s$day_14_tarsus_length, 'scaled:scale')
blue_tit_prediction_data$day_14_weight = (blue_tit_prediction_data$day_14_weight - attr(df.s$day_14_weight, 'scaled:center'))/attr(df.s$day_14_weight, 'scaled:scale')
blue_tit_prediction_data$day14_measurer = (blue_tit_prediction_data$day14_measurer - attr(df.s$day14_measurer, 'scaled:center'))/attr(df.s$day14_measurer, 'scaled:scale')
blue_tit_prediction_data$chick_sex_molec = (blue_tit_prediction_data$chick_sex_molec - attr(df.s$chick_sex_molec, 'scaled:center'))/attr(df.s$chick_sex_molec, 'scaled:scale')
blue_tit_prediction_data$chick_survival_to_first_breed_season = (blue_tit_prediction_data$chick_survival_to_first_breed_season - attr(df.s$chick_survival_to_first_breed_season, 'scaled:center'))/attr(df.s$chick_survival_to_first_breed_season, 'scaled:scale')


# hatch_year
# Extra.pair_paternity
# hatch_nest_CS                        
# hatch_nest_OH                        
# hatch_nest_LD                        
# d0_hatch_nest_brood_size             
# d14_hatch_nest_brood_size
# home_or_away                         
# rear_nest_LD                         
# rear_nest_CS                         
# rear_nest_OH       
# rear_d0_rear_nest_brood_size         
# rear_Cs_out                          
# rear_Cs_in                           
# net_rearing_manipulation             
# rear_Cs_at_start_of_rearing          
# d14_rear_nest_brood_size             
# number_chicks_fledged_from_rear_nest 
# Date_of_day14                        
# day_14_tarsus_length                 
# day_14_weight                        
# day14_measurer                       
# chick_sex_molec                      
# chick_survival_to_first_breed_season



### Fit models
lme.t.reduce.test = lmer(day_14_tarsus_length ~ 
                           rear_Cs_at_start_of_rearing + net_rearing_manipulation + chick_sex_molec +
                           net_rearing_manipulation*I(hatch_nest_LD^2) +
                           d14_rear_nest_brood_size + Date_of_day14 +
                           I(net_rearing_manipulation^2) +
                           + (1|day14_measurer) + (1|rear_area)
                         , data=test
)

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



### Predictions

pred.t = predict(lme.t.reduce.test, 
                 newdata = blue_tit_prediction_data, 
                 type = "link", se.fit = TRUE, nsim = 1000)

pred.w = predict(lme.w.reduce.test, 
                 newdata = blue_tit_prediction_data, 
                 type = "link", se.fit = TRUE, nsim = 1000)


#v2_scl <- (v2 - attr(v1_scl, 'scaled:center')) / attr(v1_scl, 'scaled:scale')


## Tarsus 

#pred.t$fit = pred.t$fit*attr(df.s$day_14_tarsus_length, 'scaled:scale') + attr(df.s$day_14_tarsus_length, 'scaled:center')
pred.t$ci.fit = pred.t$ci.fit*attr(df.s$day_14_tarsus_length, 'scaled:scale') + attr(df.s$day_14_tarsus_length, 'scaled:center')

preds.df = data.frame(scenario=integer(3), fit=numeric(3), lwr=numeric(3), upr=numeric(3), std.err=numeric(3))
preds.df$scenario = 1:3
preds.df$fit = pred.t$fit*attr(df.s$day_14_tarsus_length, 'scaled:scale') + attr(df.s$day_14_tarsus_length, 'scaled:center')
preds.df$lwr = pred.t$ci.fit[1,]
preds.df$upr = pred.t$ci.fit[2,]
preds.df$std.err = pred.t$se.boot

#preds.df

preds.df %>% 
  dplyr::mutate(scenario = c(1:3)) %>% 
  dplyr::rename(ci.low = lwr, ci.hi = upr, estimate = fit) %>%
  readr::write_csv(file = "tarsus_predictions.csv")



## Weight

pred.w$ci.fit = pred.w$ci.fit*attr(df.s$day_14_weight, 'scaled:scale') + attr(df.s$day_14_weight, 'scaled:center')

preds.df = data.frame(scenario=integer(3), fit=numeric(3), lwr=numeric(3), upr=numeric(3), std.err=numeric(3))
preds.df$scenario = 1:3
preds.df$fit = pred.w$fit*attr(df.s$day_14_weight, 'scaled:scale') + attr(df.s$day_14_weight, 'scaled:center')
preds.df$lwr = pred.w$ci.fit[1,]
preds.df$upr = pred.w$ci.fit[2,]
preds.df$std.err = pred.w$se.boot

preds.df

preds.df %>% 
  dplyr::mutate(scenario = c(1:3)) %>% 
  dplyr::rename(ci.low = lwr, ci.hi = upr, estimate = fit) %>%
  readr::write_csv(file = "weight_predictions.csv")



### Effect size calculations

# If you used any mixed modelling approaches including glmm (e.g. Poisson, binomial, zero-inflated), 
# please follow the instruction below to obtain adjusted df using the Satterthwaite approximation.

library(lmerTest)
library(parameters)


lmertest.t.reduce.test = lmerTest::lmer(day_14_tarsus_length ~ 
                           rear_Cs_at_start_of_rearing + net_rearing_manipulation + chick_sex_molec +
                           net_rearing_manipulation*I(hatch_nest_LD^2) +
                           d14_rear_nest_brood_size + Date_of_day14 +
                           I(net_rearing_manipulation^2) +
                           + (1|day14_measurer) + (1|rear_area)
                         , data=test
)

lmertest.w.reduce.test = lmerTest::lmer(day_14_weight ~ 
                           rear_Cs_at_start_of_rearing + net_rearing_manipulation +
                           chick_sex_molec + 
                           I(hatch_nest_LD^2)*net_rearing_manipulation +
                           d14_rear_nest_brood_size + 
                           I(rear_Cs_at_start_of_rearing^2) +
                           rear_nest_LD*rear_Cs_at_start_of_rearing + 
                           + (1|day14_measurer) + (1|rear_area)
                         , data=test
)

# tarsus:
summary(lmertest.t.reduce.test)$coef[,3]

# weight:
summary(lmertest.w.reduce.test)$coef[,3]

# net_rearing_manipulation

