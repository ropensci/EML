#' Upload EML to figshare
#' 
#' Modifies the EML file to reflect the figshare
#' @param file the filename of the EML file to upload
#' @param title of the figshare dataset, 
#' @param description of the dataset,
#' @param categories a category or list of categories, selected from the figshare list: 
#' @param tags at least one tag, any terms are permitted. Tags not required
#' @param links provided in the list on links of the figshare page. optional.
#' @param visibility one of "draft", "public", or "private".
#' @param figshare_id If the object already has a figshare id and we want to modify it. 
#' @param modified_eml_filename this function will update the EML file to reflect any
#' additional figshare tags or categories added, as well as the figshare DOI and remote path.
#' The new EML file is given this modified filename.  By default uses the original filename
#' and prepends figshare_
#' @return the figshare id
#' @details figshare requires authentication. See rfigshare 
#' [tutorial]() for help on configuring this.  
#' Arguments for figshare are optional, if not provided EML will attempt to
#' extract appropriate values from the EML.  If no values are found for 
#' essential metadata (title, description, category), then figshare object
#' will be still be created as a draft but cannot be published. 
#'
#' If publishing as a draft or private file, one can always make public later
#' through fs_make_public or the figshare online interface.  However, eml_figshare
#' can take the figshare_id to change any fields of an existing figshare object, 
#' and in doing so will also update the EML file.  
#' 
#' @import XML
#' @examples 
#' \dontrun{
#'    file <- system.file("doc", "my_eml_data.xml", package="EML")
#'    id <- eml_figshare(file, description="Example EML file from EML", categories = "Ecology", tags = "EML")
#' }
eml_figshare <- function(file, title = NULL, description = NULL, 
                         categories = NULL, tags = NULL, links = NULL, 
                         visibility = c("draft", "private", "public"), figshare_id = NULL, 
                         modified_eml_filename = paste("figshare", file, sep="_")){

  visibility = match.arg(visibility)

  success <- require(rfigshare)
  if(!success){
    message("rfigshare package not found. Attempting to install")
    install.packages("rfigshare")
    success <- require(rfigshare)
     if(!success)  
      stop("The rfigshare package must be installed to publish data to figshare")
  }

  ## FIXME this workflow is rather crude.  Should eml_read into S4, modify, and then eml_write XML
  ## as modified EML file, and upload that instead.  
  doc <- xmlParse(file) 
  root <- xmlRoot(doc)
  if(is.null(title))
    title <- xpathSApply(doc, "//dataset/title", xmlValue)
  if(is.null(description))
    description <- xpathSApply(doc, "//dataTable/entityDescription", xmlValue)
  if(is.null(categories))
    categories <-  xpathSApply(doc, "//dataset/additionalMetadata[@id = 'figshare']/metadata[keywordThesaurus = 'Figshare Categories']", xmlValue) 
  if(is.null(tags))
    tags <-  xpathSApply(doc, "//dataset/additionalMetadata[@id = 'figshare']/metadata[keywordThesaurus = 'Figshare Tags']", xmlValue) 
  if(is.null(links))
    links <-  xpathSApply(doc, "//dataset/additionalMetadata[@id = 'figshare']/metadata/additionalLinks/url", xmlValue) 
 csv <- xpathSApply(doc, "//dataTable/physical/objectName", xmlValue)

 if(isEmpty(description))
   description <- "EML metadata"

  ## Actual figshare part of code...
  ## Call fs_update if we have id, otherwise fs_create new fileset...
  if(!is.null(figshare_id)){
    id <- figshare_id
    fs_update(article_id = id, title = title, description = description, type = "fileset")
  } else {
    id <- fs_create(title = title, description = description, type = "fileset")
  }
  fs_add_tags(id, tags)
  fs_add_categories(id, categories)


  ## Upload data file
  fs_upload(id, csv)

  ## Extract URL for file (constructed from metadata since can't access download_url until public)
  ## Still, don't think this link will work until file is public.
  ## download_urls should be supported by figshare for private docs eventually... see [47](https://github.com/ropensci/rfigshare/issues/47)
  details <- fs_details(id, mine=TRUE)
  csv_id <- details$files[[1]]$id
  csv_name <- details$files[[1]]$name
  csv_url <- paste("http://files.figshare.com", csv_id, csv_name, sep="/")

  ## Add figshare download URL to EML
  newXMLNode("url", csv_url, attrs = list("function"="download"), parent = 
    newXMLNode("online", parent = 
      newXMLNode("distribution", parent = root[["dataset"]][["dataTable"]][["physical"]])))
  

  ## Add figshare metadata to EML
  metadata = newXMLNode("metadata", parent = 
    newXMLNode("additionalMetadata", attrs=list(id = 'figshare'), parent=
               root[["dataset"]]))

  ## Tags 
  figshare_tags = newXMLNode("keywordSet", parent = metadata)
  newXMLNode("keywordThesaurus", "figshare Tags", parent = figshare_tags)
  sapply(tags, function(tag) newXMLNode("keyword", tag, parent = figshare_tags))

  ## Categories
  figshare_categories = newXMLNode("keywordSet", parent = metadata)
  newXMLNode("keywordThesaurus", "figshare Categories", parent = figshare_categories)
  sapply(categories, function(categ) newXMLNode("keyword", categ, parent = figshare_categories))

  ## Does the thesuarus specified have to be from reserved keywords?

  ## Additional Links
  if(length(links) > 0){
    additionalLinks = newXMLNode("additionalLinks", parent = metadata)
    sapply(links, function(link) newXMLNode("url", link, parent = additionalLinks))
  }
  ## Write updated EML file (overwrites existing file unless flagged not to)
  saveXML(doc, file = modified_eml_filename)

  ## Upload updated EML file
  fs_upload(id, file = modified_eml_filename)


  details <- fs_details(id, mine=TRUE)
  eml_id <- details$files[[2]]$id

  if(visibility == "private")
    fs_make_private(id)

  else if(visibility == "public"){
    fs_make_public(id)
    ## If public, add the DOI and other citation information to the EML
  }
  id
}
