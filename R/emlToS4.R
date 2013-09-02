## Used as the basis for all coercion methods from XML::XMLInternalElementNode 
## to reml's S4 objects.  

## Assumes slot is named by the name of the repeated element
## but has type "ListOf<element>" which contains a list containing
## the repeated elements.  
emlToS4 <- function (node, obj = new(xmlName(node)), ...){
    if (is(obj, "character") && !isS4(obj)) 
        obj = new(obj)
    ids = names(node)
    nodes = xmlChildren(node)
    obj = XML:::addXMLAttributes(obj, xmlAttrs(node))
    slotIds = slotNames(obj)
    slots = getClass(class(obj))@slots
    for (i in seq(along = nodes)) {
        if (ids[i] %in% slotIds) {

          ## Added this condition to hadle multiple elements of same name
          if(is(new(slots[[ids[[i]]]]), "list"))
            slot(obj, ids[i]) <- listof(nodes, ids[[i]])
          else {

            val = if (slots[[ids[i]]] == "character") 
                xmlValue(nodes[[i]])
            else as(nodes[[i]], slots[[ids[i]]])
            slot(obj, ids[i]) <- val
          }
        }
    }
    obj
}

## Hacks XML::xmlToS4 to deal with lists 
listof <- function(kids, element, listclass = paste0("ListOf", element))
  new(listclass, lapply(kids[names(kids) == element], as, element))

