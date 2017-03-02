#' View an EML
#'
#' @param eml_path Path to the EML one wants to view
#'
#' @return Nothing, the EML is viewed in the Viewer.
#' @export
#'
#' @details The function needs the \code{listviewer} package which you can install from CRAN
#' via \code{install.packages("listviewer"))}. The function uses \code{listviewer::jsonedit}
#' which gives a crude but useful viewing of the EML
#'
#' @examples
#' f <- system.file("xsd/test", "eml-datasetWithUnits.xml", package = "EML")
#' eml_view(f)
#'  f <- system.file("xsd/test", "eml.xml", package = "EML")
#'  eml_view(f)
#'  f <- system.file("xsd/test", "eml-sample.xml", package = "EML")
#'  eml_view(f)
#'  f <- system.file("xsd/test", "eml-datasetWithCitation.xml", package = "EML")
#'  eml_view(f)
#'  f <- system.file("examples", "example-eml-2.1.0.xml", package = "EML")
#'  eml_view(f)
eml_view <- function(eml_path){
  if (!requireNamespace("listviewer", quietly = TRUE)) {
      message("eml_view needs the listviewer package, \n
              Install it via install.packages('listviewer')")
    return(NULL)
    }

  eml_list <- XML::xmlTreeParse(eml_path, encoding = "latin1")
  eml_list <- XML::xmlToList(eml_list,
                             addAttributes = FALSE,
                             simplify = FALSE)

  listviewer::jsonedit(listdata = eml_list)
}
