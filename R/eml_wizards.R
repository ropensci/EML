
prompt_user_for_columns <- function(dataframe){
  message("You didn't provide descriptions of each column")
  col_metadata <- character(length(dataframe))
  names(col_metadata) <- names(dataframe)
  for(n in names(dataframe)){
    col_metadata[n] <- readline(paste("Enter description for column '", n, "':\n ", sep=""))
  }
}

prompt_user_for_units <- function(dataframe){
  message("You didn't define what units cell values are in")
  unit_metadata <- vector("list", length(dataframe))
  names(unit_metadata) <- names(dataframe)
  for(n in names(dataframe)){
      unit_metadata[[n]] <- prompt_for_units(dataframe, n)
  }
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
        out <- custom_unit_metadata(column)
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

