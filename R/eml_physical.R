####### Internal function to coerce data.frame to physical #######

## Custom generator. Consider making int an S4 method?  
## FIXME filename should follow https://github.com/ropensci/EML/issues/106
eml_physical <- function(dat, filename=character(0), ...){
  if(length(filename) == 0 | is.null(filename)){
    longID <- gsub('.*:(.*)', '\\1', eml_id()[["id"]])
    shortID <- gsub("(.{6}).+", "\\1", longID)
    filename <- paste("table_", shortID, ".csv", sep = "")
  }
  suppressWarnings(write.csv(dat, file = filename, row.names=FALSE, ...)) # don't care about warning in coercion of data.set to data.frame
  new("physical", 
      objectName = filename, 
      size = as(object.size(dat), "numeric"), 
      characterEncoding = guess_encoding(),
      dataFormat = new("dataFormat", 
                       textFormat = new("textFormat", 
                                 numHeaderLines = 1L,
                                 numFooterLines = 0L,
                                 recordDelimiter = "\\r\\n",
                                 attributeOrientation = "column",
                                 simpleDelimited = 
                                   new("simpleDelimited", fieldDelimiter = ",")))) 
}
# Attempt to determine encoding. Helper function
guess_encoding <- function(){
  encoding = getOption("encoding")
  if(encoding == "native.enc")
    encoding = tryCatch(Sys.getlocale("LC_CTYPE"), 
                        error = function(e) character(0))
  encoding
}



