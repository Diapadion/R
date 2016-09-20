\name{cv.full}
\alias{cv.full}
\docType{data}
\title{
%%   ~~ data name/kind ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of the dataset. ~~
}
\usage{data("cv.full")}
\format{
  The format is:
List of 10
 $ lambda    : num [1:91] 3.29 3 2.74 2.49 2.27 ...
 $ cvm       : num [1:91] 1.075 1.019 0.963 0.906 0.851 ...
 $ cvsd      : num [1:91] 0.0164 0.0162 0.0157 0.0152 0.0146 ...
 $ cvup      : num [1:91] 1.092 1.036 0.979 0.922 0.865 ...
 $ cvlo      : num [1:91] 1.059 1.003 0.947 0.891 0.836 ...
 $ nzero     : Named int [1:91] 0 1 1 1 1 1 1 1 1 1 ...
  ..- attr(*, "names")= chr [1:91] "s0" "s1" "s2" "s3" ...
 $ name      : Named chr "Mean-Squared Error"
  ..- attr(*, "names")= chr "mse"
 $ glmnet.fit:List of 12
  ..$ a0       : Named num [1:100] 1.21 1.18 1.15 1.12 1.1 ...
  .. ..- attr(*, "names")= chr [1:100] "s0" "s1" "s2" "s3" ...
  ..$ beta     :Formal class 'dgCMatrix' [package "Matrix"] with 6 slots
  .. .. ..@ i       : int [1:8470] 157 157 157 157 157 157 157 157 157 157 ...
  .. .. ..@ p       : int [1:101] 0 0 1 2 3 4 5 6 7 8 ...
  .. .. ..@ Dim     : int [1:2] 208 100
  .. .. ..@ Dimnames:List of 2
  .. .. .. ..$ : chr [1:208] "p1" "p2" "p3" "p4" ...
  .. .. .. ..$ : chr [1:100] "s0" "s1" "s2" "s3" ...
  .. .. ..@ x       : num [1:8470] 0.0582 0.1183 0.18 0.2433 0.3078 ...
  .. .. ..@ factors : list()
  ..$ df       : int [1:100] 0 1 1 1 1 1 1 1 1 1 ...
  ..$ dim      : int [1:2] 208 100
  ..$ lambda   : num [1:100] 3.29 3 2.74 2.49 2.27 ...
  ..$ dev.ratio: num [1:100] 0 0.0526 0.1052 0.1576 0.2094 ...
  ..$ nulldev  : num 756
  ..$ npasses  : int 918
  ..$ jerr     : int 0
  ..$ offset   : logi FALSE
  ..$ call     : language glmnet(x = hiv.train$x, y = hiv.train$y, alpha = 0.3)
  ..$ nobs     : int 704
  ..- attr(*, "class")= chr [1:2] "elnet" "glmnet"
 $ lambda.min: num 0.0345
 $ lambda.1se: num 0.0603
 - attr(*, "class")= chr "cv.glmnet"
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
data(cv.full)
## maybe str(cv.full) ; plot(cv.full) ...
}
\keyword{datasets}
