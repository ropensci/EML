
#' set_section
#' 
#' For any EML element that takes a "section" argument, this function can be used to generate the appropriate EML from a markdown-formatted file.
#' @param file path to any document recognized by pandoc, such as Word .docx file or markdown file.
#' @import rmarkdown
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
#' @details See http://rmarkdown.rstudio.com and http://pandoc.org for more details about coversions with pandoc & rmarkdown.  
#' Pandoc comes pre-installed in RStudio
#' @export
set_section <- function(file = NULL){
  
  wd <- getwd()
  dir <- tempdir()
  file.copy(file, paste(dir, basename(file), sep="/"))
  setwd(dir)
  docbook_file = tempfile(tmpdir = ".", fileext = ".xml")
  rmarkdown::pandoc_convert(basename(file), to = "docbook", output = docbook_file, options = "-s")
  #rmarkdown::pandoc_convert(basename(file), to = "docbook", output = docbook_file, wd = dirname(file)) 
  docbook <- XML::xmlParse(docbook_file)
  setwd(wd)
  
  sections <- XML::xpathApply(docbook, "/article/sect1", XML::xmlChildren)
  s <- lapply(sections, function(x) new("section", as(x, "list")))
  as(s, "ListOfsection")
  
}