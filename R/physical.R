## Physical ##

#' @include literature.R

## Definitions of subclasses, and their coercions to/from XML: 

### Data Format ###
setClass("simpleDelimited", 
         slots = c(fieldDelimiter = "character"))
setAs("XMLInternalElementNode", "simpleDelimited",  function(from) emlToS4(from))
setAs("simpleDelimited", "XMLInternalElementNode",   function(from) S4Toeml(from))

setClass("textFormat", 
         slots = c(numHeaderLines = "integer",
                        numFooterLines = "integer",
                        recordDelimiter = "character",
                        attributeOrientation = "character", 
                        simpleDelimited = "simpleDelimited"))
setAs("XMLInternalElementNode", "textFormat",  function(from) emlToS4(from))
setAs("textFormat", "XMLInternalElementNode",   function(from) S4Toeml(from))


setClass("dataFormat",
         slots = c(textFormat = "textFormat"))
setAs("XMLInternalElementNode", "dataFormat", function(from) emlToS4(from))
setAs("dataFormat", "XMLInternalElementNode",   function(from) S4Toeml(from))


### Distribution ##  
## FIXME Flush out, this isn't the full distribution defs 
setClass("offline")
setAs("XMLInternalElementNode", "offline", function(from) emlToS4(from))
setAs("offline", "XMLInternalElementNode",   function(from) S4Toeml(from))


########################

## FIXME should include function *attribute* as well (e.g. function=download)  
setClass("online",
         slots = c(url = "character",
                        onlineDescription = "character"))
setAs("XMLInternalElementNode", "online", function(from) emlToS4(from))
setAs("online", "XMLInternalElementNode",   function(from) S4Toeml(from))


###########################

setClass("distribution",
         slots = c(online = "online",
                        offline = "offline",
                        inline = "character"))
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
                        dirname = "character"))  ## An internal notation only to assist in reading in from correct filepath  

setAs("XMLInternalElementNode", "physical", function(from) emlToS4(from))
setAs("physical", "XMLInternalElementNode",   function(from) S4Toeml(from))

## Methods to convert into native R types 
setAs("physical", "data.frame", function(from)
      extract(from)) 





