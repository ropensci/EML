
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
att_df <-
purrr::map_df(A, function(a)
  data.frame(name = a@attributeName,
             label = or_na(getone(a@attributeLabel)@.Data),      # optional, can repeat (though goodness knows why)
             type = or_na(getone(a@storageType)@.Data),          # optional, can repeat (though goodness knows why)
             missing = or_na(getone(a@missingValueCode)@.Data),  # optional, can actually be multiple
             scale = choice(a@measurementScale),
             def = a@attributeDefinition,
             stringsAsFactors = FALSE))

## Ratio/Interval maps
units_df <-
purrr::map_df(A, function(a){
  name = a@attributeName
  scale = choice(a@measurementScale)
  if(scale %in% c("ratio", "interval")){
    b <- slot(a@measurementScale, scale)

    ## Perform Reference lookup.  FIXME consider performing globally.
    if( "ReferencesGroup" %in% choice(b@numericDomain) )
      b@numericDomain <- get_reference(b@numericDomain, eml)

    bounds <- getone(b@numericDomain@BoundsGroup@bounds)

    data.frame(name = name,
               unit = or_na(slot(b@unit, choice(b@unit))@.Data),
               precision = or_na(b@precision@.Data),
               type = or_na(b@numericDomain@numberType@.Data),
               lower_bound = or_na(bounds@minimum@.Data),
               upper_bound = or_na(bounds@maximum@.Data),
      stringsAsFactors = FALSE)

  } else {
    NULL
  }
})

# ## Factors df
# purrr::map_df(A, function(a){
#   name = a@attributeName
#   scale = choice(a@measurementScale)
#   if(scale %in% c("nominal", "ordinal")){
#     b <- slot(a@measurementScale, scale)
#   } else{
#     NULL
#   }
# })
#
# ## times df
#













## should identify all ReferencesGroup elements, and replace them with copy of the
## node that they reference.
resolve_references <- function(eml){
  ## Ideally, just do this all in XML manipulation. Serialize to XML, substitute, and then re-parse.
  doc = XML::xmlParse(write_eml(eml))
  ## FIXME: Would need to do xmlRoot and then find all <references> recursively.  whoops.
  ## This is just a copy of the nodes; changing these values doesn't change `doc`
  refs <- XML::xpathApply(doc, "//references")

  replace <- lapply(refs, function(ref){
    id <- xmlValue(ref)
    nodes <- XML::xpathApply(doc, sprintf("//*[@id = '%s']", id))
  })

}
