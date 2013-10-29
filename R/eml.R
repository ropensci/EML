eml_namespaces = c(eml = "eml://ecoinformatics.org/eml-2.1.1", 
                   ds = "eml://ecoinformatics.org/dataset-2.1.1",
                   xs = "http://www.w3.org/2001/XMLSchema",
                   xsi = "http://www.w3.org/2001/XMLSchema-instance",
                   stmml = "http://www.xml-cml.org/schema/stmml-1.1")

setClass("eml",
         representation(packageId   = "character", 
                        system      = "character",
                        scope       = "character",
                        dataset     = "dataset",
                        additionalMetadata = "additionalMetadata",
                        namespaces = "character"),
         prototype = prototype(namespaces = eml_namespaces))
setAs("XMLInternalElementNode", "eml", function(from) emlToS4(from))
setAs("eml", "XMLInternalElementNode", 
      function(from){
        node <- newXMLNode("eml:eml", namespaceDefinitions = from@namespaces)
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
            cat(show(head(x)))
          })




#' generator for eml
eml <- function(dat, 
                metadata, 
                title, 
                description = character(0), 
                creator = get("defaultCreator", envir=remlConfig), 
                contact = get("defaultContact", envir=remlConfig),
                coverage = eml_coverage(scientific_names = NULL, 
                                        dates = NULL,
                                        geographic_description = NULL,
                                        NSEWbox = NULL), 
                methods = new("methods"), 
                additionalMetadata = new("additionalMetadata"),
                eml_version =  c("2.1.1", "2.1.0")){

  eml_version <- match.arg(eml_version)
  namespaces <- eml_namespaces
  if(eml_version != "2.1.1"){
    namespaces["eml"] <- gsub("2.1.1", eml_version, eml_namespaces["eml"])
    namespaces["ds"] <- gsub("2.1.1", eml_version, eml_namespaces["ds"])
  }

  if(is(creator, "character"))
    creator <- as(creator, "creator")

  if(is(creator, "creator")) # Creator should be ListOfCreator
    creator <- new("ListOfcreator", list(creator))

  if(is.null(contact) | length(contact) == 0 ){
    contact <- as(creator[[1]], "contact")
  }

  if(is(contact, "character"))
    contact <- as(contact, "contact")

  
  id <- reml_id()
  new("eml",
      packageId = id[["id"]],
      system = id[["system"]],
      scope = id[["scope"]],
      dataset = new("dataset", 
                    title = title,
                    creator = creator,
                    contact = contact,
                    coverage = coverage,
                    dataTable = eml_dataTable(dat=dat, 
                                              metadata=metadata, 
                                              title=title, 
                                              description=description),
                    methods = methods),
      namespaces = namespaces)
}


