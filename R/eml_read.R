#' @include generics.R
#' @include eml.R
NULL






#' Read EML files
#' 
#' Read EML files
#' @param file an external eml (xml) file, or XMLInternalDocument
#' @return an EML object 
#' @export eml_read read.eml
#' @aliases eml_read read.eml
eml_read <- function(file,  ...){

  ## support for file name, XMLInternalDocument, URL, or identifier

  if(is(file, "XMLInternalDocument")){  # if already parsed XML, e.g. from d1_get
    doc <- file
  } else if(file.exists(file)){ # if is a local file path...
    doc <- xmlParse(file=file, ...)
  } else if(is.character(file)){ ## Assume a remote access method?  
      require(httr)
      if(gsub("^(....).*", "\\1", file) %in% c("http", "ftp:", "file")) { ## Is it a URL?
        doc <- content(GET(file), "parsed", "text/xml") # content type not detected automatically
        # FIXME unlink the downloaded xml file after parsing? (may have to be after coercion to eml, due to XML external pointers)  
      } else {   ## Assume object is a DataONE identifer(?)
        doc <- content(GET(paste0("https://cn.dataone.org/cn/v1/object/", file)), "parsed", "text/xml") # content type actually is detected.  
      }
  } else {
    stop("cannot find or parse file")
  }

  ## Parse 
  root <- xmlRoot(doc)
  s4 <- as(root, "eml")

  ##  Keep track of dirname in additional resource files (e.g. csv's) are available in same directory
  s4@dirname <- paste0(dirname(file), "/")
  s4@dataset@dataTable[[1]]@physical@dirname <- paste0(dirname(file), "/") ## Fix for multiple dataTables per dataset
  s4
}
read.eml <- eml_read


## FIXME Don't use `@`s to access elements. In particular,
## this isn't even correct since the current format assumes only 
## 1 dataset per eml and one dataTable per dataset.  
## Simple accessor methods should be written instead.  


## accessor methods.  Note that having the same name as an existing function is no problem.  

setMethod("unit.defs", signature("eml"), function(object){
          metadata <- extract(object@dataset@dataTable[[1]]@attributeList)
          lapply(metadata, function(x) x[[3]])
})


## Make sure this returns a character type! warn if not.  
setMethod("col.defs", signature("eml"), function(object){
          metadata <- extract(object@dataset@dataTable[[1]]@attributeList)
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
          extract(object@dataset@dataTable[[1]]@attributeList)
})




setMethod("dataTable", signature("eml"), function(object){
          df = extract(object@dataset@dataTable[[1]]@physical)    ## FIXME as.Date likely to fail on ambiguous formats, need to extract format first , using=col_classes(object)
          data.set(df, col.defs=col.defs(object), unit.defs=unit.defs(object))
})

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

## FIXME should dat use "using"?  
# FIXME is this really the right return format?
          dat = extract(from@dataset@dataTable[[1]]@physical)
            list(dat = dat,
                metadata = extract(from@dataset@dataTable[[1]]@attributeList),
                title = from@dataset@title,
                description = from@dataset@dataTable[[1]]@entityDescription,
                creator = creator(from))
          }
          )







