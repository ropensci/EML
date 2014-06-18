#' eml constructor function 
#' @param dat a data.set object  
#' @param title for the metadata.  Also used as the csv filename.   
#' @param creator a ListOfcreator object, character string, or person object.  
#'  Otherwise loaded from value set by eml_config.  
#' @param contact a contact object, character string, or person object.  
#'  Otherwise loaded from value set by eml_config.  
#' @param coverage a coverage object, such as created by the eml_coverage constructor function. (optional)
#' @param citation a citation object (optional, an EML file can have either 
#' a dataset OR citation OR software OR protocol as its top-level object) 
#' @param software a software object (optional) 
#' @param protocol a protocol object (optional) 
#' @param methods a method object or plain text string, documenting additional methods 
#' @param custom_units a list of custom units. Leave as NULL and these will be automatically
#'  detected from the EMLConfig after a user declares any custom units using
#' \code{\link{create_custom_unit}}.  Advanced users can alternatively just give a list
#' of custom_unit definitions here.  See \code{\link{create_custom_unit}} for details.  
#' @param ... additional slots passed to the dataset constructor `new("dataset", ...)`
#' @param additionalMetadata an additionalMetadata object
#' @details
#' 
#' - Permits character string definitions of creator & contact
#' - generates a unique PackageId
#' - Avoids more verbose separate call to dataset constructor and eml_dataTable
#' 
#' @import methods
#' @include party_classes.R
#' @include eml_classes.R
#' @export 
eml <- function(dat = NULL,
                title = "metadata",
                creator = NULL, 
                contact = NULL, 
                coverage = eml_coverage(scientific_names = NULL,
                                        dates = NULL,
                                        geographic_description = NULL,
                                        NSEWbox = NULL),
                methods = new("methods"),
                custom_units =  NULL,
                ...,
                additionalMetadata = new("ListOfadditionalMetadata"),
                citation = NULL,
                software = NULL,
                protocol = NULL
                )
{
  ## obtain uuids 
  uid <- eml_id()

  if(is.null(creator))
    creator <- get("defaultCreator", envir=EMLConfig)
  if(is.null(contact))
    contact <- get("defaultContact", envir=EMLConfig)

  if(is.null(custom_units))
    custom_units <- mget("custom_units", 
                         envir = EMLConfig,  
                         ifnotfound=list(list()))$custom_units

  ## Coerce character string persons into EML representations
  if(!is.null(dat)) # this is written only into dataset nodes 
    who <- contact_creator(contact = contact, 
                           creator = creator)


  if(is(methods, "character")){
    methods <- new("methods", 
                   methodStep = c(new("methodStep", 
                                      description = methods)))
  }


  ref_id <- list(id = "42") 

  if(length(custom_units) > 0){
    xml_unitList <- serialize_custom_units(custom_units, id = ref_id[["id"]])
    if(!isEmpty(additionalMetadata@.Data))
      additionalMetadata <- new("ListOfadditionalMetadata", 
                                c(additionalMetadata@.Data, xml_unitList))
    else
      additionalMetadata <- new("ListOfadditionalMetadata", 
                                c(xml_unitList))

  }



  eml <- new("eml",
             packageId = uid[["id"]], 
             system = uid[["system"]],
             scope = uid[["scope"]], 
             additionalMetadata = additionalMetadata)


  if(!isEmpty(dat)){
    if(is(dat, "dataset")){ # pre-built dataset object
      eml@dataset <- dat 
    } else if(is(dat, "data.frame")){  # data.set class, (also data.frame with wizard)
      eml@dataset = new("dataset",
                        id = ref_id[["id"]],
                        title = title, # required 
                        creator = who$creator,
                        contact = who$contact,
                        coverage = coverage,
                        methods = methods, 
                        dataTable = c(eml_dataTable(dat = dat, 
                                                    title = title)),
                        ...)
    } else if(is(dat, "dataTable")){
      eml@dataset = new("dataset",
                        id = ref_id[["id"]],
                        title = title, # required 
                        creator = who$creator,
                        contact = who$contact,
                        coverage = coverage,
                        methods = methods, 
                        dataTable = c(dat),
                        ...)
    }
 }

  if(!isEmpty(citation)){
    if(isS4(citation))
      eml@citation <- citation
    else if(is(citation, "BibEntry")){ # handle RefManageR citations
      class(citation) <- "bibentry"
      eml@citation <- bibentryToCitation(citation)
    } else if(is(citation, "bibentry"))
      eml@citation <- bibentryToCitation(citation)
    else
      warning("Citation format not recognized")
  }
  if(!isEmpty(software))
    eml@software <- software
  if(!isEmpty(protocol))
    eml@protocol <- protocol
 
 
  eml 
}


