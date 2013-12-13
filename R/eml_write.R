

#' Top-level API function for writing eml 
#' @param dat either a data.frame, data.set, or eml object
#' @aliases eml_write write.eml 
#' @import XML
#' @export eml_write write.eml
#' @include reml_environment.R
eml_write <- function(dat, 
                      meta = NULL, 
                      creator = get("defaultCreator", envir=remlConfig), 
                      contact = get("defaultContact", envir=remlConfig),
                      file = NULL){

  if(is(dat, "eml")) {
    s4 <- dat

  } else if(is(dat, "dataset")){
    s4 <- new("eml", dataset = dat)
  } else {

  # FIXME we want to run these checks on the eml?  
  # Or just provide a validation method for eml?
  # FIXME attempt to get these from config during prototype?
    if(is.null(contact))
      contact <- person_wizard("contact")
    if(is.null(creator))
      creator <- c(as(contact, "creator"))
    s4 <- new("eml", 
              dataset = new("dataset",
                            creator = creator,
                            contact = contact,
                            dataTable = c(eml_dataTable(dat = dat, 
                                                        meta = meta))))
  }
  xml <- as(s4, "XMLInternalElementNode")
  saveXML(xml, file = file)
}

write.eml <- eml_write



