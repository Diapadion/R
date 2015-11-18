/*-------------------------------------------------------------------------
 |                                                                         
 |                    SAS SETUP FILE FOR ICPSR 30822
 |        SURVEY OF MIDLIFE DEVELOPMENT IN JAPAN (MIDJA), APRIL -
 |                             SEPTEMBER 2008
 |                            (DATASET 0001: )
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
 | "c:\temp\30822-0001-data.txt").
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
  VALUE j1sa1fff  0='WORST' 1='1' 2='2' 3='3' 4='4' 5='5' 6='6' 7='7' 8='8'
                  9='9' 10='BEST' 98='MISSING' 99='INAPP' ;
  VALUE j1sa2fff  0='WORST' 1='1' 2='2' 3='3' 4='4' 5='5' 6='6' 7='7' 8='8'
                  9='9' 10='BEST' 98='MISSING' 99='INAPP' ;
  VALUE j1sa3fff  0='WORST' 1='1' 2='2' 3='3' 4='4' 5='5' 6='6' 7='7' 8='8'
                  9='9' 10='BEST' 98='MISSING' 99='INAPP' ;
  VALUE j1sa4fff  0='NOT AT ALL' 1='1' 2='2' 3='3' 4='4' 5='5' 6='6' 7='7'
                  8='8' 9='9' 10='VERY MUCH' 98='MISSING' 99='INAPP' ;
  VALUE j1sa5fff  0='NOT AT ALL' 1='1' 2='2' 3='3' 4='4' 5='5' 6='6' 7='7'
                  8='8' 9='9' 10='VERY MUCH' 98='MISSING' 99='INAPP' ;
  VALUE j1ssatis  98='NOT CALCULATED - Due to missing data' ;
  VALUE j1ssatif  98='NOT CALCULATED - Due to missing data' ;
  VALUE j1sa6a    1='NOT AT ALL TRUE' 2='A LITTLE TRUE' 3='MODERATELY TRUE'
                  4='EXTREMELY TRUE' 8='MISSING' 9='INAPP' ;
  VALUE j1sa6b    1='NOT AT ALL TRUE' 2='A LITTLE TRUE' 3='MODERATELY TRUE'
                  4='EXTREMELY TRUE' 8='MISSING' 9='INAPP' ;
  VALUE j1sa6c    1='NOT AT ALL TRUE' 2='A LITTLE TRUE' 3='MODERATELY TRUE'
                  4='EXTREMELY TRUE' 8='MISSING' 9='INAPP' ;
  VALUE j1sa6d    1='NOT AT ALL TRUE' 2='A LITTLE TRUE' 3='MODERATELY TRUE'
                  4='EXTREMELY TRUE' 8='MISSING' 9='INAPP' ;
  VALUE j1sa6e    1='NOT AT ALL TRUE' 2='A LITTLE TRUE' 3='MODERATELY TRUE'
                  4='EXTREMELY TRUE' 8='MISSING' 9='INAPP' ;
  VALUE j1sampli  8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1sa7a    1='NOT AT ALL' 2='ONCE A MONTH' 3='2-3 TIMES A MONTH'
                  4='ONCE A WEEK' 5='2-3 TIMES A WEEK' 6='ALMOST EVERYDAY'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sa7b    1='NOT AT ALL' 2='ONCE A MONTH' 3='2-3 TIMES A MONTH'
                  4='ONCE A WEEK' 5='2-3 TIMES A WEEK' 6='ALMOST EVERYDAY'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sa7c    1='NOT AT ALL' 2='ONCE A MONTH' 3='2-3 TIMES A MONTH'
                  4='ONCE A WEEK' 5='2-3 TIMES A WEEK' 6='ALMOST EVERYDAY'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sa7d    1='NOT AT ALL' 2='ONCE A MONTH' 3='2-3 TIMES A MONTH'
                  4='ONCE A WEEK' 5='2-3 TIMES A WEEK' 6='ALMOST EVERYDAY'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sa7e    1='NOT AT ALL' 2='ONCE A MONTH' 3='2-3 TIMES A MONTH'
                  4='ONCE A WEEK' 5='2-3 TIMES A WEEK' 6='ALMOST EVERYDAY'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sa7f    1='NOT AT ALL' 2='ONCE A MONTH' 3='2-3 TIMES A MONTH'
                  4='ONCE A WEEK' 5='2-3 TIMES A WEEK' 6='ALMOST EVERYDAY'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sa7g    1='NOT AT ALL' 2='ONCE A MONTH' 3='2-3 TIMES A MONTH'
                  4='ONCE A WEEK' 5='2-3 TIMES A WEEK' 6='ALMOST EVERYDAY'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sa7h    1='NOT AT ALL' 2='ONCE A MONTH' 3='2-3 TIMES A MONTH'
                  4='ONCE A WEEK' 5='2-3 TIMES A WEEK' 6='ALMOST EVERYDAY'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sa7i    1='NOT AT ALL' 2='ONCE A MONTH' 3='2-3 TIMES A MONTH'
                  4='ONCE A WEEK' 5='2-3 TIMES A WEEK' 6='ALMOST EVERYDAY'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sa8a    1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa8b    1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa8c    1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa8d    1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa8e    1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa8f    1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa8g    1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa8h    1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa8i    1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa8j    1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa8k    1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa8l    1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa8m    1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa8n    1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa8o    1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa8p    1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa8q    1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa8r    1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa8s    1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa8t    1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa8u    1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa8v    1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa8w    1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa8x    1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa8y    1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa8z    1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa8aa   1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa8bb   1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa8cc   1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa8dd   1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa8ee   1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1schron  98='NOT CALCULATED (Due to missing data)' ;
  VALUE j1schrox  1='YES' 2='NO' 8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1sa9a    1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa9ay   1='ONCE A MONTH' 2='2-3 TIMES A MONTH' 3='ONCE A WEEK'
                  4='2-3 TIMES A WEEK' 5='DAILY' 8='MISSING' 9='INAPP' ;
  VALUE j1sa9b    1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa9by   1='ONCE A MONTH' 2='2-3 TIMES A MONTH' 3='ONCE A WEEK'
                  4='2-3 TIMES A WEEK' 5='DAILY' 8='MISSING' 9='INAPP' ;
  VALUE j1sa9c    1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa9cy   1='ONCE A MONTH' 2='2-3 TIMES A MONTH' 3='ONCE A WEEK'
                  4='2-3 TIMES A WEEK' 5='DAILY' 8='MISSING' 9='INAPP' ;
  VALUE j1sa9d    1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa9dy   1='ONCE A MONTH' 2='2-3 TIMES A MONTH' 3='ONCE A WEEK'
                  4='2-3 TIMES A WEEK' 5='DAILY' 8='MISSING' 9='INAPP' ;
  VALUE j1sa9e    1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa9ey   1='ONCE A MONTH' 2='2-3 TIMES A MONTH' 3='ONCE A WEEK'
                  4='2-3 TIMES A WEEK' 5='DAILY' 8='MISSING' 9='INAPP' ;
  VALUE j1sa9f    1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa9fy   1='ONCE A MONTH' 2='2-3 TIMES A MONTH' 3='ONCE A WEEK'
                  4='2-3 TIMES A WEEK' 5='DAILY' 8='MISSING' 9='INAPP' ;
  VALUE j1sa9g    1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa9gy   1='ONCE A MONTH' 2='2-3 TIMES A MONTH' 3='ONCE A WEEK'
                  4='2-3 TIMES A WEEK' 5='DAILY' 8='MISSING' 9='INAPP' ;
  VALUE j1sa9h    1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa9hy   1='ONCE A MONTH' 2='2-3 TIMES A MONTH' 3='ONCE A WEEK'
                  4='2-3 TIMES A WEEK' 5='DAILY' 8='MISSING' 9='INAPP' ;
  VALUE j1sa9i    1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa9iy   1='ONCE A MONTH' 2='2-3 TIMES A MONTH' 3='ONCE A WEEK'
                  4='2-3 TIMES A WEEK' 5='DAILY' 8='MISSING' 9='INAPP' ;
  VALUE j1sa9j    1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa9jy   1='ONCE A MONTH' 2='2-3 TIMES A MONTH' 3='ONCE A WEEK'
                  4='2-3 TIMES A WEEK' 5='DAILY' 8='MISSING' 9='INAPP' ;
  VALUE j1sa9k    1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa9ky   1='ONCE A MONTH' 2='2-3 TIMES A MONTH' 3='ONCE A WEEK'
                  4='2-3 TIMES A WEEK' 5='DAILY' 8='MISSING' 9='INAPP' ;
  VALUE j1sa9l    1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa9ly   1='ONCE A MONTH' 2='2-3 TIMES A MONTH' 3='ONCE A WEEK'
                  4='2-3 TIMES A WEEK' 5='DAILY' 8='MISSING' 9='INAPP' ;
  VALUE j1srxmed  98='NOT CALCULATED (Due to missing data)' ;
  VALUE j1srxmex  1='YES' 2='NO' 8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1sa10a   1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sa10b   1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sa10c   1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sa10d   1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sa10e   1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sa10f   1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sa10g   1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sa10h   1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sa10i   1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sa10j   1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sbadlf  8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1sbad0f  8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1siadl   8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1sa11a   1='NO' 2='YES' 8='MISSING' 9='INAPP' ;
  VALUE j1sa11b   1='NO' 2='YES' 8='MISSING' 9='INAPP' ;
  VALUE j1sa11c   1='NO' 2='YES' 8='MISSING' 9='INAPP' ;
  VALUE j1sa11d   1='NO' 2='YES' 8='MISSING' 9='INAPP' ;
  VALUE j1sdyspn  8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1sa12ff  1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa13cy  9998='MISSING' 9999='INAPP' ;
  VALUE j1sa13cm  1='JANUARY' 2='FEBRUARY' 3='MARCH' 4='APRIL' 5='MAY'
                  6='JUNE' 7='JULY' 8='AUGUST' 9='SEPTEMBER' 10='OCTOBER'
                  11='NOVEMBER' 12='DECEMBER' 98='MISSING' 99='INAPP' ;
  VALUE j1sa14ff  1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa15ff  998='MISSING' 999='INAPP' ;
  VALUE j1sa16ff  998='MISSING' 999='INAPP' ;
  VALUE j1sa17a   1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa17an  98='MISSING' 99='INAPP' ;
  VALUE j1sa17b   1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa17bn  98='MISSING' 99='INAPP' ;
  VALUE j1sa17c   1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa17cn  98='MISSING' 99='INAPP' ;
  VALUE j1sa17d   1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa17dn  98='MISSING' 99='INAPP' ;
  VALUE j1sa17e   1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa17en  98='MISSING' 99='INAPP' ;
  VALUE j1susemd  98='NOT CALCULATED (Due to missing data)' ;
  VALUE j1sa18a   1='NEVER' 2='A LITTLE' 3='SOME' 4='OFTEN' 5='A LOT'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sa18b   1='NEVER' 2='A LITTLE' 3='SOME' 4='OFTEN' 5='A LOT'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sa18c   1='NEVER' 2='A LITTLE' 3='SOME' 4='OFTEN' 5='A LOT'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sa18d   1='NEVER' 2='A LITTLE' 3='SOME' 4='OFTEN' 5='A LOT'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sa18e   1='NEVER' 2='A LITTLE' 3='SOME' 4='OFTEN' 5='A LOT'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sa18f   1='NEVER' 2='A LITTLE' 3='SOME' 4='OFTEN' 5='A LOT'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sa19ff  1='MY EMPLOYERS INSURANCE' 2='SP EMPLOYERS INSURANCE'
                  3='NATINAL HLTH INSURANCE' 4='NONE OF THE ABOVE'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sa20a   1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa20b   1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa20c   1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa20d   1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa20e   1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa20f   1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sa20g   1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sb1a    1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sb1fff  98='MISSING' 99='INAPP' ;
  VALUE j1sb2fff  1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sb3fff  98='MISSING' 99='INAPP' ;
  VALUE j1sb4fff  1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sb5fff  998='MISSING' 999='INAPP' ;
  VALUE j1sc1fff  1='EVERY DAY' 2='5-6 DAYS A WEEK' 3='3-4 DAYS A WEEK'
                  4='1-2 DAYS A WEEK' 5='LESS THAN 1 DAY A WEEK' 6='NONE'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sc2fff  98='MISSING' 99='INAPP' ;
  VALUE j1sc3fff  98='MISSING' 99='INAPP' ;
  VALUE j1sc4fff  1='NEVER' 2='1-2 TIMES' 3='3-5 TIMES' 4='6-10 TIMES'
                  5='11-20 TIMES' 6='21 OR MORE' 8='MISSING' 9='INAPP' ;
  VALUE j1sc5fff  1='NEVER' 2='1-2 TIMES' 3='3-5 TIMES' 4='6-10 TIMES'
                  5='11-20 TIMES' 6='21 OR MORE' 8='MISSING' 9='INAPP' ;
  VALUE j1sc6fff  1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sc7fff  1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sd1a    1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sd1b    1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sd1c    1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sd1d    1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sd1e    1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sd1f    1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sd1g    1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sd1h    1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sd1i    1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sd1j    1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sd1k    1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sd1l    1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sd1m    1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sd1n    1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1snegaf  8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1snegpa  8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1sd2a    1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sd2b    1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sd2c    1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sd2d    1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sd2e    1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sd2f    1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sd2g    1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sd2h    1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sd2i    1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sd2j    1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sd2k    1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sd2l    1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sd2m    1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sposaf  8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1spospa  8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1sd3a    1='NEVER' 2='ALMOST NEVER' 3='SOMETIMES' 4='FAIRLY OFTEN'
                  5='VERY OFTEN' 8='MISSING' 9='INAPP' ;
  VALUE j1sd3b    1='NEVER' 2='ALMOST NEVER' 3='SOMETIMES' 4='FAIRLY OFTEN'
                  5='VERY OFTEN' 8='MISSING' 9='INAPP' ;
  VALUE j1sd3c    1='NEVER' 2='ALMOST NEVER' 3='SOMETIMES' 4='FAIRLY OFTEN'
                  5='VERY OFTEN' 8='MISSING' 9='INAPP' ;
  VALUE j1sd3d    1='NEVER' 2='ALMOST NEVER' 3='SOMETIMES' 4='FAIRLY OFTEN'
                  5='VERY OFTEN' 8='MISSING' 9='INAPP' ;
  VALUE j1sd3e    1='NEVER' 2='ALMOST NEVER' 3='SOMETIMES' 4='FAIRLY OFTEN'
                  5='VERY OFTEN' 8='MISSING' 9='INAPP' ;
  VALUE j1sd3f    1='NEVER' 2='ALMOST NEVER' 3='SOMETIMES' 4='FAIRLY OFTEN'
                  5='VERY OFTEN' 8='MISSING' 9='INAPP' ;
  VALUE j1sd3g    1='NEVER' 2='ALMOST NEVER' 3='SOMETIMES' 4='FAIRLY OFTEN'
                  5='VERY OFTEN' 8='MISSING' 9='INAPP' ;
  VALUE j1sd3h    1='NEVER' 2='ALMOST NEVER' 3='SOMETIMES' 4='FAIRLY OFTEN'
                  5='VERY OFTEN' 8='MISSING' 9='INAPP' ;
  VALUE j1sd3i    1='NEVER' 2='ALMOST NEVER' 3='SOMETIMES' 4='FAIRLY OFTEN'
                  5='VERY OFTEN' 8='MISSING' 9='INAPP' ;
  VALUE j1sd3j    1='NEVER' 2='ALMOST NEVER' 3='SOMETIMES' 4='FAIRLY OFTEN'
                  5='VERY OFTEN' 8='MISSING' 9='INAPP' ;
  VALUE j1sps_ps  98='NOT CALCULATED (Due to missing data)' ;
  VALUE j1sd4a    1='NONE' 2='MILD' 3='MODERATE' 4='SEVERE' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sd4b    1='NONE' 2='MILD' 3='MODERATE' 4='SEVERE' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sd4c    1='NONE' 2='MILD' 3='MODERATE' 4='SEVERE' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sd4d    1='NONE' 2='MILD' 3='MODERATE' 4='SEVERE' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sd4e    1='NONE' 2='MILD' 3='MODERATE' 4='SEVERE' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sd4f    1='NONE' 2='MILD' 3='MODERATE' 4='SEVERE' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sd4g    1='NONE' 2='MILD' 3='MODERATE' 4='SEVERE' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sd4h    1='NONE' 2='MILD' 3='MODERATE' 4='SEVERE' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sd4i    1='NONE' 2='MILD' 3='MODERATE' 4='SEVERE' 8='MISSING'
                  9='INAPP' ;
  VALUE j1ssa_sa  8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1sd5a    1='ALMOST NEVER' 2='SOMETIMES' 3='OFTEN' 4='ALMOST ALWAYS'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sd5b    1='ALMOST NEVER' 2='SOMETIMES' 3='OFTEN' 4='ALMOST ALWAYS'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sd5c    1='ALMOST NEVER' 2='SOMETIMES' 3='OFTEN' 4='ALMOST ALWAYS'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sd5d    1='ALMOST NEVER' 2='SOMETIMES' 3='OFTEN' 4='ALMOST ALWAYS'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sd5e    1='ALMOST NEVER' 2='SOMETIMES' 3='OFTEN' 4='ALMOST ALWAYS'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sd5f    1='ALMOST NEVER' 2='SOMETIMES' 3='OFTEN' 4='ALMOST ALWAYS'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sd5g    1='ALMOST NEVER' 2='SOMETIMES' 3='OFTEN' 4='ALMOST ALWAYS'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sd5h    1='ALMOST NEVER' 2='SOMETIMES' 3='OFTEN' 4='ALMOST ALWAYS'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sd5i    1='ALMOST NEVER' 2='SOMETIMES' 3='OFTEN' 4='ALMOST ALWAYS'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sd5j    1='ALMOST NEVER' 2='SOMETIMES' 3='OFTEN' 4='ALMOST ALWAYS'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sd5k    1='ALMOST NEVER' 2='SOMETIMES' 3='OFTEN' 4='ALMOST ALWAYS'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sd5l    1='ALMOST NEVER' 2='SOMETIMES' 3='OFTEN' 4='ALMOST ALWAYS'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sd5m    1='ALMOST NEVER' 2='SOMETIMES' 3='OFTEN' 4='ALMOST ALWAYS'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sd5n    1='ALMOST NEVER' 2='SOMETIMES' 3='OFTEN' 4='ALMOST ALWAYS'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sd5o    1='ALMOST NEVER' 2='SOMETIMES' 3='OFTEN' 4='ALMOST ALWAYS'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sd5p    1='ALMOST NEVER' 2='SOMETIMES' 3='OFTEN' 4='ALMOST ALWAYS'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sd5q    1='ALMOST NEVER' 2='SOMETIMES' 3='OFTEN' 4='ALMOST ALWAYS'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sd5r    1='ALMOST NEVER' 2='SOMETIMES' 3='OFTEN' 4='ALMOST ALWAYS'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sd5s    1='ALMOST NEVER' 2='SOMETIMES' 3='OFTEN' 4='ALMOST ALWAYS'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sd5t    1='ALMOST NEVER' 2='SOMETIMES' 3='OFTEN' 4='ALMOST ALWAYS'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sd5u    1='ALMOST NEVER' 2='SOMETIMES' 3='OFTEN' 4='ALMOST ALWAYS'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sd5v    1='ALMOST NEVER' 2='SOMETIMES' 3='OFTEN' 4='ALMOST ALWAYS'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sae_ai  98='NOT CALCULATED (Due to missing data)' ;
  VALUE j1sae_ao  98='NOT CALCULATED (Due to missing data)' ;
  VALUE j1sae_ac  98='NOT CALCULATED (Due to missing data)' ;
  VALUE j1sae_aa  8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1se1fff  1='HAVE A PAID JOB' 2='NO PAID JOB' 8='MISSING' 9='INAPP' ;
  VALUE j1se2fff  1='BLUE-COLLAR JOB' 2='SERVICE BUSINESSES'
                  3='WHITE-COLLAR JOB' 4='SPECIALIST PERSONNEL'
                  5='MAGAGEMENT POSITION' 6='CORPORATE MANAGER'
                  7='FAMILY-OPERATED BUSINESS' 8='LIBERAL PROFESSION'
                  9='ARGICULTURE & FISHING' 10='OTHER' 98='MISSING'
                  99='INAPP' ;
  VALUE j1se3fff  1='FULL-TIME' 2='PART-TIME' 3='OTHER' 8='MISSING' 9='INAPP' ;
  VALUE j1se4fff  1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1se5fff  1='1' 2='2-4' 3='5-9' 4='10-29' 5='30-99' 6='100-299'
                  7='300-499' 8='500-999' 9='1000+' 10='GOVERNMENT AGENCIES'
                  11='DO NOT KNOW' 98='MISSING' 99='INAPP' ;
  VALUE j1se6fff  1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1se7fff  1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1se8fff  1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1se9fff  1='EXCELLENT' 2='VERY GOOD' 3='GOOD' 4='FAIR' 5='POOR'
                  8='MISSING' 9='INAPP' ;
  VALUE j1se10ff  1='VERY POSITIVE' 2='SOMEWHAT POSITIVE' 3='NEUTRAL'
                  4='SOMEWHAT NEGATIVE' 5='VERY NEGATIVE' 8='MISSING'
                  9='INAPP' ;
  VALUE j1se11ff  1='VERY POSITIVE' 2='SOMEWHAT POSITIVE' 3='NEUTRAL'
                  4='SOMEWHAT NEGATIVE' 5='VERY NEGATIVE' 8='MISSING'
                  9='INAPP' ;
  VALUE j1se12ff  0='NOT AT ALL' 1='1' 2='2' 3='3' 4='4' 5='5' 6='6' 7='7'
                  8='8' 9='9' 10='VERY MUCH' 98='MISSING' 99='INAPP' ;
  VALUE j1se13ff  0='NOT AT ALL' 1='1' 2='2' 3='3' 4='4' 5='5' 6='6' 7='7'
                  8='8' 9='9' 10='VERY MUCH' 98='MISSING' 99='INAPP' ;
  VALUE j1se14a   1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1se14b   1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1se14c   1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1se14d   1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1se14e   1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1se14f   1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1se14g   1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1se14h   1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1se14i   1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1se14j   1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1se14k   1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1se14l   1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1se14m   1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1se14n   1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1se14o   1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1se14p   1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sposwf  98='NOT CALCULATED (Due to missing data)' ;
  VALUE j1snegwf  98='NOT CALCULATED (Due to missing data)' ;
  VALUE j1sposfw  98='NOT CALCULATED (Due to missing data)' ;
  VALUE j1snegfw  98='NOT CALCULATED (Due to missing data)' ;
  VALUE j1se15a   1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1se15b   1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1se15c   1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1se15d   1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1se15e   1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1se15f   1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1se15g   1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1se15h   1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1se15i   1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1se15j   1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1se15k   1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1se16a   1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1se16b   1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1se16c   1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1se16d   1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sjcsd   98='NOT CALCULATED (Due to missing data)'
                  99='NOT CALCULATED (Due to INAPP data)' ;
  VALUE j1sjcda   98='NOT CALCULATED (Due to missing data)'
                  99='NOT CALCULATED (Due to INAPP data)' ;
  VALUE j1sjcds   98='NOT CALCULATED (Due to missing data)'
                  99='NOT CALCULATED (Due to INAPP data)' ;
  VALUE j1se17a   1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  6='DOES NOT APPLY' 8='MISSING' 9='INAPP' ;
  VALUE j1se17b   1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  6='DOES NOT APPLY' 8='MISSING' 9='INAPP' ;
  VALUE j1se17c   1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  6='DOES NOT APPLY' 8='MISSING' 9='INAPP' ;
  VALUE j1se17d   1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  6='DOES NOT APPLY' 8='MISSING' 9='INAPP' ;
  VALUE j1se17e   1='NONE OF THE TIME' 2='A LITTLE OF THE TIME'
                  3='SOME OF THE TIME' 4='MOST OF THE TIME' 5='ALL THE TIME'
                  6='DOES NOT APPLY' 8='MISSING' 9='INAPP' ;
  VALUE j1sjccs   98='NOT CALCULATED (Due to missing data)'
                  99='NOT CALCULATED (Due to Does not apply)' ;
  VALUE j1sjcss   98='NOT CALCULATED (Due to missing data)'
                  99='NOT CALCULATED (Due to Does not apply)' ;
  VALUE j1se18a   1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1se18b   1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1se18c   1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1se18d   1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1se18e   1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1se18f   1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1spiwor  8='NOT CALCULATED (Due to missing data)'
                  9='NOT CALCULATED (Due to INAPP data)' ;
  VALUE j1se19ff  0='WORST' 1='1' 2='2' 3='3' 4='4' 5='5' 6='6' 7='7' 8='8'
                  9='9' 10='BEST' 98='MISSING' 99='INAPP' ;
  VALUE j1se20ff  0='WORST' 1='1' 2='2' 3='3' 4='4' 5='5' 6='6' 7='7' 8='8'
                  9='9' 10='BEST' 98='MISSING' 99='INAPP' ;
  VALUE j1se21ff  0='WORST' 1='1' 2='2' 3='3' 4='4' 5='5' 6='6' 7='7' 8='8'
                  9='9' 10='BEST' 98='MISSING' 99='INAPP' ;
  VALUE j1sf1fff  0='WORST' 1='1' 2='2' 3='3' 4='4' 5='5' 6='6' 7='7' 8='8'
                  9='9' 10='BEST' 98='MISSING' 99='INAPP' ;
  VALUE j1sf2fff  0='WORST' 1='1' 2='2' 3='3' 4='4' 5='5' 6='6' 7='7' 8='8'
                  9='9' 10='BEST' 98='MISSING' 99='INAPP' ;
  VALUE j1sf3fff  0='WORST' 1='1' 2='2' 3='3' 4='4' 5='5' 6='6' 7='7' 8='8'
                  9='9' 10='BEST' 98='MISSING' 99='INAPP' ;
  VALUE j1sf4fff  0='NOT AT ALL' 1='1' 2='2' 3='3' 4='4' 5='5' 6='6' 7='7'
                  8='8' 9='9' 10='VERY MUCH' 98='MISSING' 99='INAPP' ;
  VALUE j1sf5fff  0='NOT AT ALL' 1='1' 2='2' 3='3' 4='4' 5='5' 6='6' 7='7'
                  8='8' 9='9' 10='VERY MUCH' 98='MISSING' 99='INAPP' ;
  VALUE j1sf6fff  1='MORE THAN NEEDED' 2='JUST ENOUGH' 3='NOT ENOUGH'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sg1a    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg1b    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg1c    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg1d    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg1e    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg1f    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg1g    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg1h    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg1i    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg1j    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg1k    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg1l    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg1m    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg1n    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg1o    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg1p    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg1q    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg1r    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg1s    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1smaste  8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1sconst  8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1sctrl   8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1sestee  98='NOT CALCULATED (Due to missing data)' ;
  VALUE j1sg2a    1='A LOT DISAGREE' 2='A LITTLE DISAGREE' 3='NEUTRAL'
                  4='A LITTLE AGREE' 5='A LOT AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg2b    1='A LOT DISAGREE' 2='A LITTLE DISAGREE' 3='NEUTRAL'
                  4='A LITTLE AGREE' 5='A LOT AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg2c    1='A LOT DISAGREE' 2='A LITTLE DISAGREE' 3='NEUTRAL'
                  4='A LITTLE AGREE' 5='A LOT AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg2d    1='A LOT DISAGREE' 2='A LITTLE DISAGREE' 3='NEUTRAL'
                  4='A LITTLE AGREE' 5='A LOT AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg2e    1='A LOT DISAGREE' 2='A LITTLE DISAGREE' 3='NEUTRAL'
                  4='A LITTLE AGREE' 5='A LOT AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg2f    1='A LOT DISAGREE' 2='A LITTLE DISAGREE' 3='NEUTRAL'
                  4='A LITTLE AGREE' 5='A LOT AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1soptim  98='NOT CALCULATED (Due to missing data)' ;
  VALUE j1spessi  98='NOT CALCULATED (Due to missing data)' ;
  VALUE j1sorien  98='NOT CALCULATED (Due to missing data)' ;
  VALUE j1sg3a    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sg3b    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sg3c    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sg3d    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sg3e    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sg3f    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sg3g    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sg3h    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sg3i    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sg3j    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sg3k    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sg3l    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sg3m    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sg3n    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sg3o    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sg3p    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sg3q    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sg3r    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sg3s    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sg3t    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1spersi  8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1sreapp  8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1schang  8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1sspctr  8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1scpctr  8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1scscag  8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1ssuffi  8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1sg4a    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg4b    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg4c    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg4d    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg4e    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg4f    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg4g    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg4h    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg4i    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg4j    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg4k    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg4l    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg4m    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg4n    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg4o    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg4p    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg4q    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg4r    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg4s    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg4t    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg4u    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg4v    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sinter  8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1sindep  8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1ssc_it  8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1ssc_id  8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1sjintr  8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1sjindp  8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1sg5a    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg5b    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg5c    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg5d    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg5e    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg5f    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg5g    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg5h    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg5i    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg5j    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1ssymp   8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1sadj    8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1sg6a    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sg6b    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sg6c    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sg6d    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sg6e    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sg6f    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sg6g    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sg6h    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sg6i    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sg6j    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sg6k    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sg6l    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sg6m    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sg6n    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sg6o    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sg6p    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sg6q    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sg6r    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sg6s    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sg6t    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sg6u    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sg6v    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sg6w    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sg6x    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sg6y    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sg6z    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sg6aa   1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sg6bb   1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sg6cc   1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sg6dd   1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sg6ee   1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sneuro  8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1sextra  8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1sopen   8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1sconsf  8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1scon0f  8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1sagree  8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1sagenc  8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1sg7a    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg7b    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg7c    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg7d    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg7e    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg7f    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg7g    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg7h    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg7i    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg7j    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg7k    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg7l    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg7m    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg7n    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg7o    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg7p    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg7q    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg7r    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sg7s    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1ssc_sc  8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1ssc_cc  8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1ssc_ec  8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1ssc_bc  8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1sh1a    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sh1b    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sh1c    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sh1d    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sh1e    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sh1f    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sgener  98='NOT CALCULATED (Due to missing data)' ;
  VALUE j1sh2fff  1='HIGHEST' 2='2' 3='3' 4='4' 5='5' 6='6' 7='7' 8='8' 9='9'
                  10='LOWEST' 98='MISSING' 99='INAPP' ;
  VALUE j1si1fff  1='ALMOST EVERYDAY' 2='SEVERAL TIMES A WEEK'
                  3='ONCE A WEEK' 4='1-3 TIMES A MONTH'
                  5='LESS THAN ONCE A MONTH' 6='NEVER OR HARDLY EVER'
                  8='MISSING' 9='INAPP' ;
  VALUE j1si2fff  1='ALMOST EVERYDAY' 2='SEVERAL TIMES A WEEK'
                  3='ONCE A WEEK' 4='1-3 TIMES A MONTH'
                  5='LESS THAN ONCE A MONTH' 6='NEVER OR HARDLY EVER'
                  8='MISSING' 9='INAPP' ;
  VALUE j1si3fff  98='MISSING' 99='INAPP' ;
  VALUE j1sj1fff  0='WORST' 1='1' 2='2' 3='3' 4='4' 5='5' 6='6' 7='7' 8='8'
                  9='9' 10='BEST' 98='MISSING' 99='INAPP' ;
  VALUE j1sj2fff  0='WORST' 1='1' 2='2' 3='3' 4='4' 5='5' 6='6' 7='7' 8='8'
                  9='9' 10='BEST' 98='MISSING' 99='INAPP' ;
  VALUE j1sj3fff  0='WORST' 1='1' 2='2' 3='3' 4='4' 5='5' 6='6' 7='7' 8='8'
                  9='9' 10='BEST' 98='MISSING' 99='INAPP' ;
  VALUE j1sj4fff  0='NOT AT ALL' 1='1' 2='2' 3='3' 4='4' 5='5' 6='6' 7='7'
                  8='8' 9='9' 10='VERY MUCH' 98='MISSING' 99='INAPP' ;
  VALUE j1sj5fff  0='NOT AT ALL' 1='1' 2='2' 3='3' 4='4' 5='5' 6='6' 7='7'
                  8='8' 9='9' 10='VERY MUCH' 98='MISSING' 99='INAPP' ;
  VALUE j1sj6fff  0='WORST' 1='1' 2='2' 3='3' 4='4' 5='5' 6='6' 7='7' 8='8'
                  9='9' 10='BEST' 98='MISSING' 99='INAPP' ;
  VALUE j1sj7a    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj7b    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj7c    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj7d    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj7e    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj7f    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj7g    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj7h    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1ssw_sl  8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1ssw_gr  8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1sj8a    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj8b    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj8c    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj8d    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj8e    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj8f    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj8g    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj8h    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj8i    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj8j    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj8k    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj8l    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj8m    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj8n    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj8o    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj8p    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj8q    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj8r    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj8s    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj8t    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj8u    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj8v    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj8w    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj8x    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj8y    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj8z    1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj8aa   1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj8bb   1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj8cc   1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj8dd   1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj8ee   1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj8ff   1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj8gg   1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj8hh   1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj8ii   1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj8jj   1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj8kk   1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj8ll   1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj8mm   1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj8nn   1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj8oo   1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj8pp   1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1spwbaf  98='NOT CALCULATED (Due to missing data)' ;
  VALUE j1spwbef  98='NOT CALCULATED (Due to missing data)' ;
  VALUE j1spwbgf  98='NOT CALCULATED (Due to missing data)' ;
  VALUE j1spwbrf  98='NOT CALCULATED (Due to missing data)' ;
  VALUE j1spwbuf  98='NOT CALCULATED (Due to missing data)' ;
  VALUE j1spwbsf  98='NOT CALCULATED (Due to missing data)' ;
  VALUE j1spwb0f  98='NOT CALCULATED (Due to missing data)' ;
  VALUE j1spwb1f  98='NOT CALCULATED (Due to missing data)' ;
  VALUE j1spwb2f  98='NOT CALCULATED (Due to missing data)' ;
  VALUE j1spwb3f  98='NOT CALCULATED (Due to missing data)' ;
  VALUE j1spwb4f  98='NOT CALCULATED (Due to missing data)' ;
  VALUE j1spwb5f  98='NOT CALCULATED (Due to missing data)' ;
  VALUE j1sj8qq   1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj8rr   1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj8ss   1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj8tt   1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj8uu   1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj8vv   1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj8ww   1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj8xx   1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj8yy   1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sj8zz   1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1smwbgr  98='NOT CALCULATED (Due to missing data)' ;
  VALUE j1smwbpd  98='NOT CALCULATED (Due to missing data)' ;
  VALUE j1sk1fff  1='0-5' 2='6-10' 3='11-20' 4='21-50' 5='51+' 8='MISSING'
                  9='INAPP' ;
  VALUE j1ssgfa   8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1sk2fff  1='SEVERAL TIME A DAY' 2='ABOUT ONCE A DAY'
                  3='SEVERAL TIME A WEEK' 4='ABOUT ONCE A WEEK'
                  5='2-3 TIMES A MONTH' 6='ABOUT ONCE A MONTH'
                  7='LESS THAN ONCE A MONTH' 8='NEVER OR HARDLY EVER'
                  98='MISSING' 99='INAPP' ;
  VALUE j1sk3a    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sk3b    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sk3c    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sk3d    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sk3e    1='NEVER' 2='RARELY' 3='SOMETIMES' 4='OFTEN' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sk3f    1='NEVER' 2='RARELY' 3='SOMETIMES' 4='OFTEN' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sk3g    1='NEVER' 2='RARELY' 3='SOMETIMES' 4='OFTEN' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sk3h    1='NEVER' 2='RARELY' 3='SOMETIMES' 4='OFTEN' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sfdspo  8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1sfdsne  8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1sfdsol  8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1sk4a    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sk4b    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sk4c    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sk4d    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sk4e    1='NEVER' 2='RARELY' 3='SOMETIMES' 4='OFTEN' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sk4f    1='NEVER' 2='RARELY' 3='SOMETIMES' 4='OFTEN' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sk4g    1='NEVER' 2='RARELY' 3='SOMETIMES' 4='OFTEN' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sk4h    1='NEVER' 2='RARELY' 3='SOMETIMES' 4='OFTEN' 8='MISSING'
                  9='INAPP' ;
  VALUE j1ssugf   8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1sstgf   8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1ssogfd  8='NOT CALCULATED (Due to missing data)' ;
  VALUE j1sl1fff  1='MARRIED' 2='SEPARATED' 3='DIVORCED' 4='WIDOWED'
                  5='NEVER MARRIED' 8='MISSING' 9='INAPP' ;
  VALUE j1sl2fff  98='MISSING' 99='INAPP' ;
  VALUE j1sl3cy   9998='MISSING' 9999='INAPP' ;
  VALUE j1sl3mo   1='JANUARY' 2='FEBRUARY' 3='MARCH' 4='APRIL' 5='MAY'
                  6='JUNE' 7='JULY' 8='AUGUST' 9='SEPTEMBER' 10='OCTOBER'
                  11='NOVEMBER' 12='DECEMBER' 98='MISSING' 99='INAPP' ;
  VALUE j1sl4fff  0='WORST' 1='1' 2='2' 3='3' 4='4' 5='5' 6='6' 7='7' 8='8'
                  9='9' 10='BEST' 98='MISSING' 99='INAPP' ;
  VALUE j1sl5fff  0='WORST' 1='1' 2='2' 3='3' 4='4' 5='5' 6='6' 7='7' 8='8'
                  9='9' 10='BEST' 98='MISSING' 99='INAPP' ;
  VALUE j1sl6fff  0='WORST' 1='1' 2='2' 3='3' 4='4' 5='5' 6='6' 7='7' 8='8'
                  9='9' 10='BEST' 98='MISSING' 99='INAPP' ;
  VALUE j1sl7fff  0='WORST' 1='1' 2='2' 3='3' 4='4' 5='5' 6='6' 7='7' 8='8'
                  9='9' 10='BEST' 98='MISSING' 99='INAPP' ;
  VALUE j1sl8fff  0='WORST' 1='1' 2='2' 3='3' 4='4' 5='5' 6='6' 7='7' 8='8'
                  9='9' 10='BEST' 98='MISSING' 99='INAPP' ;
  VALUE j1sl9fff  1='NEVER' 2='ONCE' 3='A FEW TIMES' 4='MOST OF THE TIME'
                  5='ALL OF THE TIME' 8='MISSING' 9='INAPP' ;
  VALUE j1sl10ff  1='NOT LIKELY AT ALL' 2='NOT VERY LIKELY'
                  3='SOMEWHAT LIKELY' 4='VERY LIKELY' 8='MISSING' 9='INAPP' ;
  VALUE j1smarrs  98='NOT CALCULATED (Due to missing data)'
                  99='NOT CALCULATED (Due to INAPP data)' ;
  VALUE j1sl11a   1='A LOT' 2='SOME' 3='A LITTLE' 4='NOT AT ALL' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sl11b   1='A LOT' 2='SOME' 3='A LITTLE' 4='NOT AT ALL' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sl11c   1='A LOT' 2='SOME' 3='A LITTLE' 4='NOT AT ALL' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sspdis  98='NOT CALCULATED (Due to missing data)'
                  99='NOT CALCULATED (Due to INAPP data)' ;
  VALUE j1sl12ff  1='AT LEAST ONCE A DAY' 2='A FEW TIMES A WEEK'
                  3='ONCE A WEEK' 4='A FEW TIMES A MONTH'
                  5='LESS THAN FEW TIME A MONTH' 8='MISSING' 9='INAPP' ;
  VALUE j1sl13a   1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sl13b   1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sl13c   1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sl13d   1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sl13e   1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sl13f   1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sl14a   1='NEVER' 2='RARELY' 3='SOMETIMES' 4='OFTEN' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sl14b   1='NEVER' 2='RARELY' 3='SOMETIMES' 4='OFTEN' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sl14c   1='NEVER' 2='RARELY' 3='SOMETIMES' 4='OFTEN' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sl14d   1='NEVER' 2='RARELY' 3='SOMETIMES' 4='OFTEN' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sl14e   1='NEVER' 2='RARELY' 3='SOMETIMES' 4='OFTEN' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sl14f   1='NEVER' 2='RARELY' 3='SOMETIMES' 4='OFTEN' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sspemp  8='NOT CALCULATED (Due to missing data)'
                  9='NOT CALCULATED (Due to INAPP data)' ;
  VALUE j1sspcri  8='NOT CALCULATED (Due to missing data)'
                  9='NOT CALCULATED (Due to INAPP data)' ;
  VALUE j1sspsol  8='NOT CALCULATED (Due to missing data)'
                  9='NOT CALCULATED (Due to INAPP data)' ;
  VALUE j1sl15a   1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sl15b   1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sl15c   1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sl15d   1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sl15e   1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sl15f   1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sl16a   1='NEVER' 2='RARELY' 3='SOMETIMES' 4='OFTEN' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sl16b   1='NEVER' 2='RARELY' 3='SOMETIMES' 4='OFTEN' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sl16c   1='NEVER' 2='RARELY' 3='SOMETIMES' 4='OFTEN' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sl16d   1='NEVER' 2='RARELY' 3='SOMETIMES' 4='OFTEN' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sl16e   1='NEVER' 2='RARELY' 3='SOMETIMES' 4='OFTEN' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sl16f   1='NEVER' 2='RARELY' 3='SOMETIMES' 4='OFTEN' 8='MISSING'
                  9='INAPP' ;
  VALUE j1ssugs   8='NOT CALCULATED (Due to missing data)'
                  9='NOT CALCULATED (Due to INAPP data)' ;
  VALUE j1sstgs   8='NOT CALCULATED (Due to missing data)'
                  9='NOT CALCULATED (Due to INAPP data)' ;
  VALUE j1ssolgs  8='NOT CALCULATED (Due to missing data)'
                  9='NOT CALCULATED (Due to INAPP data)' ;
  VALUE j1sl17ff  1='YOU DO A LOT MORE' 2='YOU DO SOMEWHAT MORE'
                  3='YOU DO A LITTLE MORE' 4='CHORES ARE SPLIT EQUALLY'
                  5='SP DOES A LITTLE MORE' 6='SP DOES SOMEWHAT MORE'
                  7='SP DOES A LOT MORE' 8='MISSING' 9='INAPP' ;
  VALUE j1sl18ff  98='MISSING' 99='INAPP' ;
  VALUE j1sl19ff  98='MISSING' 99='INAPP' ;
  VALUE j1sl20ff  1='VERY FAIR' 2='SOMEWHAT FAIR' 3='SOMEWHAT UNFAIR'
                  4='VERY UNFAIR' 8='MISSING' 9='INAPP' ;
  VALUE j1sl21ff  1='VERY FAIR' 2='SOMEWHAT FAIR' 3='SOMEWHAT UNFAIR'
                  4='VERY UNFAIR' 8='MISSING' 9='INAPP' ;
  VALUE j1sl22a   1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sl22b   1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sl22c   1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sl22d   1='STRONGLY DISAGREE' 2='SOME DISAGREE'
                  3='A LITTLE DISAGREE' 4='NEUTRAL' 5='A LITTLE AGREE'
                  6='SOME AGREE' 7='STRONGLY AGREE' 8='MISSING' 9='INAPP' ;
  VALUE j1sspdec  98='NOT CALCULATED (Due to missing data)'
                  99='NOT CALCULATED (Due to INAPP data)' ;
  VALUE j1sl23ff  1='EXCELLENT' 2='VERY GOOD' 3='GOOD' 4='FAIR' 5='POOR'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sl24ff  1='EXCELLENT' 2='VERY GOOD' 3='GOOD' 4='FAIR' 5='POOR'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sl25ff  1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sm1fff  1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sm2fff  0='WORST' 1='1' 2='2' 3='3' 4='4' 5='5' 6='6' 7='7' 8='8'
                  9='9' 10='BEST' 98='MISSING' 99='INAPP' ;
  VALUE j1sm3fff  0='WORST' 1='1' 2='2' 3='3' 4='4' 5='5' 6='6' 7='7' 8='8'
                  9='9' 10='BEST' 98='MISSING' 99='INAPP' ;
  VALUE j1sm4fff  0='WORST' 1='1' 2='2' 3='3' 4='4' 5='5' 6='6' 7='7' 8='8'
                  9='9' 10='BEST' 98='MISSING' 99='INAPP' ;
  VALUE j1sm5fff  0='NOT AT ALL' 1='1' 2='2' 3='3' 4='4' 5='5' 6='6' 7='7'
                  8='8' 9='9' 10='VERY MUCH' 98='MISSING' 99='INAPP' ;
  VALUE j1sm6fff  0='NOT AT ALL' 1='1' 2='2' 3='3' 4='4' 5='5' 6='6' 7='7'
                  8='8' 9='9' 10='VERY MUCH' 98='MISSING' 99='INAPP' ;
  VALUE j1sm7a    1='NOT AT ALL TRUE' 2='A LITTLE TRUE' 3='MODERATELY TRUE'
                  4='EXTREMELY TRUE' 8='MISSING' 9='INAPP' ;
  VALUE j1sm7b    1='NOT AT ALL TRUE' 2='A LITTLE TRUE' 3='MODERATELY TRUE'
                  4='EXTREMELY TRUE' 8='MISSING' 9='INAPP' ;
  VALUE j1sm7c    1='NOT AT ALL TRUE' 2='A LITTLE TRUE' 3='MODERATELY TRUE'
                  4='EXTREMELY TRUE' 8='MISSING' 9='INAPP' ;
  VALUE j1sm7d    1='NOT AT ALL TRUE' 2='A LITTLE TRUE' 3='MODERATELY TRUE'
                  4='EXTREMELY TRUE' 8='MISSING' 9='INAPP' ;
  VALUE j1sm7e    1='NOT AT ALL TRUE' 2='A LITTLE TRUE' 3='MODERATELY TRUE'
                  4='EXTREMELY TRUE' 8='MISSING' 9='INAPP' ;
  VALUE j1sm7f    1='NOT AT ALL TRUE' 2='A LITTLE TRUE' 3='MODERATELY TRUE'
                  4='EXTREMELY TRUE' 8='MISSING' 9='INAPP' ;
  VALUE j1spifam  8='NOT CALCULATED (Due to missing data)'
                  9='NOT CALCULATED (Due to INAPP data)' ;
  VALUE j1sn1fff  1='YES' 2='NO' 8='MISSING' 9='INAPP' ;
  VALUE j1sn2fff  1='SEVERAL TIME A DAY' 2='ABOUT ONCE A DAY'
                  3='SEVERAL TIME A WEEK' 4='ABOUT ONCE A WEEK'
                  5='2-3 TIMES A MONTH' 6='ABOUT ONCE A MONTH'
                  7='LESS THAN ONCE A MONTH' 8='NEVER OR HARDLY EVER'
                  98='MISSING' 99='INAPP' ;
  VALUE j1sn3a    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sn3b    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sn3c    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sn3d    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sn3e    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sn3f    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sn4a    1='NEVER' 2='RARELY' 3='SOMETIMES' 4='OFTEN' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sn4b    1='NEVER' 2='RARELY' 3='SOMETIMES' 4='OFTEN' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sn4c    1='NEVER' 2='RARELY' 3='SOMETIMES' 4='OFTEN' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sn4d    1='NEVER' 2='RARELY' 3='SOMETIMES' 4='OFTEN' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sn4e    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sn4f    1='NOT AT ALL' 2='A LITTLE' 3='SOME' 4='A LOT' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sn4g    1='NEVER' 2='RARELY' 3='SOMETIMES' 4='OFTEN' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sn4h    1='NEVER' 2='RARELY' 3='SOMETIMES' 4='OFTEN' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sn4i    1='NEVER' 2='RARELY' 3='SOMETIMES' 4='OFTEN' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sn4j    1='NEVER' 2='RARELY' 3='SOMETIMES' 4='OFTEN' 8='MISSING'
                  9='INAPP' ;
  VALUE j1skinpo  8='NOT CALCULATED (Due to missing data)'
                  9='NOT CALCULATED (Due to INAPP data)' ;
  VALUE j1skinne  8='NOT CALCULATED (Due to missing data)'
                  9='NOT CALCULATED (Due to INAPP data)' ;
  VALUE j1sfamso  8='NOT CALCULATED (Due to missing data)'
                  9='NOT CALCULATED (Due to INAPP data)' ;
  VALUE j1ssugfa  8='NOT CALCULATED (Due to missing data)'
                  9='NOT CALCULATED (Due to INAPP data)' ;
  VALUE j1sstgfa  8='NOT CALCULATED (Due to missing data)'
                  9='NOT CALCULATED (Due to INAPP data)' ;
  VALUE j1ssogfm  8='NOT CALCULATED (Due to missing data)'
                  9='NOT CALCULATED (Due to INAPP data)' ;
  VALUE j1so1fff  1='NO RELIGIOUS PREFERENCE' 2='BUDDHIST' 3='SHINTO'
                  4='CATHOLIC' 5='PROTESTANT' 6='OTHER CHRISTIAN' 7='OTHER'
                  8='MISSING' 9='INAPP' ;
  VALUE j1so2a    1='NOT AT ALL' 2='NOT VERY' 3='SOMEWHAT' 4='VERY'
                  8='MISSING' 9='INAPP' ;
  VALUE j1so2b    1='NOT AT ALL' 2='NOT VERY' 3='SOMEWHAT' 4='VERY'
                  8='MISSING' 9='INAPP' ;
  VALUE j1so2c    1='NOT AT ALL' 2='NOT VERY' 3='SOMEWHAT' 4='VERY'
                  8='MISSING' 9='INAPP' ;
  VALUE j1so3a    1='NEVER' 2='SOMETIMES' 3='USUALLY' 4='ALWAYS' 8='MISSING'
                  9='INAPP' ;
  VALUE j1so3b    1='NEVER' 2='SOMETIMES' 3='USUALLY' 4='ALWAYS' 8='MISSING'
                  9='INAPP' ;
  VALUE j1so3c    1='NEVER' 2='SOMETIMES' 3='USUALLY' 4='ALWAYS' 8='MISSING'
                  9='INAPP' ;
  VALUE j1sp1fff  1='YES' 2='NO' 3='DONT KNOW' 8='MISSING' 9='INAPP' ;
  VALUE j1sp1a    998='MISSING' 999='INAPP' ;
  VALUE j1sp1b    1='EXCELLENT' 2='VERY GOOD' 3='GOOD' 4='FAIR' 5='POOR'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sp1ccy  9998='MISSING' 9999='INAPP' ;
  VALUE j1sp1d    998='MISSING' 999='INAPP' ;
  VALUE j1sp2fff  1='YES' 2='NO' 3='DONT KNOW' 8='MISSING' 9='INAPP' ;
  VALUE j1sp2a    998='MISSING' 999='INAPP' ;
  VALUE j1sp2b    1='EXCELLENT' 2='VERY GOOD' 3='GOOD' 4='FAIR' 5='POOR'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sp2ccy  9998='MISSING' 9999='INAPP' ;
  VALUE j1sp2d    998='MISSING' 999='INAPP' ;
  VALUE j1sq1fff  1='MALE' 2='FEMALE' 8='MISSING' 9='INAPP' ;
  VALUE j1sq2age  98='MISSING' 99='INAPP' ;
  VALUE j1sq3fff  1='8TH GRADE JR HS GRADUATE' 2='SOME HIGH SCHOOL'
                  3='HIGH SCHOOL GRADUATE' 4='VOCATIONAL SCHOOL GRADUATE'
                  5='2 YEAR COLLEGE GRADUATE' 6='SOME COLLEGE'
                  7='BACHELORS DEGREE' 8='GRADUATE SCHOOL' 98='MISSING'
                  99='INAPP' ;
  VALUE j1sq4fff  1='OWN HOME OUTRIGHT' 2='PAYING ON A MORTGAGE' 3='RENT'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sq5fff  1='TWO' 2='THREE' 3='FOUR' 4='MORE THAN FIVE' 5='ONLY ONE'
                  8='MISSING' 9='INAPP' ;
  VALUE j1sq6a    1='NO' 2='YES' 8='MISSING' 9='INAPP' ;
  VALUE j1sq6b    1='NO' 2='YES' 8='MISSING' 9='INAPP' ;
  VALUE j1sq6c    1='NO' 2='YES' 8='MISSING' 9='INAPP' ;
  VALUE j1sq6d    1='NO' 2='YES' 8='MISSING' 9='INAPP' ;
  VALUE j1sq6e    1='NO' 2='YES' 8='MISSING' 9='INAPP' ;
  VALUE j1sq6f    1='NO' 2='YES' 8='MISSING' 9='INAPP' ;
  VALUE j1sq6g    1='NO' 2='YES' 8='MISSING' 9='INAPP' ;
  VALUE j1sq6h    1='NO' 2='YES' 8='MISSING' 9='INAPP' ;
  VALUE j1sq6i    1='NO' 2='YES' 8='MISSING' 9='INAPP' ;
  VALUE j1sq6j    1='NO' 2='YES' 8='MISSING' 9='INAPP' ;
*/


* SAS DATA, INFILE, INPUT STATEMENTS;

DATA;
INFILE "data-filename" LRECL=1181;
INPUT
       MIDJA_IDS 1-5           J1SA1 6-7
        J1SA2 8-9               J1SA3 10-11             J1SA4 12-13
        J1SA5 14-15             J1SSATIS 16-21 .3       J1SSATI2 22-27 .3
        J1SA6A 28               J1SA6B 29               J1SA6C 30
        J1SA6D 31               J1SA6E 32               J1SAMPLI 33-38 .3
        J1SA7A 39               J1SA7B 40               J1SA7C 41
        J1SA7D 42               J1SA7E 43               J1SA7F 44
        J1SA7G 45               J1SA7H 46               J1SA7I 47
        J1SA8A 48               J1SA8B 49               J1SA8C 50
        J1SA8D 51               J1SA8E 52               J1SA8F 53
        J1SA8G 54               J1SA8H 55               J1SA8I 56
        J1SA8J 57               J1SA8K 58               J1SA8L 59
        J1SA8M 60               J1SA8N 61               J1SA8O 62
        J1SA8P 63               J1SA8Q 64               J1SA8R 65
        J1SA8S 66               J1SA8T 67               J1SA8U 68
        J1SA8V 69               J1SA8W 70               J1SA8X 71
        J1SA8Y 72               J1SA8Z 73               J1SA8AA 74
        J1SA8BB 75              J1SA8CC 76              J1SA8DD 77
        J1SA8EE 78              J1SCHRON 79-80          J1SCHROX 81
        J1SA9A 82               J1SA9AY 83              J1SA9B 84
        J1SA9BY 85              J1SA9C 86               J1SA9CY 87
        J1SA9D 88               J1SA9DY 89              J1SA9E 90
        J1SA9EY 91              J1SA9F 92               J1SA9FY 93
        J1SA9G 94               J1SA9GY 95              J1SA9H 96
        J1SA9HY 97              J1SA9I 98               J1SA9IY 99
        J1SA9J 100              J1SA9JY 101             J1SA9K 102
        J1SA9KY 103             J1SA9L 104              J1SA9LY 105
        J1SRXMED 106-107        J1SRXMEX 108            J1SA10A 109
        J1SA10B 110             J1SA10C 111             J1SA10D 112
        J1SA10E 113             J1SA10F 114             J1SA10G 115
        J1SA10H 116             J1SA10I 117             J1SA10J 118
        J1SBADL1 119-122 .1     J1SBADL2 123-127 .3     J1SIADL 128-132 .3
        J1SA11A 133             J1SA11B 134             J1SA11C 135
        J1SA11D 136             J1SDYSPN 137            J1SA12 138
        J1SA13CY 139-142        J1SA13CM 143-144        J1SA14 145
        J1SA15 146-148          J1SA16 149-151          J1SA17A 152
        J1SA17AN 153-154        J1SA17B 155             J1SA17BN 156-157
        J1SA17C 158             J1SA17CN 159-160        J1SA17D 161
        J1SA17DN 162-163        J1SA17E 164             J1SA17EN 165-166
        J1SUSEMD 167-168        J1SA18A 169             J1SA18B 170
        J1SA18C 171             J1SA18D 172             J1SA18E 173
        J1SA18F 174             J1SA19 175              J1SA20A 176
        J1SA20B 177             J1SA20C 178             J1SA20D 179
        J1SA20E 180             J1SA20F 181             J1SA20G 182
        J1SB1A 183              J1SB1 184-185           J1SB2 186
        J1SB3 187-188           J1SB4 189               J1SB5 190-192
        J1SC1 193               J1SC2 194-195           J1SC3 196-197
        J1SC4 198               J1SC5 199               J1SC6 200
        J1SC7 201               J1SD1A 202              J1SD1B 203
        J1SD1C 204              J1SD1D 205              J1SD1E 206
        J1SD1F 207              J1SD1G 208              J1SD1H 209
        J1SD1I 210              J1SD1J 211              J1SD1K 212
        J1SD1L 213              J1SD1M 214              J1SD1N 215
        J1SNEGAF 216-220 .3     J1SNEGPA 221-225 .3     J1SD2A 226
        J1SD2B 227              J1SD2C 228              J1SD2D 229
        J1SD2E 230              J1SD2F 231              J1SD2G 232
        J1SD2H 233              J1SD2I 234              J1SD2J 235
        J1SD2K 236              J1SD2L 237              J1SD2M 238
        J1SPOSAF 239-243 .3     J1SPOSPA 244-248 .3     J1SD3A 249
        J1SD3B 250              J1SD3C 251              J1SD3D 252
        J1SD3E 253              J1SD3F 254              J1SD3G 255
        J1SD3H 256              J1SD3I 257              J1SD3J 258
        J1SPS_PS 259-264 .3     J1SD4A 265              J1SD4B 266
        J1SD4C 267              J1SD4D 268              J1SD4E 269
        J1SD4F 270              J1SD4G 271              J1SD4H 272
        J1SD4I 273              J1SSA_SA 274-278 .3     J1SD5A 279
        J1SD5B 280              J1SD5C 281              J1SD5D 282
        J1SD5E 283              J1SD5F 284              J1SD5G 285
        J1SD5H 286              J1SD5I 287              J1SD5J 288
        J1SD5K 289              J1SD5L 290              J1SD5M 291
        J1SD5N 292              J1SD5O 293              J1SD5P 294
        J1SD5Q 295              J1SD5R 296              J1SD5S 297
        J1SD5T 298              J1SD5U 299              J1SD5V 300
        J1SAE_AI 301-306 .3     J1SAE_AO 307-312 .3     J1SAE_AC 313-318 .3
        J1SAE_AA 319-322 .1     J1SE1 323               J1SE2 324-325
        J1SE3 326               J1SE4 327               J1SE5 328-329
        J1SE6 330               J1SE7 331               J1SE8 332
        J1SE9 333               J1SE10 334              J1SE11 335
        J1SE12 336-337          J1SE13 338-339          J1SE14A 340
        J1SE14B 341             J1SE14C 342             J1SE14D 343
        J1SE14E 344             J1SE14F 345             J1SE14G 346
        J1SE14H 347             J1SE14I 348             J1SE14J 349
        J1SE14K 350             J1SE14L 351             J1SE14M 352
        J1SE14N 353             J1SE14O 354             J1SE14P 355
        J1SPOSWF 356-361 .3     J1SNEGWF 362-363        J1SPOSFW 364-369 .3
        J1SNEGFW 370-375 .3     J1SE15A 376             J1SE15B 377
        J1SE15C 378             J1SE15D 379             J1SE15E 380
        J1SE15F 381             J1SE15G 382             J1SE15H 383
        J1SE15I 384             J1SE15J 385             J1SE15K 386
        J1SE16A 387             J1SE16B 388             J1SE16C 389
        J1SE16D 390             J1SJCSD 391-394 .1      J1SJCDA 395-398 .1
        J1SJCDS 399-404 .2      J1SE17A 405             J1SE17B 406
        J1SE17C 407             J1SE17D 408             J1SE17E 409
        J1SJCCS 410-411         J1SJCSS 412-415 .1      J1SE18A 416
        J1SE18B 417             J1SE18C 418             J1SE18D 419
        J1SE18E 420             J1SE18F 421             J1SPIWOR 422-426 .3
        J1SE19 427-428          J1SE20 429-430          J1SE21 431-432
        J1SF1 433-434           J1SF2 435-436           J1SF3 437-438
        J1SF4 439-440           J1SF5 441-442           J1SF6 443
        J1SG1A 444              J1SG1B 445              J1SG1C 446
        J1SG1D 447              J1SG1E 448              J1SG1F 449
        J1SG1G 450              J1SG1H 451              J1SG1I 452
        J1SG1J 453              J1SG1K 454              J1SG1L 455
        J1SG1M 456              J1SG1N 457              J1SG1O 458
        J1SG1P 459              J1SG1Q 460              J1SG1R 461
        J1SG1S 462              J1SMASTE 463-467 .3     J1SCONST 468-472 .3
        J1SCTRL 473-477 .3      J1SESTEE 478-483 .3     J1SG2A 484
        J1SG2B 485              J1SG2C 486              J1SG2D 487
        J1SG2E 488              J1SG2F 489              J1SOPTIM 490-494 .1
        J1SPESSI 495-498 .1     J1SORIEN 499-502 .1     J1SG3A 503
        J1SG3B 504              J1SG3C 505              J1SG3D 506
        J1SG3E 507              J1SG3F 508              J1SG3G 509
        J1SG3H 510              J1SG3I 511              J1SG3J 512
        J1SG3K 513              J1SG3L 514              J1SG3M 515
        J1SG3N 516              J1SG3O 517              J1SG3P 518
        J1SG3Q 519              J1SG3R 520              J1SG3S 521
        J1SG3T 522              J1SPERSI 523-527 .3     J1SREAPP 528-532 .3
        J1SCHANG 533-537 .3     J1SSPCTR 538-542 .3     J1SCPCTR 543-547 .3
        J1SCSCAG 548-552 .3     J1SSUFFI 553-556 .1     J1SG4A 557
        J1SG4B 558              J1SG4C 559              J1SG4D 560
        J1SG4E 561              J1SG4F 562              J1SG4G 563
        J1SG4H 564              J1SG4I 565              J1SG4J 566
        J1SG4K 567              J1SG4L 568              J1SG4M 569
        J1SG4N 570              J1SG4O 571              J1SG4P 572
        J1SG4Q 573              J1SG4R 574              J1SG4S 575
        J1SG4T 576              J1SG4U 577              J1SG4V 578
        J1SINTER 579-583 .3     J1SINDEP 584-588 .3     J1SSC_IT 589-593 .3
        J1SSC_ID 594-598 .3     J1SJINTR 599-603 .3     J1SJINDP 604-608 .3
        J1SG5A 609              J1SG5B 610              J1SG5C 611
        J1SG5D 612              J1SG5E 613              J1SG5F 614
        J1SG5G 615              J1SG5H 616              J1SG5I 617
        J1SG5J 618              J1SSYMP 619-623 .3      J1SADJ 624-628 .2
        J1SG6A 629              J1SG6B 630              J1SG6C 631
        J1SG6D 632              J1SG6E 633              J1SG6F 634
        J1SG6G 635              J1SG6H 636              J1SG6I 637
        J1SG6J 638              J1SG6K 639              J1SG6L 640
        J1SG6M 641              J1SG6N 642              J1SG6O 643
        J1SG6P 644              J1SG6Q 645              J1SG6R 646
        J1SG6S 647              J1SG6T 648              J1SG6U 649
        J1SG6V 650              J1SG6W 651              J1SG6X 652
        J1SG6Y 653              J1SG6Z 654              J1SG6AA 655
        J1SG6BB 656             J1SG6CC 657             J1SG6DD 658
        J1SG6EE 659             J1SNEURO 660-664 .3     J1SEXTRA 665-669 .3
        J1SOPEN 670-674 .3      J1SCONS1 675-679 .3     J1SCONS2 680-684 .3
        J1SAGREE 685-689 .2     J1SAGENC 690-694 .3     J1SG7A 695
        J1SG7B 696              J1SG7C 697              J1SG7D 698
        J1SG7E 699              J1SG7F 700              J1SG7G 701
        J1SG7H 702              J1SG7I 703              J1SG7J 704
        J1SG7K 705              J1SG7L 706              J1SG7M 707
        J1SG7N 708              J1SG7O 709              J1SG7P 710
        J1SG7Q 711              J1SG7R 712              J1SG7S 713
        J1SSC_SC 714-718 .3     J1SSC_CC 719-723 .3     J1SSC_EC 724-728 .3
        J1SSC_BC 729-733 .3     J1SH1A 734              J1SH1B 735
        J1SH1C 736              J1SH1D 737              J1SH1E 738
        J1SH1F 739              J1SGENER 740-743 .1     J1SH2 744-745
        J1SI1 746               J1SI2 747               J1SI3 748-749
        J1SJ1 750-751           J1SJ2 752-753           J1SJ3 754-755
        J1SJ4 756-757           J1SJ5 758-759           J1SJ6 760-761
        J1SJ7A 762              J1SJ7B 763              J1SJ7C 764
        J1SJ7D 765              J1SJ7E 766              J1SJ7F 767
        J1SJ7G 768              J1SJ7H 769              J1SSW_SL 770-774 .2
        J1SSW_GR 775-778 .1     J1SJ8A 779              J1SJ8B 780
        J1SJ8C 781              J1SJ8D 782              J1SJ8E 783
        J1SJ8F 784              J1SJ8G 785              J1SJ8H 786
        J1SJ8I 787              J1SJ8J 788              J1SJ8K 789
        J1SJ8L 790              J1SJ8M 791              J1SJ8N 792
        J1SJ8O 793              J1SJ8P 794              J1SJ8Q 795
        J1SJ8R 796              J1SJ8S 797              J1SJ8T 798
        J1SJ8U 799              J1SJ8V 800              J1SJ8W 801
        J1SJ8X 802              J1SJ8Y 803              J1SJ8Z 804
        J1SJ8AA 805             J1SJ8BB 806             J1SJ8CC 807
        J1SJ8DD 808             J1SJ8EE 809             J1SJ8FF 810
        J1SJ8GG 811             J1SJ8HH 812             J1SJ8II 813
        J1SJ8JJ 814             J1SJ8KK 815             J1SJ8LL 816
        J1SJ8MM 817             J1SJ8NN 818             J1SJ8OO 819
        J1SJ8PP 820             J1SPWBA1 821-825 .1     J1SPWBE1 826-830 .1
        J1SPWBG1 831-835 .1     J1SPWBR1 836-840 .1     J1SPWBU1 841-845 .1
        J1SPWBS1 846-850 .1     J1SPWBA2 851-856 .3     J1SPWBE2 857-862 .3
        J1SPWBG2 863-868 .3     J1SPWBR2 869-874 .3     J1SPWBU2 875-880 .3
        J1SPWBS2 881-886 .3     J1SJ8QQ 887             J1SJ8RR 888
        J1SJ8SS 889             J1SJ8TT 890             J1SJ8UU 891
        J1SJ8VV 892             J1SJ8WW 893             J1SJ8XX 894
        J1SJ8YY 895             J1SJ8ZZ 896             J1SMWBGR 897-902 .2
        J1SMWBPD 903-908 .2     J1SK1 909               J1SSGFA 910
        J1SK2 911-912           J1SK3A 913              J1SK3B 914
        J1SK3C 915              J1SK3D 916              J1SK3E 917
        J1SK3F 918              J1SK3G 919              J1SK3H 920
        J1SFDSPO 921-925 .3     J1SFDSNE 926-930 .3     J1SFDSOL 931-935 .3
        J1SK4A 936              J1SK4B 937              J1SK4C 938
        J1SK4D 939              J1SK4E 940              J1SK4F 941
        J1SK4G 942              J1SK4H 943              J1SSUGF 944-948 .3
        J1SSTGF 949-953 .3      J1SSOGFD 954-958 .3     J1SL1 959
        J1SL2 960-961           J1SL3CY 962-965         J1SL3MO 966-967
        J1SL4 968-969           J1SL5 970-971           J1SL6 972-973
        J1SL7 974-975           J1SL8 976-977           J1SL9 978
        J1SL10 979              J1SMARRS 980-981        J1SL11A 982
        J1SL11B 983             J1SL11C 984             J1SSPDIS 985-988 .1
        J1SL12 989              J1SL13A 990             J1SL13B 991
        J1SL13C 992             J1SL13D 993             J1SL13E 994
        J1SL13F 995             J1SL14A 996             J1SL14B 997
        J1SL14C 998             J1SL14D 999             J1SL14E 1000
        J1SL14F 1001            J1SSPEMP 1002-1006 .3   J1SSPCRI 1007-1011 .3
        J1SSPSOL 1012-1016 .3   J1SL15A 1017            J1SL15B 1018
        J1SL15C 1019            J1SL15D 1020            J1SL15E 1021
        J1SL15F 1022            J1SL16A 1023            J1SL16B 1024
        J1SL16C 1025            J1SL16D 1026            J1SL16E 1027
        J1SL16F 1028            J1SSUGS 1029-1033 .3    J1SSTGS 1034-1038 .3
        J1SSOLGS 1039-1043 .3   J1SL17 1044             J1SL18 1045-1046
        J1SL19 1047-1048        J1SL20 1049             J1SL21 1050
        J1SL22A 1051            J1SL22B 1052            J1SL22C 1053
        J1SL22D 1054            J1SSPDEC 1055-1060 .3   J1SL23 1061
        J1SL24 1062             J1SL25 1063             J1SM1 1064
        J1SM2 1065-1066         J1SM3 1067-1068         J1SM4 1069-1070
        J1SM5 1071-1072         J1SM6 1073-1074         J1SM7A 1075
        J1SM7B 1076             J1SM7C 1077             J1SM7D 1078
        J1SM7E 1079             J1SM7F 1080             J1SPIFAM 1081-1085 .3
        J1SN1 1086              J1SN2 1087-1088         J1SN3A 1089
        J1SN3B 1090             J1SN3C 1091             J1SN3D 1092
        J1SN3E 1093             J1SN3F 1094             J1SN4A 1095
        J1SN4B 1096             J1SN4C 1097             J1SN4D 1098
        J1SN4E 1099             J1SN4F 1100             J1SN4G 1101
        J1SN4H 1102             J1SN4I 1103             J1SN4J 1104
        J1SKINPO 1105-1109 .3   J1SKINNE 1110-1114 .3   J1SFAMSO 1115-1119 .3
        J1SSUGFA 1120-1123 .1   J1SSTGFA 1124-1128 .3   J1SSOGFM 1129-1133 .3
        J1SO1 1134              J1SO2A 1135             J1SO2B 1136
        J1SO2C 1137             J1SO3A 1138             J1SO3B 1139
        J1SO3C 1140             J1SP1 1141              J1SP1A 1142-1144
        J1SP1B 1145             J1SP1CCY 1146-1149      J1SP1D 1150-1152
        J1SP2 1153              J1SP2A 1154-1156        J1SP2B 1157
        J1SP2CCY 1158-1161      J1SP2D 1162-1164        J1SQ1 1165
        J1SQ2AGE 1166-1167      J1SQ3 1168-1169         J1SQ4 1170
        J1SQ5 1171              J1SQ6A 1172             J1SQ6B 1173
        J1SQ6C 1174             J1SQ6D 1175             J1SQ6E 1176
        J1SQ6F 1177             J1SQ6G 1178             J1SQ6H 1179
        J1SQ6I 1180             J1SQ6J 1181             ;


* SAS LABEL STATEMENT;

LABEL
   MIDJA_IDS= 'Corrected ID - no duplicates'
   J1SA1   = 'Rate health current'
   J1SA2   = 'Rate health ten years'
   J1SA3   = 'Rate health ten years future'
   J1SA4   = 'Rate control over health'
   J1SA5   = 'Rate thought/effort put into health'
   J1SSATIS= 'Life Satisfaction (5-items)'
   J1SSATI2= 'Life Satisfaction (6-items)'
   J1SA6A  = 'Often aware of various things in my body'
   J1SA6B  = 'Sudden loud noises really bother me'
   J1SA6C  = 'Hate to be too hot/too cold'
   J1SA6D  = 'Quick to sense hunger contractions'
   J1SA6E  = 'Low pain'
   J1SAMPLI= 'Somatic Amplification'
   J1SA7A  = 'Headaches frequency (30 days)'
   J1SA7B  = 'Backaches frequency (30 days)'
   J1SA7C  = 'Sweat frequency (30 days)'
   J1SA7D  = 'Irritability freq (30 days)'
   J1SA7E  = 'Hot flushes/flashes frequency (30 days)'
   J1SA7F  = 'Aches/joint stiffness frequnecy (30 days)'
   J1SA7G  = 'Falling/staying sleep frequency (30 days)'
   J1SA7H  = 'Leaking urine frequency (30 days)'
   J1SA7I  = 'Extremities aches/pain freq (30 days)'
   J1SA8A  = 'Asthma/bronchitis/emphysema ever (12 mo)'
   J1SA8B  = 'Tuberculosis ever (12 mo)'
   J1SA8C  = 'Other lung problems ever (12 mo)'
   J1SA8D  = 'Joint/bone diseases ever (12 mo)'
   J1SA8E  = 'Sciatica/lumbago/backache ever (12 mo)'
   J1SA8F  = 'Skin trouble persistent ever (12 mo)'
   J1SA8G  = 'Thyroid disease ever (12 mo)'
   J1SA8H  = 'Hay fever ever (12 mo)'
   J1SA8I  = 'Stomach trouble ever (12 mo)'
   J1SA8J  = 'Urinary/bladder problem ever (12 mo)'
   J1SA8K  = 'Constipated all/most ever (12 mo)'
   J1SA8L  = 'Gall bladder trouble ever (12 mo)'
   J1SA8M  = 'Foot trouble persistent ever (12 mo)'
   J1SA8N  = 'Varicose veins ever (12 mo)'
   J1SA8O  = 'AIDS/HIV ever (12 mo)'
   J1SA8P  = 'Lupus/autoimmune disorder ever (12 mo)'
   J1SA8Q  = 'Gum/mouth troubl persistent ever (12 mo)'
   J1SA8R  = 'Teeth trouble persistent ever (12 mo)'
   J1SA8S  = 'High blood press/hypertensn ever (12 mo)'
   J1SA8T  = 'Anxiety/depression ever (12 mo)'
   J1SA8U  = 'Alcohol/drug problem ever (12 mo)'
   J1SA8V  = 'Migraine headaches ever (12 mo)'
   J1SA8W  = 'Chronic sleep problems ever (12 mo)'
   J1SA8X  = 'Diabetes/high blood sugar ever (12 mo)'
   J1SA8Y  = 'Neurological disorder ever (12 mo)'
   J1SA8Z  = 'Stroke ever (12 mo)'
   J1SA8AA = 'Ulcer ever (12 mo)'
   J1SA8BB = 'Hernia ever (12 mo)'
   J1SA8CC = 'Piles/hemorrhoids ever (12 mo)'
   J1SA8DD = 'Swallowing problems ever (12 mo)'
   J1SA8EE = 'None of the problems above (12 mo)'
   J1SCHRON= 'Number Chronic Conditions (12 mo)'
   J1SCHROX= 'Having any chronic conditions (12 mo)'
   J1SA9A  = 'RX hypertension ever (30 days)'
   J1SA9AY = 'RX hypertension frequency (30 days)'
   J1SA9B  = 'RX diabetes ever (30 days)'
   J1SA9BY = 'RX diabetes frequency (30 days)'
   J1SA9C  = 'RX cholesterol ever (30 days)'
   J1SA9CY = 'RX cholesterol frequency (30 days)'
   J1SA9D  = 'RX heart condition ever (30 days)'
   J1SA9DY = 'RX heart condition frequency (30 days)'
   J1SA9E  = 'RX lung problems ever (30 days)'
   J1SA9EY = 'RX lung problems frequency (30 days)'
   J1SA9F  = 'RX ulcer ever (30 days)'
   J1SA9FY = 'RX ulcer frequency (30 days)'
   J1SA9G  = 'RX arthritis ever (30 days)'
   J1SA9GY = 'RX arthritis frequency (30 days)'
   J1SA9H  = 'RX hormone therapy ever (30 days)'
   J1SA9HY = 'RX hormone therapy frequency (30 days)'
   J1SA9I  = 'RX birth control ever (30 days)'
   J1SA9IY = 'RX birth control frequency (30 days)'
   J1SA9J  = 'RX headaches ever (30 days)'
   J1SA9JY = 'RX headaches frequency (30 days)'
   J1SA9K  = 'RX anxiety/depression ever (30 days)'
   J1SA9KY = 'RX anxiety/depression freq (30 days)'
   J1SA9L  = 'RX pain ever (30 days)'
   J1SA9LY = 'RX pain frequency (30 days)'
   J1SRXMED= 'Total Numbers Rx medicine taking (30 dys)'
   J1SRXMEX= 'Took any RX medicine (30 dys)'
   J1SA10A = 'Health limits lifting/carrying groceries'
   J1SA10B = 'Health limits bathing/dressing self'
   J1SA10C = 'Health limits climb 2-3 flights stair'
   J1SA10D = 'Health limits climb one flight of stairs'
   J1SA10E = 'Health limits bending/kneeling/stooping'
   J1SA10F = 'Health limits walking 2000 meters or more'
   J1SA10G = 'Health limits walking 200-300 meters'
   J1SA10H = 'Health limits walking 50 meters'
   J1SA10I = 'Health limits vigorous activity'
   J1SA10J = 'Health limits moderate activity'
   J1SBADL1= 'Basic Activity of Daily Living (2-item version)'
   J1SBADL2= 'Basic Activity of Daily Living (3-item version)'
   J1SIADL = 'Instrumental Activity of Daily Living'
   J1SA11A = 'Short breath hurry ground/walk slight hill'
   J1SA11B = 'Short breath walk w/ peer level ground'
   J1SA11C = 'Short breath walk own pace level ground'
   J1SA11D = 'Short breath washing/dressing'
   J1SDYSPN= 'Progressive Levels of Dyspnea'
   J1SA12  = 'Anesthesia ever'
   J1SA13CY= 'Anesthesia most recent Common Era Year'
   J1SA13CM= 'Anesthesia most recent Common Era Month'
   J1SA14  = 'Hospitalized overnight in the past 12 months'
   J1SA15  = 'Num times hospitalized overnight (12 mo)'
   J1SA16  = 'Total number nights in hospital (12 mo)'
   J1SA17A = 'Had physical routine exam (12 mo)'
   J1SA17AN= 'Num times physical routine exam (12 mo)'
   J1SA17B = 'Had dental routine exam (12 mo)'
   J1SA17BN= 'Number times dental routine exam (12 mo)'
   J1SA17C = 'Had optical routine exam (12 mo)'
   J1SA17CN= 'Num times optical routine exam (12 mo)'
   J1SA17D = 'Had  urgent care (12 mo)'
   J1SA17DN= 'Number times urgent care (12 mo)'
   J1SA17E = 'Had scheduled treat/surgry (12 mo)'
   J1SA17EN= 'Num times scheduled treat/surgry (12 mo)'
   J1SUSEMD= 'Number Times Seeing Medical Doctor (12 mo)'
   J1SA18A = 'Acupuncture frequency (12 mo)'
   J1SA18B = 'Chiropractor frequency (12 mo)'
   J1SA18C = 'Exercise/movement therapy freq (12 mo)'
   J1SA18D = 'Herbal therapy frequency (12 mo)'
   J1SA18E = 'High dose mega-vitamins frequency (12mo)'
   J1SA18F = 'Oth non-traditional therapy freq (12 mo)'
   J1SA19  = 'Current health insurance plan'
   J1SA20A = 'Medical with hospital supplement'
   J1SA20B = 'Cancer Insurance'
   J1SA20C = 'Medical with home care supplement'
   J1SA20D = 'Medical with adult disease supplement'
   J1SA20E = 'Other private medical'
   J1SA20F = 'Enrolled, details unknown'
   J1SA20G = 'Not enrolled'
   J1SB1A  = 'Did R EVER smoke?'
   J1SB1   = 'Age had first cigarette'
   J1SB2   = 'Ever smoked cigarettes regularly'
   J1SB3   = 'Age began to smoke regularly'
   J1SB4   = 'Now smoke cigarettes regularly'
   J1SB5   = 'Cigs/day during heaviest yr (cur smoker)'
   J1SC1   = 'How many days per week drank'
   J1SC2   = 'Number drinks on days when drank'
   J1SC3   = 'Times had 5+drinks same occsn (past mo)'
   J1SC4   = '# times drank more than intended (12 mo)'
   J1SC5   = '# times alcoh effects at work/etc (12mo)'
   J1SC6   = 'Lived with alcoholic during childhood'
   J1SC7   = 'Ever married to/lived with alcoholic'
   J1SD1A  = 'Felt so sad no could cheer freq (30 days)'
   J1SD1B  = 'Felt nervous frequency (30 days)'
   J1SD1C  = 'Felt restless frequency (30 days)'
   J1SD1D  = 'Felt hopeless frequency (30 days)'
   J1SD1E  = 'Felt everything was effort freq (30 days)'
   J1SD1F  = 'Felt worthless frequency (30 days)'
   J1SD1G  = 'Felt lonely frequency (30 days)'
   J1SD1H  = 'Felt afraid frequency (30 days)'
   J1SD1I  = 'Felt jittery frequency (30 days)'
   J1SD1J  = 'Felt irritable frequency (30 days)'
   J1SD1K  = 'Felt ashamed frequency (30 days)'
   J1SD1L  = 'Felt upset frequency (30 days)'
   J1SD1M  = 'Felt angry frequency (30 days)'
   J1SD1N  = 'Felt frustrated frequency (30 days)'
   J1SNEGAF= 'Negative affect'
   J1SNEGPA= 'PANAS Negative Adjectives'
   J1SD2A  = 'Felt cheerful frequency (30 days)'
   J1SD2B  = 'Felt good spirits frequency (30 days)'
   J1SD2C  = 'Felt extremely happy frequency (30 days)'
   J1SD2D  = 'Felt calm and peaceful freq (30 days)'
   J1SD2E  = 'Felt satisfied frequency (30 days)'
   J1SD2F  = 'Felt full of life frequency (30 days)'
   J1SD2G  = 'Felt close to others frequency (30 days)'
   J1SD2H  = 'Felt belong frequency (30 days)'
   J1SD2I  = 'Felt enthusiastic frequency (30 days)'
   J1SD2J  = 'Felt attentive frequency (30 days)'
   J1SD2K  = 'Felt proud frequency (30 days)'
   J1SD2L  = 'Felt active frequency (30 days)'
   J1SD2M  = 'Felt confident frequency (30 days)'
   J1SPOSAF= 'Positive affect'
   J1SPOSPA= 'PANAS Positive Adjectives'
   J1SD3A  = 'PSS Upset by something unexpected'
   J1SD3B  = 'PSS Unable to control important things'
   J1SD3C  = 'PSS Felt nervous and stressed'
   J1SD3D  = 'PSS Confident to handle personal problems'
   J1SD3E  = 'PSS Things were going your way'
   J1SD3F  = 'PSS Could not cope with all things to do'
   J1SD3G  = 'PSS Able to control irritations in life'
   J1SD3H  = 'PSS Felt on top of things'
   J1SD3I  = 'PSS Angered by things outside control'
   J1SD3J  = 'PSS Difficulties piling up can''t overcome'
   J1SPS_PS= 'Percieved Stress Scale'
   J1SD4A  = 'S- ANX Talking to authority'
   J1SD4B  = 'S- ANX Going to a party'
   J1SD4C  = 'S- ANX Working while observed'
   J1SD4D  = 'S- ANX Calling someone you don''t know well'
   J1SD4E  = 'S- ANX Talking with people don''t know well'
   J1SD4F  = 'S- ANX Center of attention'
   J1SD4G  = 'S- ANX Express disagreement to stranger'
   J1SD4H  = 'S- ANX Returning goods to a store'
   J1SD4I  = 'S- ANX Resist high-pressure salesperson'
   J1SSA_SA= 'Social Anxiety Scale'
   J1SD5A  = 'ANG-EXP Withdraw from people'
   J1SD5B  = 'ANG-EXP Pout or sulk'
   J1SD5C  = 'ANG-EXP Angrier than willing to admit'
   J1SD5D  = 'ANG-EXP Secretly critical of others'
   J1SD5E  = 'ANG-EXP Boil inside; dont show it'
   J1SD5F  = 'ANG-EXP Harbor grudges'
   J1SD5G  = 'ANG-EXP Keep things in'
   J1SD5H  = 'ANG-EXP Irritated more than others aware'
   J1SD5I  = 'ANG-EXP Slam doors'
   J1SD5J  = 'ANG-EXP Say nasty things'
   J1SD5K  = 'ANG-EXP Make sarcastic remarks'
   J1SD5L  = 'ANG-EXP Argue with others'
   J1SD5M  = 'ANG-EXP Lose my temper'
   J1SD5N  = 'ANG-EXP Strike out at what infuriates me'
   J1SD5O  = 'ANG-EXP Express my anger'
   J1SD5P  = 'ANG-EXP Someone annoys me, I tell them'
   J1SD5Q  = 'ANG-EXP Control my temper'
   J1SD5R  = 'ANG-EXP Keep my cool'
   J1SD5S  = 'ANG-EXP Calm down faster'
   J1SD5T  = 'ANG-EXP Make threats'
   J1SD5U  = 'ANG-EXP Do nothing'
   J1SD5V  = 'ANG-EXP Ignore what angers me'
   J1SAE_AI= 'Spielberger Anger Expression:Anger/In'
   J1SAE_AO= 'Spielberger Anger Expression:Anger/Out'
   J1SAE_AC= 'Spielberger Anger Expression: Anger/Control'
   J1SAE_AA= 'Spielberger Anger Expresson:Adjustment Scale'
   J1SE1   = 'Working for pay at the present time'
   J1SE2   = 'Current job type'
   J1SE3   = 'Description of working style'
   J1SE4   = 'Content of job provided Yes/No'
   J1SE5   = 'Number of employees'
   J1SE6   = 'In management position'
   J1SE7   = 'Problem with someone at work (12 mo)'
   J1SE8   = 'Other ongoing stress at work (12 mo)'
   J1SE9   = 'Chances could keep job for next 2 yrs'
   J1SE10  = 'Job effect on physical health'
   J1SE11  = 'Job effect on emotional/mental health'
   J1SE12  = 'Rate amount control over work situation'
   J1SE13  = 'Rate thought/effort put into work'
   J1SE14A = 'Job reduces effort to activities at home'
   J1SE14B = 'Job stress makes irritable at home'
   J1SE14C = 'Job makes too tired to do things at home'
   J1SE14D = 'Job problems distract you at home'
   J1SE14E = 'Job helps to deal with issues at home'
   J1SE14F = 'Job makes you more interesting at home'
   J1SE14G = 'Job makes you better companion at home'
   J1SE14H = 'Job skills useful at home'
   J1SE14I = 'Home responsibilities reduce job effort'
   J1SE14J = 'Personal worries distract you at job'
   J1SE14K = 'Home chores prevents sleep to do job'
   J1SE14L = 'Home stress makes irritable at job'
   J1SE14M = 'Talk someone at home helps job problems'
   J1SE14N = 'Providing home makes work harder at job'
   J1SE14O = 'Home love makes you confident at job'
   J1SE14P = 'Home helps to relax for next workday'
   J1SPOSWF= 'Positive Work to Family Spillover'
   J1SNEGWF= 'Negative Work to Family Spillover'
   J1SPOSFW= 'Positive Family to Work Spillover'
   J1SNEGFW= 'Negative Family to Work Spillover'
   J1SE15A = 'Work intensively at job'
   J1SE15B = 'Learn new things at work'
   J1SE15C = 'Work demands high skill level'
   J1SE15D = 'Initiate things at job'
   J1SE15E = 'Choice how to do work tasks'
   J1SE15F = 'Choice what tasks to do at work'
   J1SE15G = 'Say in work decisions'
   J1SE15H = 'Say in planning work environment'
   J1SE15I = 'Job provides variety interesting things'
   J1SE15J = 'Work demands hard to combine'
   J1SE15K = 'So involved in work forget time'
   J1SE16A = 'Too many demands at job'
   J1SE16B = 'Control amount of time on tasks at job'
   J1SE16C = 'Time to get everything done at job'
   J1SE16D = 'Lot of interruptions at job'
   J1SJCSD = 'Skill Discretion (Job Characteristics)'
   J1SJCDA = 'Decision Authority (Job Characteristics)'
   J1SJCDS = 'Demands Scale (Job Characteristics)'
   J1SE17A = 'Coworker help/support'
   J1SE17B = 'Coworker listen to work-related problems'
   J1SE17C = 'Supervisor gives needed information'
   J1SE17D = 'Supervisor help/support'
   J1SE17E = 'Supervisor listens to work-related probs'
   J1SJCCS = 'Coworker Support (Job Characteristics)'
   J1SJCSS = 'Supervisor Support (Job Characteristics)'
   J1SE18A = 'Feel cheated about good job chances'
   J1SE18B = 'Feel pride for work at job'
   J1SE18C = 'Others respect my work at job'
   J1SE18D = 'Others have more rewarding jobs'
   J1SE18E = 'Had opportunities as good as others'
   J1SE18F = 'Others have better jobs than me'
   J1SPIWOR= 'Perceived Inequality in Work'
   J1SE19  = 'Rate current work situation'
   J1SE20  = 'Rate work situation ten years ago'
   J1SE21  = 'Rate work situation ten years future'
   J1SF1   = 'Rate current financial situation'
   J1SF2   = 'Rate financial situation ten years ago'
   J1SF3   = 'Rate financial situation ten yrs future'
   J1SF4   = 'Rate control over financial situation'
   J1SF5   = 'Rate thought/effort into financial sitn'
   J1SF6   = '$ to meet needs (more,enough,not enough)'
   J1SG1A  = 'Little can do to change important things'
   J1SG1B  = 'Helpless dealing with problems of life'
   J1SG1C  = 'Do just about anything I set my mind to'
   J1SG1D  = 'Oths determine what I can and cannot do'
   J1SG1E  = 'What happens in life is beyond my ctrl'
   J1SG1F  = 'When really want something, find way'
   J1SG1G  = 'Many things interfere w/ what I want do'
   J1SG1H  = 'Whether I get what want is in own hands'
   J1SG1I  = 'Little control over things happen to me'
   J1SG1J  = 'Really no way I can solve probs I have'
   J1SG1K  = 'Feel pushed around in life'
   J1SG1L  = 'Happens to me in future depends on me'
   J1SG1M  = 'No better/worse than others'
   J1SG1N  = 'Take positive attitude toward self'
   J1SG1O  = 'Feel no good at all at times'
   J1SG1P  = 'Able to do things as well as most people'
   J1SG1Q  = 'Wish have more respect for myself'
   J1SG1R  = 'On the whole, Im satisfied with myself'
   J1SG1S  = 'Certainly feel useless at times'
   J1SMASTE= 'Personal Mastery'
   J1SCONST= 'Perceived Constraints'
   J1SCTRL = 'Sense of Control (Mastery + Constraints)'
   J1SESTEE= 'Self-esteem'
   J1SG2A  = 'In uncertain times usually expect best'
   J1SG2B  = 'Something can go wrong for me it will'
   J1SG2C  = 'Optimistic about my future'
   J1SG2D  = 'Hardly ever expect things to go my way'
   J1SG2E  = 'Rarely count on good things happen to me'
   J1SG2F  = 'Expect more good things happen than bad'
   J1SOPTIM= 'LOT: Optimism'
   J1SPESSI= 'LOT: Pessimism'
   J1SORIEN= 'LOT Overall: Optimism+Pessimism'
   J1SG3A  = 'Where theres a will theres a way'
   J1SG3B  = 'Do what can to change for better'
   J1SG3C  = 'If expectation not being met, lower them'
   J1SG3D  = 'To avoid disappnt, no set goals too high'
   J1SG3E  = 'Learn meaningful from difficlt situation'
   J1SG3F  = 'Relieved when let go of responsibilities'
   J1SG3G  = 'Even when feel too much, get it all done'
   J1SG3H  = 'Find different way of looking at things'
   J1SG3I  = 'Remind myself I cant do everything'
   J1SG3J  = 'When probs, No give up until solve them'
   J1SG3K  = 'Rarely give up even when get tough'
   J1SG3L  = 'Cant get want, assume goals unrealistic'
   J1SG3M  = 'When go wrong, usually find bright side'
   J1SG3N  = 'Find positive even in worst situations'
   J1SG3O  = 'No like ask oths for help unless have to'
   J1SG3P  = 'Asking others comes naturally for me'
   J1SG3Q  = 'No solve prob alone, ask others for help'
   J1SG3R  = 'Obstacles in way, get help from others'
   J1SG3S  = 'Difficulties too great, ask oths advice'
   J1SG3T  = 'Keep harmony w/ others and surroundings'
   J1SPERSI= 'Persist in Goal Striving (Primary Ctrl)'
   J1SREAPP= 'Positive Reappraisal (Secondary Control)'
   J1SCHANG= 'Lower Aspriations (Secondary Control)'
   J1SSPCTR= 'Selective Primary Control'
   J1SCPCTR= 'Compensatory Primary Control'
   J1SCSCAG= 'Adjustment of Goals (Compensatory Secndry Ctrl)'
   J1SSUFFI= 'Self-Sufficiency'
   J1SG4A  = 'RELAT Respect authority figures'
   J1SG4B  = 'RELAT Prefer to say NO directly'
   J1SG4C  = 'RELAT Important to keep harmony in group'
   J1SG4D  = 'RELAT Speaking up is no problem'
   J1SG4E  = 'RELAT Lively imagination important'
   J1SG4F  = 'RELAT Being singled out for praise OK'
   J1SG4G  = 'RELAT Respect for modest people'
   J1SG4H  = 'RELAT Same person at home, work, social'
   J1SG4I  = 'RELAT Sacrifice self for benefit of group'
   J1SG4J  = 'RELAT Should consider others input: plans'
   J1SG4K  = 'RELAT Prefer to be direct with new people'
   J1SG4L  = 'RELAT Important to respect group decision'
   J1SG4M  = 'RELAT Stay with group even if not happy'
   J1SG4N  = 'RELAT If family fails, I feel responsible'
   J1SG4O  = 'RELAT Even if strong disagree -don''t argue'
   J1SG4P  = 'RELAT Important to have my own ideas'
   J1SG4Q  = 'Act same way no matter who I''m with'
   J1SG4R  = 'Enjoy being unique/different from others'
   J1SG4S  = 'My happiness depends on happiness of oth'
   J1SG4T  = 'Relations more important than accomplish'
   J1SG4U  = 'Able to care of self is primary concern'
   J1SG4V  = 'Important to listen to others'' opinions'
   J1SINTER= 'Self-Construal: Interdependence (P1 3-item version)'
   J1SINDEP= 'Self-Construal: Independence (P1 3-item verseion)'
   J1SSC_IT= 'Self-Construal: Interdependence (P4 10-item version)'
   J1SSC_ID= 'Self-Construal: Independence (P4 7-item version)'
   J1SJINTR= 'Self-Construal: Interdependence (J1 12-item version)'
   J1SJINDP= 'Self-Construal: Independence (J1 10-item version)'
   J1SG5A  = 'Not happy if friend in trouble'
   J1SG5B  = 'Moved by another persons hardship'
   J1SG5C  = 'Important to be sympathetic others'
   J1SG5D  = 'My sympathy has its limits'
   J1SG5E  = 'RELAT Follow opinion of people I respect'
   J1SG5F  = 'RELAT Adjust opinion to fit group'
   J1SG5G  = 'RELAT Adjust values to fit others'
   J1SG5H  = 'RELAT Adjust to things hard to change'
   J1SG5I  = 'RELAT Life uncertain: try change no use'
   J1SG5J  = 'Important to help people who I know well'
   J1SSYMP = 'Sympathy scale'
   J1SADJ  = 'Adjustment scale'
   J1SG6A  = 'Outgoing describes you how well'
   J1SG6B  = 'Helpful describes you how well'
   J1SG6C  = 'Moody describes you how well'
   J1SG6D  = 'Organized describes you how well'
   J1SG6E  = 'Self confident describes you how well'
   J1SG6F  = 'Friendly describes you how well'
   J1SG6G  = 'Warm describes you how well'
   J1SG6H  = 'Worrying describes you how well'
   J1SG6I  = 'Responsible describes you how well'
   J1SG6J  = 'Forceful describes you how well'
   J1SG6K  = 'Lively describes you how well'
   J1SG6L  = 'Caring describes you how well'
   J1SG6M  = 'Nervous describes you how well'
   J1SG6N  = 'Creative describes you how well'
   J1SG6O  = 'Assertive describes you how well'
   J1SG6P  = 'Hardworking describes you how well'
   J1SG6Q  = 'Imaginative describes you how well'
   J1SG6R  = 'Softhearted describes you how well'
   J1SG6S  = 'Calm describes you how well'
   J1SG6T  = 'Outspoken describes you how well'
   J1SG6U  = 'Intelligent describes you how well'
   J1SG6V  = 'Curious describes you how well'
   J1SG6W  = 'Active describes you how well'
   J1SG6X  = 'Careless describes you how well'
   J1SG6Y  = 'Broad minded describes you how well'
   J1SG6Z  = 'Sympathetic describes you how well'
   J1SG6AA = 'Talkative describes you how well'
   J1SG6BB = 'Sophisticated describes you how well'
   J1SG6CC = 'Adventurous describes you how well'
   J1SG6DD = 'Dominant describes you how well'
   J1SG6EE = 'Thorough describes you how well'
   J1SNEURO= 'Neuroticism Personality Trait'
   J1SEXTRA= 'Extraversion Personality Trait'
   J1SOPEN = 'Openness Personality Trait'
   J1SCONS1= 'Conscientiousness Personality Trait (Parallel M1 items)'
   J1SCONS2= 'Conscientiousness Personality Trait (M1 items + 1 additional)'
   J1SAGREE= 'Agreeableness Personality Trait'
   J1SAGENC= 'Agency Personality Trait'
   J1SG7A  = 'CNTRL Make self do things dont want to'
   J1SG7B  = 'CNTRL If I have prob; others have worse'
   J1SG7C  = 'CNTRL Can control thoughts/desires'
   J1SG7D  = 'CNTRL Impt think, feel, act as needed'
   J1SG7E  = 'CNTRL Can improve self if change thoughts'
   J1SG7F  = 'CNTRL Impt be strong in mind and body'
   J1SG7G  = 'CNTRL Control emotions by change thoughts'
   J1SG7H  = 'CNTRL I keep my emotions to myself'
   J1SG7I  = 'CNTRL In stress, use thoughts keep calm'
   J1SG7J  = 'CNTRL Feel, but dont express neg emotion'
   J1SG7K  = 'CNTRL Known as emotional person'
   J1SG7L  = 'CNTRL Impt not to be bother to others'
   J1SG7M  = 'CNTRL Try to behave:so no trouble others'
   J1SG7N  = 'CNTRL Worry I am burden on others'
   J1SG7O  = 'CNTRL I know my own limitations'
   J1SG7P  = 'CNTRL Do best to maintain a calm mind'
   J1SG7Q  = 'CNTRL Top priority:do what supposed to'
   J1SG7R  = 'CNTRL Feel very tense when evaluated'
   J1SG7S  = 'CNTRL Often concerned re: response to me'
   J1SSC_SC= 'Self-control Scale'
   J1SSC_CC= 'Cognition Control'
   J1SSC_EC= 'Emotion Control'
   J1SSC_BC= 'Burden Consciousness'
   J1SH1A  = 'Made unique contributions to society'
   J1SH1B  = 'Important skills to pass along to others'
   J1SH1C  = 'Many people come to you for advice'
   J1SH1D  = 'Feel other people need you'
   J1SH1E  = 'Good influence on others lives'
   J1SH1F  = 'Like to teach things to people'
   J1SGENER= 'Loyola Generativity Scale'
   J1SH2   = 'Rank standing in community on ladder'
   J1SI1   = 'Contact with neighbors frequency'
   J1SI2   = 'Conversatn/get togthr w/ neighbor (freq)'
   J1SI3   = 'Years lived in current neighborhood'
   J1SJ1   = 'Rate life overall currently'
   J1SJ2   = 'Rate life overall ten years ago'
   J1SJ3   = 'Rate life overall ten years future'
   J1SJ4   = 'Rate control over life overall'
   J1SJ5   = 'Rate thought/effort into life overall'
   J1SJ6   = 'Rate your day today'
   J1SJ7A  = 'GDLIFE More happy than peers'
   J1SJ7B  = 'GDLIFE Life close to ideal'
   J1SJ7C  = 'GDLIFE Life conditions excellent'
   J1SJ7D  = 'GDLIFE Satisfied with life'
   J1SJ7E  = 'GDLIFE Gotten important things'
   J1SJ7F  = 'GDLIFE Live over, change nothing'
   J1SJ7G  = 'GDLIFE So much to be thankful for'
   J1SJ7H  = 'GDLIFE Grateful to many people'
   J1SSW_SL= 'Subjective WellBeing - Satisfaction with Life Scale'
   J1SSW_GR= 'Subjective WellBeing - Gratitude Scale'
   J1SJ8A  = 'Not afraid to voice opinions in oppositn'
   J1SJ8B  = 'In charge of situation in which I live'
   J1SJ8C  = 'No interested activities expand horizons'
   J1SJ8D  = 'Most see me as loving/affectionate'
   J1SJ8E  = 'Live life day by day, no think about fut'
   J1SJ8F  = 'Pleased with how life turned out'
   J1SJ8G  = 'Decisions not influenced by others doing'
   J1SJ8H  = 'Demands of everyday life oft get me down'
   J1SJ8I  = 'Experience challenge how think important'
   J1SJ8J  = 'Maintaining close relationships difficlt'
   J1SJ8K  = 'Have sense of direction/purpose in life'
   J1SJ8L  = 'Feel positive/confident about self'
   J1SJ8M  = 'Influenced by people w/ strong opinions'
   J1SJ8N  = 'Don''t fit in w/ people and community'
   J1SJ8O  = 'Haven''t improved as person over years'
   J1SJ8P  = 'Few close friends to share concerns with'
   J1SJ8Q  = 'No good sense of what try to accomplish'
   J1SJ8R  = 'Others gotten more out of life than I'
   J1SJ8S  = 'Confdnce in my opinions even if contrary'
   J1SJ8T  = 'Good managing daily responsibilities'
   J1SJ8U  = 'Developed a lot as person over time'
   J1SJ8V  = 'Enjoy conversations w/ family & friends'
   J1SJ8W  = 'Daily activities seem trivial & unimport'
   J1SJ8X  = 'Like most aspects of my personality'
   J1SJ8Y  = 'Difficult voice opinion on controversia'
   J1SJ8Z  = 'Overwhelmed by my responsibilities'
   J1SJ8AA = 'Life process of learning/changing/growth'
   J1SJ8BB = 'Others describe me as giving/share time'
   J1SJ8CC = 'Enjoy make plans for future & make real'
   J1SJ8DD = 'Disappointed about achievements in life'
   J1SJ8EE = 'Worry about what others think of me'
   J1SJ8FF = 'Diffclt arranging life in satisfying way'
   J1SJ8GG = 'Gave up try making improvements long ago'
   J1SJ8HH = 'No experience warm & trusting relations'
   J1SJ8II = 'Self attitude not as positive as others'
   J1SJ8JJ = 'Judge self by what I think is important'
   J1SJ8KK = 'Able to build lifestyle to my liking'
   J1SJ8LL = 'No enjoy situations require change ways'
   J1SJ8MM = 'I can trust friends & they can trust me'
   J1SJ8NN = 'Some wander aimlessly but not me'
   J1SJ8OO = 'Feel good when compare myself to friends'
   J1SJ8PP = 'Done all there is to do in life'
   J1SPWBA1= 'Autonomy (Psych Well-Being 3-item)'
   J1SPWBE1= 'Environmental Mastery (Psych Well-Being 3-item)'
   J1SPWBG1= 'Personal Growth (Psych Well-Being 3-item)'
   J1SPWBR1= 'Positive relations with others (Psych Well-Being 3-item)'
   J1SPWBU1= 'Purpose in Life (Psych Well-Being 3-item)'
   J1SPWBS1= 'Self Acceptance (Psych Well-Being 3-item)'
   J1SPWBA2= 'Autonomy (Psych Well-Being 7-item)'
   J1SPWBE2= 'Environmental Mastery (Psych Well-Being 7-item)'
   J1SPWBG2= 'Personal Growth (Psych Well-Being 7-item)'
   J1SPWBR2= 'Positive Relations w/ others (Psych Well-Being 7-item)'
   J1SPWBU2= 'Purpose in Life (Psych Well-Being 7-item)'
   J1SPWBS2= 'Self Acceptance (Psych Well-Being 7-item)'
   J1SJ8QQ = 'Take things as they are'
   J1SJ8RR = 'Grateful I was born'
   J1SJ8SS = 'Feels good do nothing and relax'
   J1SJ8TT = 'Life is succession of present moments'
   J1SJ8UU = 'Satisfied with time to laze'
   J1SJ8VV = 'Gratitude just to be alive'
   J1SJ8WW = 'Existence by itself has meaning'
   J1SJ8XX = 'Feel free when spend all time for myself'
   J1SJ8YY = 'Like to walk by myself with no aim'
   J1SJ8ZZ = 'Happiness depends on others'
   J1SMWBGR= 'Minimalist Well-Being: Gratitude'
   J1SMWBPD= 'Minimalist Well-Being: Positive Disengagement'
   J1SK1   = 'SUPFRND-# Friends'
   J1SSGFA = 'Friendship Support Scale'
   J1SK2   = 'Contact with friends (freq)'
   J1SK3A  = 'Friends really care about you'
   J1SK3B  = 'Friends understand way you feel'
   J1SK3C  = 'Rely on friends for help with problem'
   J1SK3D  = 'Open up to friends about worries'
   J1SK3E  = 'Friends make too many demands on you'
   J1SK3F  = 'Friends criticize you'
   J1SK3G  = 'Friends let you down'
   J1SK3H  = 'Friends get on your nerves'
   J1SFDSPO= 'Support from Friends'
   J1SFDSNE= 'Strain from Friends'
   J1SFDSOL= 'Friendship Affectual Solidarity'
   J1SK4A  = 'SUPFRND Care about friends'
   J1SK4B  = 'SUPFRND Understand friends feeling'
   J1SK4C  = 'SUPFRND Friends rely on you serious probs'
   J1SK4D  = 'SUPFRND Friends open up to you re worries'
   J1SK4E  = 'SUPFRND Make too many demands on friend'
   J1SK4F  = 'SUPFRND Criticize friends'
   J1SK4G  = 'SUPFRND Let friends down'
   J1SK4H  = 'SUPFRND Get on friends nerves'
   J1SSUGF = 'Support Given to Friends'
   J1SSTGF = 'Strain Given to Friends'
   J1SSOGFD= 'Affectual Solidarity Given to Friend'
   J1SL1   = 'Marital status currently'
   J1SL2   = 'Number years married'
   J1SL3CY = 'First marriage - Common Era Year'
   J1SL3MO = 'First marriage - Common Era Month'
   J1SL4   = 'Rate current marriage/relationship'
   J1SL5   = 'Rate marriage/relationship ten yrs ago'
   J1SL6   = 'Rate marriage/relationship ten yrs future'
   J1SL7   = 'Rate control over marriage/relationship'
   J1SL8   = 'Rate thought/effort marriage/relationshp'
   J1SL9   = 'Relationship in trouble (12 mo)'
   J1SL10  = 'Chances eventually separate from SP'
   J1SMARRS= 'Marital Risk'
   J1SL11A = 'Disagree about money matters with SP'
   J1SL11B = 'Disagree about household tasks with SP'
   J1SL11C = 'Disagree about leisure activities w/ SP'
   J1SSPDIS= 'Spouse/Partner Disagreement'
   J1SL12  = 'Good talk with SP (freq)'
   J1SL13A = 'SP really cares about you'
   J1SL13B = 'SP understands way you feel'
   J1SL13C = 'SP appreciates you'
   J1SL13D = 'Rely SP for help with serious problem'
   J1SL13E = 'Open up to SP about worries'
   J1SL13F = 'Can relax, be yourself around SP'
   J1SL14A = 'SP makes too many demands on you'
   J1SL14B = 'SP makes you feel tense'
   J1SL14C = 'SP argues with you'
   J1SL14D = 'SP criticizes you'
   J1SL14E = 'SP lets you down'
   J1SL14F = 'SP gets on your nerves'
   J1SSPEMP= 'Support from Spouse/Partner'
   J1SSPCRI= 'Strain from Spouse/Partner'
   J1SSPSOL= 'Spouse Affectual Solidarity'
   J1SL15A = 'SUPPART Care about partner'
   J1SL15B = 'SUPPART Understand partner'
   J1SL15C = 'SUPPART Appreciate partner'
   J1SL15D = 'SUPPART Partner rely on you serious probs'
   J1SL15E = 'SUPPART Partner open up re worries'
   J1SL15F = 'SUPPART Partner relax/be self with you'
   J1SL16A = 'SUPPART Make too many demands on partner'
   J1SL16B = 'SUPPART Partner feel tense'
   J1SL16C = 'SUPPART Argue with partner'
   J1SL16D = 'SUPPART Criticize partner'
   J1SL16E = 'SUPPART Let partner down'
   J1SL16F = 'SUPPART Get on partners nerves'
   J1SSUGS = 'Support Given to Spouse Scale'
   J1SSTGS = 'Strain Given to Spouse Scale'
   J1SSOLGS= 'Affectual Solidarity Given to Spouse/partner'
   J1SL17  = 'Who does more household chores (R or SP)'
   J1SL18  = 'R does household chores (hrs/day)'
   J1SL19  = 'SP does household chores (hrs/day)'
   J1SL20  = 'How fair are household chores to R'
   J1SL21  = 'How fair are household chores to SP'
   J1SL22A = 'Make decisions with SP as a team'
   J1SL22B = 'Talk with SP makes things better'
   J1SL22C = 'Talk with SP before make plans'
   J1SL22D = 'Ask SP for advice about issues'
   J1SSPDEC= 'Spouse/Partner Decision Making'
   J1SL23  = 'Describe SP physical health currently'
   J1SL24  = 'Describe SP mental health currently'
   J1SL25  = 'SP currently working for pay'
   J1SM1   = 'Any children'
   J1SM2   = 'Rate current relationship with children'
   J1SM3   = 'Rate relatnshp w/ children ten years ago'
   J1SM4   = 'Rate reltnshp w/ children ten yrs future'
   J1SM5   = 'Rate control over relatnship w/ children'
   J1SM6   = 'Rate thought/effort reltnshp w/ children'
   J1SM7A  = 'Feel good about opportunities for child'
   J1SM7B  = 'Family life w/ children more negative'
   J1SM7C  = 'Problems with children caused shame'
   J1SM7D  = 'No resources for fun things w/ children'
   J1SM7E  = 'Do for children as much as others'
   J1SM7F  = 'Pride about what able to do for children'
   J1SPIFAM= 'Perceived Ineqaulity in Family'
   J1SN1   = 'Any family not live with you'
   J1SN2   = 'Contact with family members (freq)'
   J1SN3A  = 'Family members really care about you'
   J1SN3B  = 'Family members understand way you feel'
   J1SN3C  = 'Rely on family for help with problem'
   J1SN3D  = 'Open up to family about worries'
   J1SN3E  = 'Really care about family members'
   J1SN3F  = 'Understand way family feels'
   J1SN4A  = 'Family members make too many demands'
   J1SN4B  = 'Family members criticize you'
   J1SN4C  = 'Family members let you down'
   J1SN4D  = 'Family members get on your nerves'
   J1SN4E  = 'SUPFAM Family rely on you serious probs'
   J1SN4F  = 'SUPFAM Family open up to you re worries'
   J1SN4G  = 'SUPFAM Make too many demands on family'
   J1SN4H  = 'SUPFAM Criticize family'
   J1SN4I  = 'SUPFAM Let family down'
   J1SN4J  = 'SUPFAM Get on family nerves'
   J1SKINPO= 'Support from Family'
   J1SKINNE= 'Strain from Family'
   J1SFAMSO= 'Family Affectual Solidarity'
   J1SSUGFA= 'Support Given to Family'
   J1SSTGFA= 'Strain Given to Family Scale'
   J1SSOGFM= 'Affectual Solidarity Given to Family'
   J1SO1   = 'Religious preference choice'
   J1SO2A  = 'How religious are you'
   J1SO2B  = 'Religion important in your life'
   J1SO2C  = 'Extent believe in god/buddha'
   J1SO3A  = 'Pray/worship at home altar'
   J1SO3B  = 'Read sutra or Bible daily at home'
   J1SO3C  = 'Religious program TV and radio'
   J1SP1   = 'Biological mother still alive'
   J1SP1A  = 'Age of biological mother'
   J1SP1B  = 'Rate physical hlth of biological mother'
   J1SP1CCY= 'Death of biological mother -Common Era Year'
   J1SP1D  = 'Mother''s age at time of death'
   J1SP2   = 'Biological father still alive'
   J1SP2A  = 'Age of biological father'
   J1SP2B  = 'Rate physical hlth of biological father'
   J1SP2CCY= 'Death of biological father - Common Era Year'
   J1SP2D  = 'Father''s age at time of death'
   J1SQ1   = 'Respondent gender'
   J1SQ2AGE= 'Current age'
   J1SQ3   = 'Highest level of education completed'
   J1SQ4   = 'Own home outright, mortgage, or rent'
   J1SQ5   = 'Family size, # of people in family'
   J1SQ6A  = 'AF Chronic disease/disability (12 mo)'
   J1SQ6B  = 'AF frequent minor illnesses (12 mo)'
   J1SQ6C  = 'AF emotional problems (12 mo)'
   J1SQ6D  = 'AF alcohol/substance problems (12 mo)'
   J1SQ6E  = 'AF financial problems (12 mo)'
   J1SQ6F  = 'AF school/work problems (12 mo)'
   J1SQ6G  = 'AF difficult find/keep job (12 mo)'
   J1SQ6H  = 'AF marital/relationship problems (12 mo)'
   J1SQ6I  = 'AF legal problems (12 mo)'
   J1SQ6J  = 'AF difficult get along with oths (12 mo)'
        ;


* USER-DEFINED MISSING VALUES RECODE TO SAS SYSMIS;

/*
   IF (J1SA1 = 98 OR J1SA1 = 99) THEN J1SA1 = .;
   IF (J1SA2 = 98 OR J1SA2 = 99) THEN J1SA2 = .;
   IF (J1SA3 = 98 OR J1SA3 = 99) THEN J1SA3 = .;
   IF (J1SA4 = 98 OR J1SA4 = 99) THEN J1SA4 = .;
   IF (J1SA5 = 98 OR J1SA5 = 99) THEN J1SA5 = .;
   IF (J1SSATIS = 98.000) THEN J1SSATIS = .;
   IF (J1SSATI2 = 98.000) THEN J1SSATI2 = .;
   IF (J1SA6A = 8 OR J1SA6A = 9) THEN J1SA6A = .;
   IF (J1SA6B = 8 OR J1SA6B = 9) THEN J1SA6B = .;
   IF (J1SA6C = 8 OR J1SA6C = 9) THEN J1SA6C = .;
   IF (J1SA6D = 8 OR J1SA6D = 9) THEN J1SA6D = .;
   IF (J1SA6E = 8 OR J1SA6E = 9) THEN J1SA6E = .;
   IF (J1SAMPLI = 8.000) THEN J1SAMPLI = .;
   IF (J1SA7A = 8 OR J1SA7A = 9) THEN J1SA7A = .;
   IF (J1SA7B = 8 OR J1SA7B = 9) THEN J1SA7B = .;
   IF (J1SA7C = 8 OR J1SA7C = 9) THEN J1SA7C = .;
   IF (J1SA7D = 8 OR J1SA7D = 9) THEN J1SA7D = .;
   IF (J1SA7E = 8 OR J1SA7E = 9) THEN J1SA7E = .;
   IF (J1SA7F = 8 OR J1SA7F = 9) THEN J1SA7F = .;
   IF (J1SA7G = 8 OR J1SA7G = 9) THEN J1SA7G = .;
   IF (J1SA7H = 8 OR J1SA7H = 9) THEN J1SA7H = .;
   IF (J1SA7I = 8 OR J1SA7I = 9) THEN J1SA7I = .;
   IF (J1SA8A = 8 OR J1SA8A = 9) THEN J1SA8A = .;
   IF (J1SA8B = 8 OR J1SA8B = 9) THEN J1SA8B = .;
   IF (J1SA8C = 8 OR J1SA8C = 9) THEN J1SA8C = .;
   IF (J1SA8D = 8 OR J1SA8D = 9) THEN J1SA8D = .;
   IF (J1SA8E = 8 OR J1SA8E = 9) THEN J1SA8E = .;
   IF (J1SA8F = 8 OR J1SA8F = 9) THEN J1SA8F = .;
   IF (J1SA8G = 8 OR J1SA8G = 9) THEN J1SA8G = .;
   IF (J1SA8H = 8 OR J1SA8H = 9) THEN J1SA8H = .;
   IF (J1SA8I = 8 OR J1SA8I = 9) THEN J1SA8I = .;
   IF (J1SA8J = 8 OR J1SA8J = 9) THEN J1SA8J = .;
   IF (J1SA8K = 8 OR J1SA8K = 9) THEN J1SA8K = .;
   IF (J1SA8L = 8 OR J1SA8L = 9) THEN J1SA8L = .;
   IF (J1SA8M = 8 OR J1SA8M = 9) THEN J1SA8M = .;
   IF (J1SA8N = 8 OR J1SA8N = 9) THEN J1SA8N = .;
   IF (J1SA8O = 8 OR J1SA8O = 9) THEN J1SA8O = .;
   IF (J1SA8P = 8 OR J1SA8P = 9) THEN J1SA8P = .;
   IF (J1SA8Q = 8 OR J1SA8Q = 9) THEN J1SA8Q = .;
   IF (J1SA8R = 8 OR J1SA8R = 9) THEN J1SA8R = .;
   IF (J1SA8S = 8 OR J1SA8S = 9) THEN J1SA8S = .;
   IF (J1SA8T = 8 OR J1SA8T = 9) THEN J1SA8T = .;
   IF (J1SA8U = 8 OR J1SA8U = 9) THEN J1SA8U = .;
   IF (J1SA8V = 8 OR J1SA8V = 9) THEN J1SA8V = .;
   IF (J1SA8W = 8 OR J1SA8W = 9) THEN J1SA8W = .;
   IF (J1SA8X = 8 OR J1SA8X = 9) THEN J1SA8X = .;
   IF (J1SA8Y = 8 OR J1SA8Y = 9) THEN J1SA8Y = .;
   IF (J1SA8Z = 8 OR J1SA8Z = 9) THEN J1SA8Z = .;
   IF (J1SA8AA = 8 OR J1SA8AA = 9) THEN J1SA8AA = .;
   IF (J1SA8BB = 8 OR J1SA8BB = 9) THEN J1SA8BB = .;
   IF (J1SA8CC = 8 OR J1SA8CC = 9) THEN J1SA8CC = .;
   IF (J1SA8DD = 8 OR J1SA8DD = 9) THEN J1SA8DD = .;
   IF (J1SA8EE = 8 OR J1SA8EE = 9) THEN J1SA8EE = .;
   IF (J1SCHRON = 98) THEN J1SCHRON = .;
   IF (J1SCHROX = 8) THEN J1SCHROX = .;
   IF (J1SA9A = 8 OR J1SA9A = 9) THEN J1SA9A = .;
   IF (J1SA9AY = 8 OR J1SA9AY = 9) THEN J1SA9AY = .;
   IF (J1SA9B = 8 OR J1SA9B = 9) THEN J1SA9B = .;
   IF (J1SA9BY = 8 OR J1SA9BY = 9) THEN J1SA9BY = .;
   IF (J1SA9C = 8 OR J1SA9C = 9) THEN J1SA9C = .;
   IF (J1SA9CY = 8 OR J1SA9CY = 9) THEN J1SA9CY = .;
   IF (J1SA9D = 8 OR J1SA9D = 9) THEN J1SA9D = .;
   IF (J1SA9DY = 8 OR J1SA9DY = 9) THEN J1SA9DY = .;
   IF (J1SA9E = 8 OR J1SA9E = 9) THEN J1SA9E = .;
   IF (J1SA9EY = 8 OR J1SA9EY = 9) THEN J1SA9EY = .;
   IF (J1SA9F = 8 OR J1SA9F = 9) THEN J1SA9F = .;
   IF (J1SA9FY = 8 OR J1SA9FY = 9) THEN J1SA9FY = .;
   IF (J1SA9G = 8 OR J1SA9G = 9) THEN J1SA9G = .;
   IF (J1SA9GY = 8 OR J1SA9GY = 9) THEN J1SA9GY = .;
   IF (J1SA9H = 8 OR J1SA9H = 9) THEN J1SA9H = .;
   IF (J1SA9HY = 8 OR J1SA9HY = 9) THEN J1SA9HY = .;
   IF (J1SA9I = 8 OR J1SA9I = 9) THEN J1SA9I = .;
   IF (J1SA9IY = 8 OR J1SA9IY = 9) THEN J1SA9IY = .;
   IF (J1SA9J = 8 OR J1SA9J = 9) THEN J1SA9J = .;
   IF (J1SA9JY = 8 OR J1SA9JY = 9) THEN J1SA9JY = .;
   IF (J1SA9K = 8 OR J1SA9K = 9) THEN J1SA9K = .;
   IF (J1SA9KY = 8 OR J1SA9KY = 9) THEN J1SA9KY = .;
   IF (J1SA9L = 8 OR J1SA9L = 9) THEN J1SA9L = .;
   IF (J1SA9LY = 8 OR J1SA9LY = 9) THEN J1SA9LY = .;
   IF (J1SRXMED = 98) THEN J1SRXMED = .;
   IF (J1SRXMEX = 8) THEN J1SRXMEX = .;
   IF (J1SA10A = 8 OR J1SA10A = 9) THEN J1SA10A = .;
   IF (J1SA10B = 8 OR J1SA10B = 9) THEN J1SA10B = .;
   IF (J1SA10C = 8 OR J1SA10C = 9) THEN J1SA10C = .;
   IF (J1SA10D = 8 OR J1SA10D = 9) THEN J1SA10D = .;
   IF (J1SA10E = 8 OR J1SA10E = 9) THEN J1SA10E = .;
   IF (J1SA10F = 8 OR J1SA10F = 9) THEN J1SA10F = .;
   IF (J1SA10G = 8 OR J1SA10G = 9) THEN J1SA10G = .;
   IF (J1SA10H = 8 OR J1SA10H = 9) THEN J1SA10H = .;
   IF (J1SA10I = 8 OR J1SA10I = 9) THEN J1SA10I = .;
   IF (J1SA10J = 8 OR J1SA10J = 9) THEN J1SA10J = .;
   IF (J1SBADL1 = 8.0) THEN J1SBADL1 = .;
   IF (J1SBADL2 = 8.000) THEN J1SBADL2 = .;
   IF (J1SIADL = 8.000) THEN J1SIADL = .;
   IF (J1SA11A = 8 OR J1SA11A = 9) THEN J1SA11A = .;
   IF (J1SA11B = 8 OR J1SA11B = 9) THEN J1SA11B = .;
   IF (J1SA11C = 8 OR J1SA11C = 9) THEN J1SA11C = .;
   IF (J1SA11D = 8 OR J1SA11D = 9) THEN J1SA11D = .;
   IF (J1SDYSPN = 8) THEN J1SDYSPN = .;
   IF (J1SA12 = 8 OR J1SA12 = 9) THEN J1SA12 = .;
   IF (J1SA13CY = 9998 OR J1SA13CY = 9999) THEN J1SA13CY = .;
   IF (J1SA13CM = 98 OR J1SA13CM = 99) THEN J1SA13CM = .;
   IF (J1SA14 = 8 OR J1SA14 = 9) THEN J1SA14 = .;
   IF (J1SA15 = 998 OR J1SA15 = 999) THEN J1SA15 = .;
   IF (J1SA16 = 998 OR J1SA16 = 999) THEN J1SA16 = .;
   IF (J1SA17A = 8 OR J1SA17A = 9) THEN J1SA17A = .;
   IF (J1SA17AN = 98 OR J1SA17AN = 99) THEN J1SA17AN = .;
   IF (J1SA17B = 8 OR J1SA17B = 9) THEN J1SA17B = .;
   IF (J1SA17BN = 98 OR J1SA17BN = 99) THEN J1SA17BN = .;
   IF (J1SA17C = 8 OR J1SA17C = 9) THEN J1SA17C = .;
   IF (J1SA17CN = 98 OR J1SA17CN = 99) THEN J1SA17CN = .;
   IF (J1SA17D = 8 OR J1SA17D = 9) THEN J1SA17D = .;
   IF (J1SA17DN = 98 OR J1SA17DN = 99) THEN J1SA17DN = .;
   IF (J1SA17E = 8 OR J1SA17E = 9) THEN J1SA17E = .;
   IF (J1SA17EN = 98 OR J1SA17EN = 99) THEN J1SA17EN = .;
   IF (J1SUSEMD = 98) THEN J1SUSEMD = .;
   IF (J1SA18A = 8 OR J1SA18A = 9) THEN J1SA18A = .;
   IF (J1SA18B = 8 OR J1SA18B = 9) THEN J1SA18B = .;
   IF (J1SA18C = 8 OR J1SA18C = 9) THEN J1SA18C = .;
   IF (J1SA18D = 8 OR J1SA18D = 9) THEN J1SA18D = .;
   IF (J1SA18E = 8 OR J1SA18E = 9) THEN J1SA18E = .;
   IF (J1SA18F = 8 OR J1SA18F = 9) THEN J1SA18F = .;
   IF (J1SA19 = 8 OR J1SA19 = 9) THEN J1SA19 = .;
   IF (J1SA20A = 8 OR J1SA20A = 9) THEN J1SA20A = .;
   IF (J1SA20B = 8 OR J1SA20B = 9) THEN J1SA20B = .;
   IF (J1SA20C = 8 OR J1SA20C = 9) THEN J1SA20C = .;
   IF (J1SA20D = 8 OR J1SA20D = 9) THEN J1SA20D = .;
   IF (J1SA20E = 8 OR J1SA20E = 9) THEN J1SA20E = .;
   IF (J1SA20F = 8 OR J1SA20F = 9) THEN J1SA20F = .;
   IF (J1SA20G = 8 OR J1SA20G = 9) THEN J1SA20G = .;
   IF (J1SB1 = 98 OR J1SB1 = 99) THEN J1SB1 = .;
   IF (J1SB2 = 8 OR J1SB2 = 9) THEN J1SB2 = .;
   IF (J1SB3 = 98 OR J1SB3 = 99) THEN J1SB3 = .;
   IF (J1SB4 = 8 OR J1SB4 = 9) THEN J1SB4 = .;
   IF (J1SB5 = 998 OR J1SB5 = 999) THEN J1SB5 = .;
   IF (J1SC1 = 8 OR J1SC1 = 9) THEN J1SC1 = .;
   IF (J1SC2 = 98 OR J1SC2 = 99) THEN J1SC2 = .;
   IF (J1SC3 = 98 OR J1SC3 = 99) THEN J1SC3 = .;
   IF (J1SC4 = 8 OR J1SC4 = 9) THEN J1SC4 = .;
   IF (J1SC5 = 8 OR J1SC5 = 9) THEN J1SC5 = .;
   IF (J1SC6 = 8 OR J1SC6 = 9) THEN J1SC6 = .;
   IF (J1SC7 = 8 OR J1SC7 = 9) THEN J1SC7 = .;
   IF (J1SD1A = 8 OR J1SD1A = 9) THEN J1SD1A = .;
   IF (J1SD1B = 8 OR J1SD1B = 9) THEN J1SD1B = .;
   IF (J1SD1C = 8 OR J1SD1C = 9) THEN J1SD1C = .;
   IF (J1SD1D = 8 OR J1SD1D = 9) THEN J1SD1D = .;
   IF (J1SD1E = 8 OR J1SD1E = 9) THEN J1SD1E = .;
   IF (J1SD1F = 8 OR J1SD1F = 9) THEN J1SD1F = .;
   IF (J1SD1G = 8 OR J1SD1G = 9) THEN J1SD1G = .;
   IF (J1SD1H = 8 OR J1SD1H = 9) THEN J1SD1H = .;
   IF (J1SD1I = 8 OR J1SD1I = 9) THEN J1SD1I = .;
   IF (J1SD1J = 8 OR J1SD1J = 9) THEN J1SD1J = .;
   IF (J1SD1K = 8 OR J1SD1K = 9) THEN J1SD1K = .;
   IF (J1SD1L = 8 OR J1SD1L = 9) THEN J1SD1L = .;
   IF (J1SD1M = 8 OR J1SD1M = 9) THEN J1SD1M = .;
   IF (J1SD1N = 8 OR J1SD1N = 9) THEN J1SD1N = .;
   IF (J1SNEGAF = 8.000) THEN J1SNEGAF = .;
   IF (J1SNEGPA = 8.000) THEN J1SNEGPA = .;
   IF (J1SD2A = 8 OR J1SD2A = 9) THEN J1SD2A = .;
   IF (J1SD2B = 8 OR J1SD2B = 9) THEN J1SD2B = .;
   IF (J1SD2C = 8 OR J1SD2C = 9) THEN J1SD2C = .;
   IF (J1SD2D = 8 OR J1SD2D = 9) THEN J1SD2D = .;
   IF (J1SD2E = 8 OR J1SD2E = 9) THEN J1SD2E = .;
   IF (J1SD2F = 8 OR J1SD2F = 9) THEN J1SD2F = .;
   IF (J1SD2G = 8 OR J1SD2G = 9) THEN J1SD2G = .;
   IF (J1SD2H = 8 OR J1SD2H = 9) THEN J1SD2H = .;
   IF (J1SD2I = 8 OR J1SD2I = 9) THEN J1SD2I = .;
   IF (J1SD2J = 8 OR J1SD2J = 9) THEN J1SD2J = .;
   IF (J1SD2K = 8 OR J1SD2K = 9) THEN J1SD2K = .;
   IF (J1SD2L = 8 OR J1SD2L = 9) THEN J1SD2L = .;
   IF (J1SD2M = 8 OR J1SD2M = 9) THEN J1SD2M = .;
   IF (J1SPOSAF = 8.000) THEN J1SPOSAF = .;
   IF (J1SPOSPA = 8.000) THEN J1SPOSPA = .;
   IF (J1SD3A = 8 OR J1SD3A = 9) THEN J1SD3A = .;
   IF (J1SD3B = 8 OR J1SD3B = 9) THEN J1SD3B = .;
   IF (J1SD3C = 8 OR J1SD3C = 9) THEN J1SD3C = .;
   IF (J1SD3D = 8 OR J1SD3D = 9) THEN J1SD3D = .;
   IF (J1SD3E = 8 OR J1SD3E = 9) THEN J1SD3E = .;
   IF (J1SD3F = 8 OR J1SD3F = 9) THEN J1SD3F = .;
   IF (J1SD3G = 8 OR J1SD3G = 9) THEN J1SD3G = .;
   IF (J1SD3H = 8 OR J1SD3H = 9) THEN J1SD3H = .;
   IF (J1SD3I = 8 OR J1SD3I = 9) THEN J1SD3I = .;
   IF (J1SD3J = 8 OR J1SD3J = 9) THEN J1SD3J = .;
   IF (J1SPS_PS = 98.000) THEN J1SPS_PS = .;
   IF (J1SD4A = 8 OR J1SD4A = 9) THEN J1SD4A = .;
   IF (J1SD4B = 8 OR J1SD4B = 9) THEN J1SD4B = .;
   IF (J1SD4C = 8 OR J1SD4C = 9) THEN J1SD4C = .;
   IF (J1SD4D = 8 OR J1SD4D = 9) THEN J1SD4D = .;
   IF (J1SD4E = 8 OR J1SD4E = 9) THEN J1SD4E = .;
   IF (J1SD4F = 8 OR J1SD4F = 9) THEN J1SD4F = .;
   IF (J1SD4G = 8 OR J1SD4G = 9) THEN J1SD4G = .;
   IF (J1SD4H = 8 OR J1SD4H = 9) THEN J1SD4H = .;
   IF (J1SD4I = 8 OR J1SD4I = 9) THEN J1SD4I = .;
   IF (J1SSA_SA = 8.000) THEN J1SSA_SA = .;
   IF (J1SD5A = 8 OR J1SD5A = 9) THEN J1SD5A = .;
   IF (J1SD5B = 8 OR J1SD5B = 9) THEN J1SD5B = .;
   IF (J1SD5C = 8 OR J1SD5C = 9) THEN J1SD5C = .;
   IF (J1SD5D = 8 OR J1SD5D = 9) THEN J1SD5D = .;
   IF (J1SD5E = 8 OR J1SD5E = 9) THEN J1SD5E = .;
   IF (J1SD5F = 8 OR J1SD5F = 9) THEN J1SD5F = .;
   IF (J1SD5G = 8 OR J1SD5G = 9) THEN J1SD5G = .;
   IF (J1SD5H = 8 OR J1SD5H = 9) THEN J1SD5H = .;
   IF (J1SD5I = 8 OR J1SD5I = 9) THEN J1SD5I = .;
   IF (J1SD5J = 8 OR J1SD5J = 9) THEN J1SD5J = .;
   IF (J1SD5K = 8 OR J1SD5K = 9) THEN J1SD5K = .;
   IF (J1SD5L = 8 OR J1SD5L = 9) THEN J1SD5L = .;
   IF (J1SD5M = 8 OR J1SD5M = 9) THEN J1SD5M = .;
   IF (J1SD5N = 8 OR J1SD5N = 9) THEN J1SD5N = .;
   IF (J1SD5O = 8 OR J1SD5O = 9) THEN J1SD5O = .;
   IF (J1SD5P = 8 OR J1SD5P = 9) THEN J1SD5P = .;
   IF (J1SD5Q = 8 OR J1SD5Q = 9) THEN J1SD5Q = .;
   IF (J1SD5R = 8 OR J1SD5R = 9) THEN J1SD5R = .;
   IF (J1SD5S = 8 OR J1SD5S = 9) THEN J1SD5S = .;
   IF (J1SD5T = 8 OR J1SD5T = 9) THEN J1SD5T = .;
   IF (J1SD5U = 8 OR J1SD5U = 9) THEN J1SD5U = .;
   IF (J1SD5V = 8 OR J1SD5V = 9) THEN J1SD5V = .;
   IF (J1SAE_AI = 98.000) THEN J1SAE_AI = .;
   IF (J1SAE_AO = 98.000) THEN J1SAE_AO = .;
   IF (J1SAE_AC = 98.000) THEN J1SAE_AC = .;
   IF (J1SAE_AA = 8.0) THEN J1SAE_AA = .;
   IF (J1SE1 = 8 OR J1SE1 = 9) THEN J1SE1 = .;
   IF (J1SE2 = 98 OR J1SE2 = 99) THEN J1SE2 = .;
   IF (J1SE3 = 8 OR J1SE3 = 9) THEN J1SE3 = .;
   IF (J1SE4 = 8 OR J1SE4 = 9) THEN J1SE4 = .;
   IF (J1SE5 = 98 OR J1SE5 = 99) THEN J1SE5 = .;
   IF (J1SE6 = 8 OR J1SE6 = 9) THEN J1SE6 = .;
   IF (J1SE7 = 8 OR J1SE7 = 9) THEN J1SE7 = .;
   IF (J1SE8 = 8 OR J1SE8 = 9) THEN J1SE8 = .;
   IF (J1SE9 = 8 OR J1SE9 = 9) THEN J1SE9 = .;
   IF (J1SE10 = 8 OR J1SE10 = 9) THEN J1SE10 = .;
   IF (J1SE11 = 8 OR J1SE11 = 9) THEN J1SE11 = .;
   IF (J1SE12 = 98 OR J1SE12 = 99) THEN J1SE12 = .;
   IF (J1SE13 = 98 OR J1SE13 = 99) THEN J1SE13 = .;
   IF (J1SE14A = 8 OR J1SE14A = 9) THEN J1SE14A = .;
   IF (J1SE14B = 8 OR J1SE14B = 9) THEN J1SE14B = .;
   IF (J1SE14C = 8 OR J1SE14C = 9) THEN J1SE14C = .;
   IF (J1SE14D = 8 OR J1SE14D = 9) THEN J1SE14D = .;
   IF (J1SE14E = 8 OR J1SE14E = 9) THEN J1SE14E = .;
   IF (J1SE14F = 8 OR J1SE14F = 9) THEN J1SE14F = .;
   IF (J1SE14G = 8 OR J1SE14G = 9) THEN J1SE14G = .;
   IF (J1SE14H = 8 OR J1SE14H = 9) THEN J1SE14H = .;
   IF (J1SE14I = 8 OR J1SE14I = 9) THEN J1SE14I = .;
   IF (J1SE14J = 8 OR J1SE14J = 9) THEN J1SE14J = .;
   IF (J1SE14K = 8 OR J1SE14K = 9) THEN J1SE14K = .;
   IF (J1SE14L = 8 OR J1SE14L = 9) THEN J1SE14L = .;
   IF (J1SE14M = 8 OR J1SE14M = 9) THEN J1SE14M = .;
   IF (J1SE14N = 8 OR J1SE14N = 9) THEN J1SE14N = .;
   IF (J1SE14O = 8 OR J1SE14O = 9) THEN J1SE14O = .;
   IF (J1SE14P = 8 OR J1SE14P = 9) THEN J1SE14P = .;
   IF (J1SPOSWF = 98.000) THEN J1SPOSWF = .;
   IF (J1SNEGWF = 98) THEN J1SNEGWF = .;
   IF (J1SPOSFW = 98.000) THEN J1SPOSFW = .;
   IF (J1SNEGFW = 98.000) THEN J1SNEGFW = .;
   IF (J1SE15A = 8 OR J1SE15A = 9) THEN J1SE15A = .;
   IF (J1SE15B = 8 OR J1SE15B = 9) THEN J1SE15B = .;
   IF (J1SE15C = 8 OR J1SE15C = 9) THEN J1SE15C = .;
   IF (J1SE15D = 8 OR J1SE15D = 9) THEN J1SE15D = .;
   IF (J1SE15E = 8 OR J1SE15E = 9) THEN J1SE15E = .;
   IF (J1SE15F = 8 OR J1SE15F = 9) THEN J1SE15F = .;
   IF (J1SE15G = 8 OR J1SE15G = 9) THEN J1SE15G = .;
   IF (J1SE15H = 8 OR J1SE15H = 9) THEN J1SE15H = .;
   IF (J1SE15I = 8 OR J1SE15I = 9) THEN J1SE15I = .;
   IF (J1SE15J = 8 OR J1SE15J = 9) THEN J1SE15J = .;
   IF (J1SE15K = 8 OR J1SE15K = 9) THEN J1SE15K = .;
   IF (J1SE16A = 8 OR J1SE16A = 9) THEN J1SE16A = .;
   IF (J1SE16B = 8 OR J1SE16B = 9) THEN J1SE16B = .;
   IF (J1SE16C = 8 OR J1SE16C = 9) THEN J1SE16C = .;
   IF (J1SE16D = 8 OR J1SE16D = 9) THEN J1SE16D = .;
   IF (J1SJCSD = 98.0 OR J1SJCSD = 99.0) THEN J1SJCSD = .;
   IF (J1SJCDA = 98.0 OR J1SJCDA = 99.0) THEN J1SJCDA = .;
   IF (J1SJCDS = 98.00 OR J1SJCDS = 99.00) THEN J1SJCDS = .;
   IF (J1SE17A = 6 OR J1SE17A = 8 OR J1SE17A = 9) THEN J1SE17A = .;
   IF (J1SE17B = 6 OR J1SE17B = 8 OR J1SE17B = 9) THEN J1SE17B = .;
   IF (J1SE17C = 6 OR J1SE17C = 8 OR J1SE17C = 9) THEN J1SE17C = .;
   IF (J1SE17D = 6 OR J1SE17D = 8 OR J1SE17D = 9) THEN J1SE17D = .;
   IF (J1SE17E = 6 OR J1SE17E = 8 OR J1SE17E = 9) THEN J1SE17E = .;
   IF (J1SJCCS = 98 OR J1SJCCS = 99) THEN J1SJCCS = .;
   IF (J1SJCSS = 99.0 OR J1SJCSS = 98.0) THEN J1SJCSS = .;
   IF (J1SE18A = 8 OR J1SE18A = 9) THEN J1SE18A = .;
   IF (J1SE18B = 8 OR J1SE18B = 9) THEN J1SE18B = .;
   IF (J1SE18C = 8 OR J1SE18C = 9) THEN J1SE18C = .;
   IF (J1SE18D = 8 OR J1SE18D = 9) THEN J1SE18D = .;
   IF (J1SE18E = 8 OR J1SE18E = 9) THEN J1SE18E = .;
   IF (J1SE18F = 8 OR J1SE18F = 9) THEN J1SE18F = .;
   IF (J1SPIWOR = 8.000 OR J1SPIWOR = 9.000) THEN J1SPIWOR = .;
   IF (J1SE19 = 98 OR J1SE19 = 99) THEN J1SE19 = .;
   IF (J1SE20 = 98 OR J1SE20 = 99) THEN J1SE20 = .;
   IF (J1SE21 = 98 OR J1SE21 = 99) THEN J1SE21 = .;
   IF (J1SF1 = 98 OR J1SF1 = 99) THEN J1SF1 = .;
   IF (J1SF2 = 98 OR J1SF2 = 99) THEN J1SF2 = .;
   IF (J1SF3 = 98 OR J1SF3 = 99) THEN J1SF3 = .;
   IF (J1SF4 = 98 OR J1SF4 = 99) THEN J1SF4 = .;
   IF (J1SF5 = 98 OR J1SF5 = 99) THEN J1SF5 = .;
   IF (J1SF6 = 8 OR J1SF6 = 9) THEN J1SF6 = .;
   IF (J1SG1A = 8 OR J1SG1A = 9) THEN J1SG1A = .;
   IF (J1SG1B = 8 OR J1SG1B = 9) THEN J1SG1B = .;
   IF (J1SG1C = 8 OR J1SG1C = 9) THEN J1SG1C = .;
   IF (J1SG1D = 8 OR J1SG1D = 9) THEN J1SG1D = .;
   IF (J1SG1E = 8 OR J1SG1E = 9) THEN J1SG1E = .;
   IF (J1SG1F = 8 OR J1SG1F = 9) THEN J1SG1F = .;
   IF (J1SG1G = 8 OR J1SG1G = 9) THEN J1SG1G = .;
   IF (J1SG1H = 8 OR J1SG1H = 9) THEN J1SG1H = .;
   IF (J1SG1I = 8 OR J1SG1I = 9) THEN J1SG1I = .;
   IF (J1SG1J = 8 OR J1SG1J = 9) THEN J1SG1J = .;
   IF (J1SG1K = 8 OR J1SG1K = 9) THEN J1SG1K = .;
   IF (J1SG1L = 8 OR J1SG1L = 9) THEN J1SG1L = .;
   IF (J1SG1M = 8 OR J1SG1M = 9) THEN J1SG1M = .;
   IF (J1SG1N = 8 OR J1SG1N = 9) THEN J1SG1N = .;
   IF (J1SG1O = 8 OR J1SG1O = 9) THEN J1SG1O = .;
   IF (J1SG1P = 8 OR J1SG1P = 9) THEN J1SG1P = .;
   IF (J1SG1Q = 8 OR J1SG1Q = 9) THEN J1SG1Q = .;
   IF (J1SG1R = 8 OR J1SG1R = 9) THEN J1SG1R = .;
   IF (J1SG1S = 8 OR J1SG1S = 9) THEN J1SG1S = .;
   IF (J1SMASTE = 8.000) THEN J1SMASTE = .;
   IF (J1SCONST = 8.000) THEN J1SCONST = .;
   IF (J1SCTRL = 8.000) THEN J1SCTRL = .;
   IF (J1SESTEE = 98.000) THEN J1SESTEE = .;
   IF (J1SG2A = 8 OR J1SG2A = 9) THEN J1SG2A = .;
   IF (J1SG2B = 8 OR J1SG2B = 9) THEN J1SG2B = .;
   IF (J1SG2C = 8 OR J1SG2C = 9) THEN J1SG2C = .;
   IF (J1SG2D = 8 OR J1SG2D = 9) THEN J1SG2D = .;
   IF (J1SG2E = 8 OR J1SG2E = 9) THEN J1SG2E = .;
   IF (J1SG2F = 8 OR J1SG2F = 9) THEN J1SG2F = .;
   IF (J1SOPTIM = 98.0) THEN J1SOPTIM = .;
   IF (J1SPESSI = 98.0) THEN J1SPESSI = .;
   IF (J1SORIEN = 98.0) THEN J1SORIEN = .;
   IF (J1SG3A = 8 OR J1SG3A = 9) THEN J1SG3A = .;
   IF (J1SG3B = 8 OR J1SG3B = 9) THEN J1SG3B = .;
   IF (J1SG3C = 8 OR J1SG3C = 9) THEN J1SG3C = .;
   IF (J1SG3D = 8 OR J1SG3D = 9) THEN J1SG3D = .;
   IF (J1SG3E = 8 OR J1SG3E = 9) THEN J1SG3E = .;
   IF (J1SG3F = 8 OR J1SG3F = 9) THEN J1SG3F = .;
   IF (J1SG3G = 8 OR J1SG3G = 9) THEN J1SG3G = .;
   IF (J1SG3H = 8 OR J1SG3H = 9) THEN J1SG3H = .;
   IF (J1SG3I = 8 OR J1SG3I = 9) THEN J1SG3I = .;
   IF (J1SG3J = 8 OR J1SG3J = 9) THEN J1SG3J = .;
   IF (J1SG3K = 8 OR J1SG3K = 9) THEN J1SG3K = .;
   IF (J1SG3L = 8 OR J1SG3L = 9) THEN J1SG3L = .;
   IF (J1SG3M = 8 OR J1SG3M = 9) THEN J1SG3M = .;
   IF (J1SG3N = 8 OR J1SG3N = 9) THEN J1SG3N = .;
   IF (J1SG3O = 8 OR J1SG3O = 9) THEN J1SG3O = .;
   IF (J1SG3P = 8 OR J1SG3P = 9) THEN J1SG3P = .;
   IF (J1SG3Q = 8 OR J1SG3Q = 9) THEN J1SG3Q = .;
   IF (J1SG3R = 8 OR J1SG3R = 9) THEN J1SG3R = .;
   IF (J1SG3S = 8 OR J1SG3S = 9) THEN J1SG3S = .;
   IF (J1SG3T = 8 OR J1SG3T = 9) THEN J1SG3T = .;
   IF (J1SPERSI = 8.000) THEN J1SPERSI = .;
   IF (J1SREAPP = 8.000) THEN J1SREAPP = .;
   IF (J1SCHANG = 8.000) THEN J1SCHANG = .;
   IF (J1SSPCTR = 8.000) THEN J1SSPCTR = .;
   IF (J1SCPCTR = 8.000) THEN J1SCPCTR = .;
   IF (J1SCSCAG = 8.000) THEN J1SCSCAG = .;
   IF (J1SSUFFI = 8.0) THEN J1SSUFFI = .;
   IF (J1SG4A = 8 OR J1SG4A = 9) THEN J1SG4A = .;
   IF (J1SG4B = 8 OR J1SG4B = 9) THEN J1SG4B = .;
   IF (J1SG4C = 8 OR J1SG4C = 9) THEN J1SG4C = .;
   IF (J1SG4D = 8 OR J1SG4D = 9) THEN J1SG4D = .;
   IF (J1SG4E = 8 OR J1SG4E = 9) THEN J1SG4E = .;
   IF (J1SG4F = 8 OR J1SG4F = 9) THEN J1SG4F = .;
   IF (J1SG4G = 8 OR J1SG4G = 9) THEN J1SG4G = .;
   IF (J1SG4H = 8 OR J1SG4H = 9) THEN J1SG4H = .;
   IF (J1SG4I = 8 OR J1SG4I = 9) THEN J1SG4I = .;
   IF (J1SG4J = 8 OR J1SG4J = 9) THEN J1SG4J = .;
   IF (J1SG4K = 8 OR J1SG4K = 9) THEN J1SG4K = .;
   IF (J1SG4L = 8 OR J1SG4L = 9) THEN J1SG4L = .;
   IF (J1SG4M = 8 OR J1SG4M = 9) THEN J1SG4M = .;
   IF (J1SG4N = 8 OR J1SG4N = 9) THEN J1SG4N = .;
   IF (J1SG4O = 8 OR J1SG4O = 9) THEN J1SG4O = .;
   IF (J1SG4P = 8 OR J1SG4P = 9) THEN J1SG4P = .;
   IF (J1SG4Q = 8 OR J1SG4Q = 9) THEN J1SG4Q = .;
   IF (J1SG4R = 8 OR J1SG4R = 9) THEN J1SG4R = .;
   IF (J1SG4S = 8 OR J1SG4S = 9) THEN J1SG4S = .;
   IF (J1SG4T = 8 OR J1SG4T = 9) THEN J1SG4T = .;
   IF (J1SG4U = 8 OR J1SG4U = 9) THEN J1SG4U = .;
   IF (J1SG4V = 8 OR J1SG4V = 9) THEN J1SG4V = .;
   IF (J1SINTER = 8.000) THEN J1SINTER = .;
   IF (J1SINDEP = 8.000) THEN J1SINDEP = .;
   IF (J1SSC_IT = 8.000) THEN J1SSC_IT = .;
   IF (J1SSC_ID = 8.000) THEN J1SSC_ID = .;
   IF (J1SJINTR = 8.000) THEN J1SJINTR = .;
   IF (J1SJINDP = 8.000) THEN J1SJINDP = .;
   IF (J1SG5A = 8 OR J1SG5A = 9) THEN J1SG5A = .;
   IF (J1SG5B = 8 OR J1SG5B = 9) THEN J1SG5B = .;
   IF (J1SG5C = 8 OR J1SG5C = 9) THEN J1SG5C = .;
   IF (J1SG5D = 8 OR J1SG5D = 9) THEN J1SG5D = .;
   IF (J1SG5E = 8 OR J1SG5E = 9) THEN J1SG5E = .;
   IF (J1SG5F = 8 OR J1SG5F = 9) THEN J1SG5F = .;
   IF (J1SG5G = 8 OR J1SG5G = 9) THEN J1SG5G = .;
   IF (J1SG5H = 8 OR J1SG5H = 9) THEN J1SG5H = .;
   IF (J1SG5I = 8 OR J1SG5I = 9) THEN J1SG5I = .;
   IF (J1SG5J = 8 OR J1SG5J = 9) THEN J1SG5J = .;
   IF (J1SSYMP = 8.000) THEN J1SSYMP = .;
   IF (J1SADJ = 8.00) THEN J1SADJ = .;
   IF (J1SG6A = 8 OR J1SG6A = 9) THEN J1SG6A = .;
   IF (J1SG6B = 8 OR J1SG6B = 9) THEN J1SG6B = .;
   IF (J1SG6C = 8 OR J1SG6C = 9) THEN J1SG6C = .;
   IF (J1SG6D = 8 OR J1SG6D = 9) THEN J1SG6D = .;
   IF (J1SG6E = 8 OR J1SG6E = 9) THEN J1SG6E = .;
   IF (J1SG6F = 8 OR J1SG6F = 9) THEN J1SG6F = .;
   IF (J1SG6G = 8 OR J1SG6G = 9) THEN J1SG6G = .;
   IF (J1SG6H = 8 OR J1SG6H = 9) THEN J1SG6H = .;
   IF (J1SG6I = 8 OR J1SG6I = 9) THEN J1SG6I = .;
   IF (J1SG6J = 8 OR J1SG6J = 9) THEN J1SG6J = .;
   IF (J1SG6K = 8 OR J1SG6K = 9) THEN J1SG6K = .;
   IF (J1SG6L = 8 OR J1SG6L = 9) THEN J1SG6L = .;
   IF (J1SG6M = 8 OR J1SG6M = 9) THEN J1SG6M = .;
   IF (J1SG6N = 8 OR J1SG6N = 9) THEN J1SG6N = .;
   IF (J1SG6O = 8 OR J1SG6O = 9) THEN J1SG6O = .;
   IF (J1SG6P = 8 OR J1SG6P = 9) THEN J1SG6P = .;
   IF (J1SG6Q = 8 OR J1SG6Q = 9) THEN J1SG6Q = .;
   IF (J1SG6R = 8 OR J1SG6R = 9) THEN J1SG6R = .;
   IF (J1SG6S = 8 OR J1SG6S = 9) THEN J1SG6S = .;
   IF (J1SG6T = 8 OR J1SG6T = 9) THEN J1SG6T = .;
   IF (J1SG6U = 8 OR J1SG6U = 9) THEN J1SG6U = .;
   IF (J1SG6V = 8 OR J1SG6V = 9) THEN J1SG6V = .;
   IF (J1SG6W = 8 OR J1SG6W = 9) THEN J1SG6W = .;
   IF (J1SG6X = 8 OR J1SG6X = 9) THEN J1SG6X = .;
   IF (J1SG6Y = 8 OR J1SG6Y = 9) THEN J1SG6Y = .;
   IF (J1SG6Z = 8 OR J1SG6Z = 9) THEN J1SG6Z = .;
   IF (J1SG6AA = 8 OR J1SG6AA = 9) THEN J1SG6AA = .;
   IF (J1SG6BB = 8 OR J1SG6BB = 9) THEN J1SG6BB = .;
   IF (J1SG6CC = 8 OR J1SG6CC = 9) THEN J1SG6CC = .;
   IF (J1SG6DD = 8 OR J1SG6DD = 9) THEN J1SG6DD = .;
   IF (J1SG6EE = 8 OR J1SG6EE = 9) THEN J1SG6EE = .;
   IF (J1SNEURO = 8.000) THEN J1SNEURO = .;
   IF (J1SEXTRA = 8.000) THEN J1SEXTRA = .;
   IF (J1SOPEN = 8.000) THEN J1SOPEN = .;
   IF (J1SCONS1 = 8.000) THEN J1SCONS1 = .;
   IF (J1SCONS2 = 8.000) THEN J1SCONS2 = .;
   IF (J1SAGREE = 8.00) THEN J1SAGREE = .;
   IF (J1SAGENC = 8.000) THEN J1SAGENC = .;
   IF (J1SG7A = 8 OR J1SG7A = 9) THEN J1SG7A = .;
   IF (J1SG7B = 8 OR J1SG7B = 9) THEN J1SG7B = .;
   IF (J1SG7C = 8 OR J1SG7C = 9) THEN J1SG7C = .;
   IF (J1SG7D = 8 OR J1SG7D = 9) THEN J1SG7D = .;
   IF (J1SG7E = 8 OR J1SG7E = 9) THEN J1SG7E = .;
   IF (J1SG7F = 8 OR J1SG7F = 9) THEN J1SG7F = .;
   IF (J1SG7G = 8 OR J1SG7G = 9) THEN J1SG7G = .;
   IF (J1SG7H = 8 OR J1SG7H = 9) THEN J1SG7H = .;
   IF (J1SG7I = 8 OR J1SG7I = 9) THEN J1SG7I = .;
   IF (J1SG7J = 8 OR J1SG7J = 9) THEN J1SG7J = .;
   IF (J1SG7K = 8 OR J1SG7K = 9) THEN J1SG7K = .;
   IF (J1SG7L = 8 OR J1SG7L = 9) THEN J1SG7L = .;
   IF (J1SG7M = 8 OR J1SG7M = 9) THEN J1SG7M = .;
   IF (J1SG7N = 8 OR J1SG7N = 9) THEN J1SG7N = .;
   IF (J1SG7O = 8 OR J1SG7O = 9) THEN J1SG7O = .;
   IF (J1SG7P = 8 OR J1SG7P = 9) THEN J1SG7P = .;
   IF (J1SG7Q = 8 OR J1SG7Q = 9) THEN J1SG7Q = .;
   IF (J1SG7R = 8 OR J1SG7R = 9) THEN J1SG7R = .;
   IF (J1SG7S = 8 OR J1SG7S = 9) THEN J1SG7S = .;
   IF (J1SSC_SC = 8.000) THEN J1SSC_SC = .;
   IF (J1SSC_CC = 8.000) THEN J1SSC_CC = .;
   IF (J1SSC_EC = 8.000) THEN J1SSC_EC = .;
   IF (J1SSC_BC = 8.000) THEN J1SSC_BC = .;
   IF (J1SH1A = 8 OR J1SH1A = 9) THEN J1SH1A = .;
   IF (J1SH1B = 8 OR J1SH1B = 9) THEN J1SH1B = .;
   IF (J1SH1C = 8 OR J1SH1C = 9) THEN J1SH1C = .;
   IF (J1SH1D = 8 OR J1SH1D = 9) THEN J1SH1D = .;
   IF (J1SH1E = 8 OR J1SH1E = 9) THEN J1SH1E = .;
   IF (J1SH1F = 8 OR J1SH1F = 9) THEN J1SH1F = .;
   IF (J1SGENER = 98.0) THEN J1SGENER = .;
   IF (J1SH2 = 98 OR J1SH2 = 99) THEN J1SH2 = .;
   IF (J1SI1 = 8 OR J1SI1 = 9) THEN J1SI1 = .;
   IF (J1SI2 = 8 OR J1SI2 = 9) THEN J1SI2 = .;
   IF (J1SI3 = 98 OR J1SI3 = 99) THEN J1SI3 = .;
   IF (J1SJ1 = 98 OR J1SJ1 = 99) THEN J1SJ1 = .;
   IF (J1SJ2 = 98 OR J1SJ2 = 99) THEN J1SJ2 = .;
   IF (J1SJ3 = 98 OR J1SJ3 = 99) THEN J1SJ3 = .;
   IF (J1SJ4 = 98 OR J1SJ4 = 99) THEN J1SJ4 = .;
   IF (J1SJ5 = 98 OR J1SJ5 = 99) THEN J1SJ5 = .;
   IF (J1SJ6 = 98 OR J1SJ6 = 99) THEN J1SJ6 = .;
   IF (J1SJ7A = 8 OR J1SJ7A = 9) THEN J1SJ7A = .;
   IF (J1SJ7B = 8 OR J1SJ7B = 9) THEN J1SJ7B = .;
   IF (J1SJ7C = 8 OR J1SJ7C = 9) THEN J1SJ7C = .;
   IF (J1SJ7D = 8 OR J1SJ7D = 9) THEN J1SJ7D = .;
   IF (J1SJ7E = 8 OR J1SJ7E = 9) THEN J1SJ7E = .;
   IF (J1SJ7F = 8 OR J1SJ7F = 9) THEN J1SJ7F = .;
   IF (J1SJ7G = 8 OR J1SJ7G = 9) THEN J1SJ7G = .;
   IF (J1SJ7H = 8 OR J1SJ7H = 9) THEN J1SJ7H = .;
   IF (J1SSW_SL = 8.00) THEN J1SSW_SL = .;
   IF (J1SSW_GR = 8.0) THEN J1SSW_GR = .;
   IF (J1SJ8A = 8 OR J1SJ8A = 9) THEN J1SJ8A = .;
   IF (J1SJ8B = 8 OR J1SJ8B = 9) THEN J1SJ8B = .;
   IF (J1SJ8C = 8 OR J1SJ8C = 9) THEN J1SJ8C = .;
   IF (J1SJ8D = 8 OR J1SJ8D = 9) THEN J1SJ8D = .;
   IF (J1SJ8E = 8 OR J1SJ8E = 9) THEN J1SJ8E = .;
   IF (J1SJ8F = 8 OR J1SJ8F = 9) THEN J1SJ8F = .;
   IF (J1SJ8G = 8 OR J1SJ8G = 9) THEN J1SJ8G = .;
   IF (J1SJ8H = 8 OR J1SJ8H = 9) THEN J1SJ8H = .;
   IF (J1SJ8I = 8 OR J1SJ8I = 9) THEN J1SJ8I = .;
   IF (J1SJ8J = 8 OR J1SJ8J = 9) THEN J1SJ8J = .;
   IF (J1SJ8K = 8 OR J1SJ8K = 9) THEN J1SJ8K = .;
   IF (J1SJ8L = 8 OR J1SJ8L = 9) THEN J1SJ8L = .;
   IF (J1SJ8M = 8 OR J1SJ8M = 9) THEN J1SJ8M = .;
   IF (J1SJ8N = 8 OR J1SJ8N = 9) THEN J1SJ8N = .;
   IF (J1SJ8O = 8 OR J1SJ8O = 9) THEN J1SJ8O = .;
   IF (J1SJ8P = 8 OR J1SJ8P = 9) THEN J1SJ8P = .;
   IF (J1SJ8Q = 8 OR J1SJ8Q = 9) THEN J1SJ8Q = .;
   IF (J1SJ8R = 8 OR J1SJ8R = 9) THEN J1SJ8R = .;
   IF (J1SJ8S = 8 OR J1SJ8S = 9) THEN J1SJ8S = .;
   IF (J1SJ8T = 8 OR J1SJ8T = 9) THEN J1SJ8T = .;
   IF (J1SJ8U = 8 OR J1SJ8U = 9) THEN J1SJ8U = .;
   IF (J1SJ8V = 8 OR J1SJ8V = 9) THEN J1SJ8V = .;
   IF (J1SJ8W = 8 OR J1SJ8W = 9) THEN J1SJ8W = .;
   IF (J1SJ8X = 8 OR J1SJ8X = 9) THEN J1SJ8X = .;
   IF (J1SJ8Y = 8 OR J1SJ8Y = 9) THEN J1SJ8Y = .;
   IF (J1SJ8Z = 8 OR J1SJ8Z = 9) THEN J1SJ8Z = .;
   IF (J1SJ8AA = 8 OR J1SJ8AA = 9) THEN J1SJ8AA = .;
   IF (J1SJ8BB = 8 OR J1SJ8BB = 9) THEN J1SJ8BB = .;
   IF (J1SJ8CC = 8 OR J1SJ8CC = 9) THEN J1SJ8CC = .;
   IF (J1SJ8DD = 8 OR J1SJ8DD = 9) THEN J1SJ8DD = .;
   IF (J1SJ8EE = 8 OR J1SJ8EE = 9) THEN J1SJ8EE = .;
   IF (J1SJ8FF = 8 OR J1SJ8FF = 9) THEN J1SJ8FF = .;
   IF (J1SJ8GG = 8 OR J1SJ8GG = 9) THEN J1SJ8GG = .;
   IF (J1SJ8HH = 8 OR J1SJ8HH = 9) THEN J1SJ8HH = .;
   IF (J1SJ8II = 8 OR J1SJ8II = 9) THEN J1SJ8II = .;
   IF (J1SJ8JJ = 8 OR J1SJ8JJ = 9) THEN J1SJ8JJ = .;
   IF (J1SJ8KK = 8 OR J1SJ8KK = 9) THEN J1SJ8KK = .;
   IF (J1SJ8LL = 8 OR J1SJ8LL = 9) THEN J1SJ8LL = .;
   IF (J1SJ8MM = 8 OR J1SJ8MM = 9) THEN J1SJ8MM = .;
   IF (J1SJ8NN = 8 OR J1SJ8NN = 9) THEN J1SJ8NN = .;
   IF (J1SJ8OO = 8 OR J1SJ8OO = 9) THEN J1SJ8OO = .;
   IF (J1SJ8PP = 8 OR J1SJ8PP = 9) THEN J1SJ8PP = .;
   IF (J1SPWBA1 = 98.0) THEN J1SPWBA1 = .;
   IF (J1SPWBE1 = 98.0) THEN J1SPWBE1 = .;
   IF (J1SPWBG1 = 98.0) THEN J1SPWBG1 = .;
   IF (J1SPWBR1 = 98.0) THEN J1SPWBR1 = .;
   IF (J1SPWBU1 = 98.0) THEN J1SPWBU1 = .;
   IF (J1SPWBS1 = 98.0) THEN J1SPWBS1 = .;
   IF (J1SPWBA2 = 98.000) THEN J1SPWBA2 = .;
   IF (J1SPWBE2 = 98.000) THEN J1SPWBE2 = .;
   IF (J1SPWBG2 = 98.000) THEN J1SPWBG2 = .;
   IF (J1SPWBR2 = 98.000) THEN J1SPWBR2 = .;
   IF (J1SPWBU2 = 98.000) THEN J1SPWBU2 = .;
   IF (J1SPWBS2 = 98.000) THEN J1SPWBS2 = .;
   IF (J1SJ8QQ = 8 OR J1SJ8QQ = 9) THEN J1SJ8QQ = .;
   IF (J1SJ8RR = 8 OR J1SJ8RR = 9) THEN J1SJ8RR = .;
   IF (J1SJ8SS = 8 OR J1SJ8SS = 9) THEN J1SJ8SS = .;
   IF (J1SJ8TT = 8 OR J1SJ8TT = 9) THEN J1SJ8TT = .;
   IF (J1SJ8UU = 8 OR J1SJ8UU = 9) THEN J1SJ8UU = .;
   IF (J1SJ8VV = 8 OR J1SJ8VV = 9) THEN J1SJ8VV = .;
   IF (J1SJ8WW = 8 OR J1SJ8WW = 9) THEN J1SJ8WW = .;
   IF (J1SJ8XX = 8 OR J1SJ8XX = 9) THEN J1SJ8XX = .;
   IF (J1SJ8YY = 8 OR J1SJ8YY = 9) THEN J1SJ8YY = .;
   IF (J1SJ8ZZ = 8 OR J1SJ8ZZ = 9) THEN J1SJ8ZZ = .;
   IF (J1SMWBGR = 98.00) THEN J1SMWBGR = .;
   IF (J1SMWBPD = 98.00) THEN J1SMWBPD = .;
   IF (J1SK1 = 8 OR J1SK1 = 9) THEN J1SK1 = .;
   IF (J1SSGFA = 8) THEN J1SSGFA = .;
   IF (J1SK2 = 8 OR J1SK2 = 9) THEN J1SK2 = .;
   IF (J1SK3A = 8 OR J1SK3A = 9) THEN J1SK3A = .;
   IF (J1SK3B = 8 OR J1SK3B = 9) THEN J1SK3B = .;
   IF (J1SK3C = 8 OR J1SK3C = 9) THEN J1SK3C = .;
   IF (J1SK3D = 8 OR J1SK3D = 9) THEN J1SK3D = .;
   IF (J1SK3E = 8 OR J1SK3E = 9) THEN J1SK3E = .;
   IF (J1SK3F = 8 OR J1SK3F = 9) THEN J1SK3F = .;
   IF (J1SK3G = 8 OR J1SK3G = 9) THEN J1SK3G = .;
   IF (J1SK3H = 8 OR J1SK3H = 9) THEN J1SK3H = .;
   IF (J1SFDSPO = 8.000) THEN J1SFDSPO = .;
   IF (J1SFDSNE = 8.000) THEN J1SFDSNE = .;
   IF (J1SFDSOL = 8.000) THEN J1SFDSOL = .;
   IF (J1SK4A = 8 OR J1SK4A = 9) THEN J1SK4A = .;
   IF (J1SK4B = 8 OR J1SK4B = 9) THEN J1SK4B = .;
   IF (J1SK4C = 8 OR J1SK4C = 9) THEN J1SK4C = .;
   IF (J1SK4D = 8 OR J1SK4D = 9) THEN J1SK4D = .;
   IF (J1SK4E = 8 OR J1SK4E = 9) THEN J1SK4E = .;
   IF (J1SK4F = 8 OR J1SK4F = 9) THEN J1SK4F = .;
   IF (J1SK4G = 8 OR J1SK4G = 9) THEN J1SK4G = .;
   IF (J1SK4H = 8 OR J1SK4H = 9) THEN J1SK4H = .;
   IF (J1SSUGF = 8.000) THEN J1SSUGF = .;
   IF (J1SSTGF = 8.000) THEN J1SSTGF = .;
   IF (J1SSOGFD = 8.000) THEN J1SSOGFD = .;
   IF (J1SL1 = 8 OR J1SL1 = 9) THEN J1SL1 = .;
   IF (J1SL2 = 98 OR J1SL2 = 99) THEN J1SL2 = .;
   IF (J1SL3CY = 9998 OR J1SL3CY = 9999) THEN J1SL3CY = .;
   IF (J1SL3MO = 98 OR J1SL3MO = 99) THEN J1SL3MO = .;
   IF (J1SL4 = 98 OR J1SL4 = 99) THEN J1SL4 = .;
   IF (J1SL5 = 98 OR J1SL5 = 99) THEN J1SL5 = .;
   IF (J1SL6 = 98 OR J1SL6 = 99) THEN J1SL6 = .;
   IF (J1SL7 = 98 OR J1SL7 = 99) THEN J1SL7 = .;
   IF (J1SL8 = 98 OR J1SL8 = 99) THEN J1SL8 = .;
   IF (J1SL9 = 8 OR J1SL9 = 9) THEN J1SL9 = .;
   IF (J1SL10 = 8 OR J1SL10 = 9) THEN J1SL10 = .;
   IF (J1SMARRS = 98 OR J1SMARRS = 99) THEN J1SMARRS = .;
   IF (J1SL11A = 8 OR J1SL11A = 9) THEN J1SL11A = .;
   IF (J1SL11B = 8 OR J1SL11B = 9) THEN J1SL11B = .;
   IF (J1SL11C = 8 OR J1SL11C = 9) THEN J1SL11C = .;
   IF (J1SSPDIS = 98.0 OR J1SSPDIS = 99.0) THEN J1SSPDIS = .;
   IF (J1SL12 = 8 OR J1SL12 = 9) THEN J1SL12 = .;
   IF (J1SL13A = 8 OR J1SL13A = 9) THEN J1SL13A = .;
   IF (J1SL13B = 8 OR J1SL13B = 9) THEN J1SL13B = .;
   IF (J1SL13C = 8 OR J1SL13C = 9) THEN J1SL13C = .;
   IF (J1SL13D = 8 OR J1SL13D = 9) THEN J1SL13D = .;
   IF (J1SL13E = 8 OR J1SL13E = 9) THEN J1SL13E = .;
   IF (J1SL13F = 8 OR J1SL13F = 9) THEN J1SL13F = .;
   IF (J1SL14A = 8 OR J1SL14A = 9) THEN J1SL14A = .;
   IF (J1SL14B = 8 OR J1SL14B = 9) THEN J1SL14B = .;
   IF (J1SL14C = 8 OR J1SL14C = 9) THEN J1SL14C = .;
   IF (J1SL14D = 8 OR J1SL14D = 9) THEN J1SL14D = .;
   IF (J1SL14E = 8 OR J1SL14E = 9) THEN J1SL14E = .;
   IF (J1SL14F = 8 OR J1SL14F = 9) THEN J1SL14F = .;
   IF (J1SSPEMP = 8.000 OR J1SSPEMP = 9.000) THEN J1SSPEMP = .;
   IF (J1SSPCRI = 8.000 OR J1SSPCRI = 9.000) THEN J1SSPCRI = .;
   IF (J1SSPSOL = 8.000 OR J1SSPSOL = 9.000) THEN J1SSPSOL = .;
   IF (J1SL15A = 8 OR J1SL15A = 9) THEN J1SL15A = .;
   IF (J1SL15B = 8 OR J1SL15B = 9) THEN J1SL15B = .;
   IF (J1SL15C = 8 OR J1SL15C = 9) THEN J1SL15C = .;
   IF (J1SL15D = 8 OR J1SL15D = 9) THEN J1SL15D = .;
   IF (J1SL15E = 8 OR J1SL15E = 9) THEN J1SL15E = .;
   IF (J1SL15F = 8 OR J1SL15F = 9) THEN J1SL15F = .;
   IF (J1SL16A = 8 OR J1SL16A = 9) THEN J1SL16A = .;
   IF (J1SL16B = 8 OR J1SL16B = 9) THEN J1SL16B = .;
   IF (J1SL16C = 8 OR J1SL16C = 9) THEN J1SL16C = .;
   IF (J1SL16D = 8 OR J1SL16D = 9) THEN J1SL16D = .;
   IF (J1SL16E = 8 OR J1SL16E = 9) THEN J1SL16E = .;
   IF (J1SL16F = 8 OR J1SL16F = 9) THEN J1SL16F = .;
   IF (J1SSUGS = 8.000 OR J1SSUGS = 9.000) THEN J1SSUGS = .;
   IF (J1SSTGS = 8.000 OR J1SSTGS = 9.000) THEN J1SSTGS = .;
   IF (J1SSOLGS = 8.000 OR J1SSOLGS = 9.000) THEN J1SSOLGS = .;
   IF (J1SL17 = 8 OR J1SL17 = 9) THEN J1SL17 = .;
   IF (J1SL18 = 98 OR J1SL18 = 99) THEN J1SL18 = .;
   IF (J1SL19 = 98 OR J1SL19 = 99) THEN J1SL19 = .;
   IF (J1SL20 = 8 OR J1SL20 = 9) THEN J1SL20 = .;
   IF (J1SL21 = 8 OR J1SL21 = 9) THEN J1SL21 = .;
   IF (J1SL22A = 8 OR J1SL22A = 9) THEN J1SL22A = .;
   IF (J1SL22B = 8 OR J1SL22B = 9) THEN J1SL22B = .;
   IF (J1SL22C = 8 OR J1SL22C = 9) THEN J1SL22C = .;
   IF (J1SL22D = 8 OR J1SL22D = 9) THEN J1SL22D = .;
   IF (J1SSPDEC = 98.000 OR J1SSPDEC = 99.000) THEN J1SSPDEC = .;
   IF (J1SL23 = 8 OR J1SL23 = 9) THEN J1SL23 = .;
   IF (J1SL24 = 8 OR J1SL24 = 9) THEN J1SL24 = .;
   IF (J1SL25 = 8 OR J1SL25 = 9) THEN J1SL25 = .;
   IF (J1SM1 = 8 OR J1SM1 = 9) THEN J1SM1 = .;
   IF (J1SM2 = 98 OR J1SM2 = 99) THEN J1SM2 = .;
   IF (J1SM3 = 98 OR J1SM3 = 99) THEN J1SM3 = .;
   IF (J1SM4 = 98 OR J1SM4 = 99) THEN J1SM4 = .;
   IF (J1SM5 = 98 OR J1SM5 = 99) THEN J1SM5 = .;
   IF (J1SM6 = 98 OR J1SM6 = 99) THEN J1SM6 = .;
   IF (J1SM7A = 8 OR J1SM7A = 9) THEN J1SM7A = .;
   IF (J1SM7B = 8 OR J1SM7B = 9) THEN J1SM7B = .;
   IF (J1SM7C = 8 OR J1SM7C = 9) THEN J1SM7C = .;
   IF (J1SM7D = 8 OR J1SM7D = 9) THEN J1SM7D = .;
   IF (J1SM7E = 8 OR J1SM7E = 9) THEN J1SM7E = .;
   IF (J1SM7F = 8 OR J1SM7F = 9) THEN J1SM7F = .;
   IF (J1SPIFAM = 8.000 OR J1SPIFAM = 9.000) THEN J1SPIFAM = .;
   IF (J1SN1 = 8 OR J1SN1 = 9) THEN J1SN1 = .;
   IF (J1SN2 = 98 OR J1SN2 = 99) THEN J1SN2 = .;
   IF (J1SN3A = 8 OR J1SN3A = 9) THEN J1SN3A = .;
   IF (J1SN3B = 8 OR J1SN3B = 9) THEN J1SN3B = .;
   IF (J1SN3C = 8 OR J1SN3C = 9) THEN J1SN3C = .;
   IF (J1SN3D = 8 OR J1SN3D = 9) THEN J1SN3D = .;
   IF (J1SN3E = 8 OR J1SN3E = 9) THEN J1SN3E = .;
   IF (J1SN3F = 8 OR J1SN3F = 9) THEN J1SN3F = .;
   IF (J1SN4A = 8 OR J1SN4A = 9) THEN J1SN4A = .;
   IF (J1SN4B = 8 OR J1SN4B = 9) THEN J1SN4B = .;
   IF (J1SN4C = 8 OR J1SN4C = 9) THEN J1SN4C = .;
   IF (J1SN4D = 8 OR J1SN4D = 9) THEN J1SN4D = .;
   IF (J1SN4E = 8 OR J1SN4E = 9) THEN J1SN4E = .;
   IF (J1SN4F = 8 OR J1SN4F = 9) THEN J1SN4F = .;
   IF (J1SN4G = 8 OR J1SN4G = 9) THEN J1SN4G = .;
   IF (J1SN4H = 8 OR J1SN4H = 9) THEN J1SN4H = .;
   IF (J1SN4I = 8 OR J1SN4I = 9) THEN J1SN4I = .;
   IF (J1SN4J = 8 OR J1SN4J = 9) THEN J1SN4J = .;
   IF (J1SKINPO = 8.000 OR J1SKINPO = 9.000) THEN J1SKINPO = .;
   IF (J1SKINNE = 8.000 OR J1SKINNE = 9.000) THEN J1SKINNE = .;
   IF (J1SFAMSO = 8.000 OR J1SFAMSO = 9.000) THEN J1SFAMSO = .;
   IF (J1SSUGFA = 8.0 OR J1SSUGFA = 9.0) THEN J1SSUGFA = .;
   IF (J1SSTGFA = 8.000 OR J1SSTGFA = 9.000) THEN J1SSTGFA = .;
   IF (J1SSOGFM = 8.000 OR J1SSOGFM = 9.000) THEN J1SSOGFM = .;
   IF (J1SO1 = 8 OR J1SO1 = 9) THEN J1SO1 = .;
   IF (J1SO2A = 8 OR J1SO2A = 9) THEN J1SO2A = .;
   IF (J1SO2B = 8 OR J1SO2B = 9) THEN J1SO2B = .;
   IF (J1SO2C = 8 OR J1SO2C = 9) THEN J1SO2C = .;
   IF (J1SO3A = 8 OR J1SO3A = 9) THEN J1SO3A = .;
   IF (J1SO3B = 8 OR J1SO3B = 9) THEN J1SO3B = .;
   IF (J1SO3C = 8 OR J1SO3C = 9) THEN J1SO3C = .;
   IF (J1SP1 = 8 OR J1SP1 = 9) THEN J1SP1 = .;
   IF (J1SP1A = 998 OR J1SP1A = 999) THEN J1SP1A = .;
   IF (J1SP1B = 8 OR J1SP1B = 9) THEN J1SP1B = .;
   IF (J1SP1CCY = 9998 OR J1SP1CCY = 9999) THEN J1SP1CCY = .;
   IF (J1SP1D = 998 OR J1SP1D = 999) THEN J1SP1D = .;
   IF (J1SP2 = 8 OR J1SP2 = 9) THEN J1SP2 = .;
   IF (J1SP2A = 998 OR J1SP2A = 999) THEN J1SP2A = .;
   IF (J1SP2B = 8 OR J1SP2B = 9) THEN J1SP2B = .;
   IF (J1SP2CCY = 9998 OR J1SP2CCY = 9999) THEN J1SP2CCY = .;
   IF (J1SP2D = 998 OR J1SP2D = 999) THEN J1SP2D = .;
   IF (J1SQ1 = 8 OR J1SQ1 = 9) THEN J1SQ1 = .;
   IF (J1SQ2AGE = 98 OR J1SQ2AGE = 99) THEN J1SQ2AGE = .;
   IF (J1SQ3 = 98 OR J1SQ3 = 99) THEN J1SQ3 = .;
   IF (J1SQ4 = 8 OR J1SQ4 = 9) THEN J1SQ4 = .;
   IF (J1SQ5 = 8 OR J1SQ5 = 9) THEN J1SQ5 = .;
   IF (J1SQ6A = 8 OR J1SQ6A = 9) THEN J1SQ6A = .;
   IF (J1SQ6B = 8 OR J1SQ6B = 9) THEN J1SQ6B = .;
   IF (J1SQ6C = 8 OR J1SQ6C = 9) THEN J1SQ6C = .;
   IF (J1SQ6D = 8 OR J1SQ6D = 9) THEN J1SQ6D = .;
   IF (J1SQ6E = 8 OR J1SQ6E = 9) THEN J1SQ6E = .;
   IF (J1SQ6F = 8 OR J1SQ6F = 9) THEN J1SQ6F = .;
   IF (J1SQ6G = 8 OR J1SQ6G = 9) THEN J1SQ6G = .;
   IF (J1SQ6H = 8 OR J1SQ6H = 9) THEN J1SQ6H = .;
   IF (J1SQ6I = 8 OR J1SQ6I = 9) THEN J1SQ6I = .;
   IF (J1SQ6J = 8 OR J1SQ6J = 9) THEN J1SQ6J = .;
*/


* SAS FORMAT STATEMENT;

/*
  FORMAT J1SA1 j1sa1fff. J1SA2 j1sa2fff. J1SA3 j1sa3fff.
         J1SA4 j1sa4fff. J1SA5 j1sa5fff. J1SSATIS j1ssatis.
         J1SSATI2 j1ssatif. J1SA6A j1sa6a. J1SA6B j1sa6b.
         J1SA6C j1sa6c. J1SA6D j1sa6d. J1SA6E j1sa6e.
         J1SAMPLI j1sampli. J1SA7A j1sa7a. J1SA7B j1sa7b.
         J1SA7C j1sa7c. J1SA7D j1sa7d. J1SA7E j1sa7e.
         J1SA7F j1sa7f. J1SA7G j1sa7g. J1SA7H j1sa7h.
         J1SA7I j1sa7i. J1SA8A j1sa8a. J1SA8B j1sa8b.
         J1SA8C j1sa8c. J1SA8D j1sa8d. J1SA8E j1sa8e.
         J1SA8F j1sa8f. J1SA8G j1sa8g. J1SA8H j1sa8h.
         J1SA8I j1sa8i. J1SA8J j1sa8j. J1SA8K j1sa8k.
         J1SA8L j1sa8l. J1SA8M j1sa8m. J1SA8N j1sa8n.
         J1SA8O j1sa8o. J1SA8P j1sa8p. J1SA8Q j1sa8q.
         J1SA8R j1sa8r. J1SA8S j1sa8s. J1SA8T j1sa8t.
         J1SA8U j1sa8u. J1SA8V j1sa8v. J1SA8W j1sa8w.
         J1SA8X j1sa8x. J1SA8Y j1sa8y. J1SA8Z j1sa8z.
         J1SA8AA j1sa8aa. J1SA8BB j1sa8bb. J1SA8CC j1sa8cc.
         J1SA8DD j1sa8dd. J1SA8EE j1sa8ee. J1SCHRON j1schron.
         J1SCHROX j1schrox. J1SA9A j1sa9a. J1SA9AY j1sa9ay.
         J1SA9B j1sa9b. J1SA9BY j1sa9by. J1SA9C j1sa9c.
         J1SA9CY j1sa9cy. J1SA9D j1sa9d. J1SA9DY j1sa9dy.
         J1SA9E j1sa9e. J1SA9EY j1sa9ey. J1SA9F j1sa9f.
         J1SA9FY j1sa9fy. J1SA9G j1sa9g. J1SA9GY j1sa9gy.
         J1SA9H j1sa9h. J1SA9HY j1sa9hy. J1SA9I j1sa9i.
         J1SA9IY j1sa9iy. J1SA9J j1sa9j. J1SA9JY j1sa9jy.
         J1SA9K j1sa9k. J1SA9KY j1sa9ky. J1SA9L j1sa9l.
         J1SA9LY j1sa9ly. J1SRXMED j1srxmed. J1SRXMEX j1srxmex.
         J1SA10A j1sa10a. J1SA10B j1sa10b. J1SA10C j1sa10c.
         J1SA10D j1sa10d. J1SA10E j1sa10e. J1SA10F j1sa10f.
         J1SA10G j1sa10g. J1SA10H j1sa10h. J1SA10I j1sa10i.
         J1SA10J j1sa10j. J1SBADL1 j1sbadlf. J1SBADL2 j1sbad0f.
         J1SIADL j1siadl. J1SA11A j1sa11a. J1SA11B j1sa11b.
         J1SA11C j1sa11c. J1SA11D j1sa11d. J1SDYSPN j1sdyspn.
         J1SA12 j1sa12ff. J1SA13CY j1sa13cy. J1SA13CM j1sa13cm.
         J1SA14 j1sa14ff. J1SA15 j1sa15ff. J1SA16 j1sa16ff.
         J1SA17A j1sa17a. J1SA17AN j1sa17an. J1SA17B j1sa17b.
         J1SA17BN j1sa17bn. J1SA17C j1sa17c. J1SA17CN j1sa17cn.
         J1SA17D j1sa17d. J1SA17DN j1sa17dn. J1SA17E j1sa17e.
         J1SA17EN j1sa17en. J1SUSEMD j1susemd. J1SA18A j1sa18a.
         J1SA18B j1sa18b. J1SA18C j1sa18c. J1SA18D j1sa18d.
         J1SA18E j1sa18e. J1SA18F j1sa18f. J1SA19 j1sa19ff.
         J1SA20A j1sa20a. J1SA20B j1sa20b. J1SA20C j1sa20c.
         J1SA20D j1sa20d. J1SA20E j1sa20e. J1SA20F j1sa20f.
         J1SA20G j1sa20g. J1SB1A j1sb1a. J1SB1 j1sb1fff.
         J1SB2 j1sb2fff. J1SB3 j1sb3fff. J1SB4 j1sb4fff.
         J1SB5 j1sb5fff. J1SC1 j1sc1fff. J1SC2 j1sc2fff.
         J1SC3 j1sc3fff. J1SC4 j1sc4fff. J1SC5 j1sc5fff.
         J1SC6 j1sc6fff. J1SC7 j1sc7fff. J1SD1A j1sd1a.
         J1SD1B j1sd1b. J1SD1C j1sd1c. J1SD1D j1sd1d.
         J1SD1E j1sd1e. J1SD1F j1sd1f. J1SD1G j1sd1g.
         J1SD1H j1sd1h. J1SD1I j1sd1i. J1SD1J j1sd1j.
         J1SD1K j1sd1k. J1SD1L j1sd1l. J1SD1M j1sd1m.
         J1SD1N j1sd1n. J1SNEGAF j1snegaf. J1SNEGPA j1snegpa.
         J1SD2A j1sd2a. J1SD2B j1sd2b. J1SD2C j1sd2c.
         J1SD2D j1sd2d. J1SD2E j1sd2e. J1SD2F j1sd2f.
         J1SD2G j1sd2g. J1SD2H j1sd2h. J1SD2I j1sd2i.
         J1SD2J j1sd2j. J1SD2K j1sd2k. J1SD2L j1sd2l.
         J1SD2M j1sd2m. J1SPOSAF j1sposaf. J1SPOSPA j1spospa.
         J1SD3A j1sd3a. J1SD3B j1sd3b. J1SD3C j1sd3c.
         J1SD3D j1sd3d. J1SD3E j1sd3e. J1SD3F j1sd3f.
         J1SD3G j1sd3g. J1SD3H j1sd3h. J1SD3I j1sd3i.
         J1SD3J j1sd3j. J1SPS_PS j1sps_ps. J1SD4A j1sd4a.
         J1SD4B j1sd4b. J1SD4C j1sd4c. J1SD4D j1sd4d.
         J1SD4E j1sd4e. J1SD4F j1sd4f. J1SD4G j1sd4g.
         J1SD4H j1sd4h. J1SD4I j1sd4i. J1SSA_SA j1ssa_sa.
         J1SD5A j1sd5a. J1SD5B j1sd5b. J1SD5C j1sd5c.
         J1SD5D j1sd5d. J1SD5E j1sd5e. J1SD5F j1sd5f.
         J1SD5G j1sd5g. J1SD5H j1sd5h. J1SD5I j1sd5i.
         J1SD5J j1sd5j. J1SD5K j1sd5k. J1SD5L j1sd5l.
         J1SD5M j1sd5m. J1SD5N j1sd5n. J1SD5O j1sd5o.
         J1SD5P j1sd5p. J1SD5Q j1sd5q. J1SD5R j1sd5r.
         J1SD5S j1sd5s. J1SD5T j1sd5t. J1SD5U j1sd5u.
         J1SD5V j1sd5v. J1SAE_AI j1sae_ai. J1SAE_AO j1sae_ao.
         J1SAE_AC j1sae_ac. J1SAE_AA j1sae_aa. J1SE1 j1se1fff.
         J1SE2 j1se2fff. J1SE3 j1se3fff. J1SE4 j1se4fff.
         J1SE5 j1se5fff. J1SE6 j1se6fff. J1SE7 j1se7fff.
         J1SE8 j1se8fff. J1SE9 j1se9fff. J1SE10 j1se10ff.
         J1SE11 j1se11ff. J1SE12 j1se12ff. J1SE13 j1se13ff.
         J1SE14A j1se14a. J1SE14B j1se14b. J1SE14C j1se14c.
         J1SE14D j1se14d. J1SE14E j1se14e. J1SE14F j1se14f.
         J1SE14G j1se14g. J1SE14H j1se14h. J1SE14I j1se14i.
         J1SE14J j1se14j. J1SE14K j1se14k. J1SE14L j1se14l.
         J1SE14M j1se14m. J1SE14N j1se14n. J1SE14O j1se14o.
         J1SE14P j1se14p. J1SPOSWF j1sposwf. J1SNEGWF j1snegwf.
         J1SPOSFW j1sposfw. J1SNEGFW j1snegfw. J1SE15A j1se15a.
         J1SE15B j1se15b. J1SE15C j1se15c. J1SE15D j1se15d.
         J1SE15E j1se15e. J1SE15F j1se15f. J1SE15G j1se15g.
         J1SE15H j1se15h. J1SE15I j1se15i. J1SE15J j1se15j.
         J1SE15K j1se15k. J1SE16A j1se16a. J1SE16B j1se16b.
         J1SE16C j1se16c. J1SE16D j1se16d. J1SJCSD j1sjcsd.
         J1SJCDA j1sjcda. J1SJCDS j1sjcds. J1SE17A j1se17a.
         J1SE17B j1se17b. J1SE17C j1se17c. J1SE17D j1se17d.
         J1SE17E j1se17e. J1SJCCS j1sjccs. J1SJCSS j1sjcss.
         J1SE18A j1se18a. J1SE18B j1se18b. J1SE18C j1se18c.
         J1SE18D j1se18d. J1SE18E j1se18e. J1SE18F j1se18f.
         J1SPIWOR j1spiwor. J1SE19 j1se19ff. J1SE20 j1se20ff.
         J1SE21 j1se21ff. J1SF1 j1sf1fff. J1SF2 j1sf2fff.
         J1SF3 j1sf3fff. J1SF4 j1sf4fff. J1SF5 j1sf5fff.
         J1SF6 j1sf6fff. J1SG1A j1sg1a. J1SG1B j1sg1b.
         J1SG1C j1sg1c. J1SG1D j1sg1d. J1SG1E j1sg1e.
         J1SG1F j1sg1f. J1SG1G j1sg1g. J1SG1H j1sg1h.
         J1SG1I j1sg1i. J1SG1J j1sg1j. J1SG1K j1sg1k.
         J1SG1L j1sg1l. J1SG1M j1sg1m. J1SG1N j1sg1n.
         J1SG1O j1sg1o. J1SG1P j1sg1p. J1SG1Q j1sg1q.
         J1SG1R j1sg1r. J1SG1S j1sg1s. J1SMASTE j1smaste.
         J1SCONST j1sconst. J1SCTRL j1sctrl. J1SESTEE j1sestee.
         J1SG2A j1sg2a. J1SG2B j1sg2b. J1SG2C j1sg2c.
         J1SG2D j1sg2d. J1SG2E j1sg2e. J1SG2F j1sg2f.
         J1SOPTIM j1soptim. J1SPESSI j1spessi. J1SORIEN j1sorien.
         J1SG3A j1sg3a. J1SG3B j1sg3b. J1SG3C j1sg3c.
         J1SG3D j1sg3d. J1SG3E j1sg3e. J1SG3F j1sg3f.
         J1SG3G j1sg3g. J1SG3H j1sg3h. J1SG3I j1sg3i.
         J1SG3J j1sg3j. J1SG3K j1sg3k. J1SG3L j1sg3l.
         J1SG3M j1sg3m. J1SG3N j1sg3n. J1SG3O j1sg3o.
         J1SG3P j1sg3p. J1SG3Q j1sg3q. J1SG3R j1sg3r.
         J1SG3S j1sg3s. J1SG3T j1sg3t. J1SPERSI j1spersi.
         J1SREAPP j1sreapp. J1SCHANG j1schang. J1SSPCTR j1sspctr.
         J1SCPCTR j1scpctr. J1SCSCAG j1scscag. J1SSUFFI j1ssuffi.
         J1SG4A j1sg4a. J1SG4B j1sg4b. J1SG4C j1sg4c.
         J1SG4D j1sg4d. J1SG4E j1sg4e. J1SG4F j1sg4f.
         J1SG4G j1sg4g. J1SG4H j1sg4h. J1SG4I j1sg4i.
         J1SG4J j1sg4j. J1SG4K j1sg4k. J1SG4L j1sg4l.
         J1SG4M j1sg4m. J1SG4N j1sg4n. J1SG4O j1sg4o.
         J1SG4P j1sg4p. J1SG4Q j1sg4q. J1SG4R j1sg4r.
         J1SG4S j1sg4s. J1SG4T j1sg4t. J1SG4U j1sg4u.
         J1SG4V j1sg4v. J1SINTER j1sinter. J1SINDEP j1sindep.
         J1SSC_IT j1ssc_it. J1SSC_ID j1ssc_id. J1SJINTR j1sjintr.
         J1SJINDP j1sjindp. J1SG5A j1sg5a. J1SG5B j1sg5b.
         J1SG5C j1sg5c. J1SG5D j1sg5d. J1SG5E j1sg5e.
         J1SG5F j1sg5f. J1SG5G j1sg5g. J1SG5H j1sg5h.
         J1SG5I j1sg5i. J1SG5J j1sg5j. J1SSYMP j1ssymp.
         J1SADJ j1sadj. J1SG6A j1sg6a. J1SG6B j1sg6b.
         J1SG6C j1sg6c. J1SG6D j1sg6d. J1SG6E j1sg6e.
         J1SG6F j1sg6f. J1SG6G j1sg6g. J1SG6H j1sg6h.
         J1SG6I j1sg6i. J1SG6J j1sg6j. J1SG6K j1sg6k.
         J1SG6L j1sg6l. J1SG6M j1sg6m. J1SG6N j1sg6n.
         J1SG6O j1sg6o. J1SG6P j1sg6p. J1SG6Q j1sg6q.
         J1SG6R j1sg6r. J1SG6S j1sg6s. J1SG6T j1sg6t.
         J1SG6U j1sg6u. J1SG6V j1sg6v. J1SG6W j1sg6w.
         J1SG6X j1sg6x. J1SG6Y j1sg6y. J1SG6Z j1sg6z.
         J1SG6AA j1sg6aa. J1SG6BB j1sg6bb. J1SG6CC j1sg6cc.
         J1SG6DD j1sg6dd. J1SG6EE j1sg6ee. J1SNEURO j1sneuro.
         J1SEXTRA j1sextra. J1SOPEN j1sopen. J1SCONS1 j1sconsf.
         J1SCONS2 j1scon0f. J1SAGREE j1sagree. J1SAGENC j1sagenc.
         J1SG7A j1sg7a. J1SG7B j1sg7b. J1SG7C j1sg7c.
         J1SG7D j1sg7d. J1SG7E j1sg7e. J1SG7F j1sg7f.
         J1SG7G j1sg7g. J1SG7H j1sg7h. J1SG7I j1sg7i.
         J1SG7J j1sg7j. J1SG7K j1sg7k. J1SG7L j1sg7l.
         J1SG7M j1sg7m. J1SG7N j1sg7n. J1SG7O j1sg7o.
         J1SG7P j1sg7p. J1SG7Q j1sg7q. J1SG7R j1sg7r.
         J1SG7S j1sg7s. J1SSC_SC j1ssc_sc. J1SSC_CC j1ssc_cc.
         J1SSC_EC j1ssc_ec. J1SSC_BC j1ssc_bc. J1SH1A j1sh1a.
         J1SH1B j1sh1b. J1SH1C j1sh1c. J1SH1D j1sh1d.
         J1SH1E j1sh1e. J1SH1F j1sh1f. J1SGENER j1sgener.
         J1SH2 j1sh2fff. J1SI1 j1si1fff. J1SI2 j1si2fff.
         J1SI3 j1si3fff. J1SJ1 j1sj1fff. J1SJ2 j1sj2fff.
         J1SJ3 j1sj3fff. J1SJ4 j1sj4fff. J1SJ5 j1sj5fff.
         J1SJ6 j1sj6fff. J1SJ7A j1sj7a. J1SJ7B j1sj7b.
         J1SJ7C j1sj7c. J1SJ7D j1sj7d. J1SJ7E j1sj7e.
         J1SJ7F j1sj7f. J1SJ7G j1sj7g. J1SJ7H j1sj7h.
         J1SSW_SL j1ssw_sl. J1SSW_GR j1ssw_gr. J1SJ8A j1sj8a.
         J1SJ8B j1sj8b. J1SJ8C j1sj8c. J1SJ8D j1sj8d.
         J1SJ8E j1sj8e. J1SJ8F j1sj8f. J1SJ8G j1sj8g.
         J1SJ8H j1sj8h. J1SJ8I j1sj8i. J1SJ8J j1sj8j.
         J1SJ8K j1sj8k. J1SJ8L j1sj8l. J1SJ8M j1sj8m.
         J1SJ8N j1sj8n. J1SJ8O j1sj8o. J1SJ8P j1sj8p.
         J1SJ8Q j1sj8q. J1SJ8R j1sj8r. J1SJ8S j1sj8s.
         J1SJ8T j1sj8t. J1SJ8U j1sj8u. J1SJ8V j1sj8v.
         J1SJ8W j1sj8w. J1SJ8X j1sj8x. J1SJ8Y j1sj8y.
         J1SJ8Z j1sj8z. J1SJ8AA j1sj8aa. J1SJ8BB j1sj8bb.
         J1SJ8CC j1sj8cc. J1SJ8DD j1sj8dd. J1SJ8EE j1sj8ee.
         J1SJ8FF j1sj8ff. J1SJ8GG j1sj8gg. J1SJ8HH j1sj8hh.
         J1SJ8II j1sj8ii. J1SJ8JJ j1sj8jj. J1SJ8KK j1sj8kk.
         J1SJ8LL j1sj8ll. J1SJ8MM j1sj8mm. J1SJ8NN j1sj8nn.
         J1SJ8OO j1sj8oo. J1SJ8PP j1sj8pp. J1SPWBA1 j1spwbaf.
         J1SPWBE1 j1spwbef. J1SPWBG1 j1spwbgf. J1SPWBR1 j1spwbrf.
         J1SPWBU1 j1spwbuf. J1SPWBS1 j1spwbsf. J1SPWBA2 j1spwb0f.
         J1SPWBE2 j1spwb1f. J1SPWBG2 j1spwb2f. J1SPWBR2 j1spwb3f.
         J1SPWBU2 j1spwb4f. J1SPWBS2 j1spwb5f. J1SJ8QQ j1sj8qq.
         J1SJ8RR j1sj8rr. J1SJ8SS j1sj8ss. J1SJ8TT j1sj8tt.
         J1SJ8UU j1sj8uu. J1SJ8VV j1sj8vv. J1SJ8WW j1sj8ww.
         J1SJ8XX j1sj8xx. J1SJ8YY j1sj8yy. J1SJ8ZZ j1sj8zz.
         J1SMWBGR j1smwbgr. J1SMWBPD j1smwbpd. J1SK1 j1sk1fff.
         J1SSGFA j1ssgfa. J1SK2 j1sk2fff. J1SK3A j1sk3a.
         J1SK3B j1sk3b. J1SK3C j1sk3c. J1SK3D j1sk3d.
         J1SK3E j1sk3e. J1SK3F j1sk3f. J1SK3G j1sk3g.
         J1SK3H j1sk3h. J1SFDSPO j1sfdspo. J1SFDSNE j1sfdsne.
         J1SFDSOL j1sfdsol. J1SK4A j1sk4a. J1SK4B j1sk4b.
         J1SK4C j1sk4c. J1SK4D j1sk4d. J1SK4E j1sk4e.
         J1SK4F j1sk4f. J1SK4G j1sk4g. J1SK4H j1sk4h.
         J1SSUGF j1ssugf. J1SSTGF j1sstgf. J1SSOGFD j1ssogfd.
         J1SL1 j1sl1fff. J1SL2 j1sl2fff. J1SL3CY j1sl3cy.
         J1SL3MO j1sl3mo. J1SL4 j1sl4fff. J1SL5 j1sl5fff.
         J1SL6 j1sl6fff. J1SL7 j1sl7fff. J1SL8 j1sl8fff.
         J1SL9 j1sl9fff. J1SL10 j1sl10ff. J1SMARRS j1smarrs.
         J1SL11A j1sl11a. J1SL11B j1sl11b. J1SL11C j1sl11c.
         J1SSPDIS j1sspdis. J1SL12 j1sl12ff. J1SL13A j1sl13a.
         J1SL13B j1sl13b. J1SL13C j1sl13c. J1SL13D j1sl13d.
         J1SL13E j1sl13e. J1SL13F j1sl13f. J1SL14A j1sl14a.
         J1SL14B j1sl14b. J1SL14C j1sl14c. J1SL14D j1sl14d.
         J1SL14E j1sl14e. J1SL14F j1sl14f. J1SSPEMP j1sspemp.
         J1SSPCRI j1sspcri. J1SSPSOL j1sspsol. J1SL15A j1sl15a.
         J1SL15B j1sl15b. J1SL15C j1sl15c. J1SL15D j1sl15d.
         J1SL15E j1sl15e. J1SL15F j1sl15f. J1SL16A j1sl16a.
         J1SL16B j1sl16b. J1SL16C j1sl16c. J1SL16D j1sl16d.
         J1SL16E j1sl16e. J1SL16F j1sl16f. J1SSUGS j1ssugs.
         J1SSTGS j1sstgs. J1SSOLGS j1ssolgs. J1SL17 j1sl17ff.
         J1SL18 j1sl18ff. J1SL19 j1sl19ff. J1SL20 j1sl20ff.
         J1SL21 j1sl21ff. J1SL22A j1sl22a. J1SL22B j1sl22b.
         J1SL22C j1sl22c. J1SL22D j1sl22d. J1SSPDEC j1sspdec.
         J1SL23 j1sl23ff. J1SL24 j1sl24ff. J1SL25 j1sl25ff.
         J1SM1 j1sm1fff. J1SM2 j1sm2fff. J1SM3 j1sm3fff.
         J1SM4 j1sm4fff. J1SM5 j1sm5fff. J1SM6 j1sm6fff.
         J1SM7A j1sm7a. J1SM7B j1sm7b. J1SM7C j1sm7c.
         J1SM7D j1sm7d. J1SM7E j1sm7e. J1SM7F j1sm7f.
         J1SPIFAM j1spifam. J1SN1 j1sn1fff. J1SN2 j1sn2fff.
         J1SN3A j1sn3a. J1SN3B j1sn3b. J1SN3C j1sn3c.
         J1SN3D j1sn3d. J1SN3E j1sn3e. J1SN3F j1sn3f.
         J1SN4A j1sn4a. J1SN4B j1sn4b. J1SN4C j1sn4c.
         J1SN4D j1sn4d. J1SN4E j1sn4e. J1SN4F j1sn4f.
         J1SN4G j1sn4g. J1SN4H j1sn4h. J1SN4I j1sn4i.
         J1SN4J j1sn4j. J1SKINPO j1skinpo. J1SKINNE j1skinne.
         J1SFAMSO j1sfamso. J1SSUGFA j1ssugfa. J1SSTGFA j1sstgfa.
         J1SSOGFM j1ssogfm. J1SO1 j1so1fff. J1SO2A j1so2a.
         J1SO2B j1so2b. J1SO2C j1so2c. J1SO3A j1so3a.
         J1SO3B j1so3b. J1SO3C j1so3c. J1SP1 j1sp1fff.
         J1SP1A j1sp1a. J1SP1B j1sp1b. J1SP1CCY j1sp1ccy.
         J1SP1D j1sp1d. J1SP2 j1sp2fff. J1SP2A j1sp2a.
         J1SP2B j1sp2b. J1SP2CCY j1sp2ccy. J1SP2D j1sp2d.
         J1SQ1 j1sq1fff. J1SQ2AGE j1sq2age. J1SQ3 j1sq3fff.
         J1SQ4 j1sq4fff. J1SQ5 j1sq5fff. J1SQ6A j1sq6a.
         J1SQ6B j1sq6b. J1SQ6C j1sq6c. J1SQ6D j1sq6d.
         J1SQ6E j1sq6e. J1SQ6F j1sq6f. J1SQ6G j1sq6g.
         J1SQ6H j1sq6h. J1SQ6I j1sq6i. J1SQ6J j1sq6j.
          ;
*/

RUN ;
