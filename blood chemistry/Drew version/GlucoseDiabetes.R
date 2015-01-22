# post The Burn analyses to confirm things in the Glucose / Diabetes related data
# only run this script after shapeUp.R - as this requires dmdob and related df's

# first, 
#   check for normality
#             outliers
#   add in time point 4


# later
#   BLUPs
#   what factors with Glucose?
#     (FA, REFA)
#   human sample

###########################

# a modified version of this df

mmdat <- data.frame(dmdob$chimp,sex,BMI,DoB,age, # to get current age
                    compare_data$chimp_Dom_CZ,compare_data$chimp_Ext_CZ,compare_data$chimp_Con_CZ,
                    compare_data$chimp_Agr_CZ,compare_data$chimp_Neu_CZ,compare_data$chimp_Opn_CZ,
                    trig[,2], chol[,2], glucose[,2],
                    mono[,1],lymph[,1],wbc[,1],
                    protein[,1],albumin[,1],calcium[,1],phos[,1],sodium[,1],potas[,1],
                    chlor[,1],globulin[,1],GGT[,1],osmolality[,1],ALP[,1],creatinine[,1],
                    BUN[,1],rbc[,1],hct[,1],hgb[,1],eos[,1],systolic[,1],diastolic[,1],
                    trig[,3], chol[,3], glucose[,3],
                    mono[,2],lymph[,2],wbc[,2],
                    protein[,2],albumin[,2],calcium[,2],phos[,2],sodium[,2],potas[,2],
                    chlor[,2],globulin[,2],GGT[,2],osmolality[,2],ALP[,2],creatinine[,2],
                    BUN[,2],rbc[,2],hct[,2],hgb[,2],eos[,2],systolic[,2],diastolic[,2],
                    trig[,4], chol[,4], glucose[,4],
                    mono[,3],lymph[,3],wbc[,3],
                    protein[,3],albumin[,3],calcium[,3],phos[,3],sodium[,3],potas[,3],
                    chlor[,3],globulin[,3],GGT[,3],osmolality[,3],ALP[,3],creatinine[,3],
                    BUN[,3],rbc[,3],hct[,3],hgb[,3],eos[,3],systolic[,3],diastolic[,3],
                    #trig[,4], chol[,4], glucose[,4],
                    dmdob$depr.z
                    
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
                     'BUN.3','rbc.3','hct.3','hgb.3','eos.3','sys.3','dias.3',
                     #'trig.4','chol.4','glucose.4',                   
                     'depressed'
                     #'sys','dias'
)


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
scoutputd <- cbind(output[,1:2],scale(output[,3]),output[4:12],scale(output[,13:37]))
colnames(scoutputd)[3] <- 'BMI'


##########################
# Models

gd1 <- lmer(glucose ~ dom + ext + neu + con + opn + agr + age + BMI + sex + (1 | chimp), 
            data = scoutputd)

gd1_c <- lmer(glucose ~ dom + ext + neu+con + neu:con + opn + agr + age + BMI + sex + (1 | chimp), 
              data = scoutputd)

gd1_d <- lmer(glucose ~ dom + ext + neu:con + opn + agr + age + BMI + sex + (1 | chimp), 
            data = scoutputd)
