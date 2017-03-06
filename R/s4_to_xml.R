
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

  who <- slotNames(obj)
  if ("namespaces" %in% who & length(ns) == 0) ns <- obj@namespaces
  slot_classes <- get_slots(class(obj))
  is_attribute <- sapply(slot_classes, function(x) x == "xml_attribute")
  attribute_elements <- who[is_attribute]

  ## clear namespace. except for stmml
  if (!grepl("^stmml:", node_name)) node_name <- gsub("^[a-z]*:", "", node_name)
  #if (length(ns) > 0) node_name <- paste0("eml:", node_name)


  ## Okay, here we go, time to create some xml. First we'll need a root if we don't have it:
  if(is.null(root)){
    root <- xml_new_root(node_name,
                         "xmlns:eml" = "eml://ecoinformatics.org/eml-2.1.1",
                         "xmlns:xs" = "http://www.w3.org/2001/XMLSchema",
                         "xmlns:xsi" = "http://www.w3.org/2001/XMLSchema-instance",
                         "xmlns:stmml" = "http://www.xml-cml.org/schema/stmml_1.1")
    xml <- root
  } else {
    xml <- xml_add_child(root, node_name)
  }

  base_attributes <- c("lang")
  schema_attributes <- c("schemaLocation")


  ## Handle the special case of "InlineType" -- which contain raw xml (for docbook text)
  if (is(obj, "InlineType")) {  # should be inherits(obj, "InlineType") ?
    xml_add_child(root, obj)  ## really? maybe need to subset the thing first?
  } else {

    who <- who[!(who %in% excluded_slots)] # drop excluded slots
    names(who) <- who
    ## Re-order 'who' to obey 'slot_order' slot.
    ordering <- slot(obj, "slot_order")
    who <- c(ordering, who[!who %in% ordering])

    for (s in who) {
      ## Attributes
      if (s %in% attribute_elements) {
        if (length(slot(obj, s)) > 0) {
          attrs <- as.character(slot(obj, s))
          if (s %in% base_attributes)
            s <- paste0("xml:", s)
          if (s %in% schema_attributes)
            s <- paste0("xsi:", s)
          names(attrs) <- s
          xml_set_attrs(root, attrs)
        }
        ## metaTypes are used in slots rather than interitence to preserve element ordering!
        ## Capitalized slots are meta-types, and should not create a new xmlNode but instead
        ## pass their children directly to their parent node.
      } else if (grepl("^[A-Z]", s)) {
        X <- slot(obj, s)
        xml_add_child(root, S4Toeml(X, root = root))
      } else {
        ## Complex child nodes
        X <- slot(obj, s)
          if (is(X, "InlineType"))
            xml_add_child(root, xml_add_child(root, s, X))
          else if (is(X, "list") && length(X)>0) {
            if (is(X[[1]], "InlineType"))
              lapply(X, function(x)  xml_add_child(root, s, x))
            else if (is.character(X[[1]]) && length(get_slots(class(X[[1]]))) <= 1)
              lapply(X, function(x) xml_add_child(root, class(x), x))
            else
              lapply(X, S4Toeml, root)
          } else if (isS4(X)) {
            xml_add_child(root, S4Toeml(slot(obj, s)))
            ## Simple Child nodes
          } else if (length(X) > 0) {
            if (s == class(obj)[1] || s == ".Data")
              # special case
              xml_add_children(root, X)   #
            else
              xml_add_children(root, xml_add_child(root, s, X))
            ## No child node
          }

      }
    }
  }
  empty <- "//*[not(*)][not(normalize-space())]"
  xml_remove(xml_find_all(root, empty))

  root
}
S4Toeml <- s4_to_xml



dummy <- function(){
  node_name <- class(obj)[[1]]
  fields <- setdiff(slotNames(obj), excluded_slots)

  if(is.null(root)){
    root <- xml_new_root(node_name,
                         "xmlns:eml" = "eml://ecoinformatics.org/eml-2.1.1",
                         "xmlns:xs" = "http://www.w3.org/2001/XMLSchema",
                         "xmlns:xsi" = "http://www.w3.org/2001/XMLSchema-instance",
                         "xmlns:stmml" = "http://www.xml-cml.org/schema/stmml_1.1")
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

