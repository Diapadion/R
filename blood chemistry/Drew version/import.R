fulldata <- read.csv('final_data.csv')
attach(fulldata)



fulldata$fear.z <- apply(cbind(fear.x,fear.y),1,mean,na.rm=TRUE)
fulldata$dom.z <- apply(cbind(dom.x,dom.y),1,mean,na.rm=TRUE)
fulldata$pers.z <- apply(cbind(pers.x,pers.y),1,mean,na.rm=TRUE)
fulldata$caut.z <- apply(cbind(caut.x,caut.y),1,mean,na.rm=TRUE)
fulldata$stbl.z <- apply(cbind(stbl.x,stbl.y),1,mean,na.rm=TRUE)
fulldata$aut.z <- apply(cbind(aut.x,aut.y),1,mean,na.rm=TRUE)
fulldata$stngy.z <- apply(cbind(stngy.x,stngy.y),1,mean,na.rm=TRUE)
fulldata$jeals.z <- apply(cbind(jeals.x,jeals.y),1,mean,na.rm=TRUE)
fulldata$reckl.z <- apply(cbind(reckl.x,reckl.y),1,mean,na.rm=TRUE)
fulldata$soc.z <- apply(cbind(soc.x,soc.y),1,mean,na.rm=TRUE)
fulldata$tim.z <- apply(cbind(tim.x,tim.y),1,mean,na.rm=TRUE)
fulldata$symp.z <- apply(cbind(symp.x,symp.y),1,mean,na.rm=TRUE)
fulldata$play.z <- apply(cbind(play.x,play.y),1,mean,na.rm=TRUE)
fulldata$sol.z <- apply(cbind(sol.x,sol.y),1,mean,na.rm=TRUE)
fulldata$actv.z <- apply(cbind(actv.x,actv.y),1,mean,na.rm=TRUE)
fulldata$help.z <- apply(cbind(help.x,help.y),1,mean,na.rm=TRUE)
fulldata$buly.z <- apply(cbind(buly.x,buly.y),1,mean,na.rm=TRUE)
fulldata$aggr.z <- apply(cbind(aggr.x,aggr.y),1,mean,na.rm=TRUE)
fulldata$manp.z <- apply(cbind(manp.x,manp.y),1,mean,na.rm=TRUE)
fulldata$gntl.z <- apply(cbind(gntl.x,gntl.y),1,mean,na.rm=TRUE)
fulldata$affc.z <- apply(cbind(affc.x,affc.y),1,mean,na.rm=TRUE)
fulldata$exct.z <- apply(cbind(exct.x,exct.y),1,mean,na.rm=TRUE)
fulldata$impl.z <- apply(cbind(impl.x,impl.y),1,mean,na.rm=TRUE)
fulldata$inqs.z <- apply(cbind(inqs.x,inqs.y),1,mean,na.rm=TRUE)
fulldata$subm.z <- apply(cbind(subm.x,subm.y),1,mean,na.rm=TRUE)
fulldata$depd.z <- apply(cbind(depd.x,depd.y),1,mean,na.rm=TRUE)
fulldata$irri.z <- apply(cbind(irri.x,irri.y),1,mean,na.rm=TRUE)
fulldata$pred.z <- apply(cbind(pred.x,pred.y),1,mean,na.rm=TRUE)
fulldata$decs.z <- apply(cbind(decs.x,decs.y),1,mean,na.rm=TRUE)
fulldata$depr.z <- apply(cbind(depr.x,depr.y),1,mean,na.rm=TRUE)
fulldata$sens.z <- apply(cbind(sens.x,sens.y),1,mean,na.rm=TRUE)
fulldata$defn.z <- apply(cbind(defn.x,defn.y),1,mean,na.rm=TRUE)
fulldata$intll.z <- apply(cbind(intll.x,intll.y),1,mean,na.rm=TRUE)
fulldata$prot.z <- apply(cbind(prot.x,prot.y),1,mean,na.rm=TRUE)
fulldata$invt.z <- apply(cbind(invt.x,invt.y),1,mean,na.rm=TRUE)
fulldata$clmy.z <- apply(cbind(clmy.x,clmy.y),1,mean,na.rm=TRUE)
fulldata$errc.z <- apply(cbind(errc.x,errc.y),1,mean,na.rm=TRUE)
fulldata$frdy.z <- apply(cbind(frdy.x,frdy.y),1,mean,na.rm=TRUE)
fulldata$lazy.z <- apply(cbind(lazy.x,lazy.y),1,mean,na.rm=TRUE)
fulldata$dsor.z <- apply(cbind(dsor.x,dsor.y),1,mean,na.rm=TRUE)
fulldata$unem.z <- apply(cbind(unem.x,unem.y),1,mean,na.rm=TRUE)
fulldata$imit.z <- apply(cbind(imit.x,imit.y),1,mean,na.rm=TRUE)
fulldata$indp.z <- apply(cbind(indp.x,indp.y),1,mean,na.rm=TRUE)

#-------#

#recompute aggregate personality scores

compare_data <- NULL

compare_data$chimp_Dom_CZ <-
  (fulldata$dom.z-fulldata$subm.z-fulldata$depd.z+fulldata$indp.z-fulldata$fear.z+fulldata$decs.z-fulldata$tim.z-fulldata$caut.z+
     fulldata$intll.z+fulldata$pers.z+fulldata$buly.z+fulldata$stngy.z+40)/12

compare_data$chimp_Ext_CZ <-
  (-fulldata$sol.z-fulldata$lazy.z+fulldata$actv.z+fulldata$play.z+fulldata$soc.z-fulldata$depr.z+fulldata$frdy.z+fulldata$affc.z+fulldata$imit.z+24)/9

compare_data$chimp_Con_CZ <-
  (-fulldata$impl.z-fulldata$defn.z-fulldata$reckl.z-fulldata$errc.z-fulldata$irri.z+fulldata$pred.z-fulldata$aggr.z-fulldata$jeals.z-fulldata$dsor.z+64)/9

compare_data$chimp_Agr_CZ <-
  (fulldata$symp.z+fulldata$help.z+fulldata$sens.z+fulldata$prot.z+fulldata$gntl.z)/5

compare_data$chimp_Neu_CZ <-
  (-fulldata$stbl.z+fulldata$exct.z-fulldata$unem.z+16)/3

compare_data$chimp_Opn_CZ <-
  (fulldata$inqs.z+fulldata$invt.z)/2



systolic <- NULL
diastolic <- NULL
systolic.1 <- NULL
diastolic.1 <- NULL
systolic.2 <- NULL
diastolic.2 <- NULL
systolic.3 <- NULL
diastolic.3 <- NULL


# fucking removing the slashes from systolic diastolic
# putting them in their own vars

bps <- strsplit(as.character(fulldata$BP.1),"[/]")
for (i in 1:dim(fulldata)[1]){
  bps <- strsplit(as.character(fulldata$BP.1),"[/]")
  if (!is.na(bps)[[i]]){
        
    systolic.1[i] = as.numeric(bps[[i]][1])
    diastolic.1[i] = as.numeric(bps[[i]][2]) 
          
  }
  else{
    systolic.1[i] = NA
    diastolic.1[i] = NA    
  }
  bps <- strsplit(as.character(fulldata$BP.2),"[/]")
  if (!is.na(bps)[[i]]){
    
    systolic.2[i] = as.numeric(bps[[i]][1])
    diastolic.2[i] = as.numeric(bps[[i]][2]) 
    
  }
  else{
    systolic.2[i] = NA
    diastolic.2[i] = NA    
  }
  bps <- strsplit(as.character(fulldata$BP.3),"[/]")
  if (!is.na(bps)[[i]]){
    
    systolic.3[i] = as.numeric(bps[[i]][1])
    diastolic.3[i] = as.numeric(bps[[i]][2]) 
    
  }
  else{
    systolic.3[i] = NA
    diastolic.3[i] = NA    
  }

    
}

systolic <- cbind(systolic.1,systolic.2,systolic.3)
diastolic <- cbind(diastolic.1,diastolic.2,diastolic.3)


# BMI


# age


# sex


# blood factors

trig <- cbind(fulldata$triglicerides,fulldata$triglicerides.1,fulldata$triglicerides.2,fulldata$triglicerides.3)
chol <- cbind(fulldata$cholesterol,fulldata$cholesterol.1,fulldata$cholesterol.2,fulldata$cholesterol.3)

glucose <- cbind(fulldata$Glucose,fulldata$Glucose.1,fulldata$Glucose.2,fulldata$Glucose.3)

mono <- cbind(fulldata$monos,fulldata$mono2,fulldata$mono3)
lymph <- cbind(fulldata$lymp,fulldata$lymp2,fulldata$lymp3)
wbc <- cbind(fulldata$wbc,fulldata$wbc2,fulldata$wbc3)


# is this crap?
mtrig <- apply(trig,1,mean,na.rm=TRUE)
mchol <- apply(chol,1,mean,na.rm=TRUE)
mglucose <- apply(glucose,1,mean,na.rm=TRUE)
mmono <- apply(mono,1,mean,na.rm=TRUE)
mlymph <- apply(lymph,1,mean,na.rm=TRUE)
mwbc <- apply(wbc,1,mean,na.rm=TRUE)
msys <- apply(systolic,1,mean,na.rm=TRUE)
mdias <- apply(diastolic,1,mean,na.rm=TRUE)

detach(fulldata)
