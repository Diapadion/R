### Models of Chimpanzee facial characteristics, age, sex, and personality

library(lme4)
library(car)
library(corrplot)
library(plyr)

s <- function(x) {scale(x)}



### loading in composite sheet

chFP = read.csv('chimpFacesPersDemos.csv')
chFP = chFP[,-1]


### zero-order correlation peek

colnames(chFP)
corrplot(cor(chFP[,c(8,12,13,14,15,16,17),],use="pairwise.complete.obs")
  ,  method = 'number')

corrplot(cor(chFP[chFP$Sex==0,c(8,12,13,14,15,16,17),],use="pairwise.complete.obs"),  method = 'number')
corrplot(cor(chFP[chFP$Sex==1,c(8,12,13,14,15,16,17),],use="pairwise.complete.obs"),  method = 'number')
# These are useful for interpretation later - note pattern of correlations among D, N, & C



### Mixed Effect Models

## Collapse subspecies random effects
levels(chFP$Subspecies)
chFP$Subspecies[chFP$Subspecies=='hybrid'] = 'unknown'

chFP$Subspecies[chFP$Subspecies=='unknown'] = NA



## Base: just subspecies random effects

m0 <- lmer(fWHR ~ 1 +
             (1 | location) + (1 | Subspecies) + (1 | ID:Subspecies)
           ,data=chFP
           )
summary(m0)
confint(m0,method='profile')

ranef(m0)



## Age and Age squared, cubed

m1 <- lmer(fWHR ~ s(Age) + s(I(Age^2)) + s(I(Age^3)) +
             (1 | location) + (1 | Subspecies) + (1 | ID:Subspecies)
           ,data = chFP
           )
summary(m1)
confint(m1, method='profile')

# No age effects. Could it be due to oversampling of older individuals? Does it matter?

# Main question - to include any age variables in later models?
# Hard to justify including Age but not the others, if we include any at all.



m2 <- lmer(fWHR ~ Age*Sex +
             (1 | location) + (1 | Subspecies) + (1 | ID:Subspecies)
           ,data = chFP
           )
summary(m2)
confint(m2, method='profile')

# Again, nothing. Yet more difficult to keep including these.



### Personality

mp1 <- lmer(fWHR ~ Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ +
              (1 | location) + (1 | Subspecies) + (1 | ID:Subspecies)
            ,data = chFP
            )
summary(mp1)
confint(mp1, method='profile')

# Nothing across the whole sample,
# but given what we know about T and sex diffs ala LeFevre et al. 2013, EaHB...



## Split by sex

mp2.f <- lmer(fWHR ~ Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ +
                (1 | location) + (1 | Subspecies) + (1 | ID:Subspecies)
            ,data = chFP[chFP$Sex==0,])

mp2.m <- lmer(fWHR ~ Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ +
                (1 | location) + (1 | Subspecies) + (1 | ID:Subspecies)
              ,data = chFP[chFP$Sex==1,])

summary(mp2.f)
summary(mp2.m)

confint(mp2.f, method='profile')
confint(mp2.m, method='profile')

# Dominance associates in females
# Neuroticism associates (negatively) in males



## Dividing by (major) subspecies

count(chFP$Subspecies)


mp3.t = lmer(fWHR ~ Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ +
               (1 | location) + (1 | ID)
             ,data = chFP[chFP$Subspecies=='troglodytes',])

mp3.v = lmer(fWHR ~ Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ +
               (1 | location) + (1 | ID)
             ,data = chFP[chFP$Subspecies=='verus',])

# # Worth doing for unknowns?
# mp3.u = lmer(fWHR ~ Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ +
#                (1 | location) + (1 | ID)
#              ,data = chFP[is.na(chFP$Subspecies),])
# summary(mp3.u) # Nothing.

summary(mp3.t)
summary(mp3.v)

confint(mp3.t, method='boot')
confint(mp3.v, method='profile')

# In Verus, low C and low N (which are neg corr'd) are both neg associated with fWHR



## Verus is the only subspecies with reasonable sample size

mp4.f = lmer(fWHR ~ Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ +
               (1 | location) + (1 | ID)
             ,data = chFP[(chFP$Subspecies=='verus'&chFP$Sex==0),])

mp4.m = lmer(fWHR ~ Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ +
               (1 | location) + (1 | ID)
             ,data = chFP[(chFP$Subspecies=='verus'&chFP$Sex==1),])

summary(mp4.f)
summary(mp4.m)

confint(mp4.f, method='profile')
confint(mp4.m, method='profile')

# This confirms the + assoc /w D unique to females, it actually appears to be - in males;
# - assoc /w N being more driven by males
# - assoc /w C stronger in females, needs both to reach significance




