
setClass("classificationSystem",
         representation(classificationSystemCitation = "citation",
                        classificationSystemModifications = "character"))

setClass("ListOforiginator", contains="list")
setClass("originator", contains="responsibleParty")

setClass("vouchers",
         representation(specimen = "character",
                        repository = "ListOforiginator")) 


setClass("taxanomicSystem",
         representation(classificationSystem = "classificationSystem",
                        identificationReference = "citation",
                        identifierName = "responsibleParty",
                        taxanomicProcedures = "character",
                        taxanomicCompleteness = "character", 
                        vouchers = "vouchers")
         )


setClass("taxanomicClassification", 
         representation(taxonRankName = "character",
                        taxonRankValue = "character",
                        commonName = "character", 
                        taxonomicClassification = "taxanomicClassification"))

setClass("ListOftaxanomicClassification", contains = "list")

#' @include referencesGroup.R
setClass("taxanomicCoverage",
         representation(taxanomicSystem = "taxanomicSystem",
                        generalTaxanomicCoverage = "character",
                        taxanomicClassification = "ListOftaxanomicClassification"),
         contains = "referencesGroup")

