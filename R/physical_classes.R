## Physical ##
#' @include literature_classes.R
## Definitions of subclasses, and their coercions to/from XML:

### Data Format ###
setClass("simpleDelimited",
         slots = c(fieldDelimiter = "character"),
         contains = "eml.2.1.1")
setAs("XMLInternalElementNode", "simpleDelimited",  function(from) emlToS4(from))
setAs("simpleDelimited", "XMLInternalElementNode",   function(from) S4Toeml(from))

setClass("textFormat",
         slots = c(numHeaderLines = "integer",
                        numFooterLines = "integer",
                        recordDelimiter = "character",
                        attributeOrientation = "character",
                        simpleDelimited = "simpleDelimited"),
         contains = "eml.2.1.1")
setAs("XMLInternalElementNode", "textFormat",  function(from) emlToS4(from))
setAs("textFormat", "XMLInternalElementNode",   function(from) S4Toeml(from))

setClass("Citation") # dummy class, defined in literature_classes.R
setClass("externallyDefinedFormat",
         slots = c(formatName = "character",
                   formatVersion = "character",
                   citation = "Citation"),
         contains = "eml.2.1.1")
setAs("XMLInternalElementNode", "externallyDefinedFormat",  function(from) emlToS4(from))
setAs("externallyDefinedFormat", "XMLInternalElementNode",   function(from) S4Toeml(from))

setClass("dataFormat",
         slots = c(textFormat = "textFormat",
                   externallyDefinedFormat = "externallyDefinedFormat"),
         contains = "eml.2.1.1")
setAs("XMLInternalElementNode", "dataFormat", function(from) emlToS4(from))
setAs("dataFormat", "XMLInternalElementNode",   function(from) S4Toeml(from))


### Distribution ##
## FIXME Flush out, this isn't the full distribution defs
setClass("offline", slots = c(
                              mediumName = "character",          # required
                              mediumDensity = "character",       # optional
                              mediumDensityUnits = "character",  # optional
                              mediumVolume = "character",        # optional
                              mediumFormat = "character",        # optional  unbounded
                              mediumNote = "character"           # optional
                              ),
         contains = "eml.2.1.1")
setAs("XMLInternalElementNode", "offline", function(from) emlToS4(from))
setAs("offline", "XMLInternalElementNode",   function(from) S4Toeml(from))


########################

## FIXME should include function *attribute* as well (e.g. function=download)
setClass("online",
         slots = c(url = "character",
                   onlineDescription = "character"),
         contains = "eml.2.1.1")
setAs("XMLInternalElementNode", "online", function(from) emlToS4(from))
setAs("online", "XMLInternalElementNode",   function(from) S4Toeml(from))


###########################

setClass("distribution",
         slots = c(online = "online",
                   offline = "offline",
                   inline = "character"),
         contains = "eml.2.1.1")
setAs("XMLInternalElementNode", "distribution", function(from) emlToS4(from))
setAs("distribution", "XMLInternalElementNode",   function(from) S4Toeml(from))
## FIXME Should check that 'from' is a internet protocol (e.g http)
setAs("character", "distribution", function(from)
  new("distribution", online = new("online", url = from)))


########################

setClass("physical",
         slots = c(objectName = "character",
                        size = "numeric", # "object_size", # R class
                        characterEncoding = "character",
                        dataFormat = "dataFormat",
                        distribution = "distribution",
                        dirname = "character"),
         contains = "eml.2.1.1")  ## An internal notation only to assist in reading in from correct filepath

setAs("XMLInternalElementNode", "physical", function(from) emlToS4(from))
setAs("physical", "XMLInternalElementNode",   function(from) S4Toeml(from))

## Methods to convert into native R types
setAs("physical", "data.frame", function(from)
      extract(from))





