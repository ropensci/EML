#' @include responsibleParty.R

setClass("metadataProvider", contains="responsibleParty")
setAs("XMLInternalElementNode", "metadataProvider",   function(from) emlToS4(from))
setAs("metadataProvider", "XMLInternalElementNode",   function(from) S4Toeml(from))

setClass("associatedPartySlots", slots = c(role = "character")) # hack to change odering
# Unclear if role should be one of the controlled types: http://knb.ecoinformatics.org/software/eml/eml-2.1.1/eml-party.html#RoleType, hf205 doesn't follow that.
setClass("associatedParty", contains=c("responsibleParty", "associatedPartySlots")) # FIXME should be ListOfresponsibleParty? but then does not find the type...
setAs("XMLInternalElementNode", "associatedParty",   function(from) emlToS4(from))
setAs("associatedParty", "XMLInternalElementNode",   function(from) S4Toeml(from))


setClass("ListOfmetadataProvider", contains="list")
setClass("ListOfassociatedParty", contains="list")





setClass("keyword",
         slots = c(keyword = "character"))
setAs("XMLInternalElementNode", "keyword",   function(from) emlToS4(from))
setAs("keyword", "XMLInternalElementNode",   function(from) S4Toeml(from))

setClass("ListOfkeyword", contains="list")

setClass("keywordSet",
         slots = c(keyword = "ListOfkeyword",
                        keywordThesaurus = "character"))
setAs("XMLInternalElementNode", "keywordSet",   function(from) emlToS4(from))
setAs("keywordSet", "XMLInternalElementNode",   function(from) S4Toeml(from))

setClass("ListOfkeywordSet", contains="list")


## Accessor / Extractor method for keywords
setMethod("keywords", signature("keywordSet"),
          function(object){
           unname(sapply(object@keyword, slot, "keyword"))
          }
         )


#' @include responsibleParty.R
setClass("resourceGroup",
          slots = c("alternateIdentifier" = "character",
                         "shortName" = "character",
                         "title" = "character",
                         "creator" = "ListOfcreator",
                         "metadataProvider" = "ListOfmetadataProvider",
                         "associatedParty"  = "ListOfassociatedParty",
                         "pubDate"  = "character", ## FIXME make a proper date class (schema accepts: year or ISO8601 format)
                         "language" = "character",
                         "series" = "character",
                         "abstract"  = "character",
                         "keywordSet" = "ListOfkeywordSet",
                         "additionalInfo" = "character",
                         "intellectualRights" = "character",
                         "distribution" = "distribution",
                         "coverage" = "coverage"))

setAs("XMLInternalElementNode", "resourceGroup",   function(from) emlToS4(from))
setAs("resourceGroup", "XMLInternalElementNode",   function(from) S4Toeml(from))

