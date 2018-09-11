label define vlR0173600   1 "CROSS MALE WHITE"  2 "CROSS MALE WH. POOR"  3 "CROSS MALE BLACK"  4 "CROSS MALE HISPANIC"  5 "CROSS FEMALE WHITE"  6 "CROSS FEMALE WH POOR"  7 "CROSS FEMALE BLACK"  8 "CROSS FEMALE HISPANIC"  9 "SUP MALE WH POOR"  10 "SUP MALE BLACK"  11 "SUP MALE HISPANIC"  12 "SUP FEM WH POOR"  13 "SUP FEMALE BLACK"  14 "SUP FEMALE HISPANIC"  15 "MIL MALE WHITE"  16 "MIL MALE BLACK"  17 "MIL MALE HISPANIC"  18 "MIL FEMALE WHITE"  19 "MIL FEMALE BLACK"  20 "MIL FEMALE HISPANIC"
label values R0173600 vlR0173600
label define vlR0214700   1 "HISPANIC"  2 "BLACK"  3 "NON-BLACK, NON-HISPANIC"
label values R0214700 vlR0214700
label define vlR0214800   1 "MALE"  2 "FEMALE"
label values R0214800 vlR0214800
/* Crosswalk for Reference number & Question name
 * Uncomment and edit this RENAME statement to rename variables for ease of use.
 * This command does not guarantee uniqueness
 */
  /* *start* */
/*
  rename A0002600 VERSION_R26_2014 
  rename R0000100 CASEID_1979 
  rename R0000149 HHID_1979 
  rename R0173600 SAMPLE_ID_1979 
  rename R0214700 SAMPLE_RACE_78SCRN 
  rename R0214800 SAMPLE_SEX_1979 
*/
  /* *end* */  
/* To convert variable names to lower case use the TOLOWER command 
 *      (type findit tolower and follow the links to install).
 * TOLOWER VARLIST will change listed variables to lower case; 
 *  TOLOWER without a specified variable list will convert all variables in the dataset to lower case
 */
/* tolower */
