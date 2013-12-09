

#' @export 
eml_get <- function(eml, 
                    x = c("id", 
                          "version", 
                          "filepath", 
                          "unit.defs", 
                          "col.defs", 
                          "citation_info", 
                          "data.set")){
  if(!is(eml, "eml"))
    stop("object 'eml' must be of class 'eml'")

  x <- match.arg(x)
  switch(x, 
         "data.set" = get_data.set(eml),
         "id" = id(eml),
         "version" = version(eml),
         "filepath" = filepath(eml),
         "unit.defs" = unit.defs(eml),
         "col.defs" = col.defs(eml),
         "citation_info" = citation_info(eml),
         "keywords", keywords(eml),
         "coverage", coverage(eml), 
         "contact", contact(eml),
         "creator", creator(eml),
         "attributeList", attributeList(eml))
}
