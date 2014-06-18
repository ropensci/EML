## Methods for `coverage` class 


#' Show coverage pretty-print format using yaml representation
#' 
#' Show coverage pretty-print format using yaml representation
#' @param object an EML coverage object
#' @return pretty print coverage in yaml format
#' @include eml_yaml.R
#' @include coverage_classes.R
setMethod("show", signature("coverage"), function(object) show_yaml(object))


#' get coverage information
#' 
#' get coverage information
#' @param coverage an object from which we extract coverage information
#' @return content of a coverage node
# export
setGeneric("coverage", function(coverage) standardGeneric("coverage"))

# accessor method
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



#' get species information
#' 
#' get species information
#' @param taxonomicCoverage an object from which taxonomic coverage information might be extracted
#' @return species names as a character string
# export
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





### Internal helper constructors 



#' @include eml_yaml.R
setMethod("show", signature("temporalCoverage"), function(object) show_yaml(object))





#' @include eml_yaml.R
setMethod("show", signature("geographicCoverage"), function(object) show_yaml(object))




