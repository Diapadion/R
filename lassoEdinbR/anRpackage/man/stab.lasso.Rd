\name{stab.lasso}
\alias{stab.lasso}
\docType{data}
\title{
%%   ~~ data name/kind ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of the dataset. ~~
}
\usage{data("stab.lasso")}
\format{
  The format is:
List of 12
 $ phat         : num [1:20, 1:21] 0 0 0 0 0 0 0 0 0 0 ...
  ..- attr(*, "dimnames")=List of 2
  .. ..$ : chr [1:20] "p1" "p11" "p21" "p31" ...
  .. ..$ : chr [1:21] "s0" "s1" "s2" "s3" ...
 $ selected     : Named int [1:3] 3 5 8
  ..- attr(*, "names")= chr [1:3] "p21" "p41" "p77"
 $ max          : Named num [1:20] 0.12 0.01 0.83 0.22 1 0.02 0 0.83 0.05 0.19 ...
  ..- attr(*, "names")= chr [1:20] "p1" "p11" "p21" "p31" ...
 $ cutoff       : num 0.75
 $ q            : num 4
 $ PFER         : num 0.816
 $ specifiedPFER: num 1
 $ p            : int 20
 $ B            : num 50
 $ sampling.type: chr "SS"
 $ assumption   : chr "unimodal"
 $ call         : language stabsel(x = hiv.train$x[, indx], y = hiv.train$y, fitfun = glmnet.lasso, cutoff = 0.75, PFER = 1)
 - attr(*, "class")= chr "stabsel"
}
\details{
%%  ~~ If necessary, more details than the __description__ above ~~
}
\source{
%%  ~~ reference to a publication or URL from which the data were obtained ~~
}
\references{
%%  ~~ possibly secondary sources and usages ~~
}
\examples{
data(stab.lasso)
## maybe str(stab.lasso) ; plot(stab.lasso) ...
}
\keyword{datasets}
