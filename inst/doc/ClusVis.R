## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, fig.align = "center", fig.width = 7, fig.height = 5)

## ---- echo=FALSE--------------------------------------------------------------
Sys.setenv(MC_DETERMINISTIC = 2)

## ---- echo = TRUE, results = 'hide'-------------------------------------------
library(RMixtComp)
library(ClusVis)

## -----------------------------------------------------------------------------
data("iris")
head(iris)

## -----------------------------------------------------------------------------
res <- mixtCompLearn(iris[, -5], nClass = 3, criterion = "BIC", nRun = 3, nCore = 1, verbose = FALSE)

## -----------------------------------------------------------------------------
logTik <- getTik(res, log = TRUE)
prop <- getProportion(res)
resVisu <- clusvis(logTik, prop)

## -----------------------------------------------------------------------------
plotDensityClusVisu(resVisu, add.obs = TRUE)

## -----------------------------------------------------------------------------
plotDensityClusVisu(resVisu, add.obs = FALSE)

## -----------------------------------------------------------------------------
data("congress")
head(congress)

## -----------------------------------------------------------------------------
## MixtComp Format
congress$V1 = refactorCategorical(congress$V1, c("democrat", "republican", "?"), c(1, 2, "?"))
for(i in 2:ncol(congress))
  congress[, i] = refactorCategorical(congress[, i], c("n", "y", "?"), c(1, 2, "?"))

head(congress)

## ---- results = 'hide'--------------------------------------------------------
model <- rep("Multinomial", ncol(congress))
names(model) = colnames(congress)

res <- mixtCompLearn(congress, model = model, nClass = 4, criterion = "BIC", nRun = 3, nCore = 1)

## -----------------------------------------------------------------------------
logTik <- getTik(res, log = TRUE)
prop <- getProportion(res)
head(logTik)

## -----------------------------------------------------------------------------
logTik[is.infinite(logTik)] = log(1e-20)
head(logTik)

## -----------------------------------------------------------------------------
resVisu <- clusvis(logTik, prop)

## -----------------------------------------------------------------------------
plotDensityClusVisu(resVisu, add.obs = TRUE)

## -----------------------------------------------------------------------------
plotDensityClusVisu(resVisu, add.obs = FALSE)

## ---- echo=FALSE--------------------------------------------------------------
Sys.unsetenv("MC_DETERMINISTIC")

