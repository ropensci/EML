#' Function to create an EML DataTable

# @param data an R dataframe
#' @param col_metadata a named character vector of definitions, e.g. c("X1" = "species name", "X2" = "species density", ...)
#' @param unit_metadata a named list of length ncol defining the cell values.  
#' arguments will vary by object class; see details.  
#' 
#' @details 
#' 
#' unit_metadata list items will depend on the class, as shown in the examples.
#' For instance: 
#' \item factor: a named character vector of definitions of each factor
#' \item numeric: unit used, from EML list
#' \item dateTime: For an R time object (POSIXt class), give the format
#' \item character: definition (same as col def?)
#' definitions: of all factors, a named character vector of definitions, e.g.  c("X1" = "species name", "X2" = "species density", ...)
#' 
#' Semantics:
#' 
#' The primary role of an EML Datatable is to define the data
#' specified by the column headings; facilitating data synthesis.
#' We have semantic meaning available in EML for many numeric units. Any
#' unit not provided must still be defined semantically.  But we have much
#' more obtuse support for providing semantic meaning to character strings.
#' 
#' @references Normative technical specification given at: 
#' 
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

eml_dataTable = function(dataframe, col_metadata, unit_metadata,
                      # Optional dataTable metadata
                      accuracy = NULL, coverage = NULL, 
                      methods = NULL, missingValueCode = NA, 
                      # physical file metadata 
                      csvfilename=NULL, file_description=NULL){

  # Write the data to a csv file
  if(is.null(csvfilename))
    csvfilename = paste(gsub("(.{16}).+", "\\1", paste(names(dataframe), collapse="_")), ".csv", sep = "")
  write.csv(dataframe, file=csvfilename) 

  if(is.null(file_description))
    file_discription = paste("Description of the CSV file", csvfilename)  

  # Write the dataTable header metadata
  dataTable = newXMLNode("dataTable")
  newXMLNode("entityName", csvfilename, parent = dataTable)
  newXMLNode("entityDescription", file_description, parent = dataTable)


  # Physical node describes the CSV file.  
  physical = newXMLNode("physical", parent = dataTable)
  newXMLNode("objectName", csvfilename, parent = physical)
  addChildren(physical, csv_format())

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
