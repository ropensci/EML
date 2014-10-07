
# Reformat a data frame's column classes based on its metadata
#
# At present, the primary pupose of this function is to convert
# a data frame with Date/Time-formatted columns into one in which
# those columns are formatted as characters using the representation
# dictated by the metadata.  
print_format <- function(dat, unit.defs){
  if(is(dat, "data.set")){
    meta <- get_metadata(dat)
    unit.defs <- lapply(meta, `[[`, 3)
  }
  who <- sapply(dat, is.datetime)
  for(i in which(who)){
    dat[[i]] <- format(dat[[i]], 
                         datetime_to_R(unit.defs[[i]][[1]]))
  }
  dat
}


# A quick helper function to identify any datetime class 
is.datetime <- function(x){
 any(c(is(x, "POSIXlt"), 
       is(x, "Date"),
       is(x, "POSIXt"),
       is(x, "POSIXc")))
}
