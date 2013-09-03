#' Top-level API function for writing eml 
#' @aliases write.eml 
#' @export
eml_write <- function(dat, metadata=NULL, title, description = character(0), 
                creator = new("ListOfcreator", 
                              list(get("defaultCreator",
                                       envir=remlConfig))), 
                contact = get("defaultContact", envir=remlConfig),
                methods = new("methods"), 
                additionalMetadata = new("additionalMetadata"),
                file = paste0(gsub(" ", "_", title), ".xml")){
  if(is.null(metadata))
    metadata <- metadata_wizard(dat)

  s4 <- eml(dat, metadata, title, description, creator,
                contact, methods, additionalMetadata)
  saveXML(as(s4, "XMLInternalDocument"), file=file)
}
