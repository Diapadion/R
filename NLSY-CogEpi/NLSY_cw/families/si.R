### Families and households controls


library(data.table)

library(lme4)



sibs <- read.csv('./families/HouseholdID.csv')

sibs = as.data.table(sibs)

#table(sibs$R0000149, useNA='ifany')
table(table(sibs$R0000149, useNA='ifany'), useNA='ifany')


colnames(sibs)[2:3] = c('IndividualID','HouseholdID')


sibs <- cbind(as.data.table(cw.df), sibs[,c(2:3)])

## Age at testing
sibs$DOB = as.Date(paste3(paste0('19',as.numeric(levels(sibs$DOB_year))[sibs$DOB_year]),
                           as.numeric(levels(sibs$DOB_month))[sibs$DOB_month],
                           '01',sep='-'), format='%Y-%m-%d')

pasteDate = as.Date(paste3('1979',
                           #sibs$month_79, # still need this
                           '06', # temp
                           '01',sep='-'), format='%Y-%m-%d')
sibs$age_1979 = (pasteDate-sibs$DOB)/365.25
head(sibs$age_1979)



sibs$HouseholdID = as.factor(sibs$HouseholdID)


n_occur <- data.table(table(sibs$HouseholdID))
sibs = sibs[sibs$HouseholdID %in% n_occur$V1[n_occur$N>1],]





### Prelim analysis

lm.1 = glm(H50_DR_Depression ~ age_1979 + AFQT89 + SAMPLE_SEX + Child_SES,
            data = sibs, family=binomial)
summary(lm.1)
#   (3586 observations deleted due to missingness)


lmm.1 <- glmer(H50_DR_Depression ~ age_1979 + AFQT89 + SAMPLE_SEX + Child_SES +
                 (1|HouseholdID), 
               data = sibs, family=binomial)
summary(lmm.1)



lmm.2 <- glmer(H50_DR_Depression ~ age_1979 + AFQT89 + SAMPLE_SEX + Child_SES +
                 (0 + AFQT89|HouseholdID), 
               data = sibs, family=binomial)
summary(lmm.2)



##

lm.b.1 = lm(H50_CESD_7 ~ age_1979 + AFQT89 + SAMPLE_SEX + Child_SES,
              data = sibs)
summary(lm.b.1)


lmm.b.1 <- lmer(H50_CESD_7 ~ age_1979 + AFQT89 + SAMPLE_SEX + Child_SES +
                 (1|HouseholdID), 
               data = sibs)
summary(lmm.b.1)


lmm.b.2 <- lmer(H50_CESD_7 ~ age_1979 + AFQT89 + SAMPLE_SEX + Child_SES +
                 (0 + AFQT89|HouseholdID), 
               data = sibs)
summary(lmm.b.2)



##

table(as.integer(sibs$H50_sleep_1))
sibs$sleep = as.integer(sibs$H50_sleep_1) + as.integer(sibs$H50_sleep_2) + 
  as.integer(sibs$H50_sleep_3) + as.integer(sibs$H50_sleep_4)
table(sibs$sleep)


lm.c.1 = lm(sleep ~ age_1979 + AFQT89 + SAMPLE_SEX + Child_SES,
            data = sibs)
summary(lm.c.1)


lmm.c.1 <- lmer(sleep ~ age_1979 + AFQT89 + SAMPLE_SEX + Child_SES +
                  (1|HouseholdID), 
                data = sibs)
summary(lmm.c.1)


lmm.c.2 <- lmer(sleep ~ age_1979 + AFQT89 + SAMPLE_SEX + Child_SES +
                  (0 + AFQT89|HouseholdID), 
                data = sibs)
summary(lmm.c.2)



##

lm.d.1 = lm(H50_SF12_MentalHealth ~ age_1979 + AFQT89 + SAMPLE_SEX + Child_SES,
            data = sibs)
summary(lm.d.1)


lmm.d.1 <- lmer(H50_SF12_MentalHealth ~ age_1979 + AFQT89 + SAMPLE_SEX + Child_SES +
                  (1|HouseholdID), 
                data = sibs)
summary(lmm.d.1)


lmm.d.2 <- lmer(H50_SF12_MentalHealth ~ age_1979 + AFQT89 + SAMPLE_SEX + Child_SES +
                  (0 + AFQT89|HouseholdID), 
                data = sibs)
summary(lmm.d.2)



