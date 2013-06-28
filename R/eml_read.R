#' Read EML files
#'
#' Attempts to parse, validate and import EML data into R data objects.  
#' TODO: Handle multiple files
#' @aliases read.eml
#' @import XML
eml_read <- function(file){
  doc <- xmlParse(file)
 

  # XPath to all dataTables containing CSV files 
  # We can assume that such dataTable nodes contain exactly one CSV file
  # FIXME: In general both R and EML can be more flexible than comma-delimited only
  # We would want to support arbitrary delimiters, etc.  
  csv_xpath <- "//physical[.//simpleDelimited[fieldDelimiter = ',']]/parent::dataTable"

  ##### Column Metadata  ################
  # We can assume that the csv dataTable object also has one attributeList,  
  colNames <- xpathSApply(doc, 
                          paste0(csv_xpath, "/attributeList/attribute/attributeName"),
                          xmlValue)
  colDefinitions <- xpathSApply(doc, 
                                paste0(csv_xpath, "//attribute/attributeDefinition"),
                                xmlValue)
  names(colDefinitions) <- colNames
  col_metadata <- colDefinitions



  ########## Unit metadata ######
  n_cols <- length(col_metadata)
  unit_metadata <- lapply(1:n_cols, function(i){
    measure_xpath <- paste0(csv_xpath, "//attribute[position()=", i, "]/measurementScale")

    ## Factors 
    if(!is.empty(xpathSApply(doc, paste0(measure_xpath, "//enumeratedDomain")))){
      code <- xpathSApply(doc, 
                          paste0(measure_xpath, 
                                 "//enumeratedDomain/codeDefinition/code"), 
                          xmlValue) 
      definitions <- xpathSApply(doc, 
                                 paste0(measure_xpath, 
                                        "//enumeratedDomain/codeDefinition/code"), 
                                 xmlValue)

    ## Numerics 
    } else if(!is.empty(xpathSApply(doc, paste0(measure_xpath, "//numberType")))){
      code <- xpathSApply(doc, paste0(measure_xpath, "//numberType"), xmlValue)
      definitions <- xpathSApply(doc, paste0(measure_xpath, "//standardUnit"), xmlValue)
    
    ## Text 
    } else if(!is.empty(xpathSApply(doc, paste0(measure_xpath, "/nominal//textDomain/definition")))){
      definitions <- xpathSApply(doc, paste0(measure_xpath, 
                                           "/nominal//textDomain/definition"), 
                               xmlValue)
      code <- NULL
    }
    names(definitions) = code
    definitions
  })          

# Set csv column classes  
  colClasses <- sapply(1:n_cols, function(i){
    measure_xpath <- paste0(csv_xpath, "//attribute[position()=", i, "]/measurementScale")
    if(!is.empty(xpathSApply(doc, paste0(measure_xpath, "/nominal//enumeratedDomain"))))
      "factor"
    else if(!is.empty(xpathSApply(doc, paste0(measure_xpath, "/ordinal//enumeratedDomain"))))
      "ordered"
    else if(!is.empty(xpathSApply(doc, paste0(measure_xpath, "/nominal//textDomain"))))
      "character"
    else if(!is.empty(xpathSApply(doc, paste0(measure_xpath, 
            "//numericDomain[numberType = 'real']"))))
      "numeric"
    else if(!is.empty(xpathSApply(doc, paste0(measure_xpath, 
            "//numericDomain[numberType = 'natural' or numberType = 'whole' or numberType = 'integer']"))))
      "integer"
    })

## FIXME
# Optionally, atomatically scale measurements to preferred units through unit conversions.  

  ## Read any CSV files ##
  # We can assume that if the data is online, the download URL is:
  download_url <- xpathSApply(doc, paste0(csv_xpath,  
                 "//physical/distribution/online/url"),
                 xmlValue)
  # NOTE: EML schema does not guarentee we have online data URL!

  ## Specify column types as determined from metadata.  
  csv <- read.csv(download_url, colClasses=colClasses)

  ## If available, check number of records. Warn but don't error if not correct.  
  ## (e.g. Harvard Forest is in the habit of writing 9999 instead of just omitting
  ##  this optional metadata...)

}

## Helper function
is.empty <- function(x) is.null(x) | length(x) == 0 

