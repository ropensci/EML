#' Convert EML into a YAML file
#'
#' Convert EML into a YAML file
#' @param object any object defined by EML that can be coerced into an XML format
#' @return a yaml representation of the object, also printed to screen.
#' @importFrom yaml as.yaml
#' @import XML
#' @import methods
show_yaml <- function(object)
          cat(yaml::as.yaml(XML::xmlToList(as(object, "XMLInternalElementNode"))))


setMethod("show", signature("eml-2.1.1"), function(object) show_yaml(object))
