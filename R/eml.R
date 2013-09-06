eml_namespaces = c(eml = "eml://ecoinformatics.org/eml-2.1.1", 
                   ds = "eml://ecoinformatics.org/dataset-2.1.1",
                   xs = "http://www.w3.org/2001/XMLSchema",
                   xsi = "http://www.w3.org/2001/XMLSchema-instance",
                   stmml = "http://www.xml-cml.org/schema/stmml-1.1")

setClass("eml",
         representation(packageId   = "character", 
                        system      = "character", 
                        dataset     = "dataset",
                        additionalMetadata = "additionalMetadata"))
setAs("XMLInternalElementNode", "eml", function(from) emlToS4(from))
setAs("eml", "XMLInternalElementNode", 
      function(from){
        node <- newXMLNode("eml:eml", namespaceDefinitions = eml_namespaces)
        S4Toeml(from, node)
      })

## FIXME this could be much richer
## FIXME use and write accessor and show methods for this info
setMethod("show", 
          signature("eml"),
          function(object){
            x <- extract(object@dataset@dataTable@physical, using=col_classes(object))
            cat(object@dataset@title, 
                object@dataset@dataTable@entityDescription, 
                format(as(object@dataset@creator, "person")), 
                sep="\n")
            cat("", sep="\n\n")
            cat(show(head(x$dat)))
          })




#' generator for eml
eml <- function(dat, 
                metadata, 
                title, 
                description = character(0), 
                creator = new("ListOfcreator", 
                              list(get("defaultCreator", envir=remlConfig))), 
                contact = get("defaultContact", envir=remlConfig),
                coverage = eml_coverage(scientific_names = NULL, 
                                        dates = NULL,
                                        geographic_description = NULL,
                                        NSEWbox = NULL), 
                methods = new("methods"), 
                additionalMetadata = new("additionalMetadata")){
  if(is(creator, "character"))
    creator <- as(creator, "creator")

  if(is(creator, "creator"))
    creator <- new("ListOfcreator", list(creator))

  if(is.null(contact) | length(contact) == 0 )
    contact <- as(creator[[1]], "contact")

  success <- require(uuid)
  if(success){
    id <- paste0("urn:uuid:", uuid::UUIDgenerate())
    system <- "uuid"
  } else {
    id <- paste0("reml_", runif(1, 1e6, 9e6))
    system <- "reml"
  }


  new("eml",
      packageId = id,
      system = system,
      dataset = new("dataset", 
                    title = title,
                    creator = creator,
                    contact = contact,
                    coverage = coverage,
                    dataTable = eml_dataTable(dat=dat, 
                                              metadata=metadata, 
                                              title=title, 
                                              description=description),
                    methods = methods))
}


