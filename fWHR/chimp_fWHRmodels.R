### Models of Chimpanzee LF/FH, age, sex, and personality

library(lme4)
library(car)
library(corrplot)
library(plyr)
library(numDeriv)
library(RCurl)
library(optimx)



s <- function(x) {scale(x)}


set.seed(1234567)



### loading in composite sheet

chFP = read.csv('chimpFacesPersDemos.csv')
chFP = chFP[,-1]

# colnames(chFP)
# dim(chFP)
chFP = chFP[!is.na(chFP$fWHR),]
# dim(chFP)






# t.test(chAgr$fWHR[chAgr$Sex=='Male'],chAgr$fWHR[chAgr$Sex=='Female'])



### Zero-order correlation plots

#colnames(chFP)
corrplot(cor(chFP[,c(8,9,12,13,14,15,16,17,18,19),],use="pairwise.complete.obs")
         ,  method = 'number')

corrplot(cor(chFP[chFP$Sex==0,c(8,12,13,14,15,16,17,18,19),],use="pairwise.complete.obs"),  method = 'number')
corrplot(cor(chFP[chFP$Sex==1,c(8,12,13,14,15,16,17,18,19),],use="pairwise.complete.obs"),  method = 'number')



### Mixed Effect Models

## Collapse subspecies random effects

#levels(chFP$Subspecies)
chFP$Subspecies[chFP$Subspecies=='hybrid'] = 'unknown'
table(chFP$Subspecies[!duplicated(chFP$ID)])

table(chFP$Sex[!duplicated(chFP$ID)&chFP$Subspecies=='verus'])
table(chFP$Sex[!duplicated(chFP$ID)&chFP$Subspecies=='schweinfurthii'])
table(chFP$Sex[!duplicated(chFP$ID)&chFP$Subspecies=='ellioti'])
table(chFP$Sex[!duplicated(chFP$ID)&chFP$Subspecies=='troglodytes'])
table(chFP$Sex[!duplicated(chFP$ID)&chFP$Subspecies=='unknown'])



# basic age,sex index:
adults = (chFP$Sex==0 & chFP$Age>7) | (chFP$Sex==1 & chFP$Age>9)
adults[is.na(adults)] = TRUE
adults = adults & (as.character(chFP$ID) != 'Gage') # 75
adults = adults & (as.character(chFP$ID) != 'Lennon') # This is a good place to pull out Lennon (130, 131)
count(adults)
#View(chFP[adults,])
chFP$ID[!adults]
chFP$Subspecies[!adults & !duplicated(chFP$ID)] # one of these is Lennon, who is verus



## Base: just subspecies random effects

set.seed(1234567)
m0 <- lmer(scale(fWHR) ~ 1 + #(1|instrument) +
             (1 | location) + 
             (1 | Subspecies) + (1 | ID:Subspecies)
           #,data=chFP[adults,]
           ,data=chFP[chFP$ID!='Lennon',]
)
summary(m0)
confint(m0,method='profile')
ranef(m0)

# Sensitivity of subspecies to individual
m0.0 <- lmer(fWHR ~ 1 +
             (1 | location) + (1 | Subspecies)
           #,data=chFP[adults,]
           ,data=chFP[chFP$ID!='Lennon',]
)
summary(m0.0)
confint(m0.0,method='profile')
ranef(m0.0)



## Age and Age squared, cubed

set.seed(1234567)
m1 <- lmer(fWHR ~ s(Age) + s(I(Age^2)) + s(I(Age^3)) +
             (1 | location) + (1 | Subspecies) + (1 | ID:Subspecies)
           ,data = chFP[adults,]
)
summary(m1)
confint(m1, method='profile')

# No age effects. Could it be due to oversampling of older individuals? Does it matter?

# Main question - to include any age variables in later models?
# Hard to justify including Age but not the others, if we include any at all.



set.seed(1234567)
m2 <- lmer(fWHR ~ Age*Sex +
             (1 | location) + (1 | Subspecies) + (1 | ID:Subspecies)
           ,data = chFP[adults,]
)
summary(m2)
confint(m2, method='profile')

# Again, nothing. Yet more difficult to include these.



### Personality

set.seed(12345)
mp1 <- lmer(fWHR ~ Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ +
              (1 | location) + (1 | Subspecies) + (1 | ID:Subspecies)
            ,data = chFP[adults,]
)
summary(mp1)
confint(mp1, method='profile')

# Nothing across the whole sample,
# but given what we know about T and sex diffs ala LeFevre et al. 2013, EaHB...



## Split by sex

set.seed(1234567)
mp2.f <- lmer(fWHR ~ Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ +
                (1 | location) + (1 | Subspecies) + (1 | ID:Subspecies)
              ,data = chFP[adults&chFP$Sex==0,]
)
mp2.m <- lmer(fWHR ~ Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ +
                (1 | location) + (1 | ID:Subspecies) + (1 | Subspecies)
              ,data = chFP[adults&chFP$Sex==1,]
)

summary(mp2.f)
summary(mp2.m)

confint(mp2.f, method='profile')
confint(mp2.m, method='profile')



## Dividing by (major) subspecies

count(chFP$Subspecies)
table(chFP$Subspecies,chFP$Sex)

set.seed(1234567)
mp3.t = lmer(fWHR ~ Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ +
               (1 | location) + 
             (1 | ID)
             ,data = chFP[adults&chFP$Subspecies=='troglodytes',]
)
mp3.v = lmer(fWHR ~ Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ +
               (1 | location) + (1 | ID)
             #,data = chFP[chFP$Subspecies=='verus',]
             ,data = chFP[adults&chFP$Subspecies=='verus',]
)

summary(mp3.t) # Nothing for troglodytes.
summary(mp3.v)

confint(mp3.t, method='Wald') # Profile not optimal
confint(mp3.v, method='profile')

# In Verus, low C and low N (which are neg corr'd) are both neg associated with fWHR



## Verus is the only subspecies with reasonable sample size

set.seed(1234567)
mp4.f = lmer(fWHR ~ Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ +
               (1 | location) + (1 | ID)
             ,data = chFP[adults&(chFP$Subspecies=='verus'&chFP$Sex==0),]
             ,control=lmerControl(optimizer="Nelder_Mead")
)
# Covergence checks
# tt <- getME(mp4.f,"theta")
# ll <- getME(mp4.f,"lower")
# min(tt[ll==0]) # not terrible, but not ideal either
# 
# derivs1 <- mp4.f@optinfo$derivs
# sc_grad1 <- with(derivs1,solve(Hessian,gradient))
# max(abs(sc_grad1)) # Fine
# max(pmin(abs(sc_grad1),abs(derivs1$gradient))) # The same - fine.

mp4.m = lmer(fWHR ~ Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ +
               (1 | location) + (1 | ID)
             ,data = chFP[adults&(chFP$Subspecies=='verus'&chFP$Sex==1),]
)

summary(mp4.f)
confint(mp4.f, method='profile')

summary(mp4.m)
confint(mp4.m, method='profile')







# Trying different optimizers for females model

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
#                                                      #optCtrl=list(maxiter=2e5)
# ))
# summary(mp4.f)
# confint(mp4.f.2, method='profile')
# confint(mp4.f.2, method='boot')
# # Nelder-Mead seems to work the best
# # Has been reincorporated above.



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


