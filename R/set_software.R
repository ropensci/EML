#' set_software
#'
#' @param codemeta codemeta object, see examples
#' @return an eml software element
#' @export
#' @examples
#' cm <- jsonlite::read_json(system.file("extdata/codemeta.json", package = "EML"))
#' software <- set_software(cm)
#' my_eml <- eml$eml(packageId = "eml-1.2", system = "knb", software = software)
#'
#' # write_eml(my_eml, "test.xml")
set_software <- function(codemeta) {
  cm <- codemeta
  eml$software(
    id = cm[["id"]],
    alternateIdentifier = cm$identifier,
    title = cm$name,
    creator = schema_to_eml(cm$author),
    associatedParty = schema_to_eml(cm$contributor),
    pubDate = cm$datePublished,
    language = cm$language,
    abstract = cm$description,
    keywordSet = if (!is.null(cm$keywords)) {
      eml$keywordSet(
        keyword = cm$keywords,
        keywordThesaurus = "codemeta"
      )
    },
    licenseURL = cm$license,
    implementation =
      eml$implementation(
        distribution = list(online = list(url = guess_url(cm))),
        size = cm$fileSize,
        operatingSystem = cm$operatingSystem,
        machineProcessor = cm$processorRequirements,
        diskUsage = cm$storageRequirements,
        runtimeMemoryUsage = cm$memoryRequirements,
        programmingLanguage = parse_programmingLanguage(cm$programmingLanguage)
      ),
    dependency = get_dependencies(cm)
  )
}


## internal helper routines
set_implementation <- function(cm) {
  if (is.na(guess_url(cm))) {
    return(NULL)
  }

  eml$implementation(
    distribution = list(online = list(url = guess_url(cm))),
    size = cm$fileSize,
    operatingSystem = cm$operatingSystem,
    machineProcessor = cm$processorRequirements,
    diskUsage = cm$storageRequirements,
    runtimeMemoryUsage = cm$memoryRequirements,
    programmingLanguage = parse_programmingLanguage(cm$programmingLanguage)
  )
}


get_dependencies <- function(cm) {
  ## Drop dependencies we cannot document
  out <- lapply(cm$softwareRequirements, set_software)
  drop <- is.na(vapply(cm$softwareRequirements, guess_url, character(1)))
  out[!drop]
}

is_url <- function(x) {
  out <- grepl("^https?://.*", x)
  if (is.null(out)) {
    return(FALSE)
  }
  if (length(out) == 0) {
    return(FALSE)
  }
  if (is.na(out)) {
    return(FALSE)
  }
  out
}

guess_url <- function(x) {
  if (is_url(x$id)) {
    return(x$id)
  } else if (is_url(x$sameAs)) {
    return(x$sameAs)
  } else if (is_url(x$codeRepository)) {
    x$codeRepository
  } else if (is_url(x$provider$url)) {
    x$provider$url
  } else {
    as.character(NA)
  }
}
parse_programmingLanguage <- function(x) {
  if (!is.null(x$name)) {
    paste(x$name, x$version)
  } else if (is.character(x)) {
    x
  } else {
    NULL
  }
}

first_nonempty <- function(...) {
  args <- list(...)
  drop <- vapply(args, is.null, logical(1))
  if (sum(!drop) > 0) {
    args[!drop][[1]]
  } else {
    NA
  }
}

schema_to_eml <- function(x) {
  lapply(x, function(author) set_responsibleParty(
      id = first_nonempty(author[["@id"]], author[["id"]]),
      givenName = author$givenName,
      surName = author$familyName,
      organizationName = author$affiliation,
      #      Note: pure codemeta doesn't recognize address properties!
      address = eml$address(
        deliveryPoint = author$address$streetAddress,
        city = author$address$addressLocality,
        administrativeArea = author$address$addressRegion,
        postalCode = author$address$postalCode,
        country = author$address$addressCountry
      ),
      electronicMailAddress = author$email,
      positionName = author$jobTitle,
      phone = author$telephone
    ))
}

## quiets concerns of R CMD check re: the "data" object 'eml'
if (getRversion() >= "2.15.1") utils::globalVariables(c("eml"))
