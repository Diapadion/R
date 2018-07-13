library(mgcv)
library(lme4)
library(gamm4)
library(caret)

load("df_hpq_elo_encoded.Rdata")


View(df_hpq_elo_encoded)
colnames(df_hpq_elo_encoded)

df_hpq_elo_encoded$Date = as.Date(df_hpq_elo_encoded$Date)
hist(df_hpq_elo_encoded$Date, 30)

df_hpq_elo_encoded$time = as.numeric(df_hpq_elo_encoded$Date) 
min(df_hpq_elo_encoded$time)
df_hpq_elo_encoded$time = df_hpq_elo_encoded$time - 2955
hist(df_hpq_elo_encoded$time)

df_hpq_elo_encoded$Dom_cz = scale(df_hpq_elo_encoded$dominance)
df_hpq_elo_encoded$Ext_cz = scale(df_hpq_elo_encoded$extraversion)
df_hpq_elo_encoded$Con_cz = scale(df_hpq_elo_encoded$conscientiousness)
df_hpq_elo_encoded$Neu_cz = scale(df_hpq_elo_encoded$neuroticism)
df_hpq_elo_encoded$Agr_cz = scale(df_hpq_elo_encoded$agreeableness)
df_hpq_elo_encoded$Opn_cz = scale(df_hpq_elo_encoded$openness)

df_hpq_elo_encoded$time_cz = scale(df_hpq_elo_encoded$time)
df_hpq_elo_encoded$time2_cz = scale(df_hpq_elo_encoded$time^2)



set.seed(123)
parts = createDataPartition(df_hpq_elo_encoded$chimpcode, 20)

df_sub = df_hpq_elo_encoded[parts$Resample01,]






mt1 = lmer(Elo ~ time_cz + time2_cz * (Dom_cz + Ext_cz + Neu_cz + 
                           Agr_cz + Con_cz + Opn_cz)
           + (1 + time_cz | chimpcode)
           , data=df_sub
)

           
gammt1 = gamm4(Elo ~ time_cz + time2_cz * (Dom_cz + Ext_cz + Neu_cz + 
                                          Agr_cz + Con_cz + Opn_cz)
     , random=~(1|chimpcode)

     , data=df_sub
)



mt2 = lmer(Elo ~ date + I(date^2))


summary(mt1)
