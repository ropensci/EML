#' constructor helper function for data table
#' 
#' constructor helper function for data table
#' @param dat a data.set object, data.frame object
#' @param name the the name of the dataTable 
#' @param description a description of the dataTable
#' @param filename the filename of the csv file created
#' @param ... additional arguments (not yet implemented)
#' @param col.defs Natural language definitions of each column. Should be a character
#' vector of length equal to each column, defined in the same order as the columns are given.   
#' @param unit.defs A list of length equal to the number of columns defining the units for each
#' column. See examples.  
#' @param col.classes column classes, primarily for use if dat is 
#' a path to a csv rather than a native R object. Optional otherwise.    
#' @param additionalInfo character vector of any additional metadata lacking a defined slot. 
#' @return a dataTable element
#' @export
#' @include dataTable_classes.R
eml_dataTable <- 
function(dat, 
         name = "data table", 
         description = character(0), 
         filename = generate_filename(name),
         col.defs = NULL,
         unit.defs = NULL,
         col.classes = NULL,
         additionalInfo = character(0),
         ...){

  id <- eml_id()

  dataTable <- new("dataTable",
                  id = id[["id"]],
                  system = id[["system"]],
                  scope = id[["scope"]],
                  entityName = name,
                  entityDescription = description,
                  attributeList = 
                    eml_attributeList(dat = dat, 
                                      col.defs = col.defs,
                                      unit.defs = unit.defs,
                                      col.classes = col.classes),  
                  physical = eml_physical(dat, 
                                          filename = filename, 
                                          ...),
                  caseSensitive = 'yes',
                  numberOfRecords = dim(dat)[1],
                  additionalInfo = additionalInfo)
# Unused slots: alternateIdentifier, methods, coverage, 
}



## Internal methods for eml_dataTable. Should all the constructor functions be exported??


