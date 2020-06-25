## ---- echo=FALSE--------------------------------------------------------------
Sys.setenv(MC_DETERMINISTIC = 2)

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, fig.align = "center", fig.width = 7, fig.height = 5)

## ---- echo = TRUE-------------------------------------------------------------
library(RMixtComp)

## -----------------------------------------------------------------------------
data(titanic)
print(titanic[c(1, 16, 38, 169, 285, 1226),])

## -----------------------------------------------------------------------------
titanicMC <- titanic
titanicMC$sex <- refactorCategorical(titanic$sex, c("male", "female"), c(1, 2))
titanicMC$pclass <- refactorCategorical(titanic$pclass, c("1st", "2nd", "3rd"), c(1, 2, 3))
titanicMC$embarked <- refactorCategorical(titanic$embarked, c("C", "Q", "S"), c(1, 2, 3))
titanicMC$survived <- refactorCategorical(titanic$survived, c(0, 1), c(1, 2))
titanicMC[is.na(titanicMC)] = "?"
head(titanicMC)

## -----------------------------------------------------------------------------
indTrain <- sample(nrow(titanicMC), floor(0.8 * nrow(titanicMC)))
titanicMCTrain <- titanicMC[indTrain, ]
titanicMCTest <- titanicMC[-indTrain, ]

## -----------------------------------------------------------------------------
model <- list(fare = "Gaussian", age = "Gaussian", pclass = "Multinomial", survived = "Multinomial", 
              sex = "Multinomial", embarked = "Multinomial", sibsp = "Poisson", parch = "Poisson")

## ----learn, results = "hide"--------------------------------------------------
resTitanic <- mixtCompLearn(titanicMCTrain, model, nClass = 1:20, nRun = 3, nCore = 1)

## -----------------------------------------------------------------------------
summary(resTitanic)

## -----------------------------------------------------------------------------
plot(resTitanic)

## -----------------------------------------------------------------------------
heatmapVar(resTitanic)

## -----------------------------------------------------------------------------
round(computeSimilarityVar(resTitanic), 2)

## -----------------------------------------------------------------------------
getProportion(resTitanic)

## -----------------------------------------------------------------------------
resK2 <- extractMixtCompObject(resTitanic, 2)
getProportion(resK2)

## ----pred, results = "hide"---------------------------------------------------
resPred <- mixtCompPredict(titanicMCTest, resLearn = resTitanic, nClass = 5, nRun = 3, nCore = 1)

## ----partition----------------------------------------------------------------
tik <- getTik(resPred)
head(tik)
partition <- getPartition(resPred)
head(partition)

## ---- echo=FALSE--------------------------------------------------------------
Sys.unsetenv("MC_DETERMINISTIC")

