
eml_boilerplate <- function(.dataframe, enumerated = NA){
  strng <- list()
  for(i in 1:ncol(.dataframe)){
  # i = 1
  .variable <- names(.dataframe)[i]
  #.dataframe[,.variable]
    if(is.character(.dataframe[ ,.variable])){
      .dataframe[,.variable]  <- factor(.dataframe[,.variable])
    }

  if(is.factor(.dataframe[,.variable])  & i %in% enumerated){
    x <- .dataframe[,.variable]
    vals <-  names(table(x))
    # symbols may pollute the string to parse
    vals <- make.names(vals)
    vals <- tolower(vals)
    vals <- gsub("\\.","_",vals)
    vals <- gsub("_+","_",vals)
    v <- .variable
    #v
    strng[[.variable]] <- paste(
    v, ' = c(',
    paste(vals, sep = '', collapse = ' = "TBA",')
    ,' = "TBA")', sep = '')
  } else if(is.factor(.dataframe[,.variable])){

    strng[[.variable]] <- paste(
      .variable, ' = "TBA"', sep = ''
      )

  } else if(is.numeric(.dataframe[,.variable])){
    v <- .variable
    strng[[.variable]] <- paste(v,' = "number"',sep='')
#    strng[[.variable]] <- '"number"'

  } else if(
    !all(is.na(as.Date(as.character(na.omit(.dataframe[,.variable])), origin = "1970-01-01")))
    ){
    v <- .variable
    strng[[.variable]] <- paste(v,' = "YYYY-MM-DD"',sep='')
#    strng[[.variable]] <- '"YYYY-MM-DD"'

  } else if (all(is.na(.dataframe[ ,.variable]))){
    v <- .variable
    strng[[.variable]] <- paste(v,' = "', names(.dataframe)[i], '"', sep='')
  }
  }
  #strng
  strng2 <- ""
  for(n in 1:(length(strng)-1)){
    strng2 <- paste(strng2, strng[[n]], ",\n")
  }
  strng2 <- paste(strng2, strng[[length(strng)]], "\n")
  #cat(strng2)
  strng3 <- paste("
  unit_metadata =
    list(",strng2,")", sep = "")
  #cat(strng3)
  eval(parse(text = strng3))
  #unit_metadata
  return(unit_metadata)
}
