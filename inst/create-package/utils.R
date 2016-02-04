## Some potential convenience functions, not currently in use for anything.



#' @import XML
#' @import xml2


xml_to_XML <- function(x){
  temp <- tempfile()
  xml2::write_xml(x, file=temp)
  doc <- XML::xmlParse(temp)
  XML::xmlRoot(doc)
}

XML_to_xml <- function(x){
  temp <- tempfile()
  doc <- XML::xmlDoc(x)
  XML::saveXML(doc, file = temp)
  xml2::read_xml(temp)
}



