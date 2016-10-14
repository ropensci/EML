


#' get_TextType
#'
#' Render a TextType node int HTML or some other format
#'
#' @param node any TextType node
#' @param to desired format, default is html, but can be any type supported by pandoc (docx, md, etc)
#' @param output name of the desired output file
#' @param view if HTML, do we want to open result in browser?
#' @importFrom utils browseURL
#' @return creates a file requested.
#' @export
#'
#' @examples
#' \donttest{
#' f <- system.file("examples/hf205-abstract.docx", package = "EML")
#' a <- as(set_TextType(f), "abstract")
#' get_TextType(a)
#' }
#'
get_TextType <-
  function(node,
           to = "html",
           output = tempfile(class(node), fileext = paste0(".", to)),
           view = TRUE) {
    # serialize sections in ListOfsection or paras from ListOfpara into XML document, save, rmarkdown into desired format
    x <- S4Toeml(node)

    if (!requireNamespace("rmarkdown", quietly = TRUE)) {
      stop("rmarkdown package required to convert to Docbook format",
           call. = FALSE)
    }
    pandoc_convert <-
      getExportedValue("rmarkdown", "pandoc_convert")

    wd <- getwd()
    dir <- tempdir()
    file.copy(output, file.path(dir, basename(output)), overwrite = TRUE)
    setwd(dir)
    docbook_file <- tempfile(tmpdir = ".", fileext = ".xml")
    XML::saveXML(x, docbook_file)
    pandoc_convert(
      basename(docbook_file),
      to = to,
      output = normalizePath(output, winslash = "/", mustWork = FALSE),
      options = "-s"
    )

    file.copy(output, file.path(wd, basename(output)), overwrite = TRUE)


    setwd(wd)

    if (view && to == "html")
      utils::browseURL(basename(output))



  }
