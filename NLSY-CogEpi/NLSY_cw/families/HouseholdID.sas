options nocenter validvarname=any;

*---Read in space-delimited ascii file;

data new_data;


infile 'HouseholdID.dat' lrecl=27 missover DSD DLM=' ' print;
input
  A0002600
  R0000100
  R0000149
  R0173600
  R0214700
  R0214800
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
  label R0000149 = "HH ID # 79";
  label R0173600 = "SAMPLE ID  79 INT";
  label R0214700 = "RACL/ETHNIC COHORT /SCRNR 79";
  label R0214800 = "SEX OF R 79";

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
  R0000149 = 'HHID_1979'n
  R0173600 = 'SAMPLE_ID_1979'n
  R0214700 = 'SAMPLE_RACE_78SCRN'n
  R0214800 = 'SAMPLE_SEX_1979'n
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
value vx3f
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
value vx4f
  1='HISPANIC'
  2='BLACK'
  3='NON-BLACK, NON-HISPANIC'
;
value vx5f
  1='MALE'
  2='FEMALE'
;
*/

/* 
 *--- Tabulations using reference number variables;
proc freq data=new_data;
tables _ALL_ /MISSING;
  format A0002600 vx0f.;
  format R0173600 vx3f.;
  format R0214700 vx4f.;
  format R0214800 vx5f.;
run;
*/

/*
*--- Tabulations using default named variables;
proc freq data=new_data;
tables _ALL_ /MISSING;
  format 'VERSION_R26_2014'n vx0f.;
  format 'SAMPLE_ID_1979'n vx3f.;
  format 'SAMPLE_RACE_78SCRN'n vx4f.;
  format 'SAMPLE_SEX_1979'n vx5f.;
run;
*/