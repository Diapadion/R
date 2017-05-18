### Don't run this!
### final_data.csv has had post script fixes made



setwd('C:/Users/s1229179/Dropbox/R/blood chemistry/Drew version/')
#setwd('C:/Users/Diapadion/Dropbox/R/blood chemistry/Drew version/')

options(stringsAsFactors = FALSE)


# merge 2 personality datasets together and generate avg item scores for individuals that had 2 raters

persdata1 <- read.csv('personality wdh rater1 4 june 2007.csv')
persdata2 <- read.csv('personality wdh rater2 4 june 2007.csv')
combined_pers <- merge(persdata1, persdata2, by="chimp", all = T)
attach(combined_pers)
combined_pers$fear.z <- apply(cbind(fear.x,fear.y),1,mean,na.rm=TRUE)
combined_pers$pers.z <- (pers.x + pers.y)/2
combined_pers$caut.z <- (caut.x + caut.y)/2
combined_pers$stbl.z <- (stbl.x + stbl.y)/2
combined_pers$aut.z <- (aut.x + aut.y)/2
combined_pers$stngy.z <- (stngy.x + stngy.y)/2
combined_pers$jeals.z <- (jeals.x + jeals.y)/2
combined_pers$reckl.z <- (reckl.x + reckl.y)/2
combined_pers$soc.z <- (soc.x + soc.y)/2
combined_pers$tim.z <- (tim.x + tim.y)/2
combined_pers$symp.z <- (symp.x + symp.y)/2
combined_pers$play.z <- (play.x + play.y)/2
combined_pers$sol.z <- (sol.x + sol.y)/2
combined_pers$actv.z <- (actv.x + actv.y)/2
combined_pers$help.z <- (help.x + help.y)/2
combined_pers$buly.z <- (buly.x + buly.y)/2
combined_pers$aggr.z <- (aggr.x + aggr.y)/2
combined_pers$manp.z <- (manp.x + manp.y)/2
combined_pers$gntl.z <- (gntl.x + gntl.y)/2
combined_pers$affc.z <- (affc.x + affc.y)/2
combined_pers$exct.z <- (exct.x + exct.y)/2
combined_pers$impl.z <- (impl.x + impl.y)/2
combined_pers$inqs.z <- (inqs.x + inqs.y)/2
combined_pers$subm.z <- (subm.x + subm.y)/2
combined_pers$depd.z <- (depd.x + depd.y)/2
combined_pers$irri.z <- (irri.x + irri.y)/2
combined_pers$pred.z <- (pred.x + pred.y)/2
combined_pers$decs.z <- (decs.x + decs.y)/2
combined_pers$depr.z <- (depr.x + depr.y)/2
combined_pers$sens.z <- (sens.x + sens.y)/2
combined_pers$defn.z <- (defn.x + defn.y)/2
combined_pers$intll.z <- (intll.x + intll.y)/2
combined_pers$prot.z <- (prot.x + prot.y)/2
combined_pers$invt.z <- (invt.x + invt.y)/2
combined_pers$clmy.z <- (clmy.x + clmy.y)/2
combined_pers$errc.z <- (errc.x + errc.y)/2
combined_pers$frdy.z <- (frdy.x + frdy.y)/2
combined_pers$lazy.z <- (lazy.x + lazy.y)/2
combined_pers$dsor.z <- (dsor.x + dsor.y)/2
combined_pers$unem.z <- (unem.x + unem.y)/2
combined_pers$imit.z <- (imit.x + imit.y)/2
combined_pers$indp.z <- (indp.x + indp.y)/2
write.csv(combined_pers, 'combined_pers and item scores.csv')
detach(combined_pers)

#here you have to manually go into Excel and create the items.a, which is either the average item rating for an individual or its single rater item score from rater 1.

#would be great if someone could provide code in R to do the step above so we don't have to do this again in the future?



blood <- read.csv("blood chemistry data.csv")
#combine persdata3 with cholesterol, triglyceride, and blood pressure data
persdata3 <- read.csv('combined_pers and item scores.csv')
blood_pers_combined <- merge(blood, persdata3, by="chimp", all = T)
write.csv(blood_pers_combined, 'combinedPersItemBlood1.csv')

blood_pressure <- read.csv("Chimpanzee Metabolic Syndrome Worksheet.csv")
blood_pers_combined1 <- merge(blood_pers_combined, blood_pressure, by="chimp", all=T)
write.csv(blood_pers_combined1, 'combinedPersItemBlood2.csv')

hematology <- read.csv("yerkes hematology data.csv")

final_minus_height <- merge(blood_pers_combined1, hematology, by="chimp", all=T)
write.csv(final_minus_height, 'combinedPersItemBlood3.csv')

height <- read.csv("Chimpanzee heights bak.csv")
final_data <- merge(final_minus_height, height, by="chimp", all=T)


write.csv(final_data, 'C:/Users/s1229179/Dropbox/R/blood chemistry/Drew version/final_data.csv')
#write.csv(final_data, 'C:/Users/Diapadion/Dropbox/R/blood chemistry/Drew version/final_data.csv')



  
#-------#

# recompute aggregate personality scores
# compare_data$chimp_Dom_CZ <-
#   (Dominant-Submissive-Dependent.Follower+Independent-Fearful+Decisive-Timid-Cautious+
#      Intelligent+Persistent+Bullying+Stingy.Greedy+40)/12
# 
# compare_data$chimp_Ext_CZ <-
#   (-Solitary-Lazy+Active+Playful+Sociable-Depressed+Friendly+Affectionate+Imitative+24)/9
# 
# compare_data$chimp_Con_CZ <-
#   (-Impulsive-Defiant-Reckless-Erratic-Irritable+Predictable-Aggressive-Jealous-Disorganized+64)/9
# 
# compare_data$chimp_Agr_CZ <-
#   (Sympathetic+Helpful+Sensitive+Protective+Gentle)/5
# 
# compare_data$chimp_Neu_CZ <-
#   (-Stable+Excitable-Unemotional+16)/3
# 
# compare_data$chimp_Opn_CZ <-
#   (Inquisitive+Inventive)/2
# 
# 
