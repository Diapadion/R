### accuracies

aacc <- 0
bacc <- 0
cacc <- 0
eacc <- 0
hacc <- 0
lacc <- 0
macc <- 0
oacc <- 0
pacc <- 0


i=1
while(adata[i,9]!='bl'){
	aacc[i]<-adata[i,9]
	aacc[i]=aacc[i]-1
	i=i+1	
	}
	i=1
while(bdata[i,9]!='bl'){
	bacc[i]<-bdata[i,9]
	bacc[i]=bacc[i]-1
	i=i+1
	}
	i=1
while(cdata[i,9]!='bl'){
	cacc[i]<-cdata[i,9]
	cacc[i]=cacc[i]-1
	i=i+1
	}
i=1
while(edata[i,9]!='bl'){
	eacc[i]=edata[i,9]
	eacc[i]=eacc[i]-1
	i=i+1
	}
i=1
while(hdata[i,9]!='bl'){
	hacc[i]=hdata[i,9]
	hacc[i]=hacc[i]-1
	i=i+1
	}
	i=1
while(ldata[i,9]!='bl'){
	lacc[i]=ldata[i,9]
	lacc[i]=lacc[i]-1
	i=i+1
	}
	i=1
while(mdata[i,9]!='bl'){
	macc[i]=mdata[i,9]
	macc[i]=macc[i]-1
	i=i+1
	}
	i=1
while(odata[i,9]!='bl'){
	oacc[i]=odata[i,9]
	oacc[i]=oacc[i]-1
	i=i+1
	}
	i=1
while(pdata[i,9]!='bl'){
	pacc[i]=pdata[i,9]
	pacc[i]=pacc[i]-1
	i=i+1
	}
	i=1;
	
# now some test(s?)	
	
scm=NULL	
scm[1] = mean(aacc)
scm[2] = mean(bacc)
scm[3] = mean(cacc)
scm[4] = mean(eacc)
scm[5] = mean(hacc)
scm[6] = mean(lacc)
scm[7] = mean(macc)
scm[8] = mean(oacc)
scm[9] = mean(pacc)


### error

aerr<-NULL
for (i in 1:length(adata[,7])){
	if((adata[i,7]=='B')||(adata[i,7]=='AC')||(adata[i,7]=='ABD')) aerr[i]=1
	else if((adata[i,7]=='C')||(adata[i,7]=='AD')) aerr[i]=2
	else if(adata[i,7]=='D') aerr[i]=3
	else if((adata[i,7]=='ABA')||(adata[i,7]=='ABCB')) aerr[i]=-1
	else if(adata[i,7]=='ABCA') aerr[i]=-2
	else if(adata[i,7]=='ABCD') aerr[i]=0
	else if(adata[i,7]=='-') next
	}
	amer = mean(aerr)
	
	berr<-NULL
for (i in 1:length(bdata[,7])){
	if((bdata[i,7]=='B')||(bdata[i,7]=='AC')||(bdata[i,7]=='ABD')) berr[i]=1
	else if((bdata[i,7]=='C')||(bdata[i,7]=='AD')) berr[i]=2
	else if(bdata[i,7]=='D') berr[i]=3
	else if((bdata[i,7]=='ABA')||(bdata[i,7]=='ABCB')) berr[i]=-1
	else if(bdata[i,7]=='ABCA') berr[i]=-2
	else if(bdata[i,7]=='ABCD') berr[i]=0
	else if(bdata[i,7]=='-') next
	}
	bmer = mean(berr)
	
	cerr<-NULL
for (i in 1:length(cdata[,7])){
	if((cdata[i,7]=='B')||(cdata[i,7]=='AC')||(cdata[i,7]=='ABD')) cerr[i]=1
	else if((cdata[i,7]=='C')||(cdata[i,7]=='AD')) cerr[i]=2
	else if(cdata[i,7]=='D') cerr[i]=3
	else if((cdata[i,7]=='ABA')||(cdata[i,7]=='ABCB')) cerr[i]=-1
	else if(cdata[i,7]=='ABCA') cerr[i]=-2
	else if(cdata[i,7]=='ABCD') cerr[i]=0
	else if(cdata[i,7]=='-') next
	}
	cmer = mean(cerr)
	
	eerr<-NULL
for (i in 1:length(edata[,7])){
	if((edata[i,7]=='B')||(edata[i,7]=='AC')||(edata[i,7]=='ABD')) eerr[i]=1
	else if((edata[i,7]=='C')||(edata[i,7]=='AD')) eerr[i]=2
	else if(edata[i,7]=='D') eerr[i]=3
	else if((edata[i,7]=='ABA')||(edata[i,7]=='ABCB')) eerr[i]=-1
	else if(edata[i,7]=='ABCA') eerr[i]=-2
	else if(edata[i,7]=='ABCD') eerr[i]=0
	else if(edata[i,7]=='-') next
	}
	emer = mean(eerr)
	
	herr<-NULL
for (i in 1:length(hdata[,7])){
	if((hdata[i,7]=='B')||(hdata[i,7]=='AC')||(hdata[i,7]=='ABD')) herr[i]=1
	else if((hdata[i,7]=='C')||(hdata[i,7]=='AD')) herr[i]=2
	else if(hdata[i,7]=='D') herr[i]=3
	else if((hdata[i,7]=='ABA')||(hdata[i,7]=='ABCB')) herr[i]=-1
	else if(hdata[i,7]=='ABCA') herr[i]=-2
	else if(hdata[i,7]=='ABCD') herr[i]=0
	else if(hdata[i,7]=='-') next
	}
	hmer = mean(herr)
	
	lerr<-NULL
for (i in 1:length(ldata[,7])){
	if((ldata[i,7]=='B')||(ldata[i,7]=='AC')||(ldata[i,7]=='ABD')) lerr[i]=1
	else if((ldata[i,7]=='C')||(ldata[i,7]=='AD')) lerr[i]=2
	else if(ldata[i,7]=='D') lerr[i]=3
	else if((ldata[i,7]=='ABA')||(ldata[i,7]=='ABCB')) lerr[i]=-1
	else if(ldata[i,7]=='ABCA') lerr[i]=-2
	else if(ldata[i,7]=='ABCD') lerr[i]=0
	else if(ldata[i,7]=='-') next
	}
	lmer = mean(lerr)
	
	merr<-NULL
for (i in 1:length(mdata[,7])){
	if((mdata[i,7]=='B')||(mdata[i,7]=='AC')||(mdata[i,7]=='ABD')) merr[i]=1
	else if((mdata[i,7]=='C')||(mdata[i,7]=='AD')) merr[i]=2
	else if(mdata[i,7]=='D') merr[i]=3
	else if((mdata[i,7]=='ABA')||(mdata[i,7]=='ABCB')) merr[i]=-1
	else if(mdata[i,7]=='ABCA') merr[i]=-2
	else if(mdata[i,7]=='ABCD') merr[i]=0
	else if(mdata[i,7]=='-') next
	}
	mmer = mean(merr)

	oerr<-NULL
for (i in 1:length(odata[,7])){
	if((odata[i,7]=='B')||(odata[i,7]=='AC')||(odata[i,7]=='ABD')) oerr[i]=1
	else if((odata[i,7]=='C')||(odata[i,7]=='AD')) oerr[i]=2
	else if(odata[i,7]=='D') oerr[i]=3
	else if((odata[i,7]=='ABA')||(odata[i,7]=='ABCB')) oerr[i]=-1
	else if(odata[i,7]=='ABCA') oerr[i]=-2
	else if(odata[i,7]=='ABCD') oerr[i]=0
	else if(odata[i,7]=='-') next
	}
	omer = mean(oerr)
	
		perr<-NULL
for (i in 1:length(pdata[,7])){
	if((pdata[i,7]=='B')||(pdata[i,7]=='AC')||(pdata[i,7]=='ABD')) perr[i]=1
	else if((pdata[i,7]=='C')||(pdata[i,7]=='AD')) perr[i]=2
	else if(pdata[i,7]=='D') perr[i]=3
	else if((pdata[i,7]=='ABA')||(pdata[i,7]=='ABCB')) perr[i]=-1
	else if(pdata[i,7]=='ABCA') perr[i]=-2
	else if(pdata[i,7]=='ABCD') perr[i]=0
	else if(pdata[i,7]=='-') next
	}
	pmer = mean(perr)
	
	scerr=NULL	
scerr[1] = mean(amer)
scerr[2] = mean(bmer)
scerr[3] = mean(cmer)
scerr[4] = mean(emer)
scerr[5] = mean(hmer)
scerr[6] = mean(lmer)
scerr[7] = mean(mmer)
scerr[8] = mean(omer)
scerr[9] = mean(pmer)
	

### total time expended
#     - how does it relate to RT?


### RT

art <- NULL
for ( i in 1:length(adata[,10])){
		art[i]=adata[i,10]
	}
brt <- NULL
for ( i in 1:length(bdata[,10])){
		brt[i]=bdata[i,10]
	}
	crt <- NULL
for ( i in 1:length(cdata[,10])){
		crt[i]=cdata[i,10]
	}
	ert <- NULL
for ( i in 1:length(edata[,10])){
		ert[i]=edata[i,10]
	}
	hrt <- NULL
for ( i in 1:length(hdata[,10])){
		hrt[i]=hdata[i,10]
	}
	lrt <- NULL
for ( i in 1:length(ldata[,10])){
		lrt[i]=ldata[i,10]
	}
	mrt <- NULL
for ( i in 1:length(mdata[,10])){
		mrt[i]=mdata[i,10]
	}
	ort <- NULL
for ( i in 1:length(odata[,10])){
		ort[i]=odata[i,10]
	}
prt <- NULL
for ( i in 1:length(pdata[,10])){
		prt[i]=pdata[i,10]
	#ptot[i]=ptot[i]-1
	}
	
scrt=NULL	
scrt[1] = mean(art)
scrt[2] = mean(brt)
scrt[3] = mean(crt)
scrt[4] = mean(ert)
scrt[5] = mean(hrt)
scrt[6] = mean(lrt)
scrt[7] = mean(mrt)
scrt[8] = mean(ort)
scrt[9] = mean(prt)
	