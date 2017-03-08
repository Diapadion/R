BeranCaps <- read.csv("caps_to_drew.csv")

bcp <- aggregate(BeranCaps, by=list(capuchin=BeranCaps$Capuchin), mean)

#hist(bcp$cap_Soc)
#bcp$capuchin
  


###
# Perdue et al., Anim Cogn (2015) 18:1105–1112
###

## Visible baiting

tmpdf <- data.frame(capuchin=c('Wren','Liam','Logan','Griffin','Lily','Nala','Drella','Gabe'), 
                   Perdue2015.vis.1=c(100,100,100,100,100,95,100,45), # larger visible
                   Perdue2015.vis.2=c(100,100,95,95,90,95,25,5), # smaller visible
                   Perdue2015.vis.3=c(100,100,100,100,100,100,80,30), # both arms visible
## Occluded baiting                   
                   Perdue2015.occ.1=c(80,90,100,100,90,80,100,80), # larger visisble
                   Perdue2015.occ.2=c(100,90,90,90,90,60,0,40) # smaller visible
                   )



bcp = merge(bcp, tmpdf, all.x=T)


### 
# Bramlett et al., Anim Cogn (2012) 15:963–969
###

tmpdf <- data.frame(capuchin=c('Wren','Liam','Logan','Griffin','Lily','Nala','Drella','Gabe'), 
                    Bramlett2012.1=c(13/14,9/10,8/10,14/24,10/14,8/8,12/16,9/16),
                    Bramlett2012.2=c(12/14,10/10,9/12,8/12,9/12,12/12,10/14,8/8),
                    Bramlett2012.3=c(9/10,9/12,11/12,15/22,8/10,9/10,0/20,0/20),
                    Bramlett2012.4=c(8/8,10/10,10/10,10/10,10/10,10/10,NA,NA),
                    Bramlett2012.5=c(14/14,8/10,8/8,10/10,19/22,0/20,NA,NA),
                    Bramlett2012.6=c(10/10,11/12,9/10,10/10,8/10,NA,NA,NA)
                    )

bcp = merge(bcp, tmpdf, all.x=T)



###
# Beran et al., Behavioural Processes 129 (2016) 68–79
###

tmpdf <- data.frame(capuchin=c('Gabe','Gambit','Griffin','Liam','Lily','Logan','Nala','Nkima','Wren'),
                    Beran2016.1.rotTray.1=c(2.6,1,3.8,5,4.4,3.8,2.8,1.0,4.8),
                    Beran2016.1.rotTray.2=c(2.4,1,4,4.2,4.8,4.4,3.6,1,5.2),
                    Beran2016.1.accum.1=c(4.4,1,4,6,5,6,2.2,1,3.8),
                    Beran2016.1.accum.2=c(3.6,1,4.2,5.8,6,6,2.6,1,6),
                    Beran2016.2.rotTray.1=c(5.6,1,1,4.2,5.2,4.6,5.8,1,5.8),
                    Beran2016.2.rotTray.2=c(3.8,1,1,4.2,4.8,4.8,6,1,6),
                    Beran2016.2.accum.1=c(5.2,1,1,6,2,6,2,1,5.4),
                    Beran2016.2.accum.2=c(5,1,1,5.8,5,6,2.4,1.2,6)
           # experiment 3 and parts of 4 unclear what to do with   
 
)

tmpdf2 <- data.frame(capuchin=c('Bias','Gonzo','Gretel','Bailey','Benny','Mason'),
                    Beran2016.4.accum.pretest=c(1.6,3.2,4.2,6.8,1,1.6),
                    Beran2016.4.rotTray.1=c(1,1,1,1,1,1),
                    Beran2016.4.rotTray.2=c(1,3,1,3,3,3),
                    Beran2016.4.rotTray.3=c(1,4,3,3,2,6),
                    # what to do about phase 4?
                    Beran2016.4.accum.posttest=c(2.4,2.6,2.8,2.4,1,3.6),
                    Beran2016.1.rotTray.1=c(4.4,1.6,3.4,2,3.6,1.6), # these are actually Exp 5
                    Beran2016.1.rotTray.2=c(3.4,1.2,4.4,2.2,3,2),
                    Beran2016.1.accum.1=c(5.5,1.6,3.6,1.2,4,1.6),
                    Beran2016.1.accum.2=c(4.2,1.4,4,1.6,4.4,1.8)
                      )

tmpdf = merge(tmpdf, tmpdf2, all.x=T, all.y=T)
bcp = merge(bcp, tmpdf, all.x=T)



###
# Evans et al., Anim Cogn (2012) 15:539–548
###

tmpdf <- data.frame(capuchin=c('Drella','Gabe','Griffin','Liam','Lily','Logan','Nala','Wren'),
                    Evans2012.1.1=c(1.42,3.13,2.75,3.5,3.63,2.67,2.71,4.5),
                    Evans2012.1.2=c(2.38,5.38,3.5,9.88,8.13,6.88,4.25,10.94),
                    Evans2012.1.3=c(2,1.71,3.38,3,3,4.5,3.79,4.58),
                    Evans2012.1.4=c(1.75,1.7,3.05,3.2,6.75,5.5,2,4.45),
                    Evans2012.2.foods=c(1.2,3.9,3.2,6,14.6,9.7,2.3,9.7),
                    Evans2012.2.tokens=c(1.3,1.4,3,3.9,7.9,5.4,1.5,4.9)
                    )

bcp = merge(bcp, tmpdf, all.x=T)


### 
# Evans et al., Behavioural Processes 103 (2014) 236–242
###

tmpdf <- data.frame(capuchin=c('Drella','Gabe','Gambit','Griffin','Liam','Lily','Logan','Nala','Wren'),
                    Evans2014.wait.stbl.1=c(25,70,75,15,45,100,75,70,30),
                    Evans2014.wait.stbl.2=c(25,35,20,30,25,55,25,70,110),
                    Evans2014.wait.toler.1=c(19.5,58.5,49.5,44,26.0,32.5,71.5,28,26),
                    Evans2014.wait.toler.2=c(93,32.5,37.5,40.5,34,32.7,45,23,27.5),
                    Evans2014.work.stbl.1=c(10,90,105,15,110,60,25,15,70),
                    Evans2014.work.stbl.2=c(115,30,10,10,20,30,45,15,15),
                    Evans2014.work.toler.1=c(3.1,2.3,2.5,2.4,6.8,2.5,4.8,5,4),
                    Evans2014.work.toler.2=c(3.6,2.1,3,2.4,5.9,3,5.4,4.2,2.9))

bcp = merge(bcp, tmpdf, all.x=T)



###
# Addessi et al., JCP (2013)
###

tmpdf <- data.frame(capuchin=c('Drella','Gabe','Griffin','Liam','Lily','Logan','Nala','Wren'),
                    Addessi2013.ITchoic=c(73.3,93.3,76.7,76.7,80,70,63.3,80),
                    Addessi2013.accum5.=c(1.42,3.13,2.75,3.5,3.63,2.67,2.71,4.5),
                    Addessi2013.accum50=c(2.38,5.38,3.5,9.88,8.13,6.88,4.25,10.94))
                    
bcp = merge(bcp, tmpdf, all.x=T)            




### Removing the caps with no data

bdf.1 = bcp[rowSums(is.na(bcp))<35,]
bdf.2 = bcp[rowSums(is.na(bcp))<38,]                 



### Creating a viable transpose

t.bdf.1 = t(bdf.1)
colnames(t.bdf.1)= t.bdf.1[1,]
t.bdf.1 = t.bdf.1[rowSums(is.na(t.bdf.1))<5,]  
t.bdf.1 = t.bdf.1[c(-1,-71),]
storage.mode(t.bdf.1) <- "numeric"
t.bdf.1 = t(apply(t.bdf.1,1,scale))



### Matrix singularity issues

## Diagnosis
eigen(cmat)

your.matrix = cmat

rankifremoved <- sapply(1:ncol(your.matrix), function (x) qr(your.matrix[,-x])$rank)
which(rankifremoved == max(rankifremoved))
