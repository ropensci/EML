

#' get_TextType
#' 
#' Render a TextType node int HTML or some other format
#'
#' @param node any TextType node
#' @param to desired format, default is html, but can be any type supported by pandoc (Word, markdown, etc)
#' @param view if HTML, do we want to open result in browser?
#'
#' @export
#'
#' @examples
#' f <- system.file("examples/hf205-abstract.docx", package = "EML")
#' a <- as(set_TextType(f), "abstract")
#' get_TextType(a)
#' 
#' 
get_TextType <- function(node, to = "html", view = TRUE){
  
    # serialize sections in ListOfsection or paras from ListOfpara into XML document, save, rmarkdown into desired format
    x <- S4Toeml(node)
  
    if (!requireNamespace("rmarkdown", quietly = TRUE)){
      stop("rmarkdown package required to convert to Docbook format", call. = FALSE)
    }
    pandoc_convert <- getExportedValue("rmarkdown", "pandoc_convert")
    
    wd <- getwd()
    dir <- tempdir()
    setwd(dir)
    docbook_file <- tempfile(tmpdir = ".", fileext = ".xml")
    
    XML::saveXML(x, docbook_file)
    
    
    output_file <- tempfile(class(node), tmpdir = ".", fileext = paste0(".", to))
    
    pandoc_convert(basename(docbook_file), to = to, output = output_file, options = "-s")
 
    file.copy(output_file, paste(wd, basename(output_file), sep="/"), overwrite = TRUE)
    
    
    setwd(wd)
    
    if(view && to == "html")
      utils::browseURL(basename(output_file))

    
    
    }