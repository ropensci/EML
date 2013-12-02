#' @include referencesGroup.R

setClass("alternativeTimeScale",
         slots = c(timeScaleName = "character",
                        timeScaleAgeEstimate = "character",
                        timeScaleAgeUncertainty = "character",
                        timeScaleAgeExplanation = "character",
                        timeScaleCitation = "character") # FIXME should be citation type
        )
setAs("XMLInternalElementNode", "alternativeTimeScale",   function(from) emlToS4(from))
setAs("alternativeTimeScale", "XMLInternalElementNode",   function(from) S4Toeml(from))


setClass("singleDateTime",
         slots = c(calendarDate = "character",
                        time = "character",
                        alternativeTimeScale = "alternativeTimeScale"))
setAs("XMLInternalElementNode", "singleDateTime",   function(from) emlToS4(from))
setAs("singleDateTime", "XMLInternalElementNode",   function(from) S4Toeml(from))

setClass("beginDate", contains="singleDateTime")
setAs("XMLInternalElementNode", "beginDate",   function(from) emlToS4(from))
setAs("beginDate", "XMLInternalElementNode",   function(from) S4Toeml(from))

setClass("endDate", contains="singleDateTime")
setAs("XMLInternalElementNode", "endDate",   function(from) emlToS4(from))
setAs("endDate", "XMLInternalElementNode",   function(from) S4Toeml(from))

setClass("rangeOfDates", 
         slots = c(beginDate = "beginDate",  
                        endDate = "endDate"))
setAs("XMLInternalElementNode", "rangeOfDates",   function(from) emlToS4(from))
setAs("rangeOfDates", "XMLInternalElementNode",   function(from) S4Toeml(from))

setClass("temporalCoverage",
         slots = c(id = "character",
                        singleDateTime = "singleDateTime",
                        rangeOfDates = "rangeOfDates"),
         contains = "referencesGroup")
setAs("XMLInternalElementNode", "temporalCoverage",   function(from) emlToS4(from))
setAs("temporalCoverage", "XMLInternalElementNode",   function(from) S4Toeml(from))


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
