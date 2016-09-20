\name{lm2}
\alias{lm2}
\docType{data}
\title{
%%   ~~ data name/kind ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of the dataset. ~~
}
\usage{data("lm2")}
\format{
  The format is:
List of 11
 $ coefficients : Named num 1.21
  ..- attr(*, "names")= chr "(Intercept)"
 $ residuals    : Named num [1:704] 1.094 -0.574 -0.584 -0.663 1.094 ...
  ..- attr(*, "names")= chr [1:704] "1" "2" "3" "4" ...
 $ effects      : Named num [1:704] -32.038 -0.614 -0.624 -0.703 1.054 ...
  ..- attr(*, "names")= chr [1:704] "(Intercept)" "" "" "" ...
 $ rank         : int 1
 $ fitted.values: Named num [1:704] 1.21 1.21 1.21 1.21 1.21 ...
  ..- attr(*, "names")= chr [1:704] "1" "2" "3" "4" ...
 $ assign       : int 0
 $ qr           :List of 5
  ..$ qr   : num [1:704, 1] -26.533 0.0377 0.0377 0.0377 0.0377 ...
  .. ..- attr(*, "dimnames")=List of 2
  .. .. ..$ : chr [1:704] "1" "2" "3" "4" ...
  .. .. ..$ : chr "(Intercept)"
  .. ..- attr(*, "assign")= int 0
  ..$ qraux: num 1.04
  ..$ pivot: int 1
  ..$ tol  : num 1e-07
  ..$ rank : int 1
  ..- attr(*, "class")= chr "qr"
 $ df.residual  : int 703
 $ call         : language lm(formula = hiv.train.y ~ 1, data = df)
 $ terms        :Classes 'terms', 'formula'  language hiv.train.y ~ 1
  .. ..- attr(*, "variables")= language list(hiv.train.y)
  .. ..- attr(*, "factors")= int(0) 
  .. ..- attr(*, "term.labels")= chr(0) 
  .. ..- attr(*, "order")= int(0) 
  .. ..- attr(*, "intercept")= int 1
  .. ..- attr(*, "response")= int 1
  .. ..- attr(*, ".Environment")=<environment: R_GlobalEnv> 
  .. ..- attr(*, "predvars")= language list(hiv.train.y)
  .. ..- attr(*, "dataClasses")= Named chr "numeric"
  .. .. ..- attr(*, "names")= chr "hiv.train.y"
 $ model        :'data.frame':	704 obs. of  1 variable:
  ..$ hiv.train.y: num [1:704] 2.301 0.633 0.623 0.544 2.301 ...
  ..- attr(*, "terms")=Classes 'terms', 'formula'  language hiv.train.y ~ 1
  .. .. ..- attr(*, "variables")= language list(hiv.train.y)
  .. .. ..- attr(*, "factors")= int(0) 
  .. .. ..- attr(*, "term.labels")= chr(0) 
  .. .. ..- attr(*, "order")= int(0) 
  .. .. ..- attr(*, "intercept")= int 1
  .. .. ..- attr(*, "response")= int 1
  .. .. ..- attr(*, ".Environment")=<environment: R_GlobalEnv> 
  .. .. ..- attr(*, "predvars")= language list(hiv.train.y)
  .. .. ..- attr(*, "dataClasses")= Named chr "numeric"
  .. .. .. ..- attr(*, "names")= chr "hiv.train.y"
 - attr(*, "class")= chr "lm"
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
data(lm2)
## maybe str(lm2) ; plot(lm2) ...
}
\keyword{datasets}
