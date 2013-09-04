
#' @include temporalCoverage.R
#' @include geographicCoverage.R
#' @include taxanomicCoverage.R
#' @include referencesGroup.R
setClass("coverage", 
         representation(id = "character",
#                        system = "character",
#                        scope = "character",
                        geographicCoverage = "geographicCoverage",
                        temporalCoverage = "temporalCoverage",
                        taxonomicCoverage = "taxonomicCoverage"),
         contains = "referencesGroup")
setAs("XMLInternalElementNode", "coverage",   function(from) emlToS4(from))
setAs("coverage", "XMLInternalElementNode",   function(from) S4Toeml(from))



#' Helper constructor for creating coverage node.  
#' Provides convenience tools to write the more common
#' versions of coverage metadata. 
#' @param scientific_names a list or character string of scientific names of species covered by this dataset.  Assumes names are two words long, given as "genus species" or "genus_species". 
#' @param dates a length-2 character vector giving the start and end dates in YYYY-MM-DD (ISO8601) format, or Date object.  
#' @param numeric vector giving the decimal degrees of latitude or longitude for a bounding box in the order North, South, East, West.  Optionally followed by a 5th and 6th value giving the altitude minimum and maximum in meters.  
#' @return an S4 representation of an eml coverage node.  
#' @export
eml_coverage <- function(scientific_names=NULL, dates=NULL, NSEWbox = NULL){
  node <- new("coverage") 
  if(!is.null(scientific_names))
    node@taxonomicCoverage <- eml_taxonomicCoverage(scientific_names)
  if(!is.null(dates))
    node@temporalCoverage <- eml_temporalCoverage(dates)
  if(!is.null(NSEWbox))
    mode@geographicCoverage <- eml_geographicCoverage(NSEWbox)
  node
}

