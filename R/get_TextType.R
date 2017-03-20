


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

    node_to_file(node, to, output)

    if (view && to == "html")
      utils::browseURL(basename(output))
  }

#' Converts a node into a file by running it through Pandoc
#'
#' @param node any node that supports a docbook-like structure (abstract, methods, etc)
#' @param to desired format, default is html, but can be any type supported by pandoc (docx, md, etc)
#' @param output name of the desired output file
#'
#' @return creates a file requested.
node_to_file <-
  function(node, to = "html", output = tempfile(class(node), fileext = paste0(".", to))) {
    ## eml_get returns a list of nodes always.
    if(!isS4(node) && length(node) == 1)
      node <- node[[1]]

    # serialize sections in ListOfsection or paras from ListOfpara into XML document, save, rmarkdown into desired format
    x <- XML::xmlChildren(EML:::S4Toeml(node))

    if (!requireNamespace("rmarkdown", quietly = TRUE)) {
      stop("rmarkdown package required to convert to Docbook format",
           call. = FALSE)
    }
    pandoc_convert <-
      getExportedValue("rmarkdown", "pandoc_convert")

    docbook_path <- tempfile(pattern = "docbook", fileext = ".db")
    doctype <- XML::Doctype(name = "section",
                            public = c("-//OASIS//DTD DocBook XML V4.2//EN"),
                            system = "http://oasis-open.org/docbook/xml/4.5/docbookx.dtd")
    y <- XML::newXMLNode("article", x)
    XML::saveXML(XML::xmlDoc(y),
                 docbook_path,
                 doctype = doctype)

    pandoc_convert(
      docbook_path,
      from = "docbook",
      to = to,
      output = normalizePath(output, winslash = "/", mustWork = FALSE),
      options = "-s"
    )

    output
  }

#' Get the text content of the abstract
#'
#' Gets a base R representation of the abstract in the given document, such as a
#' character vector.
#'
#' This function uses Pandoc to convert the XML content contained in the
#' abstract into Markdown and then into a base R type such a character vector or
#' list. This is a particularly useful function to use if you want to work with
#' the text content of your abstract to perform downstream processing. A special
#' function like this one is required because the abstract element in EML is a
#' TexType which supports a docbook-like structure including paragraphs,
#' sections, titles, and much more. To work around this, the abstract XML is
#' converted into Markdown and then read back in as a character vector and,
#' optionally, converted to your desired type.
#'
#' A special case is impelemented for character vectors in that a character
#' vector of length one is always returned.
#'
#' @param node An EML object or child/descendant object
#' @param as The desired return type, see details (optional)
#'
#' @return A text represenation of the abstract
#' @export
#'
#' @examples
#' f <- system.file("examples/hf205.xml", package = "EML")
#' eml <- read_eml(f)
#' # As a single character vector
#' get_abstract(eml, as = "character")
#' # As a list of lines
#' get_abstract(eml, as = "list")
get_abstract <-
  function(node, as = "character") {
    # Get the abstract if an abstract wasn't passed in directly
    if (is(node, "eml")) {
      node <- eml_get(node, "abstract")
    }

    # Stop if the rest of the code isn't going to work. We either need an
    # abstract instance or a list containing one
    if (!(is(node, "abstract") ||
        (is.list(node) && length(node) > 0 && is(node[[1]], "abstract")))) {
      stop("node is not an abstract or does not contain one.", call. = FALSE)
    }

    # Run the node through Pandoc into Markdown and read it in
    path <- node_to_file(node, "markdown")
    abs_text <- readLines(path)
    unlink(path)

    # Tidy it up before returning it back to the user
    if (as == "character") {
      output <- paste(abs_text, collapse = "\n")
    } else {
      output <- methods::as(abs_text, as)
    }

    output
  }
