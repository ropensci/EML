## Physical ##

### Data Format ###
setClass("simpleDelimited", 
         representation(fieldDelimiter = "character"))
setAs("XMLInternalElementNode", "simpleDelimited",  function(from) emlToS4(from))
setAs("simpleDelimited", "XMLInternalElementNode",   function(from) S4Toeml(from))

setClass("textFormat", 
         representation(numHeaderLines = "integer",
                        numFooterLines = "integer",
                        recordDelimiter = "character",
                        attributeOrientation = "character", 
                        simpleDelimited = "simpleDelimited"))
setAs("XMLInternalElementNode", "textFormat",  function(from) emlToS4(from))
setAs("textFormat", "XMLInternalElementNode",   function(from) S4Toeml(from))


setClass("dataFormat",
         representation(textFormat = "textFormat"))
setAs("XMLInternalElementNode", "dataFormat", function(from) emlToS4(from))
setAs("dataFormat", "XMLInternalElementNode",   function(from) S4Toeml(from))


### Distribution ##  
## FIXME Flush out, this isn't the full distribution defs 
setClass("offline")
setAs("XMLInternalElementNode", "offline", function(from) emlToS4(from))
setAs("offline", "XMLInternalElementNode",   function(from) S4Toeml(from))


########################

setClass("online",
         representation(url = "character",
                        onlineDescription = "character"))
setAs("XMLInternalElementNode", "online", function(from) emlToS4(from))
setAs("online", "XMLInternalElementNode",   function(from) S4Toeml(from))


###########################

setClass("distribution",
         representation(online = "online",
                        offline = "offline",
                        inline = "character"))
setAs("XMLInternalElementNode", "distribution", function(from) emlToS4(from))
setAs("distribution", "XMLInternalElementNode",   function(from) S4Toeml(from))
## FIXME Should check that 'from' is a internet protocol (e.g http)
setAs("character", "distribution", function(from)
  new("distribution", online = new("online", url = from)))


########################

setClass("physical",
         representation(objectName = "character",
                        size = "numeric", # "object_size", # R class  
                        characterEncoding = "character",
                        dataFormat = "dataFormat",
                        distribution = "distribution"))

setAs("XMLInternalElementNode", "physical", function(from) emlToS4(from))
setAs("physical", "XMLInternalElementNode",   function(from) S4Toeml(from))

## Methods to convert into native R types 
setAs("physical", "data.frame", function(from)
      extract(from)) 
## FIXME  exported for test only, maybe not necessary?
#' @export
setMethod("extract", signature("physical", "character"),
          function(from, using=NA){
            # The "ordered" class does not have a coercion defined from character
            # Better to just treat it as a factor 
            using <- gsub("ordered", "factor", using) 
            ## FIXME use the EML to determine read.csv options
            dat <- read.csv(from@objectName, colClasses=using)
          })

# If col_classes(object) returns a list, means that colClasses are not simple types (e.g. c("ordered", "factor") or "NULL")
# See read.csv for details.  Meanwhile, if we get a list, just read in ignoring the declared colClasses
setMethod("extract", signature("physical", "list"),
          function(from, using=NA){
            ## FIXME use the EML to determine read.csv options
            dat <- read.csv(from@objectName)
          })
## if no `using` option is defined: 
setMethod("extract", signature("physical"),
          function(from, using=NA){
            ## FIXME use the EML to determine read.csv options
            dat <- read.csv(from@objectName)
          })






setAs("data.frame", "physical", function(from)
      eml_physical(dat)) 

####### Internal function to coerce data.frame to physical #######
## Custom generator. Consider making int an S4 method?  
eml_physical <- function(dat, filename=character(0), ...){
  if(length(filename) == 0) 
    filename = paste(uuid::UUIDgenerate(), ".csv", sep="")
  write.csv(dat, file = filename, row.names=FALSE, ...)
  new("physical", 
      objectName = filename, 
      size = as(object.size(dat), "numeric"), 
      characterEncoding = guess_encoding(),
      dataFormat = new("dataFormat", 
                       textFormat = new("textFormat", 
                                 numHeaderLines = 1L,
                                 numFooterLines = 0L,
                                 recordDelimiter = "\\r\\n",
                                 attributeOrientation = "column",
                                 simpleDelimited = 
                                   new("simpleDelimited", fieldDelimiter = ",")))) 
}
# Attempt to determine encoding. Helper function
guess_encoding <- function(){
  encoding = getOption("encoding")
  if(encoding == "native.enc")
    encoding = tryCatch(Sys.getlocale("LC_CTYPE"), 
                        error = function(e) character(0))
  encoding
}




