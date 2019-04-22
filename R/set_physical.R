#' set_physical
#'
#' Will calculate the file size, checksum, and checksum authentication method
#' algorithm automatically if the argument \code{objectName} is a file that exists.
#'
#' @param objectName name for the object, usually a filename like "hf205-1.csv"
#' @param id optional, an id value for the <physical> element in EML, for use in referencing
#' @param numHeaderLines Number of header lines preceding data. Lines are determined by the physicalLineDelimiter, or if it is absent, by the recordDelimiter. This value indicated the number of header lines that should be skipped before starting to parse the data.
#' @param numFooterLines Number of footer lines following data. Lines are determined by the physicalLineDelimiter, or if it is absent, by the recordDelimiter. This value indicated the number of footer lines that should be skipped after parsing the data. If this value is omitted, parsers should assume the data continues to the end of the data stream.
#' @param recordDelimiter This element specifies the record delimiter character when the format is text. The record delimiter is usually a linefeed (\\n) on UNIX, a carriage return (\\r) on MacOS, or both (\\r\\n) on Windows/DOS. Multiline records are usually delimited with two line ending characters, for example on UNIX it would be two linefeed characters (\\n\\n). As record delimiters are often non-printing characters, one can use either the special value "\\n" to represent a linefeed (ASCII 0x0a) and "\\r" to represent a carriage return (ASCII 0x0d). Alternatively, one can use the hex value to represent character values (e.g., 0x0a).
#' @param fieldDelimiter "," character by default (for csv files). This element specifies a character to be used in the object for indicating the ending column for an attribute. The delimiter character itself is not part of the attribute value, but rather is present in the column following the last character of the value. Typical delimiter characters include commas, tabs, spaces, and semicolons. The only time the fieldDelimiter character is not interpreted as a delimiter is if it is contained in a quoted string (see quoteCharacter) or is immediately preceded by a literalCharacter. Non-printable quote characters can be provided as their hex values, and for tab characters by its ASCII string "\\t". Processors should assume that the field starts in the column following the previous field if the previous field was fixed, or in the column following the delimiter from the previous field if the previous field was delimited.
#' @param collapseDelimiters The collapseDelimiters element specifies whether sequential delimiters should be treated as a single delimiter or multiple delimiters. An example is when a space delimiter is used; often there may be several repeated spaces that should be treated as a single delimiter, but not always. The valid values are yes or no. If it is set to yes, then consecutive delimiters will be collapsed to one. If set to no or absent, then consecutive delimiters will be treated as separate delimiters. Default behavior is no; hence, consecutive delimiters will be treated as separate delimiters, by default.
#' @param literalCharacter This element specifies a character to be used for escaping special character values so that they are treated as literal values. This allows "escaping" for special characters like quotes, commas, and spaces when they are intended to be used in an attribute value rather than being intended as a delimiter. The literalCharacter is typically a \\.
#' @param quoteCharacter This element specifies a character to be used in the object for quoting values so that field delimiters can be used within the value. This basically allows delimiter "escaping". The quoteChacter is typically a " or '. When a processor encounters a quote character, it should not interpret any following characters as a delimiter until a matching quote character has been encountered (i.e., quotes come in pairs). It is an error to not provide a closing quote before the record ends. Non-printable quote characters can be provided as their hex values.
#' @param attributeOrientation Specifies whether the attributes described in the physical stream are found in columns or rows. The valid values are column or row. If set to 'column', then the attributes are in columns. If set to 'row', then the attributes are in rows. Row orientation is rare.
#' @param size This element contains information of the physical size of the entity, by default represented in bytes unless the sizeUnit attribute is provided to change the units.
#' @param sizeUnit the unit in which size is measured; default is 'bytes'
#' @param authentication This element describes authentication procedures or techniques, typically by giving a checksum value for the object. The method used to compute the authentication value (e.g., MD5) is listed in the method attribute.
#' @param authMethod the method for authentication checksum, e.g. MD5
#' @param characterEncoding This element contains the name of the character encoding. This is typically ASCII or UTF-8, or one of the other common encodings.
#' @param encodingMethod This element lists a encoding method used to encode the object, such as base64, BinHex.
#' @param compressionMethod This element lists a compression method used to compress the object, such as zip, compress, etc. Compression and encoding methods must be listed in the order in which they were applied, so that decompression and decoding should occur in the reverse order of the listing. For example, if a file is compressed using zip and then encoded using MIME base64, the compression method would be listed first and the encoding method second.
#' @param url optional. The complete url from which the data file can be downloaded, if possible.
#' @return an EML physical object, such as used in a dataTable element to define the format of the data file.
#' @export
#'
#' @examples
#' set_physical("hf205-01-TPexp1.csv")
#' # FIXME set recordDelimiter based on user's system?
#' # FIXME richer distribution options? use set_distribution at top level?
set_physical <- function(objectName,
                         id = character(),
                         numHeaderLines = character(),
                         numFooterLines = character(),
                         recordDelimiter = detect_delim(objectName),
                         fieldDelimiter = ",",
                         collapseDelimiters = logical(),
                         literalCharacter = character(),
                         quoteCharacter = character(),
                         attributeOrientation = "column",
                         size = NULL,
                         sizeUnit = "bytes",
                         authentication = NULL,
                         authMethod = NULL,
                         characterEncoding = character(),
                         encodingMethod = character(),
                         compressionMethod = character(),
                         url = character()) {
  dataFormat <- list(
    textFormat = list(
      numHeaderLines = numHeaderLines,
      numFooterLines = numFooterLines,
      recordDelimiter = recordDelimiter,
      attributeOrientation = attributeOrientation,
      simpleDelimited = list(
        fieldDelimiter = fieldDelimiter,
        collapseDelimiters = as.character(collapseDelimiters),
        quoteCharacter = quoteCharacter,
        literalCharacter = literalCharacter
      )
    )
  )

  # Automatically calculate file size and checksum if none is specified
  # and objectName is a path to a file on disk and either of those two
  # properties were not set when set_physical was called

  if (file.exists(objectName)) {
    if (length(size) == 0) {
      message(paste0(
        "Automatically calculated file size using file.size(\"",
        objectName,
        "\")"
      ))
      size <- as.character(file.size(objectName))
    }


    if (length(authentication) == 0) {
      message(paste0(
        "Automatically calculated authentication size using digest::digest(\"",
        objectName, "\", algo = \"md5\", file = TRUE)"
      ))
      authentication <- digest::digest(objectName, algo = "md5", file = TRUE)
      authMethod <- "MD5"
    }
    # For the objectName to be set to the basename for the path just in case
    # the user intended this
    objectName <- basename(objectName)
  }
  authentication <- list(authentication = authentication, method = authMethod)
  if (!is.null(size)) {
    size <- list(size = size, unit = sizeUnit)
  }
  out <-
    list(
      objectName = objectName,
      size = size,
      authentication = authentication,
      compressionMethod = compressionMethod,
      encodingMethod = encodingMethod,
      characterEncoding = characterEncoding,
      dataFormat = dataFormat,
      id = id,
      distribution = set_distribution(url)
    )


  out
}


#' Automatically detect line delimiters in a text file
#'
#' This helper function was written expressly for \code{\link{set_physical}} to
#' be able to automate its \code{recordDelimiter} argument.
#'
#' @param path (character) File to search for a delimiter
#' @param nchar (numeric) Maximum number of characters to read from disk when
#' searching
#'
#' @return (character) If found, the delimiter, it not, \\r\\n
detect_delim <- function(path, nchar = 1e3) {
  # only look for delimiter if the file exists
  if(file.exists(path)){
    # readChar() will error on non-character data so
    chars <- tryCatch({
      readChar(path, nchar)
    },
    error = function(e) {
      NA
    })

    search <- regexpr("[\\r\\n]+", chars, perl = TRUE)

    if (!is.na(search) && search >= 0) {
      return(substr(chars, search, search + attr(search, "match.length") - 1))
    }
  }
  # readChar() will error on non-character data so


  "\r\n"
}


set_distribution <- function(url = character()) {
  if (length(url) > 0) {
    list(online = list(url = list(
      url,
      "function" = "download"
    )))
  } else {
    list()
  }
}
