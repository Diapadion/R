************************************************************* 
**STATA program - INFERENTIAL SPECIFICATION CURVE ON BERTRAND AND MULLAINATHAN (AER 2004) "ARE EMILY AND GREG MORE EMPLOYABLE THAN LAKISHA AND JAMAL? A FIELD EXPERIMENT ON LABOR MARKET DISCRIMINATION"
*Written by Uri Simonsohn (uws@wharton.upenn.edu)
*
*Last update: 2015 03 19
*

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



*1 - Load the data (file was generated with program (4) Bertrand Mullainathan - Bootstrap under null.do"
	cd "C:\uri\research\Specification Curve\Data\"
	use monte_lakisha,clear
	
	*REcode sign and rename variables for main effect and interaction
		rename pblack pb
		rename pinter pi
		gen b= -eblack
		gen i= -einter
		
	/*******************************************************CODEBOOK*******************************************************
		*Each line is the regression result of one specification
			 montek: simulation # (0 corresponds to the actual non-shuffled data
			 k1-k3 : operationalization counters (e.g., k1=1 implies that the operationalization 1, had value 2 in this specification
			 eb: point estimate for impact on probability of resume receiving a callback when name is distinctively AFrican American
			 pb: p-value for eblack
			 ei: marginal effect from the interaction with quality (see STATA program (4) for details)
			 pi: p-value for einter
			 
	***********************************************************************************/
		
	*2  Compute share of effects that are of the predicted sign
	*2.1 Create indicator for whether effect size is positive or negative (negative: fewer callbacks with Black name)
		*main effect
			gen      bpos=1
			replace  bpos=0 if b<0
			
		*Interaction
			gen      ipos=1
			replace  ipos=0 if i<0
	
	*2.2 Count specifications that are positive in each shuffled sample
			egen bpos_freq=sum(bpos),by(montek)
			gen  bpos_share=bpos_freq/90
				
			egen ipos_freq=sum(ipos),by(montek)
			gen  ipos_share=ipos_freq/90
		
		
	*2.3 Reverse sign of effect size when the majority of effects are positive
		*Main effect
			gen     b_2s=b
			replace b_2s=-b if bpos_share>.5  //Switch sign if most estimates are negative

		*Interaction
			gen     i_2s=i
			replace i_2s=-i if ipos_share>.5  //Switch sign if most estimates are negative
			
	*2.4 Create dominant effect size dummy
		*Main Effect
			gen bdom=1
			replace bdom=0 if b_2s>0

		*Interaction
			gen idom=1
			replace idom=0 if i_2s>0
			
*3 Summarize statistical significance 
	*3.1 Dummy variable for each specification indicating p<.05 or not
		*Main Effect
			gen bsig=0                           //By default n.s.
			replace bsig=1 if pb<.05              //unless p<.05
			egen bsig_freq=sum(bsig),by(montek)   //summarize by montek the # that are significant
		*interaction
			gen isig=0                           //By default n.s
			replace isig=1 if pi<.05              //unless p<.05
			egen isig_freq=sum(isig),by(montek)   //summarize by montek the # that are significant

	*3.2 Dummy variable for each specification indicating p<.05 and edom>0 or not.
		*Main Effect
			gen     bsig_dom=bsig                     //By default assume the significant result has predicted sign
			replace bsig_dom=0 if bdom==0            //unless it does not.
			egen bsig_dom_freq=sum(bsig_dom),by(montek) //summarize by monetek the # fhtat are significant and dominant
		*Interaction
			gen     isig_dom=isig                     //By default assume the significant result has predicted sign
			replace isig_dom=0 if idom==0            //unless it does not.
			egen isig_dom_freq=sum(isig_dom),by(montek) //summarize by monetek the # fhtat are significant and dominant
			
			
			
			
*4 ANALYSES
*4.1 Median	
	*4.1.1 Compute in observed data
		*Main effect
			tabstat b_2s if montek==0,stats(median) save   //compute it . note: the "save" command save into the matris StatTotal the results
			local bmed_obs=el(r(StatTotal),1,1)             //save median onto macro el(M,j,k) takes element from row j, columm k, out of matrix M
		*Interaction
			tabstat i_2s if montek==0,stats(median) save   
			local imed_obs=el(r(StatTotal),1,1)            

	*4.1.2 Compute median effect size in each simulated data
			preserve                                           //Save dataset becuase we will collapse by Montek and then return to it
			collapse (p50) bmed=b_2s (p50) imed=i_2s ,by(montek)  //COmpute median in each dataset
									
	*4.1.3	Computer proportion of simulations with median value at least as great as that obsrved
		*main effect
			gen     bmed_bigger=0                                   //Is the median effect size for this simulation larger than that observed? Assume not
			replace bmed_bigger=1 if bmed<=`bmed_obs'               //Unless it is 
		*interaction
			gen     imed_bigger=0                                   //Is the median effect size for this simulation larger than that observed? Assume not
			replace imed_bigger=1 if imed<=`imed_obs'             //Unless it is 
			
			tab bmed_bigger if montek>0                             //Tabulate result mentioned in paper: 53.6% of simulatiosn have at least a median of 1.56
			tab imed_bigger if montek>0
					restore	                                              //Go back to full dataset
			
*4.2 Share of dominant sign effett
	*Main efect
			egen bdom_freq=sum(bdom),by(montek)                 //Generate variable with totals by simulation
			tab bdom_freq if montek==0                          //90 in the observed data
			tab bdom_freq if montek>0                           //25.2% in the simulated data have at least 90 of the same sign, dividing by 2 we get the reported p=.125
			
			*Note: when computing p-values for discrete distributions it is common to split the mass exactly at the value by 50% (see Lancaster 1961 "Significance Tests in Discrete Distributions"
			*we do that here.at's what's done in the paper, 25% of simulations have exactly 90 negative point estimates, 25%/2=.125
			
			
	*Interaction
			egen idom_freq=sum(idom),by(montek)                 //Generate variable with totals by simulation
			tab idom_freq if montek==0                          //79 in the observed data
			tab idom_freq if montek>0                           //12.6% strictly larger, .8% exactly the same, add half of that we get 12.6+.4=13%
			
			
*4.3 Share of dominant and significant sign estimates
		*Main efect
			tab bsig_dom if montek==0                    //85 specifications are significant in the original
			tab bsig_dom_freq if montek>0                //0% of shuffled samples have at least 85
		*Interaction
			tab isig_dom if montek==0                    //13 specifications are significant in the original
			tab isig_dom_freq if montek>0                //15.4% of shuffled samples are stricly higher than 13, 1.6% are exactly 13, 15.4%+.8%=16.2%
														

	
*5 Graphs			
*5.1 Sort each simulation's 1728 specifications by effect size
	*Main effect
		sort montek b_2s        //sort
		by montek: gen rank_b_2s=_n     //create variable rank, indicating rank of effect size

	*Interaction
		sort montek i_2s        //sort
		by montek: gen rank_i_2s=_n     //create variable rank, indicating rank of effect size

		
		
*5.2 Compute percentiles for each ranked specification (confidence interval lines)
	*Main effect
		sort rank_b_2s
		by rank_b_2s:  egen bp025 =pctile(b_2s), p(2.5) 
		by rank_b_2s:  egen bp975 =pctile(b_2s), p(97.5)
		by rank_b_2s:  egen bp50  =pctile(b_2s), p(50)
		
	*Interaction
		sort rank_i_2s
		by rank_i_2s:  egen ip025 =pctile(i_2s), p(2.5) 
		by rank_i_2s:  egen ip975 =pctile(i_2s), p(97.5)
		by rank_i_2s:  egen ip50  =pctile(i_2s), p(50)


			
			
*5.3 Get labels read
	keep if montek==0      //equivalent to collpase, since the percentiles are included in each montek simulation, keeep the original data						
	label var b_2s "Observed Data"
	label var i_2s "Observed Data"
	label var bp025    "2.5th and 97.5th under-the-null"
	label var bp50     "Median under-the-null"
	label var ip025    "2.5th and 97.5th under-the-null"
	label var ip50     "Median under-the-null"

	
			
*5.4 Plot itself		
	*Main Effect
		sort rank_b_2s
		line bp50  rank_b_2s,title("Impact of Black Name on Callback Rate")         /// start with the median
			ylab(,nogrid)                                         					   /// no gridlines
			xlab(1 45 90)                             					  /// labels in the x-axis
			ytitle("{bf:Callback %}" "{it:(Black - NonBlack Name)}")                      /// y-axis title
			xtitle("{bf:Specification # (sorted by effect size)}")   /// x-axis title
		legend(order(5 1 2) size(small) rows(1) pos(12) symxsize(medium) ) ///legend
		lpattern(dash)  lcolor(black)  || ///
		line bp025  rank_b_2s  ,lcolor(gray) lpattern(shortdash) lwidth(thin)    ||    ///   confidence intervalk line at 2.5%
		line bp975  rank_b_2s  ,lcolor(gray) lpattern(shortdash) lwidth(thin)     ||   ///  confidence intervalk line at 97.5%
		scatter b_2s  rank_b_2s  ,msize(tiny)   mcolor(blue) ||                    ///  observed specification curve           
		scatter b_2s rank_b_2s if b_2s==.                                       ///  Just for the marker to be larger in the legend, workaround: create empty series, include in the legend.
		, mcolor(blue) msize(small) yline(0,lwidth(vvthin) lcolor(255 102 102))   
			
		graph export "C:\uri\research\Specification Curve\Tables\Fig2b_Lakisha_Main_boot.png" , width(4000) height(2600) replace          /// Save graph in high quality .png
	
	*Interaction
		sort rank_i_2s
		line ip50  rank_i_2s,title("Return of Quality Resume for Black vs NonBlack Name")         /// start with the median
			ylab(,nogrid)                                         					   /// no gridlines
			xlab(1 45 90)                             					  /// labels in the x-axis
			ytitle("{bf:Benefit of Quality on Callback %}" "{it:(Black - NonBlack Name)}")                      /// y-axis title
			xtitle("{bf:Specification # (sorted by effect size)}")   /// x-axis title
		legend(order(5 1 2) size(small) rows(1) pos(12) symxsize(medium) ) ///legend
		lpattern(dash)  lcolor(black)  || ///
		line ip025  rank_i_2s  ,lcolor(gray) lpattern(shortdash) lwidth(thin)    ||    ///   confidence intervalk line at 2.5%
		line ip975  rank_i_2s  ,lcolor(gray) lpattern(shortdash) lwidth(thin)     ||   ///  confidence intervalk line at 97.5%
		scatter i_2s  rank_i_2s  ,msize(tiny)   mcolor(blue) ||                    ///  observed specification curve           
		scatter i_2s rank_i_2s if i_2s==.                                       ///  Just for the marker to be larger in the legend, workaround: create empty series, include in the legend.
		, mcolor(blue) msize(small) yline(0,lwidth(vvthin) lcolor(255 102 102))   
			
		graph export "C:\uri\research\Specification Curve\Tables\Fig2c_Lakisha_Interaction_boot.png" , width(4000) height(2600) replace          /// Save graph in high quality .png
	
	
	
			
			

	
	
	
	
	
	
	
			

