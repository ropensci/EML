
#' @include temporalCoverage.R
#' @include geographicCoverage.R
#' @include taxanomicCoverage.R
#' @include referencesGroup.R
setClass("coverage", 
         representation(id = "character",
#                        system = "character",
#                        scope = "character",
                        geographicCoverage = "geographicCoverage",
                        temporalCoverage = "temporalCoverage",
                        taxonomicCoverage = "taxanomicCoverage"),
         contains = "referencesGroup")
 
