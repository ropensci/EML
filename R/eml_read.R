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


