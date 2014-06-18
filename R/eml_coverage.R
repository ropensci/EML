#' Constructor function for `coverage` class.  
#' Provides convenience tools to write the more common
#' versions of coverage metadata. 
#' @param scientific_names a list or character string of scientific names of species covered by this dataset.  Assumes names are two words long, given as "genus species" or "genus_species". Can alternatively provide an `eml::taxonomicCoverage` object.  
#' @param dates a length-2 character vector giving the start and end dates in YYYY-MM-DD (ISO8601) format, or Date object.  Can alternatively provide an existing `eml::temporalCoverage` object.
#' @param geographic_description a plain-text description of the geographic location covered by this data.  
#' @param NSEWbox numeric vector giving the decimal degrees of latitude or longitude for a bounding box in the order North, South, East, West.  Optionally followed by a 5th and 6th value giving the altitude minimum and maximum in meters.  Can alternatively provide an existing `eml::geographicCoverage` object. 
#' @return an S4 representation of an eml coverage node.  
#' @export
#' @include coverage_classes.R
eml_coverage <- function(scientific_names=NULL, dates=NULL, geographic_description = NULL, NSEWbox = NULL){
  ## FIXME functions should take a S4 node too
  node <- new("coverage") 
  if(!is.null(scientific_names))
    node@taxonomicCoverage <- eml_taxonomicCoverage(scientific_names)
  if(!is.null(dates))
    node@temporalCoverage <- eml_temporalCoverage(dates)
  if(!is.null(geographic_description))
    node@geographicCoverage <- eml_geographicCoverage(geographic_description, NSEWbox)
  node
}



## Constructor for `taxonomicCoverage` class
eml_taxonomicCoverage <- function(scientific_names){
  if(is(scientific_names, "taxonomicCoverage"))
    scientific_names
  else 
    new("taxonomicCoverage", 
      taxonomicClassification = 
      new("ListOftaxonomicClassification", 
          lapply(scientific_names, as, "taxonomicClassification")))
}

#' @include resource_classes.R
## FIXME work with a variety of dateTime formats
eml_temporalCoverage <- function(dates){
  if(is(dates, "temporalCoverage"))
    dates
  else {
    if(length(dates) == 2){
    node <- new("temporalCoverage", 
                rangeOfDates = 
                new("rangeOfDates", 
                     beginDate = 
                     new("beginDate", 
                         calendarDate = to_ISO8601(dates[1])),
                     endDate = 
                     new("endDate", 
                         calendarDate = to_ISO8601(dates[2]))))
   }
   node
  }
}

to_ISO8601 <- function(x){
  if(is.character(x)) ## Attempt to make most standard formats into the desired format  
    x <- as.Date(x, '%Y-%m-%d')  
  if(is(x, "Date")) # and then convert into this format. (Note this is not an  else if call!)
    format(x, "%Y-%m-%d")
}




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



