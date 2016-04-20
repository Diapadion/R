### some plots

library(beanplot)
library(tidyr)

vpers = rbind(sel.nbm[,c(3:32)],c.bm[,c(5:34)])

vpers = gather(vpers, Marker, Measurement, wbc:osmolal)

bm.labels = colnames(c.bm[5:33])

table(vpers$Measurement[vpers$Marker == "mcv"])

par(mfrow=c(6,5))
    #, oma = c(5,4,0,0) + 0.3
    #, mar = c(0,0,1,1) + 0.5)

for (i in 1:length(bm.labels)){
  
  beanBM <- with(data=vpers[vpers$Marker == bm.labels[i],], beanplot(Measurement ~ species, side = 'both', bw = 0.5 , cutmax = 10, cutmin = 0,
                                      overallline = "median", beanlines = 'median', what = c(0,1,1,0) ,# boxwex=0.9,
                                      col = list("cadetblue3", "cadetblue1", "royalblue3", "royalblue1","slateblue","slateblue1")
                                      #, main='Dominance' 
                                      , log = "auto"
                                      ,names=c(bm.labels[i]), show.names=T
                                      #, ylim = c(0,300)
                                      
  ))
}


par(mfrow=c(1,1))
beanBM <- with(data=vpers[vpers$Marker == 'mcv',], beanplot(Measurement ~ species, side = 'both', bw = 0.3, cutmax = 200, cutmin = 0,
                                                            overallline = "median", beanlines = 'median', what = c(0,1,1,0) ,# boxwex=0.9,
                                                            col = list("cadetblue3", "cadetblue1", "royalblue3", "royalblue1","slateblue","slateblue1")
                                                            #, main='Dominance' 
                                                            , log = "auto"
                                                            #,names=c(bm.labels[i]) 
                                                            , show.names=T
                                                            #, ylim = c(0,300)
                                    
))
