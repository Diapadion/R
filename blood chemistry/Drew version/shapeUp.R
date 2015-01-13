#fulldata <- read.csv("final_data.csv")
# just use import, then attach what it gives you...
attach(fulldata)

# temporary fixes:

# - remove non personality rated individuals, or rather, individual with no DOB



as.numeric(fulldata$DOB.y,na.rm=TRUE)+as.numeric(fulldata$DOB.x,na.rm=TRUE)

     
DOBrm <- (!is.na(fulldata$DOB.x))|(!is.na(fulldata$DOB.y))

dmdob <- fulldata[DOBrm,]

DoB <- as.Date(as.character(dmdob$DOB.x),format = "%m/%d/%Y")





bchemt1 <- structure(numeric(dim(dmdob)[1]), class="Date")
bchemt2 <- structure(numeric(dim(dmdob)[1]), class="Date")
bchemt3 <- structure(numeric(dim(dmdob)[1]), class="Date")
bchemt4 <- structure(numeric(dim(dmdob)[1]), class="Date")

bcellt1 <- structure(numeric(dim(dmdob)[1]), class="Date")
bcellt2 <- structure(numeric(dim(dmdob)[1]), class="Date")
bcellt3 <- structure(numeric(dim(dmdob)[1]), class="Date")

for (i in 1:(dim(dmdob)[1])){
  yeart <- as.character(dmdob$Year1[i])
  if(nchar(yeart)==10){
    bchemt1[i] <- as.Date(yeart,format = "%m/%d/%Y")
    
  }
  else bchemt1[i] <- as.Date(yeart,format = "%m/%d/%y")
  
  yeart <- as.character(dmdob$Year2[i])
  if(nchar(yeart)==10){
    bchemt2[i] <- as.Date(yeart,format = "%m/%d/%Y")
    
  }
  else bchemt2[i] <- as.Date(yeart,format = "%m/%d/%y")
    
  yeart <- as.character(dmdob$Year3[i])
  if(nchar(yeart)==10){
    bchemt3[i] <- as.Date(yeart,format = "%m/%d/%Y")
    
  }
  else bchemt3[i] <- as.Date(yeart,format = "%m/%d/%y")
  
  yeart <- as.character(dmdob$Year4[i])
  if(nchar(yeart)==10){
    bchemt4[i] <- as.Date(yeart,format = "%m/%d/%Y")
    
  }
  else bchemt4[i] <- as.Date(yeart,format = "%m/%d/%y")
  
  #
  
  yeart <- as.character(dmdob$date1[i])
  if(nchar(yeart)==10){
    bcellt1[i] <- as.Date(yeart,format = "%d/%m/%Y")
    
  }
  else bcellt1[i] <- as.Date(yeart,format = "%d/%m/%y")
  
  yeart <- as.character(dmdob$date2[i])
  if(nchar(yeart)==10){
    bcellt2[i] <- as.Date(yeart,format = "%d/%m/%Y")
    
  }
  else bcellt2[i] <- as.Date(yeart,format = "%d/%m/%y")
  
  yeart <- as.character(dmdob$date3[i])
  if(nchar(yeart)==10){
    bcellt3[i] <- as.Date(yeart,format = "%d/%m/%Y")
    
  }
  else bcellt3[i] <- as.Date(yeart,format = "%d/%m/%y")
  
}


# sex

#IS THIS NEEDED???
#dmdob$sex[104]=0 # seems to be lolita - uncelar what problem is

sex = dmdob$Sex.x

# BMI

BMI = dmdob$BMI


# blood stuff

# use "bchem"
trig <- cbind(dmdob$triglicerides,dmdob$triglicerides.1,dmdob$triglicerides.2,dmdob$triglicerides.3)
chol <- cbind(dmdob$cholesterol,dmdob$cholesterol.1,dmdob$cholesterol.2,dmdob$cholesterol.3)
glucose <- cbind(dmdob$Glucose,dmdob$Glucose.1,dmdob$Glucose.2,dmdob$Glucose.3)

# use "bcell"
mono <- cbind(dmdob$monos,dmdob$mono2,dmdob$mono3)
lymph <- cbind(dmdob$lymph,dmdob$lymp2,dmdob$lymp3)
wbc <- cbind(dmdob$wbc,dmdob$wbc2,dmdob$wbc3)

# more (added 01/09/15)
protein <- cbind(dmdob$Protein,dmdob$Protein.1,dmdob$Protein.2,dmdob$Protein.3)
albumin <- cbind(dmdob$Albumn,dmdob$Albumn.1,dmdob$Albumn.2,dmdob$Albumn.3)
calcium <- cbind(dmdob$calcium,dmdob$calcium.1,dmdob$calcium.2,dmdob$calcium.3)
phos <- cbind(dmdob$phosphate,dmdob$phosphate.1,dmdob$phosphate.2,dmdob$phosphate.3)
sodium <- cbind(dmdob$sodium,dmdob$sodium.1,dmdob$sodium.2,dmdob$sodium.3)
potas <- cbind(dmdob$potassium,dmdob$potassium.1,dmdob$potassium.2,dmdob$potassium.3)
chlor <- cbind(dmdob$chloride,dmdob$chloride.1,dmdob$chloride.2,dmdob$chloride.3)
globulin <- cbind(dmdob$globulin,dmdob$globulin.1,dmdob$globulin.2,dmdob$globulin.3)
GGT <- cbind(dmdob$ggtp,dmdob$ggtp.1,dmdob$ggtp.2,dmdob$ggtp.3)
osmolality <- cbind(dmdob$osmolal,dmdob$osmolal.1,dmdob$osmolal.2,dmdob$osmolal.3)
ALP <- cbind(dmdob$alkphos,dmdob$alkphos.1,dmdob$alkphos.2,dmdob$alkphos.3)
creatinine <- cbind(dmdob$Creatine,dmdob$Creatin.1,dmdob$Creatin.2,dmdob$Creatin.3)
BUN <- cbind(dmdob$BUN,dmdob$BUN.1,dmdob$BUN.2,dmdob$BUN.3)
#A/G ratio?
hct <- cbind(dmdob$hct,dmdob$hct2,dmdob$hct3)
hgb <- cbind(dmdob$hgb,dmdob$hgb2,dmdob$hgb3)
eos <- cbind(dmdob$eos,dmdob$eos2,dmdob$eos3)
rbc <- cbind(dmdob$rbc,dmdob$rbc2,dmdob$rbc3)



#as.Date(as.character(dmdob$DOB.x[10]),format = "%m/%d/%y")

#as.Date(as.character(dmdob$DOB.x[25]),format = "%m/%d/%y")

# personality

compare_data <- NULL

compare_data$chimp_Dom_CZ <-
  (dmdob$dom.z-dmdob$subm.z-dmdob$depd.z+dmdob$indp.z-dmdob$fear.z+dmdob$decs.z-dmdob$tim.z-dmdob$caut.z+
     dmdob$intll.z+dmdob$pers.z+dmdob$buly.z+dmdob$stngy.z+40)/12

compare_data$chimp_Ext_CZ <-
  (-dmdob$sol.z-dmdob$lazy.z+dmdob$actv.z+dmdob$play.z+dmdob$soc.z-dmdob$depr.z+dmdob$frdy.z+dmdob$affc.z+dmdob$imit.z+24)/9

compare_data$chimp_Con_CZ <-
  (-dmdob$impl.z-dmdob$defn.z-dmdob$reckl.z-dmdob$errc.z-dmdob$irri.z+dmdob$pred.z-dmdob$aggr.z-dmdob$jeals.z-dmdob$dsor.z+64)/9

compare_data$chimp_Agr_CZ <-
  (dmdob$symp.z+dmdob$help.z+dmdob$sens.z+dmdob$prot.z+dmdob$gntl.z)/5

compare_data$chimp_Neu_CZ <-
  (-dmdob$stbl.z+dmdob$exct.z-dmdob$unem.z+16)/3

compare_data$chimp_Opn_CZ <-
  (dmdob$inqs.z+dmdob$invt.z)/2



systolic.1 <- NULL
systolic.3 <- NULL
systolic.2 <- NULL
diastolic.1 <- NULL
diastolic.2 <- NULL
diastolic.3 <- NULL

systolic <- NULL
diastolic <- NULL


# fucking removing the slashes from systolic diastolic
# putting them in their own vars

bps <- strsplit(as.character(dmdob$BP.1),"[/]")
for (i in 1:dim(dmdob)[1]){
  bps <- strsplit(as.character(dmdob$BP.1),"[/]")
  if (!is.na(bps)[[i]]){
    
    systolic.1[i] = as.numeric(bps[[i]][1])
    diastolic.1[i] = as.numeric(bps[[i]][2]) 
    
  }
  else{
    systolic.1[i] = NA
    diastolic.1[i] = NA    
  }
  bps <- strsplit(as.character(dmdob$BP.2),"[/]")
  if (!is.na(bps)[[i]]){
    
    systolic.2[i] = as.numeric(bps[[i]][1])
    diastolic.2[i] = as.numeric(bps[[i]][2]) 
    
  }
  else{
    systolic.2[i] = NA
    diastolic.2[i] = NA    
  }
  bps <- strsplit(as.character(dmdob$BP.3),"[/]")
  if (!is.na(bps)[[i]]){
    
    systolic.3[i] = as.numeric(bps[[i]][1])
    diastolic.3[i] = as.numeric(bps[[i]][2]) 
    
  }
  else{
    systolic.3[i] = NA
    diastolic.3[i] = NA    
  }
  
  
}

systolic <- cbind(systolic.1,systolic.2,systolic.3)
diastolic <- cbind(diastolic.1,diastolic.2,diastolic.3)



# putting it all together

age <- as.numeric(as.Date("2014-04-15")-DoB)

mmdat <- data.frame(dmdob$chimp,sex,BMI,DoB,age, # to get current age
                    compare_data$chimp_Dom_CZ,compare_data$chimp_Ext_CZ,compare_data$chimp_Con_CZ,
                    compare_data$chimp_Agr_CZ,compare_data$chimp_Neu_CZ,compare_data$chimp_Opn_CZ,
                    trig[,1], chol[,1], glucose[,1],
                    mono[,1],lymph[,1],wbc[,1],
                    protein[,1],albumin[,1],calcium[,1],phos[,1],sodium[,1],potas[,1],
                    chlor[,1],globulin[,1],GGT[,1],osmolality[,1],ALP[,1],creatinine[,1],
                    BUN[,1],rbc[,1],hct[,1],hgb[,1],eos[,1],systolic[,1],diastolic[,1],
                    trig[,2], chol[,2], glucose[,2],
                    mono[,2],lymph[,2],wbc[,2],
                    protein[,2],albumin[,2],calcium[,2],phos[,2],sodium[,2],potas[,2],
                    chlor[,2],globulin[,2],GGT[,2],osmolality[,2],ALP[,2],creatinine[,2],
                    BUN[,2],rbc[,2],hct[,2],hgb[,2],eos[,2],systolic[,2],diastolic[,2],
                    trig[,3], chol[,3], glucose[,3],
                    mono[,3],lymph[,3],wbc[,3],
                    protein[,3],albumin[,3],calcium[,3],phos[,3],sodium[,3],potas[,3],
                    chlor[,3],globulin[,3],GGT[,3],osmolality[,3],ALP[,3],creatinine[,3],
                    BUN[,3],rbc[,3],hct[,3],hgb[,3],eos[,3],systolic[,3],diastolic[,3]
                    #trig[,4], chol[,4], glucose[,4],
                           
                    #apply(systolic,1,mean,na.rm=TRUE),apply(diastolic,1,mean,na.rm=TRUE)
                    )

colnames(mmdat) <- c('chimp','sex','BMI','DoB','age','dom','ext','con','agr','neu','opn',
                     'trig.1','chol.1','glucose.1','mono.1','lymph.1','wbc.1',
                     'protein.1','albumin.1','calcium,1','phos.1','sodium.1','potas.1',
                     'chlor.1','globulin.1','GGT.1','osmolality.1','ALP.1','creatinine.1',
                     'BUN.1','rbc.1','hct.1','hgb.1','eos.1','sys.1','dias.1',
                     'trig.2','chol.2','glucose.2','mono.2','lymph.2','wbc.2',
                     'protein.2','albumin.2','calcium,2','phos.2','sodium.2','potas.2',
                     'chlor.2','globulin.2','GGT.2','osmolality.2','ALP.2','creatinine.2',
                     'BUN.2','rbc.2','hct.2','hgb.2','eos.2','sys.2','dias.2',
                     'trig.3','chol.3','glucose.3','mono.3','lymph.3','wbc.3',
                     'protein.3','albumin.3','calcium,3','phos.3','sodium.3','potas.3',
                     'chlor.3','globulin.3','GGT.3','osmolality.3','ALP.3','creatinine.3',
                     'BUN.3','rbc.3','hct.3','hgb.3','eos.3','sys.3','dias.3'
                     
                     #'trig.4','chol.4','glucose.4',                   
                     #'sys','dias'
                     )

meandat <- data.frame(dmdob$chimp,dmdob$sex,dmdob$BMI,DoB,(as.Date("2014-04-15")-DoB), # to get current age
                    compare_data$chimp_Dom_CZ,compare_data$chimp_Ext_CZ,compare_data$chimp_Con_CZ,
                    compare_data$chimp_Agr_CZ,compare_data$chimp_Neu_CZ,compare_data$chimp_Opn_CZ,
                      apply(trig,1,mean,na.rm=TRUE),
                      apply(chol,1,mean,na.rm=TRUE),
                      apply(lymph,1,mean,na.rm=TRUE),
                      apply(mono,1,mean,na.rm=TRUE),
                      apply(wbc,1,mean,na.rm=TRUE),
                      apply(glucose,1,mean,na.rm=TRUE),
                      apply(systolic,1,mean,na.rm=TRUE),
                      apply(diastolic,1,mean,na.rm=TRUE)
)

colnames(meandat) <- c('chimp','sex','BMI','DoB','age','dom','ext','con','agr','neu','opn',
                     'trig','chol','lymph','mono','wbc','glucose',                                       
                     'sys','dias')



detach(fulldata)
             
output <- reshape(mmdat, 
                  idvar = "chimp",
                  #idvar=c(colnames(mmdat)[1:11],'sys','dias'), 
                  varying=colnames(mmdat)[12:86], 
                  v.names=c("trig","chol","glucose","wbc","mono","lymph","protein","albumin","calcium","phos","sodium","potas",
                            "chlor","globulin","GGT","osmolality","ALP","creatinine","BUN","rbc","hct","hgb","eos","sys","dias"
                  ),
                  #sep=".",
                  direction="long")
# now scale and center it
scoutput <- cbind(output[,1:2],scale(output[,3]),output[4:12],scale(output[,13:37]))
colnames(scoutput)[3] <- 'BMI'


attach(scoutput)
# model1 <- lmer(sys ~ chimp + time + sex + BMI + age + dom + ext + con + agr + neu + opn +
#      #(time | trig) + 
#      (time | chol) + (time | glucose) + (time | wbc) + (time | mono) + (time | lymph),
#      data=output,
#      control = lmerControl(check.nobs.vs.nRE = "warning"))

#
# sex=output$sex 
#

model2 <- lmer (dias ~ age + time + (1 | chimp), data = output)

# model3 <- lm(dias ~ age + dom + ext + con + agr + neu + opn 
#              + BMI + trig + chol + glucose + wbc + mono + lymph, na.action = na.exclude)

model4 <- lm(sys ~ age + dom + ext + con + agr + neu + opn)

model5 <- lmer(dias ~ time + age + dom + ext + con + agr + neu + opn + BMI +
                 (1 + time | chimp) + (1 + time|chol), data = output)

model6 <- lmer(dias ~ time + age + (dom | chimp) + (ext | chimp) + (agr | chimp), data = output) 


model7 <- lmer(dias ~ time + sex + dom + ext + agr + neu + opn + con + BMI +
                 chol + trig + glucose + (chol|chimp) +
                 (1|chimp), data = output)

model8 <- lmer(dias ~ time + output$sex + age + (1 + time|chimp) + (BMI|chimp)
              # + (chimp|BMI)        
               + dom + ext + agr + neu + opn + con
              , data = output)

# model9 <- lme(chol ~ age + sex + dom + ext + agr + neu + opn + con, random= ~1 | chimp,  na.action = na.exclude)


# model10 <- lmer(chol ~ time + age + sex + BMI + (1 | chimp), data = output)

with(meandat, {
  model11 <- lmer(sys ~ DoB + BMI + sex
                +dom+ext+agr+neu+opn+con
                +(1 | chimp)
                  )
  Anova(model11)
  })


#######

# from slightly older code
# model_null <- lmer(dias ~ age + sex + BMI + (1 | chimp), data = output)
# 
# model_a <- lmer(dias ~ age + sex + BMI + dom + ext + agr + neu + opn + con + (1 | chimp), data = output)
# model_aa <- lmer(sys ~ age + sex + BMI + dom + ext + agr + neu + opn + con + (1 | chimp), data = output)

model_null <- lmer(dias ~ age + sex + BMI + (1 | chimp), data = meandat)

model_a <- lmer(dias ~ age + sex + BMI + dom + ext + agr + neu + opn + con + (1 | chimp), data = output)
model_aa <- lmer(sys ~ age + sex + BMI + dom + ext + agr + neu + opn + con + (1 | chimp), data = output)


# some CI math, from results borrowed from poster... 
# Beta +/- Z95 * S.E.
# z95 = 1.96

3.96+1.10*1.96
3.96-1.10*1.96
-7.76+1.91*1.96
-7.76-1.91*1.96




# model99 <- lme(dias ~ time + sex + age,
#               random = ~ time|chimp, data = output, na.action=na.omit)

# longmmdat <- reshape(mmdat, idvar = "chimp", ids = mmdat[,1], 
#                      direction='long')

#varying = list(12:32),

#colnames(mmdat)[1:11]

#meltedat <- melt(mmdat, id.vars=c(colnames(mmdat)[1:11],'sys','dias'))

#longmmdat <- reshape(meltedat, idvar = colnames(meltedat)[1:13], direction = 'wide',varying = 14 )

detach(scoutput)

#attach(meandat)

model_b <- lmer(chol ~ dom + ext + neu + con + opn + agr + age + BMI + sex + (1 | chimp), 
                data = output)
                #data = meandat)

model_c <- lmer(trig ~ dom + ext + neu + con + opn + agr + age + BMI + sex + (1 | chimp), data = output)
                #data = meandat)

#model_c <- lmer(trig ~ dom + ext + neu + con + opn + agr + (1 | chimp), data = output) # shit

#model_b <- lmer(chol ~  age + sex + BMI + dom + ext + agr + neu + opn + con + (1 | chimp) + glucose + wbc + mono + lymph, data = meandat)

model_c <- lmer(trig ~ age + sex + BMI + dom + ext + agr + neu + opn + con + (1 | chimp) + chol + glucose + wbc + mono + lymph, data = output)

model_d <- lmer(glucose ~ dom + ext + neu + con + opn + agr + age + BMI + sex + (1 | chimp), data = output)

model_e <- lmer(lymph ~ dom + ext + neu + con + opn + agr + age + BMI + sex + (1 | chimp), data = output)

model_fu <- lmer(trig ~ dom + ext + neu + con + opn + agr + age + BMI + (1 | sex) + (1 | chimp), data = output)
summary(model_fu)
confint(model_fu)
# pay close attention to what is going on in the above models



#model_e <- lmer(dias ~ age + BMI + dom + ext + agr + neu + opn + con + (1 | sex), data = output)
#model_e <- lmer(dias ~ DoB + BMI + dom + ext + agr + neu + opn + con + (1 | sex), data = output)


#detach(meandat)

detach(scoutput)

#######
# 01/09/15 - fresh models for The Burn presentation

# BP: according to FHS 1971, sys is generally a better predictor of heart disease


# sys is a better predictor here (there's nothing to see with dias)... wonder why (see below)
m_1 <- lmer(sys ~ dom + ext + neu + con + opn + agr + age + BMI + sex + (1 | chimp), 
                                   data = scoutput)
# opn: 0.48 (+), agr: 0.001 (-)
vif.mer(m_1)

# interactions?
m1a <- lmer(sys ~ dom + ext + neu + con + agr:opn + age + BMI + sex + (1 | chimp), 
            data = scoutput)
# ... no, none here

# but wait, what about the direct effects on BMI?
m_1z <- lmer(BMI ~ dom + ext + neu + con + opn + agr + age +  sex + (1 | chimp), 
             data = scoutput)

relgrad <- with(m_1a@optinfo$derivs,solve(Hessian,gradient))
max(abs(relgrad))
# Nope.

m_2a <- lmer(chol ~ dom + ext + neu + con + opn + agr + age + BMI + sex + (1 | chimp), 
            data = scoutput)
# dom: 0.00866 (-), ext: 0.022 (+), agr: 0.007 (-)
# cholesterol is diet influenced, but other factors are more important
# again, interactions?
m2a1 <- lmer(chol ~ + dom:agr + dom + ext + neu + con + opn + agr + age + BMI + sex + (1 | chimp), 
             data = scoutput)
summary(m2a1)
AIC(m_2a,m2a1)
vif.mer(m_2a)
vif.mer(m2a1)

m_2b <- lmer(trig ~ dom + ext + neu + con + opn + agr + age + BMI + sex + (1 | chimp), 
            data = scoutput) # there's nothing here...
# triglycerides indicate immediate diet

m_2c <- lmer(glucose ~ dom + ext + neu + con + opn + agr + age + BMI + sex + (1 | chimp), 
            data = scoutput)
# neu: 0.0045 (-), con: 0.011 (+)

# ... some model fit tests
m2c1 <- lmer(glucose ~ dom + ext + neu + 
                       opn + agr + age + BMI + sex + (1 | chimp), 
                     data = scoutput)
m2c2 <- lmer(glucose ~ dom + ext + con + 
                       opn + agr + age + BMI + sex + (1 | chimp), 
                     data = scoutput)
AIC(m_2c,m2c1,m2c2)
# first model is a better fir than both... so there's something legit here
m2c3 <- lmer(glucose ~ dom + ext + con:neu + 
                           opn + agr + age + BMI + sex + (1 | chimp), 
                         data = scoutput)
AIC(m2c3)

# residuals and vif
# resid(m_2c) # probably not needed with vif's
# vif requires mer-utils.R
vif.mer(m_2c)
vif.mer(m2c1)
vif.mer(m2c2)
vif.mer(m2c3)


# hematology - no effect from blood factors

m_2d <- lmer(wbc ~ dom + ext + neu + con + opn + agr + age + BMI + sex + (1 | chimp), 
                            data = scoutput)

m_2e <- lmer(lymph ~ dom + ext + neu + con + opn + agr + age + BMI + sex + (1 | chimp), 
            data = scoutput)

m_2f <- lmer(mono ~ dom + ext + neu + con + opn + agr + age + BMI + sex + (1 | chimp), 
            data = scoutput)

m_2g <- lmer(eos ~ dom + ext + neu + con + opn + agr + age + BMI + sex + (1 | chimp), 
             data = scoutput)

m2h <- lmer(hgb ~ dom + ext + neu + con + opn + agr + age + BMI + sex + (1 | chimp), 
            data = scoutput)

m2i <- lmer(hct ~ dom + ext + neu + con + opn + agr + age + BMI + sex + (1 | chimp), 
            data = scoutput)

m2j <- lmer(rbc ~ dom + ext + neu + con + opn + agr + age + BMI + sex + (1 | chimp), 
                 data = scoutput)

# ions
m2k <- lmer(potas ~ dom + ext + neu + con + opn + agr + age + BMI + sex + (1 | chimp), 
            data = scoutput)

m2l <- lmer(calcium ~ dom + ext + neu + con + opn + agr + age + BMI + sex + (1 | chimp), 
            data = scoutput)

m2m <- lmer(chlor ~ dom + ext + neu + con + opn + agr + age + BMI + sex + (1 | chimp), 
            data = scoutput)

m2n <- lmer(sodium ~ dom + ext + neu + con + opn + agr + age + BMI + sex + (1 | chimp), 
            data = scoutput)

m2o <- lmer(osmolality ~ dom + ext + neu + con + opn + agr + age + BMI + sex + (1 | chimp), 
            data = scoutput)

m2p <- lmer(phos ~ dom + ext + neu + con + opn + agr + age + BMI + sex + (1 | chimp), 
            data = scoutput)

#proteins
m2q <- lmer(protein ~ dom + ext + neu + con + opn + agr + age + BMI + sex + (1 | chimp), 
            data = scoutput)

m2r <- lmer(BUN ~ dom + ext + neu + con + opn + agr + age + BMI + sex + (1 | chimp), 
            data = scoutput)

m2s <- lmer(albumin ~ dom + ext + neu + con + opn + agr + age + BMI + sex + (1 | chimp), 
            data = scoutput)

m2t <- lmer(GGT ~ dom + ext + neu + con + opn + agr + age + BMI + sex + (1 | chimp), 
            data = scoutput)

m2u <- lmer(creatinine ~ dom + ext + neu + con + opn + agr + age + BMI + sex + (1 | chimp), 
            data = scoutput)

m2v <- lmer(globulin ~ dom + ext + neu + con + opn + agr + age + BMI + sex + (1 | chimp), 
            data = scoutput)

m2w <- lmer(ALP ~ dom + ext + neu + con + opn + agr + age + BMI + sex + (1 | chimp), 
            data = scoutput)





# dias works better here... sort of/not really (after scaling)
m_3dias <- lmer(dias ~ trig + chol + wbc + lymph + mono + glucose + 
              BUN + protein + albumin + calcium + phos + sodium + potas + chlor + globulin + GGT + osmolality +
              ALP + creatinine + rbc + hct + hgb + eos +
              age + sex + BMI + (1 | chimp), 
                data = scoutput)

m_3sys <- lmer(sys ~ trig + chol + wbc + lymph + mono + glucose + 
                  #BUN + protein + albumin + calcium + phos + sodium + potas + chlor + globulin + GGT + osmolality +
                  #ALP + creatinine + rbc + hct + hgb + eos +
                  age + sex + BMI + (1 | chimp), 
                data = scoutput)

m_3a <- lmer(sys ~ chol + trig + glucose + age + sex + BMI + (1 | chimp), data = scoutput) 


# reverse BP biomarker
m_4a <- lmer(glucose ~ sys + BMI + age + sex + (1|chimp),
                              data = scoutput)

# useful correlation checks
cor(output$con,output$neu, use='complete')
cor(output$chol,output$glucose, use='complete')


# scatterplot3d(output$con, output$neu, output$glucose)

plot(effect(term="con:neu",mod=m2c3,multiline = TRUE))
          