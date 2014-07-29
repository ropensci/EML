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
  }
  metadata
}


prompt_for_units <- function(dataframe, n){
  column <- dataframe[[n]]
    ## Factor Data
    if(is.factor(column)){
      lvls <- levels(column)
        m1 <- paste("column", n, "appears to contain categorical data.\n")
      if(is.ordered(column)){
        m1 <- paste("column", n, "appears to contain ordered categorical data.\n")
      } else {
      }
      
      m2 <- paste("Categories are ", paste(lvls, collapse = ", "), 
                  "\n Please define each of the categories at the prompt\n", sep="")
      out <- character(length(lvls))
      names(out) <- lvls
      for(item in lvls){
        out[item] <- readline(paste(m1,m2,"define '", item, "':\n", sep=""))
      }
   ## Numeric Data 
    } else if(is.numeric(column)){
      m1 <- paste("column", n, "appears to contain numerical data.\n")
      m2 <- paste("If this is incorrect, please change the column class and try again.\n")
      m3 <- "Otherwise, please specify the units from the list below\n or type 'custom' to define a custom unit type\n"
      out <- readline(paste(m1, m2, m3, "units are: "))
      if(out == "custom"){
#        out<- readline("custom unit creation not yet supported. Define unit:") 
        out <- eml_define_unit(column) 
      }
    ## Date-time data
    } else if(is(column, "POSIXt")){
    ## Character Data ###
    } else if(is.character(column)){
      m1 <- "Column appears to contain character sting data (not factor or a dateTime object)\n"
      out <- readline(paste(m1, "Please provide a description of this data\n"))
    }
    out
}



