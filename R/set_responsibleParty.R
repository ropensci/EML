#' set_responsibleParty
#'
#' @param givenName individual's given names (list or vector for multiple names).  OR a person object.
#' @param surName individual name
#' @param organizationName if party is an organization instead of an individual, name for the org
#' @param positionName individual's position, i.e. "Researcher", "Graduate Student", "Professor"
#' @param address address object, see `eml$address` to build an address object
#' @param phone individual or organization phone number
#' @param electronicMailAddress email address (alternatively, can use 'email' argument)
#' @param onlineUrl a URL to the homepage of the individual or organization
#' @param userId the user's ID, usually within a particular system (KNB, DataONE)
#' @param id Identifier for this block, ideally an ORCID id (optional)
#' @param email alias for electronicMailAddress
#'
#' @return A emld object for any responsibleParty (e.g. creator, contact, etc)
#' @export
#'
#' @examples
#' # Pass in either a person object or separate values to create an individual
#' carl <- set_responsibleParty(as.person("Carl Boettiger <cboettig@ropensci.org>"))
#' matt <- set_responsibleParty("Matthew", "Jones", email = "mbjones@@nceas.ucsb.edu")
#'
#' # To create an organization, use the named `organization` argument to
#' # specify the organization name
#' my_org <- set_responsibleParty(
#'   organization = "My Organization",
#'   email = "contact@example.org"
#' )
set_responsibleParty <-
  function(givenName = NULL,
             surName = NULL,
             organizationName = NULL,
             positionName = NULL,
             address = NULL,
             phone = NULL,
             electronicMailAddress = NULL,
             onlineUrl = NULL,
             userId = NULL,
             id = NULL,
             email = NULL) {

    if (is(givenName, "person")) {
      UseMethod("set_responsibleParty", givenName)
    } else {
      UseMethod("set_responsibleParty", c(surName, organizationName))
    }
}

#' @export
set_responsibleParty.person <- function(givenName, ...) {
  as_emld(givenName)
}


#' @export
set_responsibleParty.character <-
  function(givenName = NULL,
             surName = NULL,
             organizationName = NULL,
             positionName = NULL,
             address = NULL,
             phone = NULL,
             electronicMailAddress = NULL,
             onlineUrl = NULL,
             userId = NULL,
             id = NULL,
             email = NULL) {
    emld::as_emld(list(
      individualName = list(givenName = givenName, surName = surName),
      organizationName = organizationName,
      positionName = positionName,
      address = address,
      phone = phone,
      electronicMailAddress =
        if (is.null(electronicMailAddress)) {
          email
        } else {
          electronicMailAddress
        },
      onlineUrl = onlineUrl,
      userId = userId,
      "@id" = id
    ))
  }
