#' Publish EML
#' 
#' Push EML and data files to an online server and update EML Metadata accordingly
#' @param file The local path of an EML file
#' @param ... Additional metadata options.  If publishing to Figshare, 
#' these correspond to the options in \code{fs_new_article}. See .
#' @param destination the publishing destination, e.g. "figshare"
#' @return Uploads the dataset and file to destination specified returns an id
#'  
#' @import xml
#' @export
eml_publish <- function(file, ...,  
                        destination = c("figshare", "github")){
  available <- require(rfigshare)
  if(!available)
    stop("Publishing to figshare requires the rfigshare package")
  else
    do.call(eml_figshare, list(file, ...))
}


