### initial correlation tests

# summarizing the vars

p.summar = cbind(mtrim[,c(49:55)], aggregate(trial.dat[,c(3:5)],by=list(trial.dat$Subject), FUN=mean))
p.summar = cbind(p.summar,aggregate(log(RT.dat$RT), by=list(RT.dat$Subject), FUN=mean))

cor.r_e = cor(p.summar$Correct,p.summar$Error)
cor.r_p = cor(p.summar$Correct,p.summar$Progress)
cor.p_e = cor(p.summar$Progress,p.summar$Error)
                        

cor.t.r_f = cor.test(p.summar$Correct,p.summar$Friendliness)
cor.t.r_o = cor.test(p.summar$Correct,p.summar$Openness)
cor.t.r_c = cor.test(p.summar$Correct,p.summar$Confidence)

cor.t.e_f = cor.test(p.summar$Error,p.summar$Friendliness)
cor.t.e_o = cor.test(p.summar$Error,p.summar$Openness)
cor.t.e_c = cor.test(p.summar$Error,p.summar$Confidence)

cor.t.p_f = cor.test(p.summar$Progress,p.summar$Friendliness)
cor.t.p_o = cor.test(p.summar$Progress,p.summar$Openness)
cor.t.p_c = cor.test(p.summar$Progress,p.summar$Confidence)

cor.t.rt_f = cor.test(p.summar$x,p.summar$Friendliness)
cor.t.rt_o = cor.test(p.summar$x,p.summar$Openness)
cor.t.rt_c = cor.test(p.summar$x,p.summar$Confidence)
cor.t.rt_act = cor.test(p.summar$x,p.summar$Activity)
cor.t.rt_anx = cor.test(p.summar$x,p.summar$Anxiety)





library(corrgram)
corrgram(p.summar)
