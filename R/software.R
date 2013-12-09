#' @include resource.R 

## FIXME flush out this class
setClass("software", 
         contains = "resourceGroup")

setAs("XMLInternalElementNode", "software",   function(from) emlToS4(from))
setAs("software", "XMLInternalElementNode",   function(from) S4Toeml(from))

