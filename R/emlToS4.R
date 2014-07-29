## Used as the basis for all coercion methods from XML::XMLInternalElementNode 
## to EML's S4 objects.  

## Assumes slot is named by the name of the repeated element
## but has type "ListOf<element>" which contains a list containing
## the repeated elements.  
emlToS4 <- function (node, obj = new(xmlName(node)), ...){
    if (is(obj, "character") && !isS4(obj)) 
        obj = new(obj)
    ids = names(node)
    nodes = xmlChildren(node)
    ## isn't  that automatic from the class definition?   
    obj = addXMLAttributes(obj, xmlAttrs(node)) ## treat attributes as slots. 
    slotIds = slotNames(obj)
    slots = getClass(class(obj))@slots

    for (i in slotIds ) {  
      if(i %in% names(node)){  ## only process slotIds that have corresponding values in the XML) 
        ## Added this condition to hadle multiple elements of same name
        if(is(new(slots[[i]]), "list")){
          ## don't want to loop over all nodes, just those whose name matches i. 
          matching_nodes <- nodes[(names(nodes) %in% i)]
          slot(obj, i) <- listof(matching_nodes, i)  
        } else {
          val <- 
          if (slots[[i]] == "character") 
              xmlValue(nodes[[i]])
          else 
            as(nodes[[i]], slots[[i]])
          slot(obj, i) <- val
        }
      } else if(i == xmlName(node)) {
        if(slots[[i]] == "character")
          slot(obj, i) <- xmlValue(node)
      }
    }
    obj
}

## Hacks XML::xmlToS4 to deal with lists 
listof <- function(kids, element, listclass = paste0("ListOf", element))
  new(listclass, lapply(kids[names(kids) == element], as, element))  ## subsets already 


## Reproduce function not exported from XML to avoid NOTE
addXMLAttributes <- 
function (obj, attrs) 
{
    slots = getClass(class(obj))@slots
    i = match(names(attrs), names(slots))
    if (any(!is.na(i))) 
        for (i in names(attrs)[!is.na(i)]) slot(obj, i) <- as(attrs[i], 
            slots[[i]])
    obj
}

