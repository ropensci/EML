
#' constructor helper function for data table
#' 
#' constructor helper function for data table
#' @param dat a data.set object, data.frame object
#' @param meta a list of meta information organized by column.  
#'  Elements of the list are another list, in which: 
#'  - the first object is the column name, 
#'  - then the column description, 
#'  - then the unit definition
#' @param title the the title of the dataTable 
#' @param description a description of the dataTable
#' @param filename the filename of the csv file created
#' @param ... additional arguments (not yet implemented)
#' @return a dataTable element
#' @export
#' @include dataTable.R
eml_dataTable <- function(dat, 
                          meta = NULL, 
                          title = character(0), 
                          description = character(0), 
                          filename = character(0), 
                          ...){

## FIXME title should be called entityName, or maybe just "name"
  
  id <- EML_id()

  dataTable <- new("dataTable",
                  id = id[["id"]],
                  system = id[["system"]],
                  scope = id[["scope"]],
                  entityName = title,
                  entityDescription = description,
                  attributeList = eml_attributeList(dat),  
                  physical = eml_physical(dat, filename = filename),
                  caseSensitive = 'yes',
                  numberOfRecords = dim(dat)[1])
}



eml_attributeList <- function(dat, meta = NULL){

  ## Handle other types 
  if(is(dat, "data.set")) 
    meta <- get_metadata(dat)
  if(is.null(meta))
    meta <- metadata_wizard(dat)
  meta <- detect_class(dat, meta)

  as(meta, "attributeList")

}


### Helper Method updates metadata list with class #######################
#' Helper function to attach classes to metadata
#' @param dat a data frame
#' @param meta a list containing attribute-level metadata for each column.  
#' each element of list corresponds to a consecutive column, and gives a list containing
#' the column name (as appearing in the data-frame), the column description (e.g. from col.defs)
#' and the unit defs (e.g. from unit.defs) as  a (named) character vector.  
detect_class <- function(dat, meta = get_metadata(dat)){
  for(i in 1:length(dat)){
    meta[[i]][[4]] = map(dat[[i]]) 
  }
  meta 
}

map <- function(x){
  if(is(x, "numeric") | is(x, "integer"))
    "ratio" ## FIXME ideally we'd want to keep track of integer vs numeric..
  else if(is(x, "ordered"))
    "ordinal"
  else if(is(x, "factor"))
    "nominal"
  else if(is(x, "POSIXlt") | is(x, "POSIXct") | is(x, "Date"))
    "dateTime"
  else if(is(x, "character"))
    "nominal"
  else 
    "nominal" 
}



