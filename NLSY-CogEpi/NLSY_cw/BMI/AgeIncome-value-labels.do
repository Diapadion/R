label define vlR0173600   1 "CROSS MALE WHITE"  2 "CROSS MALE WH. POOR"  3 "CROSS MALE BLACK"  4 "CROSS MALE HISPANIC"  5 "CROSS FEMALE WHITE"  6 "CROSS FEMALE WH POOR"  7 "CROSS FEMALE BLACK"  8 "CROSS FEMALE HISPANIC"  9 "SUP MALE WH POOR"  10 "SUP MALE BLACK"  11 "SUP MALE HISPANIC"  12 "SUP FEM WH POOR"  13 "SUP FEMALE BLACK"  14 "SUP FEMALE HISPANIC"  15 "MIL MALE WHITE"  16 "MIL MALE BLACK"  17 "MIL MALE HISPANIC"  18 "MIL FEMALE WHITE"  19 "MIL FEMALE BLACK"  20 "MIL FEMALE HISPANIC"
label values R0173600 vlR0173600
label define vlR0214700   1 "HISPANIC"  2 "BLACK"  3 "NON-BLACK, NON-HISPANIC"
label values R0214700 vlR0214700
label define vlR0214800   1 "MALE"  2 "FEMALE"
label values R0214800 vlR0214800
label define vlR1800600   0 "0"
label values R1800600 vlR1800600
label define vlR1890400   0 "0"
label values R1890400 vlR1890400
label define vlR1891010   20 "20"  21 "21"  22 "22"  23 "23"  24 "24"  25 "25"  26 "26"  27 "27"  28 "28"  29 "29"  30 "30"  31 "31"  32 "32"  33 "33"  34 "34"  35 "35"
label values R1891010 vlR1891010
label define vlR5080700   0 "0"
label values R5080700 vlR5080700
label define vlR5081700   27 "27"  28 "28"  29 "29"  30 "30"  31 "31"  32 "32"  33 "33"  34 "34"  35 "35"  36 "36"  37 "37"  38 "38"  39 "39"
label values R5081700 vlR5081700
label define vlT0987800   0 "0"
label values T0987800 vlT0987800
label define vlT0989000   40 "40"  41 "41"  42 "42"  43 "43"  44 "44"  45 "45"  46 "46"  47 "47"  48 "48"  49 "49"  50 "50"  51 "51"  52 "52"
label values T0989000 vlT0989000
label define vlT5022600   0 "0"
label values T5022600 vlT5022600
label define vlT5023600   40 "40"  41 "41"  42 "42"  43 "43"  44 "44"  45 "45"  46 "46"  47 "47"  48 "48"  49 "49"  50 "50"  51 "51"  52 "52"  53 "53"  54 "54"  55 "55"  56 "56"  57 "57"  58 "58"
label values T5023600 vlT5023600
/* Crosswalk for Reference number & Question name
 * Uncomment and edit this RENAME statement to rename variables for ease of use.
 * This command does not guarantee uniqueness
 */
  /* *start* */
/*
  rename A0002600 VERSION_R26_2014 
  rename R0000100 CASEID_1979 
  rename R0173600 SAMPLE_ID_1979 
  rename R0214700 SAMPLE_RACE_78SCRN 
  rename R0214800 SAMPLE_SEX_1979 
  rename R1800600 TNFI_HHI_TRUNC_1985 
  rename R1890400 TNFI_TRUNC_1985 
  rename R1891010 AGEATINT_1985 
  rename R5080700 TNFI_TRUNC_1994 
  rename R5081700 AGEATINT_1994 
  rename T0987800 TNFI_TRUNC_2006 
  rename T0989000 AGEATINT_2006 
  rename T5022600 TNFI_TRUNC_2014 
  rename T5023600 AGEATINT_2014 
*/
  /* *end* */  
/* To convert variable names to lower case use the TOLOWER command 
 *      (type findit tolower and follow the links to install).
 * TOLOWER VARLIST will change listed variables to lower case; 
 *  TOLOWER without a specified variable list will convert all variables in the dataset to lower case
 */
/* tolower */
