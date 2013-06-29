#' Function to create an EML DataTable

# @param data an R dataframe
#' @param col_metadata a named character vector of definitions, e.g. c("X1" = "species name", "X2" = "species density", ...)
#' @param unit_metadata a named list of length ncol.  For each column, 
#' factor: a named character vector of definitions of each factor
#' numeric: unit used, from EML list
#' dateTime: For an R time object (POSIXt class), give the format
#' character: definition (same as col def?)
#' definitions of all factors, a named character vector of definitions, e.g.  c("X1" = "species name", "X2" = "species density", ...)
#' 
#' The primary role of an EML Datatable is to define the data
#' specified by the column headings; facilitating data synthesis.
#' 
#' @references Normative technical specification given at

#' @import XML
#' @import XMLSchema 
#' @examples
#'  dat = data.frame(river=c("SAC", "SAC", "AM"), 
#'                    spp = c("king", "king", "ccho"), 
#'                    stg = c("smolt", "parr", "smolt"),
#'                    ct =  c(293L, 410L, 210L))
#'  col_metadata = c(river = "http://dbpedia.org/ontology/River",
#'                   spp = "http://dbpedia.org/ontology/Species", 
#'                   stg = "Life history stage",
#'                   ct = "count")
#'  unit_metadata = 
#'   list(river = c(SAC = "The Sacramento River", AM = "The American River"),
#'        spp = c(king = "King Salmon", ccho = "Coho Salmon"),
#'        stg = c(parr = "third life stage", smolt = "fourth life stage"),
#'        ct = "number")
#' 
#'  node = eml_dataTable(dat, col_metadata, unit_metadata) 
#' 
#' We have semantic meaning available in EML for many numeric units. Any unit not provided must still be defined semantically.  But we have much more obtuse support for providing semantic meaning to character strings.  

eml_dataTable = function(dataframe, col_metadata, unit_metadata,
                      # Optional dataTable metadata
                      accuracy = NULL, coverage = NULL, 
                      methods = NULL, missingValueCode = NA, 
                      # physical file metadata 
                      csvfile=NULL, file_description=NULL, csv_url="http://github.com"){

  # Write the data to a csv file
  if(is.null(csvfile))
    csvfile = paste(gsub("(.{16}).+", "\\1", paste(names(dataframe), collapse="_")), ".csv", sep = "")
  write.csv(dataframe, file=csvfile) 

  if(is.null(file_description))
    file_discription = paste("Description of the CSV file", csvfile)  

  # Write the dataTable header metadata
  dataTable = newXMLNode("dataTable")
  newXMLNode("entityName", csvfile, parent = dataTable)
  newXMLNode("entityDescription", file_description, parent = dataTable)


  # Physical node describes the CSV file.  
  physical = newXMLNode("physical", parent = dataTable)
  newXMLNode("objectName", csvfile, parent = physical)
  addChildren(physical, csv_format())
  newXMLNode("url", csv_url, attrs = list("function"="download"), parent = 
    newXMLNode("online", parent = 
      newXMLNode("distribution", parent = physical)))


  # attrlist describes the col_metadata and unit_metadata 
  attrlist = eml_attributeList(dataframe, col_metadata, unit_metadata, 
                      id = c(1:length(dataframe)),  
                      accuracy = accuracy, coverage = coverage, 
                      methods = methods, missingValueCode = missingValueCode)

  addChildren(dataTable, attrlist)

}



#' Use templating to cast some standard node structures

csv_format = function(){ 
newXMLNode("dataFormat", .children = 
  newXMLNode("textFormat", .children = list(
    newXMLNode("numHeaderLines", '1'),
    newXMLNode("recorDelimiter", "\\r\\n"),
    newXMLNode("attributeOrientation", "column"),
    newXMLNode("simpleDelimited", .children =
      newXMLNode("fieldDelimiter", ","))
    )))
}
