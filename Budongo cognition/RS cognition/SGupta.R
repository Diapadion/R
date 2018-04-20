

library(dplyr)


as.numeric(RStemp$Correctness)-1

sg.df = aggregate(as.numeric(RStemp$Correctness)-1 ~ chimp+stage, data=RStemp, mean, na.rm=TRUE)

sg.df$RT = unlist(aggregate(RT ~ chimp+stage, data=RStemp, mean, na.rm=TRUE)[3])

colnames(sg.df)[3] <- 'Accuracy'

write.csv(sg.df, file='SGupta-2AFC.csv')
