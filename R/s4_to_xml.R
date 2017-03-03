
emptynode <- function(node){
  (!isS4(node) && length(node) == 0) || (is(node, "xml_attribute") && length(as.character(node)) == 0)
}

is.basic <- function(x) !isS4(x) && length(x) > 0 && (is.character(x) || is.numeric(x))
excluded_slots <- c("namespaces", "dirname", "slot_order", "xmlNodeName")

#' @import xml2
#' @import methods
s4_to_xml <- function(obj, root = NULL, ns = eml_namespaces){

    node_name <- class(obj)[[1]]
    fields <- setdiff(slotNames(obj), excluded_slots)

    if(is.null(root)){
      root <- do.call(xml_new_root, c(list(.value = node_name), ns))
      xml <- root
    } else {
      xml <- xml_add_child(root, node_name)
    }

    lapply(fields, function(child){
      node <- slot(obj, child)
      if(is.null(node) || emptynode(node)){
        xml
      } else if(is(node, "xml_attribute")){             # node is an attribute
        if(child == "schemaLocation") child <- paste0("xsi:", child)  #Hack, should fix slot name to keep prefix
        xml_set_attr(xml, child, as.character(node))
      } else if(grepl("ListOf", class(node))){
        lapply(node, s4_to_xml, xml)
      } else if(is.basic(node)){
        xml_set_text(xml, node)
      } else if(isS4(node)){                            # node is S4 class
        s4_to_xml(node, xml)
      } else {                                          # node is a simple type
        xml_add_child(xml, child, node)
      }
    })

   empty <- "//*[not(*)][not(normalize-space())]"
   xml_remove(xml_find_all(root, empty))

  root
}


#' root <- xml2::xml_new_root("eml", "xmlns:eml" = "eml://ecoinformatics.org/eml-2.1.1")
#' eml <- EML::read_eml("inst/examples/example-eml-2.1.1.xml")
#' xml <- s4_to_xml(eml@dataset, root)
#' xml2::write_xml(xml, "test.xml")


xml_to_s4 <- function(){}

