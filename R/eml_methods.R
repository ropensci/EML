## Additional METHODS for this class ## 

# When printing to screen, use YAML
#' @import yaml 
#' @include eml_yaml.R
setMethod("show", signature("eml"), function(object) show_yaml(object))

setMethod("coverage", signature("eml"),
          function(coverage){
          coverage(coverage@dataset@coverage)
          })


setGeneric("keywords", function(object) standardGeneric("keywords"))
setMethod("keywords", signature("eml"),
          function(object){
            out <- unname(lapply(object@dataset@keywordSet, keywords))
            thes <- sapply(object@dataset@keywordSet, 
                           function(x) x@keywordThesaurus)
            names(out) <- thes
            out
})
setMethod("keywords", signature("keywordSet"), 
          function(object){
           unname(sapply(object@keyword, slot, "keyword"))
})



## FIXME Don't use `@`s to access elements. In particular,
## this isn't even correct since the current format assumes only 
## 1 dataset per eml and one dataTable per dataset.  
## Simple accessor methods should be written instead.  


## accessor methods.  Note that having the same name as an existing function is no problem.  
setGeneric("unit.defs", function(object) standardGeneric("unit.defs"))
setMethod("unit.defs", signature("eml"), function(object){
          metadata <- extract(object@dataset@dataTable[[1]]@attributeList)
          lapply(metadata, function(x) x[[3]])
})


## Make sure this returns a character type! warn if not.  
setGeneric("col.defs", function(object) standardGeneric("col.defs"))
setMethod("col.defs", signature("eml"), function(object){
          metadata <- extract(object@dataset@dataTable[[1]]@attributeList)
          sapply(metadata, function(x) x[[2]])
})


setGeneric("contact", function(object) standardGeneric("contact"))
setMethod("contact", signature("eml"), function(object) as(object@dataset@contact, "person"))

setGeneric("creator", function(object) standardGeneric("creator"))
setMethod("creator", signature("eml"), function(object)
  as(object@dataset@creator, "person"))

#  paste(format(as(object@dataset@creator, "person"), 
#               include=c("given", "family"), 
#               braces = list(family=c("", ""))), collapse=", "))




## FIXME Consider extracting additional fields:  url, key, possibly month, note, etc
#  publisher should possibly be 'journal' (e.g. so it prints by default?) 
setGeneric("citation_info", function(object) standardGeneric("citation_info")) # can overload 'citation' if we didn't set a generic
setMethod("citation_info", signature("eml"), function(object){
              bibentry(bibtype="Manual",
                       title = object@dataset@title,
                       author = creator(object),
                       year = object@dataset@pubDate,
                       publisher = object@dataset@publisher@organizationName)
})


setGeneric("attributeList", function(object) standardGeneric("attributeList"))
setMethod("attributeList", signature("eml"), function(object){
          extract(object@dataset@dataTable[[1]]@attributeList)
})



setGeneric("get_data.set", function(object) standardGeneric("get_data.set"))
setMethod("get_data.set", signature("eml"), function(object){
          df = extract(object@dataset@dataTable[[1]]@physical)    
          data.set(df, 
                   col.defs=col.defs(object), 
                   unit.defs=unit.defs(object))
})


setGeneric("col_classes", function(object) standardGeneric("col_classes"))
setMethod("col_classes", signature("eml"),
          function(object)
            get_col_classes(object@dataset@dataTable[[1]]@attributeList@attribute))
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


## Depricated, stupid function 
## FIXME should use accessor methods in place of @
## FIXME DOn't assume dataTable[[1]] 
#setMethod("extract", signature("eml"),
#          function(from){
#          # Get classes for data table first from attribute list!
#          dat = extract(from@dataset@dataTable[[1]]@physical)
#            list(dat = dat,
#                metadata = extract(from@dataset@dataTable[[1]]@attributeList),
#                title = from@dataset@title,
#                description = from@dataset@dataTable[[1]]@entityDescription,
#                creator = creator(from))
#          }
#          )
#
#









#' eml constructor function 
#' 
#' @details
#' 
#' - Permits character string definitions of creator & contact 
#' - Avoid separate call to eml_dataTable, just pass it dat, optionally meta too
#' 
eml <- function(dat,            ## attribute level
                meta = NULL,    ## attribute level 
## physical level
                title = "metadata",         # required  
                description = character(0), # optional
## dataset level 
                creator = get("defaultCreator", envir=remlConfig), # required
                contact = get("defaultContact", envir=remlConfig), # required 
                coverage = eml_coverage(scientific_names = NULL,   # optional
                                        dates = NULL,
                                        geographic_description = NULL,
                                        NSEWbox = NULL),
                methods = new("methods"),
                ...,
## eml level
                additionalMetadata = c(new("additionalMetadata")))
{


  ## Coerce character string persons into EML representations
  if(is.null(creator))
    creator <- "" 
  if(is(creator, "character") || is(creator, "person"))
    creator <- as(creator, "creator")
  if(is(creator, "creator"))                     
    creator <- c(creator)
  if((is.null(contact) || length(contact) == 0) && is(creator, "ListOfcreator"))
    contact <- as(creator[[1]], "contact")
  if(is(contact, "character"))
    contact <- as(contact, "contact")

  
  eml <- new("eml",
             dataset = new("dataset", 
                           title = title, # required 
                           creator = creator,
                           contact = contact,
                           coverage = coverage,
                           methods = methods, 
                           ...),
             additionalMetadata = additionalMetadata)
  

  ## Identify the kind of dataset by the type of dat provided 
  if(is(dat, "data.frame")){
    eml@dataset@dataTable <- 
      c(eml_dataTable(dat = dat, meta = meta, 
                      title=title, description=description))
  } 

  eml 
}


