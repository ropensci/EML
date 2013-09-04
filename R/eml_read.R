
#' read eml files (.xml)
#'
#' @param file the name or path to the file (see ?xmlParse for details)
#' @param extract logical. default to FALSE.  extract the data table when reading the data?  
#' @param just_data logical. default FALSE. Set to true to reduce memory footprint by 
#' reading in data alone without additional metadata. Only works if extract = TRUE
#' @export
#' @aliases read.eml
eml_read <- function(file, extract = FALSE, just_data = FALSE ...){
  doc <- xmlParse(file=file, ...)
  root <- xmlRoot(doc)
  s4 <- as(root, "eml")

  if(extract_data)
    c(extract(s4), eml = if(!just_data) s4)
  else 
    s4 

                  
  
}

## FIXME should use accessor methods in place of @
## FIXME many of these can be lists, class definitions must be fixed
setMethod("extract", signature("eml"),
          function(from)
            list(dat = extract(from@dataset@dataTable@physical),
                metadata = extract(from@dataset@dataTable@attributeList),
                title = from@dataset@title,
                description = from@dataset@description,
                creator = from@dataset@creator)
          )
