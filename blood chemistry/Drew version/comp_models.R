
#aggador <- aggregate(fullcast, by = list("chimp"), FUN=mean, na.action=na.omit)





aggador <- aggregate(fullcast, by = list(fullcast$chimp), FUN=mean, na.rm=TRUE)
warnings()


attach(aggador)

# agtest <- fullcast[1:30,c(1,2,3)]
# agout <- aggregate(agtest, by = list(agtest$chimp), FUN=mean)
# 
# agout <- mean(agtest$Glucose, na.rm=TRUE)
# 
# aggador <- aggregate(cbind(fullcast$, by = list(fullcast$chimp), FUN=mean, na.action=na.omit)
                     


model_s <- lmer(systolic ~  sex + BMI
                +chimp_Agr_CZ+chimp_Con_CZ+chimp_Dom_CZ+chimp_Ext_CZ+chimp_Neu_CZ+chimp_Opn_CZ
                + (1 | chimp) + (1 | ageDays), data = fullcast
)


model_s1 <- lmer(systolic ~ sex + BMI + (1 | chimp), data = fullcast)


model_s2 <- lmer(cholesterol ~ sex + BMI
                 +chimp_Agr_CZ+chimp_Con_CZ+chimp_Dom_CZ+chimp_Ext_CZ+chimp_Neu_CZ+chimp_Opn_CZ                 
                 + (1 | chimp)) 
                     
detach(aggador)



### Complete Case Analysis


# ccag <- aggador[,c(-2,-47)]

ccag <- aggador[,c(1,3,43,49,52,53:104)]

ccag <- ccag[complete.cases(ccag),]

colnames(ccag)[1] <- "chimp"


attach(ccag)

modelcc1 <- lmer(diastolic ~  sex + BMI + DoB
                 +chimp_Agr_CZ+chimp_Con_CZ+chimp_Dom_CZ+chimp_Ext_CZ+chimp_Neu_CZ+chimp_Opn_CZ
                 + (1 | chimp), data = fullcast
)

summary(modelcc1)




detach(ccag)

