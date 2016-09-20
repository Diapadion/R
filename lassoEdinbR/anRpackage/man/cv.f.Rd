\name{cv.f}
\alias{cv.f}
\docType{data}
\title{
%%   ~~ data name/kind ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of the dataset. ~~
}
\usage{data("cv.f")}
\format{
  The format is:
List of 10
 $ lambda    : num [1:72] 1.177 1.073 0.978 0.891 0.812 ...
 $ cvm       : num [1:72] 1.08 1.07 1.05 1.04 1.03 ...
 $ cvsd      : num [1:72] 0.0165 0.0165 0.0165 0.0165 0.0165 ...
 $ cvup      : num [1:72] 1.09 1.08 1.07 1.06 1.05 ...
 $ cvlo      : num [1:72] 1.06 1.05 1.04 1.03 1.02 ...
 $ nzero     : Named int [1:72] 0 1 1 1 1 1 1 1 1 1 ...
  ..- attr(*, "names")= chr [1:72] "s0" "s1" "s2" "s3" ...
 $ name      : Named chr "Mean-Squared Error"
  ..- attr(*, "names")= chr "mse"
 $ glmnet.fit:List of 12
  ..$ a0       : Named num [1:74] 1.21 1.19 1.18 1.17 1.15 ...
  .. ..- attr(*, "names")= chr [1:74] "s0" "s1" "s2" "s3" ...
  ..$ beta     :Formal class 'dgCMatrix' [package "Matrix"] with 6 slots
  .. .. ..@ i       : int [1:967] 4 4 4 4 4 4 4 4 4 4 ...
  .. .. ..@ p       : int [1:75] 0 0 1 2 3 4 5 6 7 8 ...
  .. .. ..@ Dim     : int [1:2] 20 74
  .. .. ..@ Dimnames:List of 2
  .. .. .. ..$ : chr [1:20] "p1" "p11" "p21" "p31" ...
  .. .. .. ..$ : chr [1:74] "s0" "s1" "s2" "s3" ...
  .. .. ..@ x       : num [1:967] 0.0374 0.0743 0.1105 0.1459 0.1803 ...
  .. .. ..@ factors : list()
  ..$ df       : int [1:74] 0 1 1 1 1 1 1 1 1 1 ...
  ..$ dim      : int [1:2] 20 74
  ..$ lambda   : num [1:74] 1.177 1.073 0.978 0.891 0.812 ...
  ..$ dev.ratio: num [1:74] 0 0.0117 0.0225 0.0326 0.042 ...
  ..$ nulldev  : num 756
  ..$ npasses  : int 345
  ..$ jerr     : int 0
  ..$ offset   : logi FALSE
  ..$ call     : language glmnet(x = hiv.train$x[, indx], y = hiv.train$y, alpha = 0.3)
  ..$ nobs     : int 704
  ..- attr(*, "class")= chr [1:2] "elnet" "glmnet"
 $ lambda.min: num 0.0793
 $ lambda.1se: num 0.242
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
data(cv.f)
## maybe str(cv.f) ; plot(cv.f) ...
}
\keyword{datasets}
