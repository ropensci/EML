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


