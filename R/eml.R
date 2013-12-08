#' @include reml_environment.R 
#' @include eml-dataset.R 
#' @include eml-software.R 
#' @include eml-literature.R 
#' @include eml-protocol.R



setClass("metadata", contains="XMLInternalElementNode")
setAs("metadata", "XMLInternalElementNode", function(from) newXMLNode("metadata", from))
setAs("XMLInternalElementNode", "metadata", function(from) new("metadata", from))

setClass("additionalMetadata", 
         slots = c(metadata = "metadata",
                   describes = "character",
                   id = "character"))

setAs("additionalMetadata", "XMLInternalElementNode", function(from) S4Toeml(from))
setAs("XMLInternalElementNode", "additionalMetadata", 
      function(from){ 
        if("describes" %in% names(from))
          describes <- xmlValue(from[["describes"]])
        else
          describes <- character(0)
        new("additionalMetadata", 
            describes = describes, 
            metadata = as(from[["metadata"]], "metadata"))
      })

setClass("ListOfadditionalMetadata", contains="list")

############# eml top-level  ######################


## Default XML namespaces -- consider moving to separate file 
eml_namespaces = c(eml = "eml://ecoinformatics.org/eml-2.1.1", 
                   ds = "eml://ecoinformatics.org/dataset-2.1.1",
                   xs = "http://www.w3.org/2001/XMLSchema",
                   xsi = "http://www.w3.org/2001/XMLSchema-instance",
                   stmml = "http://www.xml-cml.org/schema/stmml-1.1")



## Define S4 class
setClass("eml",
         slots = c(packageId   = "character", 
                        system      = "character",
                        scope       = "character",
                        dataset     = "dataset",
#                        software    = "software",
#                        citation    = "citation",
#                        protocol    = "protocol",
                        additionalMetadata = "ListOfadditionalMetadata",
                        namespaces = "character", 
                        dirname = "character"), 
         # slots 'namespaces' and 'dirnames' are for internal use
         # only and not written as XML child elements.  
         prototype = prototype(namespaces = eml_namespaces))



## Define to/from XML coercions
setAs("XMLInternalElementNode", "eml", function(from) emlToS4(from))
setAs("eml", "XMLInternalElementNode", 
      function(from){
        node <- newXMLNode("eml:eml", namespaceDefinitions = from@namespaces)
        S4Toeml(from, node)
      })


#' Define constructor function 
#' @export
eml <- function(dat, 
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
                additionalMetadata = new("ListOfadditionalMetadata",
                                         list(new("additionalMetadata"))),
                eml_version =  c("2.1.1", "2.1.0")){

  if(is(dat, "data.set")) # use embedded metadata (even if metadata is not NULL?)  
    meta <- metadata(dat)

  if(is.null(meta))
    meta <- metadata_wizard(dat)

  ## Handle older versions of EML
  eml_version <- match.arg(eml_version)
  namespaces <- eml_namespaces
  if(eml_version != "2.1.1"){
    namespaces["eml"] <- gsub("2.1.1", eml_version, eml_namespaces["eml"])
    namespaces["ds"] <- gsub("2.1.1", eml_version, eml_namespaces["ds"])
  }

  ## Coerce character string persons into EML representations
  if(is(creator, "character"))
    creator <- as(creator, "creator")
  if(is(creator, "creator")) # Creator should be ListOfCreator
    creator <- new("ListOfcreator", list(creator))
  if(is.null(contact) | length(contact) == 0 ){
    contact <- as(creator[[1]], "contact")
  }
  if(is(contact, "character"))
    contact <- as(contact, "contact")

  ## Generage a unique id
  id <- reml_id()

  ## Call the generic constructor function and write values into slots
  new("eml",
      packageId = id[["id"]],
      system = id[["system"]],
      scope = id[["scope"]],
      dataset = new("dataset", 
                    title = title,
                    creator = creator,
                    contact = contact,
                    coverage = coverage,
                    dataTable = new("ListOfdataTable", 
                      list(
                      eml_dataTable(dat=dat, 
                                    meta=meta, 
                                    title=title, 
                                    description=description))),
                    methods = methods),
      additionalMetadata = additionalMetadata,
      namespaces = namespaces)
}


## Additional METHODS for this class ## 


# When printing to screen, use YAML
#' @import yaml 
#' @include eml_yaml.R
setMethod("show", signature("eml"), function(object) show_yaml(object))



setMethod("coverage", signature("eml"),
          function(coverage){
## consider checking if multiple datasets?  
          coverage(coverage@dataset@coverage)
          })


#' @export
setMethod("keywords", signature("eml"),
          function(object){
            out <- unname(lapply(object@dataset@keywordSet, keywords))
            thes <- sapply(object@dataset@keywordSet, function(x) x@keywordThesaurus)
            names(out) <- thes
            out
          })



