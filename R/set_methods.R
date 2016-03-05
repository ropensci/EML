set_methods <- function(methods_file, 
                        instrumentation = character(), 
                        software = new("software"),
                        sampling_file = NULL, 
                        sampling_coverage = new("coverage"), 
                        sampling_citation = new("citation"),
                        qualityControl_file = NULL){
  
  if(!is.null(sampling_file) && !isEmpty(sampling_coverage))
    sampling <- new("sampling", 
                    samplingDescription = new("samplingDescription", section = set_section(sampling_file)),
                    studyExtent = new("studyExtent", coverage = sampling_coverage),
                    citation = sampling_citation)
  else
    sampling <- new("sampling")
  
  if(!is.null(qualityControl_file))
    qualityControl <- new("qualityControl",
                          ProcedureStepType = new("ProcedureStepType",
                                                  description = new("description",
                                                                    section = set_section(qualityControl_file))))
  else 
    qualityControl <- new("qualityControl")
  
  
  methods <- new("methods",
      methodStep = new(
        "methodStep",
        sampling = sampling,
        ProcedureStepType = new("ProcedureStepType",
                                instrumentation = instrumentation,
                                software = software,
                                description = new("description",
                                                  section = set_section(methods_file)))
      ))
  methods
}

#' set_section
#' 
#' For any EML element that takes a "section" argument, this function can be used to generate the appropriate EML from a markdown-formatted file.
#' @param file path to a markdown-formatted file. (Any Pandoc-flavored markdown permitted)
#' @import rmarkdown
#' @import XML
#' @return a ListOfsection object that can be used in constructing any element with section slots, see examples
#' @examples 
#' f <- system.file("examples/hf205-methods.md", package = "EML")
#' set_section(f)
#' new("description", section = set_section(f))
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