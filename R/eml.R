eml_namespaces = c(eml = "//ecoinformatics.org/eml-2.1.1", 
                   ds = "//ecoinformatics.org/dataset-2.1.1",
                   xs = "http://www.w3.org/2001/XMLSchema",
                   xsi = "http://www.w3.org/2001/XMLSchema-instance",
                   stmml = "http://www.xml-cml.org/schema/stmml-1.1")

setClass("eml",
         representation(packageId   = "character", 
                        system      = "character", 
                        namespaces  = "character",
                        dataset     = "dataset",
                        additionalMetadata = "additionalMetadata"),
          prototype = prototype(packageId = paste(sep='', "urn:uuid:", uuid::UUIDgenerate()),
                                system = 'uuid',
                                namespaces = eml_namespaces))
setAs("XMLInternalElementNode", "eml", function(from) emlToS4(from))
setAs("eml", "XMLInternalElementNode",   function(from) S4Toeml(from))
setAs("eml", "XMLInternalDocument",   function(from){
      newXMLDoc(node = as(from, "XMLInternalElementNode"))
          })


#' generator for eml
eml <- function(dat, metadata, title, description = character(0), 
                creator = new("ListOfcreator", 
                              list(get("defaultCreator", envir=remlConfig))), 
                contact = get("defaultContact", envir=remlConfig),
                methods = new("methods"), 
                additionalMetadata = new("additionalMetadata")){
  if(is(creator, "character"))
    creator <- as(creator, "creator")

  if(is(creator, "creator"))
    creator <- new("ListOfcreator", list(creator))

  if(is.null(contact) | length(contact) == 0 )
    contact <- creator[[1]]

  new("eml", 
      dataset = new("dataset", 
                    title = title,
                    creator = creator,
                    contact = contact,
                    dataTable = eml_dataTable(dat, metadata, title, description),
                    methods = methods))
}


