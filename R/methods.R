### Methods ###  

#' @include literature.R

setClass("methodStep", 
         slots = c(description = "character")) # software, 
setAs("XMLInternalElementNode", "methodStep",  function(from) emlToS4(from))
setAs("methodStep", "XMLInternalElementNode",   function(from) S4Toeml(from))

setClass("methods", 
         slots = c(methodsStep = "methodStep"))
setAs("XMLInternalElementNode", "methods",  function(from) emlToS4(from))
setAs("methods", "XMLInternalElementNode",   function(from) S4Toeml(from))

