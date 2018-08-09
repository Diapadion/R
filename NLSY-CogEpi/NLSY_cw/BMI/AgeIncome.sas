options nocenter validvarname=any;

*---Read in space-delimited ascii file;

data new_data;


infile 'AgeIncome.dat' lrecl=68 missover DSD DLM=' ' print;
input
  A0002600
  R0000100
  R0173600
  R0214700
  R0214800
  R1800600
  R1890400
  R1891010
  R5080700
  R5081700
  T0987800
  T0989000
  T5022600
  T5023600
;
array nvarlist _numeric_;


*---Recode missing values to SAS custom system missing. See SAS
      documentation for use of MISSING option in procedures, e.g. PROC FREQ;

do over nvarlist;
  if nvarlist = -1 then nvarlist = .R;  /* Refused */
  if nvarlist = -2 then nvarlist = .D;  /* Dont know */
  if nvarlist = -3 then nvarlist = .I;  /* Invalid missing */
  if nvarlist = -4 then nvarlist = .V;  /* Valid missing */
  if nvarlist = -5 then nvarlist = .N;  /* Non-interview */
end;

  label A0002600 = "VERSION_R26_1 2014";
  label R0000100 = "ID# (1-12686) 79";
  label R0173600 = "SAMPLE ID  79 INT";
  label R0214700 = "RACL/ETHNIC COHORT /SCRNR 79";
  label R0214800 = "SEX OF R 79";
  label R1800600 = "TOT NET FAMILY INC P-C YR FROM HHI V-A 85";
  label R1890400 = "TOT NET FAMILY INC P-C YR 85";
  label R1891010 = "AGE OF R @ INT DATE 85";
  label R5080700 = "TOTAL NET FAMILY INCOME 94";
  label R5081700 = "AGE AT INTERVIEW DATE 94";
  label T0987800 = "TOTAL NET FAMILY INCOME 2006";
  label T0989000 = "AGE AT INTERVIEW DATE 2006";
  label T5022600 = "TOTAL NET FAMILY INCOME 2014";
  label T5023600 = "AGE AT INTERVIEW 2014";

/*---------------------------------------------------------------------*
 *  Crosswalk for Reference number & Question name                     *
 *---------------------------------------------------------------------*
 * Uncomment and edit this RENAME statement to rename variables
 * for ease of use.  You may need to use  name literal strings
 * e.g.  'variable-name'n   to create valid SAS variable names, or 
 * alter variables similarly named across years.
 * This command does not guarantee uniqueness

 * See SAS documentation for use of name literals and use of the
 * VALIDVARNAME=ANY option.     
 *---------------------------------------------------------------------*/
  /* *start* */

* RENAME
  A0002600 = 'VERSION_R26_2014'n
  R0000100 = 'CASEID_1979'n
  R0173600 = 'SAMPLE_ID_1979'n
  R0214700 = 'SAMPLE_RACE_78SCRN'n
  R0214800 = 'SAMPLE_SEX_1979'n
  R1800600 = 'TNFI_HHI_TRUNC_1985'n
  R1890400 = 'TNFI_TRUNC_1985'n
  R1891010 = 'AGEATINT_1985'n
  R5080700 = 'TNFI_TRUNC_1994'n
  R5081700 = 'AGEATINT_1994'n
  T0987800 = 'TNFI_TRUNC_2006'n
  T0989000 = 'AGEATINT_2006'n
  T5022600 = 'TNFI_TRUNC_2014'n
  T5023600 = 'AGEATINT_2014'n
;
  /* *finish* */

run;

proc means data=new_data n mean min max;
run;


/*---------------------------------------------------------------------*
 *  FORMATTED TABULATIONS                                              *
 *---------------------------------------------------------------------*
 * You can uncomment and edit the PROC FORMAT and PROC FREQ statements 
 * provided below to obtain formatted tabulations. The tabulations 
 * should reflect codebook values.
 * 
 * Please edit the formats below reflect any renaming of the variables
 * you may have done in the first data step. 
 *---------------------------------------------------------------------*/

/*
proc format; 
value vx0f
  1-999='1 TO 999'
  1000-1999='1000 TO 1999'
  2000-2999='2000 TO 2999'
  3000-3999='3000 TO 3999'
  4000-4999='4000 TO 4999'
  5000-5999='5000 TO 5999'
  6000-6999='6000 TO 6999'
  7000-7999='7000 TO 7999'
  8000-8999='8000 TO 8999'
  9000-9999='9000 TO 9999'
  10000-10999='10000 TO 10999'
  11000-11999='11000 TO 11999'
  12000-12999='12000 TO 12999'
;
value vx2f
  1='CROSS MALE WHITE'
  2='CROSS MALE WH. POOR'
  3='CROSS MALE BLACK'
  4='CROSS MALE HISPANIC'
  5='CROSS FEMALE WHITE'
  6='CROSS FEMALE WH POOR'
  7='CROSS FEMALE BLACK'
  8='CROSS FEMALE HISPANIC'
  9='SUP MALE WH POOR'
  10='SUP MALE BLACK'
  11='SUP MALE HISPANIC'
  12='SUP FEM WH POOR'
  13='SUP FEMALE BLACK'
  14='SUP FEMALE HISPANIC'
  15='MIL MALE WHITE'
  16='MIL MALE BLACK'
  17='MIL MALE HISPANIC'
  18='MIL FEMALE WHITE'
  19='MIL FEMALE BLACK'
  20='MIL FEMALE HISPANIC'
;
value vx3f
  1='HISPANIC'
  2='BLACK'
  3='NON-BLACK, NON-HISPANIC'
;
value vx4f
  1='MALE'
  2='FEMALE'
;
value vx5f
  0='0'
  1-999='1 TO 999'
  1000-1999='1000 TO 1999'
  2000-2999='2000 TO 2999'
  3000-3999='3000 TO 3999'
  4000-4999='4000 TO 4999'
  5000-5999='5000 TO 5999'
  6000-6999='6000 TO 6999'
  7000-7999='7000 TO 7999'
  8000-8999='8000 TO 8999'
  9000-9999='9000 TO 9999'
  10000-14999='10000 TO 14999'
  15000-19999='15000 TO 19999'
  20000-24999='20000 TO 24999'
  25000-49999='25000 TO 49999'
  50000-9999999='50000 TO 9999999: 50000+'
;
value vx6f
  0='0'
  1-999='1 TO 999'
  1000-1999='1000 TO 1999'
  2000-2999='2000 TO 2999'
  3000-3999='3000 TO 3999'
  4000-4999='4000 TO 4999'
  5000-5999='5000 TO 5999'
  6000-6999='6000 TO 6999'
  7000-7999='7000 TO 7999'
  8000-8999='8000 TO 8999'
  9000-9999='9000 TO 9999'
  10000-14999='10000 TO 14999'
  15000-19999='15000 TO 19999'
  20000-24999='20000 TO 24999'
  25000-49999='25000 TO 49999'
  50000-9999999='50000 TO 9999999: 50000+'
;
value vx7f
  0-19='0 TO 19: < 20'
  20='20'
  21='21'
  22='22'
  23='23'
  24='24'
  25='25'
  26='26'
  27='27'
  28='28'
  29='29'
  30='30'
  31='31'
  32='32'
  33='33'
  34='34'
  35='35'
  36-99999='36 TO 99999: 36+'
;
value vx8f
  0='0'
  1-999='1 TO 999'
  1000-1999='1000 TO 1999'
  2000-2999='2000 TO 2999'
  3000-3999='3000 TO 3999'
  4000-4999='4000 TO 4999'
  5000-5999='5000 TO 5999'
  6000-6999='6000 TO 6999'
  7000-7999='7000 TO 7999'
  8000-8999='8000 TO 8999'
  9000-9999='9000 TO 9999'
  10000-14999='10000 TO 14999'
  15000-19999='15000 TO 19999'
  20000-24999='20000 TO 24999'
  25000-49999='25000 TO 49999'
  50000-99999999='50000 TO 99999999: 50000+'
;
value vx9f
  0-26='0 TO 26: < 26'
  27='27'
  28='28'
  29='29'
  30='30'
  31='31'
  32='32'
  33='33'
  34='34'
  35='35'
  36='36'
  37='37'
  38='38'
  39='39'
  40-99='40 TO 99: 40+'
;
value vx10f
  0='0'
  1-999='1 TO 999'
  1000-1999='1000 TO 1999'
  2000-2999='2000 TO 2999'
  3000-3999='3000 TO 3999'
  4000-4999='4000 TO 4999'
  5000-5999='5000 TO 5999'
  6000-6999='6000 TO 6999'
  7000-7999='7000 TO 7999'
  8000-8999='8000 TO 8999'
  9000-9999='9000 TO 9999'
  10000-14999='10000 TO 14999'
  15000-19999='15000 TO 19999'
  20000-24999='20000 TO 24999'
  25000-49999='25000 TO 49999'
  50000-99999999='50000 TO 99999999: 50000+'
;
value vx11f
  40='40'
  41='41'
  42='42'
  43='43'
  44='44'
  45='45'
  46='46'
  47='47'
  48='48'
  49='49'
  50='50'
  51='51'
  52='52'
;
value vx12f
  0='0'
  1-999='1 TO 999'
  1000-1999='1000 TO 1999'
  2000-2999='2000 TO 2999'
  3000-3999='3000 TO 3999'
  4000-4999='4000 TO 4999'
  5000-5999='5000 TO 5999'
  6000-6999='6000 TO 6999'
  7000-7999='7000 TO 7999'
  8000-8999='8000 TO 8999'
  9000-9999='9000 TO 9999'
  10000-14999='10000 TO 14999'
  15000-19999='15000 TO 19999'
  20000-24999='20000 TO 24999'
  25000-49999='25000 TO 49999'
  50000-99999999='50000 TO 99999999: 50000+'
;
value vx13f
  40='40'
  41='41'
  42='42'
  43='43'
  44='44'
  45='45'
  46='46'
  47='47'
  48='48'
  49='49'
  50='50'
  51='51'
  52='52'
  53='53'
  54='54'
  55='55'
  56='56'
  57='57'
  58='58'
;
*/

/* 
 *--- Tabulations using reference number variables;
proc freq data=new_data;
tables _ALL_ /MISSING;
  format A0002600 vx0f.;
  format R0173600 vx2f.;
  format R0214700 vx3f.;
  format R0214800 vx4f.;
  format R1800600 vx5f.;
  format R1890400 vx6f.;
  format R1891010 vx7f.;
  format R5080700 vx8f.;
  format R5081700 vx9f.;
  format T0987800 vx10f.;
  format T0989000 vx11f.;
  format T5022600 vx12f.;
  format T5023600 vx13f.;
run;
*/

/*
*--- Tabulations using default named variables;
proc freq data=new_data;
tables _ALL_ /MISSING;
  format 'VERSION_R26_2014'n vx0f.;
  format 'SAMPLE_ID_1979'n vx2f.;
  format 'SAMPLE_RACE_78SCRN'n vx3f.;
  format 'SAMPLE_SEX_1979'n vx4f.;
  format 'TNFI_HHI_TRUNC_1985'n vx5f.;
  format 'TNFI_TRUNC_1985'n vx6f.;
  format 'AGEATINT_1985'n vx7f.;
  format 'TNFI_TRUNC_1994'n vx8f.;
  format 'AGEATINT_1994'n vx9f.;
  format 'TNFI_TRUNC_2006'n vx10f.;
  format 'AGEATINT_2006'n vx11f.;
  format 'TNFI_TRUNC_2014'n vx12f.;
  format 'AGEATINT_2014'n vx13f.;
run;
*/