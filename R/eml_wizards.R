#' Generate unit and column metadata for a data.frame
#' 
#' Utility to help generate unit and column metadata for a data.frame
#' @param dataframe a data.frame object  
#' @return a metadata list object, such as could be passed to eml_dataTable
# @export
metadata_wizard <- function(dataframe){
  metadata <- vector("list", length(dataframe))
  names(metadata) <- names(dataframe)
  for(n in names(dataframe)){
    description <- readline(paste("Enter description for column '", n, "':\n ", sep=""))
    unit_metadata <- prompt_for_units(dataframe, n)
    metadata[[n]] <- list(n, description, unit_metadata)
    message("\n")
  }
  metadata
}


prompt_for_units <- function(dataframe, n){
  column <- dataframe[[n]]
    ## Factor Data
    if(is.factor(column)){
      lvls <- levels(column)
      message(paste("column", n, "appears to contain categorical data.\n"))
      if(is.ordered(column)){
      message(paste("column", n, "appears to contain ordered categorical data.\n"))
      } else {
      }
      message(paste("Categories are ", paste(lvls, collapse = ", "), "\n Please define each of the categories at the prompt", sep=""))
      out <- character(length(lvls))
      names(out) <- lvls
      for(item in lvls){
        out[item] <- readline(paste("define '", item, "':\n", sep=""))
      }
   ## Numeric Data 
    } else if(is.numeric(column)){
      message(paste("column", n, "appears to contain numerical data.\n"))
      message(paste("If this is incorrect, please change the column class and try again.\n"))
      message("Otherwise, please specify the units from the list below\n or type 'custom' to define a custom unit type")
      out <- readline("units are: ")
      if(out == "custom"){
#        out<- readline("custom unit creation not yet supported. Define unit:") 
        out <- create_custom_unit_metadata(column) 
      }
    ## Date-time data
    } else if(is(column, "POSIXt")){
    ## Character Data ###
    } else if(is.character(column)){
      message("Column appears to contain character sting data (not factor or a dateTime object)\n")
      out <- readline("Please provide a description of this data\n")
    }
    out
}


## FIXME Doesn't provide SI unit extensions
create_custom_unit <- function(column){
      is_SI <- readline("Can the unit be defined in terms of existing SI units? (yes/no)")

      ## Coerce answer into a logical 
      is_SI <- pmatch(is_SI, c("yes", "no"))
      pick <- c(TRUE, FALSE)
      is_SI <- pick[is_SI]

      if(!is_SI){
        out <- readline("description of custom unit: ")
      } else {
        warning("Extended SI definitions not supported yet, treating as a novel unit")
        out <- readline("description of custom unit: ")
      }
}

