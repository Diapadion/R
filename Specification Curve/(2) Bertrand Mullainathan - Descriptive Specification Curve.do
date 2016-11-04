


	cd "C:\uri\research\Specification Curve\Data\"
	use "Lakisha_Ready_2015_02_18.dta", clear

	gen b_qual=. // This variable is the interaction between black * education variable, replaced in each loop

**TO MAKE EFFECT SIZE COMPARABLE BETWEEN MEDIAN SPLIT AND CONTINUOUS, I LOOK FOR THE AVERAGE MAGNITUDE CHANGE IN X FOR A MEDIAN SPLIT DIFFERENCE
**I run a regression of the continuous predicting it with the median split, the slope will capture the average difference, i then use that to multiply the effect size from the continuous
	reg sumq sumq_med	
		global sumq_dx=_b[sumq_med]
	reg qall qall_med
		global qall_dx=_b[qall_med]
	reg qall qallxb_med
		global qallxb_dx=_b[qallxb_med]
	
	reg qblack qblack_med
		global qblack_dx=_b[qblack_med]
	reg qblack qblackxb_med
		global qblackxb_dx=_b[qblackxb_med]
	
	reg qwhite qwhite_med
		global qwhite_dx=_b[qwhite_med]
	reg qwhite qwhitexb_med
		global qwhitexb_dx=_b[qwhitexb_med]
	
	
*****************************		
***LOOPS BEGINS HERE
****************************

	tempname scurve
	postfile `scurve' str80 spec k1 k2 k3  eblack pblack einter pinter rho_female rho_male using specifications_lakisha, replace
	
	local sk 1
	
*(1) Model
		forvalues k1 =1(1)2 {
			if `k1'==1 local model "reg"            //Linear probability model
			if `k1'==2 local model "probit"         //Probit
				
*(2) Type of quality
		forvalues k2=1(1)15 {
			if `k2'==1 local  qual "h"              //Randomly assigned 1-high quality, 0-low quality
			if `k2'==2 local  qual "sumq"          //Standardize sum of quality dummies
			if `k2'==3 local  qual "sumq_med"       //Median split of sum of quality dummies
			
			if `k2'==4 local  qual "qall"           //Predicted quality based on full sample, continuous
			if `k2'==5 local  qual "qallxb"         //Predicted quality based on full sample with covariates, continuous
			if `k2'==6 local  qual "qall_med"       //Predicted quality based on full sample without covariates, median split
			if `k2'==7 local  qual "qallxb_med"     //Predicted quality based on full sample with    covariates, median split
			
			if `k2'==8 local  qual "qwhite"         //Predicted quality based on whites without covariates, continuous
			if `k2'==9 local  qual "qwhitexb"       //Predicted quality based on whites with covariates, continuous
			if `k2'==10 local qual "qwhite_med"     //Predicted quality based on whites without covariates, median split
			if `k2'==11 local qual "qwhitexb_med"   //Predicted quality based on whites with    covariates, continuous
			
			if `k2'==12 local qual "qblack"         //Predicted quality based on blacks without covariates, continuous
			if `k2'==13 local qual "qblackxb"       //Predicted quality based on blacks with    covariates, continuous
			if `k2'==14 local qual "qblack_med"     //Predicted quality based on blacks sample with covariates, median split
			if `k2'==15 local qual "qblackxb_med"   //Predicted quality based on blacks sample with covariates, median split
			
*(3) Subsample
		forvalues k3 =1(1)3 {	
			if `k3'==1  local ifs " "
			if `k3'==2  local ifs "if female==1"
			if `k3'==3  local ifs "if female==0"
						
	*ALL LOOPS HAVE BEEN STARTED NOW
		*Get regregression ready to be run 
			*Generate the key interaction black*education
			quietly replace b_qual=black*`qual'
						
		*Regression line is called `spec'
			local spec `model' call c.`qual'#c.black black `qual' `ifs',cluster(adid)  //First predictor is the interaction, 2nd term is black dummy, clustering by add id
		
		*Print # of specification and the model estimated
			 di "`sk' k1=`k1' k2=`k2' k3=`k3' ---: `spec' "
		
   *RUN `SPEC' AND SAVE RESULTS
		quietly: `spec'
		
	*EXTRACT RESULTS
		*Save p-value for interaction
			local pinter=el(r(table),4,1)      //the function el(M,i,j) extracts a scalar from matrix M, row i, column j
		*Get marginal effect of Black, and its p-value
			quietly margins,dydx(black) atmeans
			local pblack=el(r(table),4,1)
			local eblack=el(r(table),1,1)
		*Get marginal effect of the interaction
			quietly margins,dydx(`qual') at(black=1)
				local qual_black=el(r(table),1,1)
			quietly  margins,dydx(`qual') at(black=0)
				local qual_white=el(r(table),1,1)
			local einter=(`qual_black'-`qual_white')
						
	*ADJUST EFFECT SIZE OF QUALITY WHEN NOT A MEDIAN SPLIt
	*Explanation: dydx computes the effect size for a change of 1 unit in the predictor. For the median split variables that involves a different magnitude cause-->different magnitude effect.
	*The adjustment is such that tehy are comparable, assesing teh difference in the average of teh quality predictor for above vs below median.
			*Adjust 
			   if (strpos("`qual'","med")==0 & `k2'>1) {        //If the variable is not the first (dummy for quality, and it it not a median split)
				local adjust "${`qual'_dx}"                     //Variables capturing the average difference for above vs below median were created at the very beggining of this file
				local einter=(`einter'*`adjust')                          
				}
	*ASSES FIT
			*get predicted probability
				capture drop call_hat  //if it exists, drop the variable call_hat
				predict call_hat
			*correlate it with the observed outcome 1/0 for females
				quietly corr call_hat call if female==1
			*Save it as `rho' 
				local rho_female r(rho)
			*correlate it with the observed outcome 1/0 for males
				quietly corr call_hat call if female==0
			*Save it as `rho' 
				local rho_male r(rho)
				
			*save results
				post `scurve' ("`spec'") (`k1') (`k2') (`k3') (`eblack') ( `pblack') (`einter') (`pinter') (`rho_female') (`rho_female')
					
			*Add 1 specification counter	
				local sk=(`sk'+1)			
			*Close loop 3
			}
			*Close loop 2
			} 
			*Close loop 1
			} 
			
		postclose `scurve'

	