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
#' @include dataTable_classes.R
eml_dataTable <- function(dat, 
                          meta = NULL, 
                          title = "data table", 
                          description = character(0), 
                          filename = character(0),
                          col.defs = NULL,
                          unit.defs = NULL,
                          ...){

## FIXME title should be called entityName, or maybe just "name"
  
  id <- eml_id()

  dataTable <- new("dataTable",
                  id = id[["id"]],
                  system = id[["system"]],
                  scope = id[["scope"]],
                  entityName = title,
                  entityDescription = description,
                  attributeList = eml_attributeList(dat = dat, 
                                                    meta = meta, 
                                                    col.defs = col.defs,
                                                    unit.defs = unit.defs),  
                  physical = eml_physical(dat, filename = filename),
                  caseSensitive = 'yes',
                  numberOfRecords = dim(dat)[1])
}



## Internal methods for eml_dataTable. Should all the constructor functions be exported??


