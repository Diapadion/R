\name{stab.step}
\alias{stab.step}
\docType{data}
\title{
%%   ~~ data name/kind ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of the dataset. ~~
}
\usage{data("stab.step")}
\format{
  The format is:
List of 12
 $ phat         : num [1:20, 1:5] 0 0 0 0 0 0 0 0 0 0 ...
  ..- attr(*, "dimnames")=List of 2
  .. ..$ : chr [1:20] "p1" "p11" "p21" "p31" ...
  .. ..$ : chr [1:5] "0" "1" "2" "3" ...
 $ selected     : Named int [1:2] 5 8
  ..- attr(*, "names")= chr [1:2] "p41" "p77"
 $ max          : Named num [1:20] 0.12 0.03 0.62 0.14 1 0.06 0 0.87 0.03 0.18 ...
  ..- attr(*, "names")= chr [1:20] "p1" "p11" "p21" "p31" ...
 $ cutoff       : num 0.75
 $ q            : num 4
 $ PFER         : num 0.816
 $ specifiedPFER: num 1
 $ p            : int 20
 $ B            : num 50
 $ sampling.type: chr "SS"
 $ assumption   : chr "unimodal"
 $ call         : language stabsel(x = hiv.train$x[, indx], y = hiv.train$y, fitfun = lars.stepwise, cutoff = 0.75, PFER = 1)
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
data(stab.step)
## maybe str(stab.step) ; plot(stab.step) ...
}
\keyword{datasets}
