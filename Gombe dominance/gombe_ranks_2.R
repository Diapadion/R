### Initial examination of ranks, 29 Oct 2014
library(ggplot2)
library(lme4)
library(lmerTest)

# Read in and merge rank and HPQ data
rank <- read.csv(file="male_ranks_2-yr_AGE.csv")
load(file="../gombe_personality.RData")

merged_df <- merged_data[(merged_data$chimp_id %in% rank$ID),]

# Standardizing personality predictors
merged_df$z_dom <- as.numeric(scale(merged_df$dominance_2009))
merged_df$z_ext <- as.numeric(scale(merged_df$extraversion_2009))
merged_df$z_con <- as.numeric(scale(merged_df$conscientiousness_2009))
merged_df$z_agr <- as.numeric(scale(merged_df$agreeableness_2009))
merged_df$z_neu <- as.numeric(scale(merged_df$neuroticism_2009))
merged_df$z_opn <- as.numeric(scale(merged_df$openness_2009))

# Extracting only usable cases, i.e. no missing data on the predictors
# or DV
df <- merge(rank,merged_df,by.x="ID",by.y="chimp_id",all.x=T)

df <- df[complete.cases(df[,c("M_Age_Mid", "dominance_2009",
                              "extraversion_2009",
                              "conscientiousness_2009",
                              "agreeableness_2009",
                              "neuroticism_2009", "openness_2009",
                              "JTF_NormMDS")]),]

# Centering and scaling age
df$ct_age <- as.numeric(scale(df$M_Age_Mid))

# Mixed effects models
mal_mds_a <- lmer(data=df,JTF_NormMDS ~ (1 | ID))

mal_mds_b <- lmer(data=df,JTF_NormMDS ~ ct_age + (1 | ID))

mal_mds_c <- lmer(data=df,JTF_NormMDS ~ ct_age + I(ct_age^2) + (1 | ID))

mal_mds_d <- lmer(data=df,JTF_NormMDS ~ ct_age + I(ct_age^2) + (1 +
                      ct_age | ID))

mal_mds_e <- lmer(data=df,JTF_NormMDS ~ ct_age + I(ct_age^2) + (1 +
                      I(ct_age^2) | ID))

mal_mds_f_zoo2 <- lmer(data=df,JTF_NormMDS ~ ct_age + I(ct_age^2)*
                       (z_dom + z_ext + z_con + z_agr + z_neu + z_opn)
                       + (1 + I(ct_age^2) | ID))

### Plotting
## Convenience function by Mark Adams for calculating .5 SD below and
## above the mean for the significant fixed effects
sd_plusminus <- function(x) {
  m <- mean(x, na.rm=T)
  s <- sd(x, na.rm=T)
  return(c(m-(.5*s), m, m+(.5*s)))
}

# Create new dataframe for plotting that contains all of the fixed
# effects variables. Non-significant fixed effects are set to their
# mean (0 in this case as they are standardized). Also contains a
# place holder for the David Scores variable
newdf <-
    expand.grid(z_dom=sd_plusminus(df$z_dom), z_ext=mean(df$z_ext),
                z_con=mean(df$z_con), z_agr=sd_plusminus(df$z_agr),
                z_neu=mean(df$z_neu), z_opn=mean(df$z_opn),
                ct_age=seq(min(df$ct_age), max(df$ct_age), by = .1),
                JTF_NormMDS=0)

# Manually obtaining predicted scores. This is used instead of
# predict() which has no easy way of providing CIs.
# Code from: http://stats.stackexchange.com/questions/60448/confidence-intervals-for-glmer-from-lme4
mm <- model.matrix(terms(mal_mds_f_zoo2),newdf)
newdf$JTF_NormMDS <- mm %*% fixef(mal_mds_f_zoo2)
pvar1 <- diag(mm %*% tcrossprod(vcov(mal_mds_f_zoo2),mm))
tvar1 <- pvar1+VarCorr(mal_mds_f_zoo2)$ID[1] # Warning: must be adapted for more complex models
# I assume the above warning refers to cases in which there are more random effects

# Generate and add CIs to new dataframe. This is also taken from the
# example cited above.
newdf <- data.frame(
    newdf
    , plo = newdf$JTF_NormMDS-2*sqrt(pvar1)
    , phi = newdf$JTF_NormMDS+2*sqrt(pvar1)
    , tlo = newdf$JTF_NormMDS-2*sqrt(tvar1)
    , thi = newdf$JTF_NormMDS+2*sqrt(tvar1)
)

# Label fixed effects (z_dom and z_agr in this case)
newdf <- transform(newdf, z_dom=factor(z_dom,
                              labels=c('Low Dominance',
                                  'Average Dominance', 'High Dominance')))

newdf <- transform(newdf, z_agr=factor(z_agr,
                              labels=c('Low Agreeableness',
                                  'Average Agreeableness', 'High Agreeableness')))

# Plot using ggplot. Changed from stackexchange example. Here I am using the
# ribbon function instead as it's more aesthetically pleasing.
g0 <- ggplot(newdf, aes(x=ct_age*(sd(df$M_Age_Mid))+(mean(df$M_Age_Mid)), y=JTF_NormMDS)) + geom_line() +
    facet_grid(z_dom ~ z_agr)

g0 <- g0 + geom_ribbon(aes(ymin = plo, ymax = phi), alpha = .25)

g0 <- g0 + xlab("Age")+ylab("Rank (Modified David Scores)")

g0 <- g0 + theme_bw() + theme(panel.grid.major = element_line(color='gray'),panel.grid.minor = element_blank())

g0 <- g0 + geom_vline(xintercept=mean(df$M_Age_Mid),linetype="dashed")

g0 <- g0 + theme(text = element_text(size=14))

# g0 + theme(strip.background = element_rect(fill = "white"))

ggsave(g0,file="male_plot_4_nov_2014.pdf",height=14,width=14)

ggsave(g0,file="male_plot_4_nov_2014.png",height=14,width=14)

# Uncertainty here is defined as the sum of fixed and random effects uncertainty

#g0 + geom_errorbar(aes(ymin = tlo, ymax = thi))+
#    labs(title="CI based on FE uncertainty + RE variance")

## Profiles of Frodo, Freud, and Wilky
# Get T-scores for personality measures in whole sample

profiles <- merged_data[merged_data$gender==1,]

profiles$t_dom <- scale(profiles$dominance_2009)*10+50
profiles$t_agr <- scale(profiles$agreeableness_2009)*10+50

profiles[profiles$chimp_id=="WL"|profiles$chimp_id=="FD"|profiles$chimp_id=="FR",c("chimp_id","t_dom","t_agr"),]
