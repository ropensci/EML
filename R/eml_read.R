
#' read eml files (.xml)
#'
#' @param file the name or path to the file (see ?xmlParse for details)
#' @param get the name of the object that should be returned 
#' @export eml_read read.eml
#' @aliases eml_read read.eml
eml_read <- function(file, get=c("eml", "data.frame", "attributeList"), ...){
  doc <- xmlParse(file=file, ...)
  root <- xmlRoot(doc)
  s4 <- as(root, "eml")
  
}
read.eml <- eml_read


## FIXME Don't use `@`s to access elements. In particular,
## this isn't even correct since the current format assumes only 
## 1 dataset per eml and one dataTable per dataset.  
## Simple accessor methods should be written instead.  


## accessor methods.  Note that having the same name as an existing function is no problem.  

setMethod("unit.defs", signature("eml"), function(object){
          metadata <- extract(object@dataset@dataTable@attributeList)
          lapply(metadata, function(x) x[[3]])
})


## Make sure this returns a character type! warn if not.  
setMethod("col.defs", signature("eml"), function(object){
          metadata <- extract(object@dataset@dataTable@attributeList)
          sapply(metadata, function(x) x[[2]])
})



setMethod("contact", signature("eml"), function(object) as(object@dataset@contact, "person"))

setMethod("creator", signature("eml"), function(object)
  as(object@dataset@creator, "person"))

#  paste(format(as(object@dataset@creator, "person"), 
#               include=c("given", "family"), 
#               braces = list(family=c("", ""))), collapse=", "))


## FIXME Consider extracting additional fields:  url, key, possibly month, note, etc
#  publisher should possibly be 'journal' (e.g. so it prints by default?) 
setMethod("citationInfo", signature("eml"), function(object){
              bibentry(bibtype="Manual",
                       title = object@dataset@title,
                       author = creator(object),
                       year = object@dataset@pubDate,
                       publisher = object@dataset@publisher@organizationName)
})

setMethod("attributeList", signature("eml"), function(object){
          extract(object@dataset@dataTable@attributeList)
})




setMethod("dataTable", signature("eml"), function(object){
          df = extract(object@dataset@dataTable@physical, using=col_classes(object))
          data.set(df, col.defs=col.defs(object), unit.defs=unit.defs(object))
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
                    z <- y@ordinal@nonNumericDomain
                    if(!isEmpty(z@textDomain))
                      "character"
                    else if(!isEmpty(z@enumeratedDomain))
                      "ordered" # c("ordered", "factor")
                  }
                })
}


## FIXME should use accessor methods in place of @
## FIXME many of these can be lists, class definitions must be fixed
setMethod("extract", signature("eml"),
          function(from){
          # Get classes for data table first from attribute list!

## FIXME should dat use "using"?  
# FIXME is this really the right return format?
          dat = extract(from@dataset@dataTable@physical)
            list(dat = dat,
                metadata = extract(from@dataset@dataTable@attributeList),
                title = from@dataset@title,
                description = from@dataset@dataTable@entityDescription,
                creator = creator(from))
          }
          )










setMethod("coverage", signature("eml"),
          function(coverage){
## consider checking if multiple datasets?  
          coverage(coverage@dataset)
          })
setMethod("coverage", signature("dataset"), 
          function(coverage){ 
            coverage(coverage@coverage)
          })



setMethod("species", signature("taxonomicCoverage"), 
          function(taxonomicCoverage){
            unname(sapply(taxonomicCoverage@taxonomicClassification, 
                 function(object){
                    x <- NULL
                    while(!isEmpty(object)){
                      if(object@taxonRankName %in% c("genus", "species"))
                        x <- c(x, object@taxonRankValue)
                      object <- object@taxonomicClassification
                    }
                    paste(x, collapse = " ")
                 }))
          })



setMethod("coverage", signature("coverage"), 
          function(coverage){
            list(
            scientific_names = species(coverage@taxonomicCoverage),
            dates = c(coverage@temporalCoverage@rangeOfDates@beginDate@calendarDate,
                      coverage@temporalCoverage@rangeOfDates@beginDate@calendarDate),
            geographic_description = coverage@geographicCoverage@geographicDescription,
            NSEWbox = c(north = coverage@geographicCoverage@boundingCoordinates@northBoundingCoordinate, 
                        south = coverage@geographicCoverage@boundingCoordinates@southBoundingCoordinate, 
                        east = coverage@geographicCoverage@boundingCoordinates@eastBoundingCoordinate, 
                        west = coverage@geographicCoverage@boundingCoordinates@westBoundingCoordinate,
                        ## check that units are in meters!
                        min_alt = coverage@geographicCoverage@boundingCoordinates@boundingAltitudes@altitudeMinimum, 
                        max_alt = coverage@geographicCoverage@boundingCoordinates@boundingAltitudes@altitudeMaximum) 
            )

          })

