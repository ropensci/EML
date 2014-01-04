#' @include eml.R
NULL






#' Read EML files
#'
#' Read EML files
#' @param file an external eml (xml) file, or XMLInternalDocument
#' @return an EML object
#' @export eml_read read.eml
#' @aliases eml_read read.eml
#' @import XML
#' @import httr
eml_read <- function(file,  ...){

  ## Handle different input arguments: ## 

  ## XMLDocument                      FIXME support XMLInternalElementNode! 
  if(is(file, "XMLInternalDocument")){  # if already parsed XML, e.g. from d1_get
    doc <- file

  ## Local Path
  } else if(file.exists(file)){ # if is a local file path...
    doc <- xmlParse(file=file, ...)
  
  ## Remote path
  } else if(is.character(file)){ ## Assume a remote access method?
      require(httr)
      ## URL 
      if(gsub("^(....).*", "\\1", file) %in% c("http", "ftp:", "file")) { ## Is it a URL?
        doc <- content(GET(file), "parsed", "text/xml") 
      
      ## Identifier 
      } else {   ## Assume object is a DataONE identifer(?)
        doc <- content(GET(paste0("https://cn.dataone.org/cn/v1/object/", file)), "parsed", "text/xml") # content type actually is detected.
      }
  } else {
    stop("cannot find or parse file")
  }


  ## Parse
  root <- xmlRoot(doc)
  s4 <- as(root, "eml")

  ## Update the namespaces 
  s4@namespaces <- sapply(xmlNamespaceDefinitions(doc), `[[`, "uri")

  ## Unlink external pointer (saves memory)  
  free(doc)

  ##  Keep track of dirname in additional resource files (e.g. csv's) are available in same directory
  s4@dirname <- paste0(dirname(file), "/")
  s4@dataset@dataTable[[1]]@physical@dirname <- paste0(dirname(file), "/") ## Fix for multiple dataTables per dataset
  s4
}
read.eml <- eml_read


