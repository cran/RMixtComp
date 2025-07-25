# MixtComp version 4.0  - july 2019
# Copyright (C) Inria - Université de Lille - CNRS

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>


#' @import RMixtCompIO RMixtCompUtilities
#' @importFrom parallel detectCores
#' @importFrom graphics plot
#' @importFrom utils head
#' @importFrom ggplot2 ggplot aes_string labs geom_point geom_line scale_x_continuous
#' @importFrom plotly plot_ly add_trace layout %>%
#' @importFrom scales pretty_breaks
#' @importFrom stats cov var
#'
#' @title RMixtComp
#' @docType package
#' @aliases RMixtComp-package
#' @name RMixtComp-package
#' @description
#' MixtComp (Mixture Composer, \url{https://github.com/modal-inria/MixtComp}) is a model-based clustering package
#' for mixed data. It used mixture models (McLachlan and Peel, 2010) fitted using a SEM algorithm (Celeux et al., 1995) to cluster the data.
#'
#' It has been engineered around the idea of easy and quick integration of all new univariate models, under the conditional
#' independence assumption.
#'
#' Five basic models (Gaussian, Multinomial, Poisson, Weibull, NegativeBinomial) are implemented, as well as two
#' advanced models: Func_CS for functional data (Same et al., 2011) and Rank_ISR for ranking data (Jacques and Biernacki, 2014).
#'
#' MixtComp has the ability to natively manage missing data (completely or by interval).
#'
#'
#' @details
#' Main functions are \link{mixtCompLearn} for clustering, \link{mixtCompPredict} for predicting the cluster of new samples
#' with a model learnt with \link{mixtCompLearn}.
#' \link[RMixtCompUtilities]{createAlgo} gives you default values for required parameters.
#'
#' Read the help page of \link{mixtCompLearn} for available models and data format. A summary of these information can be
#' accessed with the function \link[RMixtCompUtilities]{availableModels}.
#'
#' All utility functions (getters, graphical) are in the \code{\link[RMixtCompUtilities]{RMixtCompUtilities-package}} package.
#'
#' In order to have an overview of the output, you can use \link{print.MixtCompLearn}, \link{summary.MixtCompLearn} and
#' \link{plot.MixtCompLearn} functions,
#'
#' Getters are available to easily access some results (see. \link{mixtCompLearn} for output format): \link[RMixtCompUtilities]{getBIC},
#' \link[RMixtCompUtilities]{getICL}, \link[RMixtCompUtilities]{getCompletedData}, \link[RMixtCompUtilities]{getParam}, \link[RMixtCompUtilities]{getProportion}, \link[RMixtCompUtilities]{getTik}, \link[RMixtCompUtilities]{getEmpiricTik},
#' \link[RMixtCompUtilities]{getPartition}, \link[RMixtCompUtilities]{getType}, \link[RMixtCompUtilities]{getModel}, \link[RMixtCompUtilities]{getVarNames}.
#'
#'
#' You can compute discriminative powers and similarities with functions: \link[RMixtCompUtilities]{computeDiscrimPowerClass},
#' \link[RMixtCompUtilities]{computeDiscrimPowerVar}, \link[RMixtCompUtilities]{computeSimilarityClass}, \link[RMixtCompUtilities]{computeSimilarityVar}.
#'
#' Graphics functions are \link[RMixtCompUtilities]{plot.MixtComp}, \link{plot.MixtCompLearn}, \link[RMixtCompUtilities]{heatmapClass}, \link[RMixtCompUtilities]{heatmapTikSorted},
#' \link[RMixtCompUtilities]{heatmapVar}, \link[RMixtCompUtilities]{histMisclassif}, \link[RMixtCompUtilities]{plotConvergence}, \link[RMixtCompUtilities]{plotDataBoxplot}, \link[RMixtCompUtilities]{plotDataCI},
#' \link[RMixtCompUtilities]{plotDiscrimClass}, \link[RMixtCompUtilities]{plotDiscrimVar}, \link[RMixtCompUtilities]{plotProportion}, \link{plotCrit}.
#'
#' Datasets with running examples are provided: \link{titanic}, \link{CanadianWeather}, \link{prostate}, \link{simData}.
#'
#'
#' Documentation about input and output format is available: \code{vignette("dataFormat")} and
#' \code{vignette("mixtCompObject")}.
#'
#' MixtComp examples: \code{vignette("MixtComp")} or online \url{https://github.com/vandaele/mixtcomp-notebook}.
#'
#' Using ClusVis with RMixtComp: \code{vignette("ClusVis")}.
#'
#'
#' @examples
#' data(simData)
#'
#' # define the algorithm's parameters: you can use createAlgo function
#' algo <- list(
#'   nbBurnInIter = 50,
#'   nbIter = 50,
#'   nbGibbsBurnInIter = 50,
#'   nbGibbsIter = 50,
#'   nInitPerClass = 20,
#'   nSemTry = 20,
#'   confidenceLevel = 0.95
#' )
#'
#' # run RMixtComp for learning using only 3 variables
#' resLearn <- mixtCompLearn(simData$dataLearn$matrix, simData$model$unsupervised[1:3], algo,
#'   nClass = 1:2, nRun = 2, nCore = 1
#' )
#'
#' summary(resLearn)
#' plot(resLearn)
#'
#' # run RMixtComp for predicting
#' resPred <- mixtCompPredict(
#'   simData$dataPredict$matrix, simData$model$unsupervised[1:3], algo,
#'   resLearn,
#'   nCore = 1
#' )
#'
#' partitionPred <- getPartition(resPred)
#' print(resPred)
#'
#' @references
#' C. Biernacki. MixtComp software: Model-based clustering/imputation with mixed data, missing data and uncertain data. MISSDATA 2015, Jun 2015, Rennes, France. hal-01253393
#'
#' G. McLachlan, D. Peel (2000). Finite Mixture Models. Wiley Series in Probability and Statistics, 1st edition. John Wiley & Sons. doi:10.1002/0471721182.
#'
#' G. Celeux, D. Chauveau, J. Diebolt. On Stochastic Versions of the EM Algorithm. [Research Report] RR-2514, INRIA. 1995. inria-00074164
#'
#' A. Same, F. Chamroukhi, G. Govaert, P. Aknin. (2011). Model-based clustering and segmentation of time series with change in regime. Adv. Data Analysis and Classification. 5. 301-321. 10.1007/s11634-011-0096-5.
#'
#' J. Jacques, C. Biernacki. (2014). Model-based clustering for multivariate partial ranking data. Journal of Statistical Planning and Inference. 149. 10.1016/j.jspi.2014.02.011.
#'
#' @seealso \code{\link{mixtCompLearn}} \code{\link[RMixtCompUtilities]{availableModels}} \code{\link[RMixtCompUtilities]{RMixtCompUtilities-package}},
#' \code{\link[RMixtCompIO]{RMixtCompIO-package}}. Other clustering packages: \code{Rmixmod}
#'
#' @keywords package
"_PACKAGE"
