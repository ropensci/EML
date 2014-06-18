### Methods ###  

#' @include literature_classes.R
#' @include coverage_classes.R


# FIXME Classes inheriting coverage really need a ListOfcoverage
# FIXME check needs of ListOf elsewhere

setClass("proceduralStep", 
         slots = c(description = "character",
                   citation = "ListOfcitation",
## FIXME uncomment when type is defined
#                   protocol = "ListOfprotocol",
#                   software = "software",
                   instrumentation = "character" 
#                   subStep = "proceduralStep"  # Ugh, recursion creating errors
                   )) 
setAs("XMLInternalElementNode", "proceduralStep",  function(from) emlToS4(from))
setAs("proceduralStep", "XMLInternalElementNode",   function(from) S4Toeml(from))


setClass("methodStep", 
# Really? Would anyone write a dataset under a methodStep?  
# Ugh, more recursive definitions, creates an intial that wands to be NULL
         slots = c(dataSource = "character"), 
         contains = "proceduralStep")
setAs("XMLInternalElementNode", "methodStep",  function(from) emlToS4(from))
setAs("methodStep", "XMLInternalElementNode",   function(from) S4Toeml(from))


setClass("studyExtent", 
         slots = c(description = "character"),
         contains = "coverage")
setAs("XMLInternalElementNode", "studyExtent",  function(from) emlToS4(from))
setAs("studyExtent", "XMLInternalElementNode",   function(from) S4Toeml(from))


setClass("spatialSamplingUnits", 
         slots = c(referencedEntityId = "character"),
         contains = "coverage")
setAs("XMLInternalElementNode", "spatialSamplingUnits",  function(from) emlToS4(from))
setAs("spatialSamplingUnits", "XMLInternalElementNode",   function(from) S4Toeml(from))



setClass("sampling", 
         slots = c(studyExtent = "studyExtent",
                   samplingDescription = "character",
                   spatialSamplingUnits = "spatialSamplingUnits",
                   citation = "ListOfcitation"))
setAs("XMLInternalElementNode", "sampling",  function(from) emlToS4(from))
setAs("sampling", "XMLInternalElementNode",   function(from) S4Toeml(from))



setClass("qualityControl", contains = "proceduralStep") 
setAs("XMLInternalElementNode", "qualityControl",  function(from) emlToS4(from))
setAs("qualityControl", "XMLInternalElementNode",   function(from) S4Toeml(from))


setClass("ListOfmethodStep", contains="list")

#' concatenate
#' 
#' concatenate
#' @param x,... methodSteps to concatenate
#' @param recursive Needed for compatibility with generic, otherwise ignored
#' @rdname class-methodStep
setMethod("c", signature("methodStep"), function(x, ..., recursive = FALSE) new("ListOfmethodStep", list(x, ...)))

setClass("ListOfqualityControl", contains="list")

#' concatenate
#' 
#' concatenate
#' @param x,... qualityControls to concatenate
#' @param recursive Needed for compatibility with generic, otherwise ignored
#' @rdname class-qualityControl
setMethod("c", signature("qualityControl"), function(x, ..., recursive = FALSE) new("ListOfqualityControl", list(x, ...)))



setClass("methods", 
         slots = c(methodStep = "ListOfmethodStep",
                   sampling = "sampling",
                   qualityControl = "ListOfqualityControl"))


setAs("XMLInternalElementNode", "methods",  function(from) emlToS4(from))
setAs("methods", "XMLInternalElementNode",   function(from) S4Toeml(from))

