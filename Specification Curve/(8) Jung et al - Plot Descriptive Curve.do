


	cd "C:\Uri\Research\Specification Curve\Data"
	use specifications_hurricanes,clear

*Share significant
	gen sig=.
	replace sig=1 if p<.05
	replace sig=0 if p>.05
	

	
*Stack values of the specification indicators
	gen k1c=k1
	gen k2c=k2+3+2
	gen k3c=k3+3+2+4+2
	gen k4c=k4+3+2+4+2+2+2
	gen k5c=k5+3+2+4+2+2+2+2+2
	gen k6c=k6+3+2+4+2+2+2+2+2+2+2
	gen k7c=k7+3+2+4+2+2+2+2+2+2+2+6+2
	
	
*Significant vs non significant results
	gen edif_sig=edif
	replace edif_sig=. if p>.05
	label var edif_sig "p<.05"
	
	gen edif_ns=edif
	replace edif_ns=. if p<.05
	label var edif_ns "n.s."
	
*Specification in paper
	gen paper=0
	replace paper=1 if (k1==3 & k2==1 & k3==2 & k4==2 & k5==1 & k6==2 & k7==1)
	gen edif_paper=.
	replace edif_paper=edif if  paper==1
	label var edif_paper "Original Specification"
	
*Label variable
	label var k1 "Outliers"
	label var k2 "Female 1/0 vs Likert"
	label var k3 "Damages: $ vs log($)"
	label var k4 "OLS Log() vs negative binomial"
	label var k5 "what's the prediction? (Interaction with {min,win,category} or Main Effect"
	label var k6 "Controlling for year&interactions"
	
	
*ANOVA predicting effect size with operationalizations:
	anova edif k1 k2 k3 k4 k5 k6 k7
	*Get 
	estat esize
	anova edif k1 k2 k3 k4 k5 k6 k7  k1#k5 k2#k5 k3#k5 k4#k5 k6#k5 k7#k5
	estat esize
	
	
	
	
	
		
	
*Graph parameters
	summarize edif
	global brange=r(max)-r(min)
	global bmin=r(min)
	global bmax=r(max)
	global from_y=$bmin-4.5*$brange
	global graph_height=36*4/3
	
	 di $bmin
	 di $brange
	 di $from_y
	 di $graph_height
	 
	 sort edif
	 gen sk=_n
	 label var sk "Specification #"
	 
	 
*Program that plots
capture program drop plot_scurve
	program plot_scurve
	scatter k1c k2c k3c k4c k5c k6c k7c sk, xlab(1 50 250 300) xsize(10) ysize(6)   msize(vtiny vtiny vtiny vtiny vtiny vtiny vtiny) ///
	ylab(1(1)$graph_height, nogrid  )  ///
	ylabel(1 "Drop none" 2 "Drop 1 highest deaths"  3 "Drop 2 highest deaths" 									///
			///
	       6 "Drop none" 7 "Drop 1 highest damages" 8 "Drop 2 highest damages" 9 "Drop 3 highest damages"      ///
		   ///
		   12  "Female (1/0)" 13 "Rating on likert scale (1-11)"                                                                    ///
		   ///
		   16 "Log(fatalities+1)" 17 "Negative Binomial"                                                                           ///
		   ///
		   20 "Linear: $" 21 "Log:  ln($)"                                                                                      ///
		   ///
		   24 "Interaction with Damages" 25 "Interaction with Damages & Min Pressure" 26 "Interaction with Damages & Wind" 27 "Interaction with Damages & Hurricane Category" ///
		   28 "Interaction with Damages & Std.Mean(Pressure, Wind, Category)" 29 "Main effect"                                                                      ///
		   ///
		   32 "None" 33 "Year*Damages" 34 "Post 1979 (1/0)*Damages"                                                      ///
           ///		                                                                              
  		   4 "{bf:Dropping outliers}" 10 "{bf:Dropping leverage points}" 14 "{bf:Femeninity of name}" 18 "{bf:Model}" 22 "{bf:Functional for Damages}" ///
		   30 "{bf:Name femeninity: Main effect or Interaction with intensity}" 35 "{bf:Controlling for year}" 48 " " ///
		   ,angle(0) labsize(tiny) tstyle(notick) )  || ///
	scatter edif_ns sk, yaxis(2) mcolor(eltblue) msize(vtiny) legend(order(10 11 12) cols(3)  size(vsmall) rowgap(.5) pos(12) ring(0)  )    xtitle("{bf:Specification #}")   ytitle("{bf:Extra Deaths}",axis(2) placement(north))  || ///
	scatter edif_sig sk,yaxis(2) mcolor(black) msize(vtiny)  ylab(, axis(2) labsize(tiny) angle(0) nogrid) yscale(range($from_y $bmax) axis(2))  ///
	yline(0, axis(2) lw(thin) lcolor(gray))        ///
	yline(37,axis(1) lcolor(black))                ///
	yline(37.5(.5)49 ,axis(1) lw(vthick) lcolor(olive_teal)) || ///
	scatter edif_paper sk, yaxis(2) mcolor(black) msize(small) || /// plot just to get legend to work
	scatter edif_sig edif_ns edif_paper if edif_sig==.,yaxis(2) msize(vsmall vsmall small) mcolor(black eltblue black)
	
	end
	
	

******************************

*Plot whole thing
	*1) whole thing
		
		*save temp_hurricanes
		
		use temp_hurricanes,clear
	*2) First 50, last 50, random 20% in between 
			set seed 1976
			gen rand=runiform()                     			 //Random number to draw at random
			replace rand=. if sk<=50 | sk>1678      			 //Do not count teh first or last 50 for the rank
			egen rank_rand=rank(rand)               			 //Rank the random number
			gen subset=0                            			 //Dummy to indicate variables to keep
			replace subset=1 if !missing(edif_paper)             //Keep paper
			replace subset=1 if rank_rand<=199		             //Keep 199 random subsets
			replace subset=1 if sk<=50 | sk>1678
			keep if subset==1
			replace sk=_n                          			   //Renumber specifications
			
			
			*Draw it
				plot_scurve
			
			
		cd "C:\uri\research\Specification Curve\Tables"
		graph export Fig1_Hurricanes.png,width(9600) replace

		
		tab edif
