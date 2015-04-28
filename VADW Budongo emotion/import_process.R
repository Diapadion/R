
setwd('./csv')

sheets = list.files(pattern="*.csv")

# sort by animal, from here


behav_dat = NULL

## Notes: variables need to be standardized for capitalization
## (or can I do anything?)


#i = 1 # David
i = 4 # Lucy
i = 5 # Pearl

for (i in 1:length(sheets)){
  temp_dat = NULL
  temp_dat = read.csv(sheets[i], skip=1, header=TRUE)
  
  dmtd = dim(temp_dat) # this is real useful
  
  # fill out chimp, day, start time
  temp_dat$Chimp = temp_dat$Chimp[1]
  temp_dat$Day = temp_dat$Day[1] # this may need to be further processed into a datetime object
  temp_dat$Start.time = temp_dat$Start.time[1]
  
  # append total length as new column and adjust final row, Time
  temp_dat$total.length = as.numeric(substring(temp_dat$Time[dmtd[1]],7))
  temp_dat$Time = as.numeric(levels(temp_dat$Time))[temp_dat$Time]
  temp_dat$Time[dmtd[1]]=temp_dat$total.length[1]
  
  # code time differences for all behaviors (col D)
  for(j in 1 : dim(temp_dat)[1]-1){
    temp_dat$behav.length[j] = temp_dat$Time[j+1]-temp_dat$Time[j]
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
  
  # Time spent (at all) _near_ others
  temp_dat$total.near.others = sum(temp_dat$behav.length[temp_dat$X.Near.others.!=''])
  
  
  # Time(s) spent grooming with conspecific
  
  
  


  
  
}


temp_dat = read.csv(sheets[i], skip=1, header=TRUE)




temp_dat$length = as.numeric(substring(temp_dat$Time[dim(temp_dat)[1]],7))



setwd('..')
