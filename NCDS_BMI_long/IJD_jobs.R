### IJD job categories IQ 



ncds9.2 <- read.dta13("ncds_2013_employment.dta", generate.factors = FALSE)

table(ncds0123$dvht16)

table(ncds9.2$N9AS2010)


ncds.jobs = merge(ncds0123[,c('ncdsid','n622','n914','n917','n920','n923','n926','bmi16',
                              'n236','n190','n194','n195','n537','n200','n607',
                              'n1612','n2017')], 
                  ncds9.2, by.x="ncdsid", by.y="NCDSID", all=TRUE)

ncds.jobs$g = as.numeric(ncds.jobs$n920) - 2
ncds.jobs$g[ncds.jobs$g==-1] = NA

ncds.jobs$N9AS2010[table(ncds.jobs$N9AS2010) > 19]

ncds.jobs[ ncds.jobs$N9AS2010 %in%  names(table(ncds.jobs$N9AS2010))[table(ncds.jobs$N9AS2010) > 19] , ]

dim(ncds.jobs[(table(ncds.jobs$N9AS2010) > 19),])

g = ggplot(data = ncds.jobs[ ncds.jobs$N9AS2010 %in%  names(table(ncds.jobs$N9AS2010))[table(ncds.jobs$N9AS2010) > 39] , ],
           #data=ncds.jobs[(table(ncds.jobs$N9AS2010) > 19),], 
           aes(y=n920)) + geom_boxplot() +
  facet_grid(N9AS2010 ~ .)

g


table(droplevels(ncds.jobs[ ncds.jobs$N9AS2010 %in%  names(table(ncds.jobs$N9AS2010))[table(ncds.jobs$N9AS2010) > 19] , ])$N9AS2010)



ncds.jobs.cut = ncds.jobs[ ncds.jobs$N9AS2000 %in%  names(table(ncds.jobs$N9AS2000))[table(ncds.jobs$N9AS2000) > 19] , ]

table(ncds.jobs.cut$N9AS2000)

ncds.jobs.cut$N9AS2000 = droplevels(ncds.jobs.cut$N9AS2000)

describeBy(as.integer(ncds.jobs.cut$g),
           group=ncds.jobs.cut$N9AS2000)

