#' Write a data table into an EML file
#' 
#' @import XMLSchema
#' @import XML
#' 
eml_write <- function(){
  template <- xmlParse("inst/examples/hf250.xml")
  emlroot <- newXMLNode("eml:eml", 
                        namespaceDefinitions =
                        xmlNamespaceDefinitions(template, simplify=TRUE))
  emldoc <- newXMLDoc(node = emlroot)
  newXMLNode("eml:dataset", parent=emlroot)
  ## Add <access> node from eml_settings if not provided

  ## Add <dataset>
}


