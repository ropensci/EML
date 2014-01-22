#' Convert EML into a YAML file
#' 
#' Convert EML into a YAML file
#' @param object any object defined by EML that can be coerced into an XML format
#' @return a yaml representation of the object, also printed to screen.
#' @import yaml
#' @import XML
show_yaml <- function(object)     
          cat(as.yaml(xmlToList(as(object, "XMLInternalElementNode"))))


