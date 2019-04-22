#' get_unit_id
#'
#' @description A function to assist with getting valid EML unit ids
#'  (see examples). Warning: ensure returned unit is equivalent to
#'  input unit (for example "pH" will return "picohenry" which may
#'  or may not be equivalent to the input unit "pH").
#'
#' @param input_units (character|vector) input units that needs
#'  valid EML unit ids
#' @param eml_version (character) the eml schema version desired
#' (there is a change in the way eml units are named from eml-2.1.1
#'  to eml-2.2.0)
#' @return (character) A valid EML unit id. If no valid EML unit id
#'  can be found, the function will output a warning, along with a
#'  preformatted custom unit id.
#' @examples
#' \dontrun{
#' # The following all return the same id
#' get_unit_id("kilometersPerSquareSecond")
#' get_unit_id("kilometerPerSecondSquared")
#' get_unit_id("Kilometers per seconds squared")
#' get_unit_id("km/s^2")
#' get_unit_id("km s-2")
#' get_unit_id("s-2 /     kilometers-1") # this works but is not advised
#' }
#' @export
get_unit_id <- function(input_units,
                        eml_version = emld::eml_version()) {
  if (!requireNamespace("units", quietly = TRUE)) {
    stop(
      call. = FALSE,
      "return_eml_unit requires the
       'units' package to be installed."
    )
  }

  if (!is.character(input_units)) {
    stop(
      call. = FALSE,
      "input_units must be characters"
    )
  }


  ## Initiallize exponents
  exponents <- list(
    numeric = c("1", "2", "3", "4", "5", "6"),
    preceeding = c("", "square", "cubic"),
    following = c("", "squared", "cubed"),
    symbolic = c("", "\u00B2", "\u00B3")
  )

  ## Get EML units
  eml_units <- get_unitList()$units

  unlist(sapply(input_units, function(unit) {

    ## Check if unit is an eml abbreviation
    eml_abbr <- which(unit == eml_units$abbreviation)

    ## Get eml unit id
    if (is_standardUnit(unit)) {
      id <- unit
    } else if (length(eml_abbr) == 1) {
      id <- eml_units$id[eml_abbr]
    } else {
      split_unit <- get_split_unit(unit, exponents)
      f_split_unit <- tryCatch({
        format_split_unit(split_unit, exponents, eml_version, udunits_units)
      },
      error = function(e) {
        ""
      }
      )
      f_split_unit <- unlist(f_split_unit)

      ## combine and collapse unit
      if (length(f_split_unit) > 0) {
        id <- paste(c(
          f_split_unit[1],
          sapply(f_split_unit[-1],
                 function(x)
                   gsub("(^[[:alpha:]]?)",
                        "\\U\\1",
                        x,
                        perl = TRUE))
        ),
        collapse = ""
        )
      } else {
        id <- ""
      }

      if (id == "") {
        warning(
          call. = FALSE,
          "'", unit, "' cannot be converted to a standard EML form"
        )
      } else if (!is_standardUnit(id)) {
        warning(
          call. = FALSE,
          "'", id, "' is not a standard eml unit, a custom unit will be needed"
        )
      }
    }

    return(id)
  }))
}

format_split_unit <- function(split_unit,
                              exponents,
                              eml_version,
                              udunits_units) {

  ## Check if eml_version is >= 2.2.0
  greater_2.2.0 <- as.numeric(
    gsub(
      "(^eml-)([[:digit:]]\\.[[:digit:]])(\\.)([[:digit:]])",
      "\\2\\4", eml_version)) >= 2.2

  ## Format the split unit
  f_split_unit <- sapply(split_unit, function(x) {

    ## Check if the split unit is symbolic
    singular_standard <- unique(
      udunits_units$singular_standard[which(x[1] == udunits_units$symbol)])

    if (length(singular_standard) != 1) {
      ## Check if the split unit is plural
      singular_standard <- unique(
        udunits_units$singular_standard[which(x[1] == udunits_units$name_plural)])
    }

    if (length(singular_standard) == 1) {
      x[1] <- singular_standard
    }

    ## Format exponents
    if (length(x) == 2) {
      is_denominator <- grepl("^-", x[2])
      exp_value <- gsub("[^[:digit:]]", "", x[2])

      if (as.numeric(exp_value) > 3) {
        stop("only exponents up to 3 are supported by EML")

        ## If greater_2.2.0 use following exponents (e.g. second squared)
      } else if (greater_2.2.0) {
        x[2] <- exponents$following[which(exp_value == exponents$numeric)]

        ## If not use preceeding exponents (e.g. square second)
      } else {
        x[2] <- x[1]
        x[1] <- exponents$preceeding[which(exp_value == exponents$numeric)]
      }

      ## Add per if negative exponent
      if (is_denominator) {
        x <- c("per", x)
      }
    }

    return(x)
  })

  # For eml schema before 2.2, first unit of multiple units is plural
  if (!greater_2.2.0 && length(split_unit) > 1) {
    length_su <- length(f_split_unit[[1]])
    f_split_unit[[1]][length_su] <-
      udunits_units$plural_standard[
        which(f_split_unit[[1]][length_su] == udunits_units$name_singular)]
  }

  return(f_split_unit)
}

get_split_unit <- function(unit, exponents) {
  if (is.na(unit)) {
    unit <- ""
  }

  ## Replace mu with micro
  unit <- gsub("\u03BC", "\u00B5", unit)

  ## Separate string at capitals or operators (e.g. metersPerSecond or m/s)
  unit <- gsub("([^_ ])([[:upper:]])", "\\1 \\2", unit) # Split at capitals
  unit <- gsub(
    paste0(
      "([^[:alpha:]]|^)(",
      paste(suppressMessages(units::valid_udunits_prefixes()$symbol), collapse = "|"),
      ")( )([[:upper:]])"
    ),
    "\\1\\2\\4",
    unit
  ) # merge back separated prefixes (e.g. "k W" to "kW")
  unit <- gsub("(\\/|\\*)", " \\1", unit)

  ## Convert exponents to numeric exponents
  unit <- gsub("-", "- ", unit)
  unit_split <- as.list(strsplit(unit, "[[:blank:]]+")[[1]])
  for (i in rev(seq_along(unit_split))) {
    x <- tolower(unit_split[i])
    i_following_exp <- which(exponents$following == x)
    i_pre_exp <- which(exponents$preceeding == x)
    i_symbolic_exp <- which(exponents$symbolic == x)

    if (length(i_following_exp) > 0) {
      unit_split[i] <- exponents$numeric[i_following_exp]
    } else if (length(i_symbolic_exp) > 0) {
      unit_split[i] <- exponents$numeric[i_symbolic_exp]
    } else if (length(i_pre_exp) > 0 && length(unit_split) > i) {
      unit_split[i] <- unit_split[i + 1]
      unit_split[i + 1] <- exponents$numeric[i_pre_exp]
    }
  }
  unit <- paste(unit_split, collapse = " ")
  unit <- gsub("- ", "-", unit)
  unit <- gsub("[[:blank:]](-*[[:digit:]])", "\\1", unit)

  # Use units package and regex to try to get valid units
  unit <- suppressWarnings(tryCatch({
    get_valid_unit(unit)
  },
  error = function(e) {
    ""
  }
  ))

  split_unit <- as.list(strsplit(unit, " ")[[1]])

  # Separate exponents
  split_unit <- sapply(split_unit, function(x) {
    x <- gsub("(-?[[:digit:]])", " \\1", x)
    x <- strsplit(x, " ")
  })

  return(split_unit)
}

get_valid_unit <- function(unit) {
  stopifnot(length(unlist(
    gregexpr("\\(", unit))) == length(unlist(gregexpr("\\)", unit))))
  # stop if not all parenthesis are closed
  stopifnot(!grepl("\\([^\\)]*\\(", unit))
  # stop if nested parenthesis (unable to deparse)
  stopifnot(!grepl("\\([^\\)]*\\/[^\\)]*\\)", unit))
  # stop if fractions in parenthesis (unable to deparse)

  ## Preformat unit
  ## Use x2/y instead of x^2 per y
  unit <- gsub("(\\^)(-{0,1}[[:digit:]]+)", "\\2", unit) # remove ^ in front of digits
  unit <- gsub("(^|[[:blank:]]+)[p|P]er[[:blank:]]+", " / ", unit)
  # replace "per" and "Per" with "/"

  ## Deal with parenthesis
  ## Use x/y/z instead of x/(y*z)
  rev_unit <- paste(rev(strsplit(unit, NULL)[[1]]), collapse = "")
  rev_unit <- gsub("(\\*?[[:blank:]])(?=[^\\)]+\\({1}[[:blank:]]*\\/{1})",
                   "/", rev_unit, perl = TRUE) # insert "/"
  unit <- paste(rev(strsplit(rev_unit, NULL)[[1]]), collapse = "")
  unit <- gsub("\\(|\\)", " ", unit) # remove parenthesis
  unit <- gsub("\\*", " ", unit) # remove "*"

  ## Deal with exponents
  ## use x y-2 z-1 instead of x/y2/z
  unit <- gsub(
    "([[:blank:]]*\\/{1}[[:blank:]]*)([[:alpha:]_]+)(-{0,1}[[:digit:]]+|[[:blank:]]*)",
    " \\2-\\3 ", unit
  ) # remove / and add - to exponent
  unit <- gsub("(-{2})([[:digit:]])", "\\2", unit) # change -- to -
  unit <- gsub("-{1}[[:blank:]]{1}", "-1 ", unit) # change -[[:blank:]] to -1

  ## Remove leading 1 from instances like "1/m"
  unit <- gsub("(^|[[:blank:]])1", "", unit)

  ## Final clean
  unit <- gsub("[[:blank:]]+", " ", unit) # remove multple spaces
  unit <- gsub("^[[:blank:]]|[[:blank:]]$", "", unit) # remove leading/trailing spaces

  ## Attempt to deparse unit
  unit_out <- units::deparse_unit(units::as.units(unit))

  ## If unit_out is NA, deparse numerator and denominator separately
  if (unit_out == "") {
    unit_numerator <- gsub("[[:alpha:]]+-[[:digit:]]", "", unit)
    unit_numerator <- units::deparse_unit(units::as.units(unit_numerator))
    unit_denominator <- gsub("[[:alpha:]]+[[:blank:]]", "", unit)
    unit_denominator <- units::deparse_unit(units::as.units(unit_denominator))
    unit_out <- paste(unit_numerator, unit_denominator)
  }

  return(unit_out)
}

get_plural_unit <- function(unit) {

  ## Code is based on ut_form_plural function in xml.c of udunits2

  if (is.na(unit)) {
    unit <- ""
  }

  stopifnot(is.character(unit))

  singular <- tolower(unit)

  plural <- ""

  ## Known exceptions
  plural <- ifelse(unit == "siemens", "siemens", plural)
  plural <- ifelse(unit == "hertz", "hertz", plural)
  plural <- ifelse(unit == "dimensionless", "dimensionless", plural)

  ## If plural is not specifically defined, define it
  if (plural == "" && unit != "") {
    unit_length <- nchar(singular)
    last_char <- substr(singular, unit_length, unit_length)
    penultimate_char <- substr(singular, (unit_length - 1), (unit_length - 1))

    if (last_char == "y") {
      if (penultimate_char == "a" || penultimate_char == "e" || penultimate_char == "i" ||
        penultimate_char == "o" || penultimate_char == "u") {
        plural <- paste0(unit, "s")
      } else {
        plural <- paste0(substr(unit, 1, (unit_length - 1)), "ies")
      }
    } else {
      if (last_char == "s" || last_char == "x" || last_char == "z" ||
        paste0(penultimate_char, last_char) == "ch" ||
        paste0(penultimate_char, last_char) == "sh") {
        plural <- paste0(unit, "es")
      } else {
        plural <- ifelse(unit == "", NA, paste0(unit, "s"))
      }
    }
  }

  return(plural)
}

# Get udunits from the `units` package. The return value of this function is  saved in the
# sysdata.rda file.

load_udunits <- function() {

  ## Get unit system
  prefixes <- suppressMessages(units::valid_udunits_prefixes())
  udunits_unit_system <- suppressMessages(units::valid_udunits())

  ## Add a blank character to prefixes to allow for no prefix
  prefixes_symbol <- c(paste0(prefixes$symbol), "")
  prefixes_name <- c(paste0(prefixes$name), "")

  ## Remove units without a name
  udunits_unit_system <-
    udunits_unit_system[udunits_unit_system$name_singular != "", ]

  ## Remove all already prefixed names, i.e. kilogram
  is_prefixed <- grepl(paste0("^.*_?",
                              prefixes$name,
                              collapse = "|"),
                       udunits_unit_system$name_singular)
  udunits_unit_system <- udunits_unit_system[!is_prefixed, ]

  ## Get all single and plural units and symbols
  udunits_units <- lapply(seq_len(nrow(udunits_unit_system)), function(i) {

    ## Get all singular names and aliases
    name_singular <- paste0(udunits_unit_system[i, ]$name_singular,
                            ", ", udunits_unit_system[i, ]$name_singular_aliases)
    name_singular <- unlist(strsplit(name_singular, ", "))
    singular_standard <- rep(udunits_unit_system[i, ]$name_singular,
                             length(name_singular))

    ## Get all plural names and aliases
    name_plural <- paste0(udunits_unit_system[i, ]$name_plural,
                          ", ", udunits_unit_system[i, ]$name_plural_aliases)
    name_plural <- unlist(strsplit(name_plural, ", "))
    plural_standard <- rep(udunits_unit_system[i, ]$name_plural, length(name_plural))

    ## If plurals are empty, get plurals
    if (length(name_plural) == 1 && name_plural == "") {
      name_plural <- unlist(lapply(name_singular, get_plural_unit))
      plural_standard <- unlist(lapply(singular_standard, get_plural_unit))
    }

    ## Known exceptions
    if (udunits_unit_system[i, ]$name_singular %in% c("celsius", "fahrenheit")) {
      name_plural <- c(udunits_unit_system[i, ]$name_plural, name_plural)
      plural_standard <- c(udunits_unit_system[i, ]$name_plural, plural_standard)
    }

    ## Get symbols
    symbol <- udunits_unit_system[i, ]$symbol
    if (symbol != "") {
      symbol <- rep(paste0(prefixes_symbol, symbol), length(name_singular))
    } else {
      symbol <- rep(rep("", length(prefixes_symbol)), length(name_singular))
    }

    ## Get all prefixed names and plurals
    name_singular <- unlist(lapply(name_singular,
                                   function(x) paste0(prefixes_name, x)))
    singular_standard <- unlist(lapply(singular_standard,
                                       function(x) paste0(prefixes_name, x)))
    name_plural <- unlist(lapply(name_plural,
                                 function(x) paste0(prefixes_name, x)))
    plural_standard <- unlist(lapply(plural_standard,
                                     function(x) paste0(prefixes_name, x)))

    ## Create data frame
    data.frame(name_singular,
               singular_standard,
               name_plural,
               plural_standard,
               symbol,
               stringsAsFactors = FALSE)
  })

  udunits_units <- do.call(rbind, udunits_units)
}
