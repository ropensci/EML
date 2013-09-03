setClass("metadataProvider", contains="ListOfresponsibleParty")
setAs("XMLInternalElementNode", "metadataProvider",   function(from) emlToS4(from))
setAs("metadataProvider", "XMLInternalElementNode",   function(from) S4Toeml(from))
setClass("associatedParty", contains="ListOfresponsibleParty")
setAs("XMLInternalElementNode", "associatedParty",   function(from) emlToS4(from))
setAs("associatedParty", "XMLInternalElementNode",   function(from) S4Toeml(from))


setClass("ListOfmetadataProvider", contains="list")
setClass("ListOfassociatedParty", contains="list")

setClass("keyword", 
         representation(keyword = "character"))
setAs("XMLInternalElementNode", "keyword",   function(from) emlToS4(from))
setAs("keyword", "XMLInternalElementNode",   function(from) S4Toeml(from))

setClass("ListOfkeyword", contains="list")

setClass("keywordSet",
         representation(keyword = "ListOfkeyword",
                        keywordThesaurus = "character"))
setAs("XMLInternalElementNode", "keywordSet",   function(from) emlToS4(from))
setAs("keywordSet", "XMLInternalElementNode",   function(from) S4Toeml(from))

#' @include responsibleParty.R
setClass("resourceGroup",
          representation("alternateIdentifier" = "character",  
                         "shortName" = "character", 
                         "title" = "character",  
                         "creator" = "ListOfcreator", 
                         "metadataProvider" = "ListOfmetadataProvider", 
                         "associatedParty"  = "ListOfassociatedParty", 
                         "pubDate"  = "character", ## FIXME make a proper date class (schema accepts: year or ISO8601 format)
                         "language" = "character", 
                         "series" = "character", 
                         "abstract"  = "character", 
                         "keywordSet" = "keywordSet", 
                         "additionalInfo" = "character", 
                         "intellectualRights" = "character", 
                         "distribution" = "distribution", 
                         "coverage" = "coverage")) 

setAs("XMLInternalElementNode", "resourceGroup",   function(from) emlToS4(from))
setAs("resourceGroup", "XMLInternalElementNode",   function(from) S4Toeml(from))

