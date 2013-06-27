#' Write a data table into an EML file
#' @aliases write.eml
#' 
#' @import XMLSchema
#' @import XML
#' @export
#' @examples
#'  eml$set(givenName = "Carl", surName = "Boettiger", email = "cboettig@@gmail.com")
#'  dat = data.frame(river=c("SAC", "SAC", "AM"), 
#'                    spp = c("king", "king", "ccho"), 
#'                    stg = c("smolt", "parr", "smolt"),
#'                    ct =  c(293L, 410L, 210L))
#'  col_metadata = c(river = "http://dbpedia.org/ontology/River",
#'                   spp = "http://dbpedia.org/ontology/Species", 
#'                   stg = "Life history stage",
#'                   ct = "count")
#'  unit_metadata = 
#'   list(river = c(SAC = "The Sacramento River", AM = "The American River"),
#'        spp = c(king = "King Salmon", ccho = "Coho Salmon"),
#'        stg = c(parr = "third life stage", smolt = "fourth life stage"),
#'        ct = "number")
#' 
#'  node = eml_write(dat, col_metadata, unit_metadata) 
#
eml_write = function(..., file = "eml_data.xml"){

  emlroot = newXMLNode("eml:eml", namespaceDefinitions = eml_namespaces)
  emldoc = newXMLDoc(node = emlroot)
  dataset = eml_dataset(...)
  addChildren(emlroot, dataset)
  saveXML(emldoc, file=file)
}

eml_namespaces = c(eml = "eml://ecoinformatics.org/eml-2.1.0", 
                   ds = "eml://ecoinformatics.org/dataset-2.1.0",
                   xs = "http://www.w3.org/2001/XMLSchema",
                   xsi = "http://www.w3.org/2001/XMLSchema-instance",
                   stmml = "http://www.xml-cml.org/schema/stmml-1.1")

