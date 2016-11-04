
**THIS STATA FILE LOADS THE ORIGINAL DATA, CREATES NEW VARIABLES USED FOR THE ALTERNATIVE SPECIFICATIONS, AND SAVES THE NEW DATA
*Last Update: 2015 02 18
*Written by Uri Simonsohn (uws@wharton.upenn.edu)
**************************************************************************************************************************


*0) Load the posted data. Originally obtained from https://www.aeaweb.org/aer/data/sept04_data_bertrand.zip
	cd "C:\uri\research\False Positive Economics\Data\"
	use "lakisha_aer.dta",clear

 *Seed to always get same random sample of 1/3 for qualit predictions
	set seed 1975  

*1) Dummies for black, female, administrative, boston, college
	gen black=0
	replace black=1 if race=="b"
	
	gen female=0
	replace female=1 if sex=="f"
	
	gen adm=0
	replace adm=1 if kind=="a"

	gen boston=0
	replace boston=1 if city=="b"
	
	gen college=0
	replace college=1 if education==4

*2) Standardize years of experience
	egen zyearsexp=std(yearsexp)
	egen zofjobs=std(ofjobs)


*3) Refer to all predictors for the 1st stage with a single macro: $xb
	*Based on caption from Table 4
	global xb "female boston i.occupbroad req expreq comreq educreq compreq orgreq"
	
		
*4) Simple Sum of quality indicators 
	gen sumq=college+zyearsexp+volunteer+military+email+empholes+workinschool+honors+computerskills+specialskills
	egen zsumq=std(sumq)
*5) Median split on sumq
	tabstat sumq,stats(median N) save

	*Save it in a matrix
		matrix t=r(StatTotal)
	*Now a scalar called median
		local median=t[1,1]
		di `median'
	*Create the median split variable	
		gen sumq_med=0
		replace sumq_med=1 if sumq>`median'
		label var sumq_med "Median split on Sum of quality measures"
			
	
*6) Create quality_ based on subsets
	*Draw random number
		gen rand=runiform()
	*Sort by it
		sort rand
	*Holdout sample is the lowest 1/2 of the sample, based on random order
		gen half=2
		replace half=1 if _n<4870/2
	
*6.1) Using All (blacks and whites) without covariates
		*predict 2nd half with first half.
			probit call yearsexp empholes email computerskills specialskills honors volunteer military workinschool   if half==1
			gen qall2=     _b[yearsexp]*yearsexp + _b[empholes]*empholes +_b[email]*email +_b[computerskills]*computerskills ///
			                +_b[specialskills]*specialskills +_b[honors]*honors +_b[volunteer]*volunteer +_b[workinschool]*workinschool 

			
							
		*Predict 1st half with 2nd half
			probit call yearsexp empholes email computerskills specialskills honors volunteer military workinschool   if half==2
			gen qall1=     _b[yearsexp]*yearsexp + _b[empholes]*empholes +_b[email]*email +_b[computerskills]*computerskills ///
			                +_b[specialskills]*specialskills +_b[honors]*honors +_b[volunteer]*volunteer +_b[workinschool]*workinschool 


		*Merge both halfs
			gen qall=.
				*If it was gerated with teh 1st half, it is called qall2, so we assign it to those in the 2nd half as the d.v.
			replace qall=qall2 if half==1
			replace qall=qall1 if half==2
			
						
			
*6.2) Using All (blacks and whites) WITH covariates
		*predict 2nd half with first half.
			probit call yearsexp empholes email computerskills specialskills honors volunteer military workinschool $xb  if half==1
			gen qall2xb=_b[yearsexp]*yearsexp + _b[empholes]*empholes +_b[email]*email +_b[computerskills]*computerskills ///
			                +_b[specialskills]*specialskills +_b[honors]*honors +_b[volunteer]*volunteer +_b[workinschool]*workinschool if half==2
			
			
		*Predict 1st half with 2nd half
			probit call yearsexp empholes email computerskills specialskills honors volunteer military workinschool $xb  if half==2
			gen qall1xb=_b[yearsexp]*yearsexp + _b[empholes]*empholes +_b[email]*email +_b[computerskills]*computerskills ///
			                +_b[specialskills]*specialskills +_b[honors]*honors +_b[volunteer]*volunteer +_b[workinschool]*workinschool if half==1

		*Merge both halfs
			gen qallxb=.
			replace qallxb=qall1xb if half==1
			replace qallxb=qall2xb if half==2 
			
		
		
	
*(6.3) Using Blacks only without covariates
		*predict 2nd half with first half.
			probit call yearsexp empholes email computerskills specialskills honors volunteer military workinschool  if half==1 & black==1
			gen qblack2=    _b[yearsexp]*yearsexp + _b[empholes]*empholes +_b[email]*email +_b[computerskills]*computerskills ///
			                +_b[specialskills]*specialskills +_b[honors]*honors +_b[volunteer]*volunteer +_b[workinschool]*workinschool if half==2
		
			
		*Predict 1st half with 2nd half
			probit call yearsexp empholes email computerskills specialskills honors volunteer military workinschool  if half==2 & black==1
			gen qblack1=    _b[yearsexp]*yearsexp + _b[empholes]*empholes +_b[email]*email +_b[computerskills]*computerskills ///
			                +_b[specialskills]*specialskills +_b[honors]*honors +_b[volunteer]*volunteer +_b[workinschool]*workinschool if half==1
		
		*Merge both halfs
			gen qblack=.
			replace qblack=qblack2 if half==2
			replace qblack=qblack1 if half==1

*(6.4) Using Blacks only WITH covariates
		*predict 2nd half with first half.
			probit call yearsexp empholes email computerskills specialskills honors volunteer military workinschool  $xb if half==1 & black==1
			gen qblack2xb=    _b[yearsexp]*yearsexp + _b[empholes]*empholes +_b[email]*email +_b[computerskills]*computerskills ///
			                +_b[specialskills]*specialskills +_b[honors]*honors +_b[volunteer]*volunteer +_b[workinschool]*workinschool if half==2
		
			
		*Predict 1st half with 2nd half
			probit call yearsexp empholes email computerskills specialskills honors volunteer military workinschool $xb if half==2 & black==1
			gen qblack1xb=    _b[yearsexp]*yearsexp + _b[empholes]*empholes +_b[email]*email +_b[computerskills]*computerskills ///
			                +_b[specialskills]*specialskills +_b[honors]*honors +_b[volunteer]*volunteer +_b[workinschool]*workinschool if half==1
		
		*Merge both halfs
			gen qblackxb=.
			replace qblackxb=qblack2xb if half==2
			replace qblackxb=qblack1xb if half==1
		
*(6.5) Using whites only without covariates
		*predict 2nd half with first half.
			probit call yearsexp empholes email computerskills specialskills honors volunteer military workinschool  if half==1 & black==0
			gen qwhite2=    _b[yearsexp]*yearsexp + _b[empholes]*empholes +_b[email]*email +_b[computerskills]*computerskills ///
			                +_b[specialskills]*specialskills +_b[honors]*honors +_b[volunteer]*volunteer +_b[workinschool]*workinschool if half==2
		
			
		*Predict 1st half with 2nd half
			probit call yearsexp empholes email computerskills specialskills honors volunteer military workinschool  if half==2 & black==0
			gen qwhite1=    _b[yearsexp]*yearsexp + _b[empholes]*empholes +_b[email]*email +_b[computerskills]*computerskills ///
			                +_b[specialskills]*specialskills +_b[honors]*honors +_b[volunteer]*volunteer +_b[workinschool]*workinschool if half==1
		
		*Merge both halfs
			gen qwhite=.
			replace qwhite=qwhite2 if half==2
			replace qwhite=qwhite1 if half==1

*(6.6) Using whites only WITH covariates
		*predict 2nd half with first half.
			probit call yearsexp empholes email computerskills specialskills honors volunteer military workinschool  $xb if half==1 & black==0
			gen qwhite2xb=    _b[yearsexp]*yearsexp + _b[empholes]*empholes +_b[email]*email +_b[computerskills]*computerskills ///
			                +_b[specialskills]*specialskills +_b[honors]*honors +_b[volunteer]*volunteer +_b[workinschool]*workinschool if half==2
		
			
		*Predict 1st half with 2nd half
			probit call yearsexp empholes email computerskills specialskills honors volunteer military workinschool $xb if half==2 & black==0
			gen qwhite1xb=    _b[yearsexp]*yearsexp + _b[empholes]*empholes +_b[email]*email +_b[computerskills]*computerskills ///
			                +_b[specialskills]*specialskills +_b[honors]*honors +_b[volunteer]*volunteer +_b[workinschool]*workinschool if half==1
		
		*Merge both halfs
			gen qwhitexb=.
			replace qwhitexb=qwhite2xb if half==2
			replace qwhitexb=qwhite1xb if half==1
		
		
		
			
	
			
			
*7) Create median splits for q-hat
		*Compute medians
			tabstat qall qallxb qblack qblackxb qwhite qwhitexb ,stats(median N) save
		*Store them in a matrix
			matrix t=r(StatTotal)
		*Assign each of them to a macro
			local med1=t[1,1]  //median for qall 
			local med2=t[1,2]  //median for qallxb
			local med3=t[1,3]  //median for qblack
			local med4=t[1,4]  //median for qblackxb
			local med5=t[1,5]  //median for qwhite
			local med6=t[1,6]  //median for qwhitexb
		
				
		*Generate the median split variables
			gen qall_med=0
			gen qblack_med=0
			gen qwhite_med=0
			gen qallxb_med=0
			gen qblackxb_med=0
			gen qwhitexb_med=0
				
			replace qall_med=1    if qall>`med1'
			replace qallxb_med=1 if qallxb>`med2'
			
			replace qblack_med=1   if qblack>`med3'
			replace qblackxb_med=1 if qblackxb>`med4'
						
			replace qwhite_med=1   if qwhite>`med5'
			replace qwhitexb_med=1 if qwhitexb>`med6'
			
			
		save "Lakisha_Ready_2015_02_18", replace	
			