library(psych) ## Main package used in this annex.
require(GPArotation) ## Supplementary package - useful for rotations.

## Users should import their dataset here, saving as 'df'.



### Inspecting the correlations between variables before testing.
cor(bfi[,-1]
    , use = 'pairwise.complete.obs' ## Default is 'everything' - can produce many NAs.
)

corPlot(bfi[,-1]) ## Graphical plot of the correlation matrix.



### Testing the suitable of the data for factoring.
cortest.bartlett(bfi[,-1]) ## Bartlett's test that the correlation matrix is the ID matrix.
## The p-value should be low, indicating that correlations are not all 1, and multiple 
## factors could be extracted.

KMO(bfi[,-1]) ## Kaier, Meyer, Olkin measure of sampling adequacy.
## Less than 0.5 for an item has been labeled unacceptable,
## but higher values (e.g. > 0.8) are generally preferred.



### Determining the number of factors to extract.
nfactors(bfi[,-1] ## Replicates the style of Figure 2.
         , n = 10 ## Sets the maximum number of factors to search for - default is 20.
         , rotate = 'oblimin' ## Default is 'varimax' - an orthogonal rotation.
)
## Output plot shows VSS, eBIC, SRMR, and Complexity (a general diagnostic statistic).
## Full output is displayed in the console, and additional statistics can be explored
## and plotted, e.g.:
plot(nfactors(bfi[,-1], n=10, rotate='oblimin')$map, type = 'b')
## Velicer's Mimimum Average Partial (MAP), which indicates the optimal number of factor
## where it reaches a minomum.

## To fully take advantage of the many nfactors statistics, we strongly recommend
## that users consult the help file:
?nfactors


## Parallel analysis of factors solutions.
fa.parallel(bfi[,-1]
            , sim = FALSE ## Default is TRUE - FALSE replicates style of Figure 3.
            , SMC = FALSE  ## Ensures that PA is adjusted for factors.
            , fa = 'fa' ## Plots only the factor analyses.
)
## This plots a scree plot with adjusted eigenvalues and the data for comparison,
## which are random and/or resampled. Where the adjusted eigenvalue for a given factor 
## is above the line of eigenvalues from random/resampled data, parallel analysis
## indicates that that factor ought to be retained.

