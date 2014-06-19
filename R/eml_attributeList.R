#' eml_attributeList
#'
#' eml_attributeList
#' 
#' @param dat a data.frame (or a data.set which has col.defs and unit.defs)
#' @param meta a list of column and unit metadata, OR
#' @param col.defs the column definitions (if not given in meta)
#' @param unit.defs the unit definitions (if not given in meta)
#' @param col.classes the column classes of dat, if dat not given (otherwise inferred from dat)
#'
#' @export
eml_attributeList <- function(dat = NULL, 
                              meta = NULL,
                              col.classes = sapply(dat, class),
                              col.defs = NULL,
                              unit.defs = NULL){


  if(!is.null(col.defs) && !is.null(unit.defs) && 
     is.null(meta) && is(dat, "data.frame")){
    column_names <- names(dat)
    meta <- lapply(1:length(col.defs), 
                   function(i) list(
                     column_names[[i]], 
                     col.defs[[i]], 
                     unit.defs[[i]]))

  } else if(is(dat, "data.set")) { ## Handle other types 
    meta <- get_metadata(dat)

  } else  if(is.null(meta) && is.null(unit.defs)) {
    meta <- metadata_wizard(dat)
  }
  
  ## Handle column classes
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
      create_custom_unit(unit)
  }
  out
}




in_custom_library <- function(unit){
  custom_units <- mget("custom_units", envir = EMLConfig, ifnotfound=list(list()))$custom_units
  unit %in% sapply(custom_units, `[[`, "id")
}


