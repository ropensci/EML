#' Top-level API function for writing eml 
#' @aliases write.eml 
#' @export
eml_write <- function(dat, 
                      metadata=NULL, 
                      title, 
                      description = character(0), 
                creator = new("ListOfcreator", 
                              list(get("defaultCreator",
                                       envir=remlConfig))), 
                contact = get("defaultContact", envir=remlConfig),
                coverage = eml_coverage(scientific_names = NULL, 
                                        dates = NULL, 
                                        NSEWbox = NULL),
                methods = new("methods"), 
                additionalMetadata = new("additionalMetadata"),
                file = paste0(gsub(" ", "_", title), ".xml")){
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
  saveXML(as(s4, "XMLInternalElementNode"), file=file)
}
