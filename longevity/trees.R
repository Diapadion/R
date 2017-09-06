### Decision tree analyses



#library(party)
library(partykit)
library(LTRCtrees)
library(rpart.plot)
library(ipred)
library(survival)



datX$sex = as.factor(datX$sex)
levels(datX$sex) = c('Female','Male')


cit.1 = LTRCIT(Surv(age_pr, age, status) ~ 
                 sex + as.factor(origin) +  
                 Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ,
               data=datX)

cit.1.x = LTRCIT(Surv(age_pr, age, status) ~ 
                   as.factor(sex) + as.factor(origin) +  
                   Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ,
                 data=datX, 
                 Control = ctree_control(mincriterion = 0.90, minprob=0.001, mtry=100)
                 )
plot(cit.1.x)


cit.2 = LTRCIT(Surv(age_pr, age, status) ~ 
                 as.factor(sex) + as.factor(origin) +  
                 D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB,
               data=datX)

cit.2.x = LTRCIT(Surv(age_pr, age, status) ~ 
                   # as.factor(sex) + as.factor(origin) +  
                   D.r2.DoB + E.r2.DoB + Con_CZ + Agr_CZ + N.r1.DoB + O.r2.DoB,
                 data=datX)





#plot(irisct, gp = gpar(fontsize = 20)) 
plot(cit.1, gp = gpar(fontfamily='sans',fontsize = 15),
     inner_panel=node_inner,
     ip_args=list(
       abbreviate = F, 
       id = FALSE)
     # edge_panel=node_surv,
     # ep_args = list(
     #   id = F)
     )

print(cit.1.x)

plot(cit.1, gp = gpar(fontfamily='sans',fontsize = 15),
     inner_panel=node_inner,
     ip_args=list(
       abbreviate = F, 
       id = FALSE)
     # edge_panel=node_surv,
     # ep_args = list(
     #   id = F)
)


RR.a.party = as.party(RR.a)
RR.a.party$fitted[["(response)"]]<- Surv(datX$age_pr, datX$age, datX$stat.log)

plot(RR.a.party,gp = gpar(fontfamily='sans',fontsize = 15),
     inner_panel=node_inner,
     ip_args=list(
       abbreviate = F, 
       id = FALSE)
     # edge_panel=node_surv,
     # ep_args = list(
     #   id = F)
)


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

rrt.1 = LTRCART(Surv(age_pr, age, stat.log) ~
                  as.factor(sex) + as.factor(origin) +
                  Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ,
                data=datX)
rpart.plot(rrt.1)
text(rrt.1)




# cv.rrt.1 = validate(rrt.1, data=datX)


#http://luisdva.github.io/Plotting-conditional-inference-trees-in-R/


  
  
  
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



### Nice plots - for publication

plot (cit.1,inner_panel=innerWeights,
#      terminal_panel=node_barplot2,
      tp_args = list(ylines = c(2, 4)))

plot(RR.a, inner_panel=innerWeights)



### Plotting helper functions

# custom barplot function to alter the appearance of terminal nodes
# modified from code provided by Achim Zeileis to the R-help mailing list 
# source the function and assign it as a grapcon_generator object
node_barplot2 <- function(ctreeobj,
                          col = "black",
                          fill = c("red", "white"),
                          beside = NULL,
                          ymax = NULL,
                          ylines = NULL,
                          widths = 1,
                          gap = NULL,
                          reverse = NULL,
                          id = TRUE)
{
  getMaxPred <- function(x) {
    mp <- max(x$prediction)
    mpl <- ifelse(x$terminal, 0, getMaxPred(x$left))
    mpr <- ifelse(x$terminal, 0, getMaxPred(x$right))
    return(max(c(mp, mpl, mpr)))
  }
  
  y <- response(ctreeobj)[[1]]
  
  if(is.factor(y) || class(y) == "was_ordered") {
    ylevels <- levels(y)
    if(is.null(beside)) beside <- if(length(ylevels) < 3) FALSE else TRUE
    if(is.null(ymax)) ymax <- if(beside) 1.1 else 1
    if(is.null(gap)) gap <- if(beside) 0.1 else 0
  } else {
    if(is.null(beside)) beside <- FALSE
    if(is.null(ymax)) ymax <- getMaxPred(ctreeobj @ tree) * 1.1
    ylevels <- seq(along = ctreeobj @ tree$prediction)
    if(length(ylevels) < 2) ylevels <- ""
    if(is.null(gap)) gap <- 1
  }
  if(is.null(reverse)) reverse <- !beside
  if(is.null(fill)) fill <- gray.colors(length(ylevels))
  if(is.null(ylines)) ylines <- if(beside) c(3, 4) else c(1.5, 2.5)
  
  ### panel function for barplots in nodes
  rval <- function(node) {
    
    ## parameter setup
    pred <- node$prediction
    if(reverse) {
      pred <- rev(pred)
      ylevels <- rev(ylevels)
    }
    np <- length(pred)
    nc <- if(beside) np else 1
    
    fill <- rep(fill, length.out = np)
    widths <- rep(widths, length.out = nc)
    col <- rep(col, length.out = nc)
    ylines <- rep(ylines, length.out = 2)
    
    gap <- gap * sum(widths)
    yscale <- c(0, ymax)
    xscale <- c(0, sum(widths) + (nc+1)*gap)
    
    top_vp <- viewport(layout = grid.layout(nrow = 2, ncol = 3,
                                            widths = unit(c(ylines[1], 1, ylines[2]), c("lines", "null", "lines")),
                                            heights = unit(c(3.5,3.5), c("lines", "null"))),
                       width = unit(1, "npc"),
                       height = unit(1, "npc") - unit(2, "lines"),
                       name = paste("node_barplot", node$nodeID, sep = ""))
    
    pushViewport(top_vp)
    grid.rect(gp = gpar(fill = "white", col = 0))
    
    ## main title
    top <- viewport(layout.pos.col=2, layout.pos.row=1)
    pushViewport(top)
    mainlab <- paste(ifelse(id, paste("Node", node$nodeID,"\n", "(n = "), "n = "),
                     sum(node$weights), ifelse(id, ")", ""), sep = "")
    grid.text(mainlab)
    popViewport()
    
    plot <- viewport(layout.pos.col=2, layout.pos.row=2,
                     xscale=xscale, yscale=yscale,
                     name = paste("node_barplot", node$nodeID, "plot",
                                  sep = ""))
    
    pushViewport(plot)
    
    if(beside) {
      xcenter <- cumsum(widths+gap) - widths/2
      for (i in 1:np) {
        grid.rect(x = xcenter[i], y = 0, height = pred[i],
                  width = widths[i],
                  just = c("center", "bottom"), default.units = "native",
                  gp = gpar(col = col[i], fill = fill[i]))
      }
      if(length(xcenter) > 1) grid.xaxis(at = xcenter, label = FALSE)
      grid.text(ylevels, x = xcenter, y = unit(-1, "lines"),
                default.units = "native",
                just= c("center","bottom"),
                check.overlap = TRUE)
      grid.yaxis()
    } else {
      ycenter <- cumsum(pred) - pred
      
      for (i in 1:np) {
        grid.rect(x = xscale[2]/2, y = ycenter[i], height = min(pred[i], ymax - ycenter[i]),
                  width = widths[1],
                  just = c("center", "bottom"), default.units = "native",
                  gp = gpar(col = col[i], fill = fill[i]))
      }
      
      grid.yaxis(at = round(1 - pred[i], digits = 2), main = FALSE)
    }
    
    grid.rect(gp = gpar(fill = "transparent"))
    upViewport(2)
  }
  
  return(rval)
}
class(node_barplot2) <- "grapcon_generator"

# custom function by user "agstudy"
# draws a white circle with the node name and the number of obs.
# innerWeights <- function(node){
#   grid.circle(r=0.36,gp = gpar(fill = "White",col="White"))
#   mainlab <- paste( node$psplit$variableName, "\n(n = ")
#   mainlab <- paste(mainlab, sum(node$weights),")" , sep = "")
#   grid.text(mainlab,gp = gpar(col='black'))
# }

innerWeights <- function(node){
  grid.circle(gp = gpar(fill = "White", col = 'black'))
  mainlab <- paste(node$psplit$variableName, "\n(n = ")
  mainlab <- paste(mainlab, sum(node$weights),")" , sep = "")
  grid.text(mainlab,gp = gpar(col='black'))
}

