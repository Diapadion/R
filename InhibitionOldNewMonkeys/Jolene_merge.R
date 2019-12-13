#library(xlsx)

#setwd('./R/CapsPers/')
read.csv("caps_to_drew.csv")

### Importing and merging files
BeranCaps <- read.csv("caps_to_drew.csv", stringsAsFactors = TRUE)

trial.data <-
    read.csv('Exp 4 EDIT Beran et al 2016 Behavioural Processes - Copy.csv')

# trial.data <- read.xlsx("Copy of Exp 4 EDIT Beran et al 2016 Behavioural Processes.xlsx", sheetIndex=8)
#            OR       
#              <- read.xlsx("Exp 4 EDIT Beran et al 2016 Behavioural Processes.xlsx", sheetIndex=8)

bcp <- aggregate(BeranCaps, by=list(capuchin=BeranCaps$Capuchin), mean)

xtrial.data <- merge(trial.data, bcp,
                    by.x = "Capuchin", by.y = "capuchin",
                    all=T
                    )

trial.data <- xtrial.data

### Looking at how many cases there are in specific variables
table(trial.data$Choice, useNA='ifany')
table(trial.data$X1st.Bar, useNA='ifany')
table(trial.data$X2nd.Bar, useNA='ifany')

### Fixing labels to be consistent
trial.data$Choice[trial.data$Choice=='Banana '] = 'Banana'
trial.data$Choice[trial.data$Choice=='large'] = 'Large'
trial.data$Choice[trial.data$Choice=='small'] = 'Small'

trial.data$Choice[trial.data$Choice=='Banana'] = 'Large'
trial.data$Choice[trial.data$Choice=='large'] = 'Large'
trial.data$Choice[trial.data$Choice=='Large '] = 'Large'
trial.data$Choice[trial.data$Choice=='Carrot'] = 'Small'
trial.data$Choice[trial.data$Choice=='Carrot '] = 'Small'
trial.data$Choice[trial.data$Choice=='Small'] = 'Small'
trial.data$Choice[trial.data$Choice=='L'] = 'Large'
trial.data$Choice[trial.data$Choice=='S'] = 'Small'
trial.data$Choice[trial.data$Choice=='NA - grabbed first bar'] = NA

### Dropping leftover labels
trial.data$Choice = droplevels(trial.data$Choice)

### Getting rid of forced trials
trial.data <- trial.data[!(is.na(trial.data$X1st.Bar) | is.na(trial.data$X2nd.Bar)),]

### Making binary variable for if they chose banana, large reward, etc
trial.data$BestChoice = 0
trial.data$BestChoice[trial.data$Choice %in% 'Large'] = 1 

trial.data <- trial.data[-c(10:12)]

trial.data$Capuchin = droplevels(trial.data$Capuchin)

fit_opn <- glmer(Choice ~ cap_Soc + Trial.. + (1 + Trial..| Capuchin), data=trial.data, family=binomial)


#summary(fit) 
#show results
#plot(fit)

#will have to export plots to edit; as pdf or vector or jpg


