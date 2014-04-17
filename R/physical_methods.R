#' @include physical.R

########### extract methods for physical

setMethod("extract", signature("physical", "character"),
          function(from, using=NA){
            # The "ordered" class does not have a coercion defined from character
            # Better to just treat it as a factor 
            using <- gsub("ordered", "factor", using) 
            ## FIXME use the EML to determine read.csv options
            dat <- read.csv(filepath(from))  #colClasses=using)
          })
# If col_classes(object) returns a list, means that colClasses are not simple types (e.g. c("ordered", "factor") or "NULL")
# See read.csv for details.  Meanwhile, if we get a list, just read in ignoring the declared colClasses
setMethod("extract", signature("physical", "list"),
          function(from, using=NA){
            ## FIXME use the EML to determine read.csv options
            dat <- read.csv(filepath(from)) 
          })



## if no `using` option is defined: 
setMethod("extract", signature("physical"),
          function(from, using=NA){
            ## FIXME use the EML to determine read.csv options
            dat <- read.csv(filepath(from)) 
          })




#################################################################


## FIXME  exported for test only, maybe not necessary?
## extraction might not be the best way to define these.  

setGeneric("filepath", function(from) standardGeneric("filepath"))
setMethod("filepath", signature("physical"),
          function(from){
            path <- paste0(from@dirname, from@objectName)
            if(file.exists(path))
              path
            else {
              fail = download.file(from@distribution@online@url, 
                                      destfile = path, method="auto")
              if(!fail)
                path
              else
                stop(paste("could not find file", from@objectName, "in", from@dirname, "or at", from@distribution@online@url))
            }
          })


### Coerce data.frame to physical (csv) using constructor function:

setAs("data.frame", "physical", function(from)
      eml_physical(from)) 


####### Internal function to coerce data.frame to physical #######
## Custom generator. Consider making int an S4 method?  
## FIXME filename should follow https://github.com/ropensci/EML/issues/106
eml_physical <- function(dat, filename=character(0), ...){
  if(length(filename) == 0){
    longID <- gsub('.*:(.*)', '\\1', EML_id()[["id"]])
    shortID <- gsub("(.{6}).+", "\\1", longID)
    filename <- paste("table_", shortID, ".csv", sep = 0)
  }
  suppressWarnings(write.csv(dat, file = filename, row.names=FALSE, ...)) # don't care about warning in coercion of data.set to data.frame
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



