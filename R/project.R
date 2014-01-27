#' The project module
#'
#' The eml-project module describes the research context in which the dataset
#' was created, including descriptions of over-all motivations and goals,
#' funding, personnel, description of the study area etc. This is also the
#' module to describe the design of the project: the scientific questions being
#' asked, the architecture of the design, etc. This module is used to place the
#' dataset that is being documented into its larger research context. (cite eml
#' documentation).

#' The module includes
#'       eml-documentation, 
#'       eml-resource, 
#'       eml-party, 
#'       eml-coverage, 
#'       eml-literature, 
#'       eml-text

#' Inclusion of superclass
#' @import resource.R
#' @import party.R
#' @import coverage.R

# Set rquired classes 
# =================================


# one of: author, contentProvider, custodianSteward, distributor, editor,
# metadataProvider, originator, pointOfContact, principalInvestigator,
# processor, publisher, or user.

# setClass("personnel_slots", 
           # slots = c(role = "character")
         # )

# setClass("personnel",
         # contains = c("id_scope",
                      # "resourceGroup",
                      # "personnel_slots",
                      # "referencesGroup"
                      # )
         # )




# setClass("studyAreaDescription", 
         # contains = c("id_scope") 
         # )




# abstract = text
# funding = text

# title = "character" from resource?

# A choice of (
             # A sequence of (
                            # title	required	unbounded
                            # personnel	required	unbounded
                            # abstract	optional	
                            # funding	optional	
                            # studyAreaDescription	optional	
                            # designDescription	optional	
                            # relatedProject	optional	unbounded
                            # )
             # OR
             # res:ReferencesGroup	 	 
             # )
