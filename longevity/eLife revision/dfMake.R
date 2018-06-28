### Making the pub data sheet ###


# This uses datX to generate the sheet we will be creating for
# eLife public dissemination, and our analyses. 

#View(datX)



### Exporting the working data frame into a CSV file

write.csv(datX[,c('sex','status','age_pr','age','origin','sample',
                  'Dom','Ext','Con','Agr','Neu','Opn')],
          file = 'eLife-chimpLong.csv', row.names = FALSE)

## Backup

#dat.origin = datX
