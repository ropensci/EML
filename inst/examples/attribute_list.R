
library(purrr)

getone <- function(x){
  if(length(x) > 0)
    x[[1]]@.Data
  else
    NA
}

eml <- read_eml("inst/xsd/test/eml-datasetWithAttributelevelMethods.xml")
A <- eml@dataset@dataTable[[1]]@attributeList@attribute


choice <- function(s4){
  who <- slotNames(class(s4))
  drop <- sapply(who, function(x) eml2:::isEmpty(slot(s4,x)))
  who[!drop]
}

purrr::map_df(A, function(a)
  data.frame(name = a@attributeName,
             label = getone(a@attributeLabel),      # optional, can repeat (though goodness knows why)
             type = getone(a@storageType),          # optional, can repeat (though goodness knows why)
             missing = getone(a@missingValueCode),  # optional, can actually be multiple
             scale = choice(a@measurementScale),
             def = a@attributeDefinition,
             stringsAsFactors = FALSE))
