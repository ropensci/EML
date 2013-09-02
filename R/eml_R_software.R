#' Create a software node given the name of an R package
#' @param packagename the name of the R package for which we want an EML documentation node
#' See issue [#32](https://github.com/ropensci/reml/issues/32)

## Coerce an installed R package into an EML software node, given the package name
eml_R_software <- function(packagename){
  license <- packageDescription(packagename, fields="License")
  version <- packageDescription(packagename, fields="Version")
  title <- packageDescription(packagename, fields="Title")
  authors <- as.person(packageDescription(packagename, fields="Author")) ## Yay for intelligent coercion!
  implementation <- new("implementation", 
                        distribution = new("distribution", 
                                           new("online", 
                                               url = citation(packagename)$url)))
  new("software", title = title, authors = as(authors, "responsibleParty"), license = license, 
               version = version, implementation = implementation)
}


