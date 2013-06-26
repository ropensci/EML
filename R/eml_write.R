#' Write a data table into an EML file
#' 
#' @import XMLSchema
#' @import XML
#' @export
#' @examples
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
  template = xmlParse("inst/examples/hf250.xml")

  emlroot = newXMLNode("eml:eml", 
                        namespaceDefinitions =
                        xmlNamespaceDefinitions(template, simplify=TRUE))
  emldoc = newXMLDoc(node = emlroot)
  dataset = eml_dataset(...)
  addChildren(emlroot, dataset)
  saveXML(emldoc, file)
}


