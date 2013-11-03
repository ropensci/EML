
## Subclasses of taxonomicCoverage, 
## with coercion methods to/from XML 

setClass("classificationSystem",
         representation(classificationSystemCitation = "citation",
                        classificationSystemModifications = "character"))
setAs("XMLInternalElementNode", "classificationSystem",   function(from) emlToS4(from))
setAs("classificationSystem", "XMLInternalElementNode",   function(from) S4Toeml(from))



setClass("originator", contains="responsibleParty")
setAs("XMLInternalElementNode", "originator",   function(from) emlToS4(from))
setAs("originator", "XMLInternalElementNode",   function(from) S4Toeml(from))


setClass("ListOforiginator", contains="list")

setClass("vouchers",
         representation(specimen = "character",
                        repository = "ListOforiginator")) 
setAs("XMLInternalElementNode", "vouchers",   function(from) emlToS4(from))
setAs("vouchers", "XMLInternalElementNode",   function(from) S4Toeml(from))


setClass("taxonomicSystem",
         representation(classificationSystem = "classificationSystem",
                        identificationReference = "citation",
                        identifierName = "responsibleParty",
                        taxonomicProcedures = "character",
                        taxonomicCompleteness = "character", 
                        vouchers = "vouchers")
         )
setAs("XMLInternalElementNode", "taxonomicSystem",   function(from) emlToS4(from))
setAs("taxonomicSystem", "XMLInternalElementNode",   function(from) S4Toeml(from))

setClass("taxonomicClassification")
setClass("taxonomicClassification", 
         representation(taxonRankName = "character",
                        taxonRankValue = "character",
                        commonName = "character", 
                        taxonomicClassification = "taxonomicClassification" ## FIXME this recursive def is asking for trouble!! 
         ))
setAs("XMLInternalElementNode", "taxonomicClassification",   function(from) emlToS4(from))
setAs("taxonomicClassification", "XMLInternalElementNode",   function(from) S4Toeml(from))

setClass("ListOftaxonomicClassification", contains = "list")


## Class definition for taxonomicCoverage 
#' @include referencesGroup.R
setClass("taxonomicCoverage",
         representation(taxonomicSystem = "taxonomicSystem",
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
            unname(sapply(from@taxonomicClassification, as, "character"))


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





