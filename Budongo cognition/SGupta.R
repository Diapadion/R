View(PAdata)





colnames(cz_bin_pers)


sg.df2 = aggregate(as.numeric(cz_bin_pers$Accuracy)-1, by=list(cz_bin_pers$Chimp),FUN='mean')
sg.df2$sampleRT = unlist(aggregate(cz_bin_pers$inspecTime, by=list(cz_bin_pers$Chimp),FUN='mean')[2])
sg.df2$choiceRT = unlist(aggregate(cz_bin_pers$procTime, by=list(cz_bin_pers$Chimp),FUN='mean')[2])


colnames(sg.df2) <- c('Chimp','accuracy','sampleRT','choiceRT')

write.csv(sg.df2, "SGupta-MTS.csv")
