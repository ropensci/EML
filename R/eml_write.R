

#' Top-level API function for writing eml 
#' @param dat either a data.frame, data.set, or eml object
#' @aliases eml_write write.eml 
#' @import XML
#' @export eml_write write.eml
#' @include reml_environment.R
eml_write <- function(dat, 
                      meta = NULL,
                      title = "metadata",
                      creator = get("defaultCreator", envir=remlConfig), 
                      contact = get("defaultContact", envir=remlConfig),
                      file = NULL){

  ## dat Types we can handle by coercion
  if(is(dat, "eml")) {
    s4 <- dat

  } else if(is(dat, "dataset")){ # The EML object, not just a plain data.set 

    s4 <- new("eml", dataset = dat)

  } else { ## assemble minimal valid information  

  ## If only one of creator or contact is provided, use same person for both.  
  ## If no person is provided, trigger the wizard for contact and use that person as creator 
  ##  (e.g. minimal wizard.  Ideally the wizard would allow for different and multiple creators)  
    if(is.null(contact) || length(contact) == 0 || isEmpty(contact)){ # handle null person class, empty character class, or empty eml:contact class
     if(is.null(creator) || length(creator) == 0 || isEmpty(creator))
      contact <- person_wizard("contact")
     else 
      contact <- as(creator[[1]], "contact")
    }
    if(is.null(creator) || length(creator) == 0 || isEmpty(creator))
      creator <- c(as(contact, "creator"))
    s4 <- new("eml",
              dataset = new("dataset",
                            title = title,
                            creator = creator,
                            contact = contact,
                            dataTable = c(eml_dataTable(dat = dat, 
                                                        meta = meta))))
  }
  xml <- as(s4, "XMLInternalElementNode")
  saveXML(xml, file = file)
}

write.eml <- eml_write



