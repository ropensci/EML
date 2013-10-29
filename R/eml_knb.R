#' Upload EML to knb
#' 
#' @details knb requires authentication. 
#' @import XML
#' @export
#' @examples 
#' \dontrun{
#' }
eml_knb <- function(file, 
                    mn_nodeid = "urn:node:KNB",
                    cli = D1Client("PROD", mn_nodeid),
                    public = TRUE){
  success <- require(dataone)
  if(!success)
    stop("The dataone package must be installed to publish data to the KNB")

  # Declare the metadata format ## FIXME get namespace from the file 

  x <- eml_read(file)
  eml_format <- version(x)  # method works on `file` too
  eml_id <- id(x)           # method works on `file` too

  # Get the path and identifier of the csv file from the EML 
  csv <- c(path = unname(x@dataset@dataTable@physical@objectName),
           id = unname(x@dataset@dataTable@id)) # Define more elegant method..
  
  ## Build a D1Object for the table, and upload it to the MN
  csv_object <- new(Class="D1Object", csv[["id"]], csv[["path"]], "text/csv", mn_nodeid)
  ## Make the object public

#  eml_object <- new(Class="D1Object", id2, file, "eml://ecoinformatics.org/eml-2.1.1", mn_nodeid)
  meta <- paste(readLines(file), collapse = '')     # Do we need to parse the object first? 
  eml_object <- new("D1Object", eml_id, meta, eml_format, mn_nodeid)  



  # Query the object to show its identifier
  csv_pid <- getIdentifier(csv_object)
  eml_pid <- getIdentifier(eml_object)

  if(public){
  # Set access control on the data object to be public
    setPublicAccess(csv_object)
    setPublicAccess(eml_object)
    if (canRead(d1Object,"public")) {
      message("successfully set public access");
    } else {
      message("FAIL: did not set public access");
    }
  }

  # Assemble our data package containing both metadata and data
  data.package <- new("DataPackage", packageId=eml_id)
  addData(data.package,csv_object)
  addData(data.package,eml_object)
  insertRelationship(data.package, eml_id, csv["id"])

  # Now upload the whole package to the member node
  create(d1.client, data.package)

  #  test <- getD1Object(cli, eml_pid)
  eml_pid
}



setGeneric("id", function(x) standardGeneric("id"))
setMethod("id", signature("eml"), 
          function(x) unname(x@packageId))
          

setGeneric("version", function(x) standardGeneric("version"))
setMethod("version", signature("eml"), 
          function(x) x@namespaces[["eml"]])
setMethod("version", signature("character"), 
          function(x) { 
            x <- eml_read(x) 
            version(x) 
          })



