
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


setwd("./Drew version/")
library(texreg)

# Old chimp only models
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



                   
### (gg?)plot(s)

#first try - personality dimension distributions, side by side violin/bean plots

vpers<-data.frame(Sample=character(),Dimension=character(),Score=numeric(), Sex=factor)

vpers = rbind(
  cbind(Sample="Yerkes", Dimension="Dominance", Score=(((output$dom - 1) / 2) + 1),Sex=output$sex),
  cbind(Sample="Yerkes", Dimension="Neuroticism", Score=(((output$neuro - 1) / 2) + 1),Sex=output$sex),
  cbind(Sample="Yerkes", Dimension="Extraversion", Score=(((output$extra - 1) / 2) + 1),Sex=output$sex),
  cbind(Sample="Yerkes", Dimension="Agreeableness", Score=(((output$agree - 1) / 2) + 1),Sex=output$sex),
  cbind(Sample="Yerkes", Dimension="Conscientiousness", Score=(((output$cons - 1) / 2) + 1),Sex=output$sex),
  cbind(Sample="Yerkes", Dimension="Openness", Score=(((output$open - 1) / 2) + 1),Sex=output$sex),
  cbind(Sample="Americans", Dimension="Neuroticism", Score=midus_c$B1SNEURO,Sex=midus_c$B1PRSEX),
  cbind(Sample="Americans", Dimension="Dominance", Score=midus_c$B1SAGENC,Sex=midus_c$B1PRSEX),
  cbind(Sample="Americans", Dimension="Agreeableness", Score=midus_c$B1SAGREE,Sex=midus_c$B1PRSEX),
  cbind(Sample="Americans", Dimension="Conscientiousness", Score=midus_c$B1SCONS2,Sex=midus_c$B1PRSEX),
  cbind(Sample="Americans", Dimension="Extraversion", Score=midus_c$B1SEXTRA,Sex=midus_c$B1PRSEX),
  cbind(Sample="Americans", Dimension="Openness", Score=midus_c$B1SOPEN,Sex=midus_c$B1PRSEX),
  cbind(Sample="Japanese", Dimension="Agreeableness", Score=midja_c$J1SAGREE,Sex=midja_c$J1SQ1),
  cbind(Sample="Japanese", Dimension="Neuroticism", Score=midja_c$J1SNEURO,Sex=midja_c$J1SQ1),
  cbind(Sample="Japanese", Dimension="Conscientiousness", Score=midja_c$J1SCONS2,Sex=midja_c$J1SQ1),
  cbind(Sample="Japanese", Dimension="Extraversion", Score=midja_c$J1SEXTRA,Sex=midja_c$J1SQ1),
  cbind(Sample="Japanese", Dimension="Dominance", Score=midja_c$J1SAGENC,Sex=midja_c$J1SQ1),
  cbind(Sample="Japanese", Dimension="Openness", Score=midja_c$J1SOPEN,Sex=midja_c$J1SQ1))
vpers<-data.frame(Sample=vpers[,1],Dimension=vpers[,2],Score=as.numeric(as.character(vpers[,3])),Sex=as.factor(vpers[,4]))

library(beanplot)

svg(filename="PersBSPID.svg",            
    width=10, 
    height=8, 
    pointsize=12,
    bg='white')
par(mfrow=c(2,3),
    oma = c(5,4,0,0) + 0.3,
    mar = c(0,0,1,1) + 0.5)
beanpersD <- with(data=vpers[vpers$Dimension=='Dominance',], beanplot(Score ~ Sex * Sample, side = 'both', bw = 0.3, cutmax = 4, cutmin = 1,
                                                                     overallline = "median", beanlines = 'median', what = c(0,1,1,0), boxwex=0.9,
                                                                     col = list("cadetblue3", "cadetblue1", "royalblue3", "royalblue1","slateblue","slateblue1"),
                                                                     main='Dominance' , show.names=FALSE)
)

beanpersA <- with(data=vpers[vpers$Dimension=='Agreeableness',], beanplot(Score ~ Sex * Sample, side = 'both', bw = 0.3, cutmax = 4, cutmin = 1,
                                                                         overallline = "median", beanlines = 'median', what = c(0,1,1,0), boxwex=0.9,
                                                                         col = list("cadetblue3", "cadetblue1", "royalblue3", "royalblue1","slateblue","slateblue1"),
                                                                         main='Agreeableness' , show.names=FALSE 
                                                                         )
)
beanpersN <- with(data=vpers[vpers$Dimension=='Neuroticism',], beanplot(Score ~ Sex * Sample, side = 'both', bw = 0.3, cutmax = 4, cutmin = 1,
                                                                       overallline = "median", beanlines = 'median', what = c(0,1,1,0), boxwex=0.9,
                                                                       col = list("cadetblue3", "cadetblue1", "royalblue3", "royalblue1","slateblue","slateblue1"),
                                                                       main='Neuroticism' , show.names=FALSE)
)
beanpersO <- with(data=vpers[vpers$Dimension=='Openness',], beanplot(Score ~ Sex * Sample, side = 'both', bw = 0.3, cutmax = 4, cutmin = 1,
                                                                    overallline = "median", beanlines = 'median', what = c(0,1,1,0), boxwex=0.9,
                                                                    col = list("cadetblue3", "cadetblue1", "royalblue3", "royalblue1","slateblue","slateblue1"),
                                                                    main='Openness' 
                                                                    ))

beanpersC <- with(data=vpers[vpers$Dimension=='Conscientiousness',], beanplot(Score ~ Sex * Sample, side = 'both', bw = 0.3, cutmax = 4, cutmin = 1,
                                                                             overallline = "median", beanlines = 'median', what = c(0,1,1,0), boxwex=0.9,
                                                                             col = list("cadetblue3", "cadetblue1", "royalblue3", "royalblue1","slateblue","slateblue1")
                                                                             , main='Conscientiousness'
                                                                             )
)

beanpersE <- with(data=vpers[vpers$Dimension=='Extraversion',], 
                 beanplot(Score ~ Sex * Sample, side = 'both', bw = 0.3, cutmax = 4, cutmin = 1,
                          overallline = "median", beanlines = 'median', what = c(0,1,1,0), boxwex=0.9,
                          col = list("cadetblue3", "cadetblue1", "royalblue3", "royalblue1","slateblue","slateblue1")
                          , main='Extraversion' #, yaxt=''
                          ))
dev.off()





library(ggplot2)
violpers <- ggplot(vpers, aes(x=Sample, y=Score, group=Sample)) + geom_violin(trim=TRUE, aes(fill = factor(Sample))) +
  facet_wrap(~Dimension) + 
  stat_summary(fun.y=median.quartile,geom='point') + 
  stat_summary(fun.y=median.line,geom='point') +
  geom_segment(aes(x=Sample-0.1, xend=Sample+0.1, y=Score, yend=Score), colour='white') + theme_bw()

ggsave(filename = 'viol_pers.png', plot = violpers, 
       scale = 1, width = 12, height = 10,
       dpi = 300, limitsize = TRUE)

# some chi sq tests to accompany
with(vpers,chisq.test(table(Score[(Dimension=='Dominance')&(Sample=='MIDUS')]),
                      table(Score[(Dimension=='Dominance')&(Sample=='Yerkes')])))
                      
  Score[Dimension=='Dominance'&&Sample=='MIDUS'])


### now with the entire data set's worth of personality
vpersFull<-data.frame(Sample=character(),Dimension=character(),Score=numeric())

vpersFull = rbind(
  cbind(Sample="Yerkes", Dimension="Dominance", Score=(((output$dom - 1) / 2) + 1)),
  cbind(Sample="Yerkes", Dimension="Neuroticism", Score=(((output$neuro - 1) / 2) + 1)),
  cbind(Sample="Yerkes", Dimension="Extraversion", Score=(((output$extra - 1) / 2) + 1)),
  cbind(Sample="Yerkes", Dimension="Agreeableness", Score=(((output$agree - 1) / 2) + 1)),
  cbind(Sample="Yerkes", Dimension="Conscientiousness", Score=(((output$cons - 1) / 2) + 1)),
  cbind(Sample="Yerkes", Dimension="Openness", Score=(((output$open - 1) / 2) + 1)),
  cbind(Sample="MIDUS", Dimension="Neuroticism", Score=midusP1$B1SNEURO),
  cbind(Sample="MIDUS", Dimension="Dominance", Score=midusP1$B1SAGENC),
  cbind(Sample="MIDUS", Dimension="Agreeableness", Score=midusP1$B1SAGREE),
  cbind(Sample="MIDUS", Dimension="Conscientiousness", Score=midusP1$B1SCONS2),
  cbind(Sample="MIDUS", Dimension="Extraversion", Score=midusP1$B1SEXTRA),
  cbind(Sample="MIDUS", Dimension="Openness", Score=midusP1$B1SOPEN),
  cbind(Sample="MIDJA", Dimension="Agreeableness", Score=midja$J1SAGREE),
  cbind(Sample="MIDJA", Dimension="Neuroticism", Score=midja$J1SNEURO),
  cbind(Sample="MIDJA", Dimension="Conscientiousness", Score=midja$J1SCONS2),
  cbind(Sample="MIDJA", Dimension="Extraversion", Score=midja$J1SEXTRA),
  cbind(Sample="MIDJA", Dimension="Dominance", Score=midja$J1SAGENC),
  cbind(Sample="MIDJA", Dimension="Openness", Score=midja$J1SOPEN))
vpersFull<-data.frame(Sample=vpersFull[,1],Dimension=vpersFull[,2],Score=as.numeric(as.character(vpersFull[,3])))

violpFull <- ggplot(vpersFull, aes(x=Sample, y=Score, group=Sample)) + geom_violin(trim=TRUE, aes(fill = factor(Sample))) +
  facet_wrap(~Dimension) + 
  stat_summary(fun.y=median.quartile,geom='point') + 
  stat_summary(fun.y=median.line,geom='point') +
  geom_segment(aes(x=Sample-0.1, xend=Sample+0.1, y=Score, yend=Score), colour='white') + theme_bw()
#violpFull

ggsave(filename = 'viol_fullpers.png', plot = violpFull, 
       scale = 1, width = 12, height = 10,
       dpi = 300, limitsize = TRUE)


### framing and plotting of biomarker distrs
vbio <- NULL
vbio <- rbind(
  cbind(Sample="Yerkes",Marker="Diastolic BP",Value=output$dias, Sex=output$sex),
  cbind(Sample="Yerkes",Marker='Systolic BP',Value=output$sys,Sex=output$sex),
  cbind(Sample="Yerkes",Marker='BMI',Value=output$BMI,Sex=output$sex),
  cbind(Sample="Yerkes",Marker='Cholesterol',Value=output$chol,Sex=output$sex),
  cbind(Sample="Yerkes",Marker='Triglycerides',Value=output$trig,Sex=output$sex),
  cbind(Sample="Yerkes",Marker='Creatinine',Value=output$creatinine, Sex=output$sex),
  cbind(Sample="Americans",Marker='Diastolic BP',Value=midus_c$B4P1GD,Sex=midus_c$B1PRSEX),
  cbind(Sample="Americans",Marker='Systolic BP',Value=midus_c$B4P1GS,Sex=midus_c$B1PRSEX),
  cbind(Sample="Americans",Marker='BMI',Value=midus_c$B4PBMI,Sex=midus_c$B1PRSEX),
  cbind(Sample="Americans",Marker='Cholesterol',Value=midus_c$B4BCHOL,Sex=midus_c$B1PRSEX),
  cbind(Sample="Americans",Marker='Triglycerides',Value=midus_c$B4BTRIGL,Sex=midus_c$B1PRSEX),
  cbind(Sample="Americans",Marker='Creatinine',Value=midus_c$B4BSCREA,Sex=midus_c$B1PRSEX),
  cbind(Sample="Japanese",Marker='Diastolic BP',Value=midja_c$J2CBPD23,Sex=midja_c$J1SQ1),
  cbind(Sample="Japanese",Marker='Systolic BP',Value=midja_c$J2CBPS23,Sex=midja_c$J1SQ1),
  cbind(Sample="Japanese",Marker='BMI',Value=midja_c$J2CBMI,Sex=midja_c$J1SQ1),
  cbind(Sample="Japanese",Marker='Cholesterol',Value=midja_c$J2BCHOL,Sex=midja_c$J1SQ1),
  cbind(Sample="Japanese",Marker='Triglycerides',Value=midja_c$J2CTRIG,Sex=midja_c$J1SQ1),
  cbind(Sample="Japanese",Marker='Creatinine',Value=midja_c$J2BSCREA,Sex=midja_c$J1SQ1)
  )
vbio<-data.frame(Sample=vbio[,1],Marker=vbio[,2],Value=as.numeric(as.character(vbio[,3])),Sex=as.factor(vbio[,4]))


svg(filename="BiomarkBSPID.svg",            
     width=10, 
     height=8, 
     pointsize=12,
     bg='white')
par(mfrow=c(2,3),
    oma = c(5,4,0,0) + 0.3,
    mar = c(0,0,1,1) + 0.5)
beanBioBMI <- with(data=vbio[vbio$Marker=='BMI',], beanplot(Value ~ Sex * Sample, side = 'both', log = '',
                                                         bw = 5, main='BMI', show.names=FALSE,
                                                                     overallline = "median", beanlines = 'median', what = c(0,1,1,0), boxwex=0.9,
                                                                     col = list("cadetblue3", "cadetblue1", "royalblue3", "royalblue1","slateblue","slateblue1"))
)

beanBioDBP <- with(data=vbio[vbio$Marker=='Diastolic BP',], beanplot(Value ~ Sex * Sample, side = 'both', log = '',
                                                                  bw = 5, main='Diastolic BP', show.names=FALSE,
                                                                         overallline = "median", beanlines = 'median', what = c(0,1,1,0), boxwex=0.9,
                                                                         col = list("cadetblue3", "cadetblue1", "royalblue3", "royalblue1","slateblue","slateblue1"))
)
beanBioSBP <- with(data=vbio[vbio$Marker=='Systolic BP',], beanplot(Value ~ Sex * Sample, side = 'both', log = '',
                                                                 bw = 7, main='Systolic BP', show.names=FALSE,
                                                                       overallline = "median", beanlines = 'median', what = c(0,1,1,0), boxwex=0.9,
                                                                       col = list("cadetblue3", "cadetblue1", "royalblue3", "royalblue1","slateblue","slateblue1"))
)
beanBioChol <- with(data=vbio[vbio$Marker=='Cholesterol',], beanplot(Value ~ Sex * Sample, side = 'both', log = '',
                                                                 bw = 10.0, main = 'Cholesterol',
                                                                    overallline = "median", beanlines = 'median', what = c(0,1,1,0), boxwex=0.9,
                                                                    col = list("cadetblue3", "cadetblue1", "royalblue3", "royalblue1","slateblue","slateblue1"))
)

beanBioTrig <- with(data=vbio[vbio$Marker=='Triglycerides',], beanplot(Value ~ Sex * Sample, side = 'both', log = '',
                                                                   bw = 15.0, main='Triglycerides', 
                                                                             overallline = "median", beanlines = 'median', what = c(0,1,1,0), boxwex=0.9,
                                                                             col = list("cadetblue3", "cadetblue1", "royalblue3", "royalblue1","slateblue","slateblue1"))
)

beanBioCreat <- with(data=vbio[vbio$Marker=='Creatinine',], 
                 beanplot(Value ~ Sex * Sample, side = 'both', 
                          bw = 0.07, log = '', main='Creatinine' ,
                          overallline = "median", beanlines = 'median', what = c(0,1,1,0), boxwex=0.9,
                          col = list("cadetblue3", "cadetblue1", "royalblue3", "royalblue1","slateblue","slateblue1"))
)


dev.off()


vbpbio <- ggplot(vbio, aes(x=Sample, y=Value, group=Sample)) + geom_boxplot(trim=TRUE, aes(fill = factor(Sample)))
  #+ stat_summary(fun.y=median.quartile,geom='point') + 
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
  +facet_wrap(~Personality)
vregs
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

library(effects)
        
              

fixed.chol = data.frame(fixef(m2.chol))

vregs + geom_abline(intercept=fixed.chol[1,1],slope=fixed.chol[5,1] + theme_bw())


library(arm)
sim.m2.chol = sim(m2.chol)
coefplot(sim.m2.chol)


install.packages("coefplot2",
                 repos="http://www.math.mcmaster.ca/bolker/R",
                 type="source")


##### the plots below are where the regression visualization gets decent


sample_vect = c((rep(c('Japanese'),9)),(rep(c('Americans'),9)),(rep(c('Yerkes'),9)))
# 9: +3 for adding age, age^2, and BMI

pd <- position_dodge(width=0.2,height=NULL)

# Systolic CF plots
c.sys.co=fixef(m1a.a2)[c(2:3,5:11)]
m.sys.co=m.sys.a2$coefficients[c(2:3,5:11)]
j.sys.co=mj.sys.a2$coefficients[c(2:3,5:11)]

c.sys.prd = confint(m1a.a2, level=0.92, method="boot")[c(4:5,7:13),]
m.sys.prd = confint(m.sys.a2, level=0.92)[c(2:3,5:11),]
j.sys.prd = confint(mj.sys.a2, level=0.92)[c(2:3,5:11),]

sys.ci = data.frame(
  Coefficients=c(j.sys.co,m.sys.co,c.sys.co),rbind(j.sys.prd,m.sys.prd,c.sys.prd),sample_vect,Dimension=rep(rownames(m.sys.prd),3)
)
colnames(sys.ci)<-c("Coefficients",'lower',"upper","Sample","Dimension")

levels(sys.ci$Dimension) <- sub("^age$", "Age", levels(sys.ci$Dimension))
levels(sys.ci$Dimension)[7] <- 'Age^2' # dunno why the above technique doesn't work
sys.ci$Dimension <- relevel(sys.ci$Dimension,'BMI')
sys.ci$Dimension <- relevel(sys.ci$Dimension,'Age^2')
sys.ci$Dimension <- relevel(sys.ci$Dimension,'Age')


sys.ci.gg <- ggplot(sys.ci, aes(Sample,Coefficients, color=Sample)) +
  geom_point(aes(shape=Sample),size=4, position=pd) + 
  scale_color_manual(name="Sample",values=c("cadetblue3", "royalblue1","slateblue")) + 
  theme_bw() + theme(legend.position='none') +
  #  scale_x_continuous("Sample", breaks=1:length(Sample), labels=Sample) + 
  scale_y_continuous("Regression coefficients")   + 
  geom_errorbar(aes(ymin=lower,ymax=upper),width=0.1,position=pd) + facet_wrap(~ Dimension, ncol=3)

ggsave(filename = 'sys.png', plot = sys.ci.gg, 
       scale = 1, width = 7, height = 10,
       dpi = 300, limitsize = TRUE)


# Diastolic CF plots
c.dias.co=fixef(m1b.a2)[c(2:3,5:11)]
m.dias.co=m.dias.a2$coefficients[c(2:3,5:11)]
j.dias.co=mj.dias.a2$coefficients[c(2:3,5:11)]

c.dias.prd = confint(m1b.a2, level=0.92, method="boot")[c(4:5,7:13),]
m.dias.prd = confint(m.dias.a2, level=0.92)[c(2:3,5:11),]
j.dias.prd = confint(mj.dias.a2, level=0.92)[c(2:3,5:11),]

dias.ci = data.frame(
  Coefficients=c(j.dias.co,m.dias.co,c.dias.co),rbind(j.dias.prd,m.dias.prd,c.dias.prd),sample_vect,Dimension=rep(rownames(m.dias.prd),3)
)
colnames(dias.ci)<-c("Coefficients",'lower',"upper","Sample","Dimension")

levels(dias.ci$Dimension) <- sub("^age$", "Age", levels(dias.ci$Dimension))
levels(dias.ci$Dimension)[7] <- 'Age^2' # dunno why the above technique doesn't work
dias.ci$Dimension <- relevel(dias.ci$Dimension,'BMI')
dias.ci$Dimension <- relevel(dias.ci$Dimension,'Age^2')
dias.ci$Dimension <- relevel(dias.ci$Dimension,'Age')

dias.ci.gg <- ggplot(dias.ci, aes(Sample,Coefficients, color=Sample)) +
  geom_point(aes(shape=Sample),size=4, position=pd) + 
  scale_color_manual(name="Sample",values=c("cadetblue3", "royalblue1","slateblue")) + 
  theme_bw() + theme(legend.position='none') +
  #  scale_x_continuous("Sample", breaks=1:length(Sample), labels=Sample) + 
  scale_y_continuous("Regression coefficients")   + 
  geom_errorbar(aes(ymin=lower,ymax=upper),width=0.1,position=pd) + facet_wrap(~ Dimension, ncol=3)

ggsave(filename = 'dias.png', plot = dias.ci.gg, 
       scale = 1, width = 7, height = 10,
       dpi = 300, limitsize = TRUE)


# Triglyceride CF plots
c.trig.co=fixef(m2.trig.a2)[c(2:3,5:11)]
m.trig.co=m.trig.a2$coefficients[c(2:3,5:11)]
j.trig.co=mj.trig.a2$coefficients[c(2:3,5:11)]

c.trig.prd = confint(m2.trig.a2, level=0.92, method="boot")[c(4:5,7:13),]
m.trig.prd = confint(m.trig.a2, level=0.92)[c(2:3,5:11),]
j.trig.prd = confint(mj.trig.a2, level=0.92)[c(2:3,5:11),]

trig.ci = data.frame(
  Coefficients=c(j.trig.co,m.trig.co,c.trig.co),rbind(j.trig.prd,m.trig.prd,c.trig.prd),sample_vect,Dimension=rep(rownames(m.trig.prd),3)
)
colnames(trig.ci)<-c("Coefficients",'lower',"upper","Sample","Dimension")

levels(trig.ci$Dimension) <- sub("^age$", "Age", levels(trig.ci$Dimension))
levels(trig.ci$Dimension)[7] <- 'Age^2' # dunno why the above technique doesn't work
trig.ci$Dimension <- relevel(trig.ci$Dimension,'BMI')
trig.ci$Dimension <- relevel(trig.ci$Dimension,'Age^2')
trig.ci$Dimension <- relevel(trig.ci$Dimension,'Age')


trig.ci.gg <- ggplot(trig.ci, aes(Sample,Coefficients, color=Sample)) +
  geom_point(aes(shape=Sample),size=4, position=pd) + 
  scale_color_manual(name="Sample",values=c("cadetblue3", "royalblue1","slateblue")) + 
  theme_bw() + theme(legend.position='none') +
  #  scale_x_continuous("Sample", breaks=1:length(Sample), labels=Sample) + 
  scale_y_continuous("Regression coefficients")   + 
  geom_errorbar(aes(ymin=lower,ymax=upper),width=0.1,position=pd) + facet_wrap(~ Dimension, ncol=3)

ggsave(filename = 'trig.png', plot = trig.ci.gg, 
       scale = 1, width = 7, height = 10,
       dpi = 300, limitsize = TRUE)


# Cholesterol CF plots
c.chol.co=fixef(m2.chol.a2)[c(2:3,5:11)]
m.chol.co=m.chol.a2$coefficients[c(2:3,5:11)]
j.chol.co=mj.chol.a2$coefficients[c(2:3,5:11)]

c.chol.prd = confint(m2.chol.a2, level=0.92, method="boot")[c(4:5,7:13),]
m.chol.prd = confint(m.chol.a2, level=0.92)[c(2:3,5:11),]
j.chol.prd = confint(mj.chol.a2, level=0.92)[c(2:3,5:11),]

chol.ci = data.frame(
  Coefficients=c(j.chol.co,m.chol.co,c.chol.co),rbind(j.chol.prd,m.chol.prd,c.chol.prd),sample_vect,Dimension=rep(rownames(m.chol.prd),3)
)
colnames(chol.ci)<-c("Coefficients",'lower',"upper","Sample","Dimension")

levels(chol.ci$Dimension) <- sub("^age$", "Age", levels(chol.ci$Dimension))
levels(chol.ci$Dimension)[7] <- 'Age^2' # dunno why the above technique doesn't work
chol.ci$Dimension <- relevel(chol.ci$Dimension,'BMI')
chol.ci$Dimension <- relevel(chol.ci$Dimension,'Age^2')
chol.ci$Dimension <- relevel(chol.ci$Dimension,'Age')

chol.ci.gg <- ggplot(chol.ci, aes(Sample,Coefficients, color=Sample)) +
  geom_point(aes(shape=Sample),size=4, position=pd) + 
  scale_color_manual(name="Sample",values=c("cadetblue3", "royalblue1","slateblue")) + 
  theme_bw() + theme(legend.position='none') +
  #  scale_x_continuous("Sample", breaks=1:length(Sample), labels=Sample) + 
  scale_y_continuous("Regression coefficients")   + 
  geom_errorbar(aes(ymin=lower,ymax=upper),width=0.1,position=pd) + facet_wrap(~ Dimension, ncol=3)

ggsave(filename = 'chol.png', plot = chol.ci.gg, 
       scale = 1, width = 7, height = 10,
       dpi = 300, limitsize = TRUE)


# Creatinine CF plots
c.creat.co=fixef(m2.creat.a2)[c(2:3,5:11)]
m.creat.co=m.creat.a2$coefficients[c(2:3,5:11)]
j.creat.co=mj.creat.a2$coefficients[c(2:3,5:11)]

c.creat.prd = confint(m2.creat.a2, level=0.92, method="boot")[c(4:5,7:13),]
m.creat.prd = confint(m.creat.a2, level=0.92)[c(2:3,5:11),]
j.creat.prd = confint(mj.creat.a2, level=0.92)[c(2:3,5:11),]

creat.ci = data.frame(
  Coefficients=c(j.creat.co,m.creat.co,c.creat.co),rbind(j.creat.prd,m.creat.prd,c.creat.prd),sample_vect,Dimension=rep(rownames(m.creat.prd),3)
)
colnames(creat.ci)<-c("Coefficients",'lower',"upper","Sample","Dimension")

levels(creat.ci$Dimension) <- sub("^age$", "Age", levels(creat.ci$Dimension))
levels(creat.ci$Dimension)[7] <- 'Age^2' # dunno why the above technique doesn't work
creat.ci$Dimension <- relevel(creat.ci$Dimension,'BMI')
creat.ci$Dimension <- relevel(creat.ci$Dimension,'Age^2')
creat.ci$Dimension <- relevel(creat.ci$Dimension,'Age')


creat.ci.gg <- ggplot(creat.ci, aes(Sample,Coefficients, color=Sample)) +
  geom_point(aes(shape=Sample),size=4, position=pd) + 
  scale_color_manual(name="Sample",values=c("cadetblue3", "royalblue1","slateblue")) + 
  theme_bw() + theme(legend.position='none') +
  #  scale_x_continuous("Sample", breaks=1:length(Sample), labels=Sample) + 
  scale_y_continuous("Regression coefficients")   + 
  geom_errorbar(aes(ymin=lower,ymax=upper),width=0.1,position=pd) + facet_wrap(~ Dimension, ncol=3)

ggsave(filename = 'creat.png', plot = creat.ci.gg, 
       scale = 1, width = 7, height = 10,
       dpi = 300, limitsize = TRUE)



#BMI reg CF plots
# beware - can't use this until fix the BMI lmer
c.BMI.co=fixef(m3.BMI.a2)[c(2,4:10)]
m.BMI.co=m.BMI.a2$coefficients[c(2,4:10)]
j.BMI.co=mj.BMI.a2$coefficients[c(2,4:10)]

c.BMI.prd = confint(m3.BMI.a2, method='Wald',level=0.95)[c(2,4:10),]
m.BMI.prd = confint(m.BMI.a2,level=0.95)[c(2,4:10),]
j.BMI.prd = confint(mj.BMI.a2, level=0.95)[c(2,4:10),]

BMI.ci = data.frame(
  Coefficients=c(j.BMI.co,m.BMI.co,c.BMI.co),rbind(j.BMI.prd,m.BMI.prd,c.BMI.prd),
  c((rep(c('Japanese'),8)),(rep(c('Americans'),8)),(rep(c('Yerkes'),8))),
  Dimension=as.character(rep(rownames(m.BMI.prd),3))
)
colnames(BMI.ci)<-c("Coefficients",'lower',"upper","Sample","Dimension")

levels(BMI.ci$Dimension) <- sub("^age$", "Age", levels(BMI.ci$Dimension))
levels(BMI.ci$Dimension)[6] <- 'Age^2' # dunno why the above technique doesn't work
BMI.ci$Dimension <- relevel(BMI.ci$Dimension,'Age^2')
BMI.ci$Dimension <- relevel(BMI.ci$Dimension,'Age')

BMI.ci.gg <- ggplot(BMI.ci, aes(Sample,Coefficients, color=Sample)) +
  geom_point(aes(shape=Sample),size=4, position=pd) + 
  scale_color_manual(name="Sample",values=c("cadetblue3", "royalblue1","slateblue")) + 
  theme_bw() + theme(legend.position='none') + 
  #  scale_x_continuous("Sample", breaks=1:length(Sample), labels=Sample) + 
  scale_y_continuous("Regression coefficients")   + 
  geom_errorbar(aes(ymin=lower,ymax=upper),width=0.1,position=pd) +
  facet_wrap(~ Dimension, ncol=2)
#labeller = label_parsed) # so dumb that this doesn't work

#facet_wrap_labeller(BMI.cf.gg, labels = expression(paste("Age ", alpha), beta, gamma, delta, "Age^2", 'boom'))
# fuck this, low priority, fix it later


ggsave(filename = 'BMI.png', plot = BMI.ci.gg, 
       scale = 1, width = 6, height = 10,
       dpi = 300, limitsize = TRUE)



#--- Tables for 27/03/2015 and beyond
library(texreg)

#sys.tbl

ext.m1a=extract(m1a.a2, include.aic = FALSE, include.bic=FALSE, include.dic=FALSE,
                include.deviance=FALSE, include.loglik=FALSE,include.nobs=FALSE,
                include.groups=FALSE,include.variance=FALSE)

sys.tbl = htmlreg(list(m.sys.a2,mj.sys.a2,ext.m1a), custom.model.names=c('Americans','Japanese','Yerkes'), ci.force=TRUE,
                  caption = "", groups=NULL, digits=3, ci.force.level = 0.92, ci.test=NULL,
                  bold=TRUE, custom.note = '', reorder.coef = c(1:5,8,9,6,11,10,7),
                  custom.coef.names=c(NA,"Age","Age<sup>2</sup>","Sex",NA,NA,NA,NA,NA,NA,NA))
write(sys.tbl,"sys.html")

ext.trig=extract(m2.trig.a2, include.aic = FALSE, include.bic=FALSE, include.dic=FALSE,
                 include.deviance=FALSE, include.loglik=FALSE,include.nobs=FALSE,
                 include.groups=FALSE,include.variance=FALSE)
trig.tbl = htmlreg(list(m.trig.a2,mj.trig.a2,ext.trig), custom.model.names=c('Americans','Japanese','Yerkes'), ci.force=TRUE,
                   caption = "", groups=NULL, digits=3, ci.force.level = 0.92, ci.test=NULL,
                   bold=TRUE, custom.note = '', reorder.coef = c(1:5,8,9,6,11,10,7),
                   custom.coef.names=c(NA,"Age","Age<sup>2</sup>","Sex",NA,NA,NA,NA,NA,NA,NA))
write(trig.tbl,"trig.html")

ext.chol=extract(m2.chol.a2, include.aic = FALSE, include.bic=FALSE, include.dic=FALSE,
                 include.deviance=FALSE, include.loglik=FALSE,include.nobs=FALSE,
                 include.groups=FALSE,include.variance=FALSE)
chol.tbl = htmlreg(list(m.chol.a2,mj.chol.a2,ext.chol), custom.model.names=c('Americans','Japanese','Yerkes'), ci.force=TRUE,
                   caption = "", groups=NULL, digits=3, ci.force.level = 0.92, ci.test=NULL,
                   bold=TRUE, custom.note = '', reorder.coef = c(1:5,8,9,6,11,10,7),
                   custom.coef.names=c(NA,"Age","Age<sup>2</sup>","Sex",NA,NA,NA,NA,NA,NA,NA))
write(chol.tbl,"chol.html")

ext.m2.creat=extract(m2.creat.a2, include.aic = FALSE, include.bic=FALSE, include.dic=FALSE,
                     include.deviance=FALSE, include.loglik=FALSE,include.nobs=FALSE,
                     include.groups=FALSE,include.variance=FALSE)
creat.tbl = htmlreg(list(m.creat.a2,mj.creat.a2,ext.m2.creat), custom.model.names=c('Americans','Japanese','Yerkes'), ci.force=TRUE,
                    caption = "", groups=NULL, digits=3, ci.force.level = 0.92, ci.test=NULL,
                    bold=TRUE, custom.note = '', reorder.coef = c(1:5,8,9,6,11,10,7),
                    custom.coef.names=c(NA,"Age","Age<sup>2</sup>","Sex",NA,NA,NA,NA,NA,NA,NA))
write(creat.tbl,"creat.html")

ext.m1b=extract(m1b.a2, include.aic = FALSE, include.bic=FALSE, include.dic=FALSE,
                include.deviance=FALSE, include.loglik=FALSE,include.nobs=FALSE,
                include.groups=FALSE,include.variance=FALSE)  
dias.tbl = htmlreg(list(m.dias.a2,mj.dias.a2,ext.m1b), custom.model.names=c('Americans','Japanese','Yerkes'), ci.force=TRUE,
                   caption = "", groups=NULL, digits=3, ci.force.level = 0.92, ci.test=NULL,
                   bold=TRUE, custom.note = '', reorder.coef = c(1:5,8,9,6,11,10,7),
                   custom.coef.names=c(NA,"Age","Age<sup>2</sup>","Sex",NA,NA,NA,NA,NA,NA,NA))
                   #override.ci.low = list(c(0.1,0.1,0.1)),
                   #override.ci.up = list(c(0.1,0.1,0.1))                                                           

write(dias.tbl,"dias.html")

ext.m3.BMI = extract(m3.BMI.a2, include.aic = FALSE, include.bic=FALSE, include.dic=FALSE,
                                  include.deviance=FALSE, include.loglik=FALSE,include.nobs=FALSE,
                                  include.groups=FALSE,include.variance=FALSE)
BMI.tbl = htmlreg(list(m.BMI.a2,mj.BMI.a2,ext.m3.BMI), custom.model.names=c('Americans','Japanese','Yerkes'), ci.force=TRUE,
                   caption = "", groups=NULL, digits=3, ci.force.level = 0.92, ci.test=NULL,
                   bold=TRUE, custom.note = '', reorder.coef = c(1:4,7,8,5,10,9,6),
                   custom.coef.names=c(NA,"Age","Age<sup>2</sup>","Sex",NA,NA,NA,NA,NA,NA)
                  #custom.coef.names=expression(paste("c(NA,'Age', 'Age'"^"'2', 'Sex',NA,NA,NA,NA,NA,NA)")),
                  #custom.coef.names=coef.a2
                   #override.ci.low = list(c(0.1,0.1,0.1)),
                   #override.ci.up = list(c(0.1,0.1,0.1))                                                           
)
write(BMI.tbl,"BMI.html")

