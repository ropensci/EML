#' set_TextType
#'
#' For any EML element of class TextType, this function can be used to generate the appropriate EML from a markdown-formatted file.
#' @param text a plain text character string which will be used directly as the content of the node if no file is given
#' @param file path to a file providing formatted input text, see details.
#' @import XML
#' @return a TextType object that can be coerced into any element inheriting from TextType, see examples
#' @importFrom tools file_ext
#' @details If the `rmarkdown` package is installed, then the input file can
#' be a Microsoft Word (.docx) file, a markdown file, or other file
#' recognized by Pandoc (see http://pandoc.org), which will automate the conversion
#' to a docbook. Otherwise, the input file should already be in docbook format (with
#' .xml or .dbk extension).  Note that pandoc comes pre-installed in RStudio and is
#' required for the rmarkdown package.
#' @export
#' @examples
#' \donttest{
#' ## using a simple character string
#' a <- set_TextType(text = "This is the abstract")
#' as(a, "abstract")
#'
#' ## Using an external markdown file
#' f <- system.file("examples/hf205-abstract.md", package = "EML")
#' a <- set_TextType(f)
#' as(a, "abstract")
#'
#' ## Can also import from methods written in a .docx MS Word file.
#' f <- system.file("examples/hf205-abstract.docx", package = "EML")
#' a <- set_TextType(f)
#' as(a, "abstract")
#'
#' ## Documents with title headings use `section` instead of `para` notation
#' f <- system.file("examples/hf205-methods.docx", package = "EML")
#' d <- set_TextType(f)
#' as(d, "description")
#'
#' }
#'
#'
set_TextType <- function(file = NULL, text = NULL) {
  if (!is.null(text)) {
    TextType <- new("TextType", .Data = text)
  } else if (!is.null(file)) {
    docbook <- to_docbook(file)
    TextType <-
      new("TextType",
          section = set_section(docbook),
          para = set_para(docbook))
  }
  TextType
}



set_section <- function(docbook) {
  sections <-
    XML::xpathApply(docbook, "/article/sect1", XML::xmlChildren)
  s <- lapply(sections, function(x)
    new("section", as(x, "list")))
  as(s, "ListOfsection")
}



set_para <-  function(docbook) {
  para <- XML::xpathApply(docbook, "/article/para", XML::xmlChildren)
  s <- lapply(para, function(x)
    new("para", as(x, "list")))
  as(s, "ListOfpara")
}


to_docbook <- function(file = NULL) {
  if (!tools::file_ext(file) %in% c("xml", "dbk")) {
    ## Not xml yet, so use pandoc to generate docbook

    if (!requireNamespace("rmarkdown", quietly = TRUE)) {
      stop("rmarkdown package required to convert to Docbook format",
           call. = FALSE)
    }
    pandoc_convert <-
      getExportedValue("rmarkdown", "pandoc_convert")

    wd <- getwd()
    dir <- tempdir()
    file.copy(file, file.path(dir, basename(file)), overwrite = TRUE)
    setwd(dir)
    docbook_file <- tempfile(tmpdir = ".", fileext = ".xml")
    pandoc_convert(
      basename(file),
      to = "docbook",
      output = normalizePath(docbook_file, winslash = "/", mustWork = FALSE),
      options = "-s"
    )
    docbook <- XML::xmlParse(docbook_file)
    setwd(wd)

  } else {
    ## File is already xml/docbook, so no need for pandoc
    docbook  <- XML::xmlParse(file)
  }
  docbook

}
