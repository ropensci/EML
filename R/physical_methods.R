#' @include physical_classes.R

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



