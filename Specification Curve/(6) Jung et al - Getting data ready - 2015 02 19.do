	*Copy pasted from C:\Uri\Research\False Positive Economics\Data\False Positive Economics - Hurricane spreadsheets 2015 01 09.xlsx

	cd "C:\Uri\Research\Specification Curve\Data"
    use hurricanes_2015_01_09,clear
 
  **********************************************************
**(1) COMPLETE MERGE FROM PNAS WITH NEW DATA
**********************************************************

*Variables not in the PNAS paper added for specification curv
	*Femeninity by 9 raters replaced with 30 Mturk respondents so as to add Katrina and Audrey
	    *First, show they are similar (r=.9805)
			corr masfem masfem_mturk
		*But not so similar within gender
			corr masfem masfem_mturk if masfem<5
			corr masfem masfem_mturk if masfem>5
			
		*Replace femeninity rating with mturk one
			drop masfem 
			rename masfem_mturk masfem
			label var masfem "How femenine is name 1-very masculine 11-very femenine"
	
	*Damages are from website that automatically updates by inflation and other factors,new values obtained
		*First, show they are similar (r=.95)
		*    note: it is puzzling that the correlation is not r=1, perhaps the calculations are updatd over time?
			corr ndam ndam15
		*Now drop the PNAS one, and rename the mturk one
			drop ndam
			rename ndam15 dam
			label var dam "Damages in $M of dollars"

**********************************************************
**(2) CREATE NEW VARIABLES AND RENAME SOME
**********************************************************

*Log
	gen  lnd=log(alldeaths+1)
	gen  lndam=log(dam)
	label var lnd   "Log(fatalities+1)"
	label var lndam "Log(Damages in $M of dollars)"
			
*Gender-->female
    rename gender_mf female
			
*deaths
	rename alldeaths d
	label var d "# Fatalities"

*year squard
	gen year2=year*year
*post 1979
	gen     post79 =0
	replace post79=1 if year>1979
	
*Standardize hurricane characteristics
	egen zwin=std(win)
	egen zcat=std(category)
	egen zmin=std(min)
	replace zmin=-1*zmin
	gen z3=(zwin+zcat+zmin)/3
	cor zwin zcat zmin z3 lnd dam lndam
	
************************************
* (3) Descriptiv stats
	scatter d dam || lfit d dam,title("Fig S1A - All Hurricanes")
	scatter d dam if d<1000|| lfit d dam,title("Fig S1B - All Hurricanes except Katrina")

	histogram dam ,frac title("Fig S2A - $ Damages") bin(10)
	histogram lndam ,frac title("Fig S2A - log($ damages)") bin(10)
	histogram lnd if d<400,frac title("Without Katrina & Audrey") bin(6)
	
	pnorm lnd,title("log(deaths+1) is reasonably close to normal")
	pnorm lndam, title("log(damages) is reasonably close to normal")
	
	scatter d ndam if d<400  ,title("Damages & Deaths")
	scatter d ndam if d<400 || lfit d dam  ,title("Damages & Deaths")
	
	scatter lnd lndam, title("All Hurricanes (logs)") 
*/
	
	save hurricanes_ready_2015_02_19
