
#' Define constructor function 
#' @export
eml <- function(dat, 
                meta = NULL, 
                title = "metadata", 
                description = character(0), 
                creator = get("defaultCreator", envir=remlConfig), 
                contact = get("defaultContact", envir=remlConfig),
                coverage = eml_coverage(scientific_names = NULL, 
                                        dates = NULL,
                                        geographic_description = NULL,
                                        NSEWbox = NULL), 
                methods = new("methods"), 
                additionalMetadata = new("ListOfadditionalMetadata",
                                         list(new("additionalMetadata"))),
                eml_version =  c("2.1.1", "2.1.0")){

  if(is(dat, "data.set")) # use embedded metadata (even if metadata is not NULL?)  
    meta <- get_metadata(dat)

  if(is.null(meta))
    meta <- metadata_wizard(dat)

  ## Handle older versions of EML
  eml_version <- match.arg(eml_version)
  namespaces <- eml_namespaces
  if(eml_version != "2.1.1"){
    namespaces["eml"] <- gsub("2.1.1", eml_version, eml_namespaces["eml"])
    namespaces["ds"] <- gsub("2.1.1", eml_version, eml_namespaces["ds"])
  }

  ## Coerce character string persons into EML representations
  if(is(creator, "character"))
    creator <- as(creator, "creator")
  if(is(creator, "creator")) # Creator should be ListOfCreator
    creator <- new("ListOfcreator", list(creator))
  if(is.null(contact) | length(contact) == 0 ){
    contact <- as(creator[[1]], "contact")
  }
  if(is(contact, "character"))
    contact <- as(contact, "contact")

  ## Generage a unique id
  id <- reml_id()

  ## Call the generic constructor function and write values into slots
  new("eml",
      packageId = id[["id"]],
      system = id[["system"]],
      scope = id[["scope"]],
      dataset = new("dataset", 
                    title = title,
                    creator = creator,
                    contact = contact,
                    coverage = coverage,
                    dataTable = new("ListOfdataTable", 
                      list(
                      eml_dataTable(dat=dat, 
                                    meta=meta, 
                                    title=title, 
                                    description=description))),
                    methods = methods),
      additionalMetadata = additionalMetadata,
      namespaces = namespaces)
}




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
          ## FIXME as.Date likely to fail on ambiguous formats, need to extract format first , using=col_classes(object)
          data.set(df, col.defs=col.defs(object), unit.defs=unit.defs(object))
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


## FIXME should use accessor methods in place of @
## FIXME many of these can be lists, class definitions must be fixed
setMethod("extract", signature("eml"),
          function(from){
          # Get classes for data table first from attribute list!
          dat = extract(from@dataset@dataTable[[1]]@physical)
            list(dat = dat,
                metadata = extract(from@dataset@dataTable[[1]]@attributeList),
                title = from@dataset@title,
                description = from@dataset@dataTable[[1]]@entityDescription,
                creator = creator(from))
          }
          )







