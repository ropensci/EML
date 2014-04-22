#' @include reml_environment.R 
#' @include dataset.R 
#' @include software.R 
#' @include literature.R 
#' @include protocol.R
#' @include EML_id.R


#' @import methods
setClass("metadata", contains="XMLInternalElementNode")
setAs("metadata", "XMLInternalElementNode", function(from) newXMLNode("metadata", from))
setAs("XMLInternalElementNode", "metadata", function(from) new("metadata", from))

setClass("additionalMetadata", 
         slots = c(describes = "character",
                   id = "character",
                   metadata = "metadata"))

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

#' concatenate
#' 
#' concatenate
#' @param x,... additionalMetadatas to concatenate
#' @param recursive Needed for compatibility with generic, otherwise ignored
#' @rdname class-additionalMetadata
setMethod("c", signature("additionalMetadata"), function(x, ..., recursive = FALSE) new("ListOfadditionalMetadata", list(x, ...)))

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
                        citation    = "citation",
                        software    = "software",
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


