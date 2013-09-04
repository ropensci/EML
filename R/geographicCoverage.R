

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
         representation(westBoundingCoordinate = "numeric", 
                        eastBoundingCoordinate = "numeric",
                        northBoundingCoordinate = "numeric",
                        southBoundingCoordinate = "numeric", 
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
#' @param description the text-based description of the geography.  This can also 
#' be an`eml::geographicCoverage` object. 
#' @param NSEWbox the North, South, East and West coordinates, in signed decimal degrees
#' latitude/longitude, respectively.  Additionally, the minimum and maximum altitude in
#' meters can optionally be given as the 5th and 6th values of this numeric vector.  This
#' value can only be left as NULL if description is a completed `eml::geographicCoverage` 
#' object.  
eml_geographicCoverage <- function(description, NSEWbox=NULL){
  if(is(description, "geographicCoverage"))
    node <- description
  else {
    node <- new("geographicCoverage", 
                geographicDescription = description,
                boundingCoordinates = 
                new("boundingCoordinates", 
                    northBoundingCoordinate = NSEWbox[1],
                    southBoundingCoordinate = NSEWbox[2],
                    eastBoundingCoordinate =  NSEWbox[3],
                    westBoundingCoordinate = NSEWbox[4]))
    if(length(NSEWbox) == 6){ # include altitude min and max in meters
      node@boundingCoordinates@boundingAltitudes <- 
        new("boundingAltitudes", 
            altitudeMinimum  = NSEWbox[5], 
            altitudeMaximum  = NSEWbox[6], 
            altitudeUnits = "meter")
    }
    node
  }
}
