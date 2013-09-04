

#' @include attribute.R 
#setClass("altitudeUnits", contains="unit")
#setAs("XMLInternalElementNode", "altitudeUnits",   function(from) emlToS4(from))
#setAs("altitudeUnits", "XMLInternalElementNode",   function(from) S4Toeml(from))


setClass("boundingAltitudes", 
         representation(altitudeMinimum = "numeric",
                        altitudeMaximum = "numeric",
                        altitudeUnits = "character"))
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

#' Helper constructor for creating geographicCoverage node
#' 
#' Implements only a subset of possible specifications for coverage
eml_geographicCoverage <- function(NSEWbox){
  node <- new("geographicCoverage", boundingCoordinates = 
              new("boundingCoordinates", 
                  northBoundingCoordinate = NSEWbox[1],
                  southBoundingCoordinate = NSEWbox[2],
                  eastBoundingCoordinate =  NSEWbox[3],
                  westBoundingCoordinate = NSEWbox[4]))
  if(length(NSEWbox == 6)){ # include altitude min and max in meters
    node@boundingCoordinates@boundingAltitudes <- 
      new("boundingAltitudes", 
          altitudeMinimum  = NSEWbox[5], 
          altitudeMaximum  = NSEWbox[6], 
          altitudeUnits = "meter")
  }
  node
}
