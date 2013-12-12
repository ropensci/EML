#' @include party.R
#' @include coverage.R
#' @include physical.R



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


#' @include party.R
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

