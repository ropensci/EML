
#' add element to an existing EML object 
#' @export
eml_add <- function(eml=new(x, "eml")){
  what <- class(x)

  eml = switch(what, 
               "data.set" = add_dataset(x, eml),
               "additionalMetadata", add_additionalMetadata(x,eml))

  # check that we have created version, id, scope, etc 
  eml 
}

## Append a data.set 
add_dataset <- function(x, eml, ...){
  eml@dataset@dataTable <- c(eml@dataset@dataTable, eml_dataTable(x, ...))
  eml
}
