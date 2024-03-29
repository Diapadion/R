
# Set working directory
# setwd()


new_data <- read.table('HouseholdID.dat', sep=' ')
names(new_data) <- c('A0002600',
  'R0000100',
  'R0000149',
  'R0173600',
  'R0214700',
  'R0214800')


# Handle missing values

  new_data[new_data == -1] = NA  # Refused 
  new_data[new_data == -2] = NA  # Dont know 
  new_data[new_data == -3] = NA  # Invalid missing 
  new_data[new_data == -4] = NA  # Valid missing 
  new_data[new_data == -5] = NA  # Non-interview 


# If there are values not categorized they will be represented as NA

vallabels = function(data) {
  data$A0002600[1.0 <= data$A0002600 & data$A0002600 <= 999.0] <- 1.0
  data$A0002600[1000.0 <= data$A0002600 & data$A0002600 <= 1999.0] <- 1000.0
  data$A0002600[2000.0 <= data$A0002600 & data$A0002600 <= 2999.0] <- 2000.0
  data$A0002600[3000.0 <= data$A0002600 & data$A0002600 <= 3999.0] <- 3000.0
  data$A0002600[4000.0 <= data$A0002600 & data$A0002600 <= 4999.0] <- 4000.0
  data$A0002600[5000.0 <= data$A0002600 & data$A0002600 <= 5999.0] <- 5000.0
  data$A0002600[6000.0 <= data$A0002600 & data$A0002600 <= 6999.0] <- 6000.0
  data$A0002600[7000.0 <= data$A0002600 & data$A0002600 <= 7999.0] <- 7000.0
  data$A0002600[8000.0 <= data$A0002600 & data$A0002600 <= 8999.0] <- 8000.0
  data$A0002600[9000.0 <= data$A0002600 & data$A0002600 <= 9999.0] <- 9000.0
  data$A0002600[10000.0 <= data$A0002600 & data$A0002600 <= 10999.0] <- 10000.0
  data$A0002600[11000.0 <= data$A0002600 & data$A0002600 <= 11999.0] <- 11000.0
  data$A0002600[12000.0 <= data$A0002600 & data$A0002600 <= 12999.0] <- 12000.0
  data$A0002600 <- factor(data$A0002600, 
    levels=c(1.0,1000.0,2000.0,3000.0,4000.0,5000.0,6000.0,7000.0,8000.0,9000.0,10000.0,11000.0,12000.0), 
    labels=c("1 TO 999",
      "1000 TO 1999",
      "2000 TO 2999",
      "3000 TO 3999",
      "4000 TO 4999",
      "5000 TO 5999",
      "6000 TO 6999",
      "7000 TO 7999",
      "8000 TO 8999",
      "9000 TO 9999",
      "10000 TO 10999",
      "11000 TO 11999",
      "12000 TO 12999"))
  data$R0173600 <- factor(data$R0173600, 
    levels=c(1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0,12.0,13.0,14.0,15.0,16.0,17.0,18.0,19.0,20.0), 
    labels=c("CROSS MALE WHITE",
      "CROSS MALE WH. POOR",
      "CROSS MALE BLACK",
      "CROSS MALE HISPANIC",
      "CROSS FEMALE WHITE",
      "CROSS FEMALE WH POOR",
      "CROSS FEMALE BLACK",
      "CROSS FEMALE HISPANIC",
      "SUP MALE WH POOR",
      "SUP MALE BLACK",
      "SUP MALE HISPANIC",
      "SUP FEM WH POOR",
      "SUP FEMALE BLACK",
      "SUP FEMALE HISPANIC",
      "MIL MALE WHITE",
      "MIL MALE BLACK",
      "MIL MALE HISPANIC",
      "MIL FEMALE WHITE",
      "MIL FEMALE BLACK",
      "MIL FEMALE HISPANIC"))
  data$R0214700 <- factor(data$R0214700, 
    levels=c(1.0,2.0,3.0), 
    labels=c("HISPANIC",
      "BLACK",
      "NON-BLACK, NON-HISPANIC"))
  data$R0214800 <- factor(data$R0214800, 
    levels=c(1.0,2.0), 
    labels=c("MALE",
      "FEMALE"))
  return(data)
}

varlabels <- c("VERSION_R26_1 2014",
  "ID# (1-12686) 79",
  "HH ID # 79",
  "SAMPLE ID  79 INT",
  "RACL/ETHNIC COHORT /SCRNR 79",
  "SEX OF R 79"
)


# Use qnames rather than rnums

qnames = function(data) {
  names(data) <- c("VERSION_R26_2014",
    "CASEID_1979",
    "HHID_1979",
    "SAMPLE_ID_1979",
    "SAMPLE_RACE_78SCRN",
    "SAMPLE_SEX_1979")
  return(data)
}


#********************************************************************************************************

# Remove the '#' before the following line to create a data file called "categories" with value labels. 
#categories <- vallabels(new_data)

# Remove the '#' before the following lines to rename variables using Qnames instead of Reference Numbers
#new_data <- qnames(new_data)
#categories <- qnames(categories)

# Produce summaries for the raw (uncategorized) data file
summary(new_data)

# Remove the '#' before the following lines to produce summaries for the "categories" data file.
#categories <- vallabels(new_data)
#summary(categories)

#************************************************************************************************************

