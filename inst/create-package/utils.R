

## utils ##

filename <- function(x){
  strsplit(basename(x), "\\.")[[1]][1]
}

## Contrary to name, doesn't strip "xs:" namespace; this helps to avoid a lot of clashes with protected types
strip_namespace <- function(x){
  purrr::map_chr(x,
                 function(x){
                   if(length(x) > 0){
                     if(grepl("^xs:",  x))
                       x
                     else if(grepl("^xsd:",  x))
                       x <- gsub("^.*:(.*)", "xs:\\1", x)
                     else
                       x <- gsub("^.*:", "", x)
                   }
                   x
                 })
}

print_cmd <- function(l){
  n <- names(l)

  if(is.null(n)){
    out <- paste0("'", as.character(l), "'", collapse = ", ")
  } else {
    out <- ""
    if(length(l) > 1)
      for(i in 1:(length(l)-1))
        out <- paste0(out, "'", n[i], "'", " = '", l[i], "', ")
      out <- paste0(out, "'", n[length(l)], "'", " = '", l[length(l)], "'")
  }

  out
}














## Some potential convenience functions, not currently in use for anything.

#' @import XML
#' @import xml2


xml_to_XML <- function(x){
  temp <- tempfile()
  xml2::write_xml(x, file=temp)
  doc <- XML::xmlParse(temp)
  XML::xmlRoot(doc)
}

XML_to_xml <- function(x){
  temp <- tempfile()
  doc <- XML::xmlDoc(x)
  XML::saveXML(doc, file = temp)
  xml2::read_xml(temp)
}



