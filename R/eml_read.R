
#' read eml files (.xml)
#'
#' @param file the name or path to the file (see ?xmlParse for details)
#' @param get the name of the object that should be returned 
#' @export
#' @aliases read.eml
eml_read <- function(file, get=c("eml", "data.frame", "attributeList"), ...){
  doc <- xmlParse(file=file, ...)
  root <- xmlRoot(doc)
  s4 <- as(root, "eml")
  
}

## accessor methods.  Note that having the same name as an existing function is no problem.  


setMethod("contact", signature("eml"), function(object) as(object@dataset@contact, "person"))

setMethod("citationInfo", signature("eml"), function(object){
          cat(format(as(object@dataset@creator, "person"),
                     include=c("family", "given"),
                     braces = list(family=c("", ","))),
              ", ", 
              format(as.Date(object@dataset@pubDate), "%Y"), 
              ". ",              
              object@dataset@title, 
              object@dataset@publisher@organizationName, ".\n", sep="")
})

setMethod("attributeList", signature("eml"), function(object){
          extract(object@dataset@dataTable@attributeList)
})

setMethod("dataTable", signature("eml"), function(object){
          out = extract(object@dataset@dataTable@physical, using=col_classes(object))
          out
})
setMethod("col_classes", signature("eml"),
          function(object)
            get_col_classes(object@dataset@dataTable@attributeList@attribute))
get_col_classes <- function(attrs){          
          sapply(attrs,
                function(x){
                  y <- x@measurementScale
                  if(!isEmpty(y@dateTime))
                    "Date"
                  else if(!isEmpty(y@ratio))
                    "numeric"
                  else if(!isEmpty(y@interval))
                    "numeric"
                  else if(!isEmpty(y@nominal)){
                    z <- y@nominal@nonNumericDomain
                    if(!isEmpty(z@textDomain))
                      "character"
                    else if(!isEmpty(z@enumeratedDomain))
                      "factor"
                  } else if(!isEmpty(y@ordinal)){
                    z <- y@nominal@nonNumericDomain
                    if(!isEmpty(z@textDomain))
                      "character"
                    else if(!isEmpty(z@enumeratedDomain))
                      "ordered"
                  }
                })
}



## FIXME should use accessor methods in place of @
## FIXME many of these can be lists, class definitions must be fixed
setMethod("extract", signature("eml"),
          function(from){
          # Get classes for data table first from attribute list!


          dat = extract(from@dataset@dataTable@physical)
            list(dat = dat,
                metadata = extract(from@dataset@dataTable@attributeList),
                title = from@dataset@title,
                description = from@dataset@dataTable@entityDescription,
                creator = from@dataset@creator)
          }
          )
