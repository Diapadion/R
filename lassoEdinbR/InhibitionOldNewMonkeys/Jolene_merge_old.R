library(xlsx)



### Importing and merging files
BeranCaps <- read.csv("caps_to_drew.csv")

trial.data <- read.xlsx("Copy of Exp 4 EDIT Beran et al 2016 Behavioural Processes.xlsx", sheetIndex=8)


bcp <- aggregate(BeranCaps, by=list(capuchin=BeranCaps$Capuchin), mean)


trial.data <- merge(trial.data, bcp,
                    by.x = "Capuchin", by.y = "capuchin",
                    all.x = TRUE, all.y = FALSE
                    )



### Looking at how many cases there are in specific variables
table(trial.data$Choice, useNA='ifany')
table(trial.data$X1st.Bar, useNA='ifany')
table(trial.data$X2nd.Bar, useNA='ifany')



### Fixing labels to be consistent
trial.data$Choice[trial.data$Choice=='Banana '] = 'Banana'
trial.data$Choice[trial.data$Choice=='large'] = 'Large'


### Dropping leftover labels
trial.data$Choice = droplevels(trial.data$Choice)



### Getting rid of forced trials
trial.data <- trial.data[!(trial.data$X1st.Bar=='Forced Carrot '),]

trial.data <- trial.data[!(trial.data$X2nd.Bar=='Forced Banana'),]




### Making binary variable for if they chose banana, large reward, etc
trial.data$BestChoice = NA
trial.data$BestChoice[trial.data$Choice=='Banana'] = 1 # this is a comment



### Making binary variable for when they choose the first option available

