#' Top-level API function for writing eml 
#' @aliases write.eml 
#' @export
eml_write <- function(dat, 
                      metadata = NULL, 
                      title = "metadata", 
                      description = character(0), 
                creator = get("defaultCreator", envir=remlConfig), 
                contact = get("defaultContact", envir=remlConfig),
                coverage = eml_coverage(scientific_names = NULL, 
                                        dates = NULL,
                                        geographic_description = NULL,
                                        NSEWbox = NULL),
                methods = new("methods"), 
                additionalMetadata = new("additionalMetadata"),
                file = paste0(gsub(" ", "_", title), ".xml")){

  if(is(dat, "data.set")) # use embedded metadata (even if metadata is not NULL?)  
    metadata <- metadata(dat)

  if(is.null(metadata))
    metadata <- metadata_wizard(dat)

  s4 <- eml(dat = dat, 
            metadata = metadata, 
            title = title, 
            description = description, 
            creator = creator,
            contact = contact, 
            coverage = coverage, 
            methods = methods, 
            additionalMetadata = additionalMetadata)
  xml <- as(s4, "XMLInternalElementNode")
  saveXML(xml, file = file)
}







