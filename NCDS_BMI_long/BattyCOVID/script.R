### Batty et al., UKBB COVID manuscript & plots


library(readxl)
library(ggplot2)
library(jcolors)
library(scales)



#* suggest a forest plot – one for psychological exposures, for socioeconomic exposures.

#* for each exposure (independent variable) suggest two bars – one for age, sex, ethnicity adjusted OR; 
## one for age, sex, ethnicity  + SES (the latter will become ‘fully’ adjusted when we have it)

#* ideally, for each bar, we should have these numerics: number of hospitalisations, number at risk, OR + 95% CI

#* for ease of presentation, suggest reporting the unit change OR 
## – most of the effects appear linear across categories so this seems a fair summary.  

  

### Psychological variables

tab2 = read_xlsx("./BattyCOVID/Table2.xlsx")

strip2 = tab2

#stripSD = strip2[strip2$level %in% c("Per SD increase","Per SD decrease","Yes"),]


## N.B. rest of strip2 routines have not been updated to take advantage of
## improvements like those made to strip3
## TODO - doing now

strip2 = strip2[strip2$level %in% c("1 (low)","2","3","(Yes)","(No)","(Per SD increase)","(Per SD decrease)"),]


## "Model matrices"
mat2.as = matrix(strsplit(strip2$`Age & sex`[strip2$`Age & sex`!="1.0 (ref)"]," "))
mat2.ase = matrix(strsplit(strip2$`Age, sex & ethnicity`[strip2$`Age, sex & ethnicity`!="1.0 (ref)"]," "))
mat2.aseCo = matrix(strsplit(strip2$`Age, sex, ethnicity & comorbidity2`[strip2$`Age, sex, ethnicity & comorbidity2`!="1.0 (ref)"]," "))
mat2.aseL = matrix(strsplit(strip2$`Age, sex, ethnicity & lifestyle factors3`[strip2$`Age, sex, ethnicity & lifestyle factors3`!="1.0 (ref)"]," "))
mat2.aseSE = matrix(strsplit(strip2$`Age, sex, ethnicity & socioeconomic factors4`[strip2$`Age, sex, ethnicity & socioeconomic factors4`!="1.0 (ref)"]," "))
mat2.Full = matrix(strsplit(strip2$`Adjusted for all covariates`[strip2$`Adjusted for all covariates`!="1.0 (ref)"]," "))


strip2$m0.OR = 1 # age, sex
strip2$m0.lower.CI = NA
strip2$m0.upper.CI = NA

strip2$m1.OR = 1 # age, sex, eth
strip2$m1.lower.CI = NA
strip2$m1.upper.CI = NA

strip2$m2.OR = 1 # + comorbidity
strip2$m2.lower.CI = NA
strip2$m2.upper.CI = NA

strip2$m3.OR = 1 # + lifestyle
strip2$m3.lower.CI = NA
strip2$m3.upper.CI = NA

strip2$m4.OR = 1 # + socio
strip2$m4.lower.CI = NA
strip2$m4.upper.CI = NA

strip2$mFull.OR = 1 # adjusted for all covariates
strip2$mFull.lower.CI = NA
strip2$mFull.upper.CI = NA

m = 1
for (i in 1:dim(strip2[1])){
  if(strip2$`Age, sex & ethnicity`[i]!="1.0 (ref)") {
    strip2$m0.OR[i] = unlist(mat2.as[m])[1]
    strip2$m0.lower.CI[i] = unlist(mat2.as[m])[2]
    strip2$m0.upper.CI[i] = unlist(mat2.as[m])[3]
    
    strip2$m1.OR[i] = unlist(mat2.ase[m])[1]
    strip2$m1.lower.CI[i] = unlist(mat2.ase[m])[2]
    strip2$m1.upper.CI[i] = unlist(mat2.ase[m])[3]
    
    strip2$m2.OR[i] = unlist(mat2.aseCo[m])[1]
    strip2$m2.lower.CI[i] = unlist(mat2.aseCo[m])[2]
    strip2$m2.upper.CI[i] = unlist(mat2.aseCo[m])[3]
    
    strip2$m3.OR[i] = unlist(mat2.aseL[m])[1]
    strip2$m3.lower.CI[i] = unlist(mat2.aseL[m])[2]
    strip2$m3.upper.CI[i] = unlist(mat2.aseL[m])[3]
    
    strip2$m4.OR[i] = unlist(mat2.aseSE[m])[1]
    strip2$m4.lower.CI[i] = unlist(mat2.aseSE[m])[2]
    strip2$m4.upper.CI[i] = unlist(mat2.aseSE[m])[3]
    
    strip2$mFull.OR[i] = unlist(mat2.Full[m])[1]
    strip2$mFull.lower.CI[i] = unlist(mat2.Full[m])[2]
    strip2$mFull.upper.CI[i] = unlist(mat2.Full[m])[3]
    
    m=m+1
  }
  
}

strip2$m0.lower.CI = substr(strip2$m0.lower.CI,2, 5)
strip2$m0.upper.CI = substr(strip2$m0.upper.CI,1, 4)
strip2$m1.lower.CI = substr(strip2$m1.lower.CI,2, 5)
strip2$m1.upper.CI = substr(strip2$m1.upper.CI,1, 4)
strip2$m2.lower.CI = substr(strip2$m2.lower.CI,2, 5)
strip2$m2.upper.CI = substr(strip2$m2.upper.CI,1, 4)
strip2$m3.lower.CI = substr(strip2$m3.lower.CI,2, 5)
strip2$m3.upper.CI = substr(strip2$m3.upper.CI,1, 4)
strip2$m4.lower.CI = substr(strip2$m4.lower.CI,2, 5)
strip2$m4.upper.CI = substr(strip2$m4.upper.CI,1, 4)
strip2$mFull.lower.CI = substr(strip2$mFull.lower.CI,2, 5)
strip2$mFull.upper.CI = substr(strip2$mFull.upper.CI,1, 4)


strip2$m0.OR = as.numeric(strip2$m0.OR)
strip2$m0.lower.CI = as.numeric(strip2$m0.lower.CI)
strip2$m0.upper.CI = as.numeric(strip2$m0.upper.CI)

strip2$m1.OR = as.numeric(strip2$m1.OR)
strip2$m1.lower.CI = as.numeric(strip2$m1.lower.CI)
strip2$m1.upper.CI = as.numeric(strip2$m1.upper.CI)

strip2$m2.OR = as.numeric(strip2$m2.OR)
strip2$m2.lower.CI = as.numeric(strip2$m2.lower.CI)
strip2$m2.upper.CI = as.numeric(strip2$m2.upper.CI)

strip2$m3.OR = as.numeric(strip2$m3.OR)
strip2$m3.lower.CI = as.numeric(strip2$m3.lower.CI)
strip2$m3.upper.CI = as.numeric(strip2$m3.upper.CI)

strip2$m4.OR = as.numeric(strip2$m4.OR)
strip2$m4.lower.CI = as.numeric(strip2$m4.lower.CI)
strip2$m4.upper.CI = as.numeric(strip2$m4.upper.CI)

strip2$mFull.OR = as.numeric(strip2$mFull.OR)
strip2$mFull.lower.CI = as.numeric(strip2$mFull.lower.CI)
strip2$mFull.upper.CI = as.numeric(strip2$mFull.upper.CI)






## probably move
colnames(strip2)[c(1)] = c('Psych')

strip2$psy.var = paste(strip2$Psych, strip2$level, sep="\n")



### Lengthen format 
strip2.long = cbind(unname(strip2[,c(1:2,28,10:12)]),Model='Age & Sex')
strip2.long = rbind(strip2.long, cbind(unname(strip2[,c(1:2,28,13:15)]),Model='Age,Sex,Ethnicity'),
                    cbind(unname(strip2[,c(1:2,28,16:18)]),Model='+Comorbidity'),
                    cbind(unname(strip2[,c(1:2,28,19:21)]),Model='+Lifestyle'),
                    cbind(unname(strip2[,c(1:2,28,22:24)]),Model='+Socioeconomic'),
                    cbind(unname(strip2[,c(1:2,28,25:27)]),Model='Full')
)
colnames(strip2.long)[1:6] = c('Psychological','level','psy.var','OR','lower.CI','upper.CI')

# strip2.long$psy.var = factor(strip2.long$psy.var,
#                             levels=c(
#                               "Educational attainment\n(Degree)",
#                               "Educational attainment\n(Other qualifications)",
#                               "Educational attainment\n(No qualifications)",
#                               "Annual household income\n(<£18,000)",
#                               "Annual household incomex\n(£18,000-£30,999)",
#                               "Annual household income\n(£31,000-£51,999)",
#                               "Annual household income\n(£52,000-£100,000)",
#                               "Annual household income\n(>£100,000)",
#                               "Townsend Deprivation Index\n(1)",
#                               "Townsend Deprivation Index\n(2)",
#                               "Townsend Deprivation Index\n(3)"
#                             ))
# levels(strip2.long$se.var) = c(
# )
# ...


strip2.long.SD = strip2.long[strip2.long$level %in% c("(Per SD increase)","(Per SD decrease)","(Yes)"),]

strip2.long.SD$psy.var = factor(strip2.long.SD$psy.var,
                            levels=c("Psychological distress\n(Per SD increase)",
                                     "Psychiatric consultation\n(Yes)",
                                     "Neuroticism\n(Per SD increase)",
                                     "Verbal numerical reasoning\n(Per SD decrease)",
                                     "Reaction time\n(Per SD increase)"
                            ))

#strip2.long.SD = strip2.long.SD[strip2.long.SD$Model!='Full',]




# strip2$psych.var = paste(strip2$Psych, strip2$level, sep="\n")
# 
# 
# strip2$m1.OR = as.numeric(strip2$m1.OR)
# strip2$m1.lower.CI = as.numeric(strip2$m1.lower.CI)
# strip2$m1.upper.CI = as.numeric(strip2$m1.upper.CI)
# 
# 
# 
# ### "Fully" controlled Model
# strip.mat = matrix(strsplit(strip2$Full[strip2$Full!="1.0 (ref)"]," ")
#                    #,ncol=3, byrow=TRUE
# )
# 
# strip2$mFull.OR = 1
# strip2$mFull.lower.CI = NA
# strip2$mFull.upper.CI = NA
# m = 1
# for (i in 1:dim(strip2[1])){
#   if(strip2$Full[i]!="1.0 (ref)") {
#     strip2$mFull.OR[i] = unlist(strip.mat[m])[1]
#     strip2$mFull.lower.CI[i] = unlist(strip.mat[m])[2]
#     strip2$mFull.upper.CI[i] = unlist(strip.mat[m])[3]
#     m=m+1
#   }
#   
# }
# 
# strip2$mFull.lower.CI = substr(strip2$mFull.lower.CI,2, 5)
# strip2$mFull.upper.CI = substr(strip2$mFull.upper.CI,1, 4)
# 
# 
# strip2$mFull.OR = as.numeric(strip2$mFull.OR)
# strip2$mFull.lower.CI = as.numeric(strip2$mFull.lower.CI)
# strip2$mFull.upper.CI = as.numeric(strip2$mFull.upper.CI)



### Lengthen format 
# strip.long = cbind(unname(strip2[,c('Psych','level','psych.var','m1.OR','m1.lower.CI','m1.upper.CI')]),Model='Age,Sex,Ethnicity')
# strip.long = rbind(strip.long, cbind(unname(strip2[,c('Psych','level','psych.var','mFull.OR','mFull.lower.CI','mFull.upper.CI')]),Model='Full'))
# colnames(strip.long)[1:6] = c('Psych','level','psych.var','OR','lower.CI','upper.CI')
#                




#strip.long = strip.long[strip.long$level %in% c("1 (low)","2","3","Yes","No"),]



### Plot - skip to SD for psych vars

g = ggplot(data = strip2.long, aes(x=psy.var, 
                              y=OR, ymin=lower.CI, ymax=upper.CI,
                              color=Model
                              ))+
  geom_pointrange(position=position_dodge(width=0.5)) +
  #geom_point(aes(y=min, color='blue'))+
  #geom_point(aes(y=max, color='red'))+
  geom_hline(yintercept = 1, lty=2)+
  #scale_y_continuous(breaks = c(60,70,80,90,100,110,120,130,140), limits=c(80,125))+
  coord_flip()+
  #facet_grid(.~Psych)
  xlab('Psychological variable and level') + ylab('Odds ratio (95% CI)')+
  theme_classic()+theme(legend.position = c(0.85,0.15),
                   legend.background = element_rect(#fill="lightblue",
                                                     size=0.5, linetype="solid", 
                                                     colour ="darkblue"))
#g



### By SD 

g.SD = ggplot(data = strip2.long.SD, aes(x=psy.var, 
                                  y=OR, ymin=lower.CI, ymax=upper.CI,
                                  color=Model
))+
  geom_pointrange(lwd=1, position=position_dodge(width=-0.5)) +
  #geom_point(aes(y=min, color='blue'))+
  #geom_point(aes(y=max, color='red'))+
  geom_hline(yintercept = 1, lty=2)+
  #scale_y_continuous(breaks = c(60,70,80,90,100,110,120,130,140), limits=c(80,125))+
  coord_flip()+
  #facet_grid(.~Psych)
  #xlab('Psychological variable')
  xlab('') + ylab('Odds ratio (95% CI)')+
  theme_classic()+theme(legend.position = c(0.85,0.5),
                        legend.background = element_rect(#fill="lightblue",
                          size=0.5, linetype="solid", 
                          colour ="darkblue"),
                        text = element_text(size=15))

g.SD 




### Socioeconomic variables

tab3 = read_xlsx("./BattyCOVID/Table3.xlsx")

#strip3 = tab3[,c(1:8,10)]
strip3 = tab3

strip3 = strip3[!(strip3$level=='P for trend'|is.na(strip3$level)),]


### Age, sex, ethnicity Model
mat3.as = matrix(strsplit(strip3$`Age & sex`[strip3$`Age & sex`!="1.0 (ref)"]," "))
mat3.ase = matrix(strsplit(strip3$`Age, sex & ethnicity`[strip3$`Age, sex & ethnicity`!="1.0 (ref)"]," "))
mat3.aseCo = matrix(strsplit(strip3$`Age, sex, ethnicity & comorbidity2`[strip3$`Age, sex, ethnicity & comorbidity2`!="1.0 (ref)"]," "))
mat3.aseL = matrix(strsplit(strip3$`Age, sex, ethnicity & lifestyle factors3`[strip3$`Age, sex, ethnicity & lifestyle factors3`!="1.0 (ref)"]," "))
mat3.aseP = matrix(strsplit(strip3$`Age, sex, ethnicity & psychological factors4`[strip3$`Age, sex, ethnicity & psychological factors4`!="1.0 (ref)"]," "))
mat3.Full = matrix(strsplit(strip3$`Adjusted for all covariates`[strip3$`Adjusted for all covariates`!="1.0 (ref)"]," "))

strip3$m0.OR = 1 # age, sex
strip3$m0.lower.CI = NA
strip3$m0.upper.CI = NA

strip3$m1.OR = 1 # age, sex, eth
strip3$m1.lower.CI = NA
strip3$m1.upper.CI = NA

strip3$m2.OR = 1 # + comorbidity
strip3$m2.lower.CI = NA
strip3$m2.upper.CI = NA

strip3$m3.OR = 1 # + lifestyle
strip3$m3.lower.CI = NA
strip3$m3.upper.CI = NA

strip3$m4.OR = 1 # + psych
strip3$m4.lower.CI = NA
strip3$m4.upper.CI = NA

strip3$mFull.OR = 1 # adjusted for all covariates
strip3$mFull.lower.CI = NA
strip3$mFull.upper.CI = NA

m = 1
for (i in 1:dim(strip3[1])){
  if(strip3$`Age, sex & ethnicity`[i]!="1.0 (ref)") {
    strip3$m0.OR[i] = unlist(mat3.as[m])[1]
    strip3$m0.lower.CI[i] = unlist(mat3.as[m])[2]
    strip3$m0.upper.CI[i] = unlist(mat3.as[m])[3]
    
    strip3$m1.OR[i] = unlist(mat3.ase[m])[1]
    strip3$m1.lower.CI[i] = unlist(mat3.ase[m])[2]
    strip3$m1.upper.CI[i] = unlist(mat3.ase[m])[3]
    
    strip3$m2.OR[i] = unlist(mat3.aseCo[m])[1]
    strip3$m2.lower.CI[i] = unlist(mat3.aseCo[m])[2]
    strip3$m2.upper.CI[i] = unlist(mat3.aseCo[m])[3]
    
    strip3$m3.OR[i] = unlist(mat3.aseL[m])[1]
    strip3$m3.lower.CI[i] = unlist(mat3.aseL[m])[2]
    strip3$m3.upper.CI[i] = unlist(mat3.aseL[m])[3]
    
    strip3$m4.OR[i] = unlist(mat3.aseP[m])[1]
    strip3$m4.lower.CI[i] = unlist(mat3.aseP[m])[2]
    strip3$m4.upper.CI[i] = unlist(mat3.aseP[m])[3]
    
    strip3$mFull.OR[i] = unlist(mat3.Full[m])[1]
    strip3$mFull.lower.CI[i] = unlist(mat3.Full[m])[2]
    strip3$mFull.upper.CI[i] = unlist(mat3.Full[m])[3]
    
    m=m+1
  }
  
}

strip3$m0.lower.CI = substr(strip3$m0.lower.CI,2, 5)
strip3$m0.upper.CI = substr(strip3$m0.upper.CI,1, 4)
strip3$m1.lower.CI = substr(strip3$m1.lower.CI,2, 5)
strip3$m1.upper.CI = substr(strip3$m1.upper.CI,1, 4)
strip3$m2.lower.CI = substr(strip3$m2.lower.CI,2, 5)
strip3$m2.upper.CI = substr(strip3$m2.upper.CI,1, 4)
strip3$m3.lower.CI = substr(strip3$m3.lower.CI,2, 5)
strip3$m3.upper.CI = substr(strip3$m3.upper.CI,1, 4)
strip3$m4.lower.CI = substr(strip3$m4.lower.CI,2, 5)
strip3$m4.upper.CI = substr(strip3$m4.upper.CI,1, 4)
strip3$mFull.lower.CI = substr(strip3$mFull.lower.CI,2, 5)
strip3$mFull.upper.CI = substr(strip3$mFull.upper.CI,1, 4)


strip3$m0.OR = as.numeric(strip3$m0.OR)
strip3$m0.lower.CI = as.numeric(strip3$m0.lower.CI)
strip3$m0.upper.CI = as.numeric(strip3$m0.upper.CI)

strip3$m1.OR = as.numeric(strip3$m1.OR)
strip3$m1.lower.CI = as.numeric(strip3$m1.lower.CI)
strip3$m1.upper.CI = as.numeric(strip3$m1.upper.CI)

strip3$m2.OR = as.numeric(strip3$m2.OR)
strip3$m2.lower.CI = as.numeric(strip3$m2.lower.CI)
strip3$m2.upper.CI = as.numeric(strip3$m2.upper.CI)

strip3$m3.OR = as.numeric(strip3$m3.OR)
strip3$m3.lower.CI = as.numeric(strip3$m3.lower.CI)
strip3$m3.upper.CI = as.numeric(strip3$m3.upper.CI)

strip3$m4.OR = as.numeric(strip3$m4.OR)
strip3$m4.lower.CI = as.numeric(strip3$m4.lower.CI)
strip3$m4.upper.CI = as.numeric(strip3$m4.upper.CI)

strip3$mFull.OR = as.numeric(strip3$mFull.OR)
strip3$mFull.lower.CI = as.numeric(strip3$mFull.lower.CI)
strip3$mFull.upper.CI = as.numeric(strip3$mFull.upper.CI)




## probably move
colnames(strip3)[c(1)] = c('Socioeconomic')
strip3$se.var = paste(strip3$Socioeconomic, strip3$level, sep="_")




### Lengthen format 
strip3.long = cbind(unname(strip3[,c(1:2,28,10:12)]),Model='Age & Sex')
strip3.long = rbind(strip3.long, cbind(unname(strip3[,c(1:2,28,13:15)]),Model='Age,Sex,Ethnicity'),
                    cbind(unname(strip3[,c(1:2,28,16:18)]),Model='+Comorbidity'),
                    cbind(unname(strip3[,c(1:2,28,19:21)]),Model='+Lifestyle'),
                    cbind(unname(strip3[,c(1:2,28,22:24)]),Model='+Psychological'),
                    cbind(unname(strip3[,c(1:2,28,25:27)]),Model='Full')
)

colnames(strip3.long)[1:6] = c('Socioeconomic','level','se.var','OR','lower.CI','upper.CI')

strip3.long$se.var = factor(strip3.long$se.var,
                            levels=c(
                              "Educational attainment_(Degree)",
                              "Educational attainment_(Other qualifications)",
                              "Educational attainment_(No qualifications)",
                              "Annual household income_(<£18,000)",
                              "Annual household income_(£18,000-£30,999)",
                              "Annual household income_(£31,000-£51,999)",
                              "Annual household income_(>£52,000)",
                              "Neighbourhood deprivation_(1)",
                              "Neighbourhood deprivation_(2)",
                              "Neighbourhood deprivation_(3)",
                              "Occupational classification_(Managers & Senior Officials, Professional, Associate Professional & Technical)",
                              "Occupational classification_(Administrative & Secretarial, Skilled trades)",
                              "Occupational classification_(Personal service, Sales & Customer service, Process, Plant & Machine Operatives, Elementary)"
 ))
#levels(strip3.long$se.var)
levels(strip3.long$se.var)[1:13] = c(
  "Educational attainment\n(Degree - Reference)",
  "(Other qualifications)",
  "(No qualifications)",
  "Annual household income\n(<£18,000)",
  "(£18,000-£30,999)",
  "(£31,000-£51,999)",
  "(>£52,000 - Reference)",
  "Neighbourhood deprivation \n(Low - Reference)",
  "(Middle)",
  "(High)",
  "Occupational classification\n(Managers, senior officials,\netc - Reference)",
  "(Administrative & secretarial, etc)",
  "(Personal service, etc)"
  )
strip3.long$se.var <- factor(strip3.long$se.var, levels=rev(levels(strip3.long$se.var)))

# For David's meeting, rm Full, Townsend
#strip3.long = strip3.long[strip3.long$Model!='Full',]
#strip3.long = strip3.long[strip3.long$Socioeconomic!='Annual household income',]

g.se = ggplot(data = strip3.long, aes(x=se.var, 
                                  y=OR, ymin=lower.CI, ymax=upper.CI,
                                  color=Model
))+
  geom_pointrange(lwd=0.9, position=position_dodge(width=-0.8)) +
  #geom_point(aes(y=min, color='blue'))+
  #geom_point(aes(y=max, color='red'))+
  geom_hline(yintercept = 1, lty=2)+
  #scale_y_continuous(breaks = c(60,70,80,90,100,110,120,130,140), limits=c(80,125))+
  coord_flip()+
  #scale_x_discrete(labels=c("A"=expression(bold(A)), "C"=expression(bold(C)),
  #                          "E"=expression(bold(E)), parse=TRUE)) +
  #facet_grid(.~Psych)
  xlab('') + ylab('Odds ratio (95% CI)')+
  theme_classic()+theme(legend.position = c(0.85,0.5)#c(0.85,0.15),
                        , legend.background = element_rect(size=0.5, linetype="solid",colour ="darkblue")
                        , text = element_text(size=17))

g.se + scale_color_manual(values=(hue_pal()(7)[c(1:3,5:7)]))

                          