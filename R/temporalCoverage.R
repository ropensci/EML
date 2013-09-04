setClass("alternativeTimeScale",
         representation(timeScaleName = "character",
                        timeScaleAgeEstimate = "character",
                        timeScaleAgeUncertainty = "character",
                        timeScaleAgeExplanation = "character",
                        timeScaleCitation = "character") # FIXME should be citation type
        )
setAs("XMLInternalElementNode", "alternativeTimeScale",   function(from) emlToS4(from))
setAs("alternativeTimeScale", "XMLInternalElementNode",   function(from) S4Toeml(from))


setClass("singleDateTime",
         representation(calendarDate = "character",
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
         representation(beginDate = "beginDate",  
                        endDate = "endDate"))
setAs("XMLInternalElementNode", "rangeOfDates",   function(from) emlToS4(from))
setAs("rangeOfDates", "XMLInternalElementNode",   function(from) S4Toeml(from))

setClass("temporalCoverage",
         representation(id = "character",
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



# FIXME should be an S4 coersion method(?)
to_ISO8601 <- function(x){
  if(is.character(x))
    x <- as.Date(x, '%Y-%m-%d')
  if(is(x, "Date"))
    format(x, "%Y-%m-%d")
}
