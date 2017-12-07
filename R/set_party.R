#' A few helper methods to speed up creating various types of EML party
#' objects (creator, contact, etc.).
#'
#' High-level functions include:
#'
#' - set_creator
#' - set_contact
#' - set_associatedParty
#' - set_metadataProvider
#'
#' Each of these functions calls eml_party with the provided arguments.
#' In order to provide a good user experience, dots (...) with a link to the
#' eml_party function were not used. Instead, the arguments and Roxygen markup
#' have been copied across functions.
#'
#' Extra helper functions included are:
#'
#' set_phone
#' set_address
#' set_userId


#' Create a phone object
#'
#' @param number (character) The phone number
#' @param phonetype (character) The type of phone number
#'
#' @return (phone) A phone object
#' @export
#'
#' @examples
#' set_phone("1-555-555-5555")
#' set_phone("1-555-555-5556", "facsimilie")
set_phone <- function(number, phonetype) {
  phone <- new("phone",
               .Data = number)

  if (!missing(phonetype)) {
    phone@phonetype <- as(phonetype, "xml_attribute")
  }

  phone
}

#' Create an \code{address} object
#'
#' @param deliveryPoints (character|deliveryPoint) The delivery point (i.e., street address)
#' @param city (character|city) The city
#' @param administrativeArea (character|administrativeArea) The administrative area (i.e., the state (in the USA at least))
#' @param postalCode (character|postalCode) The postal code (AKA zip code (in the USA))
#' @param country (character|country) The country
#'
#' @return (address) An address object
#' @export
#'
#' @examples
#' set_address("1 Infinite Loop", "Cupertino", "CA", "95014", "USA")
#' set_address(administrativeArea = "California", country = "USA")
set_address <- function(deliveryPoints, city, administrativeArea, postalCode, country) {
  address <- new("address")

  if (!missing(deliveryPoints)) {
    address@deliveryPoint <- new("ListOfdeliveryPoint",
                                 .Data = lapply(deliveryPoints, as, "deliveryPoint"))
  }

  if (!missing(city)) {
    address@city <- as(city, "city")
  }

  if (!missing(administrativeArea)) {
    address@administrativeArea <- as(administrativeArea, "administrativeArea")
  }

  if (!missing(postalCode)) {
    address@postalCode <- as(postalCode, "postalCode")
  }

  if (!missing(country)) {
    address@country <- as(country, "country")
  }

  address
}

#' Create a \code{userId} object
#'
#' @param userId (character) The user ID
#' @param directory (character) The directory under which the user ID applies
#'
#' @return (userId) A userId object
#' @export
#'
#' @examples
#' set_userId("alice", "ldap://ldap.example.org")
#' set_userId("https://orcid.org/0000-0002-0381-3766", "https://orcid.org")
set_userId <- function(userId, directory) {
  user_id <- new("userId")

  user_id@.Data <- userId
  user_id@directory <- as(directory, "xml_attribute")

  user_id
}

#' Create a party object
#'
#' This function is meant to be used by other functions to create particular
#' types of EML parties (e.g., creator)
#'
#' Arguments, in most cases, are coerced to their appropriate type so many
#' of them can receive character vectors while they can also take vectors of
#' the appropriate target type (though this is not explicitly laid out in the
#' documentation).
#'
#' @param type (character) The type of party to create
#' @param givenNames (character) One or more given names for the party's individualName
#' @param surName (character) The sur name of the party's individualName
#' @param organizationNames (character) One or more organization names for the party
#' @param positionNames (character) One or more position names for the party
#' @param addresses (address) One or more addresses for the party
#' @param phones (character|phone) One or more phones for the party
#' @param electronicMailAddresses (character) One or more email addresses for the party
#' @param onlineUrls (character) One or more online URLs for the party
#' @param userIds (userId) One or more user IDs for the party
#' @param salutations (character) One or more salutations for the party's individualName
#' @param role (character) A role for the party
#'
#' @return An object of the class equal to \code{type}
set_party <- function(type="associatedParty",
                      givenNames,
                      surName,
                      organizationNames,
                      positionNames,
                      addresses,
                      phones,
                      electronicMailAddresses,
                      onlineUrls,
                      userIds,
                      salutations,
                      role) {
  party <- new(type)

  # Stop if role is set but the party type is not associatedParty
  if (!missing(role) && type != "associatedParty") {
    stop(paste0("A role was set but the party type is set to '", type,
                "' and the role argument is only appropriate when type is assoicatedParty."))
  }

  #' Stop if no individualName, organizationName, or positionName are set
  if (missing(surName) && missing(organizationNames) && missing(positionNames)) {
    stop("At least one of surName, organizationNames, or positionNames must be set.")
  }

  # Stop if givenNames is set by not surName
  if (!missing(givenNames) && missing(surName)) {
    stop("givenNames is set but surName is not set")
  }

  # Stop if salutations is set by not surName
  if (!missing(salutations) && missing(surName)) {
    stop("salutations is set but surName is not set")
  }

  if (!missing(surName)) {
    individual_name <- new("individualName")

    if (!missing(salutations)) {
      individual_name@salutation <- new("ListOfsalutation",
                                        .Data = lapply(salutations, as, "salutation"))
    }

    if (!missing(givenNames)) {
      individual_name@givenName <- new("ListOfgivenName",
                                       .Data = lapply(givenNames, as, "givenName"))
    }

    individual_name@surName <- as(surName, "surName")

    party@individualName <- c(individual_name)
  }

  if (!missing(organizationNames)) {
    party@organizationName <- new("ListOforganizationName",
                                  .Data = lapply(organizationNames, as, "organizationName"))
  }

  if (!missing(positionNames)) {
    party@positionName <- new("ListOfpositionName",
                              .Data = lapply(positionNames, as, "positionName"))
  }

  if (!missing(addresses)) {
    party@address <- c(addresses)
  }

  if (!missing(phones)) {
    if (is(phones, "phone")) {
      party@phone <- c(phones)
    } else {
      party@phone <- new("ListOfphone",
                         .Data = lapply(phones, as, "phone"))
    }
  }

  if (!missing(electronicMailAddresses)) {
    party@electronicMailAddress <- new("ListOfelectronicMailAddress",
                                       .Data = lapply(electronicMailAddresses, as, "electronicMailAddress"))
  }

  if (!missing(onlineUrls)) {
    party@onlineUrl <- new("ListOfonlineUrl",
                           .Data = lapply(onlineUrls, as, "onlineUrl"))
  }

  if (!missing(userIds)) {
    party@userId <- c(userIds)
  }

  if (!missing(role)) {
    party@role <- as(role, "RoleType")
  }

  party
}

#' Create a creator object
#'
#' @param givenNames (character) One or more given names for the party's individualName
#' @param surName (character) The sur name of the party's individualName
#' @param organizationNames (character) One or more organization names for the party
#' @param positionNames (character) One or more position names for the party
#' @param addresses (address) One or more addresses for the party
#' @param phones (character|phone) One or more phones for the party
#' @param electronicMailAddresses (character) One or more email addresses for the party
#' @param onlineUrls (character) One or more online URLs for the party
#' @param userIds (userId) One or more user IDs for the party
#' @param salutations (character) One or more salutations for the party's individualName

#' @return (creator) A creator object
#' @export
#'
#' @examples
#' set_creator("Mary", "Scientist")
set_creator <- function(givenNames,
                        surName,
                        organizationNames,
                        positionNames,
                        addresses,
                        phones,
                        electronicMailAddresses,
                        onlineUrls,
                        userIds,
                        salutations) {
  set_party("creator",
            givenNames,
            surName,
            organizationNames,
            positionNames,
            addresses,
            phones,
            electronicMailAddresses,
            onlineUrls,
            userIds,
            salutations)
}

#' Create a contact object
#'
#' @param givenNames (character) One or more given names for the party's individualName
#' @param surName (character) The sur name of the party's individualName
#' @param organizationNames (character) One or more organization names for the party
#' @param positionNames (character) One or more position names for the party
#' @param addresses (address) One or more addresses for the party
#' @param phones (character|phone) One or more phones for the party
#' @param electronicMailAddresses (character) One or more email addresses for the party
#' @param onlineUrls (character) One or more online URLs for the party
#' @param userIds (userId) One or more user IDs for the party
#' @param salutations (character) One or more salutations for the party's individualName
#'
#' @return (contact) A contact object
#' @export
#'
#' @examples
#' set_contact("Mary", "Scientist")
set_contact <- function(...) {
  set_party("contact",
            givenNames,
            surName,
            organizationNames,
            positionNames,
            addresses,
            phones,
            electronicMailAddresses,
            onlineUrls,
            userIds,
            salutations)
}

#' Create a metadataProvider object
#'
#' @param givenNames (character) One or more given names for the party's individualName
#' @param surName (character) The sur name of the party's individualName
#' @param organizationNames (character) One or more organization names for the party
#' @param positionNames (character) One or more position names for the party
#' @param addresses (address) One or more addresses for the party
#' @param phones (character|phone) One or more phones for the party
#' @param electronicMailAddresses (character) One or more email addresses for the party
#' @param onlineUrls (character) One or more online URLs for the party
#' @param userIds (userId) One or more user IDs for the party
#' @param salutations (character) One or more salutations for the party's individualName
#'
#' @return (metadataProvider) A metadataProivder object
#' @export
#'
#' @examples
#' set_metadataProvider("Mary", "Scientist")
set_metadataProvider <- function(...) {
  set_party("metadataProvider",
            givenNames,
            surName,
            organizationNames,
            positionNames,
            addresses,
            phones,
            electronicMailAddresses,
            onlineUrls,
            userIds,
            salutations)
}

#' Create an associatedParty object
#'
#' @param givenNames (character) One or more given names for the party's individualName
#' @param surName (character) The sur name of the party's individualName
#' @param organizationNames (character) One or more organization names for the party
#' @param positionNames (character) One or more position names for the party
#' @param addresses (address) One or more addresses for the party
#' @param phones (character|phone) One or more phones for the party
#' @param electronicMailAddresses (character) One or more email addresses for the party
#' @param onlineUrls (character) One or more online URLs for the party
#' @param userIds (userId) One or more user IDs for the party
#' @param salutations (character) One or more salutations for the party's individualName
#' @param role (character) A role for the party
#'
#' @return (associatedParty) An associatedParty object
#' @export
#'
#' @examples
#' set_associatedParty("Mary", "Scientist")
set_associatedParty <- function(...) {
  set_party("associatedParty",
            givenNames,
            surName,
            organizationNames,
            positionNames,
            addresses,
            phones,
            electronicMailAddresses,
            onlineUrls,
            userIds,
            salutations,
            role)
}
