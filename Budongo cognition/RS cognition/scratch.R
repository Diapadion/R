


setwd('Z:/chimp cognitive data/RS/training/')

flist = NULL


setwd("2-choice AA1 black/")
flist = append(flist, list.files(pattern="*.csv"))

write.csv(flist, file = '../../tempList.csv')

              
setwd("../2-choice AA2 black/")
flist = append(flist, list.files(pattern="*.csv"))


setwd('../2-choice ABpairs2_fine/')
flist = append(flist, list.files(pattern="*.csv"))


setwd("../2-choice ABpairs3_fett/")
flist = append(flist, list.files(pattern="*.csv"))


setwd("../2-choice ABpairs4/")
flist = append(flist, list.files(pattern="*.csv"))


setwd("../../testing/all/")
flist = append(flist, list.files(pattern="*.csv"))
              
              