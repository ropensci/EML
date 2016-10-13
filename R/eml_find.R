#eml_get <- function(eml, element, ...){
#  eml_get(eml_find(eml, element), ...)
#
#}



#' eml_find
#'
#' find all occurrences of an EML element in at a given node at any depth
#' @param node an EML S4 object; e.g. `eml` or any of it's child/descendant slots.
#' @param element the name of an EML element to find
#' @return the requested element as an EML S4 object
#' @export
#'
eml_find <- function(node, element) {
  if (is.list(node) && length(node) > 0) {
    nonempty_lapply(node, eml_find, element)
  } else {
    slots <- getSlots(class(node))
    children <- names(slots)
    #children <- children[!(slots %in% c("character", "xml_attribute", "XMLInternalNode"))]
    #simple <- children[(slots %in% c("character", "xml_attribute", "XMLInternalNode"))]
    #if(element %in% simple)
    
    if (element %in% children) {
      slot(node, element)
      
    } else {
      nonempty_lapply(children, function(x)
        eml_find(slot(node, x), element))
    }
  }
}


nonempty_lapply <- function(x, f, ...) {
  found <- list()
  for (i in x) {
    out <- f(i, ...)
    if (isS4(out) || length(out) > 0)
      found <- c(found, list(out))
  }
  if (length(found) == 1)
    found[[1]]
  else if (length(found) == 0)
    NULL
  else
    found
}
