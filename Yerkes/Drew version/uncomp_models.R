# fresh take on regressions, using 'fullcast', from make_data.R & uncompressed_make.R


### NOTE / TODO - is this necessary or even working?
fullcast$chimp <- as.factor(fullcast$chimp)


#attach(fullcast)

model_t <- lmer(diastolic ~ ageDays + sex + BMI
                  +chimp_Agr_CZ+chimp_Con_CZ+chimp_Dom_CZ+chimp_Ext_CZ+chimp_Neu_CZ+chimp_Opn_CZ
                + (1 | chimp), data = fullcast
                )

model_t1 <- lmer(systolic ~ sex + BMI + (1 | chimp), data = fullcast)

model_t2 <- lmer(systolic ~ chimp_Agr_CZ + chimp_Con_CZ + chimp_Dom_CZ + chimp_Ext_CZ
                 + (1 | chimp) + (1 | ageDays), data = fullcast)


model_t2 <- lmer(systolic ~ chimp_Agr_CZ + chimp_Con_CZ + chimp_Dom_CZ + chimp_Ext_CZ
                 + (ageDays | chimp), data = fullcast)


model_t3 <- lmer(systolic ~ sex + BMI
                 + cholesterol 
                # + triglycerides + Glucose + wbc + monos + lymph
               #  + chimp_Agr_CZ+chimp_Con_CZ+chimp_Dom_CZ+chimp_Ext_CZ+chimp_Neu_CZ+chimp_Opn_CZ                 
               #  + (1 | chimp               
               + (1 | triglycerides)
              #   + (1+cholesterol+triglycerides+Glucose+wbc+monos+lymph | ageDays), data = fullcast
              )



model_t4 <- lm(cholesterol ~ sex + BMI
                 +chimp_Agr_CZ+chimp_Con_CZ+chimp_Dom_CZ+chimp_Ext_CZ+chimp_Neu_CZ+chimp_Opn_CZ                 
                # + (1 | chimp)
               , na.action = na.omit
               ) 



model_t5 <- lmer(
  #cholesterol 
  #Glucose
  #monos
  wbc
  #diastolic
  ~ sex + BMI + DoB
               +chimp_Agr_CZ+chimp_Con_CZ+chimp_Dom_CZ+chimp_Ext_CZ+chimp_Neu_CZ+chimp_Opn_CZ                 
               + (1 | chimp), data = fullcast
)
Anova(model_t5)




model_t6 <- lmer(
  diastolic ~ sex + BMI + DoB
  +chimp_Agr_CZ+chimp_Con_CZ+chimp_Dom_CZ+chimp_Ext_CZ+chimp_Neu_CZ+chimp_Opn_CZ
  + (1 | chimp) 
  )
summary(model_t6)



#model_t7 <- lm(Glucose ~ cholesterol + triglycerides, na.action = na.omit)

model_t7 <- lmer(
  Glucose ~ sex + BMI
  +chimp_Agr_CZ+chimp_Con_CZ+chimp_Dom_CZ+chimp_Ext_CZ+chimp_Neu_CZ+chimp_Opn_CZ
  + (1 | chimp) 
)

summary(model_t7)

  
  
  




#detach(fullcast)


