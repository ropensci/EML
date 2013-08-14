#' Function to create an EML attributeList
#'
#' @param data an R dataframe
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
#' @import digest
#' @export
#' 
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
#'  node = eml_attributeList(dat, col_metadata, unit_metadata) 
#' 
eml_attributeList = function(dataframe, col_metadata, unit_metadata, 
                      id = c(1:length(dataframe)),  
                      accuracy = NULL, coverage = NULL, methods = NULL,
                      missingValueCode = "NA"){

##  FIXME prompting should be wrapped around existing functions instead of being internal to them 
## Prompt User for manual input if necessary metadata is not provided
#  if(is.null(col_metadata))
#    col_metadata <- prompt_user_for_columns(dataframe)
#  if(is.null(unit_metadata))
#    unit_metadata <- prompt_user_for_units(dataframe)

  ## Build the attributeList XML  
  attributeList = newXMLNode("attributeList")
  for(colname in names(dataframe)){

    column = dataframe[[colname]]

    ## FIXME Should try to use provided id first
    id = digest(col_metadata[colname])

    attribute = newXMLNode("attribute", attrs = c("id" = id), parent = attributeList)
    addChildren(attribute, newXMLNode("attributeName", colname))
    addChildren(attribute, newXMLNode("attributeDefinition", col_metadata[colname])) 
    # (measurementScale is also a child of attribute, but we need a pointer to it)
    measurementScale = newXMLNode("measurementScale", parent = attribute)

    ## Factor Data
    if(is.factor(column)){
      if(is.ordered(column)){
        enum = newXMLNode("ordinal", parent = measurementScale)
      } else {
        enum = newXMLNode("nominal", parent = measurementScale)
      }
      enumeratedDomain = 
        newXMLNode("enumeratedDomain", parent = 
          newXMLNode("nonNumericDomain", parent = enum))
      sapply(levels(column), function(level){
        codeDefinition = newXMLNode("codeDefinition", parent = enumeratedDomain)
        addChildren(codeDefinition, newXMLNode("code", level))
        addChildren(codeDefinition, 
                    newXMLNode("definition", unit_metadata[[colname]][level])) 
      })

    ## Date-time data
    } else if(is(column, "POSIXt")){
      newXMLNode("formatString", unit_metadata[[colname]], 
                 parent = newXMLNode("dateTime", parent = measurementScale))

    } else if(isDateString(unit_metadata[[colname]])){ #Hack
      newXMLNode("formatString", unit_metadata[[colname]], 
                 parent = newXMLNode("dateTime", parent = measurementScale))

    ## Numeric Data 
    } else if(is.numeric(column)){
        ratio = newXMLNode("ratio", parent = measurementScale)
        # Look up best unit match from the EML Unit library 
        unit_code = match_unit(unit_metadata[[colname]]) 
        newXMLNode("standardUnit", unit_code, 
                   parent = newXMLNode("unit", parent = ratio))
		# Set the domain to numeric
        numericDomain = newXMLNode("numericDomain", parent = ratio)
        if(is.integer(column))
          newXMLNode("numberType", "integer", parent=numericDomain)
        else
          newXMLNode("numberType", "real", parent=numericDomain)

    ## Character Data ###
    } else if(is.character(column)){
        nominal = newXMLNode("nominal", parent = measurementScale)
        textDomain = newXMLNode("textDomain", parent=nominal)
        newXMLNode("definition", unit_metadata[[colname]], parent=textDomain)
    }


    ## Optional, default matches that used by write.csv
    addChildren(attribute, 
                newXMLNode("missingValueCode", 
                           newXMLNode("code", missingValueCode),
                           newXMLNode("codeExplanation", "Missing Values")))


  } 
  attributeList 
}

isDateString <- function(x){
  x %in% c("YYYY", "YYYY-MM-DD", "MM-DD-YYYY") # Temporary hack till I work out a proper solution.  
}


#' Helper function to match the unit against standard unit definition
#' Documentation: http://knb.ecoinformatics.org/software/eml/eml-2.1.1/eml-unitTypeDefinitions.html
#' XML discription:
#' @keywords internal
match_unit = function(char){ 
  char 
}


# Columns defined as <attributes> in <attributeList>
# attribute requires: attributeName, attributeDefinition, measurementScale
# optionally: storageType, accuracy, coverage, methods, missingValueCode, attributeLabel

# measurementScale: nominal (factor), ordinal (ordered factor), interval (not yet implemented), ratio (most numeric), dateTime

