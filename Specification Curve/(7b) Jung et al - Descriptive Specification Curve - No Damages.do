


**Load STATA dataset containing original data, data on wind and additional hurricanes collected after Jung et al., and modifications made in file (6)	
  	cd "C:\Uri\Research\Specification Curve\Data"
	use "hurricanes_ready_2015_02_19",clear

*Create the specification curve for the observed data
	tempname scurve
	postfile `scurve'  str80 spec n d_max dam_max  k1 k2 k3 k4 k5 k6 k7 b p em ef edif edam mad mad_clean using specifications_hurricanes ,replace
	
*(1) Outliers loop
	    local sk 1
	    forvalues k1 =1(1)3 {
		*This is a loop where we set the maximum number of deaths in the data
			if `k1'==1 local d_max=9999999     //high maximum, nothing is dropped
			if `k1'==2 local d_max=1833        //Katrina has 1833, this drops only Katrina
			if `k1'==3 local d_max=416         //Audrey had 416, this drops both Katrina and Audrey, as in Jung et al.
			
*(2) Leverage points loop
		 forvalues k2 =1(1)4 {
		 *This is a loop where we set the maximum number of damages in dollars
				if `k2'==1 local dam_max=9999999     //High maximum, nothing is dropped
				if `k2'==2 local dam_max=75260       //Highest observed value
				if `k2'==3 local dam_max=62030       //2nd highest
				if `k2'==4 local dam_max=52270       //3rd highest
	
*(3) Gender 
		forvalues k3 =1(1)2 {
			if `k3'==1 local fem "female"             //dummy for hurricanes with female name 1-yes, 0-no
			if `k3'==2 local fem "masfem"             //average rating of femeninity by MTurk sample in 1-11 scale, 11 most femenine
	
*(4) Model
		forvalues k4 =1(1)2 {
			if `k4'==1 local model_y "reg   lnd"   //for OLS use log(d+1)
			if `k4'==2 local model_y "nbreg d"     //for nbreg us d
		
*(5) Damages: log vs dollars
		forvalues k5=1(1)2 {
			if `k5'==1 local dam dam               //Use damages in $
			if `k5'==2 local dam lndam             //Use log($)
	
*(6) Predictions: interactions vs. main effect
		forvalues k6 =1(1)6 {	
		*Recall z3=mean(zmin,zwin,zcat)
			if `k6'==1  local xb c.`dam'#c.`fem' `dam' `fem'                        //only an interaction for damages with femeninity
			if `k6'==2  local xb c.`dam'#c.`fem' `dam' `fem'  c.zmin#c.`fem'  zmin  //also an interaction with minimum pressure, as in the paper
			if `k6'==3  local xb c.`dam'#c.`fem' `dam' `fem'  c.zwin#c.`fem'  zwin  //instead of minimum pressure, maximum wind
			if `k6'==4  local xb c.`dam'#c.`fem' `dam' `fem'  c.zcat#c.`fem'  zcat  //instead of wind, category of teh ehurricance (treated as continuous variable 1-5)
			if `k6'==5  local xb c.`dam'#c.`fem' `dam' `fem'  c.z3#c.`fem'    z3    //average standardized value of minimum, wind and category
			if `k6'==6  local xb `fem' `dam' z3      
		
*(7) Year covariates;
		forvalues k7 =1(1)3 {	
			if `k7'==1  local cov " "
			if `k7'==2  local cov c.year##c.`dam'
			if `k7'==3  local cov c.post79##c.`dam'
					
	*ALL LOOPS HAVE BEEN STARTED NOW
			
		*Get regregression ready to be run 
		*Regression line is called `spec'
			local spec `model_y' `xb' `cov' if d<`d_max' & dam<`dam_max',robust

		*Print # of specification and the model estimated
			di "`sk' k1=`k1' k2=`k2'  k3=`k3' k4=`k4' k5=`k5' k6=`k6' k7=`k7' `spec' "
						
   *RUN `SPEC' AND SAVE RESULTS
		quietly: `spec'
		
	*SAVE RESULTS
		*point estimate and p-value 
			mat t=r(table)
			local b=t[1,1]  //beta of first term
			local p=t[4,1]  //p-value of 1st term
			local n=e(N)    //Save # of observations to verify outlier rule
	
		*Baseline effect sizes for male vs female
				*For males
					quietly: if `k3'==1 margins,  atmeans at(female=0)     //Estimating model with discrete male/female, get prediction for males
					quietly: if `k3'==2 margins,  atmeans at(masfem=2.53)  //Estimating model with continuous masfem, get prediction for average masfem for males
					matrix em=r(b)                                         //Store the prediced count as matrix
					local  em=em[1,1]                                      //Extract the scalar
				*For females			
					quietly: if `k3'==1 margins,  atmeans at(female=1)     //Estimating model with discrete male/female, get prediction for males
					quietly: if `k3'==2 margins,  atmeans at(masfem=8.29)  //Estimating model with continuous masfem, get prediction for average masfem for males
					matrix ef=r(b)                                         //Store the prediced count as matrix
					local  ef=ef[1,1]                                      //Extract the scalar
					
		*Baseline effect sizes for damages
				    if `k5'==1 {             //for linear damages go from 2k to 4k
						local d1 2000
						local d2 4000
						}
						
					if `k5'==2 {              //for loglinear damages go from log(2k) to log(4k)
						local d1=(log(2000))
						local d2=(log(4000))
						}
					quietly margins, atmean at(`dam'=(`d1'))             // # of deaths if damages are 2000
						matrix dydx1=r(b)                      // Save number as matrix
						local  dydx1=dydx1[1,1]                // Now as scalar
					
					quietly margins, atmean at(`dam'=(`d2'))             // # of deaths if damages are 4000
						matrix dydx2=r(b)                      // Save number as matrix
						local  dydx2=dydx2[1,1]                // Now as scalar
				
		*Compute adjustment for anti-log transformation for both effect sizes (dam and male vs female)
					if `k4'==1 {
						quietly predict lnd_hat if e(sample)      //fitted values for log(death)
						quietly gen e_lnd_hat=exp(lnd_hat)-1      //Exponentiate
						quietly reg d e_lnd_hat, noconstant       //Find correcting factor a la Woolrdige Chapter 6, example 6.7
						local ln_adjust=_b[e_lnd_hat]             //Save ln_adjust, the correcting factor for anti-log transformation
						quietly gen d_hat=e_lnd_hat*`ln_adjust'   //Created fitted values for d
						quietly drop lnd_hat e_lnd_hat            //Drop auxiliary variables no longer needed
						}					

		*Now adjust damages if needed
					if `k4'==1 local edam=((exp(`dydx2')-exp(`dydx1'))*`ln_adjust')   //If log model, exponentiate and adjust
					if `k4'==2 local edam=(`dydx2'-`dydx1')                           // If negative binomial, predicted values are lifes
								
		*Now adjust male female if needed
					if `k4'==1 local edif=((exp(`ef')-exp(`em'))*`ln_adjust')  //if log regression, exponentiate to get deadths rather than log(deaths) and then adjust using ln_adjust (see above)
					if `k4'==2 local edif=(`ef'-`em')			
					
		*Measure fit of model
			*Get d_hat
				*For negative binomial
				    if `k4'==2 quietly predict d_hat if e(sample)  //generate values only for the observations that were included in the regression
				
			*Mean absolute error
					quietly gen e_abs=abs(d-d_hat) //compute absolute difference fitted and actual value
					quietly tabstat e_abs,stats(mean) save  //compute mean
					matrix a=r(StatTotal)        //intro matrix
					local mad=a[1,1]                //into saveable scale
				
			*Mean absolute error, not counting the 5 outlier observations
					quietly tabstat e_abs if d<400 & dam<52270,stats(mean) save  //compute median
					matrix a=r(StatTotal)       
					local mad_clean=a[1,1]                
			
			*save results
				post `scurve'  ("`spec'") (`n') (`d_max') (`dam_max') ///
				(`k1') (`k2') (`k3') (`k4') (`k5') (`k6') (`k7') (`b') (`p') (`em') (`ef')     ///
				(`edif') (`edam') (`mad') (`mad_clean')
					
*/	
			*Add 1 specification counter	
				local sk=(`sk'+1)			
				drop d_hat  e_abs
			*Close loop 7
			}
			*Close loop 6
			}
			*Close loop 5
			}
			*Close loop 4
			}
			*Close loop 3
			}
			*Close loop 2
			} 
			*Close loop 1
			} 
	
		postclose `scurve'
	
	
	


	
	
	
	
