


#' get_TextType
#'
#' Render a TextType node int HTML or some other format
#'
#' @param node any TextType node
#' @param to desired format, default is html, but can be any type supported by pandoc (docx, md, etc)
#' @param output name of the desired output file
#' @param view if HTML, do we want to open result in browser?
#' @importFrom utils browseURL
#' @importFrom xml2 xml_dtd xml_add_child xml_new_root write_xml xml_children
#' @return creates a file requested.
#' @export
#'
#' @examples
#' \donttest{
#'
#' ## Convert an EML abstract to markdown
#' f <- system.file("examples/hf205.xml", package = "EML")
#' eml <- read_eml(f)
#' abstract <- eml_get(eml, "abstract")
#' get_TextType(abstract[[1]], "markdown", "abstract.markdown")
#' readLines("abstract.markdown")
#' unlink("abstract.markdown") # tidy up
#'
#' ## Turn a docx file into EML abstract and preview at HTML
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

    ## eml_get returns a list of nodes always.
    if(!isS4(node) && length(node) == 1)
      node <- node[[1]]

    # serialize sections in ListOfsection or paras from ListOfpara into XML document, save, rmarkdown into desired format
    x <- xml2::xml_children(s4_to_xml(node, root = xml2::xml_new_root("root")))

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
    docbook_file <- tempfile(pattern = "docbook", tmpdir = ".", fileext = ".db")

    doctype <-
      xml2::xml_new_root(xml2::xml_dtd("section",
                       "-//OASIS//DTD DocBook XML V4.2//EN",
                       "http://oasis-open.org/docbook/xml/4.5/docbookx.dtd"))
    xml2::xml_add_child(doctype, "article")
    xml2::write_xml(doctype, docbook_file)
    pandoc_convert(
      basename(docbook_file),
      to = to,
      from = "docbook",
      output = normalizePath(output, winslash = "/", mustWork = FALSE),
      options = "-s"
    )

    file.copy(output, file.path(wd, basename(output)), overwrite = TRUE)


    setwd(wd)

    if (view && to == "html")
      utils::browseURL(basename(output))



  }
