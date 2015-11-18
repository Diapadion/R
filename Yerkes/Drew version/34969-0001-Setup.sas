/*-------------------------------------------------------------------------
 |                                                                         
 |                    SAS SETUP FILE FOR ICPSR 34969
 |       SURVEY OF MIDLIFE DEVELOPMENT IN JAPAN (MIDJA): BIOMARKER
 |                           PROJECT, 2009-2010
 |
 |
 | SAS setup sections are provided for the ASCII version of this data
 | collection.  These sections are listed below:
 |
 | PROC FORMAT:  creates user-defined formats for the variables. Formats
 | replace original value codes with value code descriptions. Only
 | variables with user-defined formats are included in this section.
 |
 | DATA:  begins a SAS data step and names an output SAS data set.
 |
 | INFILE:  identifies the input file to be read with the input statement.
 | Users must replace the "data-filename" with a filename specifying the
 | directory on the user's computer system in which the downloaded and
 | unzipped data file is physically located (e.g.,
 | "c:\temp\34969-0001-data.txt").
 |
 | INPUT:  assigns the name, type, decimal specification (if any), and
 | specifies the beginning and ending column locations for each variable
 | in the data file.
 |
 | LABEL:  assigns descriptive labels to all variables. Variable labels
 | and variable names may be identical for some variables.
 |
 | MISSING VALUE RECODES:  sets user-defined numeric missing values to
 | missing as interpreted by the SAS system. Only variables with
 | user-defined missing values are included in this section.
 |
 | If any variables have more than one missing value, they are assigned
 | to the standard missing value of a single period (.) in the statement
 | below. To maintain the original meaning of missing codes, users may want
 | to take advantage of the SAS missing values (the letters A-Z or an
 | underscore preceded by a period).
 |
 | An example of a standard missing value recode:
 |
 |   IF (RELATION = 98 OR RELATION = 99) THEN RELATION = .; 
 |
 | The same example using special missing value recodes:
 |
 |    IF RELATION = 98 THEN RELATION = .A;
 |    IF RELATION = 99 THEN RELATION = .B;
 |
 | FORMAT:  associates the formats created by the PROC FORMAT step with
 | the variables named in the INPUT statement.
 |
 | NOTE:  Users should modify this setup file to suit their specific needs.
 | Sections for PROC FORMAT, FORMAT, and MISSING VALUE RECODES have been
 | commented out (i.e., '/*'). To include these sections in the final SAS
 | setup, users should remove the SAS comment indicators from the desired
 | section(s).
 |
 |------------------------------------------------------------------------*/

* SAS PROC FORMAT;

/*
PROC FORMAT;
  VALUE j1sq1fff  1='(1) MALE' 2='(2) FEMALE' ;
  VALUE j2q1a     1='(1) YES' 2='(2) NO' 3='(3) BORDERLINE' 7='(7) UNSURE'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q1ad    1='(1) YES' 2='(2) NO' 7='(7) DONT KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q1b     1='(1) YES' 2='(2) NO' 3='(3) BORDERLINE' 7='(7) UNSURE'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q1bd    1='(1) YES' 2='(2) NO' 7='(7) DONT KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q1c     1='(1) YES' 2='(2) NO' 3='(3) BORDERLINE' 7='(7) UNSURE'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q1cd    1='(1) YES' 2='(2) NO' 7='(7) DONT KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q1d     1='(1) YES' 2='(2) NO' 3='(3) BORDERLINE' 7='(7) UNSURE'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q1dd    1='(1) YES' 2='(2) NO' 7='(7) DONT KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q1e     1='(1) YES' 2='(2) NO' 3='(3) BORDERLINE' 7='(7) UNSURE'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q1ed    1='(1) YES' 2='(2) NO' 7='(7) DONT KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q1f     1='(1) YES' 2='(2) NO' 3='(3) BORDERLINE' 7='(7) UNSURE'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q1fd    1='(1) YES' 2='(2) NO' 7='(7) DONT KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q1g     1='(1) YES' 2='(2) NO' 3='(3) BORDERLINE' 7='(7) UNSURE'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q1gd    1='(1) YES' 2='(2) NO' 7='(7) DONT KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q1h     1='(1) YES' 2='(2) NO' 3='(3) BORDERLINE' 7='(7) UNSURE'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q1hd    1='(1) YES' 2='(2) NO' 7='(7) DONT KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q1i     1='(1) YES' 2='(2) NO' 3='(3) BORDERLINE' 7='(7) UNSURE'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q1id    1='(1) YES' 2='(2) NO' 7='(7) DONT KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q1j     1='(1) YES' 2='(2) NO' 3='(3) BORDERLINE' 7='(7) UNSURE'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q1jd    1='(1) YES' 2='(2) NO' 7='(7) DONT KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q1k     1='(1) YES' 2='(2) NO' 3='(3) BORDERLINE' 7='(7) UNSURE'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q1kd    1='(1) YES' 2='(2) NO' 7='(7) DONT KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q1l     1='(1) YES' 2='(2) NO' 3='(3) BORDERLINE' 7='(7) UNSURE'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q1ld    1='(1) YES' 2='(2) NO' 7='(7) DONT KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q1m     1='(1) YES' 2='(2) NO' 3='(3) BORDERLINE' 7='(7) UNSURE'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q1md    1='(1) YES' 2='(2) NO' 7='(7) DONT KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q1n     1='(1) YES' 2='(2) NO' 3='(3) BORDERLINE' 7='(7) UNSURE'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q1nd    1='(1) YES' 2='(2) NO' 7='(7) DONT KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q1o     1='(1) YES' 2='(2) NO' 3='(3) BORDERLINE' 7='(7) UNSURE'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q1od    1='(1) YES' 2='(2) NO' 7='(7) DONT KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q1p     1='(1) YES' 2='(2) NO' 3='(3) BORDERLINE' 7='(7) UNSURE'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q1pd    1='(1) YES' 2='(2) NO' 7='(7) DONT KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q1q     1='(1) YES' 2='(2) NO' 3='(3) BORDERLINE' 7='(7) UNSURE'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q1qd    1='(1) YES' 2='(2) NO' 7='(7) DONT KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q1r     1='(1) YES' 2='(2) NO' 3='(3) BORDERLINE' 7='(7) UNSURE'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q1rd    1='(1) YES' 2='(2) NO' 7='(7) DONT KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q1s     1='(1) YES' 2='(2) NO' 3='(3) BORDERLINE' 7='(7) UNSURE'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q1sd    1='(1) YES' 2='(2) NO' 7='(7) DONT KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q1t     1='(1) YES' 2='(2) NO' 3='(3) BORDERLINE' 7='(7) UNSURE'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q1td    1='(1) YES' 2='(2) NO' 7='(7) DONT KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q1u     1='(1) YES' 2='(2) NO' 3='(3) BORDERLINE' 7='(7) UNSURE'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q1ud    1='(1) YES' 2='(2) NO' 7='(7) DONT KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q1v     1='(1) YES' 2='(2) NO' 3='(3) BORDERLINE' 7='(7) UNSURE'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q1vd    1='(1) YES' 2='(2) NO' 7='(7) DONT KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q1w     1='(1) YES' 2='(2) NO' 3='(3) BORDERLINE' 7='(7) UNSURE'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q1wd    1='(1) YES' 2='(2) NO' 7='(7) DONT KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q1x     1='(1) YES' 2='(2) NO' 3='(3) BORDERLINE' 7='(7) UNSURE'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q1xd    1='(1) YES' 2='(2) NO' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q1y     1='(1) YES' 2='(2) NO' 3='(3) BORDERLINE' 7='(7) UNSURE'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q1yd    1='(1) YES' 2='(2) NO' 7='(7) DONT KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q1z     1='(1) YES' 2='(2) NO' 3='(3) BORDERLINE' 7='(7) UNSURE'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q1zd    1='(1) YES' 2='(2) NO' 7='(7) DONT KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q1aa    1='(1) YES' 2='(2) NO' 3='(3) BORDERLINE' 7='(7) UNSURE'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q1aad   1='(1) YES' 2='(2) NO' 7='(7) DONT KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q1bb    1='(1) YES' 2='(2) NO' 3='(3) BORDERLINE' 7='(7) UNSURE'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q1bbd   1='(1) YES' 2='(2) NO' 7='(7) DONT KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q1cc    1='(1) YES' 2='(2) NO' 3='(3) BORDERLINE' 7='(7) UNSURE'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q1ccd   1='(1) YES' 2='(2) NO' 7='(7) DONT KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q1ee    1='(1) YES' 2='(2) NO' 3='(3) BORDERLINE' 7='(7) UNSURE'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q1eed   1='(1) YES' 2='(2) NO' 7='(7) DONT KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q1ff    1='(1) YES' 2='(2) NO' 3='(3) BORDERLINE' 7='(7) UNSURE'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q1ffd   1='(1) YES' 2='(2) NO' 7='(7) DONT KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2qsymn   0='(0) NONE' ;
  VALUE j2qsymx   1='(1) YES' 2='(2) NO' ;
  VALUE j2qsymnf  0='(0) NONE' ;
  VALUE j2qsymxf  1='(1) YES' 2='(2) NO' ;
  VALUE j2q2ffff  1='(1) YES' 2='(2) NO' 3='(3) DONT WANT TO ANSWER'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q2a     1='(1) TREATMENT' 2='(2) REMISSION' 3='(3) CURED'
                  7='(7) DONT KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q2a2ff  1='(1) YES' 2='(2) NO' 7='(7) DONT KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q2b1ff  1='(1) YES' 2='(2) NO' 7='(7) UNSURE' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q2b2ff  1='(1) YES' 2='(2) NO' 7='(7) UNSURE' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q2b3ff  1='(1) YES' 2='(2) NO' 7='(7) UNSURE' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q2b4ff  1='(1) YES' 2='(2) NO' 7='(7) UNSURE' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q2b5ff  1='(1) YES' 2='(2) NO' 7='(7) UNSURE' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q2b6ff  1='(1) YES' 2='(2) NO' 7='(7) UNSURE' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q2b7ff  1='(1) YES' 2='(2) NO' 7='(7) UNSURE' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q2b8ff  1='(1) YES' 2='(2) NO' 7='(7) UNSURE' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q2b9ff  1='(1) YES' 2='(2) NO' 7='(7) UNSURE' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q2b10f  1='(1) YES' 2='(2) NO' 7='(7) UNSURE' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q3ffff  1='(1) YES' 2='(2) NO' 7='(7) DONT KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q3ah    1='(1) YES' 2='(2) NO' 7='(7) DONT KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q3aem   1='(1) HEISEI' 2='(2) SHOWA' 7='(7) DONT KNOW'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q3aemy  97='(97) DONT KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q3acey  9997='(9997) DONT KNOW' 9998='(9998) MISSING'
                  9999='(9999) INAPP' ;
  VALUE j2q3bh    1='(1) YES' 2='(2) NO' 7='(7) DONT KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q3bem   1='(1) HEISEI' 2='(2) SHOWA' 7='(7) DONT KNOW'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q3bemy  97='(97) DONT KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q3bcey  9997='(9997) DONT KNOW' 9998='(9998) MISSING'
                  9999='(9999) INAPP' ;
  VALUE j2q4ffff  1='(1) YES' 2='(2) NO' 7='(7) DONT KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q4ah    1='(1) YES' 2='(2) NO' 7='(7) DONT KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q4aem   1='(1) HEISEI' 2='(2) SHOWA' 7='(7) DONT KNOW'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q4aemy  97='(97) DONT KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q4acey  9997='(9997) DONT KNOW' 9998='(9998) MISSING'
                  9999='(9999) INAPP' ;
  VALUE j2q4bh    1='(1) YES' 2='(2) NO' 7='(7) DONT KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q4bem   1='(1) HEISEI' 2='(2) SHOWA' 7='(7) DK' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q4bemy  97='(97) DK' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q4bcey  9997='(9997) DK' 9998='(9998) MISSING' 9999='(9999) INAPP' ;
  VALUE j2q5ffff  1='(1) YES' 2='(2) NO' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q5ah    1='(1) YES' 2='(2) NO' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q5aem   1='(1) HEISEI' 2='(2) SHOWA' 7='(7) DON''T KNOW'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q5aemy  97='(97) DK' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q5acey  9997='(9997) DK' 9998='(9998) MISSING' 9999='(9999) INAPP' ;
  VALUE j2q5bh    1='(1) YES' 2='(2) NO' 7='(7) DK' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q5bem   1='(1) HEISEI' 2='(2) SHOWA' 7='(7) DK' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q5bemy  97='(97) DK' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q5bcey  9997='(9997) DK' 9998='(9998) MISSING' 9999='(9999) INAPP' ;
  VALUE j2q6ffff  1='(1) YES' 2='(2) NO' 7='(7) DK' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q6ah    1='(1) YES' 2='(2) NO' 7='(7) DK' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q6aem   1='(1) HEISEI' 2='(2) SHOWA' 7='(7) DK' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q6aemy  97='(97) DK' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q6acey  9997='(9997) DK' 9998='(9998) MISSING' 9999='(9999) INAPP' ;
  VALUE j2q6bh    1='(1) YES' 2='(2) NO' 7='(7) DK' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q6bem   1='(1) HEISEI' 2='(2) SHOWA' 7='(7) DK' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q6bemy  97='(97) DK' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q6bcey  9997='(9997) DK' 9998='(9998) MISSING' 9999='(9999) INAPP' ;
  VALUE j2q7ampm  1='(1) AM' 2='(2) PM' 7='(7) DK' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q7h     97='(97) DK' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q7m     97='(97) DK' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q8ffff  997='(997) DK' 998='(998) MISSING' 999='(999) INAPP' ;
  VALUE j2q9ampm  1='(1) AM' 2='(2) PM' 7='(7) DK' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q9h     97='(97) DK' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q9m     97='(97) DK' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q10h    97='(97) DK' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q10m    97='(97) DK' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q11a    1='(1) NOT DURING THE PAST MONTH'
                  2='(2) LESS THAN ONCE A WEEK' 3='(3) ONCE OR TWICE A WEEK'
                  4='(4) THREE OR MORE TIMES A WEEK' 7='(7) DK'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q11b    1='(1) NOT DURING THE PAST MONTH'
                  2='(2) LESS THAN ONCE A WEEK' 3='(3) ONCE OR TWICE A WEEK'
                  4='(4) THREE OR MORE TIMES A WEEK' 7='(7) DK'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q11c    1='(1) NOT DURING THE PAST MONTH'
                  2='(2) LESS THAN ONCE A WEEK' 3='(3) ONCE OR TWICE A WEEK'
                  4='(4) THREE OR MORE TIMES A WEEK' 7='(7) DK'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q11d    1='(1) NOT DURING THE PAST MONTH'
                  2='(2) LESS THAN ONCE A WEEK' 3='(3) ONCE OR TWICE A WEEK'
                  4='(4) THREE OR MORE TIMES A WEEK' 7='(7) DK'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q11e    1='(1) NOT DURING THE PAST MONTH'
                  2='(2) LESS THAN ONCE A WEEK' 3='(3) ONCE OR TWICE A WEEK'
                  4='(4) THREE OR MORE TIMES A WEEK' 7='(7) DK'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q11f    1='(1) NOT DURING THE PAST MONTH'
                  2='(2) LESS THAN ONCE A WEEK' 3='(3) ONCE OR TWICE A WEEK'
                  4='(4) THREE OR MORE TIMES A WEEK' 7='(7) DK'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q11g    1='(1) NOT DURING THE PAST MONTH'
                  2='(2) LESS THAN ONCE A WEEK' 3='(3) ONCE OR TWICE A WEEK'
                  4='(4) THREE OR MORE TIMES A WEEK' 7='(7) DK'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q11h    1='(1) NOT DURING THE PAST MONTH'
                  2='(2) LESS THAN ONCE A WEEK' 3='(3) ONCE OR TWICE A WEEK'
                  4='(4) THREE OR MORE TIMES A WEEK' 7='(7) DK'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q11i    1='(1) NOT DURING THE PAST MONTH'
                  2='(2) LESS THAN ONCE A WEEK' 3='(3) ONCE OR TWICE A WEEK'
                  4='(4) THREE OR MORE TIMES A WEEK' 7='(7) DK'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q11j    1='(1) NOT DURING THE PAST MONTH'
                  2='(2) LESS THAN ONCE A WEEK' 3='(3) ONCE OR TWICE A WEEK'
                  4='(4) THREE OR MORE TIMES A WEEK' 7='(7) DK'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q12fff  1='(1) VERY GOOD' 2='(2) FAIRLY GOOD' 3='(3) FAILY BAD'
                  4='(4) VERY BAD' 7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q13fff  1='(1) NO PROBLEM AT ALL'
                  2='(2) ONLY A VERY SLIGHT PROBLEM'
                  3='(3) SOMEWHAT OF A PROBLEM' 4='(4) A VERY BIG PROBLEM'
                  7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q14fff  1='(1) NOT DURING THE PAST MONTH'
                  2='(2) LESS THAN ONCE A WEEK' 3='(3) ONCE OR TWICE A WEEK'
                  4='(4) THREE OR MORE TIMES A WEEK' 7='(7) DK'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q15fff  1='(1) NOT DURING THE PAST MONTH'
                  2='(2) LESS THAN ONCE A WEEK' 3='(3) ONCE OR TWICE A WEEK'
                  4='(4) THREE OR MORE TIMES A WEEK' 7='(7) DK'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q16fff  1='(1) NOT DURING THE PAST MONTH'
                  2='(2) LESS THAN ONCE A WEEK' 3='(3) ONCE OR TWICE A WEEK'
                  4='(4) THREE OR MORE TIMES A WEEK' 7='(7) DK'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2qsq_sf  0='(0) VERY GOOD' 1='(1) FAIRLY GOOD' 2='(2) FAIRLY BAD'
                  3='(3) VERY BAD'
                  8='(8) NOT CALCULATED - Due to missing data' ;
  VALUE j2qsq_0f  0='(0) SUM OF SUBSCALES = 0' 1='(1) SUM OF SUBSCALES = 1-2'
                  2='(2) SUM OF SUBSCALES = 3-4'
                  3='(3) SUM OF SUBSCALES = 5-6'
                  8='(8) NOT CALCULATED - Due to missing data' ;
  VALUE j2qsq_1f  0='(0) > 7 HOURS' 1='(1) 6-7 HOURS' 2='(2) 5-6 HOURS'
                  3='(3) < 5 HOURS'
                  8='(8) NOT CALCULATED - Due to missing data' ;
  VALUE j2qsq_2f  0='(0) > 85%' 1='(1) 75-84%' 2='(2) 65-74%' 3='(3) < 65%'
                  4='(4) > 100%' 8='(8) NOT CALCULATED - Due to missing data' ;
  VALUE j2qsq_3f  0='(0) 0' 1='(1) 1-9' 2='(2) 10-18' 3='(3) 19-27'
                  8='(8) NOT CALCULATED - Due to missing data' ;
  VALUE j2qsq_4f  0='(0) NOT DURING THE PAST MONTH'
                  1='(1) LESS THAN ONCE A WEEK' 2='(2) ONCE OR TWICE A WEEK'
                  3='(3) THREE OR MORE TIMES A WEEK'
                  8='(8) NOT CALCULATED - Due to missing data' ;
  VALUE j2qsq_5f  0='(0) 0' 1='(1) 1-2' 2='(2) 3-4' 3='(3) 5-6'
                  8='(8) NOT CALCULATED - Due to missing data' ;
  VALUE j2qsq_gs  98='(98) NOT CALCULATED - Due to missing data' ;
  VALUE j2q17fff  1='(1) YES' 2='(2) NO' 7='(7) DK' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q18fff  0='(00) DID NOT INTERFERE' 10='(10) COMPLETELY INTERFERED'
                  97='(97) DK' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q19fff  0='(00) DID NOT INTERFERE' 10='(10) COMPLETELY INTERFERED'
                  97='(97) DK' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q20fff  0='(00) DID NOT INTERFERE' 10='(10) COMPLETELY INTERFERED'
                  97='(97) DK' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q21fff  0='(00) DID NOT INTERFERE' 10='(10) COMPLETELY INTERFERED'
                  97='(97) DK' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q22fff  0='(00) DID NOT INTERFERE' 10='(10) COMPLETELY INTERFERED'
                  97='(97) DK' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q23a    1='(1) YES' 2='(2) NO' 7='(7) DK' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q23b    1='(1) YES' 2='(2) NO' 7='(7) DK' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q23c    1='(1) YES' 2='(2) NO' 7='(7) DK' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q23d    1='(1) YES' 2='(2) NO' 7='(7) DK' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q23e    1='(1) YES' 2='(2) NO' 7='(7) DK' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q23f    1='(1) YES' 2='(2) NO' 7='(7) DK' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q23g    1='(1) YES' 2='(2) NO' 7='(7) DK' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q23h    1='(1) YES' 2='(2) NO' 7='(7) DK' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q23i    1='(1) YES' 2='(2) NO' 7='(7) DK' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q24fff  1='(1) YES' 2='(2) NO' 7='(7) DK' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q26fff  1='(1) YES' 2='(2) NO' 7='(7) DK' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q27a    1='(1) NEVER' 2='(2) LESS THAN 1 X PER WEEK'
                  3='(3) 1-4 X PER WEEK' 4='(4) ALMOST DAILY'
                  5='(5) 1-3 X PER DAY' 6='(6) 4-7 X PER DAY'
                  7='(7) 8 OR MORE X PER DAY' 97='(97) DK' 98='(98) MISSING'
                  99='(99) INAPP' ;
  VALUE j2q27b    1='(1) NEVER' 2='(2) LESS THAN 1 X PER WEEK'
                  3='(3) 1-4 X PER WEEK' 4='(4) ALMOST DAILY'
                  5='(5) 1-3 X PER DAY' 6='(6) 4-7 X PER DAY'
                  7='(7) 8 OR MORE X PER DAY' 97='(97) DK' 98='(98) MISSING'
                  99='(99) INAPP' ;
  VALUE j2q27c    1='(1) NEVER' 2='(2) LESS THAN 1 X PER WEEK'
                  3='(3) 1-4 X PER WEEK' 4='(4) ALMOST DAILY'
                  5='(5) 1-3 X PER DAY' 6='(6) 4-7 X PER DAY'
                  7='(7) 8 OR MORE X PER DAY' 97='(97) DK' 98='(98) MISSING'
                  99='(99) INAPP' ;
  VALUE j2q28a    1='(1) NEVER' 2='(2) LESS THAN 1 X PER WEEK'
                  3='(3) 1-4 X PER WEEK' 4='(4) ALMOST DAILY'
                  5='(5) 1-3 X PER DAY' 6='(6) 4-7 X PER DAY'
                  7='(7) 8 OR MORE X PER DAY' 97='(97) DK' 98='(98) MISSING'
                  99='(99) INAPP' ;
  VALUE j2q28b    1='(1) NEVER' 2='(2) LESS THAN 1 X PER WEEK'
                  3='(3) 1-4 X PER WEEK' 4='(4) ALMOST DAILY'
                  5='(5) 1-3 X PER DAY' 6='(6) 4-7 X PER DAY'
                  7='(7) 8 OR MORE X PER DAY' 97='(97) DK' 98='(98) MISSING'
                  99='(99) INAPP' ;
  VALUE j2q28c    1='(1) NEVER' 2='(2) LESS THAN 1 X PER WEEK'
                  3='(3) 1-4 X PER WEEK' 4='(4) ALMOST DAILY'
                  5='(5) 1-3 X PER DAY' 6='(6) 4-7 X PER DAY'
                  7='(7) 8 OR MORE X PER DAY' 97='(97) DONT KNOW'
                  98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q28d    1='(1) NEVER' 2='(2) LESS THAN 1 X PER WEEK'
                  3='(3) 1-4 X PER WEEK' 4='(4) ALMOST DAILY'
                  5='(5) 1-3 X PER DAY' 6='(6) 4-7 X PER DAY'
                  7='(7) 8 OR MORE X PER DAY' 97='(97) DONT KNOW'
                  98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q29fff  1='(1) NONE' 2='(2) LESS THAN 1 GLASS/DAY'
                  3='(3) 1-3 GLASSES/DAY' 4='(4) 4-7 GLASSES/DAY'
                  5='(5) 8 OR MORE GLASSES/DAY' 7='(7) DONT KNOW'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q30fff  1='(1) NONE' 2='(2) LESS THAN 1 GLASS/DAY'
                  3='(3) 1-3 GLASSES/DAY' 4='(4) 4-7 GLASSES/DAY'
                  5='(5) 8 OR MORE GLASSES/DAY' 7='(7) DONT KNOW'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q31fff  1='(1) NONE' 2='(2) LESS THAN 1 SERVING/DAY'
                  3='(3) 1-4 SERVINGS/DAY' 4='(4) 5-9 SERVINGS/DAY'
                  5='(5) 10 OR MORE SERVINGS/DAY' 7='(7) DONT KNOW'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q32fff  1='(1) NONE' 2='(2) LESS THAN 1 SERVING/DAY'
                  3='(3) 1-4 SERVINGS/DAY' 4='(4) 5-9 SERVINGS/DAY'
                  5='(5) 10 OR MORE SERVINGS/DAY' 7='(7) DONT KNOW'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q33fff  1='(1) NONE' 2='(2) LESS THAN 1 SERVING/DAY'
                  3='(3) 1-2 SERVINGS/DAY' 4='(4) 3-4 SERVINGS/DAY'
                  5='(5) 5 OR MORE SERVINGS/DAY' 7='(7) DONT KNOW'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q34a    1='(1) NEVER' 2='(2) LESS THAN 1X PER WEEK'
                  3='(3) 1-2 X PER WEEK' 4='(4) 3-4 X PER WEEK'
                  5='(5) 5 OR MORE X PER WEEK' 7='(7) DONT KNOW'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q34b    1='(1) NEVER' 2='(2) LESS THAN 1X PER WEEK'
                  3='(3) 1-2 X PER WEEK' 4='(4) 3-4 X PER WEEK'
                  5='(5) 5 OR MORE X PER WEEK' 7='(7) DONT KNOW'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q34c    1='(1) NEVER' 2='(2) LESS THAN 1X PER WEEK'
                  3='(3) 1-2 X PER WEEK' 4='(4) 3-4 X PER WEEK'
                  5='(5) 5 OR MORE X PER WEEK' 7='(7) DK' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q34d    1='(1) NEVER' 2='(2) LESS THAN 1X PER WEEK'
                  3='(3) 1-2 X PER WEEK' 4='(4) 3-4 X PER WEEK'
                  5='(5) 5 OR MORE X PER WEEK' 7='(7) DK' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q35fff  1='(1) NEVER' 2='(2) LESS THAN 1X PER WEEK'
                  3='(3) 1-2 X PER WEEK' 4='(4) 4-6 X PER WEEK'
                  5='(5) 7 OR MORE X PER WEEK' 7='(7) DK' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q36fff  1='(1) YES' 2='(2) NO' 7='(7) DK' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q37m    97='(97) DK' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q37y    9997='(9997) DK' 9998='(9998) MISSING' 9999='(9999) INAPP' ;
  VALUE j2q38fff  1='(1) MARRIED' 2='(2) SEPARATED' 3='(3) DIVORCED'
                  4='(4) WIDOWED' 5='(5) NEVER MARRIED'
                  6='(6) MARRIAGE-LIKE RELATIONSHIP' 7='(7) DK'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2qmarr   1='(1) 1=MARRIED' 2='(2) 2=SEPARATED' 3='(3) 3=DIVORCED'
                  4='(4) 4=WIDOWED' 5='(5) 5=NEVER MARRIED'
                  6='(6) 6=LIVING W/ SOMEONE' 7='(7) 7=DON''T KNOW'
                  8='(8) 8=MISSING' 9='(9) 9=INAPP' ;
  VALUE j2q39fff  1='(1) YES' 2='(2) NO' 7='(7) DONT KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q39ag   1='(1) MALE' 2='(2) FEMALE' 7='(7) DONT KNOW'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q39am   97='(97) DON''T KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q39ay   9997='(9997) DON''T KNOW' 9998='(9998) MISSING'
                  9999='(9999) INAPP' ;
  VALUE j2q39bg   1='(1) MALE' 2='(2) FEMALE' 7='(7) DON''T KNOW'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q39bm   97='(97) DON''T KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q39by   9997='(9997) DON''T KNOW' 9998='(9998) MISSING'
                  9999='(9999) INAPP' ;
  VALUE j2q39cg   1='(1) MALE' 2='(2) FEMALE' 7='(7) DON''T KNOW'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q39cm   97='(97) DON''T KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q39cy   9997='(9997) DON''T KNOW' 9998='(9998) MISSING'
                  9999='(9999) INAPP' ;
  VALUE j2q40a    1='(1) CHECKED' 2='(2) UNCHECKED' 7='(7) DON''T KNOW' ;
  VALUE j2q40a1f  97='(97) DON''T KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q40a3f  1='(1) VERY NEGATIVELY' 2='(2) NEGATIVELY'
                  3='(3) NOT AT ALL' 4='(4) POSITIVELY'
                  5='(5) VERY POSITIVELY' 7='(7) DON''T KNOW' 8='(8) REFUSED'
                  9='(9) INAPP' ;
  VALUE j2q40a4f  1='(1) VERY NEGATIVELY' 2='(2) NEGATIVELY'
                  3='(3) NOT AT ALL' 4='(4) POSITIVELY'
                  5='(5) VERY POSITIVELY' 7='(7) DON''T KNOW' 8='(8) REFUSED'
                  9='(9) INAPP' ;
  VALUE j2q40b    1='(1) CHECKED' 2='(2) UNCHECKED' 7='(7) DON''T KNOW' ;
  VALUE j2q40b1f  97='(97) DON''T KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q40b3f  1='(1) VERY NEGATIVELY' 2='(2) NEGATIVELY'
                  3='(3) NOT AT ALL' 4='(4) POSITIVELY'
                  5='(5) VERY POSITIVELY' 7='(7) DON''T KNOW' 8='(8) REFUSED'
                  9='(9) INAPP' ;
  VALUE j2q40b4f  1='(1) VERY NEGATIVELY' 2='(2) NEGATIVELY'
                  3='(3) NOT AT ALL' 4='(4) POSITIVELY'
                  5='(5) VERY POSITIVELY' 7='(7) DON''T KNOW' 8='(8) REFUSED'
                  9='(9) INAPP' ;
  VALUE j2q40c    1='(1) CHECKED' 2='(2) UNCHECKED' 7='(7) DON''T KNOW' ;
  VALUE j2q40c1f  97='(97) DON''T KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q40c3f  1='(1) VERY NEGATIVELY' 2='(2) NEGATIVELY'
                  3='(3) NOT AT ALL' 4='(4) POSITIVELY'
                  5='(5) VERY POSITIVELY' 7='(7) DON''T KNOW' 8='(8) REFUSED'
                  9='(9) INAPP' ;
  VALUE j2q40c4f  1='(1) VERY NEGATIVELY' 2='(2) NEGATIVELY'
                  3='(3) NOT AT ALL' 4='(4) POSITIVELY'
                  5='(5) VERY POSITIVELY' 7='(7) DON''T KNOW' 8='(8) REFUSED'
                  9='(9) INAPP' ;
  VALUE j2q40d    1='(1) CHECKED' 2='(2) UNCHECKED' 7='(7) DON''T KNOW' ;
  VALUE j2q40d1f  97='(97) DON''T KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q40d3f  1='(1) VERY NEGATIVELY' 2='(2) NEGATIVELY'
                  3='(3) NOT AT ALL' 4='(4) POSITIVELY'
                  5='(5) VERY POSITIVELY' 7='(7) DON''T KNOW' 8='(8) REFUSED'
                  9='(9) INAPP' ;
  VALUE j2q40d4f  1='(1) VERY NEGATIVELY' 2='(2) NEGATIVELY'
                  3='(3) NOT AT ALL' 4='(4) POSITIVELY'
                  5='(5) VERY POSITIVELY' 7='(7) DON''T KNOW' 8='(8) REFUSED'
                  9='(9) INAPP' ;
  VALUE j2q40e    1='(1) CHECKED' 2='(2) UNCHECKED' 7='(7) DON''T KNOW' ;
  VALUE j2q40e1f  97='(97) DON''T KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q40e3f  1='(1) VERY NEGATIVELY' 2='(2) NEGATIVELY'
                  3='(3) NOT AT ALL' 4='(4) POSITIVELY'
                  5='(5) VERY POSITIVELY' 7='(7) DON''T KNOW' 8='(8) REFUSED'
                  9='(9) INAPP' ;
  VALUE j2q40e4f  1='(1) VERY NEGATIVELY' 2='(2) NEGATIVELY'
                  3='(3) NOT AT ALL' 4='(4) POSITIVELY'
                  5='(5) VERY POSITIVELY' 7='(7) DON''T KNOW' 8='(8) REFUSED'
                  9='(9) INAPP' ;
  VALUE j2q40f    1='(1) CHECKED' 2='(2) UNCHECKED' 7='(7) DON''T KNOW' ;
  VALUE j2q40f1f  97='(97) DON''T KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q40f3f  1='(1) VERY NEGATIVELY' 2='(2) NEGATIVELY'
                  3='(3) NOT AT ALL' 4='(4) POSITIVELY'
                  5='(5) VERY POSITIVELY' 7='(7) DON''T KNOW' 8='(8) REFUSED'
                  9='(9) INAPP' ;
  VALUE j2q40f4f  1='(1) VERY NEGATIVELY' 2='(2) NEGATIVELY'
                  3='(3) NOT AT ALL' 4='(4) POSITIVELY'
                  5='(5) VERY POSITIVELY' 7='(7) DON''T KNOW' 8='(8) REFUSED'
                  9='(9) INAPP' ;
  VALUE j2q40g    1='(1) CHECKED' 2='(2) UNCHECKED' 7='(7) DON''T KNOW' ;
  VALUE j2q40g1f  97='(97) DON''T KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q40g3f  1='(1) VERY NEGATIVELY' 2='(2) NEGATIVELY'
                  3='(3) NOT AT ALL' 4='(4) POSITIVELY'
                  5='(5) VERY POSITIVELY' 7='(7) DON''T KNOW' 8='(8) REFUSED'
                  9='(9) INAPP' ;
  VALUE j2q40g4f  1='(1) VERY NEGATIVELY' 2='(2) NEGATIVELY'
                  3='(3) NOT AT ALL' 4='(4) POSITIVELY'
                  5='(5) VERY POSITIVELY' 7='(7) DON''T KNOW' 8='(8) REFUSED'
                  9='(9) INAPP' ;
  VALUE j2q41h    1='(1) CHECKED' 2='(2) UNCHECKED' 7='(7) DON''T KNOW' ;
  VALUE j2q41h1f  97='(97) DON''T KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q41h3f  1='(1) VERY NEGATIVELY' 2='(2) NEGATIVELY'
                  3='(3) NOT AT ALL' 4='(4) POSITIVELY'
                  5='(5) VERY POSITIVELY' 7='(7) DON''T KNOW' 8='(8) REFUSED'
                  9='(9) INAPP' ;
  VALUE j2q41h4f  1='(1) VERY NEGATIVELY' 2='(2) NEGATIVELY'
                  3='(3) NOT AT ALL' 4='(4) POSITIVELY'
                  5='(5) VERY POSITIVELY' 7='(7) DONT KNOW' 8='(8) REFUSED'
                  9='(9) INAPP' ;
  VALUE j2q41i    1='(1) CHECKED' 2='(2) UNCHECKED' 7='(7) DONT KNOW' ;
  VALUE j2q41i1f  97='(97) DONT KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q41i3f  1='(1) VERY NEGATIVELY' 2='(2) NEGATIVELY'
                  3='(3) NOT AT ALL' 4='(4) POSITIVELY'
                  5='(5) VERY POSITIVELY' 7='(7) DONT KNOW' 8='(8) REFUSED'
                  9='(9) INAPP' ;
  VALUE j2q41i4f  1='(1) VERY NEGATIVELY' 2='(2) NEGATIVELY'
                  3='(3) NOT AT ALL' 4='(4) POSITIVELY'
                  5='(5) VERY POSITIVELY' 7='(7) DONT KNOW' 8='(8) REFUSED'
                  9='(9) INAPP' ;
  VALUE j2q41j    1='(1) CHECKED' 2='(2) UNCHECKED' 7='(7) DONT KNOW' ;
  VALUE j2q41j1f  97='(97) DONT KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q41j3f  1='(1) VERY NEGATIVELY' 2='(2) NEGATIVELY'
                  3='(3) NOT AT ALL' 4='(4) POSITIVELY'
                  5='(5) VERY POSITIVELY' 7='(7) DONT KNOW' 8='(8) REFUSED'
                  9='(9) INAPP' ;
  VALUE j2q41j4f  1='(1) VERY NEGATIVELY' 2='(2) NEGATIVELY'
                  3='(3) NOT AT ALL' 4='(4) POSITIVELY'
                  5='(5) VERY POSITIVELY' 7='(7) DONT KNOW' 8='(8) REFUSED'
                  9='(9) INAPP' ;
  VALUE j2q41k    1='(1) CHECKED' 2='(2) UNCHECKED' 7='(7) DONT KNOW' ;
  VALUE j2q41k1f  97='(97) DONT KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q41k3f  1='(1) VERY NEGATIVELY' 2='(2) NEGATIVELY'
                  3='(3) NOT AT ALL' 4='(4) POSITIVELY'
                  5='(5) VERY POSITIVELY' 7='(7) DONT KNOW' 8='(8) REFUSED'
                  9='(9) INAPP' ;
  VALUE j2q41k4f  1='(1) VERY NEGATIVELY' 2='(2) NEGATIVELY'
                  3='(3) NOT AT ALL' 4='(4) POSITIVELY'
                  5='(5) VERY POSITIVELY' 7='(7) DONT KNOW' 8='(8) REFUSED'
                  9='(9) INAPP' ;
  VALUE j2q41l    1='(1) CHECKED' 2='(2) UNCHECKED' 7='(7) DONT KNOW' ;
  VALUE j2q41l1f  97='(97) DONT KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q41l3f  1='(1) VERY NEGATIVELY' 2='(2) NEGATIVELY'
                  3='(3) NOT AT ALL' 4='(4) POSITIVELY'
                  5='(5) VERY POSITIVELY' 7='(7) DONT KNOW' 8='(8) REFUSED'
                  9='(9) INAPP' ;
  VALUE j2q41l4f  1='(1) VERY NEGATIVELY' 2='(2) NEGATIVELY'
                  3='(3) NOT AT ALL' 4='(4) POSITIVELY'
                  5='(5) VERY POSITIVELY' 7='(7) DONT KNOW' 8='(8) REFUSED'
                  9='(9) INAPP' ;
  VALUE j2q41m    1='(1) CHECKED' 2='(2) UNCHECKED' 7='(7) DONT KNOW' ;
  VALUE j2q41m1f  97='(97) DONT KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q41m3f  1='(1) VERY NEGATIVELY' 2='(2) NEGATIVELY'
                  3='(3) NOT AT ALL' 4='(4) POSITIVELY'
                  5='(5) VERY POSITIVELY' 7='(7) DONT KNOW' 8='(8) REFUSED'
                  9='(9) INAPP' ;
  VALUE j2q41m4f  1='(1) VERY NEGATIVELY' 2='(2) NEGATIVELY'
                  3='(3) NOT AT ALL' 4='(4) POSITIVELY'
                  5='(5) VERY POSITIVELY' 7='(7) DONT KNOW' 8='(8) REFUSED'
                  9='(9) INAPP' ;
  VALUE j2q41n    1='(1) CHECKED' 2='(2) UNCHECKED' 7='(7) DONT KNOW' ;
  VALUE j2q41n1f  97='(97) DONT KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q41n3f  1='(1) VERY NEGATIVELY' 2='(2) NEGATIVELY'
                  3='(3) NOT AT ALL' 4='(4) POSITIVELY'
                  5='(5) VERY POSITIVELY' 7='(7) DONT KNOW' 8='(8) REFUSED'
                  9='(9) INAPP' ;
  VALUE j2q41n4f  1='(1) VERY NEGATIVELY' 2='(2) NEGATIVELY'
                  3='(3) NOT AT ALL' 4='(4) POSITIVELY'
                  5='(5) VERY POSITIVELY' 7='(7) DONT KNOW' 8='(8) REFUSED'
                  9='(9) INAPP' ;
  VALUE j2q41o    1='(1) CHECKED' 2='(2) UNCHECKED' 7='(7) DONT KNOW' ;
  VALUE j2q41o1f  97='(97) DONT KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q41o3f  1='(1) VERY NEGATIVELY' 2='(2) NEGATIVELY'
                  3='(3) NOT AT ALL' 4='(4) POSITIVELY'
                  5='(5) VERY POSITIVELY' 7='(7) DONT KNOW' 8='(8) REFUSED'
                  9='(9) INAPP' ;
  VALUE j2q41o4f  1='(1) VERY NEGATIVELY' 2='(2) NEGATIVELY'
                  3='(3) NOT AT ALL' 4='(4) POSITIVELY'
                  5='(5) VERY POSITIVELY' 7='(7) DONT KNOW' 8='(8) REFUSED'
                  9='(9) INAPP' ;
  VALUE j2q41p    1='(1) CHECKED' 2='(2) UNCHECKED' 7='(7) DONT KNOW' ;
  VALUE j2q41p1f  97='(97) DONT KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q41p3f  1='(1) VERY NEGATIVELY' 2='(2) NEGATIVELY'
                  3='(3) NOT AT ALL' 4='(4) POSITIVELY'
                  5='(5) VERY POSITIVELY' 7='(7) DONT KNOW' 8='(8) REFUSED'
                  9='(9) INAPP' ;
  VALUE j2q41p4f  1='(1) VERY NEGATIVELY' 2='(2) NEGATIVELY'
                  3='(3) NOT AT ALL' 4='(4) POSITIVELY'
                  5='(5) VERY POSITIVELY' 7='(7) DONT KNOW' 8='(8) REFUSED'
                  9='(9) INAPP' ;
  VALUE j2q41q    1='(1) CHECKED' 2='(2) UNCHECKED' 7='(7) DONT KNOW' ;
  VALUE j2q41q1f  97='(97) DONT KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q41q3f  1='(1) VERY NEGATIVELY' 2='(2) NEGATIVELY'
                  3='(3) NOT AT ALL' 4='(4) POSITIVELY'
                  5='(5) VERY POSITIVELY' 7='(7) DONT KNOW' 8='(8) REFUSED'
                  9='(9) INAPP' ;
  VALUE j2q41q4f  1='(1) VERY NEGATIVELY' 2='(2) NEGATIVELY'
                  3='(3) NOT AT ALL' 4='(4) POSITIVELY'
                  5='(5) VERY POSITIVELY' 7='(7) DONT KNOW' 8='(8) REFUSED'
                  9='(9) INAPP' ;
  VALUE j2q41r    1='(1) CHECKED' 2='(2) UNCHECKED' 7='(7) DONT KNOW' ;
  VALUE j2q41r1f  97='(97) DONT KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q41r3f  1='(1) VERY NEGATIVELY' 2='(2) NEGATIVELY'
                  3='(3) NOT AT ALL' 4='(4) POSITIVELY'
                  5='(5) VERY POSITIVELY' 7='(7) DONT KNOW' 8='(8) REFUSED'
                  9='(9) INAPP' ;
  VALUE j2q41r4f  1='(1) VERY NEGATIVELY' 2='(2) NEGATIVELY'
                  3='(3) NOT AT ALL' 4='(4) POSITIVELY'
                  5='(5) VERY POSITIVELY' 7='(7) DONT KNOW' 8='(8) REFUSED'
                  9='(9) INAPP' ;
  VALUE j2q41s    1='(1) CHECKED' 2='(2) UNCHECKED' 7='(7) DONT KNOW' ;
  VALUE j2q41s1f  97='(97) DONT KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q41s3f  1='(1) VERY NEGATIVELY' 2='(2) NEGATIVELY'
                  3='(3) NOT AT ALL' 4='(4) POSITIVELY'
                  5='(5) VERY POSITIVELY' 7='(7) DONT KNOW' 8='(8) REFUSED'
                  9='(9) INAPP' ;
  VALUE j2q41s4f  1='(1) VERY NEGATIVELY' 2='(2) NEGATIVELY'
                  3='(3) NOT AT ALL' 4='(4) POSITIVELY'
                  5='(5) VERY POSITIVELY' 7='(7) DONT KNOW' 8='(8) REFUSED'
                  9='(9) INAPP' ;
  VALUE j2q41t    1='(1) CHECKED' 2='(2) UNCHECKED' 7='(7) DONT KNOW' ;
  VALUE j2q41t1f  97='(97) DONT KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q41t3f  1='(1) VERY NEGATIVELY' 2='(2) NEGATIVELY'
                  3='(3) NOT AT ALL' 4='(4) POSITIVELY'
                  5='(5) VERY POSITIVELY' 7='(7) DONT KNOW' 8='(8) REFUSED'
                  9='(9) INAPP' ;
  VALUE j2q41t4f  1='(1) VERY NEGATIVELY' 2='(2) NEGATIVELY'
                  3='(3) NOT AT ALL' 4='(4) POSITIVELY'
                  5='(5) VERY POSITIVELY' 7='(7) DONT KNOW' 8='(8) REFUSED'
                  9='(9) INAPP' ;
  VALUE j2q41u    1='(1) CHECKED' 2='(2) UNCHECKED' 7='(7) DONT KNOW' ;
  VALUE j2q41u1f  97='(97) DONT KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q41u3f  1='(1) VERY NEGATIVELY' 2='(2) NEGATIVELY'
                  3='(3) NOT AT ALL' 4='(4) POSITIVELY'
                  5='(5) VERY POSITIVELY' 7='(7) DONT KNOW' 8='(8) REFUSED'
                  9='(9) INAPP' ;
  VALUE j2q41u4f  1='(1) VERY NEGATIVELY' 2='(2) NEGATIVELY'
                  3='(3) NOT AT ALL' 4='(4) POSITIVELY'
                  5='(5) VERY POSITIVELY' 7='(7) DONT KNOW' 8='(8) REFUSED'
                  9='(9) INAPP' ;
  VALUE j2q41v    1='(1) CHECKED' 2='(2) UNCHECKED' 7='(7) DONT KNOW' ;
  VALUE j2q41v1f  97='(97) DONT KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q41v3f  1='(1) VERY NEGATIVELY' 2='(2) NEGATIVELY'
                  3='(3) NOT AT ALL' 4='(4) POSITIVELY'
                  5='(5) VERY POSITIVELY' 7='(7) DONT KNOW' 8='(8) REFUSED'
                  9='(9) INAPP' ;
  VALUE j2q41v4f  1='(1) VERY NEGATIVELY' 2='(2) NEGATIVELY'
                  3='(3) NOT AT ALL' 4='(4) POSITIVELY'
                  5='(5) VERY POSITIVELY' 7='(7) DONT KNOW' 8='(8) REFUSED'
                  9='(9) INAPP' ;
  VALUE j2q41w    1='(1) CHECKED' 2='(2) UNCHECKED' 7='(7) DONT KNOW' ;
  VALUE j2q41w1f  97='(97) DONT KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q41w3f  1='(1) VERY NEGATIVELY' 2='(2) NEGATIVELY'
                  3='(3) NOT AT ALL' 4='(4) POSITIVELY'
                  5='(5) VERY POSITIVELY' 7='(7) DONT KNOW' 8='(8) REFUSED'
                  9='(9) INAPP' ;
  VALUE j2q41w4f  1='(1) VERY NEGATIVELY' 2='(2) NEGATIVELY'
                  3='(3) NOT AT ALL' 4='(4) POSITIVELY'
                  5='(5) VERY POSITIVELY' 7='(7) DONT KNOW' 8='(8) REFUSED'
                  9='(9) INAPP' ;
  VALUE j2q41x    1='(1) CHECKED' 2='(2) UNCHECKED' 7='(7) DONT KNOW' ;
  VALUE j2q41x1f  97='(97) DONT KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q41x3f  1='(1) VERY NEGATIVELY' 2='(2) NEGATIVELY'
                  3='(3) NOT AT ALL' 4='(4) POSITIVELY'
                  5='(5) VERY POSITIVELY' 7='(7) DONT KNOW' 8='(8) REFUSED'
                  9='(9) INAPP' ;
  VALUE j2q41x4f  1='(1) VERY NEGATIVELY' 2='(2) NEGATIVELY'
                  3='(3) NOT AT ALL' 4='(4) POSITIVELY'
                  5='(5) VERY POSITIVELY' 7='(7) DONT KNOW' 8='(8) REFUSED'
                  9='(9) INAPP' ;
  VALUE j2q41y    1='(1) CHECKED' 2='(2) UNCHECKED' 7='(7) DONT KNOW' ;
  VALUE j2q41y1f  97='(97) DONT KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q41y3f  1='(1) VERY NEGATIVELY' 2='(2) NEGATIVELY'
                  3='(3) NOT AT ALL' 4='(4) POSITIVELY'
                  5='(5) VERY POSITIVELY' 7='(7) DONT KNOW' 8='(8) REFUSED'
                  9='(9) INAPP' ;
  VALUE j2q41y4f  1='(1) VERY NEGATIVELY' 2='(2) NEGATIVELY'
                  3='(3) NOT AT ALL' 4='(4) POSITIVELY'
                  5='(5) VERY POSITIVELY' 7='(7) DONT KNOW' 8='(8) REFUSED'
                  9='(9) INAPP' ;
  VALUE j2q42fff  1='(1) YES' 2='(2) NO' 7='(7) DONT KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q42am   97='(97) DONT KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q42ay   9997='(9997) DONT KNOW' 9998='(9998) MISSING'
                  9999='(9999) INAPP' ;
  VALUE j2q42bm   97='(97) DONT KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q42by   9997='(9997) DONT KNOW' 9998='(9998) MISSING'
                  9999='(9999) INAPP' ;
  VALUE j2q42cm   97='(97) DONT KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q42cy   9997='(9997) DONT KNOW' 9998='(9998) MISSING'
                  9999='(9999) INAPP' ;
  VALUE j2q43a    1='(1) RARELY OR NONE OF THE TIME'
                  2='(2) SOME OR A LITTLE OF THE TIME'
                  3='(3) OCCASIONALLY OR A MODERATE AMOUNT OF TIME'
                  4='(4) MOST OR ALL OF THE TIME' 7='(7) DONT KNOW'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q43b    1='(1) RARELY OR NONE OF THE TIME'
                  2='(2) SOME OR A LITTLE OF THE TIME'
                  3='(3) OCCASIONALLY OR A MODERATE AMOUNT OF TIME'
                  4='(4) MOST OR ALL OF THE TIME' 7='(7) DONT KNOW'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q43c    1='(1) RARELY OR NONE OF THE TIME'
                  2='(2) SOME OR A LITTLE OF THE TIME'
                  3='(3) OCCASIONALLY OR A MODERATE AMOUNT OF TIME'
                  4='(4) MOST OR ALL OF THE TIME' 7='(7) DONT KNOW'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q43d    1='(1) RARELY OR NONE OF THE TIME'
                  2='(2) SOME OR A LITTLE OF THE TIME'
                  3='(3) OCCASIONALLY OR A MODERATE AMOUNT OF TIME'
                  4='(4) MOST OR ALL OF THE TIME' 7='(7) DONT KNOW'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q43e    1='(1) RARELY OR NONE OF THE TIME'
                  2='(2) SOME OR A LITTLE OF THE TIME'
                  3='(3) OCCASIONALLY OR A MODERATE AMOUNT OF TIME'
                  4='(4) MOST OR ALL OF THE TIME' 7='(7) DONT KNOW'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q43f    1='(1) RARELY OR NONE OF THE TIME'
                  2='(2) SOME OR A LITTLE OF THE TIME'
                  3='(3) OCCASIONALLY OR A MODERATE AMOUNT OF TIME'
                  4='(4) MOST OR ALL OF THE TIME' 7='(7) DONT KNOW'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q43g    1='(1) RARELY OR NONE OF THE TIME'
                  2='(2) SOME OR A LITTLE OF THE TIME'
                  3='(3) OCCASIONALLY OR A MODERATE AMOUNT OF TIME'
                  4='(4) MOST OR ALL OF THE TIME' 7='(7) DON''T KNOW'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q43h    1='(1) RARELY OR NONE OF THE TIME'
                  2='(2) SOME OR A LITTLE OF THE TIME'
                  3='(3) OCCASIONALLY OR A MODERATE AMOUNT OF TIME'
                  4='(4) MOST OR ALL OF THE TIME' 7='(7) DONT KNOW'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q43i    1='(1) RARELY OR NONE OF THE TIME'
                  2='(2) SOME OR A LITTLE OF THE TIME'
                  3='(3) OCCASIONALLY OR A MODERATE AMOUNT OF TIME'
                  4='(4) MOST OR ALL OF THE TIME' 7='(7) DONT KNOW'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q43j    1='(1) RARELY OR NONE OF THE TIME'
                  2='(2) SOME OR A LITTLE OF THE TIME'
                  3='(3) OCCASIONALLY OR A MODERATE AMOUNT OF TIME'
                  4='(4) MOST OR ALL OF THE TIME' 7='(7) DONT KNOW'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q43k    1='(1) RARELY OR NONE OF THE TIME'
                  2='(2) SOME OR A LITTLE OF THE TIME'
                  3='(3) OCCASIONALLY OR A MODERATE AMOUNT OF TIME'
                  4='(4) MOST OR ALL OF THE TIME' 7='(7) DONT KNOW'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q43l    1='(1) RARELY OR NONE OF THE TIME'
                  2='(2) SOME OR A LITTLE OF THE TIME'
                  3='(3) OCCASIONALLY OR A MODERATE AMOUNT OF TIME'
                  4='(4) MOST OR ALL OF THE TIME' 7='(7) DONT KNOW'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q43m    1='(1) RARELY OR NONE OF THE TIME'
                  2='(2) SOME OR A LITTLE OF THE TIME'
                  3='(3) OCCASIONALLY OR A MODERATE AMOUNT OF TIME'
                  4='(4) MOST OR ALL OF THE TIME' 7='(7) DON''T KNOW'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q43n    1='(1) RARELY OR NONE OF THE TIME'
                  2='(2) SOME OR A LITTLE OF THE TIME'
                  3='(3) OCCASIONALLY OR A MODERATE AMOUNT OF TIME'
                  4='(4) MOST OR ALL OF THE TIME' 7='(7) DON''T KNOW'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q43o    1='(1) RARELY OR NONE OF THE TIME'
                  2='(2) SOME OR A LITTLE OF THE TIME'
                  3='(3) OCCASIONALLY OR A MODERATE AMOUNT OF TIME'
                  4='(4) MOST OR ALL OF THE TIME' 7='(7) DON''T KNOW'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q43p    1='(1) RARELY OR NONE OF THE TIME'
                  2='(2) SOME OR A LITTLE OF THE TIME'
                  3='(3) OCCASIONALLY OR A MODERATE AMOUNT OF TIME'
                  4='(4) MOST OR ALL OF THE TIME' 7='(7) DON''T KNOW'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q43q    1='(1) RARELY OR NONE OF THE TIME'
                  2='(2) SOME OR A LITTLE OF THE TIME'
                  3='(3) OCCASIONALLY OR A MODERATE AMOUNT OF TIME'
                  4='(4) MOST OR ALL OF THE TIME' 7='(7) DON''T KNOW'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q43r    1='(1) RARELY OR NONE OF THE TIME'
                  2='(2) SOME OR A LITTLE OF THE TIME'
                  3='(3) OCCASIONALLY OR A MODERATE AMOUNT OF TIME'
                  4='(4) MOST OR ALL OF THE TIME' 7='(7) DON''T KNOW'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q43s    1='(1) RARELY OR NONE OF THE TIME'
                  2='(2) SOME OR A LITTLE OF THE TIME'
                  3='(3) OCCASIONALLY OR A MODERATE AMOUNT OF TIME'
                  4='(4) MOST OR ALL OF THE TIME' 7='(7) DON''T KNOW'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q43t    1='(1) RARELY OR NONE OF THE TIME'
                  2='(2) SOME OR A LITTLE OF THE TIME'
                  3='(3) OCCASIONALLY OR A MODERATE AMOUNT OF TIME'
                  4='(4) MOST OR ALL OF THE TIME' 7='(7) DON''T KNOW'
                  8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2qcesd   98='(98) NOT CALCULATED - Due to missing data' ;
  VALUE j2q44a    1='(1) NOT AT ALL' 2='(2) A LITTLE' 3='(3) MOSTLY'
                  4='(4) VERY WELL' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q44b    1='(1) NOT AT ALL' 2='(2) A LITTLE' 3='(3) MOSTLY'
                  4='(4) VERY WELL' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q44c    1='(1) NOT AT ALL' 2='(2) A LITTLE' 3='(3) MOSTLY'
                  4='(4) VERY WELL' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q44d    1='(1) NOT AT ALL' 2='(2) A LITTLE' 3='(3) MOSTLY'
                  4='(4) VERY WELL' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q44e    1='(1) NOT AT ALL' 2='(2) A LITTLE' 3='(3) MOSTLY'
                  4='(4) VERY WELL' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q44f    1='(1) NOT AT ALL' 2='(2) A LITTLE' 3='(3) MOSTLY'
                  4='(4) VERY WELL' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q44g    1='(1) NOT AT ALL' 2='(2) A LITTLE' 3='(3) MOSTLY'
                  4='(4) VERY WELL' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q44h    1='(1) NOT AT ALL' 2='(2) A LITTLE' 3='(3) MOSTLY'
                  4='(4) VERY WELL' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q44i    1='(1) NOT AT ALL' 2='(2) A LITTLE' 3='(3) MOSTLY'
                  4='(4) VERY WELL' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q44j    1='(1) NOT AT ALL' 2='(2) A LITTLE' 3='(3) MOSTLY'
                  4='(4) VERY WELL' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q44k    1='(1) NOT AT ALL' 2='(2) A LITTLE' 3='(3) MOSTLY'
                  4='(4) VERY WELL' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q44l    1='(1) NOT AT ALL' 2='(2) A LITTLE' 3='(3) MOSTLY'
                  4='(4) VERY WELL' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q44m    1='(1) NOT AT ALL' 2='(2) A LITTLE' 3='(3) MOSTLY'
                  4='(4) VERY WELL' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q44n    1='(1) NOT AT ALL' 2='(2) A LITTLE' 3='(3) MOSTLY'
                  4='(4) VERY WELL' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q44o    1='(1) NOT AT ALL' 2='(2) A LITTLE' 3='(3) MOSTLY'
                  4='(4) VERY WELL' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q44p    1='(1) NOT AT ALL' 2='(2) A LITTLE' 3='(3) MOSTLY'
                  4='(4) VERY WELL' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q44q    1='(1) NOT AT ALL' 2='(2) A LITTLE' 3='(3) MOSTLY'
                  4='(4) VERY WELL' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q44r    1='(1) NOT AT ALL' 2='(2) A LITTLE' 3='(3) MOSTLY'
                  4='(4) VERY WELL' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q44s    1='(1) NOT AT ALL' 2='(2) A LITTLE' 3='(3) MOSTLY'
                  4='(4) VERY WELL' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q44t    1='(1) NOT AT ALL' 2='(2) A LITTLE' 3='(3) MOSTLY'
                  4='(4) VERY WELL' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2qta_ax  98='(98) NOT CALCULATED - Due to missing data' ;
  VALUE j2q45a    1='(1) NOT AT ALL' 2='(2) A LITTLE' 3='(3) MOSTLY'
                  4='(4) VERY WELL' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q45b    1='(1) NOT AT ALL' 2='(2) A LITTLE' 3='(3) MOSTLY'
                  4='(4) VERY WELL' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q45c    1='(1) NOT AT ALL' 2='(2) A LITTLE' 3='(3) MOSTLY'
                  4='(4) VERY WELL' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q45d    1='(1) NOT AT ALL' 2='(2) A LITTLE' 3='(3) MOSTLY'
                  4='(4) VERY WELL' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q45e    1='(1) NOT AT ALL' 2='(2) A LITTLE' 3='(3) MOSTLY'
                  4='(4) VERY WELL' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q45f    1='(1) NOT AT ALL' 2='(2) A LITTLE' 3='(3) MOSTLY'
                  4='(4) VERY WELL' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q45g    1='(1) NOT AT ALL' 2='(2) A LITTLE' 3='(3) MOSTLY'
                  4='(4) VERY WELL' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q45h    1='(1) NOT AT ALL' 2='(2) A LITTLE' 3='(3) MOSTLY'
                  4='(4) VERY WELL' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q45i    1='(1) NOT AT ALL' 2='(2) A LITTLE' 3='(3) MOSTLY'
                  4='(4) VERY WELL' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q45j    1='(1) NOT AT ALL' 2='(2) A LITTLE' 3='(3) MOSTLY'
                  4='(4) VERY WELL' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q45k    1='(1) NOT AT ALL' 2='(2) A LITTLE' 3='(3) MOSTLY'
                  4='(4) VERY WELL' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q45l    1='(1) NOT AT ALL' 2='(2) A LITTLE' 3='(3) MOSTLY'
                  4='(4) VERY WELL' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q45m    1='(1) NOT AT ALL' 2='(2) A LITTLE' 3='(3) MOSTLY'
                  4='(4) VERY WELL' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q45n    1='(1) NOT AT ALL' 2='(2) A LITTLE' 3='(3) MOSTLY'
                  4='(4) VERY WELL' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q45o    1='(1) NOT AT ALL' 2='(2) A LITTLE' 3='(3) MOSTLY'
                  4='(4) VERY WELL' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2qta_ag  98='(98) NOT CALCULATED - Due to missing data' ;
  VALUE j2qta_at  98='(98) NOT CALCULATED - Due to missing data' ;
  VALUE j2qta_ar  98='(98) NOT CALCULATED - Due to missing data' ;
  VALUE j2q46a1f  1='(1) NEVER' 2='(2) 1-6 TIMES' 3='(3) 7+ TIMES'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q46a2f  1='(1) NEUTRAL OR UNPLEASANT' 2='(2) SOMEWHAT PLEASANT'
                  3='(3) VERY PLEASANT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q46b1f  1='(1) NEVER' 2='(2) 1-6 TIMES' 3='(3) 7+ TIMES'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q46b2f  1='(1) NEUTRAL OR UNPLEASANT' 2='(2) SOMEWHAT PLEASANT'
                  3='(3) VERY PLEASANT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q46c1f  1='(1) NEVER' 2='(2) 1-6 TIMES' 3='(3) 7+ TIMES'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q46c2f  1='(1) NEUTRAL OR UNPLEASANT' 2='(2) SOMEWHAT PLEASANT'
                  3='(3) VERY PLEASANT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q46d1f  1='(1) NEVER' 2='(2) 1-6 TIMES' 3='(3) 7+ TIMES'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q46d2f  1='(1) NEUTRAL OR UNPLEASANT' 2='(2) SOMEWHAT PLEASANT'
                  3='(3) VERY PLEASANT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q46e1f  1='(1) NEVER' 2='(2) 1-6 TIMES' 3='(3) 7+ TIMES'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q46e2f  1='(1) NEUTRAL OR UNPLEASANT' 2='(2) SOMEWHAT PLEASANT'
                  3='(3) VERY PLEASANT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q46f1f  1='(1) NEVER' 2='(2) 1-6 TIMES' 3='(3) 7+ TIMES'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q46f2f  1='(1) NEUTRAL OR UNPLEASANT' 2='(2) SOMEWHAT PLEASANT'
                  3='(3) VERY PLEASANT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q46g1f  1='(1) NEVER' 2='(2) 1-6 TIMES' 3='(3) 7+ TIMES' ;
  VALUE j2q46g2f  1='(1) NEUTRAL OR UNPLEASANT' 2='(2) SOMEWHAT PLEASANT'
                  3='(3) VERY PLEASANT' ;
  VALUE j2q46h1f  1='(1) NEVER' 2='(2) 1-6 TIMES' 3='(3) 7+ TIMES'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q46h2f  1='(1) NEUTRAL OR UNPLEASANT' 2='(2) SOMEWHAT PLEASANT'
                  3='(3) VERY PLEASANT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q46i1f  1='(1) NEVER' 2='(2) 1-6 TIMES' 3='(3) 7+ TIMES'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q46i2f  1='(1) NEUTRAL OR UNPLEASANT' 2='(2) SOMEWHAT PLEASANT'
                  3='(3) VERY PLEASANT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q46j1f  1='(1) NEVER' 2='(2) 1-6 TIMES' 3='(3) 7+ TIMES'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q46j2f  1='(1) NEUTRAL OR UNPLEASANT' 2='(2) SOMEWHAT PLEASANT'
                  3='(3) VERY PLEASANT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q46k1f  1='(1) NEVER' 2='(2) 1-6 TIMES' 3='(3) 7+ TIMES'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q46k2f  1='(1) NEUTRAL OR UNPLEASANT' 2='(2) SOMEWHAT PLEASANT'
                  3='(3) VERY PLEASANT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q46l1f  1='(1) NEVER' 2='(2) 1-6 TIMES' 3='(3) 7+ TIMES'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q46l2f  1='(1) NEUTRAL OR UNPLEASANT' 2='(2) SOMEWHAT PLEASANT'
                  3='(3) VERY PLEASANT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q46m1f  1='(1) NEVER' 2='(2) 1-6 TIMES' 3='(3) 7+ TIMES'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q46m2f  1='(1) NEUTRAL OR UNPLEASANT' 2='(2) SOMEWHAT PLEASANT'
                  3='(3) VERY PLEASANT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q46n1f  1='(1) NEVER' 2='(2) 1-6 TIMES' 3='(3) 7+ TIMES'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q46n2f  1='(1) NEUTRAL OR UNPLEASANT' 2='(2) SOMEWHAT PLEASANT'
                  3='(3) VERY PLEASANT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q46o1f  1='(1) NEVER' 2='(2) 1-6 TIMES' 3='(3) 7+ TIMES'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q46o2f  1='(1) NEUTRAL OR UNPLEASANT' 2='(2) SOMEWHAT PLEASANT'
                  3='(3) VERY PLEASANT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q46p1f  1='(1) NEVER' 2='(2) 1-6 TIMES' 3='(3) 7+ TIMES'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q46p2f  1='(1) NEUTRAL OR UNPLEASANT' 2='(2) SOMEWHAT PLEASANT'
                  3='(3) VERY PLEASANT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q46q1f  1='(1) NEVER' 2='(2) 1-6 TIMES' 3='(3) 7+ TIMES'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q46q2f  1='(1) NEUTRAL OR UNPLEASANT' 2='(2) SOMEWHAT PLEASANT'
                  3='(3) VERY PLEASANT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q46r1f  1='(1) NEVER' 2='(2) 1-6 TIMES' 3='(3) 7+ TIMES'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q46r2f  1='(1) NEUTRAL OR UNPLEASANT' 2='(2) SOMEWHAT PLEASANT'
                  3='(3) VERY PLEASANT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q46s1f  1='(1) NEVER' 2='(2) 1-6 TIMES' 3='(3) 7+ TIMES'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q46s2f  1='(1) NEUTRAL OR UNPLEASANT' 2='(2) SOMEWHAT PLEASANT'
                  3='(3) VERY PLEASANT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q46t1f  1='(1) NEVER' 2='(2) 1-6 TIMES' 3='(3) 7+ TIMES'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q46t2f  1='(1) NEUTRAL OR UNPLEASANT' 2='(2) SOMEWHAT PLEASANT'
                  3='(3) VERY PLEASANT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q46u1f  1='(1) NEVER' 2='(2) 1-6 TIMES' 3='(3) 7+ TIMES'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q46u2f  1='(1) NEUTRAL OR UNPLEASANT' 2='(2) SOMEWHAT PLEASANT'
                  3='(3) VERY PLEASANT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q46v1f  1='(1) NEVER' 2='(2) 1-6 TIMES' 3='(3) 7+ TIMES'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q46v2f  1='(1) NEUTRAL OR UNPLEASANT' 2='(2) SOMEWHAT PLEASANT'
                  3='(3) VERY PLEASANT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q46w1f  1='(1) NEVER' 2='(2) 1-6 TIMES' 3='(3) 7+ TIMES'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q46w2f  1='(1) NEUTRAL OR UNPLEASANT' 2='(2) SOMEWHAT PLEASANT'
                  3='(3) VERY PLEASANT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q46x1f  1='(1) NEVER' 2='(2) 1-6 TIMES' 3='(3) 7+ TIMES'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q46x2f  1='(1) NEUTRAL OR UNPLEASANT' 2='(2) SOMEWHAT PLEASANT'
                  3='(3) VERY PLEASANT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q46y1f  1='(1) NEVER' 2='(2) 1-6 TIMES' 3='(3) 7+ TIMES'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q46y2f  1='(1) NEUTRAL OR UNPLEASANT' 2='(2) SOMEWHAT PLEASANT'
                  3='(3) VERY PLEASANT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q46aaf  1='(1) NEVER' 2='(2) 1-6 TIMES' 3='(3) 7+ TIMES'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q46a0f  1='(1) NEUTRAL OR UNPLEASANT' 2='(2) SOMEWHAT PLEASANT'
                  3='(3) VERY PLEASANT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q46bbf  1='(1) NEVER' 2='(2) 1-6 TIMES' 3='(3) 7+ TIMES'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q46b0f  1='(1) NEUTRAL OR UNPLEASANT' 2='(2) SOMEWHAT PLEASANT'
                  3='(3) VERY PLEASANT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q46ccf  1='(1) NEVER' 2='(2) 1-6 TIMES' 3='(3) 7+ TIMES'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q46c0f  1='(1) NEUTRAL OR UNPLEASANT' 2='(2) SOMEWHAT PLEASANT'
                  3='(3) VERY PLEASANT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q46ddf  1='(1) NEVER' 2='(2) 1-6 TIMES' 3='(3) 7+ TIMES'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q46d0f  1='(1) NEUTRAL OR UNPLEASANT' 2='(2) SOMEWHAT PLEASANT'
                  3='(3) VERY PLEASANT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q46eef  1='(1) NEVER' 2='(2) 1-6 TIMES' 3='(3) 7+ TIMES'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q46e0f  1='(1) NEUTRAL OR UNPLEASANT' 2='(2) SOMEWHAT PLEASANT'
                  3='(3) VERY PLEASANT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q46fff  1='(1) NEVER' 2='(2) 1-6 TIMES' 3='(3) 7+ TIMES'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q46f0f  1='(1) NEUTRAL OR UNPLEASANT' 2='(2) SOMEWHAT PLEASANT'
                  3='(3) VERY PLEASANT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q46hhf  1='(1) NEVER' 2='(2) 1-6 TIMES' 3='(3) 7+ TIMES'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q46h0f  1='(1) NEUTRAL OR UNPLEASANT' 2='(2) SOMEWHAT PLEASANT'
                  3='(3) VERY PLEASANT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q46iif  1='(1) NEVER' 2='(2) 1-6 TIMES' 3='(3) 7+ TIMES'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q46i0f  1='(1) NEUTRAL OR UNPLEASANT' 2='(2) SOMEWHAT PLEASANT'
                  3='(3) VERY PLEASANT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q46jjf  1='(1) NEVER' 2='(2) 1-6 TIMES' 3='(3) 7+ TIMES'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q46j0f  1='(1) NEUTRAL OR UNPLEASANT' 2='(2) SOMEWHAT PLEASANT'
                  3='(3) VERY PLEASANT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q46kkf  1='(1) NEVER' 2='(2) 1-6 TIMES' 3='(3) 7+ TIMES'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q46k0f  1='(1) NEUTRAL OR UNPLEASANT' 2='(2) SOMEWHAT PLEASANT'
                  3='(3) VERY PLEASANT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q46llf  1='(1) NEVER' 2='(2) 1-6 TIMES' 3='(3) 7+ TIMES'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q46l0f  1='(1) NEUTRAL OR UNPLEASANT' 2='(2) SOMEWHAT PLEASANT'
                  3='(3) VERY PLEASANT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q46mmf  1='(1) NEVER' 2='(2) 1-6 TIMES' 3='(3) 7+ TIMES'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q46m0f  1='(1) NEUTRAL OR UNPLEASANT' 2='(2) SOMEWHAT PLEASANT'
                  3='(3) VERY PLEASANT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q46nnf  1='(1) NEVER' 2='(2) 1-6 TIMES' 3='(3) 7+ TIMES'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q46n0f  1='(1) NEUTRAL OR UNPLEASANT' 2='(2) SOMEWHAT PLEASANT'
                  3='(3) VERY PLEASANT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q46oof  1='(1) NEVER' 2='(2) 1-6 TIMES' 3='(3) 7+ TIMES'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q46o0f  1='(1) NEUTRAL OR UNPLEASANT' 2='(2) SOMEWHAT PLEASANT'
                  3='(3) VERY PLEASANT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q46ppf  1='(1) NEVER' 2='(2) 1-6 TIMES' 3='(3) 7+ TIMES'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q46p0f  1='(1) NEUTRAL OR UNPLEASANT' 2='(2) SOMEWHAT PLEASANT'
                  3='(3) VERY PLEASANT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q46qqf  1='(1) NEVER' 2='(2) 1-6 TIMES' 3='(3) 7+ TIMES'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q46q0f  1='(1) NEUTRAL OR UNPLEASANT' 2='(2) SOMEWHAT PLEASANT'
                  3='(3) VERY PLEASANT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q46rrf  1='(1) NEVER' 2='(2) 1-6 TIMES' 3='(3) 7+ TIMES'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q46r0f  1='(1) NEUTRAL OR UNPLEASANT' 2='(2) SOMEWHAT PLEASANT'
                  3='(3) VERY PLEASANT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q46ssf  1='(1) NEVER' 2='(2) 1-6 TIMES' 3='(3) 7+ TIMES'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q46s0f  1='(1) NEUTRAL OR UNPLEASANT' 2='(2) SOMEWHAT PLEASANT'
                  3='(3) VERY PLEASANT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q46ttf  1='(1) NEVER' 2='(2) 1-6 TIMES' 3='(3) 7+ TIMES'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q46t0f  1='(1) NEUTRAL OR UNPLEASANT' 2='(2) SOMEWHAT PLEASANT'
                  3='(3) VERY PLEASANT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q46uuf  1='(1) NEVER' 2='(2) 1-6 TIMES' 3='(3) 7+ TIMES'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q46u0f  1='(1) NEUTRAL OR UNPLEASANT' 2='(2) SOMEWHAT PLEASANT'
                  3='(3) VERY PLEASANT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q46vvf  1='(1) NEVER' 2='(2) 1-6 TIMES' 3='(3) 7+ TIMES'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q46v0f  1='(1) NEUTRAL OR UNPLEASANT' 2='(2) SOMEWHAT PLEASANT'
                  3='(3) VERY PLEASANT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q46wwf  1='(1) NEVER' 2='(2) 1-6 TIMES' 3='(3) 7+ TIMES'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q46w0f  1='(1) NEUTRAL OR UNPLEASANT' 2='(2) SOMEWHAT PLEASANT'
                  3='(3) VERY PLEASANT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q47a    1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE'
                  3='(3) SLIGHTLY DISAGREE' 4='(4) NEUTRAL'
                  5='(5) SLIGHTLY AGREE' 6='(6) AGREE' 7='(7) STRONGLY AGREE'
                  97='(97) DON''T KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q47b    1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE'
                  3='(3) SLIGHTLY DISAGREE' 4='(4) NEUTRAL'
                  5='(5) SLIGHTLY AGREE' 6='(6) AGREE' 7='(7) STRONGLY AGREE'
                  97='(97) DON''T KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q47c    1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE'
                  3='(3) SLIGHTLY DISAGREE' 4='(4) NEUTRAL'
                  5='(5) SLIGHTLY AGREE' 6='(6) AGREE' 7='(7) STRONGLY AGREE'
                  97='(97) DON''T KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q47d    1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE'
                  3='(3) SLIGHTLY DISAGREE' 4='(4) NEUTRAL'
                  5='(5) SLIGHTLY AGREE' 6='(6) AGREE' 7='(7) STRONGLY AGREE'
                  97='(97) DON''T KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q47e    1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE'
                  3='(3) SLIGHTLY DISAGREE' 4='(4) NEUTRAL'
                  5='(5) SLIGHTLY AGREE' 6='(6) AGREE' 7='(7) STRONGLY AGREE'
                  97='(97) DON''T KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q47f    1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE'
                  3='(3) SLIGHTLY DISAGREE' 4='(4) NEUTRAL'
                  5='(5) SLIGHTLY AGREE' 6='(6) AGREE' 7='(7) STRONGLY AGREE'
                  97='(97) DON''T KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q47g    1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE'
                  3='(3) SLIGHTLY DISAGREE' 4='(4) NEUTRAL'
                  5='(5) SLIGHTLY AGREE' 6='(6) AGREE' 7='(7) STRONGLY AGREE'
                  97='(97) DON''T KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q47h    1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE'
                  3='(3) SLIGHTLY DISAGREE' 4='(4) NEUTRAL'
                  5='(5) SLIGHTLY AGREE' 6='(6) AGREE' 7='(7) STRONGLY AGREE'
                  97='(97) DON''T KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q47i    1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE'
                  3='(3) SLIGHTLY DISAGREE' 4='(4) NEUTRAL'
                  5='(5) SLIGHTLY AGREE' 6='(6) AGREE' 7='(7) STRONGLY AGREE'
                  97='(97) DON''T KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q47j    1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE'
                  3='(3) SLIGHTLY DISAGREE' 4='(4) NEUTRAL'
                  5='(5) SLIGHTLY AGREE' 6='(6) AGREE' 7='(7) STRONGLY AGREE'
                  97='(97) DON''T KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q47k    1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE'
                  3='(3) SLIGHTLY DISAGREE' 4='(4) NEUTRAL'
                  5='(5) SLIGHTLY AGREE' 6='(6) AGREE' 7='(7) STRONGLY AGREE'
                  97='(97) DON''T KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q47l    1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE'
                  3='(3) SLIGHTLY DISAGREE' 4='(4) NEUTRAL'
                  5='(5) SLIGHTLY AGREE' 6='(6) AGREE' 7='(7) STRONGLY AGREE'
                  97='(97) DON''T KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2qso_pc  8='(8) NOT CALCULATED - Due to missing data' ;
  VALUE j2qso_pf  8='(8) NOT CALCULATED - Due to missing data' ;
  VALUE j2qso_px  8='(8) NOT CALCULATED - Due to missing data' ;
  VALUE j2qso_iw  8='(8) NOT CALCULATED - Due to missing data' ;
  VALUE j2qso_gw  8='(8) NOT CALCULATED - Due to missing data' ;
  VALUE j2q48a    1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE'
                  3='(3) SLIGHTLY DISAGREE' 4='(4) NEUTRAL'
                  5='(5) SLIGHTLY AGREE' 6='(6) AGREE' 7='(7) STRONGLY AGREE'
                  97='(97) DON''T KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q48b    1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE'
                  3='(3) SLIGHTLY DISAGREE' 4='(4) NEUTRAL'
                  5='(5) SLIGHTLY AGREE' 6='(6) AGREE' 7='(7) STRONGLY AGREE'
                  97='(97) DON''T KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q48c    1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE'
                  3='(3) SLIGHTLY DISAGREE' 4='(4) NEUTRAL'
                  5='(5) SLIGHTLY AGREE' 6='(6) AGREE' 7='(7) STRONGLY AGREE'
                  97='(97) DON''T KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q48d    1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE'
                  3='(3) SLIGHTLY DISAGREE' 4='(4) NEUTRAL'
                  5='(5) SLIGHTLY AGREE' 6='(6) AGREE' 7='(7) STRONGLY AGREE'
                  97='(97) DON''T KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q48e    1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE'
                  3='(3) SLIGHTLY DISAGREE' 4='(4) NEUTRAL'
                  5='(5) SLIGHTLY AGREE' 6='(6) AGREE' 7='(7) STRONGLY AGREE'
                  97='(97) DON''T KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q48f    1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE'
                  3='(3) SLIGHTLY DISAGREE' 4='(4) NEUTRAL'
                  5='(5) SLIGHTLY AGREE' 6='(6) AGREE' 7='(7) STRONGLY AGREE'
                  97='(97) DON''T KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q48g    1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE'
                  3='(3) SLIGHTLY DISAGREE' 4='(4) NEUTRAL'
                  5='(5) SLIGHTLY AGREE' 6='(6) AGREE' 7='(7) STRONGLY AGREE'
                  97='(97) DON''T KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q48h    1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE'
                  3='(3) SLIGHTLY DISAGREE' 4='(4) NEUTRAL'
                  5='(5) SLIGHTLY AGREE' 6='(6) AGREE' 7='(7) STRONGLY AGREE'
                  97='(97) DON''T KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q48i    1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE'
                  3='(3) SLIGHTLY DISAGREE' 4='(4) NEUTRAL'
                  5='(5) SLIGHTLY AGREE' 6='(6) AGREE' 7='(7) STRONGLY AGREE'
                  97='(97) DON''T KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q48j    1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE'
                  3='(3) SLIGHTLY DISAGREE' 4='(4) NEUTRAL'
                  5='(5) SLIGHTLY AGREE' 6='(6) AGREE' 7='(7) STRONGLY AGREE'
                  97='(97) DON''T KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q48k    1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE'
                  3='(3) SLIGHTLY DISAGREE' 4='(4) NEUTRAL'
                  5='(5) SLIGHTLY AGREE' 6='(6) AGREE' 7='(7) STRONGLY AGREE'
                  97='(97) DON''T KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q48l    1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE'
                  3='(3) SLIGHTLY DISAGREE' 4='(4) NEUTRAL'
                  5='(5) SLIGHTLY AGREE' 6='(6) AGREE' 7='(7) STRONGLY AGREE'
                  97='(97) DON''T KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q48m    1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE'
                  3='(3) SLIGHTLY DISAGREE' 4='(4) NEUTRAL'
                  5='(5) SLIGHTLY AGREE' 6='(6) AGREE' 7='(7) STRONGLY AGREE'
                  97='(97) DON''T KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q48n    1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE'
                  3='(3) SLIGHTLY DISAGREE' 4='(4) NEUTRAL'
                  5='(5) SLIGHTLY AGREE' 6='(6) AGREE' 7='(7) STRONGLY AGREE'
                  97='(97) DON''T KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q48o    1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE'
                  3='(3) SLIGHTLY DISAGREE' 4='(4) NEUTRAL'
                  5='(5) SLIGHTLY AGREE' 6='(6) AGREE' 7='(7) STRONGLY AGREE'
                  97='(97) DON''T KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q48p    1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE'
                  3='(3) SLIGHTLY DISAGREE' 4='(4) NEUTRAL'
                  5='(5) SLIGHTLY AGREE' 6='(6) AGREE' 7='(7) STRONGLY AGREE'
                  97='(97) DON''T KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q48q    1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE'
                  3='(3) SLIGHTLY DISAGREE' 4='(4) NEUTRAL'
                  5='(5) SLIGHTLY AGREE' 6='(6) AGREE' 7='(7) STRONGLY AGREE'
                  97='(97) DON''T KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q48r    1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE'
                  3='(3) SLIGHTLY DISAGREE' 4='(4) NEUTRAL'
                  5='(5) SLIGHTLY AGREE' 6='(6) AGREE' 7='(7) STRONGLY AGREE'
                  97='(97) DON''T KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q48s    1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE'
                  3='(3) SLIGHTLY DISAGREE' 4='(4) NEUTRAL'
                  5='(5) SLIGHTLY AGREE' 6='(6) AGREE' 7='(7) STRONGLY AGREE'
                  97='(97) DON''T KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q48t    1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE'
                  3='(3) SLIGHTLY DISAGREE' 4='(4) NEUTRAL'
                  5='(5) SLIGHTLY AGREE' 6='(6) AGREE' 7='(7) STRONGLY AGREE'
                  97='(97) DON''T KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2q48u    1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE'
                  3='(3) SLIGHTLY DISAGREE' 4='(4) NEUTRAL'
                  5='(5) SLIGHTLY AGREE' 6='(6) AGREE' 7='(7) STRONGLY AGREE'
                  97='(97) DON''T KNOW' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2qrisc   8='(8) NOT CALCULATED - Due to missing data' ;
  VALUE j2qsymp   8='(8) NOT CALCULATED - Due to missing data' ;
  VALUE j2qadj    8='(8) NOT CALCULATED - Due to missing data' ;
  VALUE j2q49a    1='(1) NOT AT ALL' 2='(2) A LITTLE' 3='(3) SOME'
                  4='(4) A LOT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q49b    1='(1) NOT AT ALL' 2='(2) A LITTLE' 3='(3) SOME'
                  4='(4) A LOT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q49c    1='(1) NOT AT ALL' 2='(2) A LITTLE' 3='(3) SOME'
                  4='(4) A LOT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q49d    1='(1) NOT AT ALL' 2='(2) A LITTLE' 3='(3) SOME'
                  4='(4) A LOT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q49e    1='(1) NOT AT ALL' 2='(2) A LITTLE' 3='(3) SOME'
                  4='(4) A LOT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q49f    1='(1) NOT AT ALL' 2='(2) A LITTLE' 3='(3) SOME'
                  4='(4) A LOT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q49g    1='(1) NOT AT ALL' 2='(2) A LITTLE' 3='(3) SOME'
                  4='(4) A LOT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q49h    1='(1) NOT AT ALL' 2='(2) A LITTLE' 3='(3) SOME'
                  4='(4) A LOT' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2qssctr  8='(8) NOT CALCULATED (Due to missing data)' ;
  VALUE j2qcscdf  8='(8) NOT CALCULATED - Due to missing data' ;
  VALUE j2qcsc0f  8='(8) NOT CALCULATED - Due to missing data' ;
  VALUE j2qcscpf  8='(8) NOT CALCULATED - Due to missing data' ;
  VALUE j2qcsc1f  8='(8) NOT CALCULATED - Due to missing data' ;
  VALUE j2q50a    1='(1) NOT AT ALL IMPORTANT' 2='(2) SOMEWHAT IMPORTANT'
                  3='(3) VERY IMPORTANT' 4='(4) EXTREMELY IMPORTANT'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q50b    1='(1) NOT AT ALL IMPORTANT' 2='(2) SOMEWHAT IMPORTANT'
                  3='(3) VERY IMPORTANT' 4='(4) EXTREMELY IMPORTANT'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q50c    1='(1) NOT AT ALL IMPORTANT' 2='(2) SOMEWHAT IMPORTANT'
                  3='(3) VERY IMPORTANT' 4='(4) EXTREMELY IMPORTANT'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q50d    1='(1) NOT AT ALL IMPORTANT' 2='(2) SOMEWHAT IMPORTANT'
                  3='(3) VERY IMPORTANT' 4='(4) EXTREMELY IMPORTANT'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q50e    1='(1) NOT AT ALL IMPORTANT' 2='(2) SOMEWHAT IMPORTANT'
                  3='(3) VERY IMPORTANT' 4='(4) EXTREMELY IMPORTANT'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q50f    1='(1) NOT AT ALL IMPORTANT' 2='(2) SOMEWHAT IMPORTANT'
                  3='(3) VERY IMPORTANT' 4='(4) EXTREMELY IMPORTANT'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q50g    1='(1) NOT AT ALL IMPORTANT' 2='(2) SOMEWHAT IMPORTANT'
                  3='(3) VERY IMPORTANT' 4='(4) EXTREMELY IMPORTANT'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2q50h    1='(1) NOT AT ALL IMPORTANT' 2='(2) SOMEWHAT IMPORTANT'
                  3='(3) VERY IMPORTANT' 4='(4) EXTREMELY IMPORTANT'
                  7='(7) DON''T KNOW' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2qsw_jp  8='(8) NOT CALCULATED - Due to missing data' ;
  VALUE j2q51a    1='(1) YES' 2='(2) NO' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q51b    1='(1) YES' 2='(2) NO' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q51c    1='(1) YES' 2='(2) NO' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q51d    1='(1) YES' 2='(2) NO' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q51e    1='(1) YES' 2='(2) NO' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q51f    1='(1) YES' 2='(2) NO' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q51g    1='(1) YES' 2='(2) NO' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q51h    1='(1) YES' 2='(2) NO' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q51i    1='(1) YES' 2='(2) NO' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q51j    1='(1) YES' 2='(2) NO' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q51k    1='(1) YES' 2='(2) NO' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q51l    1='(1) YES' 2='(2) NO' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q51m    1='(1) YES' 2='(2) NO' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q51n    1='(1) YES' 2='(2) NO' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q51o    1='(1) YES' 2='(2) NO' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q51p    1='(1) YES' 2='(2) NO' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q51q    1='(1) YES' 2='(2) NO' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q52fff  1='(1) YES' 2='(2) NO' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q541ff  1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE' 3='(3) AGREE'
                  4='(4) STRONGLY AGREE' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q542ff  1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE' 3='(3) AGREE'
                  4='(4) STRONGLY AGREE' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q543ff  1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE' 3='(3) AGREE'
                  4='(4) STRONGLY AGREE' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q544ff  1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE' 3='(3) AGREE'
                  4='(4) STRONGLY AGREE' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q545ff  1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE' 3='(3) AGREE'
                  4='(4) STRONGLY AGREE' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q546ff  1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE' 3='(3) AGREE'
                  4='(4) STRONGLY AGREE' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q547ff  1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE' 3='(3) AGREE'
                  4='(4) STRONGLY AGREE' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q548ff  1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE' 3='(3) AGREE'
                  4='(4) STRONGLY AGREE' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q549ff  1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE' 3='(3) AGREE'
                  4='(4) STRONGLY AGREE' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q5410f  1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE' 3='(3) AGREE'
                  4='(4) STRONGLY AGREE' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q5411f  1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE' 3='(3) AGREE'
                  4='(4) STRONGLY AGREE' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q5412f  1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE' 3='(3) AGREE'
                  4='(4) STRONGLY AGREE' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q5413f  1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE' 3='(3) AGREE'
                  4='(4) STRONGLY AGREE' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q5414f  1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE' 3='(3) AGREE'
                  4='(4) STRONGLY AGREE' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q5415f  1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE' 3='(3) AGREE'
                  4='(4) STRONGLY AGREE' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q5416f  1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE' 3='(3) AGREE'
                  4='(4) STRONGLY AGREE' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q5417f  1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE' 3='(3) AGREE'
                  4='(4) STRONGLY AGREE' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q5418f  1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE' 3='(3) AGREE'
                  4='(4) STRONGLY AGREE' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q5419f  1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE' 3='(3) AGREE'
                  4='(4) STRONGLY AGREE' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q5420f  1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE' 3='(3) AGREE'
                  4='(4) STRONGLY AGREE' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q5421f  1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE' 3='(3) AGREE'
                  4='(4) STRONGLY AGREE' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2q5422f  1='(1) STRONGLY DISAGREE' 2='(2) DISAGREE' 3='(3) AGREE'
                  4='(4) STRONGLY AGREE' 7='(7) DON''T KNOW' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2qjc_sd  98='(98) NOT CALCULATED - Due to missing data' ;
  VALUE j2qjc_da  98='(98) NOT CALCULATED - Due to missing data' ;
  VALUE j2qjc_dl  98='(98) NOT CALCULATED - Due to missing data' ;
  VALUE j2qjc_pd  98='(98) NOT CALCULATED - Due to missing data' ;
  VALUE j2qjc_ss  98='(98) NOT CALCULATED - Due to missing data' ;
  VALUE j2qjc_cs  98='(98) NOT CALCULATED - Due to missing data' ;
  VALUE j2clmday  1='(1) DAY OF CLINIC VISIT' 2='(2) DAY BEFORE CLINIC VISIT' ;
  VALUE j2cbmi    999997='(999997) DONT KNOW' 999998='(999998) MISSING'
                  999999='(999999) INAPP' ;
  VALUE j2chipcm  1='(1) NONE' 2='(2) WITH CLOTHES ON' 3='(3) PREGNANT' ;
  VALUE j2cwhr    999997='(999997) DONT KNOW' 999998='(999998) MISSING'
                  999999='(999999) INAPP' ;
  VALUE j2cbps2f  997='(997) DONT KNOW' 998='(998) MISSING' 999='(999) INAPP' ;
  VALUE j2cbpd2f  997='(997) DONT KNOW' 998='(998) MISSING' 999='(999) INAPP' ;
  VALUE j2cbld    1='(1) NO SAMPLE' 2='(2) PARTIAL' 3='(3) COMPLETE'
                  4='(4) OTHER' ;
  VALUE j2bchol   997='(997) DONT KNOW' 998='(998) REFUSED/MISSING'
                  999='(999) INAPP' ;
  VALUE j2bhdl    997='(997) DONT KNOW' 998='(998) REFUSED/MISSING'
                  999='(999) INAPP' ;
  VALUE j2bhdla   997='(997) DONT KNOW' 998='(998) REFUSED/MISSING'
                  999='(999) INAPP' ;
  VALUE j2brthdl  9997='(9997) DONT KNOW' 9998='(9998) REFUSED/MISSING'
                  9999='(9999) INAPP' ;
  VALUE j2brthda  9997='(9997) DONT KNOW' 9998='(9998) REFUSED/MISSING'
                  9999='(9999) INAPP' ;
  VALUE j2bdheas  9997='(9997) DONT KNOW' 9998='(9998) REFUSED/MISSING'
                  9999='(9999) INAPP' ;
  VALUE j2bdhea   9997='(9997) DONT KNOW' 9998='(9998) REFUSED/MISSING'
                  9999='(9999) INAPP' ;
  VALUE j2bscrea  997='(997) DONT KNOW' 998='(998) REFUSED/MISSING'
                  999='(999) INAPP' ;
  VALUE j2bil6ff  99997='(99997) DONT KNOW' 99998='(99998) REFUSED/MISSING'
                  99999='(99999) INAPP' ;
  VALUE j2bsil6r  99997='(99997) DONT KNOW' 99998='(99998) REFUSED/MISSING'
                  99999='(99999) INAPP' ;
  VALUE j2bfgn    997='(997) DONT KNOW' 998='(998) REFUSED/MISSING'
                  999='(999) INAPP' ;
  VALUE j2bcrp    99997='(99997) DONT KNOW' 99998='(99998) REFUSED/MISSING'
                  99999='(99999) INAPP' ;
  VALUE j2ssal    1='(1) YES' 2='(2) NO' ;
  VALUE j2cscseq  1='(1) YES' 2='(2) NO' ;
  VALUE j2sd1mnh  98='(98) MISSING' ;
  VALUE j2sd1mnm  98='(98) MISSING' ;
  VALUE j2sd1mdh  98='(98) MISSING' ;
  VALUE j2sd1mdm  98='(98) MISSING' ;
  VALUE j2sd1evh  98='(98) MISSING' ;
  VALUE j2sd1evm  98='(98) MISSING' ;
  VALUE j2sd2mnh  98='(98) MISSING' ;
  VALUE j2sd2mnm  98='(98) MISSING' ;
  VALUE j2sd2mdh  98='(98) MISSING' ;
  VALUE j2sd2mdm  98='(98) MISSING' ;
  VALUE j2sd2evh  98='(98) MISSING' ;
  VALUE j2sd2evm  98='(98) MISSING' ;
  VALUE j2sd3mnh  98='(98) MISSING' ;
  VALUE j2sd3mnm  98='(98) MISSING' ;
  VALUE j2sd3mdh  98='(98) MISSING' ;
  VALUE j2sd3mdm  98='(98) MISSING' ;
  VALUE j2sd3evh  98='(98) MISSING' ;
  VALUE j2sd3evm  98='(98) MISSING' ;
  VALUE j2scdayf  1='(1) YES' 2='(2) NO' ;
  VALUE j2scda0f  1='(1) YES' 2='(2) NO' ;
  VALUE j2scda1f  1='(1) YES' 2='(2) NO' ;
  VALUE j2bscd1f  997='(997) DONT KNOW' 998='(998) REFUSED/MISSING'
                  999='(999) INAPP' ;
  VALUE j2bscd0f  997='(997) DONT KNOW' 998='(998) REFUSED/MISSING'
                  999='(999) INAPP' ;
  VALUE j2bscd2f  997='(997) DONT KNOW' 998='(998) REFUSED/MISSING'
                  999='(999) INAPP' ;
  VALUE j2bscd3f  997='(997) DONT KNOW' 998='(998) REFUSED/MISSING'
                  999='(999) INAPP' ;
  VALUE j2bscd4f  997='(997) DONT KNOW' 998='(998) REFUSED/MISSING'
                  999='(999) INAPP' ;
  VALUE j2bscd5f  997='(997) DONT KNOW' 998='(998) REFUSED/MISSING'
                  999='(999) INAPP' ;
  VALUE j2bscd6f  997='(997) DONT KNOW' 998='(998) REFUSED/MISSING'
                  999='(999) INAPP' ;
  VALUE j2bscd7f  997='(997) DONT KNOW' 998='(998) REFUSED/MISSING'
                  999='(999) INAPP' ;
  VALUE j2bscd8f  997='(997) DONT KNOW' 998='(998) REFUSED/MISSING'
                  999='(999) INAPP' ;
  VALUE j2mpmd    1='(1) YES' 2='(2) NO' 7='(7) DK' 8='(8) MISSING' ;
  VALUE j2mqmd    1='(1) YES' 2='(2) NO' 7='(7) DK' 8='(8) MISSING' ;
  VALUE j2mpm     97='(97) DK' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mpc1ff  99999997='(99999997) DK' 99999998='(99999998) MISSING'
                  99999999='(99999999) INAPP' ;
  VALUE j2mpdd1f  9996='(9996) MIXED DOSAGE' 9997='(9997) DK'
                  9998='(9998) MISSING' 9999='(9999) INAPP' ;
  VALUE j2mpdu1f  1='(01) MG' 2='(02) GRAMS' 3='(03) MCG' 4='(04) IU'
                  5='(05) MEQ' 6='(06) CC/ML' 7='(07) TEASPOON'
                  8='(08) TABLET' 9='(09) CAPSULE' 10='(10) PUFF/SQUIRT'
                  11='(11) UNIT' 12='(12) OTHER' 97='(97) DK'
                  98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mpr1ff  1='(1) ORAL (PO)' 2='(2) INHALED' 3='(3) TOPICAL'
                  4='(4) SUB Q/SUB C' 5='(5) INTRAMUSCULAR'
                  6='(6) SUBLINGUAL' 7='(7) OTHER' 97='(97) DK'
                  98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mpf1ff  97='(97) DK' 98='(98) REFUSED' 99='(99) INAPP' ;
  VALUE j2mpfu1f  1='(1) DAY' 2='(2) EVERY OTHER DAY' 3='(3) WEEK'
                  4='(4) MONTH' 5='(5) AS NEEDED (PRN)' 6='(6) OTHER'
                  7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mpt1ff  97='(97) DK' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mptu1f  1='(1) DAY' 2='(2) WEEK' 3='(3) MONTH' 4='(4) YEAR'
                  5='(5) OTHER' 7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mpdc1f  99997='(99997) DK' 99998='(99998) MISSING'
                  99999='(99999) INAPP' ;
  VALUE j2mpc2ff  99999997='(99999997) DK' 99999998='(99999998) MISSING'
                  99999999='(99999999) INAPP' ;
  VALUE j2mpdd2f  9996='(9996) MIXED DOSAGE' 9997='(9997) DK'
                  9998='(9998) MISSING' 9999='(9999) INAPP' ;
  VALUE j2mpdu2f  1='(01) MG' 2='(02) GRAMS' 3='(03) MCG' 4='(04) IU'
                  5='(05) MEQ' 6='(06) CC/ML' 7='(07) TEASPOON'
                  8='(08) TABLET' 9='(09) CAPSULE' 10='(10) PUFF/SQUIRT'
                  11='(11) UNIT' 12='(12) OTHER' 97='(97) DK'
                  98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mpr2ff  1='(1) ORAL (PO)' 2='(2) INHALED' 3='(3) TOPICAL'
                  4='(4) SUB Q/SUB C' 5='(5) INTRAMUSCULAR'
                  6='(6) SUBLINGUAL' 7='(7) OTHER' 97='(97) DK'
                  98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mpf2ff  97='(97) DK' 98='(98) REFUSED' 99='(99) INAPP' ;
  VALUE j2mpfu2f  1='(1) DAY' 2='(2) EVERY OTHER DAY' 3='(3) WEEK'
                  4='(4) MONTH' 5='(5) AS NEEDED (PRN)' 6='(6) OTHER'
                  7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mpt2ff  97='(97) DK' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mptu2f  1='(1) DAY' 2='(2) WEEK' 3='(3) MONTH' 4='(4) YEAR'
                  5='(5) OTHER' 7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mpdc2f  99997='(99997) DK' 99998='(99998) MISSING'
                  99999='(99999) INAPP' ;
  VALUE j2mpc3ff  99999997='(99999997) DK' 99999998='(99999998) MISSING'
                  99999999='(99999999) INAPP' ;
  VALUE j2mpdd3f  9996='(9996) MIXED DOSAGE' 9997='(9997) DK'
                  9998='(9998) MISSING' 9999='(9999) INAPP' ;
  VALUE j2mpdu3f  1='(01) MG' 2='(02) GRAMS' 3='(03) MCG' 4='(04) IU'
                  5='(05) MEQ' 6='(06) CC/ML' 7='(07) TEASPOON'
                  8='(08) TABLET' 9='(09) CAPSULE' 10='(10) PUFF/SQUIRT'
                  11='(11) UNIT' 12='(12) OTHER' 97='(97) DK'
                  98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mpr3ff  1='(1) ORAL (PO)' 2='(2) INHALED' 3='(3) TOPICAL'
                  4='(4) SUB Q/SUB C' 5='(5) INTRAMUSCULAR'
                  6='(6) SUBLINGUAL' 7='(7) OTHER' 97='(97) DK'
                  98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mpf3ff  97='(97) DK' 98='(98) REFUSED' 99='(99) INAPP' ;
  VALUE j2mpfu3f  1='(1) DAY' 2='(2) EVERY OTHER DAY' 3='(3) WEEK'
                  4='(4) MONTH' 5='(5) AS NEEDED (PRN)' 6='(6) OTHER'
                  7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mpt3ff  97='(97) DK' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mptu3f  1='(1) DAY' 2='(2) WEEK' 3='(3) MONTH' 4='(4) YEAR'
                  5='(5) OTHER' 7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mpdc3f  99997='(99997) DK' 99998='(99998) MISSING'
                  99999='(99999) INAPP' ;
  VALUE j2mpc4ff  99999997='(99999997) DK' 99999998='(99999998) MISSING'
                  99999999='(99999999) INAPP' ;
  VALUE j2mpdd4f  9996='(9996) MIXED DOSAGE' 9997='(9997) DK'
                  9998='(9998) MISSING' 9999='(9999) INAPP' ;
  VALUE j2mpdu4f  1='(01) MG' 2='(02) GRAMS' 3='(03) MCG' 4='(04) IU'
                  5='(05) MEQ' 6='(06) CC/ML' 7='(07) TEASPOON'
                  8='(08) TABLET' 9='(09) CAPSULE' 10='(10) PUFF/SQUIRT'
                  11='(11) UNIT' 12='(12) OTHER' 97='(97) DK'
                  98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mpr4ff  1='(1) ORAL (PO)' 2='(2) INHALED' 3='(3) TOPICAL'
                  4='(4) SUB Q/SUB C' 5='(5) INTRAMUSCULAR'
                  6='(6) SUBLINGUAL' 7='(7) OTHER' 97='(97) DK'
                  98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mpf4ff  97='(97) DK' 98='(98) REFUSED' 99='(99) INAPP' ;
  VALUE j2mpfu4f  1='(1) DAY' 2='(2) EVERY OTHER DAY' 3='(3) WEEK'
                  4='(4) MONTH' 5='(5) AS NEEDED (PRN)' 6='(6) OTHER'
                  7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mpt4ff  97='(97) DK' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mptu4f  1='(1) DAY' 2='(2) WEEK' 3='(3) MONTH' 4='(4) YEAR'
                  5='(5) OTHER' 7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mpdc4f  99997='(99997) DON''T KNOW' 99998='(99998) MISSING'
                  99999='(99999) INAPP' ;
  VALUE j2mpc5ff  99999997='(99999997) DK' 99999998='(99999998) MISSING'
                  99999999='(99999999) INAPP' ;
  VALUE j2mpdd5f  9996='(9996) MIXED DOSAGE' 9997='(9997) DK'
                  9998='(9998) MISSING' 9999='(9999) INAPP' ;
  VALUE j2mpdu5f  1='(01) MG' 2='(02) GRAMS' 3='(03) MCG' 4='(04) IU'
                  5='(05) MEQ' 6='(06) CC/ML' 7='(07) TEASPOON'
                  8='(08) TABLET' 9='(09) CAPSULE' 10='(10) PUFF/SQUIRT'
                  11='(11) UNIT' 12='(12) OTHER' 97='(97) DK'
                  98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mpr5ff  1='(1) ORAL (PO)' 2='(2) INHALED' 3='(3) TOPICAL'
                  4='(4) SUB Q/SUB C' 5='(5) INTRAMUSCULAR'
                  6='(6) SUBLINGUAL' 7='(7) OTHER' 97='(97) DK'
                  98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mpf5ff  97='(97) DK' 98='(98) REFUSED' 99='(99) INAPP' ;
  VALUE j2mpfu5f  1='(1) DAY' 2='(2) EVERY OTHER DAY' 3='(3) WEEK'
                  4='(4) MONTH' 5='(5) AS NEEDED (PRN)' 6='(6) OTHER'
                  7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mpt5ff  97='(97) DK' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mptu5f  1='(1) DAY' 2='(2) WEEK' 3='(3) MONTH' 4='(4) YEAR'
                  5='(5) OTHER' 7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mpdc5f  99997='(99997) DK' 99998='(99998) MISSING'
                  99999='(99999) INAPP' ;
  VALUE j2mpc6ff  99999997='(99999997) DK' 99999998='(99999998) MISSING'
                  99999999='(99999999) INAPP' ;
  VALUE j2mpdd6f  9996='(9996) MIXED DOSAGE' 9997='(9997) DK'
                  9998='(9998) MISSING' 9999='(9999) INAPP' ;
  VALUE j2mpdu6f  1='(01) MG' 2='(02) GRAMS' 3='(03) MCG' 4='(04) IU'
                  5='(05) MEQ' 6='(06) CC/ML' 7='(07) TEASPOON'
                  8='(08) TABLET' 9='(09) CAPSULE' 10='(10) PUFF/SQUIRT'
                  11='(11) UNIT' 12='(12) OTHER' 97='(97) DK'
                  98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mpr6ff  1='(1) ORAL (PO)' 2='(2) INHALED' 3='(3) TOPICAL'
                  4='(4) SUB Q/SUB C' 5='(5) INTRAMUSCULAR'
                  6='(6) SUBLINGUAL' 7='(7) OTHER' 97='(97) DK'
                  98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mpf6ff  97='(97) DK' 98='(98) REFUSED' 99='(99) INAPP' ;
  VALUE j2mpfu6f  1='(1) DAY' 2='(2) EVERY OTHER DAY' 3='(3) WEEK'
                  4='(4) MONTH' 5='(5) AS NEEDED (PRN)' 6='(6) OTHER'
                  7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mpt6ff  97='(97) DK' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mptu6f  1='(1) DAY' 2='(2) WEEK' 3='(3) MONTH' 4='(4) YEAR'
                  5='(5) OTHER' 7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mpdc6f  99997='(99997) DK' 99998='(99998) MISSING'
                  99999='(99999) INAPP' ;
  VALUE j2mpc7ff  99999997='(99999997) DK' 99999998='(99999998) MISSING'
                  99999999='(99999999) INAPP' ;
  VALUE j2mpdd7f  9996='(9996) MIXED DOSAGE' 9997='(9997) DK'
                  9998='(9998) MISSING' 9999='(9999) INAPP' ;
  VALUE j2mpdu7f  1='(01) MG' 2='(02) GRAMS' 3='(03) MCG' 4='(04) IU'
                  5='(05) MEQ' 6='(06) CC/ML' 7='(07) TEASPOON'
                  8='(08) TABLET' 9='(09) CAPSULE' 10='(10) PUFF/SQUIRT'
                  11='(11) UNIT' 12='(12) OTHER' 97='(97) DK'
                  98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mpr7ff  1='(1) ORAL (PO)' 2='(2) INHALED' 3='(3) TOPICAL'
                  4='(4) SUB Q/SUB C' 5='(5) INTRAMUSCULAR'
                  6='(6) SUBLINGUAL' 7='(7) OTHER' 97='(97) DK'
                  98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mpf7ff  97='(97) DK' 98='(98) REFUSED' 99='(99) INAPP' ;
  VALUE j2mpfu7f  1='(1) DAY' 2='(2) EVERY OTHER DAY' 3='(3) WEEK'
                  4='(4) MONTH' 5='(5) AS NEEDED (PRN)' 6='(6) OTHER'
                  7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mpt7ff  97='(97) DK' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mptu7f  1='(1) DAY' 2='(2) WEEK' 3='(3) MONTH' 4='(4) YEAR'
                  5='(5) OTHER' 7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mpdc7f  99997='(99997) DK' 99998='(99998) MISSING'
                  99999='(99999) INAPP' ;
  VALUE j2mpc8ff  99999997='(99999997) DK' 99999998='(99999998) MISSING'
                  99999999='(99999999) INAPP' ;
  VALUE j2mpdd8f  9996='(9996) MIXED DOSAGE' 9997='(9997) DK'
                  9998='(9998) MISSING' 9999='(9999) INAPP' ;
  VALUE j2mpdu8f  1='(01) MG' 2='(02) GRAMS' 3='(03) MCG' 4='(04) IU'
                  5='(05) MEQ' 6='(06) CC/ML' 7='(07) TEASPOON'
                  8='(08) TABLET' 9='(09) CAPSULE' 10='(10) PUFF/SQUIRT'
                  11='(11) UNIT' 12='(12) OTHER' 97='(97) DK'
                  98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mpr8ff  1='(1) ORAL (PO)' 2='(2) INHALED' 3='(3) TOPICAL'
                  4='(4) SUB Q/SUB C' 5='(5) INTRAMUSCULAR'
                  6='(6) SUBLINGUAL' 7='(7) OTHER' 97='(97) DK'
                  98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mpf8ff  97='(97) DK' 98='(98) REFUSED' 99='(99) INAPP' ;
  VALUE j2mpfu8f  1='(1) DAY' 2='(2) EVERY OTHER DAY' 3='(3) WEEK'
                  4='(4) MONTH' 5='(5) AS NEEDED (PRN)' 6='(6) OTHER'
                  7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mpt8ff  97='(97) DK' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mptu8f  1='(1) DAY' 2='(2) WEEK' 3='(3) MONTH' 4='(4) YEAR'
                  5='(5) OTHER' 7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mpdc8f  99997='(99997) DK' 99998='(99998) MISSING'
                  99999='(99999) INAPP' ;
  VALUE j2mpc9ff  99999997='(99999997) DK' 99999998='(99999998) MISSING'
                  99999999='(99999999) INAPP' ;
  VALUE j2mpdd9f  9996='(9996) MIXED DOSAGE' 9997='(9997) DK'
                  9998='(9998) MISSING' 9999='(9999) INAPP' ;
  VALUE j2mpdu9f  1='(01) MG' 2='(02) GRAMS' 3='(03) MCG' 4='(04) IU'
                  5='(05) MEQ' 6='(06) CC/ML' 7='(07) TEASPOON'
                  8='(08) TABLET' 9='(09) CAPSULE' 10='(10) PUFF/SQUIRT'
                  11='(11) UNIT' 12='(12) OTHER' 97='(97) DK'
                  98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mpr9ff  1='(1) ORAL (PO)' 2='(2) INHALED' 3='(3) TOPICAL'
                  4='(4) SUB Q/SUB C' 5='(5) INTRAMUSCULAR'
                  6='(6) SUBLINGUAL' 7='(7) OTHER' 97='(97) DK'
                  98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mpf9ff  97='(97) DK' 98='(98) REFUSED' 99='(99) INAPP' ;
  VALUE j2mpfu9f  1='(1) DAY' 2='(2) EVERY OTHER DAY' 3='(3) WEEK'
                  4='(4) MONTH' 5='(5) AS NEEDED (PRN)' 6='(6) OTHER'
                  7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mpt9ff  97='(97) DK' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mptu9f  1='(1) DAY' 2='(2) WEEK' 3='(3) MONTH' 4='(4) YEAR'
                  5='(5) OTHER' 7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mpdc9f  99997='(99997) DK' 99998='(99998) MISSING'
                  99999='(99999) INAPP' ;
  VALUE j2mpc10f  99999997='(99999997) DK' 99999998='(99999998) MISSING'
                  99999999='(99999999) INAPP' ;
  VALUE j2mpdd0f  9996='(9996) MIXED DOSAGE' 9997='(9997) DK'
                  9998='(9998) MISSING' 9999='(9999) INAPP' ;
  VALUE j2mpdu0f  1='(01) MG' 2='(02) GRAMS' 3='(03) MCG' 4='(04) IU'
                  5='(05) MEQ' 6='(06) CC/ML' 7='(07) TEASPOON'
                  8='(08) TABLET' 9='(09) CAPSULE' 10='(10) PUFF/SQUIRT'
                  11='(11) UNIT' 12='(12) OTHER' 97='(97) DK'
                  98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mpr10f  1='(1) ORAL (PO)' 2='(2) INHALED' 3='(3) TOPICAL'
                  4='(4) SUB Q/SUB C' 5='(5) INTRAMUSCULAR'
                  6='(6) SUBLINGUAL' 7='(7) OTHER' 97='(97) DK'
                  98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mpf10f  97='(97) DK' 98='(98) REFUSED' 99='(99) INAPP' ;
  VALUE j2mpfu0f  1='(1) DAY' 2='(2) EVERY OTHER DAY' 3='(3) WEEK'
                  4='(4) MONTH' 5='(5) AS NEEDED (PRN)' 6='(6) OTHER'
                  7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mpt10f  97='(97) DK' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mptu0f  1='(1) DAY' 2='(2) WEEK' 3='(3) MONTH' 4='(4) YEAR'
                  5='(5) OTHER' 7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mpdc0f  99997='(99997) DK' 99998='(99998) MISSING'
                  99999='(99999) INAPP' ;
  VALUE j2mpc11f  99999997='(99999997) DK' 99999998='(99999998) MISSING'
                  99999999='(99999999) INAPP' ;
  VALUE j2mpd10f  9996='(9996) MIXED DOSAGE' 9997='(9997) DK'
                  9998='(9998) MISSING' 9999='(9999) INAPP' ;
  VALUE j2mpd11f  1='(01) MG' 2='(02) GRAMS' 3='(03) MCG' 4='(04) IU'
                  5='(05) MEQ' 6='(06) CC/ML' 7='(07) TEASPOON'
                  8='(08) TABLET' 9='(09) CAPSULE' 10='(10) PUFF/SQUIRT'
                  11='(11) UNIT' 12='(12) OTHER' 97='(97) DK'
                  98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mpr11f  1='(1) ORAL (PO)' 2='(2) INHALED' 3='(3) TOPICAL'
                  4='(4) SUB Q/SUB C' 5='(5) INTRAMUSCULAR'
                  6='(6) SUBLINGUAL' 7='(7) OTHER' 97='(97) DK'
                  98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mpf11f  97='(97) DK' 98='(98) REFUSED' 99='(99) INAPP' ;
  VALUE j2mpf12f  1='(1) DAY' 2='(2) EVERY OTHER DAY' 3='(3) WEEK'
                  4='(4) MONTH' 5='(5) AS NEEDED (PRN)' 6='(6) OTHER'
                  7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mpt11f  97='(97) DK' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mpt12f  1='(1) DAY' 2='(2) WEEK' 3='(3) MONTH' 4='(4) YEAR'
                  5='(5) OTHER' 7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mpd12f  99997='(99997) DK' 99998='(99998) MISSING'
                  99999='(99999) INAPP' ;
  VALUE j2mpc12f  99999997='(99999997) DK' 99999998='(99999998) MISSING'
                  99999999='(99999999) INAPP' ;
  VALUE j2mpd13f  9996='(9996) MIXED DOSAGE' 9997='(9997) DK'
                  9998='(9998) MISSING' 9999='(9999) INAPP' ;
  VALUE j2mpd14f  1='(01) MG' 2='(02) GRAMS' 3='(03) MCG' 4='(04) IU'
                  5='(05) MEQ' 6='(06) CC/ML' 7='(07) TEASPOON'
                  8='(08) TABLET' 9='(09) CAPSULE' 10='(10) PUFF/SQUIRT'
                  11='(11) UNIT' 12='(12) OTHER' 97='(97) DK'
                  98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mpr12f  1='(1) ORAL (PO)' 2='(2) INHALED' 3='(3) TOPICAL'
                  4='(4) SUB Q/SUB C' 5='(5) INTRAMUSCULAR'
                  6='(6) SUBLINGUAL' 7='(7) OTHER' 97='(97) DK'
                  98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mpf13f  97='(97) DK' 98='(98) REFUSED' 99='(99) INAPP' ;
  VALUE j2mpf14f  1='(1) DAY' 2='(2) EVERY OTHER DAY' 3='(3) WEEK'
                  4='(4) MONTH' 5='(5) AS NEEDED (PRN)' 6='(6) OTHER'
                  7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mpt13f  97='(97) DK' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mpt14f  1='(1) DAY' 2='(2) WEEK' 3='(3) MONTH' 4='(4) YEAR'
                  5='(5) OTHER' 7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mpd15f  99997='(99997) DK' 99998='(99998) MISSING'
                  99999='(99999) INAPP' ;
  VALUE j2mpc13f  99999997='(99999997) DK' 99999998='(99999998) MISSING'
                  99999999='(99999999) INAPP' ;
  VALUE j2mpd16f  9996='(9996) MIXED DOSAGE' 9997='(9997) DK'
                  9998='(9998) MISSING' 9999='(9999) INAPP' ;
  VALUE j2mpd17f  1='(01) MG' 2='(02) GRAMS' 3='(03) MCG' 4='(04) IU'
                  5='(05) MEQ' 6='(06) CC/ML' 7='(07) TEASPOON'
                  8='(08) TABLET' 9='(09) CAPSULE' 10='(10) PUFF/SQUIRT'
                  11='(11) UNIT' 12='(12) OTHER' 97='(97) DK'
                  98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mpr13f  1='(1) ORAL (PO)' 2='(2) INHALED' 3='(3) TOPICAL'
                  4='(4) SUB Q/SUB C' 5='(5) INTRAMUSCULAR'
                  6='(6) SUBLINGUAL' 7='(7) OTHER' 97='(97) DON''T KNODK'
                  98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mpf15f  97='(97) DK' 98='(98) REFUSED' 99='(99) INAPP' ;
  VALUE j2mpf16f  1='(1) DAY' 2='(2) EVERY OTHER DAY' 3='(3) WEEK'
                  4='(4) MONTH' 5='(5) AS NEEDED (PRN)' 6='(6) OTHER'
                  7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mpt15f  97='(97) DK' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mpt16f  1='(1) DAY' 2='(2) WEEK' 3='(3) MONTH' 4='(4) YEAR'
                  5='(5) OTHER' 7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mbpd    1='(1) YES' 2='(2) NO' 7='(7) DK' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2mbpc    7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mchd    1='(1) YES' 2='(2) NO' 7='(7) DK' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2mchc    7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mdpd    1='(1) YES' 2='(2) NO' 7='(7) DK' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2mdpc    7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mcod    1='(1) YES' 2='(2) NO' 7='(7) DK' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2mcoc    7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mshd    1='(1) YES' 2='(2) NO' 7='(7) DK' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2mshc    7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mqm     97='(97) DK' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mqmv    1='(1) YES' 2='(2) NO' 7='(7) DK' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2mqc1ff  99999997='(99999997) DK' 99999998='(99999998) MISSING'
                  99999999='(99999999) INAPP' ;
  VALUE j2mqdd1f  9996='(9996) MIXED DOSAGE' 9997='(9997) DK'
                  9998='(9998) MISSING' 9999='(9999) INAPP' ;
  VALUE j2mqdu1f  1='(01) MG' 2='(02) GRAMS' 3='(03) MCG' 4='(04) IU'
                  5='(05) MEQ' 6='(06) CC/ML' 7='(07) TEASPOON'
                  8='(08) TABLET' 9='(09) CAPSULE' 10='(10) PUFF/SQUIRT'
                  11='(11) UNIT' 12='(12) OTHER' 97='(97) DK'
                  98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mqr1ff  1='(1) ORAL (PO)' 2='(2) INHALED' 3='(3) TOPICAL'
                  4='(4) SUB Q/SUB C' 5='(5) INTRAMUSCULAR'
                  6='(6) SUBLINGUAL' 7='(7) OTHER' 97='(97) DK'
                  98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mqf1ff  97='(97) DK' 98='(98) REFUSED' 99='(99) INAPP' ;
  VALUE j2mqfu1f  1='(1) DAY' 2='(2) EVERY OTHER DAY' 3='(3) WEEK'
                  4='(4) MONTH' 5='(5) AS NEEDED (PRN)' 6='(6) OTHER'
                  7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mqt1ff  97='(97) DK' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mqtu1f  1='(1) DAY' 2='(2) WEEK' 3='(3) MONTH' 4='(4) YEAR'
                  5='(5) OTHER' 7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mqdc1f  99997='(99997) DK' 99998='(99998) MISSING'
                  99999='(99999) INAPP' ;
  VALUE j2mqcs    1='(1) YES' 2='(2) NO' 7='(7) DK' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2mqc2ff  99999997='(99999997) DK' 99999998='(99999998) MISSING'
                  99999999='(99999999) INAPP' ;
  VALUE j2mqdd2f  9996='(9996) MIXED DOSAGE' 9997='(9997) DK'
                  9998='(9998) MISSING' 9999='(9999) INAPP' ;
  VALUE j2mqdu2f  1='(01) MG' 2='(02) GRAMS' 3='(03) MCG' 4='(04) IU'
                  5='(05) MEQ' 6='(06) CC/ML' 7='(07) TEASPOON'
                  8='(08) TABLET' 9='(09) CAPSULE' 10='(10) PUFF/SQUIRT'
                  11='(11) UNIT' 12='(12) OTHER' 97='(97) DK'
                  98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mqr2ff  1='(1) ORAL (PO)' 2='(2) INHALED' 3='(3) TOPICAL'
                  4='(4) SUB Q/SUB C' 5='(5) INTRAMUSCULAR'
                  6='(6) SUBLINGUAL' 7='(7) OTHER' 97='(97) DK'
                  98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mqf2ff  97='(97) DK' 98='(98) REFUSED' 99='(99) INAPP' ;
  VALUE j2mqfu2f  1='(1) DAY' 2='(2) EVERY OTHER DAY' 3='(3) WEEK'
                  4='(4) MONTH' 5='(5) AS NEEDED (PRN)' 6='(6) OTHER'
                  7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mqt2ff  97='(97) DK' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mqtu2f  1='(1) DAY' 2='(2) WEEK' 3='(3) MONTH' 4='(4) YEAR'
                  5='(5) OTHER' 7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mqdc2f  99997='(99997) DK' 99998='(99998) MISSING'
                  99999='(99999) INAPP' ;
  VALUE j2mqc3ff  99999997='(99999997) DK' 99999998='(99999998) MISSING'
                  99999999='(99999999) INAPP' ;
  VALUE j2mqdd3f  9996='(9996) MIXED DOSAGE' 9997='(9997) DK'
                  9998='(9998) MISSING' 9999='(9999) INAPP' ;
  VALUE j2mqdu3f  1='(01) MG' 2='(02) GRAMS' 3='(03) MCG' 4='(04) IU'
                  5='(05) MEQ' 6='(06) CC/ML' 7='(07) TEASPOON'
                  8='(08) TABLET' 9='(09) CAPSULE' 10='(10) PUFF/SQUIRT'
                  11='(11) UNIT' 12='(12) OTHER' 97='(97) DK'
                  98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mqr3ff  1='(1) ORAL (PO)' 2='(2) INHALED' 3='(3) TOPICAL'
                  4='(4) SUB Q/SUB C' 5='(5) INTRAMUSCULAR'
                  6='(6) SUBLINGUAL' 7='(7) OTHER' 97='(97) DK'
                  98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mqf3ff  97='(97) DK' 98='(98) REFUSED' 99='(99) INAPP' ;
  VALUE j2mqfu3f  1='(1) DAY' 2='(2) EVERY OTHER DAY' 3='(3) WEEK'
                  4='(4) MONTH' 5='(5) AS NEEDED (PRN)' 6='(6) OTHER'
                  7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mqt3ff  97='(97) DK' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mqtu3f  1='(1) DAY' 2='(2) WEEK' 3='(3) MONTH' 4='(4) YEAR'
                  5='(5) OTHER' 7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mqdc3f  99997='(99997) DK' 99998='(99998) MISSING'
                  99999='(99999) INAPP' ;
  VALUE j2mqc4ff  99999997='(99999997) DK' 99999998='(99999998) MISSING'
                  99999999='(99999999) INAPP' ;
  VALUE j2mqdd4f  9996='(9996) MIXED DOSAGE' 9997='(9997) DK'
                  9998='(9998) MISSING' 9999='(9999) INAPP' ;
  VALUE j2mqdu4f  1='(01) MG' 2='(02) GRAMS' 3='(03) MCG' 4='(04) IU'
                  5='(05) MEQ' 6='(06) CC/ML' 7='(07) TEASPOON'
                  8='(08) TABLET' 9='(09) CAPSULE' 10='(10) PUFF/SQUIRT'
                  11='(11) UNIT' 12='(12) OTHER' 97='(97) DK'
                  98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mqr4ff  1='(1) ORAL (PO)' 2='(2) INHALED' 3='(3) TOPICAL'
                  4='(4) SUB Q/SUB C' 5='(5) INTRAMUSCULAR'
                  6='(6) SUBLINGUAL' 7='(7) OTHER' 97='(97) DK'
                  98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mqf4ff  97='(97) DK' 98='(98) REFUSED' 99='(99) INAPP' ;
  VALUE j2mqfu4f  1='(1) DAY' 2='(2) EVERY OTHER DAY' 3='(3) WEEK'
                  4='(4) MONTH' 5='(5) AS NEEDED (PRN)' 6='(6) OTHER'
                  7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mqt4ff  97='(97) DK' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mqtu4f  1='(1) DAY' 2='(2) WEEK' 3='(3) MONTH' 4='(4) YEAR'
                  5='(5) OTHER' 7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mqdc4f  99997='(99997) DK' 99998='(99998) MISSING'
                  99999='(99999) INAPP' ;
  VALUE j2mqc5ff  99999997='(99999997) DK' 99999998='(99999998) MISSING'
                  99999999='(99999999) INAPP' ;
  VALUE j2mqdd5f  9996='(9996) MIXED DOSAGE' 9997='(9997) DK'
                  9998='(9998) MISSING' 9999='(9999) INAPP' ;
  VALUE j2mqdu5f  1='(01) MG' 2='(02) GRAMS' 3='(03) MCG' 4='(04) IU'
                  5='(05) MEQ' 6='(06) CC/ML' 7='(07) TEASPOON'
                  8='(08) TABLET' 9='(09) CAPSULE' 10='(10) PUFF/SQUIRT'
                  11='(11) UNIT' 12='(12) OTHER' 97='(97) DK'
                  98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mqr5ff  1='(1) ORAL (PO)' 2='(2) INHALED' 3='(3) TOPICAL'
                  4='(4) SUB Q/SUB C' 5='(5) INTRAMUSCULAR'
                  6='(6) SUBLINGUAL' 7='(7) OTHER' 97='(97) DK'
                  98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mqf5ff  97='(97) DK' 98='(98) REFUSED' 99='(99) INAPP' ;
  VALUE j2mqfu5f  1='(1) DAY' 2='(2) EVERY OTHER DAY' 3='(3) WEEK'
                  4='(4) MONTH' 5='(5) AS NEEDED (PRN)' 6='(6) OTHER'
                  7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mqt5ff  97='(97) DK' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mqtu5f  1='(1) DAY' 2='(2) WEEK' 3='(3) MONTH' 4='(4) YEAR'
                  5='(5) OTHER' 7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mqdc5f  99997='(99997) DK' 99998='(99998) MISSING'
                  99999='(99999) INAPP' ;
  VALUE j2mqc6ff  99999997='(99999997) DK' 99999998='(99999998) MISSING'
                  99999999='(99999999) INAPP' ;
  VALUE j2mqdd6f  9996='(9996) MIXED DOSAGE' 9997='(9997) DK'
                  9998='(9998) MISSING' 9999='(9999) INAPP' ;
  VALUE j2mqdu6f  1='(01) MG' 2='(02) GRAMS' 3='(03) MCG' 4='(04) IU'
                  5='(05) MEQ' 6='(06) CC/ML' 7='(07) TEASPOON'
                  8='(08) TABLET' 9='(09) CAPSULE' 10='(10) PUFF/SQUIRT'
                  11='(11) UNIT' 12='(12) OTHER' 97='(97) DK'
                  98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mqr6ff  1='(1) ORAL (PO)' 2='(2) INHALED' 3='(3) TOPICAL'
                  4='(4) SUB Q/SUB C' 5='(5) INTRAMUSCULAR'
                  6='(6) SUBLINGUAL' 7='(7) OTHER' 97='(97) DK'
                  98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mqf6ff  97='(97) DK' 98='(98) REFUSED' 99='(99) INAPP' ;
  VALUE j2mqfu6f  1='(1) DAY' 2='(2) EVERY OTHER DAY' 3='(3) WEEK'
                  4='(4) MONTH' 5='(5) AS NEEDED (PRN)' 6='(6) OTHER'
                  7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mqt6ff  97='(97) DK' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mqtu6f  1='(1) DAY' 2='(2) WEEK' 3='(3) MONTH' 4='(4) YEAR'
                  5='(5) OTHER' 7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mqdc6f  99997='(99997) DK' 99998='(99998) MISSING'
                  99999='(99999) INAPP' ;
  VALUE j2mqc7ff  99999997='(99999997) DK' 99999998='(99999998) MISSING'
                  99999999='(99999999) INAPP' ;
  VALUE j2mqdd7f  9996='(9996) MIXED DOSAGE' 9997='(9997) DK'
                  9998='(9998) MISSING' 9999='(9999) INAPP' ;
  VALUE j2mqdu7f  1='(01) MG' 2='(02) GRAMS' 3='(03) MCG' 4='(04) IU'
                  5='(05) MEQ' 6='(06) CC/ML' 7='(07) TEASPOON'
                  8='(08) TABLET' 9='(09) CAPSULE' 10='(10) PUFF/SQUIRT'
                  11='(11) UNIT' 12='(12) OTHER' 97='(97) DK'
                  98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mqr7ff  1='(1) ORAL (PO)' 2='(2) INHALED' 3='(3) TOPICAL'
                  4='(4) SUB Q/SUB C' 5='(5) INTRAMUSCULAR'
                  6='(6) SUBLINGUAL' 7='(7) OTHER' 97='(97) DK'
                  98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mqf7ff  97='(97) DK' 98='(98) REFUSED' 99='(99) INAPP' ;
  VALUE j2mqfu7f  1='(1) DAY' 2='(2) EVERY OTHER DAY' 3='(3) WEEK'
                  4='(4) MONTH' 5='(5) AS NEEDED (PRN)' 6='(6) OTHER'
                  7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mqt7ff  97='(97) DK' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mqtu7f  1='(1) DAY' 2='(2) WEEK' 3='(3) MONTH' 4='(4) YEAR'
                  5='(5) OTHER' 7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mqdc7f  99997='(99997) DK' 99998='(99998) MISSING'
                  99999='(99999) INAPP' ;
  VALUE j2mqc8ff  99999997='(99999997) DK' 99999998='(99999998) MISSING'
                  99999999='(99999999) INAPP' ;
  VALUE j2mqdd8f  9996='(9996) MIXED DOSAGE' 9997='(9997) DK'
                  9998='(9998) MISSING' 9999='(9999) INAPP' ;
  VALUE j2mqdu8f  1='(01) MG' 2='(02) GRAMS' 3='(03) MCG' 4='(04) IU'
                  5='(05) MEQ' 6='(06) CC/ML' 7='(07) TEASPOON'
                  8='(08) TABLET' 9='(09) CAPSULE' 10='(10) PUFF/SQUIRT'
                  11='(11) UNIT' 12='(12) OTHER' 97='(97) DK'
                  98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mqr8ff  1='(1) ORAL (PO)' 2='(2) INHALED' 3='(3) TOPICAL'
                  4='(4) SUB Q/SUB C' 5='(5) INTRAMUSCULAR'
                  6='(6) SUBLINGUAL' 7='(7) OTHER' 97='(97) DK'
                  98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mqf8ff  97='(97) DK' 98='(98) REFUSED' 99='(99) INAPP' ;
  VALUE j2mqfu8f  1='(1) DAY' 2='(2) EVERY OTHER DAY' 3='(3) WEEK'
                  4='(4) MONTH' 5='(5) AS NEEDED (PRN)' 6='(6) OTHER'
                  7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mqt8ff  97='(97) DK' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mqtu8f  1='(1) DAY' 2='(2) WEEK' 3='(3) MONTH' 4='(4) YEAR'
                  5='(5) OTHER' 7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mqdc8f  99997='(99997) DK' 99998='(99998) MISSING'
                  99999='(99999) INAPP' ;
  VALUE j2mqc9ff  99999997='(99999997) DK' 99999998='(99999998) MISSING'
                  99999999='(99999999) INAPP' ;
  VALUE j2mqdd9f  9996='(9996) MIXED DOSAGE' 9997='(9997) DK'
                  9998='(9998) MISSING' 9999='(9999) INAPP' ;
  VALUE j2mqdu9f  1='(01) MG' 2='(02) GRAMS' 3='(03) MCG' 4='(04) IU'
                  5='(05) MEQ' 6='(06) CC/ML' 7='(07) TEASPOON'
                  8='(08) TABLET' 9='(09) CAPSULE' 10='(10) PUFF/SQUIRT'
                  11='(11) UNIT' 12='(12) OTHER' 97='(97) DK'
                  98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mqr9ff  1='(1) ORAL (PO)' 2='(2) INHALED' 3='(3) TOPICAL'
                  4='(4) SUB Q/SUB C' 5='(5) INTRAMUSCULAR'
                  6='(6) SUBLINGUAL' 7='(7) OTHER' 97='(97) DK'
                  98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mqf9ff  97='(97) DK' 98='(98) REFUSED' 99='(99) INAPP' ;
  VALUE j2mqfu9f  1='(1) DAY' 2='(2) EVERY OTHER DAY' 3='(3) WEEK'
                  4='(4) MONTH' 5='(5) AS NEEDED (PRN)' 6='(6) OTHER'
                  7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mqt9ff  97='(97) DK' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mqtu9f  1='(1) DAY' 2='(2) WEEK' 3='(3) MONTH' 4='(4) YEAR'
                  5='(5) OTHER' 7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mqdc9f  99997='(99997) DK' 99998='(99998) MISSING'
                  99999='(99999) INAPP' ;
  VALUE j2mqc10f  99999997='(99999997) DK' 99999998='(99999998) MISSING'
                  99999999='(99999999) INAPP' ;
  VALUE j2mqdd0f  9996='(9996) MIXED DOSAGE' 9997='(9997) DK'
                  9998='(9998) MISSING' 9999='(9999) INAPP' ;
  VALUE j2mqdu0f  1='(01) MG' 2='(02) GRAMS' 3='(03) MCG' 4='(04) IU'
                  5='(05) MEQ' 6='(06) CC/ML' 7='(07) TEASPOON'
                  8='(08) TABLET' 9='(09) CAPSULE' 10='(10) PUFF/SQUIRT'
                  11='(11) UNIT' 12='(12) OTHER' 97='(97) DK'
                  98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mqr10f  1='(1) ORAL (PO)' 2='(2) INHALED' 3='(3) TOPICAL'
                  4='(4) SUB Q/SUB C' 5='(5) INTRAMUSCULAR'
                  6='(6) SUBLINGUAL' 7='(7) OTHER' 97='(97) DK'
                  98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mqf10f  97='(97) DK' 98='(98) REFUSED' 99='(99) INAPP' ;
  VALUE j2mqfu0f  1='(1) DAY' 2='(2) EVERY OTHER DAY' 3='(3) WEEK'
                  4='(4) MONTH' 5='(5) AS NEEDED (PRN)' 6='(6) OTHER'
                  7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mqt10f  97='(97) DK' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mqtu0f  1='(1) DAY' 2='(2) WEEK' 3='(3) MONTH' 4='(4) YEAR'
                  5='(5) OTHER' 7='(7) DK' 8='(8) MISSING' 9='(9) INAPP' ;
  VALUE j2mqdc0f  99997='(99997) DK' 99998='(99998) MISSING'
                  99999='(99999) INAPP' ;
  VALUE j2ml      1='(1) YES' 2='(2) NO' 7='(7) DK' 8='(8) MISSING'
                  9='(9) INAPP' ;
  VALUE j2mlm     97='(97) DK' 98='(98) MISSING' 99='(99) INAPP' ;
  VALUE j2mlc1ff  99999997='(99999997) DK' 99999998='(99999998) MISSING'
                  99999999='(99999999) INAPP' ;
  VALUE j2mlc2ff  99999997='(99999997) DK' 99999998='(99999998) MISSING'
                  99999999='(99999999) INAPP' ;
  VALUE j2mlc3ff  99999997='(99999997) DK' 99999998='(99999998) MISSING'
                  99999999='(99999999) INAPP' ;
  VALUE j2mlc4ff  99999997='(99999997) DK' 99999998='(99999998) MISSING'
                  99999999='(99999999) INAPP' ;
  VALUE j2mlc5ff  99999997='(99999997) DK' 99999998='(99999998) MISSING'
                  99999999='(99999999) INAPP' ;
  VALUE j2mlc6ff  99999997='(99999997) DK' 99999998='(99999998) MISSING'
                  99999999='(99999999) INAPP' ;
  VALUE j2mlc7ff  99999997='(99999997) DK' 99999998='(99999998) MISSING'
                  99999999='(99999999) INAPP' ;
*/


* SAS DATA, INFILE, INPUT STATEMENTS;

DATA;
INFILE "data-filename" LRECL=2195;
INPUT
       MIDJA_IDS 1-8           J2CMONTH 9-10
        J2CYEAR 11-14           J1SQ1 15                J2CAGE 16-17
        J2Q1A 18                J2Q1AD 19               J2Q1B 20
        J2Q1BD 21               J2Q1C 22                J2Q1CD 23
        J2Q1D 24                J2Q1DD 25               J2Q1E 26
        J2Q1ED 27               J2Q1F 28                J2Q1FD 29
        J2Q1G 30                J2Q1GD 31               J2Q1H 32
        J2Q1HD 33               J2Q1I 34                J2Q1ID 35
        J2Q1J 36                J2Q1JD 37               J2Q1K 38
        J2Q1KD 39               J2Q1L 40                J2Q1LD 41
        J2Q1M 42                J2Q1MD 43               J2Q1N 44
        J2Q1ND 45               J2Q1O 46                J2Q1OD 47
        J2Q1P 48                J2Q1PD 49               J2Q1Q 50
        J2Q1QD 51               J2Q1R 52                J2Q1RD 53
        J2Q1S 54                J2Q1SD 55               J2Q1T 56
        J2Q1TD 57               J2Q1U 58                J2Q1UD 59
        J2Q1V 60                J2Q1VD 61               J2Q1W 62
        J2Q1WD 63               J2Q1X 64                J2Q1XD 65
        J2Q1Y 66                J2Q1YD 67               J2Q1Z 68
        J2Q1ZD 69               J2Q1AA 70               J2Q1AAD 71
        J2Q1BB 72               J2Q1BBD 73              J2Q1CC 74
        J2Q1CCD 75              J2Q1EE 76               J2Q1EED 77
        J2Q1FF 78               J2Q1FFD 79              J2QSYMN 80-81
        J2QSYMX 82              J2QSYMN2 83-84          J2QSYMX2 85
        J2Q2 86                 J2Q2A 87                J2Q2A2 88
        J2Q2B1 89               J2Q2B2 90               J2Q2B3 91
        J2Q2B4 92               J2Q2B5 93               J2Q2B6 94
        J2Q2B7 95               J2Q2B8 96               J2Q2B9 97
        J2Q2B10 98              J2Q3 99                 J2Q3AH 100
        J2Q3AEM 101             J2Q3AEMY 102-103        J2Q3ACEY 104-107
        J2Q3BH 108              J2Q3BEM 109             J2Q3BEMY 110-111
        J2Q3BCEY 112-115        J2Q4 116                J2Q4AH 117
        J2Q4AEM 118             J2Q4AEMY 119-120        J2Q4ACEY 121-124
        J2Q4BH 125              J2Q4BEM 126             J2Q4BEMY 127-128
        J2Q4BCEY 129-132        J2Q5 133                J2Q5AH 134
        J2Q5AEM 135             J2Q5AEMY 136-137        J2Q5ACEY 138-141
        J2Q5BH 142              J2Q5BEM 143             J2Q5BEMY 144-145
        J2Q5BCEY 146-149        J2Q6 150                J2Q6AH 151
        J2Q6AEM 152             J2Q6AEMY 153-154        J2Q6ACEY 155-158
        J2Q6BH 159              J2Q6BEM 160             J2Q6BEMY 161-162
        J2Q6BCEY 163-166        J2Q7AMPM 167            J2Q7H 168-169
        J2Q7M 170-171           J2Q8 172-174            J2Q9AMPM 175
        J2Q9H 176-177           J2Q9M 178-179           J2Q10H 180-181
        J2Q10M 182-183          J2Q11A 184              J2Q11B 185
        J2Q11C 186              J2Q11D 187              J2Q11E 188
        J2Q11F 189              J2Q11G 190              J2Q11H 191
        J2Q11I 192              J2Q11J 193              J2Q12 194
        J2Q13 195               J2Q14 196               J2Q15 197
        J2Q16 198               J2QSQ_S1 199            J2QSQ_S2 200
        J2QSQ_S3 201            J2QSQ_S4 202            J2QSQ_S5 203
        J2QSQ_S6 204            J2QSQ_S7 205            J2QSQ_GS 206-207
        J2Q17 208               J2Q18 209-210           J2Q19 211-212
        J2Q20 213-214           J2Q21 215-216           J2Q22 217-218
        J2Q23A 219              J2Q23B 220              J2Q23C 221
        J2Q23D 222              J2Q23E 223              J2Q23F 224
        J2Q23G 225              J2Q23H 226              J2Q23I 227
        J2Q24 228               J2Q26 229               J2Q27A 230-231
        J2Q27B 232-233          J2Q27C 234-235          J2Q28A 236-237
        J2Q28B 238-239          J2Q28C 240-241          J2Q28D 242-243
        J2Q29 244               J2Q30 245               J2Q31 246
        J2Q32 247               J2Q33 248               J2Q34A 249
        J2Q34B 250              J2Q34C 251              J2Q34D 252
        J2Q35 253               J2Q36 254               J2Q37M 255-256
        J2Q37Y 257-260          J2Q38 261               J2QMARR 262
        J2Q39 263               J2Q39AG 264             J2Q39AM 265-266
        J2Q39AY 267-270         J2Q39BG 271             J2Q39BM 272-273
        J2Q39BY 274-277         J2Q39CG 278             J2Q39CM 279-280
        J2Q39CY 281-284         J2Q40A 285              J2Q40A1 286-287
        J2Q40A3 288-289         J2Q40A4 290-291         J2Q40B 292
        J2Q40B1 293-294         J2Q40B3 295-296         J2Q40B4 297-298
        J2Q40C 299              J2Q40C1 300-301         J2Q40C3 302-303
        J2Q40C4 304-305         J2Q40D 306              J2Q40D1 307-308
        J2Q40D3 309-310         J2Q40D4 311-312         J2Q40E 313
        J2Q40E1 314-315         J2Q40E3 316-317         J2Q40E4 318-319
        J2Q40F 320              J2Q40F1 321-322         J2Q40F3 323-324
        J2Q40F4 325-326         J2Q40G 327              J2Q40G1 328-329
        J2Q40G3 330-331         J2Q40G4 332-333         J2Q41H 334
        J2Q41H1 335-336         J2Q41H3 337-338         J2Q41H4 339-340
        J2Q41I 341              J2Q41I1 342-343         J2Q41I3 344-345
        J2Q41I4 346-347         J2Q41J 348              J2Q41J1 349-350
        J2Q41J3 351-352         J2Q41J4 353-354         J2Q41K 355
        J2Q41K1 356-357         J2Q41K3 358-359         J2Q41K4 360-361
        J2Q41L 362              J2Q41L1 363-364         J2Q41L3 365-366
        J2Q41L4 367-368         J2Q41M 369              J2Q41M1 370-371
        J2Q41M3 372-373         J2Q41M4 374-375         J2Q41N 376
        J2Q41N1 377-378         J2Q41N3 379-380         J2Q41N4 381-382
        J2Q41O 383              J2Q41O1 384-385         J2Q41O3 386-387
        J2Q41O4 388-389         J2Q41P 390              J2Q41P1 391-392
        J2Q41P3 393-394         J2Q41P4 395-396         J2Q41Q 397
        J2Q41Q1 398-399         J2Q41Q3 400-401         J2Q41Q4 402-403
        J2Q41R 404              J2Q41R1 405-406         J2Q41R3 407-408
        J2Q41R4 409-410         J2Q41S 411              J2Q41S1 412-413
        J2Q41S3 414-415         J2Q41S4 416-417         J2Q41T 418
        J2Q41T1 419-420         J2Q41T3 421-422         J2Q41T4 423-424
        J2Q41U 425              J2Q41U1 426-427         J2Q41U3 428-429
        J2Q41U4 430-431         J2Q41V 432              J2Q41V1 433-434
        J2Q41V3 435-436         J2Q41V4 437-438         J2Q41W 439
        J2Q41W1 440-441         J2Q41W3 442-443         J2Q41W4 444-445
        J2Q41X 446              J2Q41X1 447-448         J2Q41X3 449-450
        J2Q41X4 451-452         J2Q41Y 453              J2Q41Y1 454-455
        J2Q41Y3 456-457         J2Q41Y4 458-459         J2Q42 460
        J2Q42AM 461-462         J2Q42AY 463-466         J2Q42BM 467-468
        J2Q42BY 469-472         J2Q42CM 473-474         J2Q42CY 475-478
        J2Q43A 479              J2Q43B 480              J2Q43C 481
        J2Q43D 482              J2Q43E 483              J2Q43F 484
        J2Q43G 485              J2Q43H 486              J2Q43I 487
        J2Q43J 488              J2Q43K 489              J2Q43L 490
        J2Q43M 491              J2Q43N 492              J2Q43O 493
        J2Q43P 494              J2Q43Q 495              J2Q43R 496
        J2Q43S 497              J2Q43T 498              J2QCESD 499-502 .1
        J2Q44A 503              J2Q44B 504              J2Q44C 505
        J2Q44D 506              J2Q44E 507              J2Q44F 508
        J2Q44G 509              J2Q44H 510              J2Q44I 511
        J2Q44J 512              J2Q44K 513              J2Q44L 514
        J2Q44M 515              J2Q44N 516              J2Q44O 517
        J2Q44P 518              J2Q44Q 519              J2Q44R 520
        J2Q44S 521              J2Q44T 522              J2QTA_AX 523-526 .1
        J2Q45A 527              J2Q45B 528              J2Q45C 529
        J2Q45D 530              J2Q45E 531              J2Q45F 532
        J2Q45G 533              J2Q45H 534              J2Q45I 535
        J2Q45J 536              J2Q45K 537              J2Q45L 538
        J2Q45M 539              J2Q45N 540              J2Q45O 541
        J2QTA_AG 542-545 .1     J2QTA_AT 546-549 .1     J2QTA_AR 550-553 .1
        J2Q46A1 554             J2Q46A2 555             J2Q46B1 556
        J2Q46B2 557             J2Q46C1 558             J2Q46C2 559
        J2Q46D1 560             J2Q46D2 561             J2Q46E1 562
        J2Q46E2 563             J2Q46F1 564             J2Q46F2 565
        J2Q46G1 566             J2Q46G2 567             J2Q46H1 568
        J2Q46H2 569             J2Q46I1 570             J2Q46I2 571
        J2Q46J1 572             J2Q46J2 573             J2Q46K1 574
        J2Q46K2 575             J2Q46L1 576             J2Q46L2 577
        J2Q46M1 578             J2Q46M2 579             J2Q46N1 580
        J2Q46N2 581             J2Q46O1 582             J2Q46O2 583
        J2Q46P1 584             J2Q46P2 585             J2Q46Q1 586
        J2Q46Q2 587             J2Q46R1 588             J2Q46R2 589
        J2Q46S1 590             J2Q46S2 591             J2Q46T1 592
        J2Q46T2 593             J2Q46U1 594             J2Q46U2 595
        J2Q46V1 596             J2Q46V2 597             J2Q46W1 598
        J2Q46W2 599             J2Q46X1 600             J2Q46X2 601
        J2Q46Y1 602             J2Q46Y2 603             J2Q46Z1 604
        J2Q46Z2 605             J2Q46AA1 606            J2Q46AA2 607
        J2Q46BB1 608            J2Q46BB2 609            J2Q46CC1 610
        J2Q46CC2 611            J2Q46DD1 612            J2Q46DD2 613
        J2Q46EE1 614            J2Q46EE2 615            J2Q46FF1 616
        J2Q46FF2 617            J2Q46HH1 618            J2Q46HH2 619
        J2Q46II1 620            J2Q46II2 621            J2Q46JJ1 622
        J2Q46JJ2 623            J2Q46KK1 624            J2Q46KK2 625
        J2Q46LL1 626            J2Q46LL2 627            J2Q46MM1 628
        J2Q46MM2 629            J2Q46NN1 630            J2Q46NN2 631
        J2Q46OO1 632            J2Q46OO2 633            J2Q46PP1 634
        J2Q46PP2 635            J2Q46QQ1 636            J2Q46QQ2 637
        J2Q46RR1 638            J2Q46RR2 639            J2Q46SS1 640
        J2Q46SS2 641            J2Q46TT1 642            J2Q46TT2 643
        J2Q46UU1 644            J2Q46UU2 645            J2Q46VV1 646
        J2Q46VV2 647            J2Q46WW1 648            J2Q46WW2 649
        J2Q47A 650-651          J2Q47B 652-653          J2Q47C 654-655
        J2Q47D 656-657          J2Q47E 658-659          J2Q47F 660-661
        J2Q47G 662-663          J2Q47H 664-665          J2Q47I 666-667
        J2Q47J 668-669          J2Q47K 670-671          J2Q47L 672-673
        J2QSO_PC 674-677 .1     J2QSO_PF 678-681 .1     J2QSO_PX 682-685 .1
        J2QSO_IW 686-689 .1     J2QSO_GW 690-693 .1     J2Q48A 694-695
        J2Q48B 696-697          J2Q48C 698-699          J2Q48D 700-701
        J2Q48E 702-703          J2Q48F 704-705          J2Q48G 706-707
        J2Q48H 708-709          J2Q48I 710-711          J2Q48J 712-713
        J2Q48K 714-715          J2Q48L 716-717          J2Q48M 718-719
        J2Q48N 720-721          J2Q48O 722-723          J2Q48P 724-725
        J2Q48Q 726-727          J2Q48R 728-729          J2Q48S 730-731
        J2Q48T 732-733          J2Q48U 734-735          J2QRISC 736-739 .1
        J2QSYMP 740-743 .1      J2QADJ 744-747 .1       J2Q49A 748
        J2Q49B 749              J2Q49C 750              J2Q49D 751
        J2Q49E 752              J2Q49F 753              J2Q49G 754
        J2Q49H 755              J2QSSCTR 756-759 .1     J2QCSCD4 760-763 .1
        J2QCSCD6 764-767 .1     J2QCSCP4 768-771 .1     J2QCSCP5 772-775 .1
        J2Q50A 776              J2Q50B 777              J2Q50C 778
        J2Q50D 779              J2Q50E 780              J2Q50F 781
        J2Q50G 782              J2Q50H 783              J2QSW_JP 784-787 .1
        J2Q51A 788              J2Q51B 789              J2Q51C 790
        J2Q51D 791              J2Q51E 792              J2Q51F 793
        J2Q51G 794              J2Q51H 795              J2Q51I 796
        J2Q51J 797              J2Q51K 798              J2Q51L 799
        J2Q51M 800              J2Q51N 801              J2Q51O 802
        J2Q51P 803              J2Q51Q 804              J2Q52 805
        J2Q541 806              J2Q542 807              J2Q543 808
        J2Q544 809              J2Q545 810              J2Q546 811
        J2Q547 812              J2Q548 813              J2Q549 814
        J2Q5410 815             J2Q5411 816             J2Q5412 817
        J2Q5413 818             J2Q5414 819             J2Q5415 820
        J2Q5416 821             J2Q5417 822             J2Q5418 823
        J2Q5419 824             J2Q5420 825             J2Q5421 826
        J2Q5422 827             J2QJC_SD 828-831 .1     J2QJC_DA 832-835 .1
        J2QJC_DL 836-839 .1     J2QJC_PD 840-843 .1     J2QJC_SS 844-847 .1
        J2QJC_CS 848-851 .1     J2CLMDAY 852            J2CLMTH 853-854
        J2CLMTM 855-856         J2CHT 857-861 .1        J2CWT 862-866 .1
        J2CBMI 867-875 .2       J2CWST 876-880 .1       J2CHIP1 881-885 .1
        J2CHIP2 886-890 .1      J2CHIPCM 891            J2CWHR 892-900 .2
        J2CBPS1 901-903         J2CBPD1 904-906         J2CBPS2 907-909
        J2CBPD2 910-912         J2CBPS3 913-915         J2CBPD3 916-918
        J2CBPS23 919-921        J2CBPD23 922-924        J2CBLD 925
        J2CBLDTH 926-927        J2CBLDTM 928-929        J2CCCTH 930-931
        J2CCCTM 932-933         J2CCSSTH 934-935        J2CCSSTM 936-937
        J2CFCTH 938-939         J2CFCTM 940-941         J2CFSSTH 942-943
        J2CFSSTM 944-945        J2CLMBLD 946-950 .2     J2CBLDCTC 951-952
        J2CBLDSSC 953-955       J2CBLDCTF 956-958       J2CBLDSSF 959-961
        J2BCHOL 962-964         J2BHDL 965-967          J2BHDLA 968-970
        J2BRTHDL 971-977 .2     J2BRTHDA 978-984 .2     J2BDHEAS 985-991 .2
        J2BDHEA 992-998 .2      J2BSCREA 999-1003 .1    J2BIL6 1004-1011 .2
        J2BSIL6R 1012-1016      J2BFGN 1017-1019        J2BCRP 1020-1027 .2
        J2CHBA1C 1028-1031 .1   J2BHA1CA 1032-1035 .1   J2CTCHOL 1036-1038
        J2CHDL 1039-1041        J2CLDL 1042-1044        J2CTRIG 1045-1047
        J2CRTHDL 1048-1051 .2   J2CGOT 1052-1054        J2CGPT 1055-1057
        J2CGGTP 1058-1060       J2CSURIC 1061-1063 .1   J2CUREA 1064-1067 .1
        J2CWBC 1068-1069        J2CRBC 1070-1072        J2CHGB 1073-1076 .1
        J2CHTC 1077-1083 .1     J2CMCV 1084-1088 .1     J2CMCH 1089-1092 .1
        J2CMCHC 1093-1096 .1    J2CPLT 1097-1100 .1     J2SSAL 1101
        J2SCVSC1 1102-1103      J2CSCSEQ 1104           J2SD1MNH 1105-1106
        J2SD1MNM 1107-1108      J2SD1MDH 1109-1110      J2SD1MDM 1111-1112
        J2SD1EVH 1113-1114      J2SD1EVM 1115-1116      J2SD2MNH 1117-1118
        J2SD2MNM 1119-1120      J2SD2MDH 1121-1122      J2SD2MDM 1123-1124
        J2SD2EVH 1125-1126      J2SD2EVM 1127-1128      J2SD3MNH 1129-1130
        J2SD3MNM 1131-1132      J2SD3MDH 1133-1134      J2SD3MDM 1135-1136
        J2SD3EVH 1137-1138      J2SD3EVM 1139-1140      J2SCDAY1 1141
        J2SCDAY2 1142           J2SCDAY3 1143           J2BSCD11 1144-1153 .2
        J2BSCD12 1154-1163 .2   J2BSCD13 1164-1173 .2   J2BSCD21 1174-1183 .2
        J2BSCD22 1184-1193 .2   J2BSCD23 1194-1203 .2   J2BSCD31 1204-1213 .2
        J2BSCD32 1214-1223 .2   J2BSCD33 1224-1233 .2   J2MPMD 1234
        J2MQMD 1235             J2MPM 1236-1237         J2MPC1 1238-1245
        J2MPDD1 1246-1255 .2    J2MPDU1 1256-1257       J2MPR1 1258-1259
        J2MPF1 1260-1261        J2MPFU1 1262            J2MPT1 1263-1269 .1
        J2MPTU1 1270            J2MPDC1 1271-1275       J2MPC2 1276-1283
        J2MPDD2 1284-1293 .2    J2MPDU2 1294-1295       J2MPR2 1296-1297
        J2MPF2 1298-1299        J2MPFU2 1300            J2MPT2 1301-1307 .1
        J2MPTU2 1308            J2MPDC2 1309-1313       J2MPC3 1314-1321
        J2MPDD3 1322-1332 .2    J2MPDU3 1333-1334       J2MPR3 1335-1336
        J2MPF3 1337-1338        J2MPFU3 1339            J2MPT3 1340-1346 .1
        J2MPTU3 1347            J2MPDC3 1348-1352       J2MPC4 1353-1360
        J2MPDD4 1361-1371 .2    J2MPDU4 1372-1373       J2MPR4 1374-1375
        J2MPF4 1376-1377        J2MPFU4 1378            J2MPT4 1379-1385 .1
        J2MPTU4 1386            J2MPDC4 1387-1391       J2MPC5 1392-1399
        J2MPDD5 1400-1410 .2    J2MPDU5 1411-1412       J2MPR5 1413-1414
        J2MPF5 1415-1416        J2MPFU5 1417            J2MPT5 1418-1424 .1
        J2MPTU5 1425            J2MPDC5 1426-1430       J2MPC6 1431-1438
        J2MPDD6 1439-1449 .2    J2MPDU6 1450-1451       J2MPR6 1452-1453
        J2MPF6 1454-1455        J2MPFU6 1456            J2MPT6 1457-1463 .1
        J2MPTU6 1464            J2MPDC6 1465-1469       J2MPC7 1470-1477
        J2MPDD7 1478-1488 .2    J2MPDU7 1489-1490       J2MPR7 1491-1492
        J2MPF7 1493-1494        J2MPFU7 1495            J2MPT7 1496-1502 .1
        J2MPTU7 1503            J2MPDC7 1504-1508       J2MPC8 1509-1516
        J2MPDD8 1517-1527 .2    J2MPDU8 1528-1529       J2MPR8 1530-1531
        J2MPF8 1532-1533        J2MPFU8 1534            J2MPT8 1535-1541 .1
        J2MPTU8 1542            J2MPDC8 1543-1547       J2MPC9 1548-1555
        J2MPDD9 1556-1566 .2    J2MPDU9 1567-1568       J2MPR9 1569-1570
        J2MPF9 1571-1572        J2MPFU9 1573            J2MPT9 1574-1580 .1
        J2MPTU9 1581            J2MPDC9 1582-1586       J2MPC10 1587-1594
        J2MPDD10 1595-1605 .2   J2MPDU10 1606-1607      J2MPR10 1608-1609
        J2MPF10 1610-1611       J2MPFU10 1612           J2MPT10 1613-1619 .1
        J2MPTU10 1620           J2MPDC10 1621-1625      J2MPC11 1626-1633
        J2MPDD11 1634-1644 .2   J2MPDU11 1645-1646      J2MPR11 1647-1648
        J2MPF11 1649-1650       J2MPFU11 1651           J2MPT11 1652-1658 .1
        J2MPTU11 1659           J2MPDC11 1660-1664      J2MPC12 1665-1672
        J2MPDD12 1673-1683 .2   J2MPDU12 1684-1685      J2MPR12 1686-1687
        J2MPF12 1688-1689       J2MPFU12 1690           J2MPT12 1691-1697 .1
        J2MPTU12 1698           J2MPDC12 1699-1703      J2MPC13 1704-1711
        J2MPDD13 1712-1722 .2   J2MPDU13 1723-1724      J2MPR13 1725-1726
        J2MPF13 1727-1728       J2MPFU13 1729           J2MPT13 1730-1736
        J2MPTU13 1737           J2MPDC13 1738-1742      J2MBPD 1743
        J2MBPC 1744             J2MCHD 1745             J2MCHC 1746
        J2MDPD 1747             J2MDPC 1748             J2MCOD 1749
        J2MCOC 1750             J2MSHD 1751             J2MSHC 1752
        J2MQM 1753-1754         J2MQMV 1755             J2MQC1 1756-1763
        J2MQDD1 1764-1773 .2    J2MQDU1 1774-1775       J2MQR1 1776-1777
        J2MQF1 1778-1779        J2MQFU1 1780            J2MQT1 1781-1787 .1
        J2MQTU1 1788            J2MQDC1 1789-1793       J2MQCS 1794
        J2MQC2 1795-1802        J2MQDD2 1803-1812 .2    J2MQDU2 1813-1814
        J2MQR2 1815-1816        J2MQF2 1817-1818        J2MQFU2 1819
        J2MQT2 1820-1826 .1     J2MQTU2 1827            J2MQDC2 1828-1832
        J2MQC3 1833-1840        J2MQDD3 1841-1850 .2    J2MQDU3 1851-1852
        J2MQR3 1853-1854        J2MQF3 1855-1856        J2MQFU3 1857
        J2MQT3 1858-1864 .1     J2MQTU3 1865            J2MQDC3 1866-1870
        J2MQC4 1871-1878        J2MQDD4 1879-1888 .2    J2MQDU4 1889-1890
        J2MQR4 1891-1892        J2MQF4 1893-1894        J2MQFU4 1895
        J2MQT4 1896-1902 .1     J2MQTU4 1903            J2MQDC4 1904-1908
        J2MQC5 1909-1916        J2MQDD5 1917-1926 .2    J2MQDU5 1927-1928
        J2MQR5 1929-1930        J2MQF5 1931-1932        J2MQFU5 1933
        J2MQT5 1934-1940 .1     J2MQTU5 1941            J2MQDC5 1942-1946
        J2MQC6 1947-1954        J2MQDD6 1955-1964 .2    J2MQDU6 1965-1966
        J2MQR6 1967-1968        J2MQF6 1969-1970        J2MQFU6 1971
        J2MQT6 1972-1978 .1     J2MQTU6 1979            J2MQDC6 1980-1984
        J2MQC7 1985-1992        J2MQDD7 1993-2002 .2    J2MQDU7 2003-2004
        J2MQR7 2005-2006        J2MQF7 2007-2008        J2MQFU7 2009
        J2MQT7 2010-2016 .1     J2MQTU7 2017            J2MQDC7 2018-2022
        J2MQC8 2023-2030        J2MQDD8 2031-2040 .2    J2MQDU8 2041-2042
        J2MQR8 2043-2044        J2MQF8 2045-2046        J2MQFU8 2047
        J2MQT8 2048-2054 .1     J2MQTU8 2055            J2MQDC8 2056-2060
        J2MQC9 2061-2068        J2MQDD9 2069-2078 .2    J2MQDU9 2079-2080
        J2MQR9 2081-2082        J2MQF9 2083-2084        J2MQFU9 2085
        J2MQT9 2086-2092 .1     J2MQTU9 2093            J2MQDC9 2094-2098
        J2MQC10 2099-2106       J2MQDD10 2107-2116 .2   J2MQDU10 2117-2118
        J2MQR10 2119-2120       J2MQF10 2121-2122       J2MQFU10 2123
        J2MQT10 2124-2130 .1    J2MQTU10 2131           J2MQDC10 2132-2136
        J2ML 2137               J2MLM 2138-2139         J2MLC1 2140-2147
        J2MLC2 2148-2155        J2MLC3 2156-2163        J2MLC4 2164-2171
        J2MLC5 2172-2179        J2MLC6 2180-2187        J2MLC7 2188-2195
        ;


* SAS LABEL STATEMENT;

LABEL 
   MIDJA_IDS= 'MIDJA ID' 
   J2CMONTH= 'Clinic Visit Date:MONTH' 
   J2CYEAR = 'Clinic Visit Date:YEAR' 
   J1SQ1   = 'Gender' 
   J2CAGE  = 'Age at Clinic Visit' 
   J2Q1A   = 'Ever had heart disease' 
   J2Q1AD  = 'Physician diagnosed heart disease' 
   J2Q1B   = 'Ever had high blood pressure' 
   J2Q1BD  = 'Physician diagnosed high blood pressure' 
   J2Q1C   = 'Ever had circulation problems' 
   J2Q1CD  = 'Physician diagnosed circulation problems' 
   J2Q1D   = 'Ever had blood clots' 
   J2Q1DD  = 'Physician diagnosed blood clots' 
   J2Q1E   = 'Ever had heart murmur' 
   J2Q1ED  = 'Physician diagnosed heart murmur' 
   J2Q1F   = 'Ever had TIA or stroke' 
   J2Q1FD  = 'Physician diagnosed TIA or stroke' 
   J2Q1G   = 'Ever had anemia or other blood disease' 
   J2Q1GD  = 'Physician diagnosed anemia or other blood disease' 
   J2Q1H   = 'Ever had cholesterol problems' 
   J2Q1HD  = 'Physician diagnosed cholesterol problems' 
   J2Q1I   = 'Ever had diabetes' 
   J2Q1ID  = 'Physician diagnosed diabetes' 
   J2Q1J   = 'Ever had asthma' 
   J2Q1JD  = 'Physician diagnosed asthma' 
   J2Q1K   = 'Ever had emphysema/COPD' 
   J2Q1KD  = 'Physician diagnosed emphysema/COPD' 
   J2Q1L   = 'Ever had tuberculosis' 
   J2Q1LD  = 'Physician diagnosed tuberculosis' 
   J2Q1M   = 'Ever had positive TB skin test' 
   J2Q1MD  = 'Physician diagnosed positive TB skin test' 
   J2Q1N   = 'Ever had thyroid disease' 
   J2Q1ND  = 'Physician diagnosed thyroid disease' 
   J2Q1O   = 'Ever had peptic ulcer disease' 
   J2Q1OD  = 'Physician diagnosed peptic ulcer disease' 
   J2Q1P   = 'Ever had cancer' 
   J2Q1PD  = 'Physician diagnosed cancer' 
   J2Q1Q   = 'Ever had colon polyp' 
   J2Q1QD  = 'Physician diagnosed colon polyp' 
   J2Q1R   = 'Ever had arthritis' 
   J2Q1RD  = 'Physician diagnosed arthritis' 
   J2Q1S   = 'Ever had glaucoma' 
   J2Q1SD  = 'Physician diagnosed glaucoma' 
   J2Q1T   = 'Ever had cirrhosis/liver disease' 
   J2Q1TD  = 'Physician diagnosed cirrhosis/liver disease' 
   J2Q1U   = 'Ever had alcoholism' 
   J2Q1UD  = 'Physician diagnosed alcoholism' 
   J2Q1V   = 'Ever had depression' 
   J2Q1VD  = 'Physician diagnosed depression' 
   J2Q1W   = 'Ever had blood transfusion before 1993' 
   J2Q1WD  = 'Physician diagnosed blood transfusion before 1993' 
   J2Q1X   = 'Ever had chronic back or neck problem' 
   J2Q1XD  = 'Physician diagnosed chroic back or neck problem' 
   J2Q1Y   = 'Ever had frequent or severe headaches' 
   J2Q1YD  = 'Physician diagnosed frequent or severe headaches' 
   J2Q1Z   = 'Ever had seasonal allergies' 
   J2Q1ZD  = 'Physician diagnosed seasonal allergies' 
   J2Q1AA  = 'Ever had neurological problem' 
   J2Q1AAD = 'Physician diagnosed neurological problem' 
   J2Q1BB  = 'Ever had HIV infection or AIDS' 
   J2Q1BBD = 'Physician diagnosed HIV infection or AIDS' 
   J2Q1CC  = 'Ever had Epilepsy or seizures' 
   J2Q1CCD = 'Physician diagnosed epilepsy or seizures' 
   J2Q1EE  = 'Ever had other conditions 1' 
   J2Q1EED = 'Physician diagnosed other condition 1' 
   J2Q1FF  = 'Ever had other conditions 2' 
   J2Q1FFD = 'Physician diagnosed other condition 2' 
   J2QSYMN = 'Total # of Symptoms & Chronic Conditions (MIDUS items only)' 
   J2QSYMX = 'Any Symptoms & Chronic Conditions?--Yes/No (MIDUS items only)' 
   J2QSYMN2= 'Total # of Symptoms & Chronic Conditions' 
   J2QSYMX2= 'Any Symptoms & Chronic Conditions?--Yes/No' 
   J2Q2    = 'Ever had cancer' 
   J2Q2A   = 'Current condition of cancer: treatment, remission, cured' 
   J2Q2A2  = 'Currently in treatment for cancer' 
   J2Q2B1  = 'Breast cancer' 
   J2Q2B2  = 'Colon cancer' 
   J2Q2B3  = 'Lung cancer' 
   J2Q2B4  = 'Lymphoma or leukemia' 
   J2Q2B5  = 'Prostate cancer' 
   J2Q2B6  = 'Skin cancer (Melanoma)' 
   J2Q2B7  = 'Uterine cancer' 
   J2Q2B8  = 'Ovarian cancer' 
   J2Q2B9  = 'Cervical cancer' 
   J2Q2B10 = 'Other cancer' 
   J2Q3    = 'Ever had a head injury' 
   J2Q3AH  = 'Hospital overnight for head injury A' 
   J2Q3AEM = 'Head injury A occurred: Emperor' 
   J2Q3AEMY= 'Head injury A occurred: Emperor Year' 
   J2Q3ACEY= 'Head injury A occurred: Common Era Year' 
   J2Q3BH  = 'Hospital overnight for head injury B' 
   J2Q3BEM = 'Head injury B occurred: Emperor' 
   J2Q3BEMY= 'Head injury B occurred: Emperor Year' 
   J2Q3BCEY= 'Head injury B occurred: Common Era Year' 
   J2Q4    = 'Ever had a joint injury' 
   J2Q4AH  = 'Hospital overnight for joint injury A' 
   J2Q4AEM = 'Joint injury A occurred: Emperor' 
   J2Q4AEMY= 'Joint injury A occurred: EmperorYear' 
   J2Q4ACEY= 'Joint injury A occurred: Common Era Year' 
   J2Q4BH  = 'Hospital overnight for joint injury B' 
   J2Q4BEM = 'Joint injury B occurred: Emperor' 
   J2Q4BEMY= 'Joint injury B occurred: Emperor Year' 
   J2Q4BCEY= 'Joint injury B occurred: Common Era Year' 
   J2Q5    = 'Ever injured in a motor vehicle accident' 
   J2Q5AH  = 'Hospital overnight for motor vehicle accident A' 
   J2Q5AEM = 'Motor vehicle accident A occurred: Emperor' 
   J2Q5AEMY= 'Motor vehicle accident A occurred: Emperor Year' 
   J2Q5ACEY= 'Motor vehicle accident A occurred: Common Era Year' 
   J2Q5BH  = 'Hospital overnight for motor vehicle accident B' 
   J2Q5BEM = 'Motor vehicle accident B occurred: Emperor' 
   J2Q5BEMY= 'Motor vehicle accident B occurred: Emperor Year' 
   J2Q5BCEY= 'Motor vehicle accident B occurred: Common Era Year' 
   J2Q6    = 'Ever had other major injuries/illnesses' 
   J2Q6AH  = 'Hospital overnight for other injury/illness A' 
   J2Q6AEM = 'Other injury/illness A occurred: Emperor' 
   J2Q6AEMY= 'Other injury/illness A occurred: Emperor Year' 
   J2Q6ACEY= 'Other injury/illness A occurred: Common Era Year' 
   J2Q6BH  = 'Hospital overnight for other injury/illness B' 
   J2Q6BEM = 'Other injury/illness B occurred: Emperor' 
   J2Q6BEMY= 'Other injury/illness B occurred: Emperor Year' 
   J2Q6BCEY= 'Other injury/illness B occurred: Common Era Year' 
   J2Q7AMPM= 'Usual bed time: am/pm' 
   J2Q7H   = 'Usual bed time: hours' 
   J2Q7M   = 'Usual bed time: minutes' 
   J2Q8    = 'Minutes to fall asleep' 
   J2Q9AMPM= 'Usual getting up time: am/pm' 
   J2Q9H   = 'Usual getting up time: hours' 
   J2Q9M   = 'Usual getting up time: minutes' 
   J2Q10H  = 'Hours of sleep a night: hours' 
   J2Q10M  = 'Hours of sleep a night: minutes' 
   J2Q11A  = 'Sleep trouble could not sleep' 
   J2Q11B  = 'Sleep trouble woke up' 
   J2Q11C  = 'Sleep trouble had to use bathroom' 
   J2Q11D  = 'Sleep trouble could not breathe' 
   J2Q11E  = 'Sleep trouble coughed and snored' 
   J2Q11F  = 'Sleep trouble felt too cold' 
   J2Q11G  = 'Sleep trouble felt too hot' 
   J2Q11H  = 'Sleep trouble had bad dreams' 
   J2Q11I  = 'Sleep trouble had pain' 
   J2Q11J  = 'Sleep trouble other reasons' 
   J2Q12   = 'Sleep quality overall' 
   J2Q13   = 'Keep up enough enthusiasm' 
   J2Q14   = 'Taken medicine to sleep' 
   J2Q15   = 'Trouble staying awake' 
   J2Q16   = 'Feeling sleepy daytime' 
   J2QSQ_S1= 'SLEEP Component 1 - Subjective Sleep Quality' 
   J2QSQ_S2= 'SLEEP Component 2 - Sleep Latency' 
   J2QSQ_S3= 'SLEEP Component 3 - Sleep Duration' 
   J2QSQ_S4= 'SLEEP Component 4 - Habitual Sleep Efficiency' 
   J2QSQ_S5= 'SLEEP Component 5 - Sleep Disturbances Range' 
   J2QSQ_S6= 'SLEEP Component 6 - Use of Sleeping Medication' 
   J2QSQ_S7= 'SLEEP Component 7 - Daytime Dysfunction' 
   J2QSQ_GS= 'SLEEP: Global Score' 
   J2Q17   = 'Have chronic pain' 
   J2Q18   = 'Pain interfered with general activity past week' 
   J2Q19   = 'Pain interfered with mood past week' 
   J2Q20   = 'Pain interfered with relationships past week' 
   J2Q21   = 'Pain interfered with sleep past week' 
   J2Q22   = 'Pain interfered with enjoyment of life past week' 
   J2Q23A  = 'Pain primary location: Head' 
   J2Q23B  = 'Pain primary location: Neck' 
   J2Q23C  = 'Pain primary location: Back' 
   J2Q23D  = 'Pain primary location: Shoulders' 
   J2Q23E  = 'Pain primary location: Arms/Hands' 
   J2Q23F  = 'Pain primary location: Hips' 
   J2Q23G  = 'Pain primary location: Legs/Feet' 
   J2Q23H  = 'Pain primary location: Knees' 
   J2Q23I  = 'Pain primary location: Other' 
   J2Q24   = 'Seen physician about pain' 
   J2Q26   = 'Follow a special diet' 
   J2Q27A  = 'Number of servings of milk' 
   J2Q27B  = 'Number of servings of yogurt' 
   J2Q27C  = 'Number of servings of small fish' 
   J2Q28A  = 'Number of servings of green tea (caffeinated)' 
   J2Q28B  = 'Number of servings of other tea (decaffeinated)' 
   J2Q28C  = 'Number of servings of coffee' 
   J2Q28D  = 'Number of servings of other caffeine beverages' 
   J2Q29   = 'Average day, # glasses of water/day' 
   J2Q30   = 'Average day, # sugared beverages/day' 
   J2Q31   = 'Average day, # servings of vegetables' 
   J2Q32   = 'Average day, # servings of fruit' 
   J2Q33   = 'Average day, # servings whole grain' 
   J2Q34A  = 'Average week, # times eat ocean fish' 
   J2Q34B  = 'Average week, # times eat beef/high fat meat' 
   J2Q34C  = 'Average week, # times eat lean meat' 
   J2Q34D  = 'Average week, # times eat non-meat protein' 
   J2Q35   = 'Average week, # times eat fast food' 
   J2Q36   = 'Marital status change since MIDJA survey' 
   J2Q37M  = 'Marital status change: Month' 
   J2Q37Y  = 'Marital status change: Year' 
   J2Q38   = 'Current marital status' 
   J2QMARR = 'Biomarker Marital Status' 
   J2Q39   = 'Anyone close passed away since MIDJA survey' 
   J2Q39AG = 'Gender of person A who passed away' 
   J2Q39AM = 'Month person A died' 
   J2Q39AY = 'Year person A died' 
   J2Q39BG = 'Gender of person B who passed away' 
   J2Q39BM = 'Month person B died' 
   J2Q39BY = 'Year person B died' 
   J2Q39CG = 'Gender of person C who passed away' 
   J2Q39CM = 'Month person C died' 
   J2Q39CY = 'Year person C died' 
   J2Q40A  = 'Ever repeated school year' 
   J2Q40A1 = 'Age repeated school year' 
   J2Q40A3 = 'Repeated school year effect (initial)' 
   J2Q40A4 = 'Repeated school year effect (long-run)' 
   J2Q40B  = 'Ever sent away from home' 
   J2Q40B1 = 'R''s age sent away from home' 
   J2Q40B3 = 'Sent away from home effect (initial)' 
   J2Q40B4 = 'Sent away from home effect (long-run)' 
   J2Q40C  = 'Ever had parent out of job' 
   J2Q40C1 = 'R''s age had parent out of job' 
   J2Q40C3 = 'Parent out of job effect (initial)' 
   J2Q40C4 = 'Parent out of job effect (long-run)' 
   J2Q40D  = 'Ever parent drank caused problems' 
   J2Q40D1 = 'R''s age parent drank caused problems' 
   J2Q40D3 = 'Parent drank problems effect (initial)' 
   J2Q40D4 = 'Parent drank problems effect (long-run)' 
   J2Q40E  = 'Ever parent drugs caused problems' 
   J2Q40E1 = 'R''s age parent drugs caused problems' 
   J2Q40E3 = 'Parent drug problems effect (initial)' 
   J2Q40E4 = 'Parent drug problems effect (long-run)' 
   J2Q40F  = 'Ever dropped out of school' 
   J2Q40F1 = 'R''s age dropped out of school' 
   J2Q40F3 = 'Dropped out of school effect (initial)' 
   J2Q40F4 = 'Dropped out of school effect (long-run)' 
   J2Q40G  = 'Ever suspended/expelled from school' 
   J2Q40G1 = 'R''s age suspended/expelled from school' 
   J2Q40G3 = 'Suspended/expelled effect (initial)' 
   J2Q40G4 = 'Suspended/expelled effect (long-run)' 
   J2Q41H  = 'Ever flunked out of school' 
   J2Q41H1 = 'R''s age flunked out of school' 
   J2Q41H3 = 'Flunked out of school effect (initial)' 
   J2Q41H4 = 'Flunked out of school effect (long-run)' 
   J2Q41I  = 'Ever fired from a job' 
   J2Q41I1 = 'R''s age fired from a job' 
   J2Q41I3 = 'Fired from a job effect (initial)' 
   J2Q41I4 = 'Fired from a job effect (long-run)' 
   J2Q41J  = 'Ever no job for long time' 
   J2Q41J1 = 'R''s age no job for long time' 
   J2Q41J3 = 'No job for long time effect (initial)' 
   J2Q41J4 = 'No job for long time effect (long-run)' 
   J2Q41K  = 'Ever parent died' 
   J2Q41K1 = 'R''s age parent died' 
   J2Q41K3 = 'Parent died effect (initial)' 
   J2Q41K4 = 'Parent died effect (long-run)' 
   J2Q41L  = 'Ever parents divorced' 
   J2Q41L1 = 'R''s age parents divorced' 
   J2Q41L3 = 'Parents divorced effect (initial)' 
   J2Q41L4 = 'Parents divorced effect (long-run)' 
   J2Q41M  = 'Ever SP engaged in infidelity' 
   J2Q41M1 = 'R''s age SP engaged in infidelity' 
   J2Q41M3 = 'SP infidelity effect (initial)' 
   J2Q41M4 = 'SP infidelity effect (long-run)' 
   J2Q41N  = 'Ever significant in-law difficulties' 
   J2Q41N1 = 'R''s age significant in-law difficulties' 
   J2Q41N3 = 'Signif in-law difficult effect (initial)' 
   J2Q41N4 = 'Signif in-law difficlt effect (long-run)' 
   J2Q41O  = 'Ever sibling died' 
   J2Q41O1 = 'R''s age sibling died' 
   J2Q41O3 = 'Sibling died effect (initial)' 
   J2Q41O4 = 'Sibling died effect (long-run)' 
   J2Q41P  = 'Ever child died' 
   J2Q41P1 = 'R''s age child died' 
   J2Q41P3 = 'Child died effect (initial)' 
   J2Q41P4 = 'Child died effect (long-run)' 
   J2Q41Q  = 'Ever child experienced life-threatening accident/injury' 
   J2Q41Q1 = 'R''s age child expernce life-threatening' 
   J2Q41Q3 = 'Child life-threatening effect (initial)' 
   J2Q41Q4 = 'Child life-threatening effect (long-run)' 
   J2Q41R  = 'Ever lost home to fire/flood/etc' 
   J2Q41R1 = 'R''s age lost home to fire/flood/etc' 
   J2Q41R3 = 'Lost home fire/flood effect (initial)' 
   J2Q41R4 = 'Lost home fire/flood effect (long-run)' 
   J2Q41S  = 'Ever physically assaulted' 
   J2Q41S1 = 'R''s age physically assaulted' 
   J2Q41S3 = 'Physically assaulted effect (initial)' 
   J2Q41S4 = 'Physically assaulted effect (long-run)' 
   J2Q41T  = 'Ever sexually assaulted' 
   J2Q41T1 = 'R''s age sexually assaulted' 
   J2Q41T3 = 'Sexually assaulted effect (initial)' 
   J2Q41T4 = 'Sexually assaulted effect (long-run)' 
   J2Q41U  = 'Ever serious legal difficult/prison' 
   J2Q41U1 = 'R''s age serious legal difficult/prison' 
   J2Q41U3 = 'Legal difficult/prison effect (initial)' 
   J2Q41U4 = 'Legal difficult/prison effect (long-run)' 
   J2Q41V  = 'Ever jail detention' 
   J2Q41V1 = 'R''s age jail detention' 
   J2Q41V3 = 'Jail detention effect (initial)' 
   J2Q41V4 = 'Jail detention effect (long-run)' 
   J2Q41W  = 'Ever bankruptcy declared' 
   J2Q41W1 = 'R''s age bankruptcy declared' 
   J2Q41W3 = 'Bankruptcy declared effect (initial)' 
   J2Q41W4 = 'Bankruptcy declared effect (long-run)' 
   J2Q41X  = 'Ever financial loss unrelated to work' 
   J2Q41X1 = 'R''s age financial loss unrelated to work' 
   J2Q41X3 = 'Finc loss unrelated wrk effect (initial)' 
   J2Q41X4 = 'Fin loss unrelated wrk effect (long-run)' 
   J2Q41Y  = 'Ever welfare' 
   J2Q41Y1 = 'R''s age welfare' 
   J2Q41Y3 = 'Welfare effect (initial)' 
   J2Q41Y4 = 'Welfare effect (long-run)' 
   J2Q42   = 'Other events happened since MIDJA survey' 
   J2Q42AM = 'Month of Other event A' 
   J2Q42AY = 'Year of Other event A' 
   J2Q42BM = 'Month of Other event B' 
   J2Q42BY = 'Year of Other event B' 
   J2Q42CM = 'Month of Other event C' 
   J2Q42CY = 'Year of Other event C' 
   J2Q43A  = 'CESD Unusually bothered by things' 
   J2Q43B  = 'CESD Appetite was poor' 
   J2Q43C  = 'CESD Could not shake off blues' 
   J2Q43D  = 'CESD Felt I was as good as others' 
   J2Q43E  = 'CESD Trouble keeping mind on tasks' 
   J2Q43F  = 'CESD Felt depressed' 
   J2Q43G  = 'CESD Everything I did was an effort' 
   J2Q43H  = 'CESD Hopeful about the future' 
   J2Q43I  = 'CESD Thought my life had been a failure' 
   J2Q43J  = 'CESD Felt fearful' 
   J2Q43K  = 'CESD Sleep was restless' 
   J2Q43L  = 'CESD I was happy' 
   J2Q43M  = 'CESD I talked less than usual' 
   J2Q43N  = 'CESD I felt lonely' 
   J2Q43O  = 'CESD People were unfriendly' 
   J2Q43P  = 'CESD I enjoyed life' 
   J2Q43Q  = 'CESD I had crying spells' 
   J2Q43R  = 'CESD I felt sad' 
   J2Q43S  = 'CESD I felt that people dislike me' 
   J2Q43T  = 'CESD I could not get going' 
   J2QCESD = 'CESD: Center for Epidemiologic Studies Depression Scale' 
   J2Q44A  = 'T- ANX Feel pleasant' 
   J2Q44B  = 'T- ANX Tire quickly' 
   J2Q44C  = 'T- ANX Feel like crying' 
   J2Q44D  = 'T- ANX Wish could be happy as others' 
   J2Q44E  = 'T- ANX Lose out because slow to decide' 
   J2Q44F  = 'T- ANX Feel rested' 
   J2Q44G  = 'T- ANX Calm, cool and collected' 
   J2Q44H  = 'T- ANX Difficulties pilling up; cant overcome' 
   J2Q44I  = 'T- ANX Worry too much over small things' 
   J2Q44J  = 'T- ANX I am happy' 
   J2Q44K  = 'T- ANX Inclined to take things hard' 
   J2Q44L  = 'T- ANX Lack self-confidence' 
   J2Q44M  = 'T- ANX Feel secure' 
   J2Q44N  = 'T- ANX Avoid facing crisis or difficulty' 
   J2Q44O  = 'T- ANX Feel blue' 
   J2Q44P  = 'T- ANX I am content' 
   J2Q44Q  = 'T- ANX Unimportant thoughts; bother me' 
   J2Q44R  = 'T- ANX Cant put disappointment out of mind' 
   J2Q44S  = 'T- ANX I am a steady person' 
   J2Q44T  = 'T- ANX Tension; think over recent concern' 
   J2QTA_AX= 'Spielberger Trait Anxiety Inventory' 
   J2Q45A  = 'T- ANG Fiery temper' 
   J2Q45B  = 'T- ANG Quick tempered' 
   J2Q45C  = 'T- ANG Hotheaded person' 
   J2Q45D  = 'T- ANG Annoyed if singled out & corrected' 
   J2Q45E  = 'T- ANG Furious when criticized publicly' 
   J2Q45F  = 'T- ANG Angry if slowed by others mistakes' 
   J2Q45G  = 'T- ANG Infuriated; good job; bad review' 
   J2Q45H  = 'T- ANG Fly off the handle' 
   J2Q45I  = 'T- ANG Annoyed no recognition; good work' 
   J2Q45J  = 'T- ANG People think always right irritate me' 
   J2Q45K  = 'T- ANG Get mad, say nasty things' 
   J2Q45L  = 'T- ANG Feel irritated' 
   J2Q45M  = 'T- ANG Feel angry' 
   J2Q45N  = 'T- ANG Get frustrated, feel like hitting' 
   J2Q45O  = 'T- ANG Blood boils under pressure' 
   J2QTA_AG= 'Spielberger Trait Anger Inventory' 
   J2QTA_AT= 'Spielberger Trait Anger: Angry Temperament' 
   J2QTA_AR= 'Spielberger Anger: Angry Reaction' 
   J2Q46A1 = 'PES-FREQ Appreciate nature' 
   J2Q46A2 = 'PES-FEEL Appreciate nature' 
   J2Q46B1 = 'PES-FREQ Meet someone new' 
   J2Q46B2 = 'PES-FEEL Meet someone new' 
   J2Q46C1 = 'PES-FREQ Plan trips or vacations' 
   J2Q46C2 = 'PES-FEEL Plan trips or vacations' 
   J2Q46D1 = 'PES-FREQ Reading' 
   J2Q46D2 = 'PES-FEEL Reading' 
   J2Q46E1 = 'PES-FREQ Helping someone' 
   J2Q46E2 = 'PES-FEEL Helping someone' 
   J2Q46F1 = 'PES-FREQ Breathing clean air' 
   J2Q46F2 = 'PES-FEEL Breathing clean air' 
   J2Q46G1 = 'PES-FREQ Saying something clearly' 
   J2Q46G2 = 'PES-FEEL Saying something clearly' 
   J2Q46H1 = 'PES-FREQ Thinking about good in future' 
   J2Q46H2 = 'PES-FEEL Thinking about good in future' 
   J2Q46I1 = 'PES-FREQ Laughing' 
   J2Q46I2 = 'PES-FEEL Laughing' 
   J2Q46J1 = 'PES-FREQ Being with animals' 
   J2Q46J2 = 'PES-FEEL Being with animals' 
   J2Q46K1 = 'PES-FREQ Having an open conversation' 
   J2Q46K2 = 'PES-FEEL Having an open conversation' 
   J2Q46L1 = 'PES-FREQ Going to a party' 
   J2Q46L2 = 'PES-FEEL Going to a party' 
   J2Q46M1 = 'PES-FREQ Giving thanks for daily life' 
   J2Q46M2 = 'PES-FEEL Giving thanks for daily life' 
   J2Q46N1 = 'PES-FREQ Being with friends' 
   J2Q46N2 = 'PES-FEEL Being with friends' 
   J2Q46O1 = 'PES-FREQ Being popular at a gathering' 
   J2Q46O2 = 'PES-FEEL Being popular at a gathering' 
   J2Q46P1 = 'PES-FREQ Enjoying TV or movies' 
   J2Q46P2 = 'PES-FEEL Enjoying TV or movies' 
   J2Q46Q1 = 'PES-FREQ Sitting in the sun' 
   J2Q46Q2 = 'PES-FEEL Sitting in the sun' 
   J2Q46R1 = 'PES-FREQ Seeing good happen to Fam/Frnd' 
   J2Q46R2 = 'PES-FEEL Seeing good happen to Fam/Frnd' 
   J2Q46S1 = 'PES-FREQ Planning something' 
   J2Q46S2 = 'PES-FEEL Planning something' 
   J2Q46T1 = 'PES-FREQ Having a lively talk' 
   J2Q46T2 = 'PES-FEEL Having a lively talk' 
   J2Q46U1 = 'PES-FREQ Being with family' 
   J2Q46U2 = 'PES-FEEL Being with family' 
   J2Q46V1 = 'PES-FREQ Taking a relaxing bath' 
   J2Q46V2 = 'PES-FEEL Taking a relaxing bath' 
   J2Q46W1 = 'PES-FREQ Seeing beautiful scenery' 
   J2Q46W2 = 'PES-FEEL Seeing beautiful scenery' 
   J2Q46X1 = 'PES-FREQ Eating good meals' 
   J2Q46X2 = 'PES-FEEL Eating good meals' 
   J2Q46Y1 = 'PES-FREQ Having spare time' 
   J2Q46Y2 = 'PES-FEEL Having spare time' 
   J2Q46Z1 = 'PES-FREQ Noticed as sexually attractive' 
   J2Q46Z2 = 'PES-FEEL Noticed as sexually attractive' 
   J2Q46AA1= 'PES-FREQ Learning to do something new' 
   J2Q46AA2= 'PES-FEEL Learning to do something new' 
   J2Q46BB1= 'PES-FREQ Complimenting someone' 
   J2Q46BB2= 'PES-FEEL Complimenting someone' 
   J2Q46CC1= 'PES-FREQ Thinking about people I like' 
   J2Q46CC2= 'PES-FEEL Thinking about people I like' 
   J2Q46DD1= 'PES-FREQ Kissing' 
   J2Q46DD2= 'PES-FEEL Kissing' 
   J2Q46EE1= 'PES-FREQ Praying or meditating' 
   J2Q46EE2= 'PES-FEEL Praying or meditating' 
   J2Q46FF1= 'PES-FREQ Doing a project my own way' 
   J2Q46FF2= 'PES-FEEL Doing a project my own way' 
   J2Q46HH1= 'PES-FREQ Being relaxed' 
   J2Q46HH2= 'PES-FEEL Being relaxed' 
   J2Q46II1= 'PES-FREQ Sleeping soundly at night' 
   J2Q46II2= 'PES-FEEL Sleeping soundly at night' 
   J2Q46JJ1= 'PES-FREQ Having a good fitness workout' 
   J2Q46JJ2= 'PES-FEEL Having a good fitness workout' 
   J2Q46KK1= 'PES-FREQ Amusing people' 
   J2Q46KK2= 'PES-FEEL Amusing people' 
   J2Q46LL1= 'PES-FREQ Being with someone I love' 
   J2Q46LL2= 'PES-FEEL Being with someone I love' 
   J2Q46MM1= 'PES-FREQ Sexual relation with partner' 
   J2Q46MM2= 'PES-FEEL Sexual relation with partner' 
   J2Q46NN1= 'PES-FREQ Watching sports' 
   J2Q46NN2= 'PES-FEEL Watching sports' 
   J2Q46OO1= 'PES-FREQ Being with happy people' 
   J2Q46OO2= 'PES-FEEL Being with happy people' 
   J2Q46PP1= 'PES-FREQ Smiling at people' 
   J2Q46PP2= 'PES-FEEL Smiling at people' 
   J2Q46QQ1= 'PES-FREQ Being with spouse/partner' 
   J2Q46QQ2= 'PES-FEEL Being with spouse/partner' 
   J2Q46RR1= 'PES-FREQ Teaching or advising someone' 
   J2Q46RR2= 'PES-FEEL Teaching or advising someone' 
   J2Q46SS1= 'PES-FREQ Being complimented' 
   J2Q46SS2= 'PES-FEEL Being complimented' 
   J2Q46TT1= 'PES-FREQ Being told I am loved' 
   J2Q46TT2= 'PES-FEEL Being told I me loved' 
   J2Q46UU1= 'PES-FREQ Seeing old friends' 
   J2Q46UU2= 'PES-FEEL Seeing old friends' 
   J2Q46VV1= 'PES-FREQ Shopping' 
   J2Q46VV2= 'PES-FEEL Shopping' 
   J2Q46WW1= 'PES-FREQ Feeling no pain' 
   J2Q46WW2= 'PES-FEEL Feeling no pain' 
   J2Q47A  = 'RELAT Obligated to be informed with news' 
   J2Q47B  = 'RELAT Obligated to vote in elections' 
   J2Q47C  = 'RELAT Oblig:time/money to social causes' 
   J2Q47D  = 'RELAT Drop plans if family very troubled' 
   J2Q47E  = 'RELAT Obligated to contact family regularly' 
   J2Q47F  = 'RELAT Obligated give needy friend money' 
   J2Q47G  = 'RELAT Obligated to take adult child in' 
   J2Q47H  = 'RELAT My work makes world better place' 
   J2Q47I  = 'RELAT Think of harm my work may cause' 
   J2Q47J  = 'RELAT Help out colleagues at work' 
   J2Q47K  = 'RELAT Volunteer do unwanted tasks at work' 
   J2Q47L  = 'RELAT Known for honesty/integrity at work' 
   J2QSO_PC= 'Public Community' 
   J2QSO_PF= 'Private Family/Friends 3 items' 
   J2QSO_PX= 'Private Family/Friends 4 items' 
   J2QSO_IW= 'Private/Ingroup Work' 
   J2QSO_GW= 'Good Work Scale' 
   J2Q48A  = 'RELAT Close relations impt reflection me' 
   J2Q48B  = 'RELAT Very close others impt part of me' 
   J2Q48C  = 'RELAT Pride:close others accomplishments' 
   J2Q48D  = 'RELAT Who I am is who friends are' 
   J2Q48E  = 'RELAT Think of self, think of fam/frnds' 
   J2Q48F  = 'RELAT Someone close is hurt, I feel hurt' 
   J2Q48G  = 'RELAT Close relation:no effect self feeling' 
   J2Q48H  = 'RELAT Close relations not impt who I am' 
   J2Q48I  = 'RELAT Pride comes from close friends' 
   J2Q48J  = 'RELAT Identify closely with close friends' 
   J2Q48K  = 'RELAT Walk in a room can figure out mood' 
   J2Q48L  = 'RELAT Not affected by moods of others' 
   J2Q48M  = 'RELAT Cant be happy if friend in trouble' 
   J2Q48N  = 'RELAT Moved when hear hardships' 
   J2Q48O  = 'RELAT Nothing more vital than sympathy' 
   J2Q48P  = 'RELAT My sympathy has its limits' 
   J2Q48Q  = 'RELAT Follow opinion of people I respect' 
   J2Q48R  = 'RELAT Adjust opinion to fit group' 
   J2Q48S  = 'RELAT Adjust values to fit others' 
   J2Q48T  = 'RELAT Adjust to things hard to change' 
   J2Q48U  = 'RELAT Life uncertain: try change no use' 
   J2QRISC = 'Relational Interdependent self-construal scale' 
   J2QSYMP = 'Sympathy scale' 
   J2QADJ  = 'Adjustment scale' 
   J2Q49A  = 'When goal decided, keep in mind benefits' 
   J2Q49B  = 'Decided on something, avoid distract' 
   J2Q49C  = 'Difficult goals, mind how good will feel' 
   J2Q49D  = 'Can''t attain goal in any way, let go' 
   J2Q49E  = 'Stop thinking/let go unattainable goal' 
   J2Q49F  = 'Something no work, try not to think about' 
   J2Q49G  = 'Can''t attain goal, think about oth goals' 
   J2Q49H  = 'Impossible attain goal, no blame myself' 
   J2QSSCTR= 'Selective Secondary Control' 
   J2QCSCD4= 'Compensatory Secondary Control - Disengagement - 4 items version' 
   J2QCSCD6= 'Compensatory Secondary Control - Disengagement - 6 items version' 
   J2QCSCP4= 'Compensatory Secondary Control - Self Protection - 4 items version' 
   J2QCSCP5= 'Compensatory Secondary Control - Self Protection - 5 items version' 
   J2Q50A  = 'GDLIFE Be critical/reflect on actions' 
   J2Q50B  = 'GDLIFE Needed by others' 
   J2Q50C  = 'GDLIFE Harmony with others/events' 
   J2Q50D  = 'GDLIFE Make good effort/stick to it' 
   J2Q50E  = 'GDLIFE Peace and satisfaction' 
   J2Q50F  = 'GDLIFE Sympathy from others' 
   J2Q50G  = 'GDLIFE Respect from others' 
   J2Q50H  = 'GDLIFE Give back to society' 
   J2QSW_JP= 'Subjective Well-Being Japanese Comparison' 
   J2Q51A  = 'Autonomy important for good life' 
   J2Q51B  = 'Good job important for good life' 
   J2Q51C  = 'Learning/growth important for good life' 
   J2Q51D  = 'Life''s pleasures important for good life' 
   J2Q51E  = 'Enough money important for good life' 
   J2Q51F  = 'Extra money important for good life' 
   J2Q51G  = 'Faith important for good life' 
   J2Q51H  = 'Giving to community import for good life' 
   J2Q51I  = 'Love/care for self import for good life' 
   J2Q51J  = 'Physical fitness important for good life' 
   J2Q51K  = 'Positiv attitude important for good life' 
   J2Q51L  = 'Family relations important for good life' 
   J2Q51M  = 'Friend relations important for good life' 
   J2Q51N  = 'Relax/peace important for good life' 
   J2Q51O  = 'Absence of illness import for good life' 
   J2Q51P  = 'Sense of accomplish import for good life' 
   J2Q51Q  = 'Sense of purpose important for good life' 
   J2Q52   = 'Have an ikigai in life' 
   J2Q541  = 'Job requires learn new things' 
   J2Q542  = 'Job requires a lot of repetitive work' 
   J2Q543  = 'Job requires to be creative' 
   J2Q544  = 'Job allows to make a lot of decisions on own' 
   J2Q545  = 'Job requires a high level of skill' 
   J2Q546  = 'Very little freedom to decide how to do my work' 
   J2Q547  = 'Do a variety of different things on job' 
   J2Q548  = 'Have a lot of say about what happens on job' 
   J2Q549  = 'Have opportunity to develop own special abilities' 
   J2Q5410 = 'Job requires working very fast' 
   J2Q5411 = 'Job requires working very hard' 
   J2Q5412 = 'Not asked to do excessive amount of work' 
   J2Q5413 = 'Have enough time to get job done' 
   J2Q5414 = 'Free from conflicting demands others make' 
   J2Q5415 = 'Supervisor concerned welfare of those under him' 
   J2Q5416 = 'Supervisor pays attention to what I am saying' 
   J2Q5417 = 'Supervisor helpful in getting job done' 
   J2Q5418 = 'Supervisor successful in getting people work together' 
   J2Q5419 = 'People work with are competent' 
   J2Q5420 = 'People work with take personal interest in me' 
   J2Q5421 = 'People work with are friendly' 
   J2Q5422 = 'People work with are helpful in getting job done' 
   J2QJC_SD= 'Job Content Scales: Skill Discretion' 
   J2QJC_DA= 'Job Content Scales: Decision Authority' 
   J2QJC_DL= 'Job Content Scales: Decision Latitude' 
   J2QJC_PD= 'Job Content Scales: Psychological Demand' 
   J2QJC_SS= 'Job Content Scales: Supervisor Support' 
   J2QJC_CS= 'Job Content Scales: Coworker Support' 
   J2CLMDAY= 'On what day did respondent eat last?' 
   J2CLMTH = 'Time of Last Meal: Hour' 
   J2CLMTM = 'Time of Last Meal: Minute' 
   J2CHT   = 'Height (cm)' 
   J2CWT   = 'Weight (kg)' 
   J2CBMI  = 'BMI (Body Mass Index)' 
   J2CWST  = 'Waist (cm)' 
   J2CHIP1 = 'Hip 1: Abdominal Girth (Iliac crest, cm)' 
   J2CHIP2 = 'Hip 2: Maximum Extension (cm)' 
   J2CHIPCM= 'Flag: Coded notes from Hip Measurement' 
   J2CWHR  = 'Waist-Hip Ratio' 
   J2CBPS1 = 'Blood Pressure 1: Systolic (High)' 
   J2CBPD1 = 'Blood Pressure 1: Diastolic (Low)' 
   J2CBPS2 = 'Blood Pressure 2: Systolic (High)' 
   J2CBPD2 = 'Blood Pressure 2: Diastolic (Low)' 
   J2CBPS3 = 'Blood Pressure 3: Systolic (High)' 
   J2CBPD3 = 'Blood Pressure 3: Diastolic (Low)' 
   J2CBPS23= 'Average of 2nd and 3rd systolic BPs' 
   J2CBPD23= 'Average of 2nd and 3rd diastolic BPs' 
   J2CBLD  = 'Was Blood Sample Collected?' 
   J2CBLDTH= 'Time of Blood Sample Collection: Hour' 
   J2CBLDTM= 'Time of Blood Sample Collection: Minute' 
   J2CCCTH = 'Time Citrate Tube was Centrifuged: Hour' 
   J2CCCTM = 'Time Citrate Tube was Centrifuged: Minute' 
   J2CCSSTH= 'Time SST Tube was Centrifuged: Hour' 
   J2CCSSTM= 'Time SST Tube was Centrifuged: Minute' 
   J2CFCTH = 'Time Citrate Tube was Frozen: Hour' 
   J2CFCTM = 'Time Citrate Tube was Frozen: Minute' 
   J2CFSSTH= 'Time SST Tube was Frozen: Hour' 
   J2CFSSTM= 'Time SST Tube was Frozen: Minute' 
   J2CLMBLD= 'Lag hours: time of last meal to blood collection' 
   J2CBLDCTC= 'Lag mins: time of blood collection to Citrate tube centrifugation' 
   J2CBLDSSC= 'Lag mins: time of blood collection to SST tube centrifugation' 
   J2CBLDCTF= 'Lag mins: time of blood collection to time Citrate tube was frozen' 
   J2CBLDSSF= 'Lag mins: time of blood collection to time SST tube was frozen' 
   J2BCHOL = 'Biocore Total Cholesterol (mg/dL)' 
   J2BHDL  = 'Biocore original MIDJA HDL Cholesterol (mg/dL)' 
   J2BHDLA = 'Biocore MIDJA HDL Cholesterol (adjusted to MIDUS)  (mg/dL)' 
   J2BRTHDL= 'Biocore original MIDJA ratio Total/HDL Cholesterol (chol/HDL)' 
   J2BRTHDA= 'Biocore MIDJA ratio Total/HDL Cholesterol (adjusted to MIDUS) (chol/HDL)' 
   J2BDHEAS= 'Biocore DHEA-S (ug/dL)' 
   J2BDHEA = 'Biocore DHEA (ng/mL)' 
   J2BSCREA= 'Biocore Serum Creatinine (mg/dL)' 
   J2BIL6  = 'Biocore IL6 (pg/ml)' 
   J2BSIL6R= 'Biocore sIL6r (pg/ml)' 
   J2BFGN  = 'Biocore Fibrinogen (mg/dL)' 
   J2BCRP  = 'Biocore C Reactive Protein (ug/mL)' 
   J2CHBA1C= 'Tokyo Lab: Hemoglobin A1c (%)' 
   J2BHA1CA= 'MIDUS Adjusted Tokyo Lab: Hemoglobin A1c (%)' 
   J2CTCHOL= 'Tokyo Lab: Total Cholesterol (mg/dL)' 
   J2CHDL  = 'Tokyo Lab: HDL Cholesterol (mg/dL)' 
   J2CLDL  = 'Tokyo Lab: LDL Cholesterol (mg/dL)' 
   J2CTRIG = 'Tokyo Lab: Triglyceride (mg/dL)' 
   J2CRTHDL= 'Tokyo Lab: Ratio Total/HDL Cholesterol' 
   J2CGOT  = 'Tokyo Lab: GOT (Glutamic Oxaloacetic Transaminase)' 
   J2CGPT  = 'Tokyo Lab: GPT (Glutamic Pyruvic Transaminase)' 
   J2CGGTP = 'Tokyo Lab: Gamma-GTP (Gamma Glutamyl Transpepetidase)' 
   J2CSURIC= 'Tokyo Lab: Serum Uric Acid' 
   J2CUREA = 'Tokyo Lab: BUN (Blood Urea Nitrogen)' 
   J2CWBC  = 'Tokyo Lab: White Blood Cell Count' 
   J2CRBC  = 'Tokyo Lab: Red Blood Cell Count' 
   J2CHGB  = 'Tokyo Lab:Hemoglobin (HGB)' 
   J2CHTC  = 'Tokyo Lab:Hematocrit (HTC)' 
   J2CMCV  = 'Tokyo Lab: Mean Cell Volume (MCV)' 
   J2CMCH  = 'Tokyo Lab: Mean Cell Hemoglobin (MCH)' 
   J2CMCHC = 'Tokyo Lab: Mean Cell Hemoglobin Concentration (MCHC)' 
   J2CPLT  = 'Tokyo Lab: Platelets' 
   J2SSAL  = 'Did R provide any saliva samples?' 
   J2SCVSC1= 'Lag in Days: from Clinic Visit Date to Saliva Collection Start Date' 
   J2CSCSEQ= 'Saliva Sample Collected on 3 Consecutive Days?' 
   J2SD1MNH= 'Saliva Cortisol Collection Time: Day 1 - Morning: Hour' 
   J2SD1MNM= 'Saliva Cortisol Collection Time: Day 1 - Morning: Minute' 
   J2SD1MDH= 'Saliva Cortisol Collection Time: Day 1 - Midday: Hour' 
   J2SD1MDM= 'Saliva Cortisol Collection Time: Day 1 - Midday: Minute' 
   J2SD1EVH= 'Saliva Cortisol Collection Time: Day 1 - Evening: Hour' 
   J2SD1EVM= 'Saliva Cortisol Collection Time: Day 1 - Evening: Minute' 
   J2SD2MNH= 'Saliva Cortisol Collection Time: Day 2 - Morning: Hour' 
   J2SD2MNM= 'Saliva Cortisol Collection Time: Day 2 - Morning: Minute' 
   J2SD2MDH= 'Saliva Cortisol Collection Time: Day 2 - Midday: Hour' 
   J2SD2MDM= 'Saliva Cortisol Collection Time: Day 2 - Midday: Minute' 
   J2SD2EVH= 'Saliva Cortisol Collection Time: Day 2 - Evening: Hour' 
   J2SD2EVM= 'Saliva Cortisol Collection Time: Day 2 - Evening: Minute' 
   J2SD3MNH= 'Saliva Cortisol Collection Time: Day 3 - Morning: Hour' 
   J2SD3MNM= 'Saliva Cortisol Collection Time: Day 3 - Morning: Minute' 
   J2SD3MDH= 'Saliva Cortisol Collection Time: Day 3 - Midday: Hour' 
   J2SD3MDM= 'Saliva Cortisol Collection Time: Day 3 - Midday: Minute' 
   J2SD3EVH= 'Saliva Cortisol Collection Time: Day 3 - Evening: Hour' 
   J2SD3EVM= 'Saliva Cortisol Collection Time: Day 3 - Evening: Minute' 
   J2SCDAY1= 'Did R have Any Valid Saliva Samples on Day 1?' 
   J2SCDAY2= 'Did R have Any Valid Saliva Samples on Day 2?' 
   J2SCDAY3= 'Did R have Any Valid Saliva Samples on Day 3?' 
   J2BSCD11= 'Saliva Cortisol Day 1 Morning (nmol/L)' 
   J2BSCD12= 'Saliva Cortisol Day 1 Midday (nmol/L)' 
   J2BSCD13= 'Saliva Cortisol Day 1 Evening (nmol/L)' 
   J2BSCD21= 'Saliva Cortisol Day 2 Morning (nmol/L)' 
   J2BSCD22= 'Saliva Cortisol Day 2 Midday (nmol/L)' 
   J2BSCD23= 'Saliva Cortisol Day 2 Evening (nmol/L)' 
   J2BSCD31= 'Saliva Cortisol Day 3 Morning (nmol/L)' 
   J2BSCD32= 'Saliva Cortisol Day 3 Midday (nmol/L)' 
   J2BSCD33= 'Saliva Cortisol Day 3 Evening (nmol/L)' 
   J2MPMD  = 'Taking Prescription Medication?--YES/NO' 
   J2MQMD  = 'Taking Quasi (non-prescription) Medication?--YES/NO' 
   J2MPM   = 'Prescription: Number of prescription medications' 
   J2MPC1  = 'Prescription: Drug code 1' 
   J2MPDD1 = 'Prescription: Dosage 1' 
   J2MPDU1 = 'Prescription: Dosage units 1' 
   J2MPR1  = 'Prescription: Method of taking (route) 1' 
   J2MPF1  = 'Prescription: Frequency 1' 
   J2MPFU1 = 'Prescription: Frequency unit of time 1' 
   J2MPT1  = 'Prescription: Taken for how long 1' 
   J2MPTU1 = 'Prescription: Unit of time taken 1' 
   J2MPDC1 = 'Prescription: Diagnosis code 1' 
   J2MPC2  = 'Prescription: Drug code 2' 
   J2MPDD2 = 'Prescription: Dosage 2' 
   J2MPDU2 = 'Prescription: Dosage units 2' 
   J2MPR2  = 'Prescription: Method of taking (route) 2' 
   J2MPF2  = 'Prescription: Frequency 2' 
   J2MPFU2 = 'Prescription: Frequency unit of time 2' 
   J2MPT2  = 'Prescription: Taken for how long 2' 
   J2MPTU2 = 'Prescription: Unit of time taken 2' 
   J2MPDC2 = 'Prescription: Diagnosis code 2' 
   J2MPC3  = 'Prescription: Drug code 3' 
   J2MPDD3 = 'Prescription: Dosage 3' 
   J2MPDU3 = 'Prescription: Dosage units 3' 
   J2MPR3  = 'Prescription: Method of taking (route) 3' 
   J2MPF3  = 'Prescription: Frequency 3' 
   J2MPFU3 = 'Prescription: Frequency unit of time 3' 
   J2MPT3  = 'Prescription: Taken for how long 3' 
   J2MPTU3 = 'Prescription: Unit of time taken 3' 
   J2MPDC3 = 'Prescription: Diagnosis code 3' 
   J2MPC4  = 'Prescription: Drug code 4' 
   J2MPDD4 = 'Prescription: Dosage 4' 
   J2MPDU4 = 'Prescription: Dosage units 4' 
   J2MPR4  = 'Prescription: Method of taking (route) 4' 
   J2MPF4  = 'Prescription: Frequency 4' 
   J2MPFU4 = 'Prescription: Frequency unit of time 4' 
   J2MPT4  = 'Prescription: Taken for how long 4' 
   J2MPTU4 = 'Prescription: Unit of time taken 4' 
   J2MPDC4 = 'Prescription: Diagnosis code 4' 
   J2MPC5  = 'Prescription: Drug code 5' 
   J2MPDD5 = 'Prescription: Dosage 5' 
   J2MPDU5 = 'Prescription: Dosage units 5' 
   J2MPR5  = 'Prescription: Method of taking (route) 5' 
   J2MPF5  = 'Prescription: Frequency 5' 
   J2MPFU5 = 'Prescription: Frequency unit of time 5' 
   J2MPT5  = 'Prescription: Taken for how long 5' 
   J2MPTU5 = 'Prescription: Unit of time taken 5' 
   J2MPDC5 = 'Prescription: Diagnosis code 5' 
   J2MPC6  = 'Prescription: Drug code 6' 
   J2MPDD6 = 'Prescription: Dosage 6' 
   J2MPDU6 = 'Prescription: Dosage units 6' 
   J2MPR6  = 'Prescription: Method of taking (route) 6' 
   J2MPF6  = 'Prescription: Frequency 6' 
   J2MPFU6 = 'Prescription: Frequency unit of time 6' 
   J2MPT6  = 'Prescription: Taken for how long 6' 
   J2MPTU6 = 'Prescription: Unit of time taken 6' 
   J2MPDC6 = 'Prescription: Diagnosis code 6' 
   J2MPC7  = 'Prescription: Drug code 7' 
   J2MPDD7 = 'Prescription: Dosage 7' 
   J2MPDU7 = 'Prescription: Dosage units 7' 
   J2MPR7  = 'Prescription: Method of taking (route) 7' 
   J2MPF7  = 'Prescription: Frequency 7' 
   J2MPFU7 = 'Prescription: Frequency unit of time 7' 
   J2MPT7  = 'Prescription: Taken for how long 7' 
   J2MPTU7 = 'Prescription: Unit of time taken 7' 
   J2MPDC7 = 'Prescription: Diagnosis code 7' 
   J2MPC8  = 'Prescription: Drug code 8' 
   J2MPDD8 = 'Prescription: Dosage 8' 
   J2MPDU8 = 'Prescription: Dosage units 8' 
   J2MPR8  = 'Prescription: Method of taking (route) 8' 
   J2MPF8  = 'Prescription: Frequency 8' 
   J2MPFU8 = 'Prescription: Frequency unit of time 8' 
   J2MPT8  = 'Prescription: Taken for how long 8' 
   J2MPTU8 = 'Prescription: Unit of time taken 8' 
   J2MPDC8 = 'Prescription: Diagnosis code 8' 
   J2MPC9  = 'Prescription: Drug code 9' 
   J2MPDD9 = 'Prescription: Dosage 9' 
   J2MPDU9 = 'Prescription: Dosage units 9' 
   J2MPR9  = 'Prescription: Method of taking (route) 9' 
   J2MPF9  = 'Prescription: Frequency 9' 
   J2MPFU9 = 'Prescription: Frequency unit of time 9' 
   J2MPT9  = 'Prescription: Taken for how long 9' 
   J2MPTU9 = 'Prescription: Unit of time taken 9' 
   J2MPDC9 = 'Prescription: Diagnosis code 9' 
   J2MPC10 = 'Prescription: Drug code 10' 
   J2MPDD10= 'Prescription: Dosage 10' 
   J2MPDU10= 'Prescription: Dosage units 10' 
   J2MPR10 = 'Prescription: Method of taking (route) 10' 
   J2MPF10 = 'Prescription: Frequency 10' 
   J2MPFU10= 'Prescription: Frequency unit of time 10' 
   J2MPT10 = 'Prescription: Taken for how long 10' 
   J2MPTU10= 'Prescription: Unit of time taken 10' 
   J2MPDC10= 'Prescription: Diagnosis code 10' 
   J2MPC11 = 'Prescription: Drug code 11' 
   J2MPDD11= 'Prescription: Dosage 11' 
   J2MPDU11= 'Prescription: Dosage units 11' 
   J2MPR11 = 'Prescription: Method of taking (route) 11' 
   J2MPF11 = 'Prescription: Frequency 11' 
   J2MPFU11= 'Prescription: Frequency unit of time 11' 
   J2MPT11 = 'Prescription: Taken for how long 11' 
   J2MPTU11= 'Prescription: Unit of time taken 11' 
   J2MPDC11= 'Prescription: Diagnosis code 11' 
   J2MPC12 = 'Prescription: Drug code 12' 
   J2MPDD12= 'Prescription: Dosage 12' 
   J2MPDU12= 'Prescription: Dosage units 12' 
   J2MPR12 = 'Prescription: Method of taking (route) 12' 
   J2MPF12 = 'Prescription: Frequency 12' 
   J2MPFU12= 'Prescription: Frequency unit of time 12' 
   J2MPT12 = 'Prescription: Taken for how long 12' 
   J2MPTU12= 'Prescription: Unit of time taken 12' 
   J2MPDC12= 'Prescription: Diagnosis code 12' 
   J2MPC13 = 'Prescription: Drug code 13' 
   J2MPDD13= 'Prescription: Dosage 13' 
   J2MPDU13= 'Prescription: Dosage units 13' 
   J2MPR13 = 'Prescription: Method of taking (route) 13' 
   J2MPF13 = 'Prescription: Frequency 13' 
   J2MPFU13= 'Prescription: Frequency unit of time 13' 
   J2MPT13 = 'Prescription: Taken for how long 13' 
   J2MPTU13= 'Prescription: Unit of time taken 13' 
   J2MPDC13= 'Prescription: Diagnosis code 13' 
   J2MBPD  = 'Taking Blood Pressure med --YES/NO' 
   J2MBPC  = 'Taking Blood Pressure med --# of meds' 
   J2MCHD  = 'Taking CHOLESTEROL med --YES/NO' 
   J2MCHC  = 'Taking CHOLESTEROL med --# of meds' 
   J2MDPD  = 'Taking DEPRESSION med --YES/NO' 
   J2MDPC  = 'Taking DEPRESSION med --# of meds' 
   J2MCOD  = 'Taking CORTICOSTEROID med --YES/NO' 
   J2MCOC  = 'Taking CORTICOSTEROID med --# of meds' 
   J2MSHD  = 'Taking SEX HORMONE med --YES/NO' 
   J2MSHC  = 'Taking SEX HORMONE med --# of meds' 
   J2MQM   = 'Number of Quasi (non-prescription) medications' 
   J2MQMV  = 'Quasi (non-prescription): Does R take multiple vitamin' 
   J2MQC1  = 'Quasi (non-prescription): Drug code 1' 
   J2MQDD1 = 'Quasi (non-prescription): Dosage 1' 
   J2MQDU1 = 'Quasi (non-prescription): Dosage units 1' 
   J2MQR1  = 'Quasi (non-prescription): Method of taking (route) 1' 
   J2MQF1  = 'Quasi (non-prescription): Frequency 1' 
   J2MQFU1 = 'Quasi (non-prescription): Frequency units 1' 
   J2MQT1  = 'Quasi (non-prescription): Taken for how long 1' 
   J2MQTU1 = 'Quasi (non-prescription): Taken for how long units 1' 
   J2MQDC1 = 'Quasi (non-prescription): Diagnosis code 1' 
   J2MQCS  = 'Quasi (non-prescription): Does R take calcium supplement' 
   J2MQC2  = 'Quasi (non-prescription): Drug code 2' 
   J2MQDD2 = 'Quasi (non-prescription): Dosage 2' 
   J2MQDU2 = 'Quasi (non-prescription): Dosage units 2' 
   J2MQR2  = 'Quasi (non-prescription): Method of taking (route) 2' 
   J2MQF2  = 'Quasi (non-prescription): Frequency 2' 
   J2MQFU2 = 'Quasi (non-prescription): Frequency units 2' 
   J2MQT2  = 'Quasi (non-prescription): Taken for how long 2' 
   J2MQTU2 = 'Quasi (non-prescription): Taken for how long units 2' 
   J2MQDC2 = 'Quasi (non-prescription): Diagnosis code 2' 
   J2MQC3  = 'Quasi (non-prescription): Drug code 3' 
   J2MQDD3 = 'Quasi (non-prescription): Dosage 3' 
   J2MQDU3 = 'Quasi (non-prescription): Dosage units 3' 
   J2MQR3  = 'Quasi (non-prescription): Method of taking (route) 3' 
   J2MQF3  = 'Quasi (non-prescription): Frequency 3' 
   J2MQFU3 = 'Quasi (non-prescription): Frequency units 3' 
   J2MQT3  = 'Quasi (non-prescription): Taken for how long 3' 
   J2MQTU3 = 'Quasi (non-prescription): Taken for how long units 3' 
   J2MQDC3 = 'Quasi (non-prescription): Diagnosis code 3' 
   J2MQC4  = 'Quasi (non-prescription): Drug code 4' 
   J2MQDD4 = 'Quasi (non-prescription): Dosage 4' 
   J2MQDU4 = 'Quasi (non-prescription): Dosage units 4' 
   J2MQR4  = 'Quasi (non-prescription): Method of taking (route) 4' 
   J2MQF4  = 'Quasi (non-prescription): Frequency 4' 
   J2MQFU4 = 'Quasi (non-prescription): Frequency units 4' 
   J2MQT4  = 'Quasi (non-prescription): Taken for how long 4' 
   J2MQTU4 = 'Quasi (non-prescription): Taken for how long units 4' 
   J2MQDC4 = 'Quasi (non-prescription): Diagnosis code 4' 
   J2MQC5  = 'Quasi (non-prescription): Drug code 5' 
   J2MQDD5 = 'Quasi (non-prescription): Dosage 5' 
   J2MQDU5 = 'Quasi (non-prescription): Dosage units 5' 
   J2MQR5  = 'Quasi (non-prescription): Method of taking (route) 5' 
   J2MQF5  = 'Quasi (non-prescription): Frequency 5' 
   J2MQFU5 = 'Quasi (non-prescription): Frequency units 5' 
   J2MQT5  = 'Quasi (non-prescription): Taken for how long 5' 
   J2MQTU5 = 'Quasi (non-prescription): Taken for how long units 5' 
   J2MQDC5 = 'Quasi (non-prescription): Diagnosis code 5' 
   J2MQC6  = 'Quasi (non-prescription): Drug code 6' 
   J2MQDD6 = 'Quasi (non-prescription): Dosage 6' 
   J2MQDU6 = 'Quasi (non-prescription): Dosage units 6' 
   J2MQR6  = 'Quasi (non-prescription): Method of taking (route) 6' 
   J2MQF6  = 'Quasi (non-prescription): Frequency 6' 
   J2MQFU6 = 'Quasi (non-prescription): Frequency units 6' 
   J2MQT6  = 'Quasi (non-prescription): Taken for how long 6' 
   J2MQTU6 = 'Quasi (non-prescription): Taken for how long units 6' 
   J2MQDC6 = 'Quasi (non-prescription): Diagnosis code 6' 
   J2MQC7  = 'Quasi (non-prescription): Drug code 7' 
   J2MQDD7 = 'Quasi (non-prescription): Dosage 7' 
   J2MQDU7 = 'Quasi (non-prescription): Dosage units 7' 
   J2MQR7  = 'Quasi (non-prescription): Method of taking (route) 7' 
   J2MQF7  = 'Quasi (non-prescription): Frequency 7' 
   J2MQFU7 = 'Quasi (non-prescription): Frequency units 7' 
   J2MQT7  = 'Quasi (non-prescription): Taken for how long 7' 
   J2MQTU7 = 'Quasi (non-prescription): Taken for how long units 7' 
   J2MQDC7 = 'Quasi (non-prescription): Diagnosis code 7' 
   J2MQC8  = 'Quasi (non-prescription): Drug code 8' 
   J2MQDD8 = 'Quasi (non-prescription): Dosage 8' 
   J2MQDU8 = 'Quasi (non-prescription): Dosage units 8' 
   J2MQR8  = 'Quasi (non-prescription): Method of taking (route) 8' 
   J2MQF8  = 'Quasi (non-prescription): Frequency 8' 
   J2MQFU8 = 'Quasi (non-prescription): Frequency units 8' 
   J2MQT8  = 'Quasi (non-prescription): Taken for how long 8' 
   J2MQTU8 = 'Quasi (non-prescription): Taken for how long units 8' 
   J2MQDC8 = 'Quasi (non-prescription): Diagnosis code 8' 
   J2MQC9  = 'Quasi (non-prescription): Drug code 9' 
   J2MQDD9 = 'Quasi (non-prescription): Dosage 9' 
   J2MQDU9 = 'Quasi (non-prescription): Dosage units 9' 
   J2MQR9  = 'Quasi (non-prescription): Method of taking (route) 9' 
   J2MQF9  = 'Quasi (non-prescription): Frequency 9' 
   J2MQFU9 = 'Quasi (non-prescription): Frequency units 9' 
   J2MQT9  = 'Quasi (non-prescription): Taken for how long 9' 
   J2MQTU9 = 'Quasi (non-prescription): Taken for how long units 9' 
   J2MQDC9 = 'Quasi (non-prescription): Diagnosis code 9' 
   J2MQC10 = 'Quasi (non-prescription): Drug code 10' 
   J2MQDD10= 'Quasi (non-prescription): Dosage 10' 
   J2MQDU10= 'Quasi (non-prescription): Dosage units 10' 
   J2MQR10 = 'Quasi (non-prescription): Method of taking (route) 10' 
   J2MQF10 = 'Quasi (non-prescription): Frequency 10' 
   J2MQFU10= 'Quasi (non-prescription): Frequency units 10' 
   J2MQT10 = 'Quasi (non-prescription): Taken for how long 10' 
   J2MQTU10= 'Quasi (non-prescription): Taken for how long units 10' 
   J2MQDC10= 'Quasi (non-prescription): Diagnosis code 10' 
   J2ML    = 'Any Medication Allergies?' 
   J2MLM   = 'Allergies: Number of Medication Allergies' 
   J2MLC1  = 'Allergies: Drug code 1' 
   J2MLC2  = 'Allergies: Drug code 2' 
   J2MLC3  = 'Allergies: Drug code 3' 
   J2MLC4  = 'Allergies: Drug code 4' 
   J2MLC5  = 'Allergies: Drug code 5' 
   J2MLC6  = 'Allergies: Drug code 6' 
   J2MLC7  = 'Allergies: Drug code 7' 
        ; 


* USER-DEFINED MISSING VALUES RECODE TO SAS SYSMIS;

/*
   IF (J2Q1A = 7 OR J2Q1A = 8 OR J2Q1A = 9) THEN J2Q1A = .;
   IF (J2Q1AD = 7 OR J2Q1AD = 8 OR J2Q1AD = 9) THEN J2Q1AD = .;
   IF (J2Q1B = 7 OR J2Q1B = 8 OR J2Q1B = 9) THEN J2Q1B = .;
   IF (J2Q1BD = 7 OR J2Q1BD = 8 OR J2Q1BD = 9) THEN J2Q1BD = .;
   IF (J2Q1C = 7 OR J2Q1C = 8 OR J2Q1C = 9) THEN J2Q1C = .;
   IF (J2Q1CD = 7 OR J2Q1CD = 8 OR J2Q1CD = 9) THEN J2Q1CD = .;
   IF (J2Q1D = 7 OR J2Q1D = 8 OR J2Q1D = 9) THEN J2Q1D = .;
   IF (J2Q1DD = 7 OR J2Q1DD = 8 OR J2Q1DD = 9) THEN J2Q1DD = .;
   IF (J2Q1E = 7 OR J2Q1E = 8 OR J2Q1E = 9) THEN J2Q1E = .;
   IF (J2Q1ED = 7 OR J2Q1ED = 8 OR J2Q1ED = 9) THEN J2Q1ED = .;
   IF (J2Q1F = 7 OR J2Q1F = 8 OR J2Q1F = 9) THEN J2Q1F = .;
   IF (J2Q1FD = 7 OR J2Q1FD = 8 OR J2Q1FD = 9) THEN J2Q1FD = .;
   IF (J2Q1G = 7 OR J2Q1G = 8 OR J2Q1G = 9) THEN J2Q1G = .;
   IF (J2Q1GD = 7 OR J2Q1GD = 8 OR J2Q1GD = 9) THEN J2Q1GD = .;
   IF (J2Q1H = 7 OR J2Q1H = 8 OR J2Q1H = 9) THEN J2Q1H = .;
   IF (J2Q1HD = 7 OR J2Q1HD = 8 OR J2Q1HD = 9) THEN J2Q1HD = .;
   IF (J2Q1I = 7 OR J2Q1I = 8 OR J2Q1I = 9) THEN J2Q1I = .;
   IF (J2Q1ID = 7 OR J2Q1ID = 8 OR J2Q1ID = 9) THEN J2Q1ID = .;
   IF (J2Q1J = 7 OR J2Q1J = 8 OR J2Q1J = 9) THEN J2Q1J = .;
   IF (J2Q1JD = 7 OR J2Q1JD = 8 OR J2Q1JD = 9) THEN J2Q1JD = .;
   IF (J2Q1K = 7 OR J2Q1K = 8 OR J2Q1K = 9) THEN J2Q1K = .;
   IF (J2Q1KD = 7 OR J2Q1KD = 8 OR J2Q1KD = 9) THEN J2Q1KD = .;
   IF (J2Q1L = 7 OR J2Q1L = 8 OR J2Q1L = 9) THEN J2Q1L = .;
   IF (J2Q1LD = 7 OR J2Q1LD = 8 OR J2Q1LD = 9) THEN J2Q1LD = .;
   IF (J2Q1M = 7 OR J2Q1M = 8 OR J2Q1M = 9) THEN J2Q1M = .;
   IF (J2Q1MD = 7 OR J2Q1MD = 8 OR J2Q1MD = 9) THEN J2Q1MD = .;
   IF (J2Q1N = 7 OR J2Q1N = 8 OR J2Q1N = 9) THEN J2Q1N = .;
   IF (J2Q1ND = 7 OR J2Q1ND = 8 OR J2Q1ND = 9) THEN J2Q1ND = .;
   IF (J2Q1O = 7 OR J2Q1O = 8 OR J2Q1O = 9) THEN J2Q1O = .;
   IF (J2Q1OD = 7 OR J2Q1OD = 8 OR J2Q1OD = 9) THEN J2Q1OD = .;
   IF (J2Q1P = 7 OR J2Q1P = 8 OR J2Q1P = 9) THEN J2Q1P = .;
   IF (J2Q1PD = 7 OR J2Q1PD = 8 OR J2Q1PD = 9) THEN J2Q1PD = .;
   IF (J2Q1Q = 7 OR J2Q1Q = 8 OR J2Q1Q = 9) THEN J2Q1Q = .;
   IF (J2Q1QD = 7 OR J2Q1QD = 8 OR J2Q1QD = 9) THEN J2Q1QD = .;
   IF (J2Q1R = 7 OR J2Q1R = 8 OR J2Q1R = 9) THEN J2Q1R = .;
   IF (J2Q1RD = 7 OR J2Q1RD = 8 OR J2Q1RD = 9) THEN J2Q1RD = .;
   IF (J2Q1S = 7 OR J2Q1S = 8 OR J2Q1S = 9) THEN J2Q1S = .;
   IF (J2Q1SD = 7 OR J2Q1SD = 8 OR J2Q1SD = 9) THEN J2Q1SD = .;
   IF (J2Q1T = 7 OR J2Q1T = 8 OR J2Q1T = 9) THEN J2Q1T = .;
   IF (J2Q1TD = 7 OR J2Q1TD = 8 OR J2Q1TD = 9) THEN J2Q1TD = .;
   IF (J2Q1U = 7 OR J2Q1U = 8 OR J2Q1U = 9) THEN J2Q1U = .;
   IF (J2Q1UD = 7 OR J2Q1UD = 8 OR J2Q1UD = 9) THEN J2Q1UD = .;
   IF (J2Q1V = 7 OR J2Q1V = 8 OR J2Q1V = 9) THEN J2Q1V = .;
   IF (J2Q1VD = 7 OR J2Q1VD = 8 OR J2Q1VD = 9) THEN J2Q1VD = .;
   IF (J2Q1W = 7 OR J2Q1W = 8 OR J2Q1W = 9) THEN J2Q1W = .;
   IF (J2Q1WD = 7 OR J2Q1WD = 8 OR J2Q1WD = 9) THEN J2Q1WD = .;
   IF (J2Q1X = 7 OR J2Q1X = 8 OR J2Q1X = 9) THEN J2Q1X = .;
   IF (J2Q1XD = 7 OR J2Q1XD = 8 OR J2Q1XD = 9) THEN J2Q1XD = .;
   IF (J2Q1Y = 7 OR J2Q1Y = 8 OR J2Q1Y = 9) THEN J2Q1Y = .;
   IF (J2Q1YD = 7 OR J2Q1YD = 8 OR J2Q1YD = 9) THEN J2Q1YD = .;
   IF (J2Q1Z = 7 OR J2Q1Z = 8 OR J2Q1Z = 9) THEN J2Q1Z = .;
   IF (J2Q1ZD = 7 OR J2Q1ZD = 8 OR J2Q1ZD = 9) THEN J2Q1ZD = .;
   IF (J2Q1AA = 7 OR J2Q1AA = 8 OR J2Q1AA = 9) THEN J2Q1AA = .;
   IF (J2Q1AAD = 7 OR J2Q1AAD = 8 OR J2Q1AAD = 9) THEN J2Q1AAD = .;
   IF (J2Q1BB = 7 OR J2Q1BB = 8 OR J2Q1BB = 9) THEN J2Q1BB = .;
   IF (J2Q1BBD = 7 OR J2Q1BBD = 8 OR J2Q1BBD = 9) THEN J2Q1BBD = .;
   IF (J2Q1CC = 7 OR J2Q1CC = 8 OR J2Q1CC = 9) THEN J2Q1CC = .;
   IF (J2Q1CCD = 7 OR J2Q1CCD = 8 OR J2Q1CCD = 9) THEN J2Q1CCD = .;
   IF (J2Q1EE = 7 OR J2Q1EE = 8 OR J2Q1EE = 9) THEN J2Q1EE = .;
   IF (J2Q1EED = 7 OR J2Q1EED = 8 OR J2Q1EED = 9) THEN J2Q1EED = .;
   IF (J2Q1FF = 7 OR J2Q1FF = 8 OR J2Q1FF = 9) THEN J2Q1FF = .;
   IF (J2Q1FFD = 7 OR J2Q1FFD = 8 OR J2Q1FFD = 9) THEN J2Q1FFD = .;
   IF (J2Q2 = 8 OR J2Q2 = 9) THEN J2Q2 = .;
   IF (J2Q2A = 7 OR J2Q2A = 8 OR J2Q2A = 9) THEN J2Q2A = .;
   IF (J2Q2A2 = 7 OR J2Q2A2 = 8 OR J2Q2A2 = 9) THEN J2Q2A2 = .;
   IF (J2Q2B1 = 7 OR J2Q2B1 = 8 OR J2Q2B1 = 9) THEN J2Q2B1 = .;
   IF (J2Q2B2 = 7 OR J2Q2B2 = 8 OR J2Q2B2 = 9) THEN J2Q2B2 = .;
   IF (J2Q2B3 = 7 OR J2Q2B3 = 8 OR J2Q2B3 = 9) THEN J2Q2B3 = .;
   IF (J2Q2B4 = 7 OR J2Q2B4 = 8 OR J2Q2B4 = 9) THEN J2Q2B4 = .;
   IF (J2Q2B5 = 7 OR J2Q2B5 = 8 OR J2Q2B5 = 9) THEN J2Q2B5 = .;
   IF (J2Q2B6 = 7 OR J2Q2B6 = 8 OR J2Q2B6 = 9) THEN J2Q2B6 = .;
   IF (J2Q2B7 = 7 OR J2Q2B7 = 8 OR J2Q2B7 = 9) THEN J2Q2B7 = .;
   IF (J2Q2B8 = 7 OR J2Q2B8 = 8 OR J2Q2B8 = 9) THEN J2Q2B8 = .;
   IF (J2Q2B9 = 7 OR J2Q2B9 = 8 OR J2Q2B9 = 9) THEN J2Q2B9 = .;
   IF (J2Q2B10 = 7 OR J2Q2B10 = 8 OR J2Q2B10 = 9) THEN J2Q2B10 = .;
   IF (J2Q3 = 7 OR J2Q3 = 8 OR J2Q3 = 9) THEN J2Q3 = .;
   IF (J2Q3AH = 7 OR J2Q3AH = 8 OR J2Q3AH = 9) THEN J2Q3AH = .;
   IF (J2Q3AEM = 7 OR J2Q3AEM = 8 OR J2Q3AEM = 9) THEN J2Q3AEM = .;
   IF (J2Q3AEMY = 97 OR J2Q3AEMY = 98 OR J2Q3AEMY = 99) THEN J2Q3AEMY = .;
   IF (J2Q3ACEY = 9997 OR J2Q3ACEY = 9998 OR J2Q3ACEY = 9999) THEN J2Q3ACEY = .;
   IF (J2Q3BH = 7 OR J2Q3BH = 8 OR J2Q3BH = 9) THEN J2Q3BH = .;
   IF (J2Q3BEM = 7 OR J2Q3BEM = 8 OR J2Q3BEM = 9) THEN J2Q3BEM = .;
   IF (J2Q3BEMY = 97 OR J2Q3BEMY = 98 OR J2Q3BEMY = 99) THEN J2Q3BEMY = .;
   IF (J2Q3BCEY = 9997 OR J2Q3BCEY = 9998 OR J2Q3BCEY = 9999) THEN J2Q3BCEY = .;
   IF (J2Q4 = 7 OR J2Q4 = 8 OR J2Q4 = 9) THEN J2Q4 = .;
   IF (J2Q4AH = 7 OR J2Q4AH = 8 OR J2Q4AH = 9) THEN J2Q4AH = .;
   IF (J2Q4AEM = 7 OR J2Q4AEM = 8 OR J2Q4AEM = 9) THEN J2Q4AEM = .;
   IF (J2Q4AEMY = 97 OR J2Q4AEMY = 98 OR J2Q4AEMY = 99) THEN J2Q4AEMY = .;
   IF (J2Q4ACEY = 9997 OR J2Q4ACEY = 9998 OR J2Q4ACEY = 9999) THEN J2Q4ACEY = .;
   IF (J2Q4BH = 7 OR J2Q4BH = 8 OR J2Q4BH = 9) THEN J2Q4BH = .;
   IF (J2Q4BEM = 7 OR J2Q4BEM = 8 OR J2Q4BEM = 9) THEN J2Q4BEM = .;
   IF (J2Q4BEMY = 97 OR J2Q4BEMY = 98 OR J2Q4BEMY = 99) THEN J2Q4BEMY = .;
   IF (J2Q4BCEY = 9997 OR J2Q4BCEY = 9998 OR J2Q4BCEY = 9999) THEN J2Q4BCEY = .;
   IF (J2Q5 = 7 OR J2Q5 = 8 OR J2Q5 = 9) THEN J2Q5 = .;
   IF (J2Q5AH = 7 OR J2Q5AH = 8 OR J2Q5AH = 9) THEN J2Q5AH = .;
   IF (J2Q5AEM = 7 OR J2Q5AEM = 8 OR J2Q5AEM = 9) THEN J2Q5AEM = .;
   IF (J2Q5AEMY = 97 OR J2Q5AEMY = 98 OR J2Q5AEMY = 99) THEN J2Q5AEMY = .;
   IF (J2Q5ACEY = 9997 OR J2Q5ACEY = 9998 OR J2Q5ACEY = 9999) THEN J2Q5ACEY = .;
   IF (J2Q5BH = 7 OR J2Q5BH = 8 OR J2Q5BH = 9) THEN J2Q5BH = .;
   IF (J2Q5BEM = 7 OR J2Q5BEM = 8 OR J2Q5BEM = 9) THEN J2Q5BEM = .;
   IF (J2Q5BEMY = 97 OR J2Q5BEMY = 98 OR J2Q5BEMY = 99) THEN J2Q5BEMY = .;
   IF (J2Q5BCEY = 9997 OR J2Q5BCEY = 9998 OR J2Q5BCEY = 9999) THEN J2Q5BCEY = .;
   IF (J2Q6 = 7 OR J2Q6 = 8 OR J2Q6 = 9) THEN J2Q6 = .;
   IF (J2Q6AH = 7 OR J2Q6AH = 8 OR J2Q6AH = 9) THEN J2Q6AH = .;
   IF (J2Q6AEM = 7 OR J2Q6AEM = 8 OR J2Q6AEM = 9) THEN J2Q6AEM = .;
   IF (J2Q6AEMY = 97 OR J2Q6AEMY = 98 OR J2Q6AEMY = 99) THEN J2Q6AEMY = .;
   IF (J2Q6ACEY = 9997 OR J2Q6ACEY = 9998 OR J2Q6ACEY = 9999) THEN J2Q6ACEY = .;
   IF (J2Q6BH = 7 OR J2Q6BH = 8 OR J2Q6BH = 9) THEN J2Q6BH = .;
   IF (J2Q6BEM = 7 OR J2Q6BEM = 8 OR J2Q6BEM = 9) THEN J2Q6BEM = .;
   IF (J2Q6BEMY = 97 OR J2Q6BEMY = 98 OR J2Q6BEMY = 99) THEN J2Q6BEMY = .;
   IF (J2Q6BCEY = 9997 OR J2Q6BCEY = 9998 OR J2Q6BCEY = 9999) THEN J2Q6BCEY = .;
   IF (J2Q7AMPM = 7 OR J2Q7AMPM = 8 OR J2Q7AMPM = 9) THEN J2Q7AMPM = .;
   IF (J2Q7H = 97 OR J2Q7H = 98 OR J2Q7H = 99) THEN J2Q7H = .;
   IF (J2Q7M = 97 OR J2Q7M = 98 OR J2Q7M = 99) THEN J2Q7M = .;
   IF (J2Q8 = 997 OR J2Q8 = 998 OR J2Q8 = 999) THEN J2Q8 = .;
   IF (J2Q9AMPM = 7 OR J2Q9AMPM = 8 OR J2Q9AMPM = 9) THEN J2Q9AMPM = .;
   IF (J2Q9H = 97 OR J2Q9H = 98 OR J2Q9H = 99) THEN J2Q9H = .;
   IF (J2Q9M = 97 OR J2Q9M = 98 OR J2Q9M = 99) THEN J2Q9M = .;
   IF (J2Q10H = 97 OR J2Q10H = 98 OR J2Q10H = 99) THEN J2Q10H = .;
   IF (J2Q10M = 97 OR J2Q10M = 98 OR J2Q10M = 99) THEN J2Q10M = .;
   IF (J2Q11A = 7 OR J2Q11A = 8 OR J2Q11A = 9) THEN J2Q11A = .;
   IF (J2Q11B = 7 OR J2Q11B = 8 OR J2Q11B = 9) THEN J2Q11B = .;
   IF (J2Q11C = 7 OR J2Q11C = 8 OR J2Q11C = 9) THEN J2Q11C = .;
   IF (J2Q11D = 7 OR J2Q11D = 8 OR J2Q11D = 9) THEN J2Q11D = .;
   IF (J2Q11E = 7 OR J2Q11E = 8 OR J2Q11E = 9) THEN J2Q11E = .;
   IF (J2Q11F = 7 OR J2Q11F = 8 OR J2Q11F = 9) THEN J2Q11F = .;
   IF (J2Q11G = 7 OR J2Q11G = 8 OR J2Q11G = 9) THEN J2Q11G = .;
   IF (J2Q11H = 7 OR J2Q11H = 8 OR J2Q11H = 9) THEN J2Q11H = .;
   IF (J2Q11I = 7 OR J2Q11I = 8 OR J2Q11I = 9) THEN J2Q11I = .;
   IF (J2Q11J = 7 OR J2Q11J = 8 OR J2Q11J = 9) THEN J2Q11J = .;
   IF (J2Q12 = 7 OR J2Q12 = 8 OR J2Q12 = 9) THEN J2Q12 = .;
   IF (J2Q13 = 7 OR J2Q13 = 8 OR J2Q13 = 9) THEN J2Q13 = .;
   IF (J2Q14 = 7 OR J2Q14 = 8 OR J2Q14 = 9) THEN J2Q14 = .;
   IF (J2Q15 = 7 OR J2Q15 = 8 OR J2Q15 = 9) THEN J2Q15 = .;
   IF (J2Q16 = 7 OR J2Q16 = 8 OR J2Q16 = 9) THEN J2Q16 = .;
   IF (J2QSQ_S1 = 8) THEN J2QSQ_S1 = .;
   IF (J2QSQ_S2 = 8) THEN J2QSQ_S2 = .;
   IF (J2QSQ_S3 = 8) THEN J2QSQ_S3 = .;
   IF (J2QSQ_S4 = 8) THEN J2QSQ_S4 = .;
   IF (J2QSQ_S5 = 8) THEN J2QSQ_S5 = .;
   IF (J2QSQ_S6 = 8) THEN J2QSQ_S6 = .;
   IF (J2QSQ_S7 = 8) THEN J2QSQ_S7 = .;
   IF (J2QSQ_GS = 98) THEN J2QSQ_GS = .;
   IF (J2Q17 = 7 OR J2Q17 = 8 OR J2Q17 = 9) THEN J2Q17 = .;
   IF (J2Q18 = 97 OR J2Q18 = 98 OR J2Q18 = 99) THEN J2Q18 = .;
   IF (J2Q19 = 97 OR J2Q19 = 98 OR J2Q19 = 99) THEN J2Q19 = .;
   IF (J2Q20 = 97 OR J2Q20 = 98 OR J2Q20 = 99) THEN J2Q20 = .;
   IF (J2Q21 = 97 OR J2Q21 = 98 OR J2Q21 = 99) THEN J2Q21 = .;
   IF (J2Q22 = 97 OR J2Q22 = 98 OR J2Q22 = 99) THEN J2Q22 = .;
   IF (J2Q23A = 7 OR J2Q23A = 8 OR J2Q23A = 9) THEN J2Q23A = .;
   IF (J2Q23B = 7 OR J2Q23B = 8 OR J2Q23B = 9) THEN J2Q23B = .;
   IF (J2Q23C = 7 OR J2Q23C = 8 OR J2Q23C = 9) THEN J2Q23C = .;
   IF (J2Q23D = 7 OR J2Q23D = 8 OR J2Q23D = 9) THEN J2Q23D = .;
   IF (J2Q23E = 7 OR J2Q23E = 8 OR J2Q23E = 9) THEN J2Q23E = .;
   IF (J2Q23F = 7 OR J2Q23F = 8 OR J2Q23F = 9) THEN J2Q23F = .;
   IF (J2Q23G = 7 OR J2Q23G = 8 OR J2Q23G = 9) THEN J2Q23G = .;
   IF (J2Q23H = 7 OR J2Q23H = 8 OR J2Q23H = 9) THEN J2Q23H = .;
   IF (J2Q23I = 7 OR J2Q23I = 8 OR J2Q23I = 9) THEN J2Q23I = .;
   IF (J2Q24 = 7 OR J2Q24 = 8 OR J2Q24 = 9) THEN J2Q24 = .;
   IF (J2Q26 = 7 OR J2Q26 = 8 OR J2Q26 = 9) THEN J2Q26 = .;
   IF (J2Q27A = 97 OR J2Q27A = 98 OR J2Q27A = 99) THEN J2Q27A = .;
   IF (J2Q27B = 97 OR J2Q27B = 98 OR J2Q27B = 99) THEN J2Q27B = .;
   IF (J2Q27C = 97 OR J2Q27C = 98 OR J2Q27C = 99) THEN J2Q27C = .;
   IF (J2Q28A = 97 OR J2Q28A = 98 OR J2Q28A = 99) THEN J2Q28A = .;
   IF (J2Q28B = 97 OR J2Q28B = 98 OR J2Q28B = 99) THEN J2Q28B = .;
   IF (J2Q28C = 97 OR J2Q28C = 98 OR J2Q28C = 99) THEN J2Q28C = .;
   IF (J2Q28D = 97 OR J2Q28D = 98 OR J2Q28D = 99) THEN J2Q28D = .;
   IF (J2Q29 = 7 OR J2Q29 = 8 OR J2Q29 = 9) THEN J2Q29 = .;
   IF (J2Q30 = 7 OR J2Q30 = 8 OR J2Q30 = 9) THEN J2Q30 = .;
   IF (J2Q31 = 7 OR J2Q31 = 8 OR J2Q31 = 9) THEN J2Q31 = .;
   IF (J2Q32 = 7 OR J2Q32 = 8 OR J2Q32 = 9) THEN J2Q32 = .;
   IF (J2Q33 = 7 OR J2Q33 = 8 OR J2Q33 = 9) THEN J2Q33 = .;
   IF (J2Q34A = 7 OR J2Q34A = 8 OR J2Q34A = 9) THEN J2Q34A = .;
   IF (J2Q34B = 7 OR J2Q34B = 8 OR J2Q34B = 9) THEN J2Q34B = .;
   IF (J2Q34C = 7 OR J2Q34C = 8 OR J2Q34C = 9) THEN J2Q34C = .;
   IF (J2Q34D = 7 OR J2Q34D = 8 OR J2Q34D = 9) THEN J2Q34D = .;
   IF (J2Q35 = 7 OR J2Q35 = 8 OR J2Q35 = 9) THEN J2Q35 = .;
   IF (J2Q36 = 7 OR J2Q36 = 8 OR J2Q36 = 9) THEN J2Q36 = .;
   IF (J2Q37M = 97 OR J2Q37M = 98 OR J2Q37M = 99) THEN J2Q37M = .;
   IF (J2Q37Y = 9997 OR J2Q37Y = 9998 OR J2Q37Y = 9999) THEN J2Q37Y = .;
   IF (J2Q38 = 7 OR J2Q38 = 8 OR J2Q38 = 9) THEN J2Q38 = .;
   IF (J2QMARR = 7 OR J2QMARR = 8 OR J2QMARR = 9) THEN J2QMARR = .;
   IF (J2Q39 = 7 OR J2Q39 = 8 OR J2Q39 = 9) THEN J2Q39 = .;
   IF (J2Q39AG = 7 OR J2Q39AG = 8 OR J2Q39AG = 9) THEN J2Q39AG = .;
   IF (J2Q39AM = 97 OR J2Q39AM = 98 OR J2Q39AM = 99) THEN J2Q39AM = .;
   IF (J2Q39AY = 9997 OR J2Q39AY = 9998 OR J2Q39AY = 9999) THEN J2Q39AY = .;
   IF (J2Q39BG = 7 OR J2Q39BG = 8 OR J2Q39BG = 9) THEN J2Q39BG = .;
   IF (J2Q39BM = 97 OR J2Q39BM = 98 OR J2Q39BM = 99) THEN J2Q39BM = .;
   IF (J2Q39BY = 9997 OR J2Q39BY = 9998 OR J2Q39BY = 9999) THEN J2Q39BY = .;
   IF (J2Q39CG = 7 OR J2Q39CG = 8 OR J2Q39CG = 9) THEN J2Q39CG = .;
   IF (J2Q39CM = 97 OR J2Q39CM = 98 OR J2Q39CM = 99) THEN J2Q39CM = .;
   IF (J2Q39CY = 9997 OR J2Q39CY = 9998 OR J2Q39CY = 9999) THEN J2Q39CY = .;
   IF (J2Q40A = 7) THEN J2Q40A = .;
   IF (J2Q40A1 = 97 OR J2Q40A1 = 98 OR J2Q40A1 = 99) THEN J2Q40A1 = .;
   IF (J2Q40A3 = 7 OR J2Q40A3 = 8 OR J2Q40A3 = 9) THEN J2Q40A3 = .;
   IF (J2Q40A4 = 7 OR J2Q40A4 = 8 OR J2Q40A4 = 9) THEN J2Q40A4 = .;
   IF (J2Q40B = 7) THEN J2Q40B = .;
   IF (J2Q40B1 = 97 OR J2Q40B1 = 98 OR J2Q40B1 = 99) THEN J2Q40B1 = .;
   IF (J2Q40B3 = 7 OR J2Q40B3 = 8 OR J2Q40B3 = 9) THEN J2Q40B3 = .;
   IF (J2Q40B4 = 7 OR J2Q40B4 = 8 OR J2Q40B4 = 9) THEN J2Q40B4 = .;
   IF (J2Q40C = 7) THEN J2Q40C = .;
   IF (J2Q40C1 = 97 OR J2Q40C1 = 98 OR J2Q40C1 = 99) THEN J2Q40C1 = .;
   IF (J2Q40C3 = 7 OR J2Q40C3 = 8 OR J2Q40C3 = 9) THEN J2Q40C3 = .;
   IF (J2Q40C4 = 7 OR J2Q40C4 = 8 OR J2Q40C4 = 9) THEN J2Q40C4 = .;
   IF (J2Q40D = 7) THEN J2Q40D = .;
   IF (J2Q40D1 = 97 OR J2Q40D1 = 98 OR J2Q40D1 = 99) THEN J2Q40D1 = .;
   IF (J2Q40D3 = 7 OR J2Q40D3 = 8 OR J2Q40D3 = 9) THEN J2Q40D3 = .;
   IF (J2Q40D4 = 7 OR J2Q40D4 = 8 OR J2Q40D4 = 9) THEN J2Q40D4 = .;
   IF (J2Q40E = 7) THEN J2Q40E = .;
   IF (J2Q40E1 = 97 OR J2Q40E1 = 98 OR J2Q40E1 = 99) THEN J2Q40E1 = .;
   IF (J2Q40E3 = 7 OR J2Q40E3 = 8 OR J2Q40E3 = 9) THEN J2Q40E3 = .;
   IF (J2Q40E4 = 7 OR J2Q40E4 = 8 OR J2Q40E4 = 9) THEN J2Q40E4 = .;
   IF (J2Q40F = 7) THEN J2Q40F = .;
   IF (J2Q40F1 = 97 OR J2Q40F1 = 98 OR J2Q40F1 = 99) THEN J2Q40F1 = .;
   IF (J2Q40F3 = 7 OR J2Q40F3 = 8 OR J2Q40F3 = 9) THEN J2Q40F3 = .;
   IF (J2Q40F4 = 7 OR J2Q40F4 = 8 OR J2Q40F4 = 9) THEN J2Q40F4 = .;
   IF (J2Q40G = 7) THEN J2Q40G = .;
   IF (J2Q40G1 = 97 OR J2Q40G1 = 98 OR J2Q40G1 = 99) THEN J2Q40G1 = .;
   IF (J2Q40G3 = 7 OR J2Q40G3 = 8 OR J2Q40G3 = 9) THEN J2Q40G3 = .;
   IF (J2Q40G4 = 7 OR J2Q40G4 = 8 OR J2Q40G4 = 9) THEN J2Q40G4 = .;
   IF (J2Q41H = 7) THEN J2Q41H = .;
   IF (J2Q41H1 = 97 OR J2Q41H1 = 98 OR J2Q41H1 = 99) THEN J2Q41H1 = .;
   IF (J2Q41H3 = 7 OR J2Q41H3 = 8 OR J2Q41H3 = 9) THEN J2Q41H3 = .;
   IF (J2Q41H4 = 7 OR J2Q41H4 = 8 OR J2Q41H4 = 9) THEN J2Q41H4 = .;
   IF (J2Q41I = 7) THEN J2Q41I = .;
   IF (J2Q41I1 = 97 OR J2Q41I1 = 98 OR J2Q41I1 = 99) THEN J2Q41I1 = .;
   IF (J2Q41I3 = 7 OR J2Q41I3 = 8 OR J2Q41I3 = 9) THEN J2Q41I3 = .;
   IF (J2Q41I4 = 7 OR J2Q41I4 = 8 OR J2Q41I4 = 9) THEN J2Q41I4 = .;
   IF (J2Q41J = 7) THEN J2Q41J = .;
   IF (J2Q41J1 = 97 OR J2Q41J1 = 98 OR J2Q41J1 = 99) THEN J2Q41J1 = .;
   IF (J2Q41J3 = 7 OR J2Q41J3 = 8 OR J2Q41J3 = 9) THEN J2Q41J3 = .;
   IF (J2Q41J4 = 7 OR J2Q41J4 = 8 OR J2Q41J4 = 9) THEN J2Q41J4 = .;
   IF (J2Q41K = 7) THEN J2Q41K = .;
   IF (J2Q41K1 = 97 OR J2Q41K1 = 98 OR J2Q41K1 = 99) THEN J2Q41K1 = .;
   IF (J2Q41K3 = 7 OR J2Q41K3 = 8 OR J2Q41K3 = 9) THEN J2Q41K3 = .;
   IF (J2Q41K4 = 7 OR J2Q41K4 = 8 OR J2Q41K4 = 9) THEN J2Q41K4 = .;
   IF (J2Q41L = 7) THEN J2Q41L = .;
   IF (J2Q41L1 = 97 OR J2Q41L1 = 98 OR J2Q41L1 = 99) THEN J2Q41L1 = .;
   IF (J2Q41L3 = 7 OR J2Q41L3 = 8 OR J2Q41L3 = 9) THEN J2Q41L3 = .;
   IF (J2Q41L4 = 7 OR J2Q41L4 = 8 OR J2Q41L4 = 9) THEN J2Q41L4 = .;
   IF (J2Q41M = 7) THEN J2Q41M = .;
   IF (J2Q41M1 = 97 OR J2Q41M1 = 98 OR J2Q41M1 = 99) THEN J2Q41M1 = .;
   IF (J2Q41M3 = 7 OR J2Q41M3 = 8 OR J2Q41M3 = 9) THEN J2Q41M3 = .;
   IF (J2Q41M4 = 7 OR J2Q41M4 = 8 OR J2Q41M4 = 9) THEN J2Q41M4 = .;
   IF (J2Q41N = 7) THEN J2Q41N = .;
   IF (J2Q41N1 = 97 OR J2Q41N1 = 98 OR J2Q41N1 = 99) THEN J2Q41N1 = .;
   IF (J2Q41N3 = 7 OR J2Q41N3 = 8 OR J2Q41N3 = 9) THEN J2Q41N3 = .;
   IF (J2Q41N4 = 7 OR J2Q41N4 = 8 OR J2Q41N4 = 9) THEN J2Q41N4 = .;
   IF (J2Q41O = 7) THEN J2Q41O = .;
   IF (J2Q41O1 = 97 OR J2Q41O1 = 98 OR J2Q41O1 = 99) THEN J2Q41O1 = .;
   IF (J2Q41O3 = 7 OR J2Q41O3 = 8 OR J2Q41O3 = 9) THEN J2Q41O3 = .;
   IF (J2Q41O4 = 7 OR J2Q41O4 = 8 OR J2Q41O4 = 9) THEN J2Q41O4 = .;
   IF (J2Q41P = 7) THEN J2Q41P = .;
   IF (J2Q41P1 = 97 OR J2Q41P1 = 98 OR J2Q41P1 = 99) THEN J2Q41P1 = .;
   IF (J2Q41P3 = 7 OR J2Q41P3 = 8 OR J2Q41P3 = 9) THEN J2Q41P3 = .;
   IF (J2Q41P4 = 7 OR J2Q41P4 = 8 OR J2Q41P4 = 9) THEN J2Q41P4 = .;
   IF (J2Q41Q = 7) THEN J2Q41Q = .;
   IF (J2Q41Q1 = 97 OR J2Q41Q1 = 98 OR J2Q41Q1 = 99) THEN J2Q41Q1 = .;
   IF (J2Q41Q3 = 7 OR J2Q41Q3 = 8 OR J2Q41Q3 = 9) THEN J2Q41Q3 = .;
   IF (J2Q41Q4 = 7 OR J2Q41Q4 = 8 OR J2Q41Q4 = 9) THEN J2Q41Q4 = .;
   IF (J2Q41R = 7) THEN J2Q41R = .;
   IF (J2Q41R1 = 97 OR J2Q41R1 = 98 OR J2Q41R1 = 99) THEN J2Q41R1 = .;
   IF (J2Q41R3 = 7 OR J2Q41R3 = 8 OR J2Q41R3 = 9) THEN J2Q41R3 = .;
   IF (J2Q41R4 = 7 OR J2Q41R4 = 8 OR J2Q41R4 = 9) THEN J2Q41R4 = .;
   IF (J2Q41S = 7) THEN J2Q41S = .;
   IF (J2Q41S1 = 97 OR J2Q41S1 = 98 OR J2Q41S1 = 99) THEN J2Q41S1 = .;
   IF (J2Q41S3 = 7 OR J2Q41S3 = 8 OR J2Q41S3 = 9) THEN J2Q41S3 = .;
   IF (J2Q41S4 = 7 OR J2Q41S4 = 8 OR J2Q41S4 = 9) THEN J2Q41S4 = .;
   IF (J2Q41T = 7) THEN J2Q41T = .;
   IF (J2Q41T1 = 97 OR J2Q41T1 = 98 OR J2Q41T1 = 99) THEN J2Q41T1 = .;
   IF (J2Q41T3 = 7 OR J2Q41T3 = 8 OR J2Q41T3 = 9) THEN J2Q41T3 = .;
   IF (J2Q41T4 = 7 OR J2Q41T4 = 8 OR J2Q41T4 = 9) THEN J2Q41T4 = .;
   IF (J2Q41U = 7) THEN J2Q41U = .;
   IF (J2Q41U1 = 97 OR J2Q41U1 = 98 OR J2Q41U1 = 99) THEN J2Q41U1 = .;
   IF (J2Q41U3 = 7 OR J2Q41U3 = 8 OR J2Q41U3 = 9) THEN J2Q41U3 = .;
   IF (J2Q41U4 = 7 OR J2Q41U4 = 8 OR J2Q41U4 = 9) THEN J2Q41U4 = .;
   IF (J2Q41V = 7) THEN J2Q41V = .;
   IF (J2Q41V1 = 97 OR J2Q41V1 = 98 OR J2Q41V1 = 99) THEN J2Q41V1 = .;
   IF (J2Q41V3 = 7 OR J2Q41V3 = 8 OR J2Q41V3 = 9) THEN J2Q41V3 = .;
   IF (J2Q41V4 = 7 OR J2Q41V4 = 8 OR J2Q41V4 = 9) THEN J2Q41V4 = .;
   IF (J2Q41W = 7) THEN J2Q41W = .;
   IF (J2Q41W1 = 97 OR J2Q41W1 = 98 OR J2Q41W1 = 99) THEN J2Q41W1 = .;
   IF (J2Q41W3 = 7 OR J2Q41W3 = 8 OR J2Q41W3 = 9) THEN J2Q41W3 = .;
   IF (J2Q41W4 = 7 OR J2Q41W4 = 8 OR J2Q41W4 = 9) THEN J2Q41W4 = .;
   IF (J2Q41X = 7) THEN J2Q41X = .;
   IF (J2Q41X1 = 97 OR J2Q41X1 = 98 OR J2Q41X1 = 99) THEN J2Q41X1 = .;
   IF (J2Q41X3 = 7 OR J2Q41X3 = 8 OR J2Q41X3 = 9) THEN J2Q41X3 = .;
   IF (J2Q41X4 = 7 OR J2Q41X4 = 8 OR J2Q41X4 = 9) THEN J2Q41X4 = .;
   IF (J2Q41Y = 7) THEN J2Q41Y = .;
   IF (J2Q41Y1 = 97 OR J2Q41Y1 = 98 OR J2Q41Y1 = 99) THEN J2Q41Y1 = .;
   IF (J2Q41Y3 = 7 OR J2Q41Y3 = 8 OR J2Q41Y3 = 9) THEN J2Q41Y3 = .;
   IF (J2Q41Y4 = 7 OR J2Q41Y4 = 8 OR J2Q41Y4 = 9) THEN J2Q41Y4 = .;
   IF (J2Q42 = 7 OR J2Q42 = 8 OR J2Q42 = 9) THEN J2Q42 = .;
   IF (J2Q42AM = 97 OR J2Q42AM = 98 OR J2Q42AM = 99) THEN J2Q42AM = .;
   IF (J2Q42AY = 9997 OR J2Q42AY = 9998 OR J2Q42AY = 9999) THEN J2Q42AY = .;
   IF (J2Q42BM = 97 OR J2Q42BM = 98 OR J2Q42BM = 99) THEN J2Q42BM = .;
   IF (J2Q42BY = 9997 OR J2Q42BY = 9998 OR J2Q42BY = 9999) THEN J2Q42BY = .;
   IF (J2Q42CM = 97 OR J2Q42CM = 98 OR J2Q42CM = 99) THEN J2Q42CM = .;
   IF (J2Q42CY = 9997 OR J2Q42CY = 9998 OR J2Q42CY = 9999) THEN J2Q42CY = .;
   IF (J2Q43A = 7 OR J2Q43A = 8 OR J2Q43A = 9) THEN J2Q43A = .;
   IF (J2Q43B = 7 OR J2Q43B = 8 OR J2Q43B = 9) THEN J2Q43B = .;
   IF (J2Q43C = 7 OR J2Q43C = 8 OR J2Q43C = 9) THEN J2Q43C = .;
   IF (J2Q43D = 7 OR J2Q43D = 8 OR J2Q43D = 9) THEN J2Q43D = .;
   IF (J2Q43E = 7 OR J2Q43E = 8 OR J2Q43E = 9) THEN J2Q43E = .;
   IF (J2Q43F = 7 OR J2Q43F = 8 OR J2Q43F = 9) THEN J2Q43F = .;
   IF (J2Q43G = 7 OR J2Q43G = 8 OR J2Q43G = 9) THEN J2Q43G = .;
   IF (J2Q43H = 7 OR J2Q43H = 8 OR J2Q43H = 9) THEN J2Q43H = .;
   IF (J2Q43I = 7 OR J2Q43I = 8 OR J2Q43I = 9) THEN J2Q43I = .;
   IF (J2Q43J = 7 OR J2Q43J = 8 OR J2Q43J = 9) THEN J2Q43J = .;
   IF (J2Q43K = 7 OR J2Q43K = 8 OR J2Q43K = 9) THEN J2Q43K = .;
   IF (J2Q43L = 7 OR J2Q43L = 8 OR J2Q43L = 9) THEN J2Q43L = .;
   IF (J2Q43M = 7 OR J2Q43M = 8 OR J2Q43M = 9) THEN J2Q43M = .;
   IF (J2Q43N = 7 OR J2Q43N = 8 OR J2Q43N = 9) THEN J2Q43N = .;
   IF (J2Q43O = 7 OR J2Q43O = 8 OR J2Q43O = 9) THEN J2Q43O = .;
   IF (J2Q43P = 7 OR J2Q43P = 8 OR J2Q43P = 9) THEN J2Q43P = .;
   IF (J2Q43Q = 7 OR J2Q43Q = 8 OR J2Q43Q = 9) THEN J2Q43Q = .;
   IF (J2Q43R = 7 OR J2Q43R = 8 OR J2Q43R = 9) THEN J2Q43R = .;
   IF (J2Q43S = 7 OR J2Q43S = 8 OR J2Q43S = 9) THEN J2Q43S = .;
   IF (J2Q43T = 7 OR J2Q43T = 8 OR J2Q43T = 9) THEN J2Q43T = .;
   IF (J2QCESD = 98.0) THEN J2QCESD = .;
   IF (J2Q44A = 7 OR J2Q44A = 8 OR J2Q44A = 9) THEN J2Q44A = .;
   IF (J2Q44B = 7 OR J2Q44B = 8 OR J2Q44B = 9) THEN J2Q44B = .;
   IF (J2Q44C = 7 OR J2Q44C = 8 OR J2Q44C = 9) THEN J2Q44C = .;
   IF (J2Q44D = 7 OR J2Q44D = 8 OR J2Q44D = 9) THEN J2Q44D = .;
   IF (J2Q44E = 7 OR J2Q44E = 8 OR J2Q44E = 9) THEN J2Q44E = .;
   IF (J2Q44F = 7 OR J2Q44F = 8 OR J2Q44F = 9) THEN J2Q44F = .;
   IF (J2Q44G = 7 OR J2Q44G = 8 OR J2Q44G = 9) THEN J2Q44G = .;
   IF (J2Q44H = 7 OR J2Q44H = 8 OR J2Q44H = 9) THEN J2Q44H = .;
   IF (J2Q44I = 7 OR J2Q44I = 8 OR J2Q44I = 9) THEN J2Q44I = .;
   IF (J2Q44J = 7 OR J2Q44J = 8 OR J2Q44J = 9) THEN J2Q44J = .;
   IF (J2Q44K = 7 OR J2Q44K = 8 OR J2Q44K = 9) THEN J2Q44K = .;
   IF (J2Q44L = 7 OR J2Q44L = 8 OR J2Q44L = 9) THEN J2Q44L = .;
   IF (J2Q44M = 7 OR J2Q44M = 8 OR J2Q44M = 9) THEN J2Q44M = .;
   IF (J2Q44N = 7 OR J2Q44N = 8 OR J2Q44N = 9) THEN J2Q44N = .;
   IF (J2Q44O = 7 OR J2Q44O = 8 OR J2Q44O = 9) THEN J2Q44O = .;
   IF (J2Q44P = 7 OR J2Q44P = 8 OR J2Q44P = 9) THEN J2Q44P = .;
   IF (J2Q44Q = 7 OR J2Q44Q = 8 OR J2Q44Q = 9) THEN J2Q44Q = .;
   IF (J2Q44R = 7 OR J2Q44R = 8 OR J2Q44R = 9) THEN J2Q44R = .;
   IF (J2Q44S = 7 OR J2Q44S = 8 OR J2Q44S = 9) THEN J2Q44S = .;
   IF (J2Q44T = 7 OR J2Q44T = 8 OR J2Q44T = 9) THEN J2Q44T = .;
   IF (J2QTA_AX = 98.0) THEN J2QTA_AX = .;
   IF (J2Q45A = 7 OR J2Q45A = 8 OR J2Q45A = 9) THEN J2Q45A = .;
   IF (J2Q45B = 7 OR J2Q45B = 8 OR J2Q45B = 9) THEN J2Q45B = .;
   IF (J2Q45C = 7 OR J2Q45C = 8 OR J2Q45C = 9) THEN J2Q45C = .;
   IF (J2Q45D = 7 OR J2Q45D = 8 OR J2Q45D = 9) THEN J2Q45D = .;
   IF (J2Q45E = 7 OR J2Q45E = 8 OR J2Q45E = 9) THEN J2Q45E = .;
   IF (J2Q45F = 7 OR J2Q45F = 8 OR J2Q45F = 9) THEN J2Q45F = .;
   IF (J2Q45G = 7 OR J2Q45G = 8 OR J2Q45G = 9) THEN J2Q45G = .;
   IF (J2Q45H = 7 OR J2Q45H = 8 OR J2Q45H = 9) THEN J2Q45H = .;
   IF (J2Q45I = 7 OR J2Q45I = 8 OR J2Q45I = 9) THEN J2Q45I = .;
   IF (J2Q45J = 7 OR J2Q45J = 8 OR J2Q45J = 9) THEN J2Q45J = .;
   IF (J2Q45K = 7 OR J2Q45K = 8 OR J2Q45K = 9) THEN J2Q45K = .;
   IF (J2Q45L = 7 OR J2Q45L = 8 OR J2Q45L = 9) THEN J2Q45L = .;
   IF (J2Q45M = 7 OR J2Q45M = 8 OR J2Q45M = 9) THEN J2Q45M = .;
   IF (J2Q45N = 7 OR J2Q45N = 8 OR J2Q45N = 9) THEN J2Q45N = .;
   IF (J2Q45O = 7 OR J2Q45O = 8 OR J2Q45O = 9) THEN J2Q45O = .;
   IF (J2QTA_AG = 98.0) THEN J2QTA_AG = .;
   IF (J2QTA_AT = 98.0) THEN J2QTA_AT = .;
   IF (J2QTA_AR = 98.0) THEN J2QTA_AR = .;
   IF (J2Q46A1 = 7 OR J2Q46A1 = 8 OR J2Q46A1 = 9) THEN J2Q46A1 = .;
   IF (J2Q46A2 = 7 OR J2Q46A2 = 8 OR J2Q46A2 = 9) THEN J2Q46A2 = .;
   IF (J2Q46B1 = 7 OR J2Q46B1 = 8 OR J2Q46B1 = 9) THEN J2Q46B1 = .;
   IF (J2Q46B2 = 7 OR J2Q46B2 = 8 OR J2Q46B2 = 9) THEN J2Q46B2 = .;
   IF (J2Q46C1 = 7 OR J2Q46C1 = 8 OR J2Q46C1 = 9) THEN J2Q46C1 = .;
   IF (J2Q46C2 = 7 OR J2Q46C2 = 8 OR J2Q46C2 = 9) THEN J2Q46C2 = .;
   IF (J2Q46D1 = 7 OR J2Q46D1 = 8 OR J2Q46D1 = 9) THEN J2Q46D1 = .;
   IF (J2Q46D2 = 7 OR J2Q46D2 = 8 OR J2Q46D2 = 9) THEN J2Q46D2 = .;
   IF (J2Q46E1 = 7 OR J2Q46E1 = 8 OR J2Q46E1 = 9) THEN J2Q46E1 = .;
   IF (J2Q46E2 = 7 OR J2Q46E2 = 8 OR J2Q46E2 = 9) THEN J2Q46E2 = .;
   IF (J2Q46F1 = 7 OR J2Q46F1 = 8 OR J2Q46F1 = 9) THEN J2Q46F1 = .;
   IF (J2Q46F2 = 7 OR J2Q46F2 = 8 OR J2Q46F2 = 9) THEN J2Q46F2 = .;
   IF (J2Q46G1 = 7 OR J2Q46G1 = 8 OR J2Q46G1 = 9) THEN J2Q46G1 = .;
   IF (J2Q46G2 = 7 OR J2Q46G2 = 8 OR J2Q46G2 = 9) THEN J2Q46G2 = .;
   IF (J2Q46H1 = 7 OR J2Q46H1 = 8 OR J2Q46H1 = 9) THEN J2Q46H1 = .;
   IF (J2Q46H2 = 7 OR J2Q46H2 = 8 OR J2Q46H2 = 9) THEN J2Q46H2 = .;
   IF (J2Q46I1 = 7 OR J2Q46I1 = 8 OR J2Q46I1 = 9) THEN J2Q46I1 = .;
   IF (J2Q46I2 = 7 OR J2Q46I2 = 8 OR J2Q46I2 = 9) THEN J2Q46I2 = .;
   IF (J2Q46J1 = 7 OR J2Q46J1 = 8 OR J2Q46J1 = 9) THEN J2Q46J1 = .;
   IF (J2Q46J2 = 7 OR J2Q46J2 = 8 OR J2Q46J2 = 9) THEN J2Q46J2 = .;
   IF (J2Q46K1 = 7 OR J2Q46K1 = 8 OR J2Q46K1 = 9) THEN J2Q46K1 = .;
   IF (J2Q46K2 = 7 OR J2Q46K2 = 8 OR J2Q46K2 = 9) THEN J2Q46K2 = .;
   IF (J2Q46L1 = 7 OR J2Q46L1 = 8 OR J2Q46L1 = 9) THEN J2Q46L1 = .;
   IF (J2Q46L2 = 7 OR J2Q46L2 = 8 OR J2Q46L2 = 9) THEN J2Q46L2 = .;
   IF (J2Q46M1 = 7 OR J2Q46M1 = 8 OR J2Q46M1 = 9) THEN J2Q46M1 = .;
   IF (J2Q46M2 = 7 OR J2Q46M2 = 8 OR J2Q46M2 = 9) THEN J2Q46M2 = .;
   IF (J2Q46N1 = 7 OR J2Q46N1 = 8 OR J2Q46N1 = 9) THEN J2Q46N1 = .;
   IF (J2Q46N2 = 7 OR J2Q46N2 = 8 OR J2Q46N2 = 9) THEN J2Q46N2 = .;
   IF (J2Q46O1 = 7 OR J2Q46O1 = 8 OR J2Q46O1 = 9) THEN J2Q46O1 = .;
   IF (J2Q46O2 = 7 OR J2Q46O2 = 8 OR J2Q46O2 = 9) THEN J2Q46O2 = .;
   IF (J2Q46P1 = 7 OR J2Q46P1 = 8 OR J2Q46P1 = 9) THEN J2Q46P1 = .;
   IF (J2Q46P2 = 7 OR J2Q46P2 = 8 OR J2Q46P2 = 9) THEN J2Q46P2 = .;
   IF (J2Q46Q1 = 7 OR J2Q46Q1 = 8 OR J2Q46Q1 = 9) THEN J2Q46Q1 = .;
   IF (J2Q46Q2 = 7 OR J2Q46Q2 = 8 OR J2Q46Q2 = 9) THEN J2Q46Q2 = .;
   IF (J2Q46R1 = 7 OR J2Q46R1 = 8 OR J2Q46R1 = 9) THEN J2Q46R1 = .;
   IF (J2Q46R2 = 7 OR J2Q46R2 = 8 OR J2Q46R2 = 9) THEN J2Q46R2 = .;
   IF (J2Q46S1 = 7 OR J2Q46S1 = 8 OR J2Q46S1 = 9) THEN J2Q46S1 = .;
   IF (J2Q46S2 = 7 OR J2Q46S2 = 8 OR J2Q46S2 = 9) THEN J2Q46S2 = .;
   IF (J2Q46T1 = 7 OR J2Q46T1 = 8 OR J2Q46T1 = 9) THEN J2Q46T1 = .;
   IF (J2Q46T2 = 7 OR J2Q46T2 = 8 OR J2Q46T2 = 9) THEN J2Q46T2 = .;
   IF (J2Q46U1 = 7 OR J2Q46U1 = 8 OR J2Q46U1 = 9) THEN J2Q46U1 = .;
   IF (J2Q46U2 = 7 OR J2Q46U2 = 8 OR J2Q46U2 = 9) THEN J2Q46U2 = .;
   IF (J2Q46V1 = 7 OR J2Q46V1 = 8 OR J2Q46V1 = 9) THEN J2Q46V1 = .;
   IF (J2Q46V2 = 7 OR J2Q46V2 = 8 OR J2Q46V2 = 9) THEN J2Q46V2 = .;
   IF (J2Q46W1 = 7 OR J2Q46W1 = 8 OR J2Q46W1 = 9) THEN J2Q46W1 = .;
   IF (J2Q46W2 = 7 OR J2Q46W2 = 8 OR J2Q46W2 = 9) THEN J2Q46W2 = .;
   IF (J2Q46X1 = 7 OR J2Q46X1 = 8 OR J2Q46X1 = 9) THEN J2Q46X1 = .;
   IF (J2Q46X2 = 7 OR J2Q46X2 = 8 OR J2Q46X2 = 9) THEN J2Q46X2 = .;
   IF (J2Q46Y1 = 7 OR J2Q46Y1 = 8 OR J2Q46Y1 = 9) THEN J2Q46Y1 = .;
   IF (J2Q46Y2 = 7 OR J2Q46Y2 = 8 OR J2Q46Y2 = 9) THEN J2Q46Y2 = .;
   IF (J2Q46Z1 = 7 OR J2Q46Z1 = 8 OR J2Q46Z1 = 9) THEN J2Q46Z1 = .;
   IF (J2Q46Z2 = 7 OR J2Q46Z2 = 8 OR J2Q46Z2 = 9) THEN J2Q46Z2 = .;
   IF (J2Q46AA1 = 7 OR J2Q46AA1 = 8 OR J2Q46AA1 = 9) THEN J2Q46AA1 = .;
   IF (J2Q46AA2 = 7 OR J2Q46AA2 = 8 OR J2Q46AA2 = 9) THEN J2Q46AA2 = .;
   IF (J2Q46BB1 = 7 OR J2Q46BB1 = 8 OR J2Q46BB1 = 9) THEN J2Q46BB1 = .;
   IF (J2Q46BB2 = 7 OR J2Q46BB2 = 8 OR J2Q46BB2 = 9) THEN J2Q46BB2 = .;
   IF (J2Q46CC1 = 7 OR J2Q46CC1 = 8 OR J2Q46CC1 = 9) THEN J2Q46CC1 = .;
   IF (J2Q46CC2 = 7 OR J2Q46CC2 = 8 OR J2Q46CC2 = 9) THEN J2Q46CC2 = .;
   IF (J2Q46DD1 = 7 OR J2Q46DD1 = 8 OR J2Q46DD1 = 9) THEN J2Q46DD1 = .;
   IF (J2Q46DD2 = 7 OR J2Q46DD2 = 8 OR J2Q46DD2 = 9) THEN J2Q46DD2 = .;
   IF (J2Q46EE1 = 7 OR J2Q46EE1 = 8 OR J2Q46EE1 = 9) THEN J2Q46EE1 = .;
   IF (J2Q46EE2 = 7 OR J2Q46EE2 = 8 OR J2Q46EE2 = 9) THEN J2Q46EE2 = .;
   IF (J2Q46FF1 = 7 OR J2Q46FF1 = 8 OR J2Q46FF1 = 9) THEN J2Q46FF1 = .;
   IF (J2Q46FF2 = 7 OR J2Q46FF2 = 8 OR J2Q46FF2 = 9) THEN J2Q46FF2 = .;
   IF (J2Q46HH1 = 7 OR J2Q46HH1 = 8 OR J2Q46HH1 = 9) THEN J2Q46HH1 = .;
   IF (J2Q46HH2 = 7 OR J2Q46HH2 = 8 OR J2Q46HH2 = 9) THEN J2Q46HH2 = .;
   IF (J2Q46II1 = 7 OR J2Q46II1 = 8 OR J2Q46II1 = 9) THEN J2Q46II1 = .;
   IF (J2Q46II2 = 7 OR J2Q46II2 = 8 OR J2Q46II2 = 9) THEN J2Q46II2 = .;
   IF (J2Q46JJ1 = 7 OR J2Q46JJ1 = 8 OR J2Q46JJ1 = 9) THEN J2Q46JJ1 = .;
   IF (J2Q46JJ2 = 7 OR J2Q46JJ2 = 8 OR J2Q46JJ2 = 9) THEN J2Q46JJ2 = .;
   IF (J2Q46KK1 = 7 OR J2Q46KK1 = 8 OR J2Q46KK1 = 9) THEN J2Q46KK1 = .;
   IF (J2Q46KK2 = 7 OR J2Q46KK2 = 8 OR J2Q46KK2 = 9) THEN J2Q46KK2 = .;
   IF (J2Q46LL1 = 7 OR J2Q46LL1 = 8 OR J2Q46LL1 = 9) THEN J2Q46LL1 = .;
   IF (J2Q46LL2 = 7 OR J2Q46LL2 = 8 OR J2Q46LL2 = 9) THEN J2Q46LL2 = .;
   IF (J2Q46MM1 = 7 OR J2Q46MM1 = 8 OR J2Q46MM1 = 9) THEN J2Q46MM1 = .;
   IF (J2Q46MM2 = 7 OR J2Q46MM2 = 8 OR J2Q46MM2 = 9) THEN J2Q46MM2 = .;
   IF (J2Q46NN1 = 7 OR J2Q46NN1 = 8 OR J2Q46NN1 = 9) THEN J2Q46NN1 = .;
   IF (J2Q46NN2 = 7 OR J2Q46NN2 = 8 OR J2Q46NN2 = 9) THEN J2Q46NN2 = .;
   IF (J2Q46OO1 = 7 OR J2Q46OO1 = 8 OR J2Q46OO1 = 9) THEN J2Q46OO1 = .;
   IF (J2Q46OO2 = 7 OR J2Q46OO2 = 8 OR J2Q46OO2 = 9) THEN J2Q46OO2 = .;
   IF (J2Q46PP1 = 7 OR J2Q46PP1 = 8 OR J2Q46PP1 = 9) THEN J2Q46PP1 = .;
   IF (J2Q46PP2 = 7 OR J2Q46PP2 = 8 OR J2Q46PP2 = 9) THEN J2Q46PP2 = .;
   IF (J2Q46QQ1 = 7 OR J2Q46QQ1 = 8 OR J2Q46QQ1 = 9) THEN J2Q46QQ1 = .;
   IF (J2Q46QQ2 = 7 OR J2Q46QQ2 = 8 OR J2Q46QQ2 = 9) THEN J2Q46QQ2 = .;
   IF (J2Q46RR1 = 7 OR J2Q46RR1 = 8 OR J2Q46RR1 = 9) THEN J2Q46RR1 = .;
   IF (J2Q46RR2 = 7 OR J2Q46RR2 = 8 OR J2Q46RR2 = 9) THEN J2Q46RR2 = .;
   IF (J2Q46SS1 = 7 OR J2Q46SS1 = 8 OR J2Q46SS1 = 9) THEN J2Q46SS1 = .;
   IF (J2Q46SS2 = 7 OR J2Q46SS2 = 8 OR J2Q46SS2 = 9) THEN J2Q46SS2 = .;
   IF (J2Q46TT1 = 7 OR J2Q46TT1 = 8 OR J2Q46TT1 = 9) THEN J2Q46TT1 = .;
   IF (J2Q46TT2 = 7 OR J2Q46TT2 = 8 OR J2Q46TT2 = 9) THEN J2Q46TT2 = .;
   IF (J2Q46UU1 = 7 OR J2Q46UU1 = 8 OR J2Q46UU1 = 9) THEN J2Q46UU1 = .;
   IF (J2Q46UU2 = 7 OR J2Q46UU2 = 8 OR J2Q46UU2 = 9) THEN J2Q46UU2 = .;
   IF (J2Q46VV1 = 7 OR J2Q46VV1 = 8 OR J2Q46VV1 = 9) THEN J2Q46VV1 = .;
   IF (J2Q46VV2 = 7 OR J2Q46VV2 = 8 OR J2Q46VV2 = 9) THEN J2Q46VV2 = .;
   IF (J2Q46WW1 = 7 OR J2Q46WW1 = 8 OR J2Q46WW1 = 9) THEN J2Q46WW1 = .;
   IF (J2Q46WW2 = 7 OR J2Q46WW2 = 8 OR J2Q46WW2 = 9) THEN J2Q46WW2 = .;
   IF (J2Q47A = 97 OR J2Q47A = 98 OR J2Q47A = 99) THEN J2Q47A = .;
   IF (J2Q47B = 97 OR J2Q47B = 98 OR J2Q47B = 99) THEN J2Q47B = .;
   IF (J2Q47C = 97 OR J2Q47C = 98 OR J2Q47C = 99) THEN J2Q47C = .;
   IF (J2Q47D = 97 OR J2Q47D = 98 OR J2Q47D = 99) THEN J2Q47D = .;
   IF (J2Q47E = 97 OR J2Q47E = 98 OR J2Q47E = 99) THEN J2Q47E = .;
   IF (J2Q47F = 97 OR J2Q47F = 98 OR J2Q47F = 99) THEN J2Q47F = .;
   IF (J2Q47G = 97 OR J2Q47G = 98 OR J2Q47G = 99) THEN J2Q47G = .;
   IF (J2Q47H = 97 OR J2Q47H = 98 OR J2Q47H = 99) THEN J2Q47H = .;
   IF (J2Q47I = 97 OR J2Q47I = 98 OR J2Q47I = 99) THEN J2Q47I = .;
   IF (J2Q47J = 97 OR J2Q47J = 98 OR J2Q47J = 99) THEN J2Q47J = .;
   IF (J2Q47K = 97 OR J2Q47K = 98 OR J2Q47K = 99) THEN J2Q47K = .;
   IF (J2Q47L = 97 OR J2Q47L = 98 OR J2Q47L = 99) THEN J2Q47L = .;
   IF (J2QSO_PC = 8.0) THEN J2QSO_PC = .;
   IF (J2QSO_PF = 8.0) THEN J2QSO_PF = .;
   IF (J2QSO_PX = 8.0) THEN J2QSO_PX = .;
   IF (J2QSO_IW = 8.0) THEN J2QSO_IW = .;
   IF (J2QSO_GW = 8.0) THEN J2QSO_GW = .;
   IF (J2Q48A = 97 OR J2Q48A = 98 OR J2Q48A = 99) THEN J2Q48A = .;
   IF (J2Q48B = 97 OR J2Q48B = 98 OR J2Q48B = 99) THEN J2Q48B = .;
   IF (J2Q48C = 97 OR J2Q48C = 98 OR J2Q48C = 99) THEN J2Q48C = .;
   IF (J2Q48D = 97 OR J2Q48D = 98 OR J2Q48D = 99) THEN J2Q48D = .;
   IF (J2Q48E = 97 OR J2Q48E = 98 OR J2Q48E = 99) THEN J2Q48E = .;
   IF (J2Q48F = 97 OR J2Q48F = 98 OR J2Q48F = 99) THEN J2Q48F = .;
   IF (J2Q48G = 97 OR J2Q48G = 98 OR J2Q48G = 99) THEN J2Q48G = .;
   IF (J2Q48H = 97 OR J2Q48H = 98 OR J2Q48H = 99) THEN J2Q48H = .;
   IF (J2Q48I = 97 OR J2Q48I = 98 OR J2Q48I = 99) THEN J2Q48I = .;
   IF (J2Q48J = 97 OR J2Q48J = 98 OR J2Q48J = 99) THEN J2Q48J = .;
   IF (J2Q48K = 97 OR J2Q48K = 98 OR J2Q48K = 99) THEN J2Q48K = .;
   IF (J2Q48L = 97 OR J2Q48L = 98 OR J2Q48L = 99) THEN J2Q48L = .;
   IF (J2Q48M = 97 OR J2Q48M = 98 OR J2Q48M = 99) THEN J2Q48M = .;
   IF (J2Q48N = 97 OR J2Q48N = 98 OR J2Q48N = 99) THEN J2Q48N = .;
   IF (J2Q48O = 97 OR J2Q48O = 98 OR J2Q48O = 99) THEN J2Q48O = .;
   IF (J2Q48P = 97 OR J2Q48P = 98 OR J2Q48P = 99) THEN J2Q48P = .;
   IF (J2Q48Q = 97 OR J2Q48Q = 98 OR J2Q48Q = 99) THEN J2Q48Q = .;
   IF (J2Q48R = 97 OR J2Q48R = 98 OR J2Q48R = 99) THEN J2Q48R = .;
   IF (J2Q48S = 97 OR J2Q48S = 98 OR J2Q48S = 99) THEN J2Q48S = .;
   IF (J2Q48T = 97 OR J2Q48T = 98 OR J2Q48T = 99) THEN J2Q48T = .;
   IF (J2Q48U = 97 OR J2Q48U = 98 OR J2Q48U = 99) THEN J2Q48U = .;
   IF (J2QRISC = 8.0) THEN J2QRISC = .;
   IF (J2QSYMP = 8.0) THEN J2QSYMP = .;
   IF (J2QADJ = 8.0) THEN J2QADJ = .;
   IF (J2Q49A = 7 OR J2Q49A = 8 OR J2Q49A = 9) THEN J2Q49A = .;
   IF (J2Q49B = 7 OR J2Q49B = 8 OR J2Q49B = 9) THEN J2Q49B = .;
   IF (J2Q49C = 7 OR J2Q49C = 8 OR J2Q49C = 9) THEN J2Q49C = .;
   IF (J2Q49D = 7 OR J2Q49D = 8 OR J2Q49D = 9) THEN J2Q49D = .;
   IF (J2Q49E = 7 OR J2Q49E = 8 OR J2Q49E = 9) THEN J2Q49E = .;
   IF (J2Q49F = 7 OR J2Q49F = 8 OR J2Q49F = 9) THEN J2Q49F = .;
   IF (J2Q49G = 7 OR J2Q49G = 8 OR J2Q49G = 9) THEN J2Q49G = .;
   IF (J2Q49H = 7 OR J2Q49H = 8 OR J2Q49H = 9) THEN J2Q49H = .;
   IF (J2QSSCTR = 8.0) THEN J2QSSCTR = .;
   IF (J2QCSCD4 = 8.0) THEN J2QCSCD4 = .;
   IF (J2QCSCD6 = 8.0) THEN J2QCSCD6 = .;
   IF (J2QCSCP4 = 8.0) THEN J2QCSCP4 = .;
   IF (J2QCSCP5 = 8.0) THEN J2QCSCP5 = .;
   IF (J2Q50A = 7 OR J2Q50A = 8 OR J2Q50A = 9) THEN J2Q50A = .;
   IF (J2Q50B = 7 OR J2Q50B = 8 OR J2Q50B = 9) THEN J2Q50B = .;
   IF (J2Q50C = 7 OR J2Q50C = 8 OR J2Q50C = 9) THEN J2Q50C = .;
   IF (J2Q50D = 7 OR J2Q50D = 8 OR J2Q50D = 9) THEN J2Q50D = .;
   IF (J2Q50E = 7 OR J2Q50E = 8 OR J2Q50E = 9) THEN J2Q50E = .;
   IF (J2Q50F = 7 OR J2Q50F = 8 OR J2Q50F = 9) THEN J2Q50F = .;
   IF (J2Q50G = 7 OR J2Q50G = 8 OR J2Q50G = 9) THEN J2Q50G = .;
   IF (J2Q50H = 7 OR J2Q50H = 8 OR J2Q50H = 9) THEN J2Q50H = .;
   IF (J2QSW_JP = 8.0) THEN J2QSW_JP = .;
   IF (J2Q51A = 7 OR J2Q51A = 8 OR J2Q51A = 9) THEN J2Q51A = .;
   IF (J2Q51B = 7 OR J2Q51B = 8 OR J2Q51B = 9) THEN J2Q51B = .;
   IF (J2Q51C = 7 OR J2Q51C = 8 OR J2Q51C = 9) THEN J2Q51C = .;
   IF (J2Q51D = 7 OR J2Q51D = 8 OR J2Q51D = 9) THEN J2Q51D = .;
   IF (J2Q51E = 7 OR J2Q51E = 8 OR J2Q51E = 9) THEN J2Q51E = .;
   IF (J2Q51F = 7 OR J2Q51F = 8 OR J2Q51F = 9) THEN J2Q51F = .;
   IF (J2Q51G = 7 OR J2Q51G = 8 OR J2Q51G = 9) THEN J2Q51G = .;
   IF (J2Q51H = 7 OR J2Q51H = 8 OR J2Q51H = 9) THEN J2Q51H = .;
   IF (J2Q51I = 7 OR J2Q51I = 8 OR J2Q51I = 9) THEN J2Q51I = .;
   IF (J2Q51J = 7 OR J2Q51J = 8 OR J2Q51J = 9) THEN J2Q51J = .;
   IF (J2Q51K = 7 OR J2Q51K = 8 OR J2Q51K = 9) THEN J2Q51K = .;
   IF (J2Q51L = 7 OR J2Q51L = 8 OR J2Q51L = 9) THEN J2Q51L = .;
   IF (J2Q51M = 7 OR J2Q51M = 8 OR J2Q51M = 9) THEN J2Q51M = .;
   IF (J2Q51N = 7 OR J2Q51N = 8 OR J2Q51N = 9) THEN J2Q51N = .;
   IF (J2Q51O = 7 OR J2Q51O = 8 OR J2Q51O = 9) THEN J2Q51O = .;
   IF (J2Q51P = 7 OR J2Q51P = 8 OR J2Q51P = 9) THEN J2Q51P = .;
   IF (J2Q51Q = 7 OR J2Q51Q = 8 OR J2Q51Q = 9) THEN J2Q51Q = .;
   IF (J2Q52 = 7 OR J2Q52 = 8 OR J2Q52 = 9) THEN J2Q52 = .;
   IF (J2Q541 = 7 OR J2Q541 = 8 OR J2Q541 = 9) THEN J2Q541 = .;
   IF (J2Q542 = 7 OR J2Q542 = 8 OR J2Q542 = 9) THEN J2Q542 = .;
   IF (J2Q543 = 7 OR J2Q543 = 8 OR J2Q543 = 9) THEN J2Q543 = .;
   IF (J2Q544 = 7 OR J2Q544 = 8 OR J2Q544 = 9) THEN J2Q544 = .;
   IF (J2Q545 = 7 OR J2Q545 = 8 OR J2Q545 = 9) THEN J2Q545 = .;
   IF (J2Q546 = 7 OR J2Q546 = 8 OR J2Q546 = 9) THEN J2Q546 = .;
   IF (J2Q547 = 7 OR J2Q547 = 8 OR J2Q547 = 9) THEN J2Q547 = .;
   IF (J2Q548 = 7 OR J2Q548 = 8 OR J2Q548 = 9) THEN J2Q548 = .;
   IF (J2Q549 = 7 OR J2Q549 = 8 OR J2Q549 = 9) THEN J2Q549 = .;
   IF (J2Q5410 = 7 OR J2Q5410 = 8 OR J2Q5410 = 9) THEN J2Q5410 = .;
   IF (J2Q5411 = 7 OR J2Q5411 = 8 OR J2Q5411 = 9) THEN J2Q5411 = .;
   IF (J2Q5412 = 7 OR J2Q5412 = 8 OR J2Q5412 = 9) THEN J2Q5412 = .;
   IF (J2Q5413 = 7 OR J2Q5413 = 8 OR J2Q5413 = 9) THEN J2Q5413 = .;
   IF (J2Q5414 = 7 OR J2Q5414 = 8 OR J2Q5414 = 9) THEN J2Q5414 = .;
   IF (J2Q5415 = 7 OR J2Q5415 = 8 OR J2Q5415 = 9) THEN J2Q5415 = .;
   IF (J2Q5416 = 7 OR J2Q5416 = 8 OR J2Q5416 = 9) THEN J2Q5416 = .;
   IF (J2Q5417 = 7 OR J2Q5417 = 8 OR J2Q5417 = 9) THEN J2Q5417 = .;
   IF (J2Q5418 = 7 OR J2Q5418 = 8 OR J2Q5418 = 9) THEN J2Q5418 = .;
   IF (J2Q5419 = 7 OR J2Q5419 = 8 OR J2Q5419 = 9) THEN J2Q5419 = .;
   IF (J2Q5420 = 7 OR J2Q5420 = 8 OR J2Q5420 = 9) THEN J2Q5420 = .;
   IF (J2Q5421 = 7 OR J2Q5421 = 8 OR J2Q5421 = 9) THEN J2Q5421 = .;
   IF (J2Q5422 = 7 OR J2Q5422 = 8 OR J2Q5422 = 9) THEN J2Q5422 = .;
   IF (J2QJC_SD = 98.0) THEN J2QJC_SD = .;
   IF (J2QJC_DA = 98.0) THEN J2QJC_DA = .;
   IF (J2QJC_DL = 98.0) THEN J2QJC_DL = .;
   IF (J2QJC_PD = 98.0) THEN J2QJC_PD = .;
   IF (J2QJC_SS = 98.0) THEN J2QJC_SS = .;
   IF (J2QJC_CS = 98.0) THEN J2QJC_CS = .;
   IF (J2CBMI = 999998.00 OR J2CBMI = 999999.00) THEN J2CBMI = .;
   IF (J2CWHR = 999998.00 OR J2CWHR = 999999.00) THEN J2CWHR = .;
   IF (J2CBPS23 = 998) THEN J2CBPS23 = .;
   IF (J2CBPD23 = 998) THEN J2CBPD23 = .;
   IF (J2BCHOL = 997 OR J2BCHOL = 998 OR J2BCHOL = 999) THEN J2BCHOL = .;
   IF (J2BHDL = 997 OR J2BHDL = 998 OR J2BHDL = 999) THEN J2BHDL = .;
   IF (J2BHDLA = 997 OR J2BHDLA = 998 OR J2BHDLA = 999) THEN J2BHDLA = .;
   IF (J2BRTHDL = 9997.00 OR J2BRTHDL = 9998.00 OR J2BRTHDL = 9999.00) THEN J2BRTHDL = .;
   IF (J2BRTHDA = 9997.00 OR J2BRTHDA = 9998.00 OR J2BRTHDA = 9999.00) THEN J2BRTHDA = .;
   IF (J2BDHEAS = 9997.00 OR J2BDHEAS = 9998.00 OR J2BDHEAS = 9999.00) THEN J2BDHEAS = .;
   IF (J2BDHEA = 9997.00 OR J2BDHEA = 9998.00 OR J2BDHEA = 9999.00) THEN J2BDHEA = .;
   IF (J2BSCREA = 997.0 OR J2BSCREA = 998.0 OR J2BSCREA = 999.0) THEN J2BSCREA = .;
   IF (J2BIL6 = 997.00 OR J2BIL6 = 998.00 OR J2BIL6 = 999.00) THEN J2BIL6 = .;
   IF (J2BSIL6R = 99997 OR J2BSIL6R = 99998 OR J2BSIL6R = 99999) THEN J2BSIL6R = .;
   IF (J2BFGN = 997 OR J2BFGN = 998 OR J2BFGN = 999) THEN J2BFGN = .;
   IF (J2BCRP = 99997.00 OR J2BCRP = 99998.00 OR J2BCRP = 99999.00) THEN J2BCRP = .;
   IF (J2SD1MNH = 98) THEN J2SD1MNH = .;
   IF (J2SD1MNM = 98) THEN J2SD1MNM = .;
   IF (J2SD1MDH = 98) THEN J2SD1MDH = .;
   IF (J2SD1MDM = 98) THEN J2SD1MDM = .;
   IF (J2SD1EVH = 98) THEN J2SD1EVH = .;
   IF (J2SD1EVM = 98) THEN J2SD1EVM = .;
   IF (J2SD2MNH = 98) THEN J2SD2MNH = .;
   IF (J2SD2MNM = 98) THEN J2SD2MNM = .;
   IF (J2SD2MDH = 98) THEN J2SD2MDH = .;
   IF (J2SD2MDM = 98) THEN J2SD2MDM = .;
   IF (J2SD2EVH = 98) THEN J2SD2EVH = .;
   IF (J2SD2EVM = 98) THEN J2SD2EVM = .;
   IF (J2SD3MNH = 98) THEN J2SD3MNH = .;
   IF (J2SD3MNM = 98) THEN J2SD3MNM = .;
   IF (J2SD3MDH = 98) THEN J2SD3MDH = .;
   IF (J2SD3MDM = 98) THEN J2SD3MDM = .;
   IF (J2SD3EVH = 98) THEN J2SD3EVH = .;
   IF (J2SD3EVM = 98) THEN J2SD3EVM = .;
   IF (J2BSCD11 = 997.00 OR J2BSCD11 = 998.00 OR J2BSCD11 = 999.00) THEN J2BSCD11 = .;
   IF (J2BSCD12 = 997.00 OR J2BSCD12 = 998.00 OR J2BSCD12 = 999.00) THEN J2BSCD12 = .;
   IF (J2BSCD13 = 997.00 OR J2BSCD13 = 998.00 OR J2BSCD13 = 999.00) THEN J2BSCD13 = .;
   IF (J2BSCD21 = 997.00 OR J2BSCD21 = 998.00 OR J2BSCD21 = 999.00) THEN J2BSCD21 = .;
   IF (J2BSCD22 = 997.00 OR J2BSCD22 = 998.00 OR J2BSCD22 = 999.00) THEN J2BSCD22 = .;
   IF (J2BSCD23 = 997.00 OR J2BSCD23 = 998.00 OR J2BSCD23 = 999.00) THEN J2BSCD23 = .;
   IF (J2BSCD31 = 997.00 OR J2BSCD31 = 998.00 OR J2BSCD31 = 999.00) THEN J2BSCD31 = .;
   IF (J2BSCD32 = 997.00 OR J2BSCD32 = 998.00 OR J2BSCD32 = 999.00) THEN J2BSCD32 = .;
   IF (J2BSCD33 = 997.00 OR J2BSCD33 = 998.00 OR J2BSCD33 = 999.00) THEN J2BSCD33 = .;
   IF (J2MPMD = 7 OR J2MPMD = 8) THEN J2MPMD = .;
   IF (J2MQMD = 7 OR J2MQMD = 8) THEN J2MQMD = .;
   IF (J2MPM = 97 OR J2MPM = 98 OR J2MPM = 99) THEN J2MPM = .;
   IF (J2MPC1 = 99999997 OR J2MPC1 = 99999998 OR J2MPC1 = 99999999) THEN J2MPC1 = .;
   IF (J2MPDD1 = 9997.00 OR J2MPDD1 = 9998.00 OR J2MPDD1 = 9999.00) THEN J2MPDD1 = .;
   IF (J2MPDU1 = 97 OR J2MPDU1 = 98 OR J2MPDU1 = 99) THEN J2MPDU1 = .;
   IF (J2MPR1 = 97 OR J2MPR1 = 98 OR J2MPR1 = 99) THEN J2MPR1 = .;
   IF (J2MPF1 = 97 OR J2MPF1 = 98 OR J2MPF1 = 99) THEN J2MPF1 = .;
   IF (J2MPFU1 = 7 OR J2MPFU1 = 8 OR J2MPFU1 = 9) THEN J2MPFU1 = .;
   IF (J2MPT1 = 97.0 OR J2MPT1 = 98.0 OR J2MPT1 = 99.0) THEN J2MPT1 = .;
   IF (J2MPTU1 = 7 OR J2MPTU1 = 8 OR J2MPTU1 = 9) THEN J2MPTU1 = .;
   IF (J2MPDC1 = 99997 OR J2MPDC1 = 99998 OR J2MPDC1 = 99999) THEN J2MPDC1 = .;
   IF (J2MPC2 = 99999997 OR J2MPC2 = 99999998 OR J2MPC2 = 99999999) THEN J2MPC2 = .;
   IF (J2MPDD2 = 9997.00 OR J2MPDD2 = 9998.00 OR J2MPDD2 = 9999.00) THEN J2MPDD2 = .;
   IF (J2MPDU2 = 97 OR J2MPDU2 = 98 OR J2MPDU2 = 99) THEN J2MPDU2 = .;
   IF (J2MPR2 = 97 OR J2MPR2 = 98 OR J2MPR2 = 99) THEN J2MPR2 = .;
   IF (J2MPF2 = 97 OR J2MPF2 = 98 OR J2MPF2 = 99) THEN J2MPF2 = .;
   IF (J2MPFU2 = 7 OR J2MPFU2 = 8 OR J2MPFU2 = 9) THEN J2MPFU2 = .;
   IF (J2MPT2 = 97.0 OR J2MPT2 = 98.0 OR J2MPT2 = 99.0) THEN J2MPT2 = .;
   IF (J2MPTU2 = 7 OR J2MPTU2 = 8 OR J2MPTU2 = 9) THEN J2MPTU2 = .;
   IF (J2MPDC2 = 99997 OR J2MPDC2 = 99998 OR J2MPDC2 = 99999) THEN J2MPDC2 = .;
   IF (J2MPC3 = 99999997 OR J2MPC3 = 99999998 OR J2MPC3 = 99999999) THEN J2MPC3 = .;
   IF (J2MPDD3 = 9997.00 OR J2MPDD3 = 9998.00 OR J2MPDD3 = 9999.00) THEN J2MPDD3 = .;
   IF (J2MPDU3 = 97 OR J2MPDU3 = 98 OR J2MPDU3 = 99) THEN J2MPDU3 = .;
   IF (J2MPR3 = 97 OR J2MPR3 = 98 OR J2MPR3 = 99) THEN J2MPR3 = .;
   IF (J2MPF3 = 97 OR J2MPF3 = 98 OR J2MPF3 = 99) THEN J2MPF3 = .;
   IF (J2MPFU3 = 7 OR J2MPFU3 = 8 OR J2MPFU3 = 9) THEN J2MPFU3 = .;
   IF (J2MPT3 = 97.0 OR J2MPT3 = 98.0 OR J2MPT3 = 99.0) THEN J2MPT3 = .;
   IF (J2MPTU3 = 7 OR J2MPTU3 = 8 OR J2MPTU3 = 9) THEN J2MPTU3 = .;
   IF (J2MPDC3 = 99997 OR J2MPDC3 = 99998 OR J2MPDC3 = 99999) THEN J2MPDC3 = .;
   IF (J2MPC4 = 99999997 OR J2MPC4 = 99999998 OR J2MPC4 = 99999999) THEN J2MPC4 = .;
   IF (J2MPDD4 = 9997.00 OR J2MPDD4 = 9998.00 OR J2MPDD4 = 9999.00) THEN J2MPDD4 = .;
   IF (J2MPDU4 = 97 OR J2MPDU4 = 98 OR J2MPDU4 = 99) THEN J2MPDU4 = .;
   IF (J2MPR4 = 97 OR J2MPR4 = 98 OR J2MPR4 = 99) THEN J2MPR4 = .;
   IF (J2MPF4 = 97 OR J2MPF4 = 98 OR J2MPF4 = 99) THEN J2MPF4 = .;
   IF (J2MPFU4 = 7 OR J2MPFU4 = 8 OR J2MPFU4 = 9) THEN J2MPFU4 = .;
   IF (J2MPT4 = 97.0 OR J2MPT4 = 98.0 OR J2MPT4 = 99.0) THEN J2MPT4 = .;
   IF (J2MPTU4 = 7 OR J2MPTU4 = 8 OR J2MPTU4 = 9) THEN J2MPTU4 = .;
   IF (J2MPDC4 = 99997 OR J2MPDC4 = 99998 OR J2MPDC4 = 99999) THEN J2MPDC4 = .;
   IF (J2MPC5 = 99999997 OR J2MPC5 = 99999998 OR J2MPC5 = 99999999) THEN J2MPC5 = .;
   IF (J2MPDD5 = 9997.00 OR J2MPDD5 = 9998.00 OR J2MPDD5 = 9999.00) THEN J2MPDD5 = .;
   IF (J2MPDU5 = 97 OR J2MPDU5 = 98 OR J2MPDU5 = 99) THEN J2MPDU5 = .;
   IF (J2MPR5 = 97 OR J2MPR5 = 98 OR J2MPR5 = 99) THEN J2MPR5 = .;
   IF (J2MPF5 = 97 OR J2MPF5 = 98 OR J2MPF5 = 99) THEN J2MPF5 = .;
   IF (J2MPFU5 = 7 OR J2MPFU5 = 8 OR J2MPFU5 = 9) THEN J2MPFU5 = .;
   IF (J2MPT5 = 97.0 OR J2MPT5 = 98.0 OR J2MPT5 = 99.0) THEN J2MPT5 = .;
   IF (J2MPTU5 = 7 OR J2MPTU5 = 8 OR J2MPTU5 = 9) THEN J2MPTU5 = .;
   IF (J2MPDC5 = 99997 OR J2MPDC5 = 99998 OR J2MPDC5 = 99999) THEN J2MPDC5 = .;
   IF (J2MPC6 = 99999997 OR J2MPC6 = 99999998 OR J2MPC6 = 99999999) THEN J2MPC6 = .;
   IF (J2MPDD6 = 9997.00 OR J2MPDD6 = 9998.00 OR J2MPDD6 = 9999.00) THEN J2MPDD6 = .;
   IF (J2MPDU6 = 97 OR J2MPDU6 = 98 OR J2MPDU6 = 99) THEN J2MPDU6 = .;
   IF (J2MPR6 = 97 OR J2MPR6 = 98 OR J2MPR6 = 99) THEN J2MPR6 = .;
   IF (J2MPF6 = 97 OR J2MPF6 = 98 OR J2MPF6 = 99) THEN J2MPF6 = .;
   IF (J2MPFU6 = 7 OR J2MPFU6 = 8 OR J2MPFU6 = 9) THEN J2MPFU6 = .;
   IF (J2MPT6 = 97.0 OR J2MPT6 = 98.0 OR J2MPT6 = 99.0) THEN J2MPT6 = .;
   IF (J2MPTU6 = 7 OR J2MPTU6 = 8 OR J2MPTU6 = 9) THEN J2MPTU6 = .;
   IF (J2MPDC6 = 99997 OR J2MPDC6 = 99998 OR J2MPDC6 = 99999) THEN J2MPDC6 = .;
   IF (J2MPC7 = 99999997 OR J2MPC7 = 99999998 OR J2MPC7 = 99999999) THEN J2MPC7 = .;
   IF (J2MPDD7 = 9997.00 OR J2MPDD7 = 9998.00 OR J2MPDD7 = 9999.00) THEN J2MPDD7 = .;
   IF (J2MPDU7 = 97 OR J2MPDU7 = 98 OR J2MPDU7 = 99) THEN J2MPDU7 = .;
   IF (J2MPR7 = 97 OR J2MPR7 = 98 OR J2MPR7 = 99) THEN J2MPR7 = .;
   IF (J2MPF7 = 97 OR J2MPF7 = 98 OR J2MPF7 = 99) THEN J2MPF7 = .;
   IF (J2MPFU7 = 7 OR J2MPFU7 = 8 OR J2MPFU7 = 9) THEN J2MPFU7 = .;
   IF (J2MPT7 = 97.0 OR J2MPT7 = 98.0 OR J2MPT7 = 99.0) THEN J2MPT7 = .;
   IF (J2MPTU7 = 7 OR J2MPTU7 = 8 OR J2MPTU7 = 9) THEN J2MPTU7 = .;
   IF (J2MPDC7 = 99997 OR J2MPDC7 = 99998 OR J2MPDC7 = 99999) THEN J2MPDC7 = .;
   IF (J2MPC8 = 99999997 OR J2MPC8 = 99999998 OR J2MPC8 = 99999999) THEN J2MPC8 = .;
   IF (J2MPDD8 = 9997.00 OR J2MPDD8 = 9998.00 OR J2MPDD8 = 9999.00) THEN J2MPDD8 = .;
   IF (J2MPDU8 = 97 OR J2MPDU8 = 98 OR J2MPDU8 = 99) THEN J2MPDU8 = .;
   IF (J2MPR8 = 97 OR J2MPR8 = 98 OR J2MPR8 = 99) THEN J2MPR8 = .;
   IF (J2MPF8 = 97 OR J2MPF8 = 98 OR J2MPF8 = 99) THEN J2MPF8 = .;
   IF (J2MPFU8 = 7 OR J2MPFU8 = 8 OR J2MPFU8 = 9) THEN J2MPFU8 = .;
   IF (J2MPT8 = 97.0 OR J2MPT8 = 98.0 OR J2MPT8 = 99.0) THEN J2MPT8 = .;
   IF (J2MPTU8 = 7 OR J2MPTU8 = 8 OR J2MPTU8 = 9) THEN J2MPTU8 = .;
   IF (J2MPDC8 = 99997 OR J2MPDC8 = 99998 OR J2MPDC8 = 99999) THEN J2MPDC8 = .;
   IF (J2MPC9 = 99999997 OR J2MPC9 = 99999998 OR J2MPC9 = 99999999) THEN J2MPC9 = .;
   IF (J2MPDD9 = 9997.00 OR J2MPDD9 = 9998.00 OR J2MPDD9 = 9999.00) THEN J2MPDD9 = .;
   IF (J2MPDU9 = 97 OR J2MPDU9 = 98 OR J2MPDU9 = 99) THEN J2MPDU9 = .;
   IF (J2MPR9 = 97 OR J2MPR9 = 98 OR J2MPR9 = 99) THEN J2MPR9 = .;
   IF (J2MPF9 = 97 OR J2MPF9 = 98 OR J2MPF9 = 99) THEN J2MPF9 = .;
   IF (J2MPFU9 = 7 OR J2MPFU9 = 8 OR J2MPFU9 = 9) THEN J2MPFU9 = .;
   IF (J2MPT9 = 97.0 OR J2MPT9 = 98.0 OR J2MPT9 = 99.0) THEN J2MPT9 = .;
   IF (J2MPTU9 = 7 OR J2MPTU9 = 8 OR J2MPTU9 = 9) THEN J2MPTU9 = .;
   IF (J2MPDC9 = 99997 OR J2MPDC9 = 99998 OR J2MPDC9 = 99999) THEN J2MPDC9 = .;
   IF (J2MPC10 = 99999997 OR J2MPC10 = 99999998 OR J2MPC10 = 99999999) THEN J2MPC10 = .;
   IF (J2MPDD10 = 9997.00 OR J2MPDD10 = 9998.00 OR J2MPDD10 = 9999.00) THEN J2MPDD10 = .;
   IF (J2MPDU10 = 97 OR J2MPDU10 = 98 OR J2MPDU10 = 99) THEN J2MPDU10 = .;
   IF (J2MPR10 = 97 OR J2MPR10 = 98 OR J2MPR10 = 99) THEN J2MPR10 = .;
   IF (J2MPF10 = 97 OR J2MPF10 = 98 OR J2MPF10 = 99) THEN J2MPF10 = .;
   IF (J2MPFU10 = 7 OR J2MPFU10 = 8 OR J2MPFU10 = 9) THEN J2MPFU10 = .;
   IF (J2MPT10 = 97.0 OR J2MPT10 = 98.0 OR J2MPT10 = 99.0) THEN J2MPT10 = .;
   IF (J2MPTU10 = 7 OR J2MPTU10 = 8 OR J2MPTU10 = 9) THEN J2MPTU10 = .;
   IF (J2MPDC10 = 99997 OR J2MPDC10 = 99998 OR J2MPDC10 = 99999) THEN J2MPDC10 = .;
   IF (J2MPC11 = 99999997 OR J2MPC11 = 99999998 OR J2MPC11 = 99999999) THEN J2MPC11 = .;
   IF (J2MPDD11 = 9997.00 OR J2MPDD11 = 9998.00 OR J2MPDD11 = 9999.00) THEN J2MPDD11 = .;
   IF (J2MPDU11 = 97 OR J2MPDU11 = 98 OR J2MPDU11 = 99) THEN J2MPDU11 = .;
   IF (J2MPR11 = 97 OR J2MPR11 = 98 OR J2MPR11 = 99) THEN J2MPR11 = .;
   IF (J2MPF11 = 97 OR J2MPF11 = 98 OR J2MPF11 = 99) THEN J2MPF11 = .;
   IF (J2MPFU11 = 7 OR J2MPFU11 = 8 OR J2MPFU11 = 9) THEN J2MPFU11 = .;
   IF (J2MPT11 = 97.0 OR J2MPT11 = 98.0 OR J2MPT11 = 99.0) THEN J2MPT11 = .;
   IF (J2MPTU11 = 7 OR J2MPTU11 = 8 OR J2MPTU11 = 9) THEN J2MPTU11 = .;
   IF (J2MPDC11 = 99997 OR J2MPDC11 = 99998 OR J2MPDC11 = 99999) THEN J2MPDC11 = .;
   IF (J2MPC12 = 99999997 OR J2MPC12 = 99999998 OR J2MPC12 = 99999999) THEN J2MPC12 = .;
   IF (J2MPDD12 = 9997.00 OR J2MPDD12 = 9998.00 OR J2MPDD12 = 9999.00) THEN J2MPDD12 = .;
   IF (J2MPDU12 = 97 OR J2MPDU12 = 98 OR J2MPDU12 = 99) THEN J2MPDU12 = .;
   IF (J2MPR12 = 97 OR J2MPR12 = 98 OR J2MPR12 = 99) THEN J2MPR12 = .;
   IF (J2MPF12 = 97 OR J2MPF12 = 98 OR J2MPF12 = 99) THEN J2MPF12 = .;
   IF (J2MPFU12 = 7 OR J2MPFU12 = 8 OR J2MPFU12 = 9) THEN J2MPFU12 = .;
   IF (J2MPT12 = 97.0 OR J2MPT12 = 98.0 OR J2MPT12 = 99.0) THEN J2MPT12 = .;
   IF (J2MPTU12 = 7 OR J2MPTU12 = 8 OR J2MPTU12 = 9) THEN J2MPTU12 = .;
   IF (J2MPDC12 = 99997 OR J2MPDC12 = 99998 OR J2MPDC12 = 99999) THEN J2MPDC12 = .;
   IF (J2MPC13 = 99999997 OR J2MPC13 = 99999998 OR J2MPC13 = 99999999) THEN J2MPC13 = .;
   IF (J2MPDD13 = 9997.00 OR J2MPDD13 = 9998.00 OR J2MPDD13 = 9999.00) THEN J2MPDD13 = .;
   IF (J2MPDU13 = 97 OR J2MPDU13 = 98 OR J2MPDU13 = 99) THEN J2MPDU13 = .;
   IF (J2MPR13 = 97 OR J2MPR13 = 98 OR J2MPR13 = 99) THEN J2MPR13 = .;
   IF (J2MPF13 = 97 OR J2MPF13 = 98 OR J2MPF13 = 99) THEN J2MPF13 = .;
   IF (J2MPFU13 = 7 OR J2MPFU13 = 8 OR J2MPFU13 = 9) THEN J2MPFU13 = .;
   IF (J2MPT13 = 97 OR J2MPT13 = 98 OR J2MPT13 = 99) THEN J2MPT13 = .;
   IF (J2MPTU13 = 7 OR J2MPTU13 = 8 OR J2MPTU13 = 9) THEN J2MPTU13 = .;
   IF (J2MBPD = 7 OR J2MBPD = 8 OR J2MBPD = 9) THEN J2MBPD = .;
   IF (J2MBPC = 7 OR J2MBPC = 8 OR J2MBPC = 9) THEN J2MBPC = .;
   IF (J2MCHD = 7 OR J2MCHD = 8 OR J2MCHD = 9) THEN J2MCHD = .;
   IF (J2MCHC = 7 OR J2MCHC = 8 OR J2MCHC = 9) THEN J2MCHC = .;
   IF (J2MDPD = 7 OR J2MDPD = 8 OR J2MDPD = 9) THEN J2MDPD = .;
   IF (J2MDPC = 7 OR J2MDPC = 8 OR J2MDPC = 9) THEN J2MDPC = .;
   IF (J2MCOD = 7 OR J2MCOD = 8 OR J2MCOD = 9) THEN J2MCOD = .;
   IF (J2MCOC = 7 OR J2MCOC = 8 OR J2MCOC = 9) THEN J2MCOC = .;
   IF (J2MSHD = 7 OR J2MSHD = 8 OR J2MSHD = 9) THEN J2MSHD = .;
   IF (J2MSHC = 7 OR J2MSHC = 8 OR J2MSHC = 9) THEN J2MSHC = .;
   IF (J2MQM = 97 OR J2MQM = 98 OR J2MQM = 99) THEN J2MQM = .;
   IF (J2MQMV = 7 OR J2MQMV = 8 OR J2MQMV = 9) THEN J2MQMV = .;
   IF (J2MQC1 = 99999997 OR J2MQC1 = 99999998 OR J2MQC1 = 99999999) THEN J2MQC1 = .;
   IF (J2MQDD1 = 9997.00 OR J2MQDD1 = 9998.00 OR J2MQDD1 = 9999.00) THEN J2MQDD1 = .;
   IF (J2MQDU1 = 97 OR J2MQDU1 = 98 OR J2MQDU1 = 99) THEN J2MQDU1 = .;
   IF (J2MQR1 = 97 OR J2MQR1 = 98 OR J2MQR1 = 99) THEN J2MQR1 = .;
   IF (J2MQF1 = 97 OR J2MQF1 = 98 OR J2MQF1 = 99) THEN J2MQF1 = .;
   IF (J2MQFU1 = 7 OR J2MQFU1 = 8 OR J2MQFU1 = 9) THEN J2MQFU1 = .;
   IF (J2MQT1 = 97.0 OR J2MQT1 = 98.0 OR J2MQT1 = 99.0) THEN J2MQT1 = .;
   IF (J2MQTU1 = 7 OR J2MQTU1 = 8 OR J2MQTU1 = 9) THEN J2MQTU1 = .;
   IF (J2MQDC1 = 99997 OR J2MQDC1 = 99998 OR J2MQDC1 = 99999) THEN J2MQDC1 = .;
   IF (J2MQCS = 7 OR J2MQCS = 8 OR J2MQCS = 9) THEN J2MQCS = .;
   IF (J2MQC2 = 99999997 OR J2MQC2 = 99999998 OR J2MQC2 = 99999999) THEN J2MQC2 = .;
   IF (J2MQDD2 = 9997.00 OR J2MQDD2 = 9998.00 OR J2MQDD2 = 9999.00) THEN J2MQDD2 = .;
   IF (J2MQDU2 = 97 OR J2MQDU2 = 98 OR J2MQDU2 = 99) THEN J2MQDU2 = .;
   IF (J2MQR2 = 97 OR J2MQR2 = 98 OR J2MQR2 = 99) THEN J2MQR2 = .;
   IF (J2MQF2 = 97 OR J2MQF2 = 98 OR J2MQF2 = 99) THEN J2MQF2 = .;
   IF (J2MQFU2 = 7 OR J2MQFU2 = 8 OR J2MQFU2 = 9) THEN J2MQFU2 = .;
   IF (J2MQT2 = 97.0 OR J2MQT2 = 98.0 OR J2MQT2 = 99.0) THEN J2MQT2 = .;
   IF (J2MQTU2 = 7 OR J2MQTU2 = 8 OR J2MQTU2 = 9) THEN J2MQTU2 = .;
   IF (J2MQDC2 = 99997 OR J2MQDC2 = 99998 OR J2MQDC2 = 99999) THEN J2MQDC2 = .;
   IF (J2MQC3 = 99999997 OR J2MQC3 = 99999998 OR J2MQC3 = 99999999) THEN J2MQC3 = .;
   IF (J2MQDD3 = 9997.00 OR J2MQDD3 = 9998.00 OR J2MQDD3 = 9999.00) THEN J2MQDD3 = .;
   IF (J2MQDU3 = 97 OR J2MQDU3 = 98 OR J2MQDU3 = 99) THEN J2MQDU3 = .;
   IF (J2MQR3 = 97 OR J2MQR3 = 98 OR J2MQR3 = 99) THEN J2MQR3 = .;
   IF (J2MQF3 = 97 OR J2MQF3 = 98 OR J2MQF3 = 99) THEN J2MQF3 = .;
   IF (J2MQFU3 = 7 OR J2MQFU3 = 8 OR J2MQFU3 = 9) THEN J2MQFU3 = .;
   IF (J2MQT3 = 97.0 OR J2MQT3 = 98.0 OR J2MQT3 = 99.0) THEN J2MQT3 = .;
   IF (J2MQTU3 = 7 OR J2MQTU3 = 8 OR J2MQTU3 = 9) THEN J2MQTU3 = .;
   IF (J2MQDC3 = 99997 OR J2MQDC3 = 99998 OR J2MQDC3 = 99999) THEN J2MQDC3 = .;
   IF (J2MQC4 = 99999997 OR J2MQC4 = 99999998 OR J2MQC4 = 99999999) THEN J2MQC4 = .;
   IF (J2MQDD4 = 9997.00 OR J2MQDD4 = 9998.00 OR J2MQDD4 = 9999.00) THEN J2MQDD4 = .;
   IF (J2MQDU4 = 97 OR J2MQDU4 = 98 OR J2MQDU4 = 99) THEN J2MQDU4 = .;
   IF (J2MQR4 = 97 OR J2MQR4 = 98 OR J2MQR4 = 99) THEN J2MQR4 = .;
   IF (J2MQF4 = 97 OR J2MQF4 = 98 OR J2MQF4 = 99) THEN J2MQF4 = .;
   IF (J2MQFU4 = 7 OR J2MQFU4 = 8 OR J2MQFU4 = 9) THEN J2MQFU4 = .;
   IF (J2MQT4 = 97.0 OR J2MQT4 = 98.0 OR J2MQT4 = 99.0) THEN J2MQT4 = .;
   IF (J2MQTU4 = 7 OR J2MQTU4 = 8 OR J2MQTU4 = 9) THEN J2MQTU4 = .;
   IF (J2MQDC4 = 99997 OR J2MQDC4 = 99998 OR J2MQDC4 = 99999) THEN J2MQDC4 = .;
   IF (J2MQC5 = 99999997 OR J2MQC5 = 99999998 OR J2MQC5 = 99999999) THEN J2MQC5 = .;
   IF (J2MQDD5 = 9997.00 OR J2MQDD5 = 9998.00 OR J2MQDD5 = 9999.00) THEN J2MQDD5 = .;
   IF (J2MQDU5 = 97 OR J2MQDU5 = 98 OR J2MQDU5 = 99) THEN J2MQDU5 = .;
   IF (J2MQR5 = 97 OR J2MQR5 = 98 OR J2MQR5 = 99) THEN J2MQR5 = .;
   IF (J2MQF5 = 97 OR J2MQF5 = 98 OR J2MQF5 = 99) THEN J2MQF5 = .;
   IF (J2MQFU5 = 7 OR J2MQFU5 = 8 OR J2MQFU5 = 9) THEN J2MQFU5 = .;
   IF (J2MQT5 = 97.0 OR J2MQT5 = 98.0 OR J2MQT5 = 99.0) THEN J2MQT5 = .;
   IF (J2MQTU5 = 7 OR J2MQTU5 = 8 OR J2MQTU5 = 9) THEN J2MQTU5 = .;
   IF (J2MQDC5 = 99997 OR J2MQDC5 = 99998 OR J2MQDC5 = 99999) THEN J2MQDC5 = .;
   IF (J2MQC6 = 99999997 OR J2MQC6 = 99999998 OR J2MQC6 = 99999999) THEN J2MQC6 = .;
   IF (J2MQDD6 = 9997.00 OR J2MQDD6 = 9998.00 OR J2MQDD6 = 9999.00) THEN J2MQDD6 = .;
   IF (J2MQDU6 = 97 OR J2MQDU6 = 98 OR J2MQDU6 = 99) THEN J2MQDU6 = .;
   IF (J2MQR6 = 97 OR J2MQR6 = 98 OR J2MQR6 = 99) THEN J2MQR6 = .;
   IF (J2MQF6 = 97 OR J2MQF6 = 98 OR J2MQF6 = 99) THEN J2MQF6 = .;
   IF (J2MQFU6 = 7 OR J2MQFU6 = 8 OR J2MQFU6 = 9) THEN J2MQFU6 = .;
   IF (J2MQT6 = 97.0 OR J2MQT6 = 98.0 OR J2MQT6 = 99.0) THEN J2MQT6 = .;
   IF (J2MQTU6 = 7 OR J2MQTU6 = 8 OR J2MQTU6 = 9) THEN J2MQTU6 = .;
   IF (J2MQDC6 = 99997 OR J2MQDC6 = 99998 OR J2MQDC6 = 99999) THEN J2MQDC6 = .;
   IF (J2MQC7 = 99999997 OR J2MQC7 = 99999998 OR J2MQC7 = 99999999) THEN J2MQC7 = .;
   IF (J2MQDD7 = 9997.00 OR J2MQDD7 = 9998.00 OR J2MQDD7 = 9999.00) THEN J2MQDD7 = .;
   IF (J2MQDU7 = 97 OR J2MQDU7 = 98 OR J2MQDU7 = 99) THEN J2MQDU7 = .;
   IF (J2MQR7 = 97 OR J2MQR7 = 98 OR J2MQR7 = 99) THEN J2MQR7 = .;
   IF (J2MQF7 = 97 OR J2MQF7 = 98 OR J2MQF7 = 99) THEN J2MQF7 = .;
   IF (J2MQFU7 = 7 OR J2MQFU7 = 8 OR J2MQFU7 = 9) THEN J2MQFU7 = .;
   IF (J2MQT7 = 97.0 OR J2MQT7 = 98.0 OR J2MQT7 = 99.0) THEN J2MQT7 = .;
   IF (J2MQTU7 = 7 OR J2MQTU7 = 8 OR J2MQTU7 = 9) THEN J2MQTU7 = .;
   IF (J2MQDC7 = 99997 OR J2MQDC7 = 99998 OR J2MQDC7 = 99999) THEN J2MQDC7 = .;
   IF (J2MQC8 = 99999997 OR J2MQC8 = 99999998 OR J2MQC8 = 99999999) THEN J2MQC8 = .;
   IF (J2MQDD8 = 9997.00 OR J2MQDD8 = 9998.00 OR J2MQDD8 = 9999.00) THEN J2MQDD8 = .;
   IF (J2MQDU8 = 97 OR J2MQDU8 = 98 OR J2MQDU8 = 99) THEN J2MQDU8 = .;
   IF (J2MQR8 = 97 OR J2MQR8 = 98 OR J2MQR8 = 99) THEN J2MQR8 = .;
   IF (J2MQF8 = 97 OR J2MQF8 = 98 OR J2MQF8 = 99) THEN J2MQF8 = .;
   IF (J2MQFU8 = 7 OR J2MQFU8 = 8 OR J2MQFU8 = 9) THEN J2MQFU8 = .;
   IF (J2MQT8 = 97.0 OR J2MQT8 = 98.0 OR J2MQT8 = 99.0) THEN J2MQT8 = .;
   IF (J2MQTU8 = 7 OR J2MQTU8 = 8 OR J2MQTU8 = 9) THEN J2MQTU8 = .;
   IF (J2MQDC8 = 99997 OR J2MQDC8 = 99998 OR J2MQDC8 = 99999) THEN J2MQDC8 = .;
   IF (J2MQC9 = 99999997 OR J2MQC9 = 99999998 OR J2MQC9 = 99999999) THEN J2MQC9 = .;
   IF (J2MQDD9 = 9997.00 OR J2MQDD9 = 9998.00 OR J2MQDD9 = 9999.00) THEN J2MQDD9 = .;
   IF (J2MQDU9 = 97 OR J2MQDU9 = 98 OR J2MQDU9 = 99) THEN J2MQDU9 = .;
   IF (J2MQR9 = 97 OR J2MQR9 = 98 OR J2MQR9 = 99) THEN J2MQR9 = .;
   IF (J2MQF9 = 97 OR J2MQF9 = 98 OR J2MQF9 = 99) THEN J2MQF9 = .;
   IF (J2MQFU9 = 7 OR J2MQFU9 = 8 OR J2MQFU9 = 9) THEN J2MQFU9 = .;
   IF (J2MQT9 = 97.0 OR J2MQT9 = 98.0 OR J2MQT9 = 99.0) THEN J2MQT9 = .;
   IF (J2MQTU9 = 7 OR J2MQTU9 = 8 OR J2MQTU9 = 9) THEN J2MQTU9 = .;
   IF (J2MQDC9 = 99997 OR J2MQDC9 = 99998 OR J2MQDC9 = 99999) THEN J2MQDC9 = .;
   IF (J2MQC10 = 99999997 OR J2MQC10 = 99999998 OR J2MQC10 = 99999999) THEN J2MQC10 = .;
   IF (J2MQDD10 = 9997.00 OR J2MQDD10 = 9998.00 OR J2MQDD10 = 9999.00) THEN J2MQDD10 = .;
   IF (J2MQDU10 = 97 OR J2MQDU10 = 98 OR J2MQDU10 = 99) THEN J2MQDU10 = .;
   IF (J2MQR10 = 97 OR J2MQR10 = 98 OR J2MQR10 = 99) THEN J2MQR10 = .;
   IF (J2MQF10 = 97 OR J2MQF10 = 98 OR J2MQF10 = 99) THEN J2MQF10 = .;
   IF (J2MQFU10 = 7 OR J2MQFU10 = 8 OR J2MQFU10 = 9) THEN J2MQFU10 = .;
   IF (J2MQT10 = 97.0 OR J2MQT10 = 98.0 OR J2MQT10 = 99.0) THEN J2MQT10 = .;
   IF (J2MQTU10 = 7 OR J2MQTU10 = 8 OR J2MQTU10 = 9) THEN J2MQTU10 = .;
   IF (J2MQDC10 = 99997 OR J2MQDC10 = 99998 OR J2MQDC10 = 99999) THEN J2MQDC10 = .;
   IF (J2ML = 7 OR J2ML = 8 OR J2ML = 9) THEN J2ML = .;
   IF (J2MLM = 97 OR J2MLM = 98 OR J2MLM = 99) THEN J2MLM = .;
   IF (J2MLC1 = 99999997 OR J2MLC1 = 99999998 OR J2MLC1 = 99999999) THEN J2MLC1 = .;
   IF (J2MLC2 = 99999997 OR J2MLC2 = 99999998 OR J2MLC2 = 99999999) THEN J2MLC2 = .;
   IF (J2MLC3 = 99999997 OR J2MLC3 = 99999998 OR J2MLC3 = 99999999) THEN J2MLC3 = .;
   IF (J2MLC4 = 99999997 OR J2MLC4 = 99999998 OR J2MLC4 = 99999999) THEN J2MLC4 = .;
   IF (J2MLC5 = 99999997 OR J2MLC5 = 99999998 OR J2MLC5 = 99999999) THEN J2MLC5 = .;
   IF (J2MLC6 = 99999997 OR J2MLC6 = 99999998 OR J2MLC6 = 99999999) THEN J2MLC6 = .;
   IF (J2MLC7 = 99999997 OR J2MLC7 = 99999998 OR J2MLC7 = 99999999) THEN J2MLC7 = .;
*/


* SAS FORMAT STATEMENT;

/*
  FORMAT J1SQ1 j1sq1fff. J2Q1A j2q1a. J2Q1AD j2q1ad.
         J2Q1B j2q1b. J2Q1BD j2q1bd. J2Q1C j2q1c.
         J2Q1CD j2q1cd. J2Q1D j2q1d. J2Q1DD j2q1dd.
         J2Q1E j2q1e. J2Q1ED j2q1ed. J2Q1F j2q1f.
         J2Q1FD j2q1fd. J2Q1G j2q1g. J2Q1GD j2q1gd.
         J2Q1H j2q1h. J2Q1HD j2q1hd. J2Q1I j2q1i.
         J2Q1ID j2q1id. J2Q1J j2q1j. J2Q1JD j2q1jd.
         J2Q1K j2q1k. J2Q1KD j2q1kd. J2Q1L j2q1l.
         J2Q1LD j2q1ld. J2Q1M j2q1m. J2Q1MD j2q1md.
         J2Q1N j2q1n. J2Q1ND j2q1nd. J2Q1O j2q1o.
         J2Q1OD j2q1od. J2Q1P j2q1p. J2Q1PD j2q1pd.
         J2Q1Q j2q1q. J2Q1QD j2q1qd. J2Q1R j2q1r.
         J2Q1RD j2q1rd. J2Q1S j2q1s. J2Q1SD j2q1sd.
         J2Q1T j2q1t. J2Q1TD j2q1td. J2Q1U j2q1u.
         J2Q1UD j2q1ud. J2Q1V j2q1v. J2Q1VD j2q1vd.
         J2Q1W j2q1w. J2Q1WD j2q1wd. J2Q1X j2q1x.
         J2Q1XD j2q1xd. J2Q1Y j2q1y. J2Q1YD j2q1yd.
         J2Q1Z j2q1z. J2Q1ZD j2q1zd. J2Q1AA j2q1aa.
         J2Q1AAD j2q1aad. J2Q1BB j2q1bb. J2Q1BBD j2q1bbd.
         J2Q1CC j2q1cc. J2Q1CCD j2q1ccd. J2Q1EE j2q1ee.
         J2Q1EED j2q1eed. J2Q1FF j2q1ff. J2Q1FFD j2q1ffd.
         J2QSYMN j2qsymn. J2QSYMX j2qsymx. J2QSYMN2 j2qsymnf.
         J2QSYMX2 j2qsymxf. J2Q2 j2q2ffff. J2Q2A j2q2a.
         J2Q2A2 j2q2a2ff. J2Q2B1 j2q2b1ff. J2Q2B2 j2q2b2ff.
         J2Q2B3 j2q2b3ff. J2Q2B4 j2q2b4ff. J2Q2B5 j2q2b5ff.
         J2Q2B6 j2q2b6ff. J2Q2B7 j2q2b7ff. J2Q2B8 j2q2b8ff.
         J2Q2B9 j2q2b9ff. J2Q2B10 j2q2b10f. J2Q3 j2q3ffff.
         J2Q3AH j2q3ah. J2Q3AEM j2q3aem. J2Q3AEMY j2q3aemy.
         J2Q3ACEY j2q3acey. J2Q3BH j2q3bh. J2Q3BEM j2q3bem.
         J2Q3BEMY j2q3bemy. J2Q3BCEY j2q3bcey. J2Q4 j2q4ffff.
         J2Q4AH j2q4ah. J2Q4AEM j2q4aem. J2Q4AEMY j2q4aemy.
         J2Q4ACEY j2q4acey. J2Q4BH j2q4bh. J2Q4BEM j2q4bem.
         J2Q4BEMY j2q4bemy. J2Q4BCEY j2q4bcey. J2Q5 j2q5ffff.
         J2Q5AH j2q5ah. J2Q5AEM j2q5aem. J2Q5AEMY j2q5aemy.
         J2Q5ACEY j2q5acey. J2Q5BH j2q5bh. J2Q5BEM j2q5bem.
         J2Q5BEMY j2q5bemy. J2Q5BCEY j2q5bcey. J2Q6 j2q6ffff.
         J2Q6AH j2q6ah. J2Q6AEM j2q6aem. J2Q6AEMY j2q6aemy.
         J2Q6ACEY j2q6acey. J2Q6BH j2q6bh. J2Q6BEM j2q6bem.
         J2Q6BEMY j2q6bemy. J2Q6BCEY j2q6bcey. J2Q7AMPM j2q7ampm.
         J2Q7H j2q7h. J2Q7M j2q7m. J2Q8 j2q8ffff.
         J2Q9AMPM j2q9ampm. J2Q9H j2q9h. J2Q9M j2q9m.
         J2Q10H j2q10h. J2Q10M j2q10m. J2Q11A j2q11a.
         J2Q11B j2q11b. J2Q11C j2q11c. J2Q11D j2q11d.
         J2Q11E j2q11e. J2Q11F j2q11f. J2Q11G j2q11g.
         J2Q11H j2q11h. J2Q11I j2q11i. J2Q11J j2q11j.
         J2Q12 j2q12fff. J2Q13 j2q13fff. J2Q14 j2q14fff.
         J2Q15 j2q15fff. J2Q16 j2q16fff. J2QSQ_S1 j2qsq_sf.
         J2QSQ_S2 j2qsq_0f. J2QSQ_S3 j2qsq_1f. J2QSQ_S4 j2qsq_2f.
         J2QSQ_S5 j2qsq_3f. J2QSQ_S6 j2qsq_4f. J2QSQ_S7 j2qsq_5f.
         J2QSQ_GS j2qsq_gs. J2Q17 j2q17fff. J2Q18 j2q18fff.
         J2Q19 j2q19fff. J2Q20 j2q20fff. J2Q21 j2q21fff.
         J2Q22 j2q22fff. J2Q23A j2q23a. J2Q23B j2q23b.
         J2Q23C j2q23c. J2Q23D j2q23d. J2Q23E j2q23e.
         J2Q23F j2q23f. J2Q23G j2q23g. J2Q23H j2q23h.
         J2Q23I j2q23i. J2Q24 j2q24fff. J2Q26 j2q26fff.
         J2Q27A j2q27a. J2Q27B j2q27b. J2Q27C j2q27c.
         J2Q28A j2q28a. J2Q28B j2q28b. J2Q28C j2q28c.
         J2Q28D j2q28d. J2Q29 j2q29fff. J2Q30 j2q30fff.
         J2Q31 j2q31fff. J2Q32 j2q32fff. J2Q33 j2q33fff.
         J2Q34A j2q34a. J2Q34B j2q34b. J2Q34C j2q34c.
         J2Q34D j2q34d. J2Q35 j2q35fff. J2Q36 j2q36fff.
         J2Q37M j2q37m. J2Q37Y j2q37y. J2Q38 j2q38fff.
         J2QMARR j2qmarr. J2Q39 j2q39fff. J2Q39AG j2q39ag.
         J2Q39AM j2q39am. J2Q39AY j2q39ay. J2Q39BG j2q39bg.
         J2Q39BM j2q39bm. J2Q39BY j2q39by. J2Q39CG j2q39cg.
         J2Q39CM j2q39cm. J2Q39CY j2q39cy. J2Q40A j2q40a.
         J2Q40A1 j2q40a1f. J2Q40A3 j2q40a3f. J2Q40A4 j2q40a4f.
         J2Q40B j2q40b. J2Q40B1 j2q40b1f. J2Q40B3 j2q40b3f.
         J2Q40B4 j2q40b4f. J2Q40C j2q40c. J2Q40C1 j2q40c1f.
         J2Q40C3 j2q40c3f. J2Q40C4 j2q40c4f. J2Q40D j2q40d.
         J2Q40D1 j2q40d1f. J2Q40D3 j2q40d3f. J2Q40D4 j2q40d4f.
         J2Q40E j2q40e. J2Q40E1 j2q40e1f. J2Q40E3 j2q40e3f.
         J2Q40E4 j2q40e4f. J2Q40F j2q40f. J2Q40F1 j2q40f1f.
         J2Q40F3 j2q40f3f. J2Q40F4 j2q40f4f. J2Q40G j2q40g.
         J2Q40G1 j2q40g1f. J2Q40G3 j2q40g3f. J2Q40G4 j2q40g4f.
         J2Q41H j2q41h. J2Q41H1 j2q41h1f. J2Q41H3 j2q41h3f.
         J2Q41H4 j2q41h4f. J2Q41I j2q41i. J2Q41I1 j2q41i1f.
         J2Q41I3 j2q41i3f. J2Q41I4 j2q41i4f. J2Q41J j2q41j.
         J2Q41J1 j2q41j1f. J2Q41J3 j2q41j3f. J2Q41J4 j2q41j4f.
         J2Q41K j2q41k. J2Q41K1 j2q41k1f. J2Q41K3 j2q41k3f.
         J2Q41K4 j2q41k4f. J2Q41L j2q41l. J2Q41L1 j2q41l1f.
         J2Q41L3 j2q41l3f. J2Q41L4 j2q41l4f. J2Q41M j2q41m.
         J2Q41M1 j2q41m1f. J2Q41M3 j2q41m3f. J2Q41M4 j2q41m4f.
         J2Q41N j2q41n. J2Q41N1 j2q41n1f. J2Q41N3 j2q41n3f.
         J2Q41N4 j2q41n4f. J2Q41O j2q41o. J2Q41O1 j2q41o1f.
         J2Q41O3 j2q41o3f. J2Q41O4 j2q41o4f. J2Q41P j2q41p.
         J2Q41P1 j2q41p1f. J2Q41P3 j2q41p3f. J2Q41P4 j2q41p4f.
         J2Q41Q j2q41q. J2Q41Q1 j2q41q1f. J2Q41Q3 j2q41q3f.
         J2Q41Q4 j2q41q4f. J2Q41R j2q41r. J2Q41R1 j2q41r1f.
         J2Q41R3 j2q41r3f. J2Q41R4 j2q41r4f. J2Q41S j2q41s.
         J2Q41S1 j2q41s1f. J2Q41S3 j2q41s3f. J2Q41S4 j2q41s4f.
         J2Q41T j2q41t. J2Q41T1 j2q41t1f. J2Q41T3 j2q41t3f.
         J2Q41T4 j2q41t4f. J2Q41U j2q41u. J2Q41U1 j2q41u1f.
         J2Q41U3 j2q41u3f. J2Q41U4 j2q41u4f. J2Q41V j2q41v.
         J2Q41V1 j2q41v1f. J2Q41V3 j2q41v3f. J2Q41V4 j2q41v4f.
         J2Q41W j2q41w. J2Q41W1 j2q41w1f. J2Q41W3 j2q41w3f.
         J2Q41W4 j2q41w4f. J2Q41X j2q41x. J2Q41X1 j2q41x1f.
         J2Q41X3 j2q41x3f. J2Q41X4 j2q41x4f. J2Q41Y j2q41y.
         J2Q41Y1 j2q41y1f. J2Q41Y3 j2q41y3f. J2Q41Y4 j2q41y4f.
         J2Q42 j2q42fff. J2Q42AM j2q42am. J2Q42AY j2q42ay.
         J2Q42BM j2q42bm. J2Q42BY j2q42by. J2Q42CM j2q42cm.
         J2Q42CY j2q42cy. J2Q43A j2q43a. J2Q43B j2q43b.
         J2Q43C j2q43c. J2Q43D j2q43d. J2Q43E j2q43e.
         J2Q43F j2q43f. J2Q43G j2q43g. J2Q43H j2q43h.
         J2Q43I j2q43i. J2Q43J j2q43j. J2Q43K j2q43k.
         J2Q43L j2q43l. J2Q43M j2q43m. J2Q43N j2q43n.
         J2Q43O j2q43o. J2Q43P j2q43p. J2Q43Q j2q43q.
         J2Q43R j2q43r. J2Q43S j2q43s. J2Q43T j2q43t.
         J2QCESD j2qcesd. J2Q44A j2q44a. J2Q44B j2q44b.
         J2Q44C j2q44c. J2Q44D j2q44d. J2Q44E j2q44e.
         J2Q44F j2q44f. J2Q44G j2q44g. J2Q44H j2q44h.
         J2Q44I j2q44i. J2Q44J j2q44j. J2Q44K j2q44k.
         J2Q44L j2q44l. J2Q44M j2q44m. J2Q44N j2q44n.
         J2Q44O j2q44o. J2Q44P j2q44p. J2Q44Q j2q44q.
         J2Q44R j2q44r. J2Q44S j2q44s. J2Q44T j2q44t.
         J2QTA_AX j2qta_ax. J2Q45A j2q45a. J2Q45B j2q45b.
         J2Q45C j2q45c. J2Q45D j2q45d. J2Q45E j2q45e.
         J2Q45F j2q45f. J2Q45G j2q45g. J2Q45H j2q45h.
         J2Q45I j2q45i. J2Q45J j2q45j. J2Q45K j2q45k.
         J2Q45L j2q45l. J2Q45M j2q45m. J2Q45N j2q45n.
         J2Q45O j2q45o. J2QTA_AG j2qta_ag. J2QTA_AT j2qta_at.
         J2QTA_AR j2qta_ar. J2Q46A1 j2q46a1f. J2Q46A2 j2q46a2f.
         J2Q46B1 j2q46b1f. J2Q46B2 j2q46b2f. J2Q46C1 j2q46c1f.
         J2Q46C2 j2q46c2f. J2Q46D1 j2q46d1f. J2Q46D2 j2q46d2f.
         J2Q46E1 j2q46e1f. J2Q46E2 j2q46e2f. J2Q46F1 j2q46f1f.
         J2Q46F2 j2q46f2f. J2Q46G1 j2q46g1f. J2Q46G2 j2q46g2f.
         J2Q46H1 j2q46h1f. J2Q46H2 j2q46h2f. J2Q46I1 j2q46i1f.
         J2Q46I2 j2q46i2f. J2Q46J1 j2q46j1f. J2Q46J2 j2q46j2f.
         J2Q46K1 j2q46k1f. J2Q46K2 j2q46k2f. J2Q46L1 j2q46l1f.
         J2Q46L2 j2q46l2f. J2Q46M1 j2q46m1f. J2Q46M2 j2q46m2f.
         J2Q46N1 j2q46n1f. J2Q46N2 j2q46n2f. J2Q46O1 j2q46o1f.
         J2Q46O2 j2q46o2f. J2Q46P1 j2q46p1f. J2Q46P2 j2q46p2f.
         J2Q46Q1 j2q46q1f. J2Q46Q2 j2q46q2f. J2Q46R1 j2q46r1f.
         J2Q46R2 j2q46r2f. J2Q46S1 j2q46s1f. J2Q46S2 j2q46s2f.
         J2Q46T1 j2q46t1f. J2Q46T2 j2q46t2f. J2Q46U1 j2q46u1f.
         J2Q46U2 j2q46u2f. J2Q46V1 j2q46v1f. J2Q46V2 j2q46v2f.
         J2Q46W1 j2q46w1f. J2Q46W2 j2q46w2f. J2Q46X1 j2q46x1f.
         J2Q46X2 j2q46x2f. J2Q46Y1 j2q46y1f. J2Q46Y2 j2q46y2f.
         J2Q46AA1 j2q46aaf. J2Q46AA2 j2q46a0f. J2Q46BB1 j2q46bbf.
         J2Q46BB2 j2q46b0f. J2Q46CC1 j2q46ccf. J2Q46CC2 j2q46c0f.
         J2Q46DD1 j2q46ddf. J2Q46DD2 j2q46d0f. J2Q46EE1 j2q46eef.
         J2Q46EE2 j2q46e0f. J2Q46FF1 j2q46fff. J2Q46FF2 j2q46f0f.
         J2Q46HH1 j2q46hhf. J2Q46HH2 j2q46h0f. J2Q46II1 j2q46iif.
         J2Q46II2 j2q46i0f. J2Q46JJ1 j2q46jjf. J2Q46JJ2 j2q46j0f.
         J2Q46KK1 j2q46kkf. J2Q46KK2 j2q46k0f. J2Q46LL1 j2q46llf.
         J2Q46LL2 j2q46l0f. J2Q46MM1 j2q46mmf. J2Q46MM2 j2q46m0f.
         J2Q46NN1 j2q46nnf. J2Q46NN2 j2q46n0f. J2Q46OO1 j2q46oof.
         J2Q46OO2 j2q46o0f. J2Q46PP1 j2q46ppf. J2Q46PP2 j2q46p0f.
         J2Q46QQ1 j2q46qqf. J2Q46QQ2 j2q46q0f. J2Q46RR1 j2q46rrf.
         J2Q46RR2 j2q46r0f. J2Q46SS1 j2q46ssf. J2Q46SS2 j2q46s0f.
         J2Q46TT1 j2q46ttf. J2Q46TT2 j2q46t0f. J2Q46UU1 j2q46uuf.
         J2Q46UU2 j2q46u0f. J2Q46VV1 j2q46vvf. J2Q46VV2 j2q46v0f.
         J2Q46WW1 j2q46wwf. J2Q46WW2 j2q46w0f. J2Q47A j2q47a.
         J2Q47B j2q47b. J2Q47C j2q47c. J2Q47D j2q47d.
         J2Q47E j2q47e. J2Q47F j2q47f. J2Q47G j2q47g.
         J2Q47H j2q47h. J2Q47I j2q47i. J2Q47J j2q47j.
         J2Q47K j2q47k. J2Q47L j2q47l. J2QSO_PC j2qso_pc.
         J2QSO_PF j2qso_pf. J2QSO_PX j2qso_px. J2QSO_IW j2qso_iw.
         J2QSO_GW j2qso_gw. J2Q48A j2q48a. J2Q48B j2q48b.
         J2Q48C j2q48c. J2Q48D j2q48d. J2Q48E j2q48e.
         J2Q48F j2q48f. J2Q48G j2q48g. J2Q48H j2q48h.
         J2Q48I j2q48i. J2Q48J j2q48j. J2Q48K j2q48k.
         J2Q48L j2q48l. J2Q48M j2q48m. J2Q48N j2q48n.
         J2Q48O j2q48o. J2Q48P j2q48p. J2Q48Q j2q48q.
         J2Q48R j2q48r. J2Q48S j2q48s. J2Q48T j2q48t.
         J2Q48U j2q48u. J2QRISC j2qrisc. J2QSYMP j2qsymp.
         J2QADJ j2qadj. J2Q49A j2q49a. J2Q49B j2q49b.
         J2Q49C j2q49c. J2Q49D j2q49d. J2Q49E j2q49e.
         J2Q49F j2q49f. J2Q49G j2q49g. J2Q49H j2q49h.
         J2QSSCTR j2qssctr. J2QCSCD4 j2qcscdf. J2QCSCD6 j2qcsc0f.
         J2QCSCP4 j2qcscpf. J2QCSCP5 j2qcsc1f. J2Q50A j2q50a.
         J2Q50B j2q50b. J2Q50C j2q50c. J2Q50D j2q50d.
         J2Q50E j2q50e. J2Q50F j2q50f. J2Q50G j2q50g.
         J2Q50H j2q50h. J2QSW_JP j2qsw_jp. J2Q51A j2q51a.
         J2Q51B j2q51b. J2Q51C j2q51c. J2Q51D j2q51d.
         J2Q51E j2q51e. J2Q51F j2q51f. J2Q51G j2q51g.
         J2Q51H j2q51h. J2Q51I j2q51i. J2Q51J j2q51j.
         J2Q51K j2q51k. J2Q51L j2q51l. J2Q51M j2q51m.
         J2Q51N j2q51n. J2Q51O j2q51o. J2Q51P j2q51p.
         J2Q51Q j2q51q. J2Q52 j2q52fff. J2Q541 j2q541ff.
         J2Q542 j2q542ff. J2Q543 j2q543ff. J2Q544 j2q544ff.
         J2Q545 j2q545ff. J2Q546 j2q546ff. J2Q547 j2q547ff.
         J2Q548 j2q548ff. J2Q549 j2q549ff. J2Q5410 j2q5410f.
         J2Q5411 j2q5411f. J2Q5412 j2q5412f. J2Q5413 j2q5413f.
         J2Q5414 j2q5414f. J2Q5415 j2q5415f. J2Q5416 j2q5416f.
         J2Q5417 j2q5417f. J2Q5418 j2q5418f. J2Q5419 j2q5419f.
         J2Q5420 j2q5420f. J2Q5421 j2q5421f. J2Q5422 j2q5422f.
         J2QJC_SD j2qjc_sd. J2QJC_DA j2qjc_da. J2QJC_DL j2qjc_dl.
         J2QJC_PD j2qjc_pd. J2QJC_SS j2qjc_ss. J2QJC_CS j2qjc_cs.
         J2CLMDAY j2clmday. J2CBMI j2cbmi. J2CHIPCM j2chipcm.
         J2CWHR j2cwhr. J2CBPS23 j2cbps2f. J2CBPD23 j2cbpd2f.
         J2CBLD j2cbld. J2BCHOL j2bchol. J2BHDL j2bhdl.
         J2BHDLA j2bhdla. J2BRTHDL j2brthdl. J2BRTHDA j2brthda.
         J2BDHEAS j2bdheas. J2BDHEA j2bdhea. J2BSCREA j2bscrea.
         J2BIL6 j2bil6ff. J2BSIL6R j2bsil6r. J2BFGN j2bfgn.
         J2BCRP j2bcrp. J2SSAL j2ssal. J2CSCSEQ j2cscseq.
         J2SD1MNH j2sd1mnh. J2SD1MNM j2sd1mnm. J2SD1MDH j2sd1mdh.
         J2SD1MDM j2sd1mdm. J2SD1EVH j2sd1evh. J2SD1EVM j2sd1evm.
         J2SD2MNH j2sd2mnh. J2SD2MNM j2sd2mnm. J2SD2MDH j2sd2mdh.
         J2SD2MDM j2sd2mdm. J2SD2EVH j2sd2evh. J2SD2EVM j2sd2evm.
         J2SD3MNH j2sd3mnh. J2SD3MNM j2sd3mnm. J2SD3MDH j2sd3mdh.
         J2SD3MDM j2sd3mdm. J2SD3EVH j2sd3evh. J2SD3EVM j2sd3evm.
         J2SCDAY1 j2scdayf. J2SCDAY2 j2scda0f. J2SCDAY3 j2scda1f.
         J2BSCD11 j2bscd1f. J2BSCD12 j2bscd0f. J2BSCD13 j2bscd2f.
         J2BSCD21 j2bscd3f. J2BSCD22 j2bscd4f. J2BSCD23 j2bscd5f.
         J2BSCD31 j2bscd6f. J2BSCD32 j2bscd7f. J2BSCD33 j2bscd8f.
         J2MPMD j2mpmd. J2MQMD j2mqmd. J2MPM j2mpm.
         J2MPC1 j2mpc1ff. J2MPDD1 j2mpdd1f. J2MPDU1 j2mpdu1f.
         J2MPR1 j2mpr1ff. J2MPF1 j2mpf1ff. J2MPFU1 j2mpfu1f.
         J2MPT1 j2mpt1ff. J2MPTU1 j2mptu1f. J2MPDC1 j2mpdc1f.
         J2MPC2 j2mpc2ff. J2MPDD2 j2mpdd2f. J2MPDU2 j2mpdu2f.
         J2MPR2 j2mpr2ff. J2MPF2 j2mpf2ff. J2MPFU2 j2mpfu2f.
         J2MPT2 j2mpt2ff. J2MPTU2 j2mptu2f. J2MPDC2 j2mpdc2f.
         J2MPC3 j2mpc3ff. J2MPDD3 j2mpdd3f. J2MPDU3 j2mpdu3f.
         J2MPR3 j2mpr3ff. J2MPF3 j2mpf3ff. J2MPFU3 j2mpfu3f.
         J2MPT3 j2mpt3ff. J2MPTU3 j2mptu3f. J2MPDC3 j2mpdc3f.
         J2MPC4 j2mpc4ff. J2MPDD4 j2mpdd4f. J2MPDU4 j2mpdu4f.
         J2MPR4 j2mpr4ff. J2MPF4 j2mpf4ff. J2MPFU4 j2mpfu4f.
         J2MPT4 j2mpt4ff. J2MPTU4 j2mptu4f. J2MPDC4 j2mpdc4f.
         J2MPC5 j2mpc5ff. J2MPDD5 j2mpdd5f. J2MPDU5 j2mpdu5f.
         J2MPR5 j2mpr5ff. J2MPF5 j2mpf5ff. J2MPFU5 j2mpfu5f.
         J2MPT5 j2mpt5ff. J2MPTU5 j2mptu5f. J2MPDC5 j2mpdc5f.
         J2MPC6 j2mpc6ff. J2MPDD6 j2mpdd6f. J2MPDU6 j2mpdu6f.
         J2MPR6 j2mpr6ff. J2MPF6 j2mpf6ff. J2MPFU6 j2mpfu6f.
         J2MPT6 j2mpt6ff. J2MPTU6 j2mptu6f. J2MPDC6 j2mpdc6f.
         J2MPC7 j2mpc7ff. J2MPDD7 j2mpdd7f. J2MPDU7 j2mpdu7f.
         J2MPR7 j2mpr7ff. J2MPF7 j2mpf7ff. J2MPFU7 j2mpfu7f.
         J2MPT7 j2mpt7ff. J2MPTU7 j2mptu7f. J2MPDC7 j2mpdc7f.
         J2MPC8 j2mpc8ff. J2MPDD8 j2mpdd8f. J2MPDU8 j2mpdu8f.
         J2MPR8 j2mpr8ff. J2MPF8 j2mpf8ff. J2MPFU8 j2mpfu8f.
         J2MPT8 j2mpt8ff. J2MPTU8 j2mptu8f. J2MPDC8 j2mpdc8f.
         J2MPC9 j2mpc9ff. J2MPDD9 j2mpdd9f. J2MPDU9 j2mpdu9f.
         J2MPR9 j2mpr9ff. J2MPF9 j2mpf9ff. J2MPFU9 j2mpfu9f.
         J2MPT9 j2mpt9ff. J2MPTU9 j2mptu9f. J2MPDC9 j2mpdc9f.
         J2MPC10 j2mpc10f. J2MPDD10 j2mpdd0f. J2MPDU10 j2mpdu0f.
         J2MPR10 j2mpr10f. J2MPF10 j2mpf10f. J2MPFU10 j2mpfu0f.
         J2MPT10 j2mpt10f. J2MPTU10 j2mptu0f. J2MPDC10 j2mpdc0f.
         J2MPC11 j2mpc11f. J2MPDD11 j2mpd10f. J2MPDU11 j2mpd11f.
         J2MPR11 j2mpr11f. J2MPF11 j2mpf11f. J2MPFU11 j2mpf12f.
         J2MPT11 j2mpt11f. J2MPTU11 j2mpt12f. J2MPDC11 j2mpd12f.
         J2MPC12 j2mpc12f. J2MPDD12 j2mpd13f. J2MPDU12 j2mpd14f.
         J2MPR12 j2mpr12f. J2MPF12 j2mpf13f. J2MPFU12 j2mpf14f.
         J2MPT12 j2mpt13f. J2MPTU12 j2mpt14f. J2MPDC12 j2mpd15f.
         J2MPC13 j2mpc13f. J2MPDD13 j2mpd16f. J2MPDU13 j2mpd17f.
         J2MPR13 j2mpr13f. J2MPF13 j2mpf15f. J2MPFU13 j2mpf16f.
         J2MPT13 j2mpt15f. J2MPTU13 j2mpt16f. J2MBPD j2mbpd.
         J2MBPC j2mbpc. J2MCHD j2mchd. J2MCHC j2mchc.
         J2MDPD j2mdpd. J2MDPC j2mdpc. J2MCOD j2mcod.
         J2MCOC j2mcoc. J2MSHD j2mshd. J2MSHC j2mshc.
         J2MQM j2mqm. J2MQMV j2mqmv. J2MQC1 j2mqc1ff.
         J2MQDD1 j2mqdd1f. J2MQDU1 j2mqdu1f. J2MQR1 j2mqr1ff.
         J2MQF1 j2mqf1ff. J2MQFU1 j2mqfu1f. J2MQT1 j2mqt1ff.
         J2MQTU1 j2mqtu1f. J2MQDC1 j2mqdc1f. J2MQCS j2mqcs.
         J2MQC2 j2mqc2ff. J2MQDD2 j2mqdd2f. J2MQDU2 j2mqdu2f.
         J2MQR2 j2mqr2ff. J2MQF2 j2mqf2ff. J2MQFU2 j2mqfu2f.
         J2MQT2 j2mqt2ff. J2MQTU2 j2mqtu2f. J2MQDC2 j2mqdc2f.
         J2MQC3 j2mqc3ff. J2MQDD3 j2mqdd3f. J2MQDU3 j2mqdu3f.
         J2MQR3 j2mqr3ff. J2MQF3 j2mqf3ff. J2MQFU3 j2mqfu3f.
         J2MQT3 j2mqt3ff. J2MQTU3 j2mqtu3f. J2MQDC3 j2mqdc3f.
         J2MQC4 j2mqc4ff. J2MQDD4 j2mqdd4f. J2MQDU4 j2mqdu4f.
         J2MQR4 j2mqr4ff. J2MQF4 j2mqf4ff. J2MQFU4 j2mqfu4f.
         J2MQT4 j2mqt4ff. J2MQTU4 j2mqtu4f. J2MQDC4 j2mqdc4f.
         J2MQC5 j2mqc5ff. J2MQDD5 j2mqdd5f. J2MQDU5 j2mqdu5f.
         J2MQR5 j2mqr5ff. J2MQF5 j2mqf5ff. J2MQFU5 j2mqfu5f.
         J2MQT5 j2mqt5ff. J2MQTU5 j2mqtu5f. J2MQDC5 j2mqdc5f.
         J2MQC6 j2mqc6ff. J2MQDD6 j2mqdd6f. J2MQDU6 j2mqdu6f.
         J2MQR6 j2mqr6ff. J2MQF6 j2mqf6ff. J2MQFU6 j2mqfu6f.
         J2MQT6 j2mqt6ff. J2MQTU6 j2mqtu6f. J2MQDC6 j2mqdc6f.
         J2MQC7 j2mqc7ff. J2MQDD7 j2mqdd7f. J2MQDU7 j2mqdu7f.
         J2MQR7 j2mqr7ff. J2MQF7 j2mqf7ff. J2MQFU7 j2mqfu7f.
         J2MQT7 j2mqt7ff. J2MQTU7 j2mqtu7f. J2MQDC7 j2mqdc7f.
         J2MQC8 j2mqc8ff. J2MQDD8 j2mqdd8f. J2MQDU8 j2mqdu8f.
         J2MQR8 j2mqr8ff. J2MQF8 j2mqf8ff. J2MQFU8 j2mqfu8f.
         J2MQT8 j2mqt8ff. J2MQTU8 j2mqtu8f. J2MQDC8 j2mqdc8f.
         J2MQC9 j2mqc9ff. J2MQDD9 j2mqdd9f. J2MQDU9 j2mqdu9f.
         J2MQR9 j2mqr9ff. J2MQF9 j2mqf9ff. J2MQFU9 j2mqfu9f.
         J2MQT9 j2mqt9ff. J2MQTU9 j2mqtu9f. J2MQDC9 j2mqdc9f.
         J2MQC10 j2mqc10f. J2MQDD10 j2mqdd0f. J2MQDU10 j2mqdu0f.
         J2MQR10 j2mqr10f. J2MQF10 j2mqf10f. J2MQFU10 j2mqfu0f.
         J2MQT10 j2mqt10f. J2MQTU10 j2mqtu0f. J2MQDC10 j2mqdc0f.
         J2ML j2ml. J2MLM j2mlm. J2MLC1 j2mlc1ff.
         J2MLC2 j2mlc2ff. J2MLC3 j2mlc3ff. J2MLC4 j2mlc4ff.
         J2MLC5 j2mlc5ff. J2MLC6 j2mlc6ff. J2MLC7 j2mlc7ff.
          ;
*/

RUN ;
