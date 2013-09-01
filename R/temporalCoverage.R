setClass("alternativeTimeScale",
         representation(timeScaleName = "character",
                        timeScaleAgeEstimate = "character",
                        timeScaleAgeUncertainty = "character",
                        timeScaleAgeExplanation = "character",
                        timeScaleCitation = "character") # FIXME should be citation type
        )
setClass("singleDateTime",
         representation(calendarDate = "character",
                        time = "character",
                        alternativeTimeScale = "alternativeTimeScale"))

setClass("rangeOfDates", 
         representation(beginDate = "singleDateTime",
                        endDate = "singleDateTime"))

setClass("temporalCoverage",
         representation(id = "character",
                        singleDateTime = "singleDateTime",
                        rangeOfDates = "rangeOfDates"),
         contains = "referencesGroup")


