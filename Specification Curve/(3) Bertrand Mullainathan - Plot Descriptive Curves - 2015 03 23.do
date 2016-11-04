**THIS SINGLE PROGRAM CAN BE RUN FOR THE DESCRIPTIVE CURVES FOR MAIN EFFECT AND INTERACTIN
* TO RUN FOR EACH DO THE FOLLOWING

*FOR MAIN EFFECT, SKIP THE LINES "FOR INTERACTION

	cd "C:\uri\research\Specification Curve\Data\"
	use "specifications_lakisha",clear
	
	
	*For main effect
		gen b=eblack
		gen p=pblack
		global title "Main Effect of Black Name"
		
	
	*SKIP IF RUNNING THE INTERACTION
	*for interaction
		replace b=einter
		replace p=pinter
		global title "Interaction Effect of Black Name & Quality"
	
	
*Stack values of the specification indicators
	gen k1c=k1
	gen k2c=k2+2+2
	replace k2c=k2c+2 if k2>3
	gen k3c=k3+2+2+15+2+2+2
	
		
	
*Significant vs non significant results
	gen b_sig=b
	replace b_sig=. if p>.05
	label var b_sig "p<.05"
	
	gen b_ns=b
	replace b_ns=. if p<.05
	label var b_ns "n.s."
	
*Specification in paper
	gen paper=0
	replace paper=1 if (k1==2 & k2==1 & k3==1) | (k1==2 & k2==6 & k3==1)

	gen b_paper=.
	replace b_paper=b if paper==1
	
	label var b_paper "Original Specifications"
	
	gen k1c_paper=.
	gen k2c_paper=.
	gen k3c_paper=.
	
	replace k1c_paper = k1c if paper==1
	replace k2c_paper = k2c if paper==1
	replace k3c_paper = k3c if paper==1
	
		
	
*Sort effect size
	sort b
	gen sk=_n
	label var sk "Specification # - sorted by effect size"
	

	label var k1 "Model (dprobit vs OLS)"
	label var k2 "Quality measure"
	label var k3 "Subsample"

	anova b k1 k2 k3 
	
	
	
*Graph parameters
	summarize b
	global brange=r(max)-r(min)
	global bmin=r(min)
	global bmax=r(max)
	global from_y=$bmin-4.5*$brange
	global graph_height=28*4/3
	
	  
	 di $bmin
	 di $brange
	 di $from_y
	 di $graph_height
	 
	 	 
	scatter k1c k2c k3c  sk, xlab(0(10)90) xsize(10) ysize(6) msize(vsmall vsmall vsmall) title("$title") ///
	ylab(0(1)$graph_height ) ///
		 /// 
			ylabel(1 "OLS" 2 "Probit (marginal effects)" ///
		 /// 
	       5 "Randomly assigned: High vs low " 6 "Sum of individual quality 1/0s continuous)" 7 "Sum of individual quality 1/0s (median split)" ///
		   10 "Based on full sample, without covariates, continous" ///
		   11 "Based on full sample, with    covariates, continous" ///
		   12 "Based on full sample, without covariates, median split" ///
		   13 "Based on full sample, with    covariates, median split" ///
		   14 "Based on Whites, without covariates, continous" ///
		   15 "Based on Whites, with    covariates, continous" ///
		   16 "Based on Whites, without covariates, median split" ///
		   17 "Based on Whites, with    covariates, median split" ///
	       18 "Based on Blacks, without covariates, continous" ///
		   19 "Based on Blacks, with    covariates, continous" ///
		   20 "Based on Blacks, without covariates, median split" ///
		   21 "Based on Blacks, with    covariates, median split" ///
		   ///
		   26  "Men and Women" 27 "Only Women" 28 "Only Men" 36 " " ///
		 /// 
  		   3 "*{bf:Model}*" 23 "*{bf:Operationalizing CV quality}*" 22 "{it:Predicted callback in 1st stage     }" ///
		   8 "{it: Other measures of CV quality}      " ///
		   29 "*{bf:Gender}*" ,angle(0) labsize(vsmall) tstyle(notick)) || ///
		scatter b_ns  sk, yaxis(2) mcolor(eltblue) msize(vsmall) legend(order(4 5 6) cols(3) size(small) rowgap(.5) pos(12)  )   ytitle("{bf:% difference}",axis(2) placement(north))  || ///
		scatter b_sig sk,yaxis(2) mcolor(black) msize(vsmall)  ylab(, axis(2) labsize(tiny) angle(0) ) yscale(range($from_y $bmax) axis(2))  ///
		yline(0, axis(2) lw(thin) lcolor(gray))  yline(3 24 23 8 22 29, lw(thick) lcolor(white))  ///
		yline(29.5(.5)37 ,axis(1) lw(vthick) lcolor(olive_teal)) || ///
		scatter b_paper sk, yaxis(2)  msize(medlarge) mcolor(eltblue)  
	


*Save graph in high definition
	*IF I run the main effect run this
		graph export "C:\uri\research\Specification Curve\Tables\FigS3a Main Effect Black - Descriptive.png", width(1400) replace
	*If I run the interaction effect run this
		graph export "C:\uri\research\Specification Curve\Tables\FigS4 Interaction - Descriptive.png", width(1400) replace
	

	
	tabstat rmse_clean,by(k4) stats(mean sd median)	
	
	
