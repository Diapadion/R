\name{fit.full}
\alias{fit.full}
\docType{data}
\title{
%%   ~~ data name/kind ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of the dataset. ~~
}
\usage{data("fit.full")}
\format{
  The format is:
List of 12
 $ a0       : Named num [1:100] 1.21 1.18 1.15 1.12 1.1 ...
  ..- attr(*, "names")= chr [1:100] "s0" "s1" "s2" "s3" ...
 $ beta     :Formal class 'dgCMatrix' [package "Matrix"] with 6 slots
  .. ..@ i       : int [1:8470] 157 157 157 157 157 157 157 157 157 157 ...
  .. ..@ p       : int [1:101] 0 0 1 2 3 4 5 6 7 8 ...
  .. ..@ Dim     : int [1:2] 208 100
  .. ..@ Dimnames:List of 2
  .. .. ..$ : chr [1:208] "p1" "p2" "p3" "p4" ...
  .. .. ..$ : chr [1:100] "s0" "s1" "s2" "s3" ...
  .. ..@ x       : num [1:8470] 0.0582 0.1183 0.18 0.2433 0.3078 ...
  .. ..@ factors : list()
 $ df       : int [1:100] 0 1 1 1 1 1 1 1 1 1 ...
 $ dim      : int [1:2] 208 100
 $ lambda   : num [1:100] 3.29 3 2.74 2.49 2.27 ...
 $ dev.ratio: num [1:100] 0 0.0526 0.1052 0.1576 0.2094 ...
 $ nulldev  : num 756
 $ npasses  : int 918
 $ jerr     : int 0
 $ offset   : logi FALSE
 $ call     : language glmnet(x = hiv.train$x, y = hiv.train$y, alpha = 0.3)
 $ nobs     : int 704
 - attr(*, "class")= chr [1:2] "elnet" "glmnet"
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
data(fit.full)
## maybe str(fit.full) ; plot(fit.full) ...
}
\keyword{datasets}
