*************************************************************
**STATA program - INFERENTIAL SPECIFICATION CURVE ON JUNG ET AL. "FEMALE HURRICANES ARE DEADLIER"
*Written by Uri Simonsohn (uws@wharton.upenn.edu)
*Last update: 2015 03 19
*


*************************************************************
*THE MONTECARLO WAS RUN IN PARALEL IN THREE BATCHES, HERE THEY GET MERGED

/* cd "C:\uri\research\Specification Curve\Data\"
	use             monte_hurricanes_0_199,clear
		drop if monte==199
	append using    monte_hurricanes_199_250
	append using    monte_hurricanes_251_500
	
*SAVE ALL THREE
	save monte_hurricanes_0_500
*/

*************************************************************
*OUTLINE:
*
*The program below proceed in 5 major steps
*
*1  Load the data
*2  Compute share of effects that are of the predicted sign
*3  Summarize statistical significance 
*4  ANALYSES
*4.1 Median	
*4.2 Share of dominant sign effett
*4.3 Share of dominant and significant sign estimates
*5   Plot
*************************************************************

*1 - Load the data
		cd "C:\uri\research\Specification Curve\Data\"
		use monte_hurricanes_0_500,clear
		*Rename the montecarlo loop counter
		rename monte montek
/*******************************************************CODEBOOK*******************************************************
		*Each line is the regression result of one specification
			 montek: simulation # (0 corresponds to the actual non-shuffled data
			 k1-k7 : operationalization counters (e.g., k1=1 implies that the operationalization 1, had value 2 in this specification
			 b     : point estimate for first predictor in the regression. It corresponds to female*damages interaction in most specifications. When only female main effect to the main effect. When only the z3 interaction to taht interaction
			 p     : p-value for b
			 em    : predicted deaths, evaluated at sample means, for male hurricane 
			 ef    : predicted deaths, evaluated at sample means, for female hurricane 
			 edif  : key effect size metri, difference in predicted deaths for female-male hurricanees (ef-em)
***********************************************************************************/
 
 	
  	
*2  Compute share of effects that are of the predicted sign
	*2.1 Create indicator for whether effect size is positive or negative (positive: more deaths with female hurricane)
		gen      epos=1
		replace  epos=0 if edif<0
		
	*2.2 Count specifications that are positive in each bootstrapped sample
		egen pos_freq=sum(epos),by(montek)
		gen pos_share=pos_freq/1728
		
	*2.3 Reverse sign of effect size when the majority of effects are negative
		*If most effects are negative, sign is switched
		*The new variable edif_2s is like a 2-sided measure of effect size
			gen edif_2s=edif                       
			replace edif_2s=-edif if pos_share<.5  //Switch sign if most estimates are negative

	*2.4 Create dominant effect size dummy
			gen edom=1
			replace edom=0 if edif_2s<0

*3 Summarize statistical significance 
	*3.1 Dummy variable for each specification indicating p<.05 or not
			gen sig=0                           //By default n.s.
			replace sig=1 if p<.05              //unless p<.05
			egen sig_freq=sum(sig),by(montek)   //summarize by montek the # that are significant
			label var sig     "Effect size significant? p<.05"
	
	*3.2 Dummy variable for each specification indicating p<.05 and edom>0 or not.
			gen sig_dom=sig                           //By default assume the significant result has predicted sign
			replace sig_dom=0 if edom==0              //unless it does not.
			egen sig_dom_freq=sum(sig_dom),by(montek) //summarize by monetek the # fhtat are significant and dominant
			label var sig_dom "Effect size significant and of dominant sign? p<.05"
			
*4 ANALYSES
*4.1 Median	
	*4.1.1 Compute in observed data
		tabstat edif_2s if montek==0,stats(median) save   //compute it . note: the "save" command save into the matris StatTotal the results
		local median_obs=el(r(StatTotal),1,1)             //save median onto macro el(M,j,k) takes element from row j, columm k, out of matrix M
			
	*4.1.2 Compute median effect size in each simulated data
			preserve                                           //Save dataset becuase we will collapse by Montek and then return to it
			collapse (p50) median_edif_2s=edif_2s ,by(montek)  //COmpute median in each dataset
						
	*4.1.2	Computer proportion of simulations with median value at least as great as that obsrved
			gen     med_bigger=0                                   //Is the median effect size for this simulation larger than that observed? Assume not
			replace med_bigger=1 if median_edif_2s>=`median_obs'   //Unless it is 
			tab med_bigger if montek>0                            //Tabulate result mentioned in paper: 53.6% of simulatiosn have at least a median of 1.56
			restore	                                              //Go back to full dataset
			
*4.2 Share of dominant sign effett
		*Count # of dominant sign estimates
			egen dom_freq=sum(edom),by(montek)                 //Generate variable with totals by simulation
			tab dom_freq if montek==0                          //1704 in the observed data
			tab dom_freq if montek>0                           //17.8% in the simulated data have at least 1704 of the same sign
			
*4.3 Share of dominant and significant sign estimates
		*Share significant in dominant direction
			tab sig_dom if montek==0                    //37 specifications are significant in the original
			tab sig_dom_freq if montek>0                //85% of bootstrapped samples have at least 37 significant effects in the dominant direction
														//   the outouput shows the c.d.f. for each value. For 36 significant p-values it is 15%, so for 37 or larger it is 100%-15%=85%

	
*5 Graphs			
*5.1 Sort each simulation's 1728 specifications by effect size
	sort montek edif_2s        //sort
	by montek: gen rank_edif_2s=_n     //create variable rank, indicating rank of effect size

*5.2 Compute percentiles for each ranked specification (confidence interval lines)
	sort rank_edif_2s
	by rank_edif_2s:  egen p025 =pctile(edif_2s), p(2.5) 
	by rank_edif_2s:  egen p975 =pctile(edif_2s), p(97.5)
	by rank_edif_2s:  egen p50  =pctile(edif_2s), p(50)
			

*5.3 Get labels read
	keep if montek==0      //equivalent to collpase, since the percentiles are included in each montek simulation, keeep the original data						
	label var edif_2s "Observed Data"
	label var p025    "2.5th and 97.5th under-the-null"
	label var p50     "Median under-the-null"
			
			
*5.4 Plot itself		
	line p50  rank_edif_2s,title("Femeninity of Hurricane Name and Deaths")         /// start with the median
		ylab(,nogrid)                                            /// no gridlines
		xlab(1 500 1000 1500 1728)                               /// labels in the x-axis
		ytitle("{bf:Additional Fatalities}" "{it:(Female-Male hurricane)}")                      /// y-axis title
		xtitle("{bf:Specification # (sorted by effect size)}")   /// x-axis title
	legend(order(5 1 2) size(small) rows(1) pos(12) symxsize(medium) ) ///legend
	lpattern(dash)  lcolor(black)  || ///
	line p025  rank_edif_2s  ,lcolor(gray) lpattern(shortdash) lwidth(thin)    ||    ///   confidence intervalk line at 2.5%
	line p975  rank_edif_2s  ,lcolor(gray) lpattern(shortdash) lwidth(thin)     ||   ///  confidence intervalk line at 97.5%
	scatter edif_2s  rank_edif_2s  ,msize(tiny)   mcolor(blue) ||                    ///  observed specification curve           
	scatter edif_2s rank_edif_2s if edif_2s==.                                       ///  Just for the marker to be larger in the legend, workaround: create empty series, include in the legend.
	, mcolor(blue) msize(small) yline(0,lwidth(vvthin) lcolor(255 102 102))   ///
			
			
	graph export "C:\uri\research\Specification Curve\Tables\Fig2a_hurricane_boot.png" , width(4000) height(2600) replace          /// Save graph in high quality .png
	
			
			

