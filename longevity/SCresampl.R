### Permutations for Inferential Specification Curves



# x <- 1:12
# # a random permutation
# sample(x)
# # bootstrap resampling -- only if length(x) > 1 !
# sample(x, replace = TRUE)

# testing

var = 4
reps = 1000

resamp = data.frame(matrix(NA,nrow=reps,ncol=12))
for(i in 1:reps){
  ind = sample(dim(yLt)[1], replace = T)
  newY = yLt[ind,]
  # fit = survreg(newY ~ as.factor(sex) + as.factor(origin) +  
  #                 Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ
  #               + frailty.gaussian(sample) + strata(datX$strt)
  #               , data=datX, dist='t')
  fit = survreg(newY ~ as.factor(sex) +
                  Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ
                + frailty.gaussian(sample)
                , data=datX, dist='logistic')
  resamp[i,] = fit$coefficients
}

#rs.u.x.l.6 = resamp
quantile(rs.u.x.l.6[,4], c(0.025,0.975))
median(rs.u.x.l.6[,4])

#rs.s.i.t.6 = resamp
quantile(rs.s.i.t.6[,7], c(0.025,0.975))
median(rs.s.i.t.6[,7])

summary(AFT.u.x.l.6)



effsz = function(mod, var){
  
  mod$coefficients[var]
  
  
}

censboot(datX,)