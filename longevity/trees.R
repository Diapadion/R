### Decision tree analyses


library(party)
library(partykit)
library(LTRCtrees)
library(rpart.plot)
library(ipred)




cit.1 = LTRCIT(Surv(age_pr, age, status) ~ 
                 as.factor(sex) + as.factor(origin) +  
                 Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ,
               data=datX)

cit.1.x = LTRCIT(Surv(age_pr, age, status) ~ 
                   # as.factor(sex) + as.factor(origin) +  
                   Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ,
                 data=datX)


cit.2 = LTRCIT(Surv(age_pr, age, status) ~ 
                 as.factor(sex) + as.factor(origin) +  
                 D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB,
               data=datX)

cit.2.x = LTRCIT(Surv(age_pr, age, status) ~ 
                   # as.factor(sex) + as.factor(origin) +  
                   D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB,
                 data=datX)


plot(cit.1)
print(cit.1.x)


### Random forest

cif.1 = cforest(Surv(age_pr, age, status) ~ 
                  as.factor(sex) + as.factor(origin) +  
                  Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ,
                control = cforest_control(mincriterion = 0.1),
                data=datX)


pt <- prettytree(cif.1@ensemble[[90]], names(cif.1@data@get("input"))) 
nt <- new("BinaryTree") 
nt@tree <- pt 
nt@data <- cif.1@data 
nt@responses <- cif.1@responses 

plot(nt)

cforestImpPlot <- function(x) {
  cforest_importance <<- v <- varimp(x)
  dotchart(v[order(v)])
}


cforestImpPlot(cif.1)

varimp(cif.1)


importance(cif.1)

###




#cit.1.pred = predict(cit.1, newdata=datX, type = 'prob')

rrt.1 = LTRCART(Surv(age_pr, age, status) ~
                  as.factor(sex) + as.factor(origin) +
                  Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ,
                data=datX)
rpart.plot(rrt.1)
text(rrt.1)




# cv.rrt.1 = validate(rrt.1, data=datX)


http://luisdva.github.io/Plotting-conditional-inference-trees-in-R/


  
  
  
# library(rms)



library(randomForest) #SRC)

rf.1 <- rfsrc(Surv(age, status) ~ 
                as.factor(sex) + as.factor(origin) +  
                #Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ,
              D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB,
              nsplit = 10, ntree=100, data=datX)
print(rf.1)
plot(rf.1)
matplot(rf.1$time.interest, 100 * t(rf.1$survival[1:10, ]),
        xlab = "Time", ylab = "Survival", type = "l", lty = 1)
plot.survival(rf.1, subset = 1:10, haz.model='ggamma')

set.seed(779)
vsel = var.select(Surv(age, status) ~
                    as.factor(sex) + as.factor(origin) +
                    Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ,
                  conservative = 'high', sub.order =T,
                  data=datX)
vsel = var.select(Surv(age, status) ~
                    as.factor(sex) + as.factor(origin) +
                    #Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ,
                    D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB,
                  conservative = 'high', sub.order =T,
                  data=datX)

#vsel = max.subtree(rf.1, max.order = 3, sub.order = T)


plot.variable(rf.1, c("Dom_CZ","Ext_CZ","Con_CZ","Neu_CZ","Agr_CZ","Opn_CZ"))



### some figures aggreagated from __

IT.bin.x1 = c(99.9, 100, 100, 99.9, 100, 100)
IT.bin.x2 = c(100, 99.9, 100, 100, 100, 100)

ART.bin.x1 = c(98, 99.9, 100, 98.9, 99.9, 100)
ART.bin.x2 = c(99.9, 99.5, 100, 100, 100, 100)

IT.cont.x1 = c(99.9, 100, 100, 99.9, 99.9, 100)
IT.cont.x2 = c(99.7, 87.6, 100, 100, 98, 100)

ART.cont.x1 = c(95.7, 99.9, 100, 97.3, 99.4, 100)
ART.cont.x2 = c(99.8, 99.2, 100, 100, 99.6, 100)


mean(c(IT.bin.x1,IT.bin.x2,IT.cont.x1,IT.cont.x2))
mean(c(ART.bin.x1,ART.bin.x2,ART.cont.x1,ART.cont.x2))
