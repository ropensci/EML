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
                    id = permid(),
                    public = TRUE){
  success <- require(rfigshare)
  if(!success)
    stop("The dataone package must be installed to publish data to the KNB")

  csvdata <- attachments(file, "csv")

  ## Build a D1Object for the table, and upload it to the MN
  d1Object <- new(Class="D1Object", id, csvdata, format, mn_nodeid)

  # Query the object to show its identifier
  pidValue <- getIdentifier(d1Object)
  message(paste("ID of d1Object:",pidValue))

  if(public){
  # Set access control on the data object to be public
    setPublicAccess(d1Object)
    if (canRead(d1Object,"public")) {
      message("successfully set public access");
    } else {
      message("FAIL: did not set public access");
    }
  }

  # Now actually load the object into the KNB repository
  createD1Object(cli, d1Object)

  pidValue
}



permid <- function() paste("r_test1", format(Sys.time(), "%Y%m%d%H%M%s"), "1", sep=".")
attachments <- function(doc, type="csv"){
  type <- match.arg(type)
  switch(type, 
    csv = xpathSApply(doc, "//dataTable/physical/objectName", xmlValue)
  )
}

