#' View an EML
#'
#' @param eml_path Path to the EML one wants to view
#' @param ... additional arguments to \code{\link{read_xml}}
#' @return Nothing, the EML is viewed in the Viewer.
#' @export
#' @importFrom xml2 as_list
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
eml_view <- function(eml_path, ...){
  if (!requireNamespace("listviewer", quietly = TRUE)) {
      message("eml_view needs the listviewer package, \n
              Install it via install.packages('listviewer')")
    return(NULL)
    }

  doc <- read_xml(eml_path, ...)
  eml_list <- xml2::as_list(doc)

  ## shouldn't call function from a Suggested package, see get_TextType for how we use rmarkdown fns
  jsonedit <- getExportedValue("listviewer", "jsonedit")
  # jsonedit(eml_list)
}
