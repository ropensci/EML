
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


setClass("taxanomicSystem",
         representation(classificationSystem = "classificationSystem",
                        identificationReference = "citation",
                        identifierName = "responsibleParty",
                        taxanomicProcedures = "character",
                        taxanomicCompleteness = "character", 
                        vouchers = "vouchers")
         )
setAs("XMLInternalElementNode", "taxanomicSystem",   function(from) emlToS4(from))
setAs("taxanomicSystem", "XMLInternalElementNode",   function(from) S4Toeml(from))


setClass("taxanomicClassification", 
         representation(taxonRankName = "character",
                        taxonRankValue = "character",
                        commonName = "character" 
#                       , taxonomicClassification = "taxanomicClassification" ## FIXME should include  this recursive def according to schema?
         ))
setAs("XMLInternalElementNode", "taxanomicClassification",   function(from) emlToS4(from))
setAs("taxanomicClassification", "XMLInternalElementNode",   function(from) S4Toeml(from))

setClass("ListOftaxanomicClassification", contains = "list")

#' @include referencesGroup.R
setClass("taxanomicCoverage",
         representation(taxanomicSystem = "taxanomicSystem",
                        generalTaxanomicCoverage = "character",
                        taxanomicClassification = "ListOftaxanomicClassification"),
         contains = "referencesGroup")
setAs("XMLInternalElementNode", "taxanomicCoverage",   function(from) emlToS4(from))
setAs("taxanomicCoverage", "XMLInternalElementNode",   function(from) S4Toeml(from))

