### initial correlation tests

# summarizing the vars

p.summar = cbind(mtrim[,c(49:55)], aggregate(trial.dat[,c(4:6)],by=list(trial.dat$Subject), FUN=mean))
p.summar = cbind(p.summar,aggregate(log(RT.dat$RT), by=list(RT.dat$Subject), FUN=mean))
p.summar = cbind(p.summar,aggregate(log(RT.dat1$RT), by=list(RT.dat1$Subject), FUN=mean))

cor.r_e = cor(p.summar$Correct,p.summar$Error)
cor.r_p = cor(p.summar$Correct,p.summar$Progress)
cor.p_e = cor(p.summar$Progress,p.summar$Error)
                        

cor.t.r_f = cor.test(p.summar$Correct,p.summar$Friendliness)
cor.t.r_o = cor.test(p.summar$Correct,p.summar$Openness)
cor.t.r_c = cor.test(p.summar$Correct,p.summar$Confidence)

cor.t.e_f = cor.test(p.summar$Error,p.summar$Friendliness)
cor.t.e_o = cor.test(p.summar$Error,p.summar$Openness)
cor.t.e_c = cor.test(p.summar$Error,p.summar$Confidence)
cor.t.e_a = cor.test(p.summar$Error,p.summar$Activity)


cor.t.p_f = cor.test(p.summar$Progress,p.summar$Friendliness)
cor.t.p_o = cor.test(p.summar$Progress,p.summar$Openness)
cor.t.p_c = cor.test(p.summar$Progress,p.summar$Confidence)
cor.t.p_act = cor.test(p.summar$Progress,p.summar$Activity)


cor.t.rt_f = cor.test(p.summar$x,p.summar$Friendliness)
cor.t.rt_o = cor.test(p.summar$x,p.summar$Openness)
cor.t.rt_c = cor.test(p.summar$x,p.summar$Confidence)
cor.t.rt_act = cor.test(p.summar$x,p.summar$Activity)
cor.t.rt_anx = cor.test(p.summar$x,p.summar$Anxiety)





library(corrgram)
corrgram(p.summar)


cormat <- cor(p.summar[,c(-7,-8,-12,-14)])

cor.mtest <- function(mat, conf.level = 0.95){
  mat <- as.matrix(mat)
  n <- ncol(mat)
  p.mat <- lowCI.mat <- uppCI.mat <- matrix(NA, n, n)
  diag(p.mat) <- 0
  diag(lowCI.mat) <- diag(uppCI.mat) <- 1
  for(i in 1:(n-1)){
    for(j in (i+1):n){
      tmp <- cor.test(mat[,i], mat[,j], conf.level = conf.level)
      p.mat[i,j] <- p.mat[j,i] <- tmp$p.value
      lowCI.mat[i,j] <- lowCI.mat[j,i] <- tmp$conf.int[1]
      uppCI.mat[i,j] <- uppCI.mat[j,i] <- tmp$conf.int[2]
    }
  }
  return(list(p.mat, lowCI.mat, uppCI.mat))
}

res1 <- cor.mtest(cormat,0.01)

# correlations of r > 0.66 are significant at p < 0.05

library(corrplot)
## use this for pub
corrplot(cormat,type="lower", method = 'number',diag = F, addCoef.col = 'grey27',
         p.mat = res1[[1]], sig.level = 0.005, insig = 'n', pch = '*' 
         )

corrplot(res1[[1]],type="lower",diag = F, addCoef.col = 'grey')

