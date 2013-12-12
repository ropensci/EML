

#' Top-level API function for writing eml 
#' @param dat either a data.frame, data.set, or eml object
#' @aliases eml_write write.eml 
#' @export eml_write write.eml
#' @include reml_environment.R
eml_write <- function(dat, 
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
                additionalMetadata = new("ListOfadditionalMetadata"),
                file = NULL, # paste0(gsub(" ", "_", title), ".xml"),
                eml_version = c("2.1.1", "2.1.0"))

{
  if(is(dat, "eml"))
    s4 <- dat
  else{

    if(is.null(creator))
      creator <- person_wizard("creator")
    if(is.null(contact))
      contact <- person_wizard("contact")
    if(is(dat, "data.set")) # use embedded metadata (even if metadata is not NULL?)  
            meta <- get_metadata(dat)
    if(is.null(meta)) # If it is still NULL after get_metadata(), 
          meta <- metadata_wizard(dat)
  }

    s4 <- eml(dat = dat, 
            meta = meta, 
            title = title, 
            description = description, 
            creator = creator,
            contact = contact, 
            coverage = coverage, 
            methods = methods, 
            additionalMetadata = additionalMetadata,
            eml_version = eml_version)

  xml <- as(s4, "XMLInternalElementNode")
  saveXML(xml, file = file)
}

write.eml <- eml_write



