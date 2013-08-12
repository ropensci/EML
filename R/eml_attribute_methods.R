#' Helper function to attach classes to metadata
#' @export 
detect_class <- function(dat, meta){
  for(i in 1:length(dat)){
    meta[[i]][[4]] = map(class(dat[[i]])) 
  }
  meta 
}

map <- function(x){
  if(is(x, "numeric"))
    "eml:ratio"
  else if(is(x, "ordered"))
    "eml:ordinal"
  else if(is(x, "factor"))
    "eml:nominal"
  else if(is(x, "POSIXlt") | is(x, "POSIXct"))
    "eml:dateTime"
  else if(is(x, "character"))
    "eml:nominal"
}


### Character to eml:nominal (factors and character strings) ###
setAs("character", "eml:nominal", 
      function(from)
        new("eml:nominal",
            nonNumericDomain = as(from, "eml:nonNumericDomain")))


setAs("character", "eml:textDomain", function(from){
  new("eml:textDomain", definition = from)
})
setAs("character", "eml:nonNumericDomain", 
      function(from){
        if (length(from) == 1)
          new("eml:nonNumericDomain",
              textDomain = as(from, "eml:textDomain"))
        else if(length(from) > 1)
          new("eml:nonNumericDomain", 
              enumeratedDomain = as(from, "ListOfCodeDefinition"))
      })
setAs("character", "ListOfCodeDefinition", 
      function(from){
        new("ListOfCodeDefinition", 
            lapply(names(from), function(name)
              new("eml:codeDefinition", code = name, definition = from[name])))
      })


## Promote nominal to a measurement scale
setAs("eml:nominal", "eml:measurementScale",
      function(from)
        new("eml:measurementScale", 
            nominal = from))


## Ordinal ##
setAs("character", "eml:ordinal", 
      function(from)
        new("eml:ordinal",
            nonNumericDomain = as(from, "eml:nonNumericDomain")))
setAs("eml:ordinal", "eml:measurementScale",
      function(from)
        new("eml:measurementScale", 
            ordinal = from))


## Ratio ## 
setAs("character", "eml:ratio", 
      function(from)
        new("eml:ratio", unit = as(from, "eml:unit")))
setAs("character", "eml:unit", 
      function(from)
        new("eml:ratio", standardUnit = from)) # Could match from to the standardUnit list

#### interval ### 
setAs("character", "eml:interval", 
      function(from)
        new("eml:interval", unit = as(from, "eml:unit")))


## dateTime ## 
setAs("character", "eml:dateTime", 
      function(from)
        new("eml:dateTime", formatString = from)) ## could perform check / validation on string


            
## Coerce from[[3]] into appropriate scale
setAs("list", "eml:attribute", 
      function(from)
        new("eml:attribute", 
            attributeName = from[[1]],
            attributeDefinition = from[[2]],
            measurementScale = as(as(from[[3]], from[[4]]), "eml:measurementScale")))


setAs("list", "eml:attributeList", function(from){
  if(! all(sapply(from, class) == "list") )
    error("expected list of lists")
  new("eml:attributeList", lapply(from, as, "eml:attribute"))
})





#attrList =  as(metadata, "eml:attributeList")


  
#new("eml:dataset", dataTable = new("eml:dataTable", attributeList = attrList) )

