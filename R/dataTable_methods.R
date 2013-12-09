
#' @include dataTable.R
## constructor / generator for data table
eml_dataTable <- function(dat, 
                          meta = NULL, 
                          title = character(0), 
                          description = character(0), 
                          filename = character(0), ...){

  if(is(dat, "data.set")) 
    meta <- get_metadata(dat)
  if(is.null(meta))
    meta <- metadata_wizard(dat)


  if(length(title) > 0 & length(filename) == 0)
    filename <- paste0(gsub(" ", "_", title), ".csv")
  meta <- detect_class(dat, meta)
  id <- reml_id()
  dataTable <- new("dataTable",
                  id = id[["id"]],
                  system = id[["system"]],
                  scope = id[["scope"]],
                  entityName = title,
                  entityDescription = description,
                  attributeList = as(meta, "attributeList"),
                  physical = eml_physical(dat, filename=filename),
                  caseSensitive = 'yes',
                  numberOfRecords = dim(dat)[1])
}


### Helper Method updates metadata list with class #######################
#' Helper function to attach classes to metadata
#' @param dat a data frame
#' @param meta a list containing attribute-level metadata for each column.  
#' each element of list corresponds to a consecutive column, and gives a list containing
#' the column name (as appearing in the data-frame), the column description (e.g. from col.defs)
#' and the 
detect_class <- function(dat, meta){
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
    "nominal" # FIXME should we error or default to character string?
}



