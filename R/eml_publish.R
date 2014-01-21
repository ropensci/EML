#' Publish EML
#' 
#' Push EML and data files to an online server and update EML Metadata accordingly
#' @param file The local path of an EML file
#' @param ... Additional metadata options.  If publishing to Figshare, 
#' these correspond to the options in \code{fs_new_article}. See .
#' @param destination the publishing destination, e.g. "figshare"
#' @return Uploads the dataset and file to destination specified returns an id
#'  
#' @import XML
#' @export
#' @examples 
#' \dontrun{
#'    file <- system.file("doc", "my_eml_data.xml", package="EML")
#'    id <- eml_publish(file, description="Example EML file from EML", categories = "Ecology", tags = "EML")
#' }
eml_publish <- function(file, 
                        ...,  
                        destination = c("figshare", "knb")){

  txt <- "continue"
  if(!all(eml_validate(file))){
    txt <- readline("File validation check failed. Type 'continue' 
            to continue anyway, otherwise, Type 'exit'
            or press Ctrl+C")
  } 
  if(txt == "continue") {
    destination <- tolower(destination)
    destination <- match.arg(destination)
    out <- switch(destination, 
           figshare = eml_figshare(file, ...),
           knb = eml_knb(file, ...))
  } else {
    out <- NULL
  }
  out 
}


