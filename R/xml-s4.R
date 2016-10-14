## Used as the basis for all coercion methods from XML::XMLInternalNode
## to EML's S4 objects.

## Assumes slot is named by the name of the repeated element
## but has type "ListOf<element>" which contains a list containing
## the repeated elements.

#' @import XML


emlToS4 <- function (node, obj = new(xmlName(node)), ...) {
  node_name <- fix_protected_names(xmlName(node))
  attrs <- xmlAttrs(node)
  children <- drop_comment_nodes(xmlChildren(node))
  xml_names <- names(children)
  xml_attr_names <- names(attrs)

  s4 <- new(node_name)
  slot_classes <- get_slots(node_name)
  s4_names <- names(slot_classes)
  subclasses <- xml_names[!xml_names %in% s4_names]
  not_sub <- xml_names[xml_names %in% s4_names]
  subattrs <- xml_attr_names[!xml_attr_names %in% s4_names]
  not_subattrs <- xml_attr_names[xml_attr_names %in% s4_names]
  subclasses <- c(subclasses, subattrs)
  metanames <- s4_names[grepl("^[A-Z]", s4_names)]
  metaclasses <- lapply(metanames, get_slots)
  names(metaclasses) <- metanames

  text_classes <- "text" %in% subclasses
  subclasses <- subclasses[subclasses != "text"]

  for (child in not_subattrs) {
    slot(s4, child) <- new("xml_attribute", attrs[[child]])
  }

  if (inherits(s4, "InlineType")) {
    kids <- xmlChildren(node)
    class(kids) <- c("list", "XMLInternalNodeList")
    s4@.Data  <- kids
  } else {
    if (length(metaclasses) == 0 && text_classes) {
      #if("value" %in% names(children) && "value" %in% s4_names){
      # s4@value <- listof(children, "value")
      s4@.Data <-
        paste(sapply(children[names(children) == "text"], xmlValue), collapse = "\n")
      #} else {
      #s4@.Data <- xmlValue(node)
      #}
    }


    for (child in unique(subclasses)) {
      y <- lapply(metaclasses, function(x)
        match(child, names(x)))
      s <- names(y)[!is.na(y)]
      cls <- metaclasses[[s]][[y[[s]]]]
      if (is.null(slot(s4, s)))
        slot(s4, s) <- new(s)
      if (grepl("^ListOf", cls))
        slot(slot(s4, s), child) <- listof(children, child)
      else if (cls == "character")
        slot(slot(s4, s), child) <- xmlValue(children[[child]])
      else if (cls == "xml_attribute")
        slot(slot(s4, s), child) <-
        new("xml_attribute" , attrs[[child]])
      else
        slot(slot(s4, s), child) <- emlToS4(children[[child]])
    }

    ## These are the normal s4@slot items
    for (child in unique(not_sub)) {
      cls <- slot_classes[[child]]
      if (grepl("^ListOf", cls)) {
        slot(s4, child) <- listof(children, child)
      } else if (cls == "character") {
        slot(s4, child) <- xmlValue(children[[child]])
      } else {
        slot(s4, child) <- emlToS4(children[[child]])
      }
    }


  }

  s4
}


#' @import XML
#' @import methods
S4Toeml <- function(obj,
                    node = NULL,
                    excluded_slots = c("namespaces", "dirname", "slot_order", "xmlNodeName"),
                    ns = character()) {
  who <- slotNames(obj)
  if ("namespaces" %in% who & length(ns) == 0) {
    ns <- obj@namespaces
  }

  slot_classes <- get_slots(class(obj))
  is_attribute <-
    sapply(slot_classes, function(x)
      x == "xml_attribute")

  attribute_elements <- who[is_attribute]

  ## Allow XML node name to be defined using a special slot (instead of class name)

  if ("xmlNodeName" %in% who) {
    node_name <- slot(obj, "xmlNodeName")
  } else {
    node_name <- class(obj)[1]
  }

  ## clear namespace. except for stmml
  if (!grepl("^stmml:", node_name))
    node_name <- gsub("^[a-z]*:", "", node_name)

  if (length(ns) > 0)
    node_name <- paste0("eml:", node_name)

  if (is.null(node))
    node <- newXMLNode(node_name, namespaceDefinitions = ns)

  base_attributes <- c("lang")
  schema_attributes <- c("schemaLocation")



  if (is(obj, "InlineType")) {
    node <- newXMLNode(node_name, obj)
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
          suppressWarnings(addAttributes(node, .attrs = attrs))
        }

        ## Capitalized slots are meta-types, and should not create a new xmlNode but instead
        ## pass their children directly to their parent node.
      } else if (grepl("^[A-Z]", s)) {
        X <- slot(obj, s)
        if (!isEmpty(X)) {
          addChildren(node, S4Toeml(X, node = node))
        }
      } else {
        ## Complex child nodes
        X <- slot(obj, s)
        if (!isEmpty(X)) {
          if (is(X, "InlineType"))
            addChildren(node, newXMLNode(s, .children = X))
          else if (is(X, "list")) {
            if (is(X[[1]], "InlineType"))
              addChildren(node, kids = lapply(X, function(x)
                newXMLNode(s, .children = x)))
            else if (is.character(X[[1]]) &&
                     length(get_slots(class(X[[1]]))) <= 1)
              addChildren(node, kids = lapply(X, function(x)
                newXMLNode(class(x), x)))
            else
              addChildren(node, kids = lapply(X, S4Toeml))
          } else if (isS4(X)) {
            addChildren(node, S4Toeml(slot(obj, s)))
            ## Simple Child nodes
          } else if (length(X) > 0) {
            if (s == class(obj)[1] || s == ".Data")
              # special case
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


get_slots <- function(class_name) {
  getClass(class_name)@slots
}






##
listof <-
  function(kids,
           element,
           listclass = paste0("ListOf", element))
    new(listclass, lapply(kids[names(kids) == element], emlToS4))  ## subsets already


##  HTML-style comments create: XMLInternalCommentNode as xmlChildren, which we don't want
drop_comment_nodes <- function(nodes) {
  drop <- sapply(nodes, function(x)
    is(x, "XMLInternalCommentNode"))
  out <- nodes[!drop]
  names(out) <- fix_protected_names(names(out))
  out
}

fix_protected_names <- function(x) {
  sapply(x, function(node_name) {
    protected <- c("complex")
    if (node_name %in% protected)
      node_name <- paste0("eml:", node_name)
    node_name
  })
}

