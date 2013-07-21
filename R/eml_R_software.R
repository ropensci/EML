#' Create a software node given the name of an R package
#' @param packagename the name of the R package for which we want an EML documentation node
#' See issue [#32](https://github.com/ropensci/reml/issues/32)
eml_R_software <- function(packagename, ...){
  license <- packageDescription(packagename, fields="License")
  version <- packageDescription(packagename, fields="Version")
  title <- packageDescription(packagename, fields="Title")
  authors <- as.person(packageDescription(packagename, fields="Author")) ## Yay for intelligent coercion!
  implementation <- list(distribution = list(url = citation(packagename)$url))
  eml_software(title = title, authors = authors, license = license, 
               version = version, implementation = implementation, ...)
}


