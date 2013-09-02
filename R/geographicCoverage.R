
#' @include attribute.R 
setClass("boundingAltitudes", 
         representation(altitudeMinimum = "numeric",
                        altitudeMaximum = "numeric",
                        altitudeUnits = "unit"))
setAs("XMLInternalElementNode", "boundingAltitudes",   function(from) emlToS4(from))
setAs("boundingAltitudes", "XMLInternalElementNode",   function(from) S4Toeml(from))

setClass("boundingCoordinates",
         representation(northBoundingCoordinate = "numeric",
                        southBoundingCoordinate = "numeric", 
                        eastBoundingCoordinate = "numeric", 
                        westBoundingCoordinate = "numeric", 
                        boundingAltitudes = "boundingAltitudes"))
setAs("XMLInternalElementNode", "boundingCoordinates",   function(from) emlToS4(from))
setAs("boundingCoordinates", "XMLInternalElementNode",   function(from) S4Toeml(from))

#' @include referencesGroup.R
setClass("geographicCoverage",
         representation(id = "character",
                        geographicDescription = "character",
                        boundingCoordinates = "boundingCoordinates",
                        datasetGPolygon = "character"), # Should support the polygon properly...
         contains = "referencesGroup")
setAs("XMLInternalElementNode", "geographicCoverage",   function(from) emlToS4(from))
setAs("geographicCoverage", "XMLInternalElementNode",   function(from) S4Toeml(from))

