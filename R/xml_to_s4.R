## Used as the basis for all coercion methods from xml_node
## to EML's S4 objects.

## Assumes slot is named by the name of the repeated element
## but has type "ListOf<element>" which contains a list containing
## the repeated elements.

xml_to_s4 <- function(node){
  node_name <- fix_protected_names( xml_name(node) )
  attrs <- xml_attrs(node)
  children <-  xml_children(node)
  xml_names <- as.character(xml_name(children))
  xml_attr_names <- names(attrs)

  s4 <- new(node_name)
  slot_classes <- get_slots(node_name)
  s4_names <- sapply(names(slot_classes), strip_prefix)
  names(slot_classes) <- s4_names

  ## sub-classes/attrs are in the xml but do not have an s4 slot, such as: xmlns attributes (additional namespaces)
  subclasses <- xml_names[!xml_names %in% s4_names]
  not_sub <- xml_names[xml_names %in% s4_names]
  subattrs <- xml_attr_names[!xml_attr_names %in% s4_names]
  not_subattrs <- xml_attr_names[xml_attr_names %in% s4_names]
  subclasses <- c(subclasses, subattrs)

  ## metanames are s4 slots referring to a collection of xml elements, such as ResourceGroup, BoundsGroup, etc.
  ## These always start with a capital (but are not in all caps, e.g. ISSN is not a metaclass), and would be an inherited class but that doesn't preserve slot order, so we use them a slot
  metanames <- s4_names[grepl("^[A-Z][a-z]", s4_names)]
  metaclasses <- lapply(metanames, get_slots)
  names(metaclasses) <- metanames

  ## fill in attributes for which we have a slot
  for (child in not_subattrs) {
    slot(s4, child) <- new("xml_attribute", attrs[[child]])
  }



  ## InlineType nodes are left as xml
  if (inherits(s4, "InlineType")) {

    kids <- xml_children(node)
    if(length(kids) > 0){
      s4@.Data <- list(kids)
    } else {
      s4@.Data <- list(node)
    }
  } else {

    ## Simple data node
    if (length(metaclasses) == 0 && length(not_sub) == 0 && ".Data" %in% slotNames(node_name)) {
      s4@.Data <- xml_text(node)
    }

    ## handle the metaclasses
    if(length(metaclasses) > 0 ){
      for (child in unique(subclasses)) {
        y <- lapply(metaclasses, function(x) match(child, names(x)))
        s <- names(y)[!is.na(y)]
        cls <- metaclasses[[s]][[y[[s]]]]
        if (is.null(slot(s4, s)))
          slot(s4, s) <- new(s)
        slot(slot(s4,s),child) <- parse_xml(child, children, cls)
      }
    }

    ## These are the normal s4@slot items
    for (child in unique(not_sub)) {
      cls <- as.character(slot_classes[[child]])
      s <- fix_protected_names(child)
      slot(s4, s) <- parse_xml(child, children, cls)
    }
  }
  s4

}

parse_xml <- function(child, children, cls){
  i <- grep(paste0("^", child, "$"), xml_name(children))  ## position of whole word matches, code != codeExplanation
  if (grepl("^ListOf", cls)) { ## Should be identical to if(length(i) > 1)
    listof(children, child, i)
  } else if (cls == "character") {
     xml_text(children[[i]])
  } else {
     xml_to_s4(children[[i]])
  }
}


##
listof <-
  function(children,
           child,
           i,
           listclass = paste0("ListOf", child))
    new(listclass, lapply(children[i], xml_to_s4))  ## subsets already


fix_protected_names <- function(x) {
  sapply(x, function(node_name) {
    protected <- c("complex")
    if (node_name %in% protected)
      node_name <- paste0("eml:", node_name)
    node_name
  })
}



get_slots <- function(class_name) {
  getClass(class_name)@slots
}



isEmpty <- function(obj) {
  if (!isS4(obj)) {
    if (length(obj) > 0)
      out <- FALSE
    else
      out <- TRUE
  } else {
    if (identical(obj, new(class(obj)[1])))
      out <- TRUE
    else if (is(obj, "list"))
      out <-
        all(sapply(obj, isEmpty))  # a ListOf object of length > 0 is still empty if all elements are empty
    else {
      empty <- sapply(slotNames(obj),
                      function(s) {
                        if (isS4(slot(obj, s)))
                          isEmpty(slot(obj, s))
                        else {
                          if (length(slot(obj, s)) == 0)
                            TRUE
                          else if (length(slot(obj, s)) > 0)
                            FALSE
                        }
                      })
      out <- !any(!empty)
    }
    out
  }
}


emlToS4 <- xml_to_s4
