#' @importFrom utils bibentry person

# The literature module
#
# The eml-literature module contains information that describes literature
# resources. It is intended to provide overview information about the
# literature citation, including title, abstract, keywords, and contacts.
# Citation types follow the conventions laid out by EndNote, and there is an
# attempt to represent a compatible subset of the EndNote citation types.
# These citation types include: article, book, chapter, edited book,
# manuscript, report, thesis, conference proceedings, personal communication,
# map, generic, audio visual, and presentation. The "generic" citation type
# would be used when one of the other types will not work (cite eml
# documentation)).

# Set required classes
# =================================

# bibentry coercion
setOldClass("bibentry")

# citation types
# ==============

# article <-> bibentry

# bibtex [required/optional] (EML mapping)

# author  [r] (? creator)
# title   [r] (? title)
# journal [r] (journal)
# year    [r] (? pubDate)

# volume  [o] (volume)
# number  [o] (? issue)
# pages   [o] (? pageRange)
# month   [o] (? pubDate)
# note    [o] (?)

setAs("article", "bibentry", function(from) {
  entry <- list(
    bibtype = class(from),
    #                       author = as(from@creator, "person"),
    #                       title = from@title,
    journal = from@journal,
    #                       year = from@pubDate, # FIXME: handle date properly and extract year
    volume = from@volume,
    number = from@issue,
    pages = from@pageRange,
    #                       month = from@pubDate, # FIXME: handle date properly and extract year
    textVersion = NULL,
    header = paste("Citation based on eml", class(from)),
    footer = "---------------------------------------0"
  )
  #
  entry
})

setAs("bibentry", "article", function(from) {
  eml_citation <- new("article")
  #      eml_citation@creator = new("ListOfcreator", lapply(from$author, as, "creator"))
  #      eml_citation@title = from$title
  eml_citation@journal <- from$journal
  #      eml_citation@pubDate = paste(from$year, from$month, sep = "-") # FIXME: Needs to be handled properly to put together year and month
  eml_citation@volume <- from$volume
  eml_citation@issue <- from$number
  eml_citation@pageRange <- from$pages
  eml_citation
})

# bibtex book
# field [required/optional] (EML)

# (author) or editor [r] (? creator)
# title            [r] (? title)
# publisher        [r] (? publisher)
# year             [r] (? pubDate)

# volume or number [o] (volume)
# series           [o] (?)
# address          [o] (pubPlace)
# edition          [o] (edition)
# month            [o] (pubDate month)
# note             [o] (?)
# isbn             [o] (ISBN)

setAs("book", "bibentry", function(from) {
  entry <-  list(
    bibtype = class(from),
    # required
    #                       author = as(from@creator, "person"),
    #                       title  = from@title,
    publisher = as(from@publisher, "person"),
    #                       year = from@pubDate, # FIXME: handle date properly and extract year
    volume = from@volume,
    series = from@series,
    address = from@publicationPlace,
    edition = from@edition,
    #                       month = from@pubDate, # FIXME: handle date properly and extract year
    isbn = from@ISBN,
    textVersion = NULL,
    header = paste("Citation based on eml", class(from)),
    footer = "---------------------------------------0"
  )
  #
  entry
})

setAs("bibentry", "book", function(from) {
  eml_citation                  <- new("book")
  #     eml_citation@creator          <- new("ListOfcreator", lapply(from$author, as, "creator")) # FIXME: The latex fields can be author or editor
  #     eml_citation@title            <- from$title
  eml_citation@publisher        <- as(person(from$publisher), "publisher")
  #     eml_citation@pubDate          <- paste(from$year, from$month, sep = "-")
  eml_citation@volume           <- from$volume
  eml_citation@series           <- from$series
  eml_citation@publicationPlace <- from$address
  eml_citation@edition          <- from$edition
  eml_citation@ISBN             <- from$isbn
  eml_citation
})



# bibtex book
# field [required/optional] (EML)

# editor [r] (creator list editors here)
# title            [r] (title)
# publisher        [r] (publisher)
# year             [r] (pubDate)

# volume or number [o] (volume)
# series           [o] (pageRange)
# address          [o] (publicationPlace)
# edition          [o] (edition)
# month            [o] (pubDate)
# note             [o] (?)
# isbn             [o] (ISBN)

setAs("editedBook", "bibentry", function(from) {
  entry =  list(
    bibtype = "Book",
    editor = as(from@creator, "person"),
    publisher = as(from@publisher, "person"),
    volume = from@volume,
    series = from@series,
    address = from@publicationPlace,
    edition = from@edition,
    isbn = from@ISBN,
    textVersion = NULL,
    header = paste("Citation based on eml", class(from)),
    footer = "---------------------------------------0"
  )

  entry
})

setAs("bibentry", "editedBook", function(from) {
  eml_citation                  <- new("editedBook")
  eml_citation@publisher        <- as(person(from$publisher), "publisher")
  eml_citation@volume           <- from$volume
  eml_citation@series           <- from$series
  eml_citation@publicationPlace <- from$address
  eml_citation@edition          <- from$edition
  eml_citation@ISBN             <- from$isbn
  eml_citation
})


# bibtex inbook
# field [required/optional] (EML)
# author or editor     [r] (editor)
# title                [r] (title)
# chapter and/or pages [r] (pageRange)
# publisher            [r] (publisher)
# year                 [r] (pubDate)

# volume or number     [o] (volume)
# series               [o] (series)
# type                 [o] (?)
# address              [o] (publicationPlace)
# edition              [o] (edition)
# month                [o] (pubDate)
# note                 [o] (?)

setAs("chapter", "bibentry", function(from) {
  entry =  list(
    bibtype = "InBook",
    editor = as(from@editor, "person"),
    publisher = as(from@publisher, "person"),
    chapter = from@pageRange,
    # Not exaclty right bu field required
    volume = from@volume,
    series = from@series,
    address = from@publicationPlace,
    edition = from@edition,
    isbn = from@ISBN,
    textVersion = NULL,
    header = paste("Citation based on eml", class(from)),
    footer = "---------------------------------------0"
  )

  entry
})

setAs("bibentry", "chapter", function(from) {
  eml_citation                  <- new("chapter")
  eml_citation@editor           <- new("ListOfeditor", lapply(from$editor, as, "editor"))
  #     eml_citation@title            <- from$title
  eml_citation@publisher        <- as(person(from$publisher), "publisher")
  #     eml_citation@pubDate          <- paste(from$year, from$month, sep = "-")
  eml_citation@volume           <- from$volume
  eml_citation@series           <- from$series
  eml_citation@publicationPlace <- from$address
  eml_citation@edition          <- from$edition
  eml_citation@ISBN             <- from$isbn
  eml_citation
})

# Manuscript

# bibtex unpublished
# field [required/optional] (EML)

# author [r] (creator)
# title  [r] (title)
# note   [r] (additionalInfo)

# year   [o] (pubDate)
# month  [o] (pubDate)

setAs("manuscript", "bibentry", function(from) {
  entry <-  list(
    bibtype = "unpublished",
    # required
    #                       author = as(from@creator, "person"),
    #                       title  = from@title,
    # The note is quired for unpublished and is not written if character(0)
    #                note = if(length(from@ResourceGroup@additionalInfo) == 0){"-"} else {from@additionalInfo},
    # optional
    #                       year = from@pubDate, # FIXME: handle date properly and extract year
    #                       month = from@pubDate, # FIXME: handle date properly and extract month
    textVersion = NULL,
    header = paste("Citation based on eml", class(from)),
    footer = "---------------------------------------0"
  )

  entry
})

setAs("bibentry", "manuscript", function(from) {
  eml_citation                  <- new("manuscript")
  #     eml_citation@creator          <- new("ListOfcreator", lapply(from$author, as, "creator"))
  #     eml_citation@title            <- from$title
  #eml_citation@additionalInfo   <- from$note
  #     eml_citation@pubDate          <- paste(from$year, from$month, sep = "-")
  eml_citation@institution      <- new("ListOfinstitution")
  eml_citation
})

# Thesis

# bibtex phdthesis
# field [required/optional] (EML)

# author  [r] (author)
# title   [r] (title)
# school  [r] (institution)
# year    [r] (pubDate (year))

# type    [o] (degree)
# address [o] (write coercion from institution to address)
# month   [o] (pubDate)
# note    [o] (?)

setAs("thesis", "bibentry", function(from) {
  entry <-  list(
    bibtype = "phdthesis",
    # required
    #                       author = as(from@creator, "person"),
    #                       title  = from@title,
    school = paste(unlist(
      lapply(from@institution, function(x)
        slot(x, "organizationName"))
    ), collapse = ", "),
    #                       year = from@pubDate, # FIXME: handle date properly and extract year
    # optional
    type = from@degree,
    # address = as(from@institution, "address") # FIXME: write coercion? But no good way back from this entry to an eml address
    #                       month = from@pubDate, # FIXME: handle date properly and extract month
    textVersion = NULL,
    header = paste("Citation based on eml", class(from)),
    footer = "---------------------------------------0"
  )

  entry
})

setAs("bibentry", "thesis", function(from) {
  eml_citation                  <- new("thesis")
  # required
  eml_citation@degree           <- from$type
  eml_citation@institution      <- new("ListOfinstitution", lapply(unlist(strsplit(from$school, ",")), function(organization)
    new("institution", organizationName = organization)))
  #     eml_citation@creator          = new("ListOfcreator", lapply(from$author, as, "creator"))
  # optional + more
  #     eml_citation@title            = from$title
  #     eml_citation@pubDate          = paste(from$year, from$month, sep = "-") # FIXME: Handle dates properly
  eml_citation
})


# bibtex proceedings
# field [required/optional] (EML)

# title            [r] (title)
# year             [r] (conferenceDate)

# address          [o] (conferenceLocation)
# month            [o] (conferenceDate)
# organization     [o] (conferenceName)
# editor           [o] (?)
# volume or number [o] (?)
# series           [o] (?)
# publisher        [o] (?)
# note             [o] (?)

setAs("conferenceProceedings", "bibentry", function(from) {
  entry <-  list(
    bibtype = "proceedings",
    # required
    #                       title  = from@title,
    year = from@conferenceDate,
    # FIXME: handle date properly and extract year
    address = as(from@conferenceLocation, "character"),
    month = from@conferenceDate,
    organization = from@conferenceName,
    textVersion = NULL,
    header = paste("Citation based on eml", class(from)),
    footer = "---------------------------------------0"
  )

  entry
})

setAs("bibentry", "conferenceProceedings", function(from) {
  eml_citation                      <- new("conferenceProceedings")
  #     eml_citation@title                <- from$title
  eml_citation@conferenceDate       <- paste(from$year, from$month, sep = "-") # FIXME: handle date properly
  # eml_citation@conferenceLocation <- from$adddress # FIXME: extract address from string? no good way
  eml_citation@conferenceName       <- from$organization
  eml_citation
})


# bibtex misc
# field [required/optional] (EML)
# author       [o] (creator)
# title        [o] (title)
# howpublished [o] (publisher) questionable
# month        [o] (pubDate)
# year         [o] (pubDate)
# note         [o] (additionalinfo)

setAs("personalCommunication", "bibentry", function(from) {
  entry <-  list(
    bibtype = "misc",
    textVersion = NULL,
    header = paste("Citation based on eml", class(from)),
    footer = "---------------------------------------0"
  )

  entry
})

setAs("bibentry", "personalCommunication", function(from) {
  eml_citation                      <- new("personalCommunication")
  # eml_citation@publisher
  # eml_citation@publicationPlace
  # eml_citation@recipient
  # eml_citation@communication
  eml_citation
})

# bibtex misc
# field [required/optional] (EML)
# author       [o] (creator)
# title        [o] (title)
# howpublished [o] (?)
# month        [o] (pubDate)
# year         [o] (pubDate)
# note         [o] (additionalInfo)

setAs("map", "bibentry", function(from) {
  entry <-  list(
    bibtype = "misc",
    textVersion = NULL,
    header = paste("Citation based on eml", class(from)),
    footer = "---------------------------------------0"
  )

  entry
})

setAs("bibentry", "map", function(from) {
  eml_citation                      <- new("map")
  # publisher              optional (from responsibleParty)
  # edition	        optional
  # geographicCoverage	optional unbounded (from geographicCoverage)
  # scale	                optional
  eml_citation
})



# bibtex misc
# field [required/optional] (EML)
# author       [o] (creator)
# title        [o] (title)
# howpublished [o] (?)
# month        [o] (pubDate)
# year         [o] (pubDate)
# note         [o] (additionalinfo)

setAs("audioVisual", "bibentry", function(from) {
  entry <-  list(
    bibtype = "misc",
    textVersion = NULL,
    header = paste("Citation based on eml", class(from)),
    footer = "---------------------------------------0"
  )

  entry
})

setAs("bibentry", "audioVisual", function(from) {
  eml_citation                      <- new("audioVisual")
  eml_citation@publisher	       <- new("publisher")
  # publicationPlace	optional unbounded
  # performer	        optional unbounded (from responsibleParty)
  # ISBN	                optional
  eml_citation
})



# bibtex misc
# field [required/optional] (EML)
# author       [o] (creator)
# title        [o] (title)
# howpublished [o] (?)
# month        [o] (pubDate)
# year         [o] (pubDate)
# note         [o] (additionalInfo)

setAs("generic", "bibentry", function(from) {
  entry =  list(
    bibtype = "misc",
    textVersion = NULL,
    header = paste("Citation based on eml", class(from)),
    footer = "---------------------------------------0"
  )

  entry
})

setAs("bibentry", "generic", function(from) {
  eml_citation                      <- new("generic")
  eml_citation@publisher	       <- new("publisher")
  eml_citation@ISBN                 <- ""
  eml_citation
})



setAs("citation", "bibentry", function(from)
  citationToBibentry(from))
citationToBibentry <- function(from) {
  eml_types <- slotNames(from)
  eml_types <-
    eml_types[!(eml_types %in% c(".Data", "references", names(getSlots("ResourceGroup"))))]
  type <- eml_types[sapply(eml_types,
                           function(x)
                             ! isEmpty(slot(from, x)))]
  out <- as(slot(from, type[[1]]), "bibentry")

  out$author <- as(from@creator, "person")
  out$title <- from@title
  out$year <- from@pubDate
  do.call(bibentry, out)

}


# generic bibentry coercion to eml citations
setAs("bibentry",
      "citation",
      function(from)
        bibentryToCitation(from))

bibentryToCitation <-
  function(from) {
    type <- from$bibtype

    if (type == "Book") {
      if (!is.null(from$editor))
        type <- "editedBook"
    } else if (type == "InBook") {
      type <- "chapter"
    } else if (type == "Unpublished") {
      type <- "manuscript"
    } else if (type == "PhdThesis") {
      type <- "thesis"
    } else if (type == "Proceedings") {
      type <- "conferenceProceedings"
    } else if (type %in% c("Article")) {
      type <- type
    } else {
      type <- "generic"
      warning(
        "Cannot determine the right citation type automatically. Coerced to eml generic citation type!"
      )
    }

    object <- switch(
      type,
      Article = as(from, "article"),
      Book = as(from, "book"),
      editedBook = as(from, "editedBook"),
      chapter = as(from, "chapter"),
      manuscript = as(from, "manuscript"),
      thesis = as(from, "thesis"),
      conferenceProceedings = as(from, "conferenceProceedings"),
      generic = as(from, "generic")
    )

    type <- class(object)
    out <- new(
      "citation",
      title = from$title,
      pubDate = from$year,
      creator = new("ListOfcreator", lapply(from$author, function(x)
        as(as(x, "ResponsibleParty"), "creator")))
    )
    slot(out, type) <- object

    out
  }
promote_to_citation <- function(object) {
  type <- class(object)
  out <- new("citation")
  slot(out, type) <- object
  out
}
