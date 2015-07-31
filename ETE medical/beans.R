

ete1 = read.csv('CSVexport.csv',header=T)


library(beanplot)

ete1Consultant = ete1[ete1$Career.stage == 'Consultant',]

  

genderM = beanplot(ete1$How.many.hours.per.week.do.you.spend.on.research.activities. ~ ete1$Gender,
                   bw='nrd0', cutmin=0, cutmax=60,
                   overallline = "median", beanlines = 'median')

genderMconsonly = beanplot(ete1Consultant$How.many.hours.per.week.do.you.spend.on.research.activities. ~ ete1Consultant$Gender,
                   bw='nrd0', cutmin=0, cutmax=60,
                   overallline = "median", beanlines = 'median')
  
  
  with(data=vpers[vpers$Dimension=='Dominance',], beanplot(Score ~ Sex * Sample, side = 'both', bw = 0.3, cutmax = 4, cutmin = 1,
                                                           overallline = "median", beanlines = 'median', what = c(0,1,1,0), boxwex=0.9,
                                                           col = list("cadetblue3", "cadetblue1", "royalblue3", "royalblue1","slateblue","slateblue1"),
                                                           main='Dominance' , show.names=FALSE)
  )
  
RCPprog = beanplot(ete1$How.many.hours.per.week.do.you.spend.on.research.activities. ~ ete1$Did.you.complete..or.are.you.currently.completing..an.Academic.Foundation.Programme..AFP...Academic.Clinical.Fellowship..ACF..or.Clinical.Lectureship..CL..programme.,
                     bw='nrd0', cutmin=0, cutmax=60,
                     overallline = "median", beanlines = 'median')
  
  
aggregate(x = ete1$How.many.hours.per.week.do.you.spend.on.research.activities.,
          by = list(ete1$Gender),
          FUN=mean
          , na.action=na.pass,
          na.rm=T
          )


aggregate(x = ete1Consultant$How.many.hours.per.week.do.you.spend.on.research.activities.,
          by = list(ete1Consultant$Gender),
          FUN=mean
          , na.action=na.pass,
          na.rm=T
)

# RCP progs
aggregate(x = ete1$How.many.hours.per.week.do.you.spend.on.research.activities.,
          by = list(ete1$Did.you.complete..or.are.you.currently.completing..an.Academic.Foundation.Programme..AFP...Academic.Clinical.Fellowship..ACF..or.Clinical.Lectureship..CL..programme.),
          FUN=mean
          , na.action=na.pass,
          na.rm=T
)
table(ete1$Did.you.complete..or.are.you.currently.completing..an.Academic.Foundation.Programme..AFP...Academic.Clinical.Fellowship..ACF..or.Clinical.Lectureship..CL..programme.)


table(ete1$How.many.hours.per.week.do.you.spend.on.research.activities.[ete1$Gender=='Male'])
table(ete1$How.many.hours.per.week.do.you.spend.on.research.activities.[ete1$Gender=='Female'])



t.test(ete1$How.many.hours.per.week.do.you.spend.on.research.activities.[ete1$Gender=='Female'],
       ete1$How.many.hours.per.week.do.you.spend.on.research.activities.[ete1$Gender=='Male'],
       alternative = 'less')


t.test(ete1$How.many.hours.per.week.do.you.spend.on.research.activities.[ete1Consultant$Gender=='Female'],
       ete1$How.many.hours.per.week.do.you.spend.on.research.activities.[ete1Consultant$Gender=='Male'],
       alternative = 'less')

