

setwd('/') # change this to where you want to operate

files <- (Sys.glob("*.jpg"))

piclist <- NULL

for (i in 1:length(files)) {
  dater = file.info(files[i])
  piclist = rbind(piclist,cbind(files[i],as.character(dater$ctime)))
  
}


write.csv(piclist,"imgNameDates.csv")
