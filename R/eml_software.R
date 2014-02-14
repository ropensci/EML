
#' Generate the EML software node for an R package
#' 
#' Generate the EML software node for an R package
#' @param packagename the name of any installed R package
#' @return the eml software element containing the metadata for given package
#' @examples
#'   software <- eml_r_package("EML")
#' @include software.R
#' @export 
eml_r_package <- function(packagename){
  info <- packageDescription(packagename)
#  info$BugReports       
#  info$Suggests   #
#  info$Packaged   # packaged date-time, by user       
#  info$Built      # built by R version 

  cre <- eval(parse(text = info[["Authors@R"]]))
  cre <- new("ListOfcreator", lapply(cre, as, "creator")) 

  ## Find out if distribution is via CRAN, Github, etc
  distribution = new("distribution", online = new("online", url = info$URL))

  
  deps <- strsplit(paste(info$Imports, info$Depends, sep=", "), ", ")
# Dependency must be a Software node. Do we really want to do this recursion? Issue #104 
#  depends <- new("ListOfdependency", 
#                 lapply(deps, function(dep) 
#                        new("dependency", software = eml_r_package(dep))))
  implement <- new("implementation", distribution = distribution)

  ## Capture all package info as a character string without printing to console
  displayInfo <- paste(capture.output(print(info)), collapse="\n")

  new("software",
      shortName = info$Package,
      title = info$Title,
      pubDate = info$Date,
      abstract = info$Description,
      creator = cre,
      license = info$License,
      version = info$Version,
      implementation = implement,
#      dependency = depends,
      additionalInfo = displayInfo)
}
