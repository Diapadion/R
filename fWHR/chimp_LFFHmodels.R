### Models of Chimpanzee facial characteristics, age, sex, and personality

library(lme4)
library(car)
library(corrplot)
library(plyr)
library(numDeriv)
library(RCurl)
library(optimx)
library(lmtest)



s <- function(x) {scale(x)}



### loading in composite sheet

chFP = read.csv('chimpFacesPersDemos.csv')
chFP = chFP[,-1]

chFP = chFP[!is.na(chFP$lffh),]



### zero-order correlation peek

colnames(chFP)
corrplot(cor(chFP[,c(8,13,14,15,16,17,18),],use="pairwise.complete.obs")
  ,  method = 'number')

corrplot(cor(chFP[chFP$Sex==0,c(8,13,14,15,16,17,18),],use="pairwise.complete.obs"),  method = 'number')
corrplot(cor(chFP[chFP$Sex==1,c(8,13,14,15,16,17,18),],use="pairwise.complete.obs"),  method = 'number')



### Mixed Effect Models

## Collapse subspecies random effects
levels(chFP$Subspecies)
chFP$Subspecies[chFP$Subspecies=='hybrid'] = 'unknown'
table(chFP$Subspecies)
table(chFP$Sex[chFP$Subspecies=='verus'])

#chFP$Subspecies[chFP$Subspecies=='unknown'] = NA # DO NOT RUN



## Base: just subspecies random effects

m0.lf <- lmer(lffh ~ 1 +
             (1 | location) + (1 | Subspecies) + (1 | ID:Subspecies)
           ,data=chFP[adults,]
           #,data = chFP[chFP$Age>7,]
           )
summary(m0.lf)
confint(m0.lf,method='profile')

ranef(m0.lf)



## basic age,sex index:
# adults = (chFP$Sex==0 & chFP$Age>7) | (chFP$Sex==1 & chFP$Age>9) | (chFP$ID == 'Gage')
# adults[is.na(adults)] = TRUE
## Adults is generated from fWHR model file



## Age and Age squared, cubed

m1.1.lf <- lmer(lffh ~ s(Age) +
             (1 | location) + (1 | Subspecies) + (1 | ID:Subspecies)
           #,data = chFP
           ,data = chFP[adults,]
           )
m1.2.lf <- lmer(lffh ~ s(Age) + s(I(Age^2)) +
                (1 | location) + (1 | Subspecies) + (1 | ID:Subspecies)
              #,data = chFP
              ,data = chFP[adults,]
)
anova(m1.1.lf,m1.2.lf)
# Adding the squared term doesn't add parsimonious value.

summary(m1.1.lf)
confint(m1.1.lf, method='profile')

# Strong positive effect of age.



m2.lf <- lmer(lffh ~ s(Age) + Sex +
             (1 | location) + (1 | Subspecies) + (1 | ID:Subspecies)
           #,data = chFP
           ,data = chFP[adults,]
           )
summary(m2.lf)

m2.lf.i <- lmer(lffh ~ s(Age) * Sex +
                (1 | location) + (1 | Subspecies) + (1 | ID:Subspecies)
              #,data = chFP
              ,data = chFP[adults,]
)
summary(m2.lf.i)

anova(m2.lf,m2.lf.i)

# Interestingly, strong drive by the interaction.

m2.lf.i0 <- lmer(lffh ~ s(Age) : Sex +
                  (1 | location) + (1 | Subspecies) + (1 | ID:Subspecies)
                #,data = chFP
                ,data = chFP[adults,]
)
summary(m2.lf.i0)

anova(m2.lf,m2.lf.i,m2.lf.i0)

# This is not as straight-forward to interpret, but the best model includes 
# only the age-sex interaction term, but no independent age or sex contribution.



### Personality

mp1.lf <- lmer(lffh ~ s(Age):Sex + Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ +
              (1 | location) + (1 | Subspecies) + (1 | ID:Subspecies)
            #,data = chFP
            ,data = chFP[adults,]
            )
summary(mp1.lf)
confint(mp1.lf, method='profile')

# Nothing across the whole sample.



## Split by sex

mp2.f.lf <- lmer(lffh ~ Age + Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ +
                (1 | location) + (1 | Subspecies) + (1 | ID:Subspecies)
            #,data = chFP[chFP$Sex==0,]
            ,data = chFP[adults&chFP$Sex==0,]
            )

mp2.m.lf <- lmer(lffh ~ Age + Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ +
                (1 | location) + (1 | ID:Subspecies) + (1 | Subspecies)
              #,data = chFP[chFP$Sex==1,]
              ,data = chFP[adults&chFP$Sex==1,]
            )


summary(mp2.f.lf)
summary(mp2.m.lf)

confint(mp2.f.lf, method='profile')
confint(mp2.m.lf, method='profile')

# Extraversion associates in females
# Dominance associates (negatively) in males



## Dividing by (major) subspecies

count(chFP$Subspecies)


mp3.t.lf = lmer(lffh ~ Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ + #Age:Sex +
               (1 | location) + (1 | ID)
             #,data = chFP[chFP$Subspecies=='troglodytes',]
             ,data = chFP[adults&chFP$Subspecies=='troglodytes',]
             ) # The Age:Sex interaction makes the model intractable, so it has to be omitted. Not sure what else to do about that...
        

mp3.v.lf = lmer(lffh ~ Age:Sex + Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ +
               (1 | location) + (1 | ID)
             #,data = chFP[chFP$Subspecies=='verus',]
             ,data = chFP[adults&chFP$Subspecies=='verus',]
             )

# # Worth doing for unknowns?
# mp3.u = lmer(fWHR ~ Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ +
#                (1 | location) + (1 | ID)
#              ,data = chFP[is.na(chFP$Subspecies),])
# summary(mp3.u) # Nothing.

summary(mp3.t.lf) # Nothing for troglodytes.
summary(mp3.v.lf)

confint(mp3.v.lf, method='profile')

# In Verus, maybe something for N, but it is extremely borderline.



## Verus is the only subspecies with reasonable sample size

mp4.f.lf = lmer(lffh ~ Age + Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ +
               (1 | location) + (1 | ID)
             ,data = chFP[adults&(chFP$Subspecies=='verus'&chFP$Sex==0),]
             ,control=lmerControl(optimizer="Nelder_Mead")
             )

summary(mp4.f.lf)
summary(mp4.m.lf)

confint(mp4.f.lf, method='profile')
confint(mp4.m.lf, method='profile')

# Again, if anything, there is this negative D association in males.



### Leftover code for checking & debugging models

# # Covergence checks
# tt <- getME(mp4.f,"theta")
# ll <- getME(mp4.f,"lower")
# min(tt[ll==0]) # not terrible, but not ideal either
# 
# derivs1 <- mp4.f@optinfo$derivs
# sc_grad1 <- with(derivs1,solve(Hessian,gradient))
# max(abs(sc_grad1)) # Fine
# max(pmin(abs(sc_grad1),abs(derivs1$gradient))) # The same - fine.
# 
# mp4.m.lf = lmer(lffh ~ Age + Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ +
#                   (1 | location) + (1 | ID)
#                 ,data = chFP[adults&(chFP$Subspecies=='verus'&chFP$Sex==1),]
# )
# 
# 
# # Trying different optimizers for females model
# 
# afurl <- "https://raw.githubusercontent.com/lme4/lme4/master/inst/utils/allFit.R"
# eval(parse(text=getURL(afurl)))
# 
# aa <- allFit(mp4.f)
# is.OK <- sapply(aa,is,"merMod")
# aa.OK <- aa[is.OK]
# lapply(aa.OK,function(x) x@optinfo$conv$lme4$messages)
# (lliks <- sort(sapply(aa.OK,logLik)))
# # Any of these seem like they would work in theory
# 
# mp4.f.2 <- update(mp4.f,start=ss,control=lmerControl(optimizer="Nelder_Mead"#,
#                                            #optCtrl=list(maxiter=2e5)
#                                            ))
# summary(mp4.f)
# confint(mp4.f.2, method='profile')
# confint(mp4.f.2, method='boot')
# # Nelder-Mead seems to work the best
# # Has been reincorporated above.
# 
# 
# 
# # VERUS
# # The + assoc /w D in females is not very strong, it actually appears to be greater and - in males;
# # - assoc /w N being more driven by males
# # - assoc /w C stronger in females, needs both to reach significance.
# 
# 
# 
# # TROGLODYTES
# # Nothing there, sample is too small.
# 
# # mp5.f = lmer(fWHR ~ Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ +
# #                (1 | location) + (1 | ID)
# #              ,data = chFP[indx&(chFP$Subspecies=='troglodytes'&chFP$Sex==0),]
# # )
# #
# # mp5.m = lmer(fWHR ~ Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ +
# #                (1 | ID)
# #              ,data = chFP[indx&(chFP$Subspecies=='troglodytes'&chFP$Sex==1),]
# # )
# #
# # summary(mp5.f)
# # summary(mp5.m)


