## NB. Leveda's files:All chimps have 12 files each except:
# Paul = 11; timings wrong
# Cindy = 11; week 8 file missed
# Lucy = 13; filming error = extra focal for Lucy

# First check working directory
#setwd('./Edited files')

#lists all sheets in working directory
sheets = list.files(pattern="*.csv")

# sort by animal, from here


behav_dat = NULL

## Notes: variables need to be standardized for capitalization
##        a particular time standardization has been determined as well
### See Lucy file for correct formatting
# Once formatted, then add code to compile data together

# sheet order in wd; sheets need to be loaded 1 at a time, usin i='number here'
#i = 1 # Cindy
#i = 2 # David
#i = 3 # Kilimi
#i = 4 # Lianne
#i = 5 # Louis
#i = 6 # Pearl
# once loaded, merge all sheets vertically using rbind


  # this loop takes a single sheet (currently by index) and
  # add it to a df of the meaningful events, as specified by design doc
  
  ## Below no longer planned:
  ## function can be used to append sheets to one another to create 
  ## a mass df for mixed modeling

for (i in 1:length(sheets)){
  

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
  ### TODO does not appear to be working
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
  
  
  # for the extended Lucy example, this relied on col Q
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
     	is.na(temp_dat$Full.Display..hoots.only..or.fight.[j]) |    
        (temp_dat$Does.focal.show.consolation.behaviour.after.a.fight.between.conspecifics.[j] != '' &
         !is.na(temp_dat$Does.focal.show.consolation.behaviour.after.a.fight.between.conspecifics.[j]) 
        ) | 
        (temp_dat$Name.of.conspecific.s..fought.with[j] != '' &  
         !is.na(temp_dat$Name.of.conspecific.s..fought.with[j]))
       ){
      filter_dat = rbind(filter_dat,cbind(temp_dat[j,],temp_dat[j-1,]))
    }
  }
 
  
  behav_dat <- rbind(behav_dat, filter_dat)
  
} 


### below is incomplete and needs to be tailored to the preferred directory/spreadsheet setup

#for (i in 1:length(sheets)){
#  process_sheet(i)  # fill in later
  
  
#}


#temp_dat = read.csv(sheets[i], skip=1, header=TRUE)




#temp_dat$length = as.numeric(substring(temp_dat$Time[dim(temp_dat)[1]],7))



#setwd('..')


### EDITS TO ADD: VW, 13.08.15
# Write loop to read in all files at once, to same dataframe (above code)
# Where '/' is present in data (e.g. x /runs away) treat info after / as note, *EXCEPT* for columns R-S; can we put this extra info in separate column labelled 'Notes'?
# Where '-' is present, e.g. in column Ag: 'receive-Rene' can we add name of conspecific to separate column?
# If a cell = ?, or x? or Kindia? or display?, etc (i.e. any cell that contains '?'), is there a way to exclude this from the behavioural/time totals, as this indicates uncertainty that data is accurate.
# Can we add a column that calculates proportion responses to emotional event, i.e. if 'Does.focal.respond = Y', calculated out of total number of events where focal is present (e.g. if there are 12 events during focal, and focal chimp is present for 10 and respond 'Y' to 8, this column would be 8/10)
# For total time, add code to account for occasions when end time is not rounded to minute, e.g. total time = 19.22

# Potential problems with running code: Note to self
# When running files, make sure to delete all empty bottom rows or this fucks up time calculations for total time, OS and beh. length. Also make sure to run this line of code:
#   dmtd = dim(temp_dat) # this is real useful
# before running all the code below, or the time calulcations won't work either.

### DMA - 01.10.15
# - "aNother" spelled wrong most of the time. Fixed in Cindy 130114
