#library(xlsx)

df <- read.csv('homelessnessData.csv') 

colnames(df)

levels(df$Gender)
table(df$Gender)

levels(df$How.would.you.rate.your.medical.education.training.in.adequately.preparing.you.to.treat.homeless.patients.)
table(df$How.would.you.rate.your.medical.education.training.in.adequately.preparing.you.to.treat.homeless.patients.)
order(df)

df[,17] <- ordered(df[,17], levels = c("Non existent", "Minimal", "Average", "Good","Excellent"))


table(df[,18])
df[,18] <- ordered(df[,18], levels = c("Strongly disagree","Disagree","Neither agree nor disagree","Agree","Strongly agree"))




table(df[,22])
