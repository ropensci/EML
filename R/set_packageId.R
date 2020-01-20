#' set packageId
#' Add a helper function to set packageId
#' @param eml an existing eml list object. Default is a new list.
#' @param packageId desired package ID to use (e.g. a DOI).  If not provided,
#' an UUID-based ID will automatically be generated for you.
#' @param system The system used for creating the ID (e.g. DOI, UUID, etc)
#' @return The input eml object with packageId now added
#' @export
#' @importFrom uuid UUIDgenerate
#' @examples
#' eml <- set_packageId()
#'
# Dev Note: this does not follow the constructor pattern of other set methods.
# This takes the whole `eml` document as input and returns it (i.e. like a OO method),
# while other set_ methods follow a less OO model, just taking the arguments and returning a
# list fragment (e.g. the "attributesList" part, not the whole eml).
set_packageId <- function(eml = list(), packageId = uuid::UUIDgenerate(), system = "uuid"){
  ## should we warn if overwriting previous package id? prompt for interactive decision?
  if (!is.null(eml$packageId)) {
    warning(paste("Overwriting previous packageId:", eml$packageId))
  }
  eml$packageId <- uuid::UUIDgenerate()
  eml$system <- "uuid"
  eml
}