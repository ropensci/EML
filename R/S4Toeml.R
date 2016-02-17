
#' @import XML
#' @import methods
S4Toeml <- function(obj,
                    node = NULL,
                    excluded_slots = c("namespaces", "dirname", "xmlNodeName"),
                    ns = character()){

    who <- slotNames(obj)
    if("namespaces" %in% who & length(ns) == 0){
      ns <- obj@namespaces
    }

    slot_classes <- get_slots(class(obj))
    is_attribute <- sapply(slot_classes, function(x) x == "xml_attribute")

    attribute_elements <- who[is_attribute]

    ## Allow XML node name to be defined using a special slot (instead of class name)

    if("xmlNodeName" %in% who){
      node_name <- slot(obj, "xmlNodeName")
    } else {
      node_name <- class(obj)[1]
    }
    ## clear namespace
    node_name <- gsub("^[a-z]*:", "", node_name)

    if(length(ns) > 0)
      node_name <- paste0("eml:", node_name)

    if(is.null(node))
      node <- newXMLNode(node_name, namespaceDefinitions = ns)

    base_attributes = c("lang")
    schema_attributes = c("schemaLocation")



    if(is(obj, "InlineType")){
      node <- newXMLNode(node_name, obj)
    } else {


      who <- who[!(who %in% excluded_slots)] # drop excluded slots
      for(s in who){
        ## Attributes
        if(s %in% attribute_elements){
          if(length(slot(obj,s)) > 0){
            attrs <- as.character(slot(obj,s))
            if(s %in% base_attributes)
              s <- paste0("xml:", s)
            if(s %in% schema_attributes)
              s <- paste0("xsi:", s)
            names(attrs) <- s
            suppressWarnings(addAttributes(node, .attrs = attrs))
          }

        ## Capitalized slots are meta-types, and should not create a new xmlNode but instead
        ## pass their children directly to their parent node.
        } else if(grepl("^[A-Z]", s)){
          X = slot(obj, s)
          if(!isEmpty(X)){
            addChildren(node, S4Toeml(X, node = node))
          }
        } else {
          ## Complex child nodes
          X = slot(obj, s)
          if(!isEmpty(X)){
            if(is(X, "InlineType"))
              addChildren(node, newXMLNode(s, .children = X))
            else if(is(X, "list")){
              if(is(X[[1]], "InlineType"))
                addChildren(node, lapply(X, function(x) newXMLNode(s, .children = x)))
              else if(is.character(X[[1]]) && length(get_slots(class(X[[1]]))) <= 1)
                addChildren(node, lapply(X, function(x) newXMLNode(class(x), x)))
              else
                addChildren(node, lapply(X, S4Toeml))
            } else if(isS4(X)){
              addChildren(node, S4Toeml(slot(obj, s)))
            ## Simple Child nodes
            } else if(length(X) > 0){
               if(s == class(obj)[1] || s == ".Data")              # special case
                addChildren(node, X)   #
               else
                addChildren(node, newXMLNode(s, X))
            ## No child node
            }
          } else {
            node
          }
        }
      }
    }

    node
}


isEmpty <- function(obj){
  if(!isS4(obj)){
    if(length(obj) > 0)
      out <- FALSE
    else
      out <- TRUE
  } else {
    if( identical(obj, new(class(obj)[1])) )
      out <- TRUE
    else if(is(obj, "list"))
      out <- all(sapply(obj, isEmpty))  # a ListOf object of length > 0 is still empty if all elements are empty
    else {
      empty <- sapply(slotNames(obj),
      function(s){
        if(isS4(slot(obj, s)))
          isEmpty(slot(obj,s))
        else {
          if(length(slot(obj, s)) == 0)
            TRUE
          else if(length(slot(obj, s)) > 0)
            FALSE
        }
      })
      out <- !any(!empty)
    }
    out
  }
}


get_slots <- function(class_name){
  getClass(class_name)@slots
}
