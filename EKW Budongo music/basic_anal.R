


data1<- read.csv(file.choose(),header=T)
#choose excel file (saved as .csv file)

#data1

library(lme4)

# To code any explanatory variables that are nominal as categorical factors:
# (this e.g. ID and SESSION is the categorical var that needs recoding as a factor variable)

data1$ID<-factor(data1$ID)

data1$SESSION<-factor(data1$SESSION)

# RUN THE MODEL
# In this model trying to explain variation in MORS (0/1) with explanatory 
# variables SESSION (categorical) and PRECOND– random factor = ID (catetgorical)

model.1<- glmer(MORS~scale(PRECOND)+SESSION+(1|ID), data=data1, family=binomial(link='logit'),
                nAGQ=10
                  )

glm.1<- glm(MORS~scale(PRECOND)+SESSION+ID, data=data1, family=binomial(link='logit')   
)

#To see the basic output

summary(model.1)
