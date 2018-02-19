### Models of Chimpanzee facial characteristics, age, sex, and personality

library(lme4)
library(car)
library(corrplot)
library(plyr)
library(numDeriv)
library(RCurl)
library(optimx)



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
table(chFP$Subspecies)
table(chFP$Sex[chFP$Subspecies=='verus'])

#chFP$Subspecies[chFP$Subspecies=='unknown'] = NA # DO NOT RUN



## Base: just subspecies random effects

m0 <- lmer(fWHR ~ 1 +
             (1 | location) + (1 | Subspecies) + (1 | ID:Subspecies)
           ,data=chFP
           #,data = chFP[chFP$Age>7,]
           )
summary(m0)
confint(m0,method='profile')

ranef(m0)



# basic age,sex index:
indx = (chFP$Sex==0 & chFP$Age>7) | (chFP$Sex==1 & chFP$Age>9) | (chFP$ID == 'Gage')
indx[is.na(indx)] = TRUE



## Age and Age squared, cubed

m1 <- lmer(fWHR ~ s(Age) + s(I(Age^2)) + s(I(Age^3)) +
             (1 | location) + (1 | Subspecies) + (1 | ID:Subspecies)
           #,data = chFP
           ,data = chFP[indx,]
           )
summary(m1)
confint(m1, method='profile')

# No age effects. Could it be due to oversampling of older individuals? Does it matter?

# Main question - to include any age variables in later models?
# Hard to justify including Age but not the others, if we include any at all.



m2 <- lmer(fWHR ~ Age*Sex +
             (1 | location) + (1 | Subspecies) + (1 | ID:Subspecies)
           #,data = chFP
           ,data = chFP[indx,]
           )
summary(m2)
confint(m2, method='profile')

# Again, nothing. Yet more difficult to keep including these.



### Personality

mp1 <- lmer(fWHR ~ Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ +
              (1 | location) + (1 | Subspecies) + (1 | ID:Subspecies)
            #,data = chFP
            ,data = chFP[indx,]
            )
summary(mp1)
confint(mp1, method='profile')

# Nothing across the whole sample,
# but given what we know about T and sex diffs ala LeFevre et al. 2013, EaHB...



## Split by sex

mp2.f <- lmer(fWHR ~ Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ +
                (1 | location) + (1 | Subspecies) + (1 | ID:Subspecies)
            #,data = chFP[chFP$Sex==0,]
            ,data = chFP[indx&chFP$Sex==0,]
            )

mp2.m <- lmer(fWHR ~ Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ +
                (1 | location) + (1 | ID:Subspecies) + (1 | Subspecies)
              #,data = chFP[chFP$Sex==1,]
              ,data = chFP[indx&chFP$Sex==1,]
            )


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
             #,data = chFP[chFP$Subspecies=='troglodytes',]
             ,data = chFP[indx&chFP$Subspecies=='troglodytes',]
             )
        

mp3.v = lmer(fWHR ~ Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ +
               (1 | location) + (1 | ID)
             #,data = chFP[chFP$Subspecies=='verus',]
             ,data = chFP[indx&chFP$Subspecies=='verus',]
             )

# # Worth doing for unknowns?
# mp3.u = lmer(fWHR ~ Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ +
#                (1 | location) + (1 | ID)
#              ,data = chFP[is.na(chFP$Subspecies),])
# summary(mp3.u) # Nothing.

summary(mp3.t) # Nothing for troglodytes.
summary(mp3.v)

confint(mp3.t, method='Wald')
confint(mp3.v, method='profile')

# In Verus, low C and low N (which are neg corr'd) are both neg associated with fWHR



## Verus is the only subspecies with reasonable sample size

mp4.f = lmer(fWHR ~ Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ +
               (1 | location) + (1 | ID)
             ,data = chFP[indx&(chFP$Subspecies=='verus'&chFP$Sex==0),]
             ,control=lmerControl(optimizer="Nelder_Mead")
             )
# Covergence checks
tt <- getME(mp4.f,"theta")
ll <- getME(mp4.f,"lower")
min(tt[ll==0]) # not terrible, but not ideal either

derivs1 <- mp4.f@optinfo$derivs
sc_grad1 <- with(derivs1,solve(Hessian,gradient))
max(abs(sc_grad1)) # Fine
max(pmin(abs(sc_grad1),abs(derivs1$gradient))) # The same - fine.

mp4.m = lmer(fWHR ~ Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ +
               (1 | location) + (1 | ID)
             ,data = chFP[indx&(chFP$Subspecies=='verus'&chFP$Sex==1),]
             )

summary(mp4.f)
summary(mp4.m)

confint(mp4.f, method='profile')
# 2.5 %     97.5 %
#   .sig01       0.00000000 0.14967947
# .sig02       0.00000000 0.34803668
# .sigma       0.17818178 0.26753845
# (Intercept)  1.61955158 1.91370410
# Dom_CZ       0.00817667 0.20753487
# Ext_CZ      -0.13630212 0.12185953
# Con_CZ      -0.14912258 0.07709833
# Agr_CZ      -0.06656844 0.19159615
# Neu_CZ      -0.12393911 0.07226640
# Opn_CZ      -0.09946781 0.07316191
#confint(mp4.f, method='boot')

confint(mp4.m, method='profile')
# 2.5 %      97.5 %
#   .sig01       0.07779975  0.25612958
# .sig02       0.06246343  0.62575035
# .sigma       0.14322512  0.22881822
# (Intercept)  1.33656500  2.03737732
# Dom_CZ      -0.33445053 -0.01900332
# Ext_CZ      -0.45372506  0.18310760
# Con_CZ      -0.24671679  0.21099174
# Agr_CZ      -0.18221122  0.19102970
# Neu_CZ      -0.29580105 -0.01959169
# Opn_CZ      -0.08888618  0.35837230
#confint(mp4.m, method='boot')



# Trying different optimizers for females model

afurl <- "https://raw.githubusercontent.com/lme4/lme4/master/inst/utils/allFit.R"
eval(parse(text=getURL(afurl)))

aa <- allFit(mp4.f)
is.OK <- sapply(aa,is,"merMod")
aa.OK <- aa[is.OK]
lapply(aa.OK,function(x) x@optinfo$conv$lme4$messages)
(lliks <- sort(sapply(aa.OK,logLik)))
# Any of these seem like they would work in theory

mp4.f.2 <- update(mp4.f,start=ss,control=lmerControl(optimizer="Nelder_Mead"#,
                                           #optCtrl=list(maxiter=2e5)
                                           ))
summary(mp4.f)
confint(mp4.f.2, method='profile')
confint(mp4.f.2, method='boot')
# Nelder-Mead seems to work the best
# Has been reincorporated above.



# VERUS
# The + assoc /w D in females is not very strong, it actually appears to be greater and - in males;
# - assoc /w N being more driven by males
# - assoc /w C stronger in females, needs both to reach significance.



# TROGLODYTES
# Nothing there, sample is too small.

# mp5.f = lmer(fWHR ~ Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ +
#                (1 | location) + (1 | ID)
#              ,data = chFP[indx&(chFP$Subspecies=='troglodytes'&chFP$Sex==0),]
# )
# 
# mp5.m = lmer(fWHR ~ Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ +
#                (1 | ID)
#              ,data = chFP[indx&(chFP$Subspecies=='troglodytes'&chFP$Sex==1),]
# )
# 
# summary(mp5.f)
# summary(mp5.m)


