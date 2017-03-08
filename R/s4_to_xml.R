
emptynode <- function(node){
  (!isS4(node) && length(node) == 0) || (is(node, "xml_attribute") && length(as.character(node)) == 0)
}

is.basic <- function(x) !isS4(x) && length(x) > 0 && (is.character(x) || is.numeric(x))
excluded_slots <- c("namespaces", "dirname", "slot_order", "xmlNodeName")
base_attributes <- c("lang")
schema_attributes <- c("schemaLocation")






s4_to_xml <- function(obj, root = NULL, ns = eml_namespaces){
  node_name <- class(obj)[[1]]
  fields <- setdiff(slotNames(obj), excluded_slots)

  if(is.null(root)){

    names(ns) <- paste("xmlns", names(ns), sep=":")
    root <- do.call(xml_new_root, c(.value = node_name, as.list(ns)))
    xml <- root
  } else {

    if(inherits(obj,"InlineType") && length(obj@.Data) > 0 && is(obj@.Data[[1]], "xml_node")){
      xml <- xml_add_child(root, obj@.Data[[1]])
    } else {
     xml <- xml_add_child(root, node_name)
    }
  }

  lapply(fields, function(child){
    node <- slot(obj, child)
    if(is.null(node) || emptynode(node)){             # slot is empty
      xml
    } else if(is(node, "xml_attribute")){             # node is an attribute
      if(child == "schemaLocation") child <- paste0("xsi:", child)  #Hack, should fix slot name to keep prefix. (schema_attributes)
      #if(child %in% base_attributes)  child <- paste0("xml:", child)
      xml_set_attr(xml, child, as.character(node))
    } else if(grepl("^[A-Z]", child)){                # node is a metanode (class whose children should all become slots)
      xml_add_child(xml, s4_to_xml(node, xml))
    } else if(is(node, "list") && length(node) > 0 && is(node@.Data[[1]], "xml_nodeset")){
      lapply(node@.Data[[1]], function(n) xml_add_child(xml, n))
    } else if(grepl("ListOf", class(node))){
      lapply(node, s4_to_xml, xml)
    } else if(is.basic(node) && child == ".Data"){
      xml_set_text(xml, node)
    } else if(isS4(node)){                            # node is S4 class
      s4_to_xml(node, xml)
    } else if(child != ".Data"){                                          # node is a simple type
      xml_add_child(xml, child, node)
    }
  })


  ## FIXME: We could use the option="no_empty_tags" from write_xml instead; internal C method, would be faster
  empty <- "//*[not(*)][not(normalize-space())]"  ## FIXME do not remove attribute-only nodes
  xml_remove(xml_find_all(root, empty))

  root
}

S4Toeml <- s4_to_xml
