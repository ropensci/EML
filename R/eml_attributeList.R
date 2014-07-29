#' eml_attributeList
#'
#' eml_attributeList
#' 
#' @param dat a data.frame (or a data.set which has col.defs and unit.defs)
#' @param col.defs the column definitions (if not given in meta)
#' @param unit.defs the unit definitions (if not given in meta)
#' @param col.classes column classes, primarily for use if dat is 
#' a path to a csv rather than a native R object. Optional otherwise.    
#' @param col.names names of the columns, if dat is a csv file path.  
#' @export
eml_attributeList <- 
function(dat = NULL, 
         col.defs = NULL,
         unit.defs = NULL,
         col.classes = NULL,
         col.names = NULL){

  if(is(dat, "data.frame")){
    if(is.null(col.classes))
      col.classes <-  sapply(dat, class)
    if(is.null(col.names))
      col.names <-  names(dat)
  } else if (is(dat, "character") && is.null(col.names)){
    tmp <- read.csv(dat, nrows=3, header=TRUE)
    col.names <- names(tmp)
  }


  if(is(dat, "data.set")) 
    meta <- get_metadata(dat)

  if(!is.null(col.defs) && !is.null(unit.defs) && 
     !is.null(col.names)){
      meta <- lapply(1:length(col.defs), 
                     function(i) list(
                       col.names[[i]], 
                       col.defs[[i]], 
                       unit.defs[[i]]))
  } #else if(is.null(meta)) {
    #meta <- metadata_wizard(dat)  # Wizard isn't helpful 
  #}

  ## Detect & add EML class based on R's col.classes
  meta <- detect_class(meta, col.classes)

#  as(meta, "attributeList")

  uid <- eml_id()
  new("attributeList",
      id = uid[["id"]], 
      attribute = new("ListOfattribute", 
                      lapply(meta, eml_attribute, uid[["id"]])))
}


#' Helper function to attach classes to metadata
#' @param meta a list containing attribute-level 
#' metadata for each column.  see details. 
#' @param col.classes a character vector of column classes from the data.  
#' @details each element of meta list corresponds to a consecutive
#' column, and gives a list containing the column name (as appearing in the
#' data-frame), the column description (e.g. from col.defs) and the unit defs
#' (e.g. from unit.defs) as  a (named) character vector.
detect_class <- function(meta, col.classes){
  for(i in 1:length(meta)){
    if(length(col.classes) == 1)
      cls <- col.classes
    else if(length(col.classes) < 1)
      cls <- "character"
    else 
      cls <- col.classes[[i]]

    meta[[i]][[4]] <- map(cls) 
  }
  meta 
}
map <- function(x){
  if("numeric" %in% x | "integer" %in% x )
    "ratio" ## FIXME ideally we'd want to keep track of integer vs numeric..
  else if("ordered" %in% x)
    "ordinal"
  else if("factor" %in% x)
    "nominal"
  else if("POSIXlt" %in% x | "POSIXct" %in% x | "Date" %in% x)
    "dateTime"
  else if("character" %in% x )
    "nominal"
  else 
    "nominal" 
}


eml_attribute <- function(from, ...){
        new("attribute", 
            attributeName = from[[1]],
            attributeDefinition = from[[2]],
            measurementScale = eml_measurementScale(from[[3]], from[[4]], ...))
}


eml_measurementScale <- function(unit.def, col.class, attrListID = NULL){

  ## FIXME HACK.  Consider more explicit R-based col.class, 
  if(col.class == "nominal" && length(unit.def) == 1)
    new("measurementScale", 
        nominal = new("nominal", 
                      nonNumericDomain = new("nonNumericDomain",
                                             textDomain = new("textDomain", 
                                                              definition = unit.def))))
  else 
  switch(col.class,
         nominal = new("measurementScale", 
                       nominal = new("nominal", 
                                     nonNumericDomain = eml_nonNumericDomain(unit.def))), 
         ordinal = new("measurementScale", 
                       ordinal = new("ordinal", 
                                     nonNumericDomain = eml_nonNumericDomain(unit.def))), 
         ratio = new("measurementScale", 
                     ratio = new("ratio",
                                 numericDomain = new("numericDomain", 
                                                     numberType = "real"), #FIXME get numberType properly
                                 unit = eml_unit(unit.def[[1]]))), 
         # FIXME has precision and numericDomain@numberType, numericDomain@boundsGroup
         dateTime = new("measurementScale", 
                        dateTime = eml_dateTime(unit.def[[1]]) ), 
         interval = new("measurementScale", 
                        interval = new("interval",
                                       numericDomain = new("numericDomain", 
                                                           numberType = "real"), 
                                       unit = eml_unit(unit.def[[1]])))
         )
}

eml_dateTime <- function(formatstring){ # FIXME perform validation. Accept R notation (%Y -> YYYY)
  new("dateTime", formatString = formatstring)
}
eml_nonNumericDomain <- function(from){
new("nonNumericDomain", 
    enumeratedDomain = 
      new("enumeratedDomain", 
          codeDefinition = 
            new("ListOfcodeDefinition", 
                lapply(names(from), 
                       function(name) new("codeDefinition", 
                                          code = name, 
                                          definition = as.character(from[name]))))))
}

eml_unit <- function(unit){
  if(is_standard_unit(unit)){ 
    out <- new("unit", 
               standardUnit = unit) 
  } else {
    out <- new("unit", customUnit = unit)
    if(!in_custom_library(unit))
      eml_define_unit(unit)
  }
  out
}




in_custom_library <- function(unit){
  custom_units <- mget("custom_units", envir = EMLConfig, ifnotfound=list(list()))$custom_units
  custom_types <- mget("custom_types", envir = EMLConfig, ifnotfound=list(list()))$custom_types
  unit %in% sapply(c(custom_types, custom_units), `[[`, "id")
}


