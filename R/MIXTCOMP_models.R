#
# Functions to create the model argument of \link{mixtCompLearn}
#
# @param nSub Number of subregressions used
# @param nCoeff Number of coefficients of each subregression
# @param sharedAlpha If TRUE, use Func_SharedAlpha_CS instead of FUnc_CS
#
# @return a list describing the model
#
# @examples 
# model <- list("gauss1" = Gaussian(), 
#               "gauss2" = Gaussian(), 
#               "func1" = Func_CS(15, 2, FALSE), 
#               "func2" = Func_CS(10, 3, TRUE))
#
# @author Quentin Grimonprez
# @rdname Models
# @export
LatentClass <- function()
{
  list(type = "LatentClass", paramStr = "")
}

# @rdname Models
# @export
Gaussian <- function()
{
  list(type = "Gaussian", paramStr = "")
}

# @rdname Models
# @export
Poisson <- function()
{
  list(type = "Poisson", paramStr = "")
}

# @rdname Models
# @export
Multinomial <- function()
{
  list(type = "Multinomial", paramStr = "")
}

# @rdname Models
# @export
NegativeBinomial <- function()
{
  list(type = "NegativeBinomial", paramStr = "")
}

# @rdname Models
# @export
Weibull <- function()
{
  list(type = "Weibull", paramStr = "")
}

# @rdname Models
# @export
Rank_ISR <- function()
{
  list(type = "Rank_ISR", paramStr = "")
}

# @rdname Models
# @export
Func_CS <- function(nSub, nCoeff = 2, sharedAlpha = FALSE)
{
  list(type = ifelse(sharedAlpha, "Func_SharedAlpha_CS", "Func_CS"), paramStr =  paste0("nSub: ", nSub, ", nCoeff: ", nCoeff))
}


