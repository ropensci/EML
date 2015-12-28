#' @include methods_classes.R
#' @include coverage_classes.R
#' @include physical_classes.R
setClass("entityGroup",
         slots = c(entityName = "character",
                   entityDescription = "character",
                   alternateIdentifier = "character",
                   physical = "physical",
                   coverage = "coverage",
                   methods = "methods",
                   additionalInfo = "character"),
         contains = "eml.2.1.1")

setAs("XMLInternalElementNode", "entityGroup",  function(from) emlToS4(from))
setAs("entityGroup", "XMLInternalElementNode",   function(from) S4Toeml(from))

setClass("otherEntity_slots",
         slots = c(attributeList = "attributeList",  ## Hack to make entityGroup slots listed first!
                   entityType = "character"),
         contains = "id_scope")

setAs("XMLInternalElementNode", "otherEntity_slots",  function(from) emlToS4(from))
setAs("otherEntity_slots", "XMLInternalElementNode",   function(from) S4Toeml(from))

setClass("otherEntity",
         contains=c("entityGroup", "otherEntity_slots"))
setAs("XMLInternalElementNode", "otherEntity",  function(from) emlToS4(from))
setAs("otherEntity", "XMLInternalElementNode",   function(from) S4Toeml(from))
