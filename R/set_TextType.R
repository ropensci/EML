## Developer note: Some functions not fully compatible with pandoc < 2.0

#' set_TextType
#'
#' For any EML element of class TextType, this function can be used to generate
#'  the appropriate EML from a markdown-formatted file.
#' @param text a plain text character string which will be used directly as the content
#'  of the node if no file is given
#' @param file path to a file providing formatted input text, see details.
#' @return a TextType object that can be coerced into any element inheriting from TextType, see examples
#' @importFrom tools file_ext
#' @importFrom methods as
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
#' }
#'
set_TextType <- function(file = NULL, text = NULL) {
  if (!is.null(text)) {
    TextType <- text
  } else if (!is.null(file)) {
    docbook <- to_docbook(file)
    TextType <-
      list(
        section = set_section(docbook),
        para = set_para(docbook)
      )
  }
  TextType
}

#' @importFrom xml2 xml_find_all xml_children xml_contents read_xml
#' @importFrom utils compareVersion
#' @importFrom rmarkdown pandoc_version
set_section <- function(docbook) {
  ## Argh, section tag name changes in different versions of pandoc!!
  if (utils::compareVersion(
    as.character(rmarkdown::pandoc_version()),
    "2.0"
  ) == 1) {
    xpath <- "/article/section"
  } else {
    xpath <- "/article/sect1"
  }
  lapply(
    xml2::xml_find_all(docbook, xpath),
    function(x)
      paste(lapply(xml2::xml_children(x), as.character),
        collapse = "\n"
      )
  )
}



set_para <- function(docbook) {
  lapply(
    xml2::xml_find_all(docbook, "/article/para"),
    function(x) as.character(xml2::xml_contents(x))
  )
}

#' @importFrom xml2 xml_ns_strip
to_docbook <- function(file = NULL) {
  if (!tools::file_ext(file) %in% c("xml", "dbk", "db")) {
    ## Not xml yet, so use pandoc to generate docbook

    if (!requireNamespace("rmarkdown", quietly = TRUE)) {
      stop("rmarkdown package required to convert to Docbook format",
        call. = FALSE
      )
    }
    if (!rmarkdown::pandoc_available()) {
      stop(paste("Pandoc is required to convert to Docbook format.",
              "Please supply input text directly"),
              call. = FALSE
             )
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
    docbook <- xml2::read_xml(docbook_file)
    on.exit(setwd(wd))
  } else {
    ## File is already xml/docbook, so no need for pandoc
    docbook <- xml2::read_xml(file)
  }

  ## Unlike EML, treat this as literal!
  xml2::xml_ns_strip(docbook)
  docbook
}
