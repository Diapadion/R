hit <- NULL

for (i in 1:dim(allData)[1])
{
	if(allData[i,7]=="High"){
			hit <- c(hit,allData[i,5])
	
}
}
