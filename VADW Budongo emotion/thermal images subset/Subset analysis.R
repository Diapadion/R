# read in data subset
therm_sub <- read.csv("Image subset to analyse.csv", header = T, sep = ",", na.strings = c("N/A", " "))
names(therm_sub)
names(therm_sub) [1] <- "condition"

class(therm_sub$LE.Mean)
# replace comma in Time column with period
therm_sub$LE.Area <- as.numeric(gsub(",", ".", therm_sub$LE.Area))
therm_sub$LE.Mean <- as.numeric(gsub(",", ".", therm_sub$LE.Mean))
therm_sub$LE.StdDev <- as.numeric(gsub(",", ".", therm_sub$LE.StdDev))
therm_sub$LE.Min <- as.numeric(gsub(",", ".", therm_sub$LE.Min))
therm_sub$LE.Max <- as.numeric(gsub(",", ".", therm_sub$LE.Max))
therm_sub$RE.Area <- as.numeric(gsub(",", ".", therm_sub$RE.Area))
therm_sub$RE.Mean <- as.numeric(gsub(",", ".", therm_sub$RE.Mean))
therm_sub$RE.StdDev <- as.numeric(gsub(",", ".", therm_sub$RE.StdDev))
therm_sub$RE.Min <- as.numeric(gsub(",", ".", therm_sub$RE.Min))
therm_sub$RE.Max <- as.numeric(gsub(",", ".", therm_sub$RE.Max))
therm_sub$Nose.Area <- as.numeric(gsub(",", ".", therm_sub$Nose.Area))
therm_sub$Nose.Mean <- as.numeric(gsub(",", ".", therm_sub$Nose.Mean))
therm_sub$Nose.StdDev <- as.numeric(gsub(",", ".", therm_sub$Nose.StdDev))
therm_sub$Nose.Min <- as.numeric(gsub(",", ".", therm_sub$Nose.Min))
therm_sub$Nose.Max <- as.numeric(gsub(",", ".", therm_sub$Nose.Max))

therm_sub2 <- therm_sub[which(therm_sub$LE.Mean < 200),]

# examine left eye
hist(therm_sub2$LE.Mean, breaks = 20)
hist(therm_sub2$LE.Min, breaks = 20)
hist(therm_sub2$LE.Max, breaks = 20)
# examine right eye
hist(therm_sub2$RE.Mean, breaks = 20)
hist(therm_sub2$RE.Min, breaks = 20)
hist(therm_sub2$RE.Max, breaks = 20)
# LB: 4 instances of strange eye temp (~200) - repeat measurements
# examine nose
hist(therm_sub2$Nose.Mean, breaks = 20)
hist(therm_sub2$Nose.Min, breaks = 20)
hist(therm_sub2$Nose.Max, breaks = 20) # widest temp variation in nose

table(therm_sub2$condition)
# can only examine temp change within ed19, lb20.2, pa6 and pe15 (3-6 images)
# fk19,fk3,fk9,kl19,lb10 all have 2 images

# ed19, no BL, no nose
plot(therm_sub2$LE.Mean[which(therm_sub2$condition == "ed19")]) # decrease
plot(therm_sub2$RE.Mean[which(therm_sub2$condition == "ed19")]) # decrease

# lb20, no BL, no nose
# **NB 2 data points removed due to extreme outlier (> 200)**
plot(therm_sub2$LE.Mean[which(therm_sub2$condition == "lb20.2")]) # non linear change
plot(therm_sub2$RE.Mean[which(therm_sub2$condition == "lb20.2")]) # non linear change

# pa6, with BL
plot(therm_sub2$LE.Mean[which(therm_sub2$condition == "pa6")]) # linear decrease
plot(therm_sub2$RE.Mean[which(therm_sub2$condition == "pa6")]) # increase

# pe15, with BL
plot(therm_sub2$LE.Mean[which(therm_sub2$condition == "pe15")]) # non linear change
plot(therm_sub2$RE.Mean[which(therm_sub2$condition == "pe15")]) # non linear change
plot(therm_sub2$Nose.Mean[which(therm_sub2$condition == "pe15")]) # increase

