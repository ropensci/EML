#' set_methods
#'
#' @param methods_file Path to a file (markdown or .docx) containing a description of the methods used
#' @param instrumentation optional, text describing instrumentation used in methods
#' @param software optional, an EML software node describing software used in methods
#' @param sampling_file optional, Path to a file (.md or .docx) describing sampling method
#' @param sampling_coverage optional, coverage node for methods, e.g. set_coverage()
#' @param sampling_citation optional, a citation element describing the sampling protocol
#' @param qualityControl_file optional, path to a file (.md or .docx) describing quality control methods
#'
#' @return A methods object
#' @export
#'
#' @examples \donttest{
#' f <- system.file("examples/hf205-methods.md", package = "EML")
#' set_methods(methods_file = f)
#'
#' ## Can also import from methods written in a .docx MS Word file.
#' f <- system.file("examples/hf205-methods.docx", package = "EML")
#' set_methods(methods_file = f)
#' }
set_methods <- function(methods_file,
                        instrumentation = character(),
                        software = new("software"),
                        sampling_file = NULL,
                        sampling_coverage = new("coverage"),
                        sampling_citation = new("citation"),
                        qualityControl_file = NULL) {
  if (!is.null(sampling_file) && !isEmpty(sampling_coverage)) {
    sampling <- new(
      "sampling",
      samplingDescription = as(set_TextType(sampling_file), "samplingDescription"),
      studyExtent = new("studyExtent", coverage = sampling_coverage),
      citation = sampling_citation
    )
  } else{
    sampling <- new("sampling")
  }
  
  if (!is.null(qualityControl_file)) {
    qualityControl <- new("qualityControl",
                          description = as(set_TextType(qualityControl_file), "description")
                          )
  } else {
    qualityControl <- new("qualityControl")
  }
  
  methods <- new(
    "methods",
    sampling = sampling,
    methodStep = new(
      "methodStep",
      instrumentation = instrumentation,
      software = software,
      description = as(set_TextType(methods_file), "description")
      )
  )
  methods
}
