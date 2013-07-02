#' Convert EML into a YAML file
#' 
#' Provides a reasonably readable plain-text summary of metadata by converting XML to YAML
#' @param file the path to the EML file to be converted
#' @param con optional file name to write out to (see \link{\code{writeLines}}. 
#'  otherwise returned to terminal.  
#' @param .parseopts optional additional arguments to \link{\code{xmlParse}}
#' @param .yamlopts optional additional arguments to \link{\code{as.yaml}}
#' @returns A YAML representation of the metadata in the EML file, either
#' to the terminal or externally.  
#' @examples
#' file <- system.file("doc", "my_eml_data.xml", package="reml")
#' eml_yaml(file)
#' # we can pass additional optional arguments too, e.g.
#' eml_yaml(file, .yamlopts = list(indent=4))
eml_yaml <- function(file, con = stdout(), .parseopts=list(), .yamlopts=list()){
  available <- require(yaml)
  if(!available)
    stop("please install the yaml package first to use this function")
  else {
    doc <- do.call(xmlParse, c(file, .parseopts))
    .yamlopts$x <- xmlToList(doc) 
    out <- do.call(as.yaml, .yamlopts)
    writeLines(out, con = con)
  }
}
