## Additional METHODS for this class ## 


#' eml constructor function 
#' @param dat a data.set object  
#' @param title for the metadata.  Also used as the csv filename.   
#' @param creator a ListOfcreator object, character string, or person object.  
#'  Otherwise loaded from value set by eml_config.  
#' @param contact a contact object, character string, or person object.  
#'  Otherwise loaded from value set by eml_config.  
#' @param coverage a coverage object, such as created by the eml_coverage constructor function. (optional)
#' @param citation a citation object (optional, an EML file can have either 
#' a dataset OR citation OR software OR protocol as its top-level object) 
#' @param software a software object (optional) 
#' @param protocol a protocol object (optional) 
#' @param methods a method object or plain text string, documenting additional methods 
#' @param ... additional slots passed to the dataset constructor `new("dataset", ...)`
#' @param additionalMetadata an additionalMetadata object
#' @details
#' 
#' - Permits character string definitions of creator & contact
#' - generates a unique PackageId
#' - Avoids more verbose separate call to dataset constructor and eml_dataTable
#' 
#' @import methods
#' @include party.R
#' @include eml.R
#' @export 
eml <- function(dat = NULL,
                title = "metadata",
                creator = get("defaultCreator", envir=EMLConfig),
                contact = get("defaultContact", envir=EMLConfig),
                coverage = eml_coverage(scientific_names = NULL,
                                        dates = NULL,
                                        geographic_description = NULL,
                                        NSEWbox = NULL),
                methods = new("methods"),
                ...,
                additionalMetadata = c(new("additionalMetadata")),
                citation = NULL,
                software = NULL,
                protocol = NULL
                )
{


  ## Coerce character string persons into EML representations


  uid <- EML_id()
  who <- contact_creator(contact = contact, 
                         creator = creator)


  if(is(methods, "character")){
    methods <- new("methods", methodStep = c(new("methodStep", description = methods)))
  }

  eml <- new("eml",
             packageId = uid[["id"]], 
             system = uid[["system"]],
             scope = uid[["scope"]], 
             additionalMetadata = additionalMetadata)


  if(!isEmpty(dat)){
    if(is(dat, "dataset")){ # pre-built dataset object
      eml@dataset <- dat 
    } else if(is(dat, "data.frame")){  # data.set class, (also data.frame with wizard)
      eml@dataset = new("dataset", 
                        title = title, # required 
                        creator = who$creator,
                        contact = who$contact,
                        coverage = coverage,
                        methods = methods, 
                        dataTable = c(eml_dataTable(dat = dat, 
                                                    title = title)),
                        ...)
    } else if(is(dat, "dataTable")){
       eml@dataset = new("dataset", 
                        title = title, # required 
                        creator = who$creator,
                        contact = who$contact,
                        coverage = coverage,
                        methods = methods, 
                        dataTable = c(dat),
                        ...)
    }
 }

  if(!isEmpty(citation))
    eml@citation <- citation
  if(!isEmpty(software))
    eml@software <- software
  if(!isEmpty(protocol))
    eml@protocol <- protocol
 
 
  eml 
}


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





contact_creator <- function(contact = get("defaultContact", envir=EMLConfig), 
                            creator = get("defaultCreator", envir=EMLConfig)){

   ## Get a contact first 
  if(is.null(contact) || length(contact) == 0 || isEmpty(contact)){ # IF no contact given... 
   ## If no creator given either...
    if(is.null(creator) || length(creator) == 0 || isEmpty(creator)){
      if(interactive()){
        contact <- person_wizard("contact")  ## USE THE WIZARD!
      } else { 
        stop("no creator or contact given.")
      }
    ## Else, use the first creator...
    } else {
      if(is(creator, "ListOfcreator"))
        contact <- as(creator[[1]], "contact")
      else 
        contact <- as(creator, "contact")
    }
  } # 
  

  ## Handle cas of contact given as alternative format, e.g. character and person coercions 
  contact <- as(contact, "contact")
  
  ## We now have a contact... If we don't have a creator, use this: 
  if(is.null(creator) || length(creator) == 0 || isEmpty(creator) ){
    creator <- as(contact, "creator")
  }

   if(!is(creator, "ListOfcreator")){
    creator <- c(as(creator, "creator")) # ListOf
  }

  list(contact = contact, creator = creator)
}

