



mm.creat <- lmer(Creatine ~ sex + s(DoB) #+ age + age2 
             + chimp_Dom_CZ + chimp_Opn_CZ + chimp_Con_CZ 
             + chimp_Neu_CZ + chimp_Ext_CZ + chimp_Agr_CZ 
             #Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion
             + (1|chimp),
             data = fullcast[!is.na(fullcast$Creatine),])
summary(mm.creat)


mm.wbc <- lmer(wbc ~ sex + s(DoB) #+ age + age2 
                 + chimp_Dom_CZ + chimp_Opn_CZ + chimp_Con_CZ 
                 + chimp_Neu_CZ + chimp_Ext_CZ + chimp_Agr_CZ 
                 #Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion
                 + (1|chimp),
                 data = fullcast)
summary(mm.wbc)

mm.rbc <- lmer(rbc ~ sex + s(DoB) #+ age + age2 
               + chimp_Dom_CZ + chimp_Opn_CZ + chimp_Con_CZ 
               + chimp_Neu_CZ + chimp_Ext_CZ + chimp_Agr_CZ 
               #Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion
               + (1|chimp),
               data = fullcast)
summary(mm.rbc)


mm.lymph <- lmer(lymph ~ sex + s(DoB) #+ age + age2 
               + chimp_Dom_CZ + chimp_Opn_CZ + chimp_Con_CZ 
               + chimp_Neu_CZ + chimp_Ext_CZ + chimp_Agr_CZ 
               #Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion
               + (1|chimp),
               data = fullcast)
summary(mm.lymph)


mm.monos <- lmer(monos ~ sex + s(DoB) #+ age + age2 
               + chimp_Dom_CZ + chimp_Opn_CZ + chimp_Con_CZ 
               + chimp_Neu_CZ + chimp_Ext_CZ + chimp_Agr_CZ 
               #Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion
               + (1|chimp),
               data = fullcast)
summary(mm.monos)


mm.eos <- lmer(eos ~ sex + s(DoB) #+ age + age2 
               + chimp_Dom_CZ + chimp_Opn_CZ + chimp_Con_CZ 
               + chimp_Neu_CZ + chimp_Ext_CZ + chimp_Agr_CZ 
               #Openness + Agreeableness + Conscientiousness + Neuroticism + Extraversion
               + (1|chimp),
               data = fullcast)
summary(mm.eos)



