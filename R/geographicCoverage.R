
#' @include attribute.R 
setClass("boundingAltitudes", 
         representation(altitudeMinimum = "numeric",
                        altitudeMaximum = "numeric",
                        altitudeUnits = "unit"))

setClass("boundingCoordinates",
         representation(northBoundingCoordinate = "numeric",
                        southBoundingCoordinate = "numeric", 
                        eastBoundingCoordinate = "numeric", 
                        westBoundingCoordinate = "numeric", 
                        boundingAltitudes = "boundingAltitudes"))

#' @include referencesGroup.R
setClass("geographicCoverage",
         representation(id = "character",
                        geographicDescription = "character",
                        boundingCoordinates = "boundingCoordinates",
                        datasetGPolygon = "character"), # Should support the polygon properly...
         contains = "referencesGroup")
