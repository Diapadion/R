getwd()
setwd("../ETE medical/")

ella <- read.csv("masterData.csv")

## outcomes
hist(ella$How.many.hours.per.week.do.you.spend.on.research.activities.)
table(ella$How.many.hours.per.week.do.you.spend.on.research.activities.)

class(ella$How.many.hours.per.week.do.you.spend.on.research.activities.)

ella$ceil.Hours <- ceil(ella$How.many.hours.per.week.do.you.spend.on.research.activities.)

## predictor(s)
table(ella$Nation)

## mixed
table(ella$Current.research.role)

# this needs to be releveled
ella$Current.research.role <- relevel(ella$Current.research.role, "Formally employed in a medical research role")
ella$Current.research.role <- relevel(ella$Current.research.role, "Involved in medical research, but not formally employed in a research role")
ella$Current.research.role <- relevel(ella$Current.research.role, "Interested in medical research but not currently involved" )
ella$Current.research.role <- relevel(ella$Current.research.role, "Not interested in medical research")

ella$Current.research.role <- ordered(ella$Current.research.role, levels = 
                                        c("Not interested in medical research", 
                                          "Interested in medical research but not currently involved",
                                          "Involved in medical research, but not formally employed in a research role",
                                          "Formally employed in a medical research role"))


library(nnet)
m.nation.1 <- multinom(Current.research.role ~ as.factor(Nation),
                   data = ella[(!is.na(ella$Current.research.role) & (ella$Nation != '')),]
                   )     


library(pscl)
m.natxrole.zif <- zeroinfl(ceil.Hours ~ Nation + Current.research.role,
         data = ella[(!is.na(ella$Current.research.role) & (ella$Nation != '')),],
         dist = "poisson"
         )



#######

ella$Barrier23 <- ella$Barrier.4.xxiii.I.feel.I.need.an.experienced.senior.physician.to.mentor.guide.me.personally..and.do.not.know.anyone.who.could.take.on.this.role
table(ella$Barrier23)

levels(ella$Barrier23)[levels(ella$Barrier23) == "No impact on my engagement in research"] <- 0
levels(ella$Barrier23)[levels(ella$Barrier23) == "Very small impact on my engagement in research"] <- 1
levels(ella$Barrier23)[levels(ella$Barrier23) == "Small impact on my engagement in research"] <- 2
levels(ella$Barrier23)[levels(ella$Barrier23) == "Moderate impact on my engagement in research"] <- 4
levels(ella$Barrier23)[levels(ella$Barrier23) == "Medium impact on my engagement in research"] <- 3
levels(ella$Barrier23)[levels(ella$Barrier23) == "Significant impact on my engagement in research"] <- 5

hist(as.numeric(as.character(ella$Barrier23)))
     
m.b23.zif <- zeroinfl(as.numeric(as.character(Barrier23)) ~ Career.stage,
                           data = ella[(ella$Barrier23 != ''),],
                           dist = "poisson" )


table(ella$Career.stage)
ella$Barrier23[(ella$Career.stage == 'Foundation Year 1')]
                                                                             