


# imported REFA matrices from matlab to work with
# essentially redoing the tests in pcaAdds.R

# helpers = pers[,,c(-4,-5,-7,-8,-16,-53)]
# flatset = array(0,c(48,108))
# n=1
# for (i in 1:48){
#   for (j in 1:9){
#     for (k in 1:12){
#       flatset[i,n]=helpers[j,k,i]
#       n=n+1
#     }
#   }
#   n=1
# }
#flatset


salientload <- function (refarotmat, cutoff=0.6){
  
  rldngs = array(0,c(48,5))
  rldngs = refarotmat
  
  
  for (i in 1:dim(rldngs)[2]){
    for (j in 1:48){
      # cut-off set to the "mid" loading condition of 0.6
      
      if (-(cutoff)>rldngs[j,i]){
        rldngs[j,i]=-1
      }
      else if (rldngs[j,i]>cutoff){
        rldngs[j,i]=1
      }
      else{
        rldngs[j,i]=0
      }
    }
  }
  
  return(rldngs)    
}


createScores <- function (loads){
  loads = t(loads)
  refascore=array(0,c(9,dim(loads)[1]))
    
  for (i in 1:48){
    for (j in 1:dim(loads)[1]){
      refascore[1:9,j] <- refascore[1:9,j]+loads[j,i]*fullset[,i]
    }		
  }
  return (t(refascore))
}


# fix the saliency matrices (for "dupes")

#2_
#13:
rf2sal[13,2]=0
#15:
rf2sal[15,1]=0

#3
#16:
rf3sal[16,1]=0

#4_
#6:
rf4sal[6,1]=0
#16:
rf4sal[16,3]=0
#26:
rf4sal[26,4]=0

#5_
#4:
rf5sal[4,2]=0
#16:
rf5sal[16,4]=0
#26:
rf5sal[26,1]=0
#32:
rf5sal[32,1]=0
#33:
rf5sal[33,1]=0

#6_
#15:
rf6sal[15,3]=0