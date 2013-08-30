setAs("data.frame", "physical", function(from)
      eml_physical(dat)) 


#' generator for eml
#' @export
eml <- function(dat, metadata, title, description = character(0), 
                creator = new("ListOf_creator", 
                              list(as(default_person(), "creator"))), 
                contact = as(default_person(), "contact"),
                methods = new("methods"), 
                additionalMetadata = new("additionalMetadata")){
  new("eml", 
      dataset = new("dataset", 
                    title = title,
                    creator = creator,
                    contact = contact,
                    dataTable = eml_dataTable(dat, metadata, title, description),
                    methods = methods))
}

## generator for data table
eml_dataTable <- function(dat, metadata, 
                          title = character(0), 
                          description = character(0), 
                          filename = character(0), ...){
  if(length(title) > 0 & length(filename) == 0)
    filename <- paste0(title, ".csv")
  metadata <- detect_class(dat, metadata)
  dataTable = new("dataTable", 
                  entityName = title,
                  entityDescription = description,
                  attributeList = as(metadata, "attributeList"),
                  physical = eml_physical(dat, filename=filename),
                  caseSensitive = TRUE,
                  numberOfRecords = dim(dat)[1])
}


## Custom generator. How would I rewrite this as a S4 generator?  As an S4 method?  
eml_physical <- function(dat, filename=character(0), ...){
  if(length(filename) == 0) 
    filename = paste(uuid::UUIDgenerate(), ".csv", sep="")
  write.csv(dat, file = filename, ...)
  new("physical", 
      objectName = filename, 
      size = as(object.size(dat), "numeric"), 
      characterEncoding = guess_encoding(),
      dataFormat = new("csv")) 
}


## FIXME Should check that 'from' is a internet protocol (e.g http)
setAs("character", "distribution", function(from)
  new("distribution", online = new("online", url = from)))



# Attempt to determine encoding. Helper function
guess_encoding <- function(){
  encoding = getOption("encoding")
  if(encoding == "native.enc")
    encoding = tryCatch(Sys.getlocale("LC_CTYPE"), 
                        error = function(e) character(0))
  encoding
}


# Generate a dataFormat object for standard csv.  Use as prototype?  
setClass("csv",
         contains = "dataFormat",
         prototype = prototype( 
           new("textFormat", 
             numHeaderLines = 1L,
             numFooterLines = 0L,
             recordDelimiter = "\\r\\n",
             attributeOrientation = "column",
             simpleDelimited = 
               new("simpleDelimited", fieldDelimiter = ","))))

