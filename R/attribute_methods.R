
########################### Extraction methods ###################################
## methods extract standard R formats (e.g. the metadata list format) 

#' @include attribute_classes.R

setGeneric("extract", function(from, using) standardGeneric("extract"))


setMethod("extract", signature("attributeList"), function(from){
  lapply(from@attribute, 
         function(x) 
           list(x@attributeName,
                x@attributeDefinition,
                extract(x@measurementScale)))
})

 
setMethod("extract", signature("measurementScale"), function(from){
# Find out which scale is not empty...
  plyr::compact(lapply(slotNames(from), function(s)
    if(!isEmpty(slot(from, s)))
      extract(slot(from, s))))[[1]]
})

## FIXME write these methods! 
setMethod("extract", signature("nominal"), function(from){
  x <- from@nonNumericDomain
  if(!isEmpty(x@enumeratedDomain)){  # Factor
    code <- sapply(x@enumeratedDomain@codeDefinition, function(y) y@code)
    def <- sapply(x@enumeratedDomain@codeDefinition, function(y) y@definition)
    names(def) <- code
    def 
  } else if(!isEmpty(x@textDomain)) { # character
    x@textDomain@definition
  }
})
setMethod("extract", signature("ordinal"), function(from){
  extract(as(from, "nominal"))
})
setMethod("extract", signature("ratio"), function(from){
  if(!isEmpty(from@unit@standardUnit))
    from@unit@standardUnit
  else if(!isEmpty(from@unit@customUnit))
    from@unit@customUnit
})
setMethod("extract", signature("interval"), function(from){
  extract(as(from, "ratio"))
})
setMethod("extract", signature("dateTime"), function(from){
  from@formatString
})



