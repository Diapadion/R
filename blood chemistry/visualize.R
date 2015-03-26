
median.quartile <- function(x){
  out <- quantile(x, probs = c(0.25,0.5,0.75))
  names(out) <- c("ymin","y","ymax")
  return(out) 
}
median.line <- function(x){
  out <- quantile(x, probs = 0.5)
  names(out) <- "y"
  return(out) 
}


library(texreg)
setwd("C:/Users/s1229179/git-repos/R/blood chemistry/Drew version/")

tbl1 = htmlreg(m_1)
print.texregTable(tbl1)

tbl2a = htmlreg(m_2a)
print.texregTable(tbl2a)

tbl2b = htmlreg(m_2b)
print.texregTable(tbl2b)

#---

tbl2c1 = htmlreg(m_2c)
print.texregTable(tbl2c1)

tbl2c2 = htmlreg(c(m_2c,m2c1,m2c2))
print.texregTable(tbl2c2)

tbl2c3 = htmlreg(c(m_2c,m2c1,m2c2,m2c0))
print.texregTable(tbl2c3)

tbl2c4 = htmlreg(c(m_2c,m2c1,m2c2,m2c0,m2c3))
print.texregTable(tbl2c4)

#--- 24/03/2015

sys.tbl = htmlreg(list(m.sys,m_1))
write(sys.tbl,"sys.html")

chol.tbl = htmlreg(list(m.chol,m_2a))
write(chol.tbl,"chol.html")

trig.tbl = htmlreg(list(m.trig,m_2b))
write(trig.tbl,"trig.html")

gluco.tbl = htmlreg(list(m.gluc,m_2c))
write(gluco.tbl,"gluco.html")

creat.tbl = htmlreg(list(m.creat,m2u))
write(creat.tbl,"creat.html")

alkphos.tbl = htmlreg(list(m.alp,m2w))
write(alkphos.tbl,"alkphos.html")


print.texregTable(tbl2c3)


#--- for 27/03/2015

#sys.tbl

sys.tbl = htmlreg(list(m.sys,mj.sys,m1a), custom.model.names=c('Americans','Japanese','Chimpanzees'), ci.force=TRUE)
write(sys.tbl,"sys.html")

trig.tbl = htmlreg(list(m.trig,mj.trig,m2.trig), custom.model.names=c('Americans','Japanese','Chimpanzees'), ci.force=TRUE)
write(trig.tbl,"trig.html")

chol.tbl = htmlreg(list(m.chol,mj.chol,m2.chol), custom.model.names=c('Americans','Japanese','Chimpanzees'), ci.force=TRUE)
write(chol.tbl,"chol.html")

creat.tbl = htmlreg(list(m.creat,mj.creat,m2.creat), custom.model.names=c('Americans','Japanese','Chimpanzees'), ci.force=TRUE)
write(creat.tbl,"creat.html")

### ggplot 
library(ggplot2)

#first try - personality dimension distributions, side by side violin/bean plots

vpers<-data.frame(Sample=character(),Dimension=character(),Score=numeric())

vpers = rbind(
  cbind(Sample="Yerkes", Dimension="Dominance", Score=(((output$dom - 1) / 2) + 1)),
  cbind(Sample="Yerkes", Dimension="Neuroticism", Score=(((output$neuro - 1) / 2) + 1)),
  cbind(Sample="Yerkes", Dimension="Extraversion", Score=(((output$extra - 1) / 2) + 1)),
  cbind(Sample="Yerkes", Dimension="Agreeableness", Score=(((output$agree - 1) / 2) + 1)),
  cbind(Sample="Yerkes", Dimension="Conscientiousness", Score=(((output$cons - 1) / 2) + 1)),
  cbind(Sample="Yerkes", Dimension="Openness", Score=(((output$open - 1) / 2) + 1)),
  cbind(Sample="MIDUS", Dimension="Neuroticism", Score=midus_c$B1SNEURO),
  cbind(Sample="MIDUS", Dimension="Dominance", Score=midus_c$B1SAGENC),
  cbind(Sample="MIDUS", Dimension="Agreeableness", Score=midus_c$B1SAGREE),
  cbind(Sample="MIDUS", Dimension="Conscientiousness", Score=midus_c$B1SCONS2),
  cbind(Sample="MIDUS", Dimension="Extraversion", Score=midus_c$B1SEXTRA),
  cbind(Sample="MIDUS", Dimension="Openness", Score=midus_c$B1SOPEN),
  cbind(Sample="MIDJA", Dimension="Agreeableness", Score=midja_c$J1SAGREE),
  cbind(Sample="MIDJA", Dimension="Neuroticism", Score=midja_c$J1SNEURO),
  cbind(Sample="MIDJA", Dimension="Conscientiousness", Score=midja_c$J1SCONS2),
  cbind(Sample="MIDJA", Dimension="Extraversion", Score=midja_c$J1SEXTRA),
  cbind(Sample="MIDJA", Dimension="Dominance", Score=midja_c$J1SAGENC),
  cbind(Sample="MIDJA", Dimension="Openness", Score=midja_c$J1SOPEN))
vpers<-data.frame(Sample=vpers[,1],Dimension=vpers[,2],Score=as.numeric(as.character(vpers[,3])))
  
violpers <- ggplot(vpers, aes(x=Sample, y=Score, group=Sample)) + geom_violin(trim=TRUE, aes(fill = factor(Sample))) +
  facet_wrap(~Dimension) + 
  stat_summary(fun.y=median.quartile,geom='point') + 
  stat_summary(fun.y=median.line,geom='point') +
  geom_segment(aes(x=Sample-0.1, xend=Sample+0.1, y=Score, yend=Score), colour='white') + theme_bw()


vbio <- NULL
vbio <- rbind(
  cbind(Sample="Yerkes",Marker="Diastolic BP",Value=output$dias),
  cbind(Sample="Yerkes",Marker='Systolic BP',Value=output$sys),
  cbind(Sample="Yerkes",Marker='BMI',Value=output$BMI),
  cbind(Sample="Yerkes",Marker='Cholesterol',Value=output$chol),
  cbind(Sample="Yerkes",Marker='Triglycerides',Value=output$trig),
  cbind(Sample="Yerkes",Marker='Creatinine',Value=output$creatinine),
  cbind(Sample="MIDUS",Marker='Diastolic BP',Value=midus_c$B4P1GD),
  cbind(Sample="MIDUS",Marker='Systolic BP',Value=midus_c$B4P1GS),
  cbind(Sample="MIDUS",Marker='BMI',Value=midus_c$B4PBMI),
  cbind(Sample="MIDUS",Marker='Cholesterol',Value=midus_c$B4BCHOL),
  cbind(Sample="MIDUS",Marker='Triglycerides',Value=midus_c$B4BTRIGL),
  cbind(Sample="MIDUS",Marker='Creatinine',Value=midus_c$B4BSCREA),
  cbind(Sample="MIDJA",Marker='Diastolic BP',Value=midja_c$J2CBPS23),
  cbind(Sample="MIDJA",Marker='Systolic BP',Value=midja_c$J2CBPD23),
  cbind(Sample="MIDJA",Marker='BMI',Value=midja_c$J2CBMI),
  cbind(Sample="MIDJA",Marker='Cholesterol',Value=midja_c$J2BCHOL),
  cbind(Sample="MIDJA",Marker='Triglycerides',Value=midja_c$J2CTRIG),
  cbind(Sample="MIDJA",Marker='Creatinine',Value=midja_c$J2BSCREA)
  )
vbio<-data.frame(Sample=vbio[,1],Marker=vbio[,2],Value=as.numeric(as.character(vbio[,3])))

vbpbio <- ggplot(vbio, aes(x=Sample, y=Value, group=Sample)) + geom_boxplot(trim=TRUE, aes(fill = factor(Sample)))
  + stat_summary(fun.y=median.quartile,geom='point') + 
  stat_summary(fun.y=median.line,geom='point') +
  geom_segment(aes(x=Sample-0.1, xend=Sample+0.1, y=Value, yend=Value), colour='white')
vbpbio + facet_wrap(~ Marker, scales = "free_y") + theme_bw()
vbpbio

# violtest <- ggplot(diamonds, aes(x=color, y=depth, group=color)) +
#   geom_boxplot(trim=TRUE, aes(fill = factor(color))) +
#   facet_wrap(~ clarity, scales = "free_y") + theme_bw()
# 
# violtest


library(reshape2)
# vmregs <- reshape(midus_cs, direction="long", varying=NULL,
#                   v.names=c('Dominance','Extraversion','Openness',
#                             'Conscientiousness','Agreeableness','Neuroticism'))
vmregs <- melt(midus_cs[,1:15], id.vars=c('M2ID','sex','age','chol','creat','trig','BMI','sys','dias'))
vmregs$Sample = 'MIDUS'
vjregs <- melt(midja_cs[,1:15], id.vars=c('MIDJA_IDS','sex','age','chol','creat','trig','BMI','sys','dias'))
vjregs$Sample = 'MIDJA'
colnames(vjregs)[1]<-'M2ID'
#vmjregs <- merge(vmregs,vjregs,by=c('M2ID','age','sex','chol','creat','BMI','sys','dias','trig','variable','value'))
vmjregs <- rbind(vmregs,vjregs)

simp_mean=cbind(imp_mean$imputations$imp7[,1:2],apply(imp_mean$imputations$imp7[,3:20], c(2), scale))

vcregs <- melt(simp_mean[,1:15], id.vars=c('Chimp','sex','age','chol','creat','trig','BMI','sys','dias'))
vcregs$Sample = 'Yerkes'
colnames(vcregs)[1]<-'M2ID'

vmjcregs <- rbind(vmjregs,vcregs)
              
colnames(vmjcregs)[2:11]<-c('Sex','Age','Cholesterol','Creatinine','Triglycerides',
                           'BMI','Systolic BP','Diastolic BP','Personality','Score')

# one each for all the biomarkers ... i.e. long format

# vcregs <- with(data=meandat,data.frame(Chimp=chimp,Sex=sex,Age=age,
#                                        Cholesterol=chol,Creatinine=creatinine,Triglycerides=trig,
#                                        BMI=BMI,Systolic=sys,Diastolic=dias,
#                                        Dominance=dom,Extraversion=extra,Openness=open,
#                                        Conscientiousness=cons,Agreeableness=agree,Neuroticism=neuro))
#                                        


### let the ggplotting fuck begin


vregs <- ggplot(vmjcregs, aes(y=Cholesterol,x=Score,colour=Sample)) + 
  stat_smooth(method=lm 
            #  , formula="Cholesterol ~ Dominance + Neuroticism + Agreeableness + Extraversion + Conscientiousness + Openness
            #  + Sex + BMI + Age + 1"
              ) #+ 
  facet_wrap(~Personality)

vregs + geom_point()
# vregs + geom_line(data=meandat, 
#               aes(ymin=lwr,ymax=upr)
  
#vregs + geom_abline(aes(intercept=coef(m.chol[1])), slope = coef(m.chol[5]))


# new predictions for lmer's


cForPreds <-  data.frame(scoutput[,6:11]
  #,scoutput$age,scoutput$BMI,scoutput$sex
  )
cForPreds = data.frame(dom=scoutput$dom)

cchol.d.preds = predict(m2.chol
                        #scoutput[,6:11])
                        #expand.grid(scoutput[,6:11],scoutput$age,scoutput$BMI,scoutput$sex)) # BE CAREFUL
    #                    , newdata=cForPreds
                        )




cchol.preds = data.frame(
  rbind(
    cbind(Cholesterol=cchol.preds,lwr=cchol.preds-fixef(m2.chol)[2],upr=cchol.preds+fixef(m2.chol)[2],Dimension="Dominance"),
    cbind(Cholesterol=cchol.preds,lwr=cchol.preds-fixef(m2.chol)[3],upr=cchol.preds+fixef(m2.chol)[3],Dimension="Extraversion")
  ))


vregs + geom_smooth(data=cchol.preds, aes(ymin=lwr,ymax=upr,fill='Yerkes'),alpha=0.3) #+              
             
              

vregs <- ggplot(, aes(y=carat, x=price)) + facet_grid(. ~ cut)
c + stat_smooth(method=lm, fullrange = TRUE) + geom_point()
c + stat_smooth(method=lm) + geom_point
  


#library(ez)
#cchol.preds = ezPredict(m2.chol)
cchol.preds = confint(m2.chol)

library(effects)
        
              

fixed.chol = data.frame(fixef(m2.chol))

vregs + geom_abline(intercept=fixed.chol[1,1],slope=fixed.chol[5,1] + theme_bw())


library(arm)
sim.m2.chol = sim(m2.chol)
coefplot(sim.m2.chol)


install.packages("coefplot2",
                 repos="http://www.math.mcmaster.ca/bolker/R",
                 type="source")
