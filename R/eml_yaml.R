#' Convert EML into a YAML file

show_yaml <- function(object)     
          cat(as.yaml(xmlToList(as(object, "XMLInternalElementNode"))))


