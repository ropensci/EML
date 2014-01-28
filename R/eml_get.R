
#' Extract content from an EML object
#' 
#' Extract content from an EML object
#' @param eml an EML object
#' @param x the desired content we should extract from the eml object
#' @return the requested content.  Format will depend on the request.  
#' @details All content can always be accessed using the standard S4 subsetting mechanisms.
#' This function merely provides a convenient interface for returning more commonly requested
#' content in forms that may be more convenient than the S4 structure.  These formats mirror the 
#' input formats used by the corresponding helper constructors.  
#' @export 
eml_get <- function(eml, 
                    x = c("id", 
                          "version", 
                          "csv_filepaths", 
                          "unit.defs", 
                          "col.defs", 
                          "citation_info",
                          "keywords",
                          "coverage",
                          "contact",
                          "creator",
                          "attributeList",
                          "data.set")){
  if(!is(eml, "eml"))
    stop("object 'eml' must be of class 'eml'")

  x <- match.arg(x)
  switch(x, 
         "data.set" = get_data.set(eml),
         "id" = id(eml),
         "version" = version(eml),
         "csv_filepaths" = csv_filepaths(eml),
         "unit.defs" = unit.defs(eml),
         "col.defs" = col.defs(eml),
         "citation_info" = citation_info(eml),
         "keywords" = keywords(eml),
         "coverage" = coverage(eml), 
         "contact" = contact(eml),
         "creator" = creator(eml),
         "attributeList" = attributeList(eml))
   
}


csv_filepaths <- function(eml){
  paste(eml@dirname, 
        sapply(eml@dataset@dataTable, function(dataTable) dataTable@physical@objectName),
        sep = "")
}

