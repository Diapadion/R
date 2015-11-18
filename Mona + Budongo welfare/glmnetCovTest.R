### covTest for glmnet fuck

# requires:
# glmnet


## output of covTest
#
# $results
# Predictor_Number Drop_in_covariance P-value
# 1             1.0053  0.3697
# 2             3.7148  0.0279
# 3             0.1798  0.8357
# 7             0.0157  0.9844
# 8             0.9848  0.3772
# 5             0.0107  0.9893
# 4             0.1335  0.8752
# -5                 NA      NA
# 
# $sigma
# [1] 5.2625
# 
# $null.dist
# [1] "F(2,97)"


glmnetCovTest = function(netfitobj, larsfitobj, x, y, maxp = min(nrow(x),ncol(x))){
  
   netfitobj = fwf2.net
   larsfitobj = tst.lars
   x = netform2
   y = temp$totalwelfare
   maxp=min(nrow(x),ncol(x))
  
  
   n=nrow(x)
   p=ncol(x)
  ## notes on vars
  # y is the outcome var
  # my is 
  my = mean(y)
  
  
  lambda.min.ratio = ifelse(nrow(x)<ncol(x),0.1,0.0001)
  
  jlist=unlist(larsfitobj$act)
  lamlist=c(netfitobj$lambda,0)
  maxp.call=maxp
  
  maxp=length(jlist)
  maxp=min(maxp,which(lamlist==0))
  maxp=min(maxp,maxp.call)
  jlist=jlist[1:maxp]
  
  cov0=cov=sig=rep(NA,maxp)
  
  yy = y - my
  
  for(j in 1:maxp){
    if(jlist[j]>0){
      
      lambda=lamlist[j+1]
      yhat=as.vector(predict(netfitobj,x,type="link",s=lambda/n))

      cov[j]=sum(yy*yhat)
    
      if(j==1){cov0[j]=0}
      if(j>1){
        tt0=which(larsfitobj$beta[j,]!=0)
        
        glmobj0=glmnet(x[,tt0,drop=F],y,family="gaussian",standardize=fitobj$standardize,lambda.min.ratio=lambda.min.ratio)
        yhat0=as.vector(predict(glmobj0,x[,tt0,drop=F],type="link",s=lambda/n))
        
        
        cov0[j]=sum(yy*yhat0)
        
      }
    }
  }
  
  if(is.numeric((sigma.est))){
    sigma=sigma.est;sigma.type="known";null.dist="Exp(1)"
    if(sigma.est<=0){stop("sigma.est must be positive")}
  }
  if(sigma.est=="full"){
    if(nrow(x)<ncol(x)+1) stop("Number of observations must exceed number of variables,
                               when sigma.est is `full; you need to specify a numeric value for sigma.est")
    sigma.type="unknown"
    aaa=lsfit(x,y)
    sigma=sqrt(sum(aaa$res^2)/(n-p))
    np=n-p
    null.dist=paste("F(2,",as.character(np),")",sep="")
  }
  tt=((cov-cov0)/sigma^2)
  
  if(sigma.type=="known"){out=cbind(jlist,tt,1-pexp(tt,1));dimnames(out)[[2]]=c("Predictor_Number","Drop_in_covariance","P-value")}
  if(sigma.type=="unknown"){out=cbind(jlist,tt,1-pf(tt,2,n-p));dimnames(out)[[2]]=c("Predictor_Number","Drop_in_covariance","P-value")}
  dimnames(out)[[1]]=rep("",nrow(out))
  return(list(results=round(out,4),sigma=round(sigma,4),null.dist=null.dist))
}


# # linking glmnet to covTest
# glmobj=glmnet(x,y,family="binomial",standardize=fitobj$standardize,lambda.min.ratio=lambda.min.ratio)
# 
# 
# 
# if(length(tt0)==1){tt0=c(tt0,tt0)}
# glmobj0=glmnet(x[,tt0,drop=F],y,family="binomial",standardize=fitobj$standardize,lambda.min.ratio=lambda.min.ratio)
# yhat0=as.vector(predict(glmobj0,x[,tt0,drop=F],type="link",s=lambda/n))
# }
# if(family=="cox"){  
#   if(length(tt0)==1){tt0=c(tt0,tt0)}
#   glmobj0=glmnet(x[,tt0,drop=F],Surv(y,status),family="cox",standardize=fitobj$standardize,lambda.min.ratio=lambda.min.ratio)
#   yhat0=as.vector(predict(glmobj0,x[,tt0,drop=F],type="link",s=lambda/n))
# }
# }
# cov0[j]=sum(yy*yhat0)
# }
# }
# }
# 
# if(is.numeric((sigma.est))){
#   sigma=sigma.est;sigma.type="known";null.dist="Exp(1)"
#   if(sigma.est<=0){stop("sigma.est must be positive")}
# }
# if(sigma.est=="full"){
#   if(nrow(x)<ncol(x)+1) stop("Number of observations must exceed number of variables,
#                              when sigma.est is `full; you need to specify a numeric value for sigma.est")
#   sigma.type="unknown"
#   aaa=lsfit(x,y)
#   sigma=sqrt(sum(aaa$res^2)/(n-p))
#   np=n-p
#   null.dist=paste("F(2,",as.character(np),")",sep="")
# }
# tt=((cov-cov0)/sigma^2)
# 
# if(sigma.type=="known"){out=cbind(jlist,tt,1-pexp(tt,1));dimnames(out)[[2]]=c("Predictor_Number","Drop_in_covariance","P-value")}
# if(sigma.type=="unknown"){out=cbind(jlist,tt,1-pf(tt,2,n-p));dimnames(out)[[2]]=c("Predictor_Number","Drop_in_covariance","P-value")}
# dimnames(out)[[1]]=rep("",nrow(out))
# return(list(results=round(out,4),sigma=round(sigma,4),null.dist=null.dist))
# 
# 
# 
# }
