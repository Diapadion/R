
library(foreign)

wisc <- read.spss('Z:/WisconsinLongitudinal/wls_pub_13_03.sav', to.data.frame = T)
#warnings()

wisc.sib <- wisc[,c('xbrdxdy','xlivsib','xdeatyr','ssbsex','nh009rec','nh009rei',
                    'nh011rer','nh012rer','nh013rer','nh014rer','nh015rer','nh016rer',
                    'nh004rer','nh007rer')]
rm(wisc)

wisc.sib[!(wisc.sib$xlivsib=='no'),] <- NA
wisc.sib[wisc.sib$xdeatyr %in% c('9972','9972','9974','9976','9977','9997','9999'),] <- NA
wisc.sib[wisc.sib == 'ref/na'] <- NA

toScore <- function(val){
  ifelse(val=='agree strongly', val<-6,
         ifelse(val=='agree moderately', val<-5,
                ifelse(val=='agree slightly',val<-4,
                       ifelse(val=='disagree slightly',val<-3,
                              ifelse(val=='disagree moderately',val<-2,
                                     ifelse(val=='disagree strongly',val<-1,
                                            val<-NA))))))
}

for (i in c(7:14)){
  wisc.sib[,i] = sapply(wisc.sib[,i], toScore)
}

wisc.sib <- wisc.sib[complete.cases(wisc.sib),]

#table(wisc.sib$xdeatyr)
#table(wisc.sib$DeathAge)

#wisc.sib$xbrdxdy[wisc.sib$xdeatyr=='1994']

wisc.sib$DeathAge = wisc.sib$xdeatyr - wisc.sib$xbrdxdy - 1900


plot(wisc.sib$DeathAge, wisc.sib$nh009rec)

cor.test(wisc.sib$DeathAge, wisc.sib$nh009rec)


### New scores

### Altruism

# nh013rer: To what extent do you agree that you see yourself as someone who is generally trusting?
# nh015rer: To what extent do you agree that you see yourself as someone who is considerate to almost everyone?
# nh016rer: To what extent do you agree that you see yourself as someone who likes to cooperate with others

wisc.sib$Alt.z <- scale(wisc.sib$nh013rer + wisc.sib$nh015rer + wisc.sib$nh016rer #- wisc.sib$nh014rer + 7
                        )

### Dominance

# nh011rer: To what extent do you agree that you see yourself as someone who tends to find fault with others?
# nh012rer: To what extent do you agree that you see yourself as someone who is sometimes rude to others?
# nh004rer: To what extent do you agree that you see yourself as someone who is reserved?
# nh007rer: To what extent do you agree that you see yourself as someone who is sometimes shy, inhibited?

wisc.sib$Dom.z <- scale(wisc.sib$nh011rer + wisc.sib$nh012rer - wisc.sib$nh004rer - wisc.sib$nh007rer + 14)

# Exclude?

#? nh014rer: To what extent do you agree that you see yourself as someone who can be cold and aloof?



###

outliers <- function(obs, x = 2.5)
  abs(obs - mean(obs, na.rm = T)) > (sd(obs, na.rm = T) * x)

wisc.sib$Alt.z[outliers(wisc.sib$Alt.z)] <- NA
# rescale
#wisc.sib$Alt.z <- scale(wisc.sib$Alt.z)


plot(wisc.sib$DeathAge, wisc.sib$Alt.z)

cor.test(wisc.sib$DeathAge, wisc.sib$Alt.z)


# ugh this works better above than it does here
wisc.sib$Dom.z[outliers(wisc.sib$Dom.z)] <- NA
#wisc.sib$Dom.z <- scale(wisc.sib$Dom.z)



plot(wisc.sib$DeathAge, wisc.sib$Dom.z)


cor.test(wisc.sib$DeathAge, wisc.sib$Dom.z)



library(ggplot2)

p <- ggplot(wisc.sib, aes(Dom.z, Alt.z)) + 
  geom_jitter(size = (wisc.sib$DeathAge-20)/7, colour = 'blue', alpha = 0.1) #+
  #coord_cartesian(xlim = c(-2, 2), ylim = c(-2, 2))

p



### How about some Chimps

deCH <- datX[datX$stat.log==T,c('age','Dom_CZ','Agr_CZ')]
colnames(deCH) <- c('DeathAge','Dom.z','Alt.z')
deCH$species = 'chimp'

wisc.sib$species = 'human'

sampH <- sample(1:dim(wisc.sib)[1], dim(deCH[1]))
deCH <- rbind(deCH, wisc.sib[sampH,c('DeathAge','Dom.z','Alt.z','species')])


# df adjustments for plotting aesthetics
deCH$Alt.z[deCH$species=='chimp'] = deCH$Alt.z[deCH$species=='chimp'] / 2.5

deCH$DeathAge[deCH$species=='human'] = deCH$DeathAge[deCH$species=='human']  -30 #/ 2?
 

# and the final plot

squ = c(-2.0, 2.0)

p <- ggplot(deCH, aes(Dom.z, Alt.z, colour = species)) + 
  #geom_jitter(aes(colour=deCH$species,size = (deCH$DeathAge)/7, alpha = 0.1), position='jitter') #+
  geom_jitter(size= deCH$DeathAge/2, alpha = 0.5, show.legend = FALSE,
              width = 0.3, height = 0.3) +  #aes(colour=deCH$species) +
coord_cartesian(xlim = squ, ylim = squ) +
  scale_color_manual(values=c('red','steelblue1')) + theme_bw()

p

("#FF5252", "#1D75E1")
#56B4E9
