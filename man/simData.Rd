% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/MIXTCOMP_datasets.R
\docType{data}
\name{simData}
\alias{simData}
\title{Simulated Heterogeneous data}
\format{
A list containing three elements: \emph{dataLearn}, \emph{dataPredict} and \emph{model}.
\itemize{
  \item \emph{dataLearn} is a list containing the data in the three accepted format (list, data.frame and matrix).
Data consists of 200 individuals and 9 variables.
  \item \emph{dataPredict} is a list containing the data in the three accepted format (list, data.frame and matrix).
Data consists of 100 individuals and 8 variables.
  \item \emph{model} is a list containing the model lists used for clustering \emph{model$unsupervised}
and classification \emph{model$supervised}.
}
}
\usage{
data(simData)
}
\description{
Simulated Heterogeneous data
}
\examples{
data(simData)
str(simData)

}
\seealso{
Other data: 
\code{\link{CanadianWeather}},
\code{\link{prostate}},
\code{\link{titanic}}
}
\concept{data}
\keyword{data}
