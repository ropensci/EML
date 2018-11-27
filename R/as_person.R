
#' @importFrom emld as_emld
#' @export
emld::as_emld

#' @importFrom emld as_emld
#' @method as_emld person
#' @export
as_emld.person <- function(x, from = "list") {
  tmp <- function(x) {
    orcid <- x$comment[["ORCID"]]
    out <-
      list(
        individualName = list(
          givenName = x$given,
          surName = x$family
        ),
        electronicMailAddress = x$email
      )
    if (!is.null(orcid)) {
      out$`@id` <- paste0("https://orcid.org/", orcid)
    }

    class(out) <- c("emld", "list")
    out
  }

  if (length(x) > 1) {
    lapply(x, tmp)
  } else {
    tmp(x)
  }
}
