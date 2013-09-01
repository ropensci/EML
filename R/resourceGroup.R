
#' @include person.R
setClass("resourceGroup",
          representation("alternateIdentifier" = "character",  
                         "shortName" = "character", 
                         "title" = "character",  
                         "creator" = "creator", 
                         "metadataProvider" = "character", 
                         "associatedParty"  = "character", 
                         "pubDate"  = "character", 
                         "language" = "character", 
                         "series" = "character", 
                         "abstract"  = "character", 
                         "keywordSet" = "character", 
                         "additionalInfo" = "character", 
                         "intellectualRights" = "character", 
                         "distribution" = "character", 
                         "coverage" = "coverage")) 


