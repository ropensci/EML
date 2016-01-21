

#' Top-level API function for writing eml 
#' @param dat either a data.frame, data.set, or eml object
#' @param file the filename for the output EML.  If NULL, will return the 
#' XML text as a character string.  
#' @param title a title for the EML metadata file, also used in naming the csv file.  
#' @param creator an EML creator (or ListOfcreator for multiple creators) object, 
#' R person object, or text string recognizable as a name or vector of names.  
#' @param contact an EML contact, R person object with email address, or text
#' string with email in angle brackets.  
#' @param ... additional arguments to dataset and dataTable, see \code{\link{eml_dataTable}}
#' @aliases eml_write write.eml 
#' @import XML
#' @export eml_write write.eml
#' @include reml_environment.R
eml_write <- function(dat = NULL,
                      file = NULL,
                      title = "metadata",
                      creator = get("defaultCreator", envir=EMLConfig), 
                      contact = get("defaultContact", envir=EMLConfig),
                      ...){

  ## dat Types we can handle by coercion
  if(is(dat, "eml")) {
    s4 <- dat

  } else if(is(dat, "dataset")){ # The EML object, not just a plain data.set 

    s4 <- new("eml", dataset = dat)

  } else { ## assemble minimal valid information  


    s4 <- eml(dat = dat, 
              title = title, 
              creator = creator, 
              contact = contact,
              ...)
  }
  xml <- as(s4, "XMLInternalElementNode")
  saveXML(xml, file = file)
}

write.eml <- eml_write



