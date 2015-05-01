### 2015 revision of the original code

### accuracies

aacc <- 0
bacc <- 0
cacc <- 0
eacc <- 0
hacc <- 0
lacc <- 0
macc <- 0
oacc <- 0
pacc <- 0


i=1
while(adata[i,9]!='bl'){
  aacc[i]<-adata[i,9]
  aacc[i]=aacc[i]-1
  i=i+1	
}
i=1
while(bdata[i,9]!='bl'){
  bacc[i]<-bdata[i,9]
  bacc[i]=bacc[i]-1
  i=i+1
}
i=1
while(cdata[i,9]!='bl'){
  cacc[i]<-cdata[i,9]
  cacc[i]=cacc[i]-1
  i=i+1
}
i=1
while(edata[i,9]!='bl'){
  eacc[i]=edata[i,9]
  eacc[i]=eacc[i]-1
  i=i+1
}
i=1
while(hdata[i,9]!='bl'){
  hacc[i]=hdata[i,9]
  hacc[i]=hacc[i]-1
  i=i+1
}
i=1
while(ldata[i,9]!='bl'){
  lacc[i]=ldata[i,9]
  lacc[i]=lacc[i]-1
  i=i+1
}
i=1
while(mdata[i,9]!='bl'){
  macc[i]=mdata[i,9]
  macc[i]=macc[i]-1
  i=i+1
}
i=1
while(odata[i,9]!='bl'){
  oacc[i]=odata[i,9]
  oacc[i]=oacc[i]-1
  i=i+1
}
i=1
while(pdata[i,9]!='bl'){
  pacc[i]=pdata[i,9]
  pacc[i]=pacc[i]-1
  i=i+1
}
i=1;

# now some test(s?)	

scm=NULL	
scm[1] = mean(aacc)
scm[2] = mean(bacc)
scm[3] = mean(cacc)
scm[4] = mean(eacc)
scm[5] = mean(hacc)
scm[6] = mean(lacc)
scm[7] = mean(macc)
scm[8] = mean(oacc)
scm[9] = mean(pacc)


for(i in 1:length(dataIn[,9])){
  if(dataIn$TrialAccuracy == ){
    
  } else trial.dat$correct[i] = NA
}




### error, progress, & reward rate

trial.dat<-data.frame(Subject=character(),Date=character(),Trial=numeric(),Correct=numeric(),
                      Error=numeric(),Progress=numeric(),RT=numeric())


for (i in 1:length(dataIn[,7])){
  if(dataIn[i,7]=='-') {
    #skip
  } else {
    Subject = dataIn$Sub[i]
    Date = dataIn$Date[i]
    Trial = dataIn$Trial[i]
    RT = dataIn$RT[i]
    
    if(dataIn[i,7]=='B') {
      Error = 1
      Progress = 0
      Correct = 0
      
    } else if (dataIn[i,7]=='AC') {
      Error = 1
      Progress = 1
      Correct = 0
      
    } else if (dataIn[i,7]=='ABD') {
      Error = 1
      Progress = 2
      Correct = 0
      
    } else if(dataIn[i,7]=='C') {
      Error = 2
      Progress = 0
      Correct = 0
            
    } else if (dataIn[i,7]=='AD') {
      Error = 2
      Progress = 1  
      Correct = 0

    } else if(dataIn[i,7]=='ABCB') {
      Error = -1
      Progress = 3
      Correct = 0
    
    } else if(dataIn[i,7]=='D') {
      Error = 3
      Progress = 0
      Correct = 0
      
    } else if(dataIn[i,7]=='ABA') {
      Error = -1
      Progress = 2
      Correct = 0
      
    } else if(dataIn[i,7]=='ABCA') {
      Error = -2
      Progress = 3
      Correct = 0
      
    } else if(dataIn[i,7]=='ABCD') {
      Error = 0
      Progress = 4
      Correct = 1
    }
    
    trial.dat <- rbind(trial.dat, data.frame(Subject,Date,Trial,Correct,Error,Progress,RT))
}
}



### total time expended
#     - how does it relate to RT?


### RT

art <- NULL
for ( i in 1:length(adata[,10])){
  art[i]=adata[i,10]
}
brt <- NULL
for ( i in 1:length(bdata[,10])){
  brt[i]=bdata[i,10]
}
crt <- NULL
for ( i in 1:length(cdata[,10])){
  crt[i]=cdata[i,10]
}
ert <- NULL
for ( i in 1:length(edata[,10])){
  ert[i]=edata[i,10]
}
hrt <- NULL
for ( i in 1:length(hdata[,10])){
  hrt[i]=hdata[i,10]
}
lrt <- NULL
for ( i in 1:length(ldata[,10])){
  lrt[i]=ldata[i,10]
}
mrt <- NULL
for ( i in 1:length(mdata[,10])){
  mrt[i]=mdata[i,10]
}
ort <- NULL
for ( i in 1:length(odata[,10])){
  ort[i]=odata[i,10]
}
prt <- NULL
for ( i in 1:length(pdata[,10])){
  prt[i]=pdata[i,10]
  #ptot[i]=ptot[i]-1
}

scrt=NULL	
scrt[1] = mean(art)
scrt[2] = mean(brt)
scrt[3] = mean(crt)
scrt[4] = mean(ert)
scrt[5] = mean(hrt)
scrt[6] = mean(lrt)
scrt[7] = mean(mrt)
scrt[8] = mean(ort)
scrt[9] = mean(prt)
