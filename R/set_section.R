
#' set_section
#' 
#' For any EML element that takes a "section" argument, this function can be used to generate the appropriate EML from a markdown-formatted file.
#' @param file path to a file providing formatted input text, see details.
#' @import XML
#' @return a ListOfsection object that can be used in constructing any element with section slots, see examples
#' @examples 
#' f <- system.file("examples/hf205-methods.md", package = "EML")
#' set_section(f)
#' new("description", section = set_section(f))
#' 
#' ## Can also import from methods written in a .docx MS Word file. 
#' f <- system.file("examples/hf205-methods.docx", package = "EML")
#' set_section(f)
#' new("description", section = set_section(f))
#' 
#' @importFrom tools file_ext
#' @details If the `rmarkdown` package is installed, then the input file can 
#' be a Microsoft Word (.docx) file, a markdown file, or other file
#' recognized by Pandoc (see http://pandoc.org), which will automate the conversion
#' to a docbook. Otherwise, the input file should already be in docbook format (with 
#' .xml or .dbk extension).  Note that pandoc comes pre-installed in RStudio and is 
#' required for the rmarkdown package.  
#' @export
set_section <- function(file = NULL){
  
  if(!tools::file_ext(file) %in% c("xml", "dbk")){
    
    if (!requireNamespace("rmarkdown", quietly = TRUE)){
      stop("rmarkdown package required to convert to Docbook format", call. = FALSE)
    }
    pandoc_convert <- getExportedValue("rmarkdown", "pandoc_convert")

    wd <- getwd()
    dir <- tempdir()
    file.copy(file, paste(dir, basename(file), sep="/"))
    setwd(dir)
    docbook_file = tempfile(tmpdir = ".", fileext = ".xml")
    pandoc_convert(basename(file), to = "docbook", output = docbook_file, options = "-s")
    docbook <- XML::xmlParse(docbook_file)
    setwd(wd)
  
  } else { 
    docbook  <- XML::xmlParse(file)
  }
  ##
  
  sections <- XML::xpathApply(docbook, "/article/sect1", XML::xmlChildren)
  s <- lapply(sections, function(x) new("section", as(x, "list")))
  as(s, "ListOfsection")
  
}