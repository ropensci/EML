## Physical ##

### Data Format ###
setClass("simpleDelimited", 
         representation(fieldDelimiter = "character"))
setAs("XMLInternalElementNode", "simpleDelimited",  function(from) emlToS4(from))

setClass("textFormat", 
         representation(numHeaderLines = "integer",
                        numFooterLines = "integer",
                        recordDelimiter = "character",
                        attributeOrientation = "character", 
                        simpleDelimited = "simpleDelimited"))
setAs("XMLInternalElementNode", "textFormat",  function(from) emlToS4(from))


setClass("dataFormat",
         representation(textFormat = "textFormat"))
setAs("XMLInternalElementNode", "dataFormat", function(from) emlToS4(from))


### Distribution ##
setClass("offline")
setAs("XMLInternalElementNode", "offline", function(from) emlToS4(from))

setClass("online",
         representation(url = "character",
                        onlineDescription = "character"))
setAs("XMLInternalElementNode", "online", function(from) emlToS4(from))


setClass("distribution",
         representation(online = "online",
                        offline = "offline",
                        inline = "character"))
setAs("XMLInternalElementNode", "distribution", function(from) emlToS4(from))

setClass("physical",
         representation(objectName = "character",
                        size = "numeric", # "object_size", # R class  
                        characterEncoding = "character",
                        dataFormat = "dataFormat",
                        distribution = "distribution"))

setAs("XMLInternalElementNode", "physical", function(from) emlToS4(from))


