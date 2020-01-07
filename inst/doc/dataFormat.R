## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
library(RMixtComp)

## ----data---------------------------------------------------------------------
dat <- list(x = rnorm(100), y = rpois(100, 2), z = rnorm(100, -3, 1))

## ----model--------------------------------------------------------------------
dat <- list(x = list(type = "Gaussian", paramStr = ""), y = "Poisson", z = "Gaussian")

## ----algo, eval=TRUE----------------------------------------------------------
algo <- list(nbBurnInIter = 100,
             nbIter = 100,
             nbGibbsBurnInIter = 100,
             nbGibbsIter = 100,
             nInitPerClass = 2,
             nSemTry = 10,
             confidenceLevel = 0.95,
             ratioStableCriterion = 0.9,
             nStableCriterion = 7,
             notes = "You can add any note you wish in non mandatory fields like this one (notes). They will be copied to the output.")

## ----algo2--------------------------------------------------------------------
algo <- createAlgo()

