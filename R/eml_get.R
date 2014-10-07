
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
                          "data.frame",
                          "data.set")){
  if(!is(eml, "eml"))
    stop("object 'eml' must be of class 'eml'")

  x <- match.arg(x)
  switch(x, 
         "data.set" = get_data.set(eml),
         "data.frame" = get_data(eml),
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
  objs <- sapply(eml@dataset@dataTable, function(dataTable) dataTable@physical@objectName) 
  catpaths(eml@dirname, objs)
}


catpaths <- function(dirname, objectName){
  if(length(dirname)==0 || dirname == ".")
    objectName
  else 
    paste0(dirname, objectName)

}

## FIXME allow configuration to toggle off class estimation 
get_data <- function(eml, collapse = TRUE){
  tables <- lapply(eml@dataset@dataTable, function(dataTable){
    filepath <- filepath(dataTable@physical) # use method
    dat <- read.csv(filepath, colClasses = "character")
    dat <- match_column_classes(dataTable@attributeList@attribute, dat)
  })
  if(length(tables) == 1 && collapse)
    tables <- tables[[1]]
  tables
}



match_column_classes <- function(attribute, dat){
  attrs <- get_col.classes(attribute)
  names(attrs) <- sapply(attribute, slot, "attributeName")

  ntmap <- c("real" = "numeric", "natural" = "integer", "whole" = "integer", "integer" = "integer") 

  factor_cols <- which(attrs == "factor")
  for(i in factor_cols)
    dat[[i]] <- as.factor(dat[[i]])

  factor_cols <- which(attrs == "numeric")
  for(i in factor_cols){
    numberType <- c(attribute[[i]]@measurementScale@interval@numericDomain@numberType,
                    attribute[[i]]@measurementScale@ratio@numericDomain@numberType)
    dat[[i]] <- as(dat[[i]], ntmap[[numberType]])
  }

  factor_cols <- which(attrs == "ordered")
  for(i in factor_cols){
   lvls <- sapply(attribute[[i]]@measurementScale@ordinal@nonNumericDomain@enumeratedDomain@codeDefinition, slot, "code")
    dat[[i]] <- ordered(dat[[i]], levels = lvls)
  }

  factor_cols <- which(attrs == "Date")
  if(!eml_get_config("datesAsStrings", "TRUE")){
    for(i in factor_cols){
     fmt <- slot(attribute[[i]]@measurementScale@dateTime, "formatString")
     fmt <- datetime_to_R(fmt)
     dat[[i]] <- as.POSIXlt(dat[[i]], format = fmt)
    }
  }
  # "character" columns already have class 'character'
  dat
}

datetime_to_R <- function(fmt){
  
  map <- c("YYYY" = "%Y",
           "YY" = "%y",
           "MM" = "%m",
           "DD" = "%D",
           "hh" = "%H", # 24 ht
           "mm" = "%M",
           "hhmm" = "%H%M",
           "ss" = "%S",
           "ss.sss" = "%S",
           "DDD" = "%j",
           "WWW" = "%b") # month abbreviation
  
  x <- strsplit(fmt, "[-/:]")[[1]]
  collapse <-  gsub("\\w*([-/:]).*", "\\1", fmt) 
  paste(map[x], collapse = collapse)
}


get_col.classes <- function(attrs){          
          sapply(attrs,
                function(x){
                  y <- x@measurementScale
                  if(!isEmpty(y@dateTime))
                    "Date"
                  else if(!isEmpty(y@ratio))
                    "numeric"
                  else if(!isEmpty(y@interval))
                    "numeric"
                  else if(!isEmpty(y@nominal)){
                    z <- y@nominal@nonNumericDomain
                    if(!isEmpty(z@textDomain))
                      "character"
                    else if(!isEmpty(z@enumeratedDomain))
                      "factor"
                  } else if(!isEmpty(y@ordinal)){
                    z <- y@ordinal@nonNumericDomain
                    if(!isEmpty(z@textDomain))
                      "character"
                    else if(!isEmpty(z@enumeratedDomain))
                      "ordered" # should be c("ordered", "factor")
                  }
                })
}



