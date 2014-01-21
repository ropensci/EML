########### TAXONOMIC COVERAGE ############################# 


## Subclasses of taxonomicCoverage, 
## with coercion methods to/from XML 
#' @include party.R

setClass("ListOfcitation") # Dummy declaration to avoid warning, replaced when collating literature.R module

setClass("classificationSystem",
         slots = c(classificationSystemCitation = "ListOfcitation",
                        classificationSystemModifications = "character"))
setAs("XMLInternalElementNode", "classificationSystem",   function(from) emlToS4(from))
setAs("classificationSystem", "XMLInternalElementNode",   function(from) S4Toeml(from))


setClass("vouchers",
         slots = c(specimen = "character",
                        repository = "ListOforiginator")) 
setAs("XMLInternalElementNode", "vouchers",   function(from) emlToS4(from))
setAs("vouchers", "XMLInternalElementNode",   function(from) S4Toeml(from))

setClass("taxonomicSystem",
         slots = c(classificationSystem = "classificationSystem",
                        identificationReference = "ListOfcitation",
                        identifierName = "responsibleParty",
                        taxonomicProcedures = "character",
                        taxonomicCompleteness = "character", 
                        vouchers = "vouchers")
         )
setAs("XMLInternalElementNode", "taxonomicSystem",   function(from) emlToS4(from))
setAs("taxonomicSystem", "XMLInternalElementNode",   function(from) S4Toeml(from))

setClass("taxonomicClassification")
setClass("taxonomicClassification", 
         slots = c(taxonRankName = "character",
                        taxonRankValue = "character",
                        commonName = "character", 
                        taxonomicClassification = "taxonomicClassification" ## FIXME this recursive def is asking for trouble!! 
         ))
setAs("XMLInternalElementNode", "taxonomicClassification",   function(from) emlToS4(from))
setAs("taxonomicClassification", "XMLInternalElementNode",   function(from) S4Toeml(from))

setClass("ListOftaxonomicClassification", contains = "list")
setMethod("c", signature("taxonomicClassification"), function(x, ...) new("ListOftaxonomicClassification", list(x, ...)))

## Class definition for taxonomicCoverage 
setClass("taxonomicCoverage",
         slots = c(taxonomicSystem = "taxonomicSystem",
                        generalTaxanomicCoverage = "character",
                        taxonomicClassification = "ListOftaxonomicClassification"),
         contains = "referencesGroup")
setAs("XMLInternalElementNode", "taxonomicCoverage",   function(from) emlToS4(from))
setAs("taxonomicCoverage", "XMLInternalElementNode",   function(from) S4Toeml(from))



### Helper coercion methods to convert strings of species names into EML objects  ##
## FIXME is it wise to define such coercions since the strings may not correspond to appropriate objects?  


## string taxonomicClassification object
setAs("character", "taxonomicClassification", function(from){
      from <- gsub("_", " ", from) # names should have spaces
      tmp <- strsplit(from, " ")[[1]]
      if(length(tmp) == 2){  ## Need better error handling of species names here...
        genus <- tmp[[1]]
        species <- tmp[[2]]
        sp <- new("taxonomicClassification") 
        sp@taxonRankName = "species"   # FIXME can't add during call to "new" due to recursive definition...
        sp@taxonRankValue = species

        out <- new("taxonomicClassification") 
        out@taxonRankName = "genus"
        out@taxonRankValue = genus
        out@taxonomicClassification = sp
        out
      }

      out
})

setAs("character", "taxonomicCoverage", function(from){
    new("taxonomicCoverage", 
      taxonomicClassification = 
      new("ListOftaxonomicClassification", 
          lapply(from, as, "taxonomicClassification")))})

## Coerce taxonomicCoverage into a string of species names
setAs("taxonomicClassification", "character", function(from){
                    x <- NULL
                    while(!isEmpty(from)){
                      if(from@taxonRankName %in% c("genus", "species"))
                        x <- c(x, from@taxonRankValue)
                      from <- from@taxonomicClassification
                    }
                    paste(x, collapse = " ")
                 })
setAs("taxonomicCoverage", "character", function(from)
            unname(sapply(from@taxonomicClassification, as, "character")))



########################## TEMPORAL COVERAGE ################


setClass("alternativeTimeScale",
         slots = c(timeScaleName = "character",
                        timeScaleAgeEstimate = "character",
                        timeScaleAgeUncertainty = "character",
                        timeScaleAgeExplanation = "character",
                        timeScaleCitation = "ListOfcitation") 
        )
setAs("XMLInternalElementNode", "alternativeTimeScale",   function(from) emlToS4(from))
setAs("alternativeTimeScale", "XMLInternalElementNode",   function(from) S4Toeml(from))


setClass("singleDateTime",
         slots = c(calendarDate = "character",
                        time = "character",
                        alternativeTimeScale = "alternativeTimeScale"))
setAs("XMLInternalElementNode", "singleDateTime",   function(from) emlToS4(from))
setAs("singleDateTime", "XMLInternalElementNode",   function(from) S4Toeml(from))

setClass("beginDate", contains="singleDateTime")
setAs("XMLInternalElementNode", "beginDate",   function(from) emlToS4(from))
setAs("beginDate", "XMLInternalElementNode",   function(from) S4Toeml(from))

setClass("endDate", contains="singleDateTime")
setAs("XMLInternalElementNode", "endDate",   function(from) emlToS4(from))
setAs("endDate", "XMLInternalElementNode",   function(from) S4Toeml(from))

setClass("rangeOfDates", 
         slots = c(beginDate = "beginDate",  
                        endDate = "endDate"))
setAs("XMLInternalElementNode", "rangeOfDates",   function(from) emlToS4(from))
setAs("rangeOfDates", "XMLInternalElementNode",   function(from) S4Toeml(from))

setClass("temporalCoverage",
         slots = c(id = "character",
                        singleDateTime = "singleDateTime",
                        rangeOfDates = "rangeOfDates"),
         contains = "referencesGroup")
setAs("XMLInternalElementNode", "temporalCoverage",   function(from) emlToS4(from))
setAs("temporalCoverage", "XMLInternalElementNode",   function(from) S4Toeml(from))



############# GEOGRAPHIC COVERAGE ##########################

#' @include attribute.R 
#setClass("altitudeUnits", contains="unit")
#setAs("XMLInternalElementNode", "altitudeUnits",   function(from) emlToS4(from))
#setAs("altitudeUnits", "XMLInternalElementNode",   function(from) S4Toeml(from))

setClass("boundingAltitudes", 
         slots = c(altitudeMinimum = "numeric",
                        altitudeMaximum = "numeric",
                        altitudeUnits = "character"))
setAs("XMLInternalElementNode", "boundingAltitudes",   function(from) emlToS4(from))
setAs("boundingAltitudes", "XMLInternalElementNode",   function(from) S4Toeml(from))

setClass("boundingCoordinates",
         slots = c(westBoundingCoordinate = "numeric", 
                        eastBoundingCoordinate = "numeric",
                        northBoundingCoordinate = "numeric",
                        southBoundingCoordinate = "numeric", 
                        boundingAltitudes = "boundingAltitudes"))
setAs("XMLInternalElementNode", "boundingCoordinates",   function(from) emlToS4(from))
setAs("boundingCoordinates", "XMLInternalElementNode",   function(from) S4Toeml(from))

setClass("geographicCoverage",
         slots = c(id = "character",
                        geographicDescription = "character",
                        boundingCoordinates = "boundingCoordinates",
                        datasetGPolygon = "character"), # Should support the polygon properly...
         contains = "referencesGroup")
setAs("XMLInternalElementNode", "geographicCoverage",   function(from) emlToS4(from))
setAs("geographicCoverage", "XMLInternalElementNode",   function(from) S4Toeml(from))


################## overall coverage ##########

setClass("coverage", 
         slots = c(id = "character",
#                        system = "character",
#                        scope = "character",
                        geographicCoverage = "geographicCoverage",
                        temporalCoverage = "temporalCoverage",
                        taxonomicCoverage = "taxonomicCoverage"),
         contains = "referencesGroup")
setAs("XMLInternalElementNode", "coverage",   function(from) emlToS4(from))
setAs("coverage", "XMLInternalElementNode",   function(from) S4Toeml(from))



