#' @include methods.R
#' @include coverage.R
#' @include physical.R
setClass("entityGroup", 
         slots = c(entityName = "character",
                   entityDescription = "character",
                   alternateIdentifier = "character",
                   physical = "physical",
                   coverage = "coverage",
                   methods = "methods",
                   additionalInfo = "character"))

setAs("XMLInternalElementNode", "entityGroup",  function(from) emlToS4(from))
setAs("entityGroup", "XMLInternalElementNode",   function(from) S4Toeml(from))

