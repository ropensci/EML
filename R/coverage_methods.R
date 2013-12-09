#' Constructor function for `coverage` class.  
#' Provides convenience tools to write the more common
#' versions of coverage metadata. 
#' @param scientific_names a list or character string of scientific names of species covered by this dataset.  Assumes names are two words long, given as "genus species" or "genus_species". Can alternatively provide an `eml::taxonomicCoverage` object.  
#' @param dates a length-2 character vector giving the start and end dates in YYYY-MM-DD (ISO8601) format, or Date object.  Can alternatively provide an existing `eml::temporalCoverage` object.
#' @param geographic_descirption a plain-text description of the geographic location covered by this data.  
#' @param NSEWbox numeric vector giving the decimal degrees of latitude or longitude for a bounding box in the order North, South, East, West.  Optionally followed by a 5th and 6th value giving the altitude minimum and maximum in meters.  Can alternatively provide an existing `eml::geographicCoverage` object. 
#' @return an S4 representation of an eml coverage node.  
#' @export
#' @include coverage.R
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


## Methods for `coverage` class 

#' @include eml_yaml.R
#' @include coverage.R
setMethod("show", signature("coverage"), function(object) show_yaml(object))


#' @export
setGeneric("coverage", function(coverage) standardGeneric("coverage"))

#' accessor method
setMethod("coverage", signature("coverage"), function(coverage) coverage)

# Coercing to a generic list is error-prone, e.g. as(coverage, "list")[[1]][[1]] 
# would not consistently return the same field.  Instead, we coerce to a specific
# list structured in the way eml_coverage expects its arugments.  
# Thus, `cov <- coverage(eml); S4 <- do.call(eml_coverage, cov)` works,
# returning an S4 version (S4) and the list argument (cov).  
setAs("coverage", "list", function(from)
      get_coverage_list(from)
#      xmlToList(as(from, "XMLInternalElementNode"))
)


get_coverage_list <- 
  function(coverage){
            list(
            scientific_names = species(coverage@taxonomicCoverage),
            dates = c(coverage@temporalCoverage@rangeOfDates@beginDate@calendarDate,
                      coverage@temporalCoverage@rangeOfDates@beginDate@calendarDate),
            geographic_description = coverage@geographicCoverage@geographicDescription,
            NSEWbox = c(north = coverage@geographicCoverage@boundingCoordinates@northBoundingCoordinate, 
                        south = coverage@geographicCoverage@boundingCoordinates@southBoundingCoordinate, 
                        east = coverage@geographicCoverage@boundingCoordinates@eastBoundingCoordinate, 
                        west = coverage@geographicCoverage@boundingCoordinates@westBoundingCoordinate,
                        ## check that units are in meters!
                        min_alt = coverage@geographicCoverage@boundingCoordinates@boundingAltitudes@altitudeMinimum, 
                        max_alt = coverage@geographicCoverage@boundingCoordinates@boundingAltitudes@altitudeMaximum) 
            )

          }




#' @export
setGeneric("species", function(taxonomicCoverage) standardGeneric("species"))
## Coerce taxonomicCoverage into a species string  
## FIXME define at the taxonomimcClassifcation level first
## FIXME Define as a coercion to character instead?
setMethod("species", signature("taxonomicCoverage"), 
          function(taxonomicCoverage){
            unname(sapply(taxonomicCoverage@taxonomicClassification, 
                 function(object){
                    x <- NULL
                    while(!isEmpty(object)){
                      if(object@taxonRankName %in% c("genus", "species"))
                        x <- c(x, object@taxonRankValue)
                      object <- object@taxonomicClassification
                    }
                    paste(x, collapse = " ")
                 }))
          })







