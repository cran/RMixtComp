% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/MIXTCOMP_datasets.R
\docType{data}
\name{CanadianWeather}
\alias{CanadianWeather}
\title{Canadian average annual weather cycle}
\format{
A list containing 5 elements:
\itemize{
  \item tempav: a matrix of dimensions (365, 35) giving the average temperature in degrees celsius for each day of the year.
  \item precav: a matrix of dimensions (365, 35) giving the average rainfall in millimeters for each day of the year.
  \item time: sequence from 1 to 365.
  \item coordinates: a matrix giving 'N.latitude' and 'W.longitude' for each place.
  \item region: Which of 4 climate zones contain each place: Atlantic, Pacific, Continental, Arctic.
}
}
\source{
Ramsay, James O., and Silverman, Bernard W. (2006), Functional Data Analysis, 2nd ed., Springer, New York.

Ramsay, James O., and Silverman, Bernard W. (2002), Applied Functional Data Analysis, Springer, New York
}
\usage{
data(CanadianWeather)
}
\description{
Daily temperature and precipitation at 35 different locations in Canada averaged over 1960 to 1994.
Data from \code{fda} package.
}
\examples{
\donttest{
data(CanadianWeather)

# convert functional to MixtComp format
dat <- list(
  tempav = apply(
    CanadianWeather$tempav, 2,
    function(x) createFunctional(CanadianWeather$time, x)
  ),
  precav = apply(
    CanadianWeather$precav, 2,
    function(x) createFunctional(CanadianWeather$time, x)
  )
)

# create model with 4 subregressions ans 2 coefficients per regression
model <- list(
  tempav = list(type = "Func_CS", paramStr = "nSub: 4, nCoeff: 2"),
  precav = list(type = "Func_CS", paramStr = "nSub: 4, nCoeff: 2")
)

# create algo
algo <- createAlgo()

# run clustering
resLearn <- mixtCompLearn(dat, model, algo, nClass = 2:4, criterion = "ICL", nRun = 3, nCore = 1)

summary(resLearn)

plot(resLearn)

getPartition(resLearn)
getTik(resLearn, log = FALSE)
}

}
\seealso{
Other data: 
\code{\link{prostate}},
\code{\link{simData}},
\code{\link{titanic}}
}
\concept{data}
\keyword{data}
