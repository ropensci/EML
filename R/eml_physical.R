####### Internal function to coerce data.frame to physical #######

## Custom generator. 

#' eml_physical constructor
#' 
#' eml_physical constructor
#' @param dat a data.frame or path to existing csv file
#' @param filename the filename to be used. Ignored if `dat` 
#' is a path to a file.  Can include the full path (e.g. if
#' file is to be written to a different directory).
#' @param characterEncoding string defining the encoding used. will guess based on R's configuration (sensible for data.frames or csv files produced by R, but not otherwise).
#' @param ... additional arguments passed to eml_dataFormat, eml_distribution or write.csv. 
eml_physical <- 
function(dat,
         filename = character(), # Full path, file extension
         characterEncoding = guess_encoding(),
         ...){

  # FIXME base this on entityName?  
  if(length(filename) == 0 || is.null(filename)){

    generate_filename("table")
  }


  if(gsub(".*(\\.csv)", "\\1", filename) != ".csv")
    filename <- paste(filename, "csv", sep=".")

  ## handle existing csv path
  if(is.character(dat)){
    if(file.exists(dat)){
      filename <- dat
      size <- file.info(dat)$size # in bytes
    }
  } else if(is(dat, "data.frame")){ 
    suppressWarnings(# don't warn in coerce of data.set 
      write.csv(dat, 
                file = filename, 
                row.names=FALSE)) 
  }


  dirname <- dirname(filename)
  objectName <- basename(filename)


  new("physical", 
      objectName = objectName, 
      size = as(object.size(dat), "numeric"), 
      characterEncoding = characterEncoding,
      dataFormat = eml_dataFormat(...),
      distribution = eml_distribution(...),
      dirname = dirname
      ) 
}


# Attempt to determine encoding. Helper function
guess_encoding <- function(){
  encoding = getOption("encoding")
  if(encoding == "native.enc")
    encoding = tryCatch(Sys.getlocale("LC_CTYPE"), 
                        error = function(e) character(0))
  encoding
}


eml_distribution <- function(){
  new("distribution")
}

eml_dataFormat <- function(numHeaderLines = 1L, 
                           numFooterLines = 0L, 
                           recordDelimiter = "\\r\\n", 
                           attributeOrientation = "column", 
                           sep = ","){ # so named to match write.csv
  new("dataFormat", 
     textFormat = new("textFormat", 
               numHeaderLines = numHeaderLines,
               numFooterLines = numFooterLines,
               recordDelimiter = recordDelimiter,
               attributeOrientation = attributeOrientation,
               simpleDelimited = 
                 new("simpleDelimited", 
                     fieldDelimiter = sep)))

}

generate_filename <- function(template = "table"){
    longID <- gsub('.*:(.*)', '\\1', eml_id()[["id"]])
    shortID <- gsub("(.{6}).+", "\\1", longID)
    template <- gsub(" ", "_", template) # no spaces 
    filename <- paste(template, "_", shortID, sep = "")
}

