#' @include methods.R
#' @include coverage.R
#' @include physical.R
setClass("entityGroup", 
         representation(entityName = "character",
                        entityDescription = "character",
                        alternateIdentifier = "character",
                        physical = "physical",
                        coverage = "coverage",
                        methods = "methods",
                        additionalInfo = "character"))

etAs("XMLInternalElementNode", "entityGroup",  function(from) emlToS4(from))

