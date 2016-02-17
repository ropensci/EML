
library(purrr)

getone <- function(x){
  if(is(x, "list")){
    if(length(x) == 0){
      cls <- sub("^ListOf", "", class(x))
      x <- new(class(x), list(new(cls)))
    }
  }
  x[[1]]
}

or_na <- function(x){
  if(length(x) == 0)
    x <- NA
  x
}

get_reference <- function(n, eml){
  id <- n@ReferencesGroup@references[[1]]
  doc = XML::xmlParse(write_eml(eml))
  node <- XML::xpathApply(doc, sprintf("//*[@id = '%s']", id))[[1]]
  eml2:::emlToS4(node)
}


eml <- read_eml("inst/xsd/test/eml-datasetWithAttributelevelMethods.xml")
A <- eml@dataset@dataTable[[1]]@attributeList@attribute


choice <- function(s4){
  who <- slotNames(class(s4))
  drop <- sapply(who, function(x) eml2:::isEmpty(slot(s4,x)))
  who[!drop]
}

## Attribute name/def
purrr::map_df(A, function(a)
  data.frame(name = a@attributeName,
             label = or_na(getone(a@attributeLabel)@.Data),      # optional, can repeat (though goodness knows why)
             type = or_na(getone(a@storageType)@.Data),          # optional, can repeat (though goodness knows why)
             missing = or_na(getone(a@missingValueCode)@.Data),  # optional, can actually be multiple
             scale = choice(a@measurementScale),
             def = a@attributeDefinition,
             stringsAsFactors = FALSE))

## Ratio/Interval maps
purrr::map_df(A, function(a){
  name = a@attributeName
  print(name)
  scale = choice(a@measurementScale)
  if(scale %in% c("ratio", "interval")){
    b <- slot(a@measurementScale, scale)

    ## Perform Reference lookup.  FIXME consider performing globally.
    if(choice(b@numericDomain) == "ReferencesGroup")
      b@numericDomain <- get_reference(b@numericDomain, eml)
    else {
      bounds <- getone(b@numericDomain@BoundsGroup@bounds)

    data.frame(name = name,
               unit = or_na(slot(b@unit, choice(b@unit))@.Data),
               precision = or_na(b@precision@.Data),
               type = or_na(b@numericDomain@numberType@.Data),
               lower_bound = or_na(bounds@minimum@.Data),
               upper_bound = or_na(bounds@maximum@.Data),
      stringsAsFactors = FALSE)
    }
  } else {
    NULL
  }
})


