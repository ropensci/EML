
# eml_creator <- template_constructor("creator")
template_constructor <- function(object) {
  args <- emld::template(object)
  f <- paste0(
    "function(",
    paste(names(args), "=", args, collapse = ", "),
    "){ list(",
    paste(names(args), "=", names(args), collapse = ","),
    ")}"
  )
  eval(parse(text = f))
}


# who <- readLines(system.file("extdata/complexTypes.txt", package="EML"))
# names(who) <- who
# construct <- lapply(who, template_constructor)

#' eml
#'
#' @docType data
#' @keywords datasets
#' @name eml
#' @format A list with constructor functions
NULL
