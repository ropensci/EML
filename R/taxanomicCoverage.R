
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
                        commonName = "character" 
                       , taxonomicClassification = "taxonomicClassification" ## FIXME should include  this recursive def according to schema?
         ))
setAs("XMLInternalElementNode", "taxonomicClassification",   function(from) emlToS4(from))
setAs("taxonomicClassification", "XMLInternalElementNode",   function(from) S4Toeml(from))

setClass("ListOftaxonomicClassification", contains = "list")

#' @include referencesGroup.R
setClass("taxonomicCoverage",
         representation(taxonomicSystem = "taxonomicSystem",
                        generalTaxanomicCoverage = "character",
                        taxonomicClassification = "ListOftaxonomicClassification"),
         contains = "referencesGroup")
setAs("XMLInternalElementNode", "taxonomicCoverage",   function(from) emlToS4(from))
setAs("taxonomicCoverage", "XMLInternalElementNode",   function(from) S4Toeml(from))



setAs("character", "taxonomicClassification", function(from){
      from <- gsub("_", " ", from) # names should have spaces
      tmp <- strsplit(from, " ")[[1]]
      if(length(tmp) == 2){  ## Need better error handling of species names here...
        genus <- tmp[[1]]
        species <- tmp[[2]]
        sp <- new("taxonomicClassification", 
            taxonRankName = "species", 
            taxonRankValue = species)

        out <- new("taxonomicClassification", 
            taxonRankName = "genus", 
            taxonRankValue = genus,
            taxonomicClassification = sp)
      }

      out
         })

eml_taxonomicCoverage <- function(scientific_names){
  new("taxonomicCoverage", 
      taxonomicClassification = new("ListOftaxonomicClassification", 
                                    lapply(scientific_names, as, "taxonomicClassification")))
}
