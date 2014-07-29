#' @include physical_classes.R
#' 
NULL


## FIXME use the EML to determine read.csv options
extract <- 
function(from, using=NA){
  dat <- read.csv(filepath(from)) 
}


filepath <-
function(from){
  path <- catpaths(from@dirname, from@objectName)
  if(file.exists(path))
    path
  else { ## For some reason, eml_figshare is using http://files.figshare.com/<EMLID> as dirname...
    fail <- download.file(from@distribution@online@url, 
                         destfile = from@objectName)
    if(!fail)
      from@objectName
    else
      stop(paste("could not find file", 
                 from@objectName, 
                 "in", 
                 from@dirname, 
                 "or at", 
                 from@distribution@online@url))
  }
}


### Coerce data.frame to physical (csv) using constructor function:

setAs("data.frame", "physical", function(from) eml_physical(from)) 



