

eml_show <- function(node){
  
  
  
  if(is.list(node) && length(node) > 0){
    nonempty_lapply(node, eml_show)
  } else {
    slots <- getSlots(class(node))
    children <- names(slots)
    children <- children[!(slots %in% c("XMLInternalNode"))]
    
    for(child in children){
      element <- slot(node, child)
      if(is.character(element))
        cat(paste0(child, ": ", element))
      #else
      #  cat(paste0("\n", child, ":", " ", eml_show(slot(node, child))))
    }
  }
}
