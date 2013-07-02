#' Write R objects into an EML file
#' 
#' Generates an EML file corresponding to the data provided.   
#' @aliases write.eml
#' 
#' @return Writes the EML file generated to the filename given.   May also write out 
#' the R object to the appropriate file type -- e.g. data.frames will be written out 
#' to CSV files linked to the EML. Invsibily returns a pointer to the EML document,
#' as would be returned from \code{\link{xmlParse}}.  
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
#'
#'
eml_write = function(..., file = NULL){
# FIXME Allow modifying an existing EML file(?)
# FIXME Support for writing alternative EML objects
	available <- require(uuid)
	if(!available) {
		top("Creating EML requires the uuid package")
	} else {
		pid = paste(sep='', "urn:uuid:", UUIDgenerate())
#		message(pid)
		emlroot = newXMLNode("eml:eml", attrs = c(packageId = pid, system = 'uuid'), namespaceDefinitions = eml_namespaces)
		emldoc = newXMLDoc(node = emlroot)
		dataset = eml_dataset(...)
		addChildren(emlroot, dataset)
		saveXML(emldoc, file=file)
    invisible(emldoc)
	}
}

eml_namespaces = c(eml = "eml://ecoinformatics.org/eml-2.1.0", 
                   ds = "eml://ecoinformatics.org/dataset-2.1.0",
                   xs = "http://www.w3.org/2001/XMLSchema",
                   xsi = "http://www.w3.org/2001/XMLSchema-instance",
                   stmml = "http://www.xml-cml.org/schema/stmml-1.1")

