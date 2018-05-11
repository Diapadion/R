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

KMO(bfi[,-1]) ## Kaier, Meyer, Olkin measure of sampling adequacy.



### Determining the number of factors to extract.
nfactors(bfi[,-1] ## Replicates the style of Figure 2.
         , n = 10 ## Sets the maximum number of factors to search for - default is 20.
         , rotate = 'oblimin' ## Default is 'varimax' - an orthogonal rotation.
)

fa.parallel(bfi[,-1]
            , sim = FALSE ## Default is TRUE - FALSE replicates style of Figure 3.
            , SMC = TRUE  ## Ensures that PA is adjusted for factors.
            , fa = 'both' ## Plots both factor and component analyses.
)
