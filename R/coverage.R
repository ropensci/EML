
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
setAs("XMLInternalElementNode", "coverage",   function(from) emlToS4(from))
setAs("coverage", "XMLInternalElementNode",   function(from) S4Toeml(from))

