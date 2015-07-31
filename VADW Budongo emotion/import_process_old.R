
setwd('./csv')

sheets = list.files(pattern="*.csv")

# sort by animal, from here


behav_dat = NULL

## Notes: variables need to be standardized for capitalization
##        a particular time standardization has been determined as well


#i = 1 # David
i = 4 # Lucy (new)
#i = 6 # Pearl
#i = 7 # Pearl++ new and improved (and fake)

i = 2 

process_sheet <- function(indat){
  # this function takes a single sheet (currently by index) and
  # returns a df of the meaningful events, as specified by design doc
  
  # function can be used to append sheets to one another to create 
  # a mass df for mixed modeling
  
  
  temp_dat = NULL
  temp_dat = read.csv(sheets[i], skip=1, header=TRUE)
  
  dmtd = dim(temp_dat) # this is real useful
  
  # fill out chimp, day, start time
  temp_dat$Chimp = temp_dat$Chimp[1]
  temp_dat$Day = temp_dat$Day[1] # this may need to be further processed into a datetime object
  temp_dat$Start.time = temp_dat$Start.time[1]
  
  # append total length as new column and adjust final row, Time
  # !!! this needs to be done with Date's, not numerics, otherwise the times will be wrong
  # so the data needs to be properly standardized
  # currently this works for Lucy 07-10 data
  ## once Lucy 07-10 has been modified by dividing time by 60
 
  temp_dat$total.length = strptime(substring(temp_dat$Time[dmtd[1]]
                                               ,7), format='%M')
  # same for the above guy, it needs to be a certain length string-phrase to exclude
  # (but the numeric aspect works... for now)
  
  temp_dat$Time = strptime(levels(temp_dat$Time)[temp_dat$Time],format="%H:%M:%S")
  #temp_dat$Time = as.numeric(levels(temp_dat$Time))[temp_dat$Time] # obsolete
  temp_dat$Time[dmtd[1]]=temp_dat$total.length[1] # may need later adjusts
  
  # code time differences for all behaviors (col D)
  for(j in 1 : dim(temp_dat)[1]-1){
    temp_dat$behav.length[j] = difftime(temp_dat$Time[j+1],temp_dat$Time[j],units="secs")
    # the last row has the wrong value
  }
  
  # accounting for all the state behaviors
  temp_dat$time.Forag = sum(temp_dat$behav.length[temp_dat$Fo == 'x'])
  temp_dat$time.RestGroom = sum(temp_dat$behav.length[temp_dat$Re.Gr == 'x'])
  temp_dat$time.Travel = sum(temp_dat$behav.length[temp_dat$Tr == 'x'])
  temp_dat$time.Forag = sum(temp_dat$behav.length[temp_dat$Fo == 'x'])
  temp_dat$time.Play = sum(temp_dat$behav.length[temp_dat$Pl == 'x'])
  temp_dat$time.Di = sum(temp_dat$behav.length[temp_dat$Di == 'x'])
  
  # AlloGrooming and Aggression are handled a little differently
  temp_dat$time.AlloGr.give = sum(temp_dat$behav.length[temp_dat$AG == 'give'])
  temp_dat$time.AlloGr.receive = sum(temp_dat$behav.length[temp_dat$AG == 'receive'])
  temp_dat$time.AlloGr.mutual = sum(temp_dat$behav.length[temp_dat$AG == 'mutual'])
  temp_dat$time.AlloGr.total = temp_dat$time.AlloGr.give+temp_dat$time.AlloGr.receive+temp_dat$time.AlloGr.mutual
  
  temp_dat$time.Aggress.give = sum(temp_dat$behav.length[temp_dat$Ag == 'give'])
  temp_dat$time.Aggress.receive = sum(temp_dat$behav.length[temp_dat$Ag == 'receive'])
  temp_dat$time.Aggress.mutual = sum(temp_dat$behav.length[temp_dat$Ag == 'mutual'])
  temp_dat$time.Aggress.total = colSums(rbind(temp_dat$time.Aggress.give,temp_dat$time.Aggress.receive,
                                              temp_dat$time.Aggress.mutual))
  #summing these guys when they're full of NAs is a problem
  
  
  # OoS totaling
  ### TODO does not papear ot be working
  if ('x' %in% temp_dat$OS){
    temp_dat$any.OS = 'Y'
    temp_dat$total.OS = sum(temp_dat$behav.length[temp_dat$OS=='x'])
    
  } else {
    temp_dat$any.OS = 'N'
    temp_dat$total.OS = NA    
  }
  
  # where does chimp spend the longest time?  
  areaTotals = aggregate(temp_dat$behav.length, list(temp_dat$Pod), sum)
  areaTotals = areaTotals[areaTotals$Group.1 != '',]
  
  if ('1' %in% areaTotals$Group.1){
    temp_dat$time.pod1 = areaTotals$x[areaTotals$Group.1 == '1']    
  } else {
    temp_dat$time.pod1=NA
  }
  if ('2' %in% areaTotals$Group.1){
    temp_dat$time.pod2 = areaTotals$x[areaTotals$Group.1 == '2']    
  } else {
    temp_dat$time.pod2=NA
  }
  if ('3' %in% areaTotals$Group.1){
    temp_dat$time.pod3 = areaTotals$x[areaTotals$Group.1 == '3']    
  } else {
    temp_dat$time.pod3=NA
  }
  if ('Outside' %in% areaTotals$Group.1){
    temp_dat$time.out = areaTotals$x[areaTotals$Group.1 == 'Outside']    
  } else {
    temp_dat$time.out=NA
  }
  
  
  
  # Aggression tabulating
  if ('x' %in% temp_dat$Ag){
    temp_dat$any.Ag = 'Y'
    
  } else {
    temp_dat$any.Ag = 'N'
  }
  
  
  # for the extended Lucy example, this reliead on col Q
  # but O and P should function exactly the same
  
  # Time spent (at all) _near_ others (Q)
  temp_dat$total.near.others = sum(temp_dat$behav.length[temp_dat$X.Near.others.!=''])
  #table(temp_dat$X.Near.others.)
  
  dyad_list = aggregate(temp_dat$behav.length,by=list(temp_dat$X.Near.others.), FUN=sum)
  indx = dim(dyad_list)[1]>1
  temp_dat$most.near =  ifelse(indx,
          as.character(dyad_list[2,1]),
         NA)

  # Time spent sitting with conspecifics
  temp_dat$total.with.others = sum(temp_dat$behav.length[temp_dat$Sitting.with.conspecific!=''])
  
  dyad_list = aggregate(temp_dat$behav.length,by=list(temp_dat$Sitting.with.conspecific.), FUN=sum)
  indx = dim(dyad_list)[1]>1
  temp_dat$most.sit.with =  ifelse(indx,
                               as.character(dyad_list[2,1]),
                               NA)
  
  # Time(s) spent grooming with conspecific
  temp_dat$total.groom.others = sum(temp_dat$behav.length[temp_dat$Grooming.with.conspecific.!=''])
  
  dyad_list = aggregate(temp_dat$behav.length,by=list(temp_dat$Grooming.with.conspecific.), FUN=sum)
  indx = dim(dyad_list)[1]>1
  temp_dat$most.groom.with =  ifelse(indx,
                                   as.character(dyad_list[2,1]),
                                   NA)
  
  
  ## Emotion - column R onwards
  temp_dat$total.emotion.events = sum(temp_dat$Full.Display..hoots.only..or.fight.!='')
  
  
  # filter_dat is a new df which is expanded and fit with room for current and previous events:
  filter_dat <- NULL
  
  # identifying rows with emotional events (R complete) *or* reconciliation behav.s
  # and recording previous states where relevant
  for (j in 2:dmtd[1]){
    if ((temp_dat$Full.Display..hoots.only..or.fight.[j] != '') | 
        (temp_dat$Full.Display..hoots.only..or.fight.[j] == NA) |
        (temp_dat$Does.focal.show.consolation.behaviour.after.a.fight.between.conspecifics.[j] != '' &
         !is.na(temp_dat$Does.focal.show.consolation.behaviour.after.a.fight.between.conspecifics.[j]) 
        ) | 
        (temp_dat$Name.of.conspecific.s..fought.with[j] != '' &  
         !is.na(temp_dat$Name.of.conspecific.s..fought.with[j]))
       ){
      filter_dat = rbind(filter_dat,cbind(temp_dat[j,],temp_dat[j-1,]))
    }
  }
  
  return(filter_dat)
}



### below is incomplete and needs to be tailored to the preferred directory/spreadsheet setup

for (i in 1:length(sheets)){
  process_sheet(i)  # fill in later
  
  
}


temp_dat = read.csv(sheets[i], skip=1, header=TRUE)




temp_dat$length = as.numeric(substring(temp_dat$Time[dim(temp_dat)[1]],7))



setwd('..')
