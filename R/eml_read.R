#' @export
#' @aliases read.eml

eml_read <- function(file, extract_data=FALSE, ...){
  doc <- xmlParse(file=file, ...)
  root <- xmlRoot(doc)
  s4 <- as(root, "eml")

  if(extract_data)
    ## FIXME should use accessor methods in place of @
    ## FIXME many of these can be lists, class definitions must be fixed
    out <- list(dat = extract(s4@dataset@dataTable@physical),
                metadata = metadata(s4@dataset@dataTable@attributeList),
                title = s4@dataset@title,
                description = s4@dataset@description,
                creator = s4@dataset@creator,
                methods = s4@dataset@methods,
                additionalMetadata = s4@additionalMetadata,
                eml = s4)
  
}


setMethod("extract", signature("eml"),
          function(from){
            dat <- extract(from)
            metadata
          })
