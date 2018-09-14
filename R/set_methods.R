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
#' @examples
#' \donttest{
#' f <- system.file("examples/hf205-methods.md", package = "EML")
#' set_methods(methods_file = f)
#' 
#' ## Can also import from methods written in a .docx MS Word file.
#' f <- system.file("examples/hf205-methods.docx", package = "EML")
#' set_methods(methods_file = f)
#' }
set_methods <- function(methods_file,
                        instrumentation = character(),
                        software = NULL,
                        sampling_file = NULL,
                        sampling_coverage = NULL,
                        sampling_citation = NULL,
                        qualityControl_file = NULL) {
  if (!is.null(sampling_file) && !is.null(sampling_coverage)) {
    sampling <- list(
      samplingDescription = set_TextType(sampling_file),
      studyExtent = list(coverage = sampling_coverage),
      citation = sampling_citation
    )
  } else {
    sampling <- NULL
  }

  if (!is.null(qualityControl_file)) {
    qualityControl <- list(
      description = set_TextType(qualityControl_file)
    )
  } else {
    qualityControl <- NULL
  }

  methods <- list(
    sampling = sampling,
    methodStep = list(
      instrumentation = instrumentation,
      software = software,
      description = set_TextType(methods_file)
    )
  )
  methods
}
