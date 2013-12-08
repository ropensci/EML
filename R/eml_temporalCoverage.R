#' @include eml-resource.R

## FIXME work with a variety of dateTime formats
eml_temporalCoverage <- function(dates){
  if(is(dates, "temporalCoverage"))
    dates
  else {
    if(length(dates) == 2){
    node <- new("temporalCoverage", 
                rangeOfDates = 
                new("rangeOfDates", 
                     beginDate = 
                     new("beginDate", 
                         calendarDate = to_ISO8601(dates[1])),
                     endDate = 
                     new("endDate", 
                         calendarDate = to_ISO8601(dates[2]))))
   }
   node
  }
}

#' @include eml_yaml.R
setMethod("show", signature("temporalCoverage"), function(object) show_yaml(object))



# FIXME should be an S4 coersion method(?)
to_ISO8601 <- function(x){
  if(is.character(x)) ## Attempt to make most standard formats into the desired format  
    x <- as.Date(x, '%Y-%m-%d')  
  if(is(x, "Date")) # and then convert into this format. (Note this is not an  else if call!)
    format(x, "%Y-%m-%d")
}
