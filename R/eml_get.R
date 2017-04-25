

#' eml_get
#'
#' eml_get
#' @include classes.R classes-stmml.R get_attributes.R get_unitList.R
#' @param x an EML object or child/descendant object
#' @param element name of the element to be extracted. If multiple occurrences are found, will extract all
#' @param eml the eml file from which to look up references (optional)
#' @param ... additional arguments for specific get_* methods, see details
#' @details Some elements have custom get_<class> functions which return the requested metadata in a more natural format, such
#' as get_attributeList, which returns data.frames containing the desired metadata.  If such a function exists for the element
#' requested, that function is called instead. Additional arguments given to `eml_get` will be passed to that function via ...,
#' for example, compare \code{\link{get_attributes}} to the example shown here.
#' @examples \donttest{
#' f <- system.file("xsd/test", "eml-datasetWithUnits.xml", package = "EML")
#' eml <- read_eml(f)
#' eml_get(eml, "physical")
#' eml_get(eml, "attributeList")
#'
#' ## The first argument need not be an "eml" class, it could be a child element; e.g.
#' eml_get(eml@dataset@dataTable, "physical")
#' }
#' @rdname eml_get
#' @export
setGeneric("eml_get", function(x, element = NULL, ...) {
  if (is.null(element)) {
    out <- x

  } else {
    all <- eml_find(x, element)
    if (length(all) > 1) {
      out <- lapply(all, eml_get, ...)
      out <-
        out[!sapply(out, eml_empty)] # drop the empty S4 elements
    } else {
      out <- eml_get(all, ...)
    }

    # Return early if no elements were found
    if (length(out) == 0) {
      return(out)
    }

    if (isS4(out) &&
        length(out) < 1)
      # Already a simple S4 element, ready to return
      out <- out
    else if (!isS4(out[[1]]) &&
             length(out) == 1) {
      # deal with the length-1 list of lists
      out <- out[[1]]
      out <-
        out[!sapply(out, eml_empty)] # drop the empty S4 elements
    }
  }
  out
})


eml_empty <- function(x) {
  if (is.character(x) && length(x) > 0)
    FALSE
  else if (is.list(x) && length(x) > 0)
    all(vapply(x, eml_empty, logical(1)))
  else if (length(x) == 0 && isS4(x))
    all(vapply(names(getSlots(class(x))), function(s)
      eml_empty(methods::slot(x, s)), logical(1)))
  else if (identical(x, character()))
    TRUE
  else if (identical(x, list()))
    TRUE
  else
    FALSE
}

## Class-specific methods

#' @describeIn eml_get get method for attributeList
setMethod("eml_get", signature = "attributeList", get_attributes)

#' @describeIn eml_get get method for UnitList
setMethod("eml_get", signature = "unitList", get_unitList)
