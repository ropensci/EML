# TODO:
# o check that citation file has not been included somewhere if so change to literature file here.
# o check that all fields are correct down to the atomic ones
# o check that superclass are included properly
# o create validity functions (really necessary?)
# o check mapping of fields to bibtex (write all fields? as bibtex ignores unknown)
#       - or give own style file that allows for all fields

#' The literature module
#'
#' The eml-literature module contains information that describes literature
#' resources. It is intended to provide overview information about the
#' literature citation, including title, abstract, keywords, and contacts.
#' Citation types follow the conventions laid out by EndNote, and there is an
#' attempt to represent a compatible subset of the EndNote citation types.
#' These citation types include: article, book, chapter, edited book,
#' manuscript, report, thesis, conference proceedings, personal communication,
#' map, generic, audio visual, and presentation. The "generic" citation type
#' would be used when one of the other types will not work (cite eml
#' documentation)).

#' Inclusion of superclass
#' @include resource.R


# Atomic classes for citation types
# =================================

setClass("journal",
         slots = c(journal = "character")
         )

setClass("volume",
         slots = c(volume = "character")
         )

setClass("numberOfVolumes",
         slots = c(numberOfVolumes = "character")
         )

setClass("issue",
         slots = c(issue = "character")
         )

setClass("pageRange",
         slots = c(pageRange = "character")
         )

setClass("totalPages",
         slots = c(totalPages = "character")
         )

setClass("totalTables",
         slots = c(totalTables = "character")
         )

setClass("totalFigures",
         slots = c(totalFigures = "character")
         )

# already defined in  dataset.R
# setClass("publisher",
         # slots = c(publisher = "responsibleParty"))

setClass("institution",
         slots = c(institution = "responsibleParty")
         )

setClass("publicationPlace",
         slots = c(publicationPlace = "character")
         )

setClass("ISSN",
         slots = c(ISSN = "character")
         )

setClass("ISBN",
         slots = c(ISBN = "character")
         )

setClass("edition",
         slots = c(edition = "character")
         )

setClass("chapterNumber",
         slots = c(chapterNumber = "character")
         )

setClass("editor",
         slots = c(editor = "character")
        )

setClass("bookTitle",
         slots = c(bookTitle = "character")
         )

setClass("degree",
         slots = c(degree = "character")
         )

setClass("conferenceName",
         slots = c(conferenceName = "character")
         )

setClass("conferenceDate",
         slots = c(conferenceDate = "character")
         )

setClass("communicationType",
         slots = c(communicationType = "character")
         )

setClass("referenceType",
         slots = c(referenceType = "character")
         )

setClass("scale",
         slots = c(referenceType = "geographicCoverage")
         )

setClass("performer",
         slots = c(referenceType = "responsibleParty")
         )

setClass("originalPublication",
         slots = c(referenceType = "character")
         )

setClass("reprintEdition",
         slots = c(reprintEdition = "character")
         )

setClass("reviewdItem",
         slots = c(reviewdItem = "character")
         )

setClass("recipient",
         slots = c(reviewdItem = "responsibleParty")
         )


# citation types
# ==============

# Article

# A sequence of (
               # journal	required
               # volume	optional
               # issue	optional
               # pageRange	optional
               # publisher	optional (from responsibleParty)
               # publicationPlace	optional
               # ISSN	optional
               # )

# article setup

setClass("article_slots",
         slots = c(journal = "journal",
                   volume = "volume",
                   issue = "issue",
                   pageRange = "pageRange",
                   publisher = "publisher",
                   publicationPlace = "publicationPlace",
                   ISSN = "ISSN"
                   )
         )

setClass("article",
         contains = c("id_scope",
                      "resourceGroup",
                      "article_slots",
                      "referencesGroup"
                      )
         )

# article coercion

setAs("article",
      "XMLInternalElementNode",
      function(from) emlToS4(from)
      )

setAs("XMLInternalElementNode",
      "article",
      function(from) emlToS4(from)
      )


# article methods

# bibtex [required/optional] (EML)

# author  [r] (? creator)
# title   [r] (? title)
# journal [r] (journal)
# year    [r] (? pubDate)

# volume  [o] (volume)
# number  [o] (? issue)
# pages   [o] (? pageRange)
# month   [o] (?)
# note    [o] (?)

# setMethod("bibentry",
          # "article",
    # function(object, bibtype){
          # bibentry(author = object@creator,
                # title = object@title,
                # journal = object@journal,
                # year = object@pubDate)

          # entry
          # }
      # )


# Book

# A sequence of (
               # publisher	required (responsibleParty)
               # publicationPlace	optional
               # edition	optional
               # volume	optional
               # numberOfVolumes	optional
               # totalPages	optional
               # totalFigures	optional
               # totalTables	optional
               # ISBN	optional
               # )

# bibtex book
# field [required/optional] (EML)

# author or editor [r] (?)
# title            [r] (?)
# publisher        [r] (journal)
# year             [r] (?)

# volume or number [o] (volume)
# series           [o] (? pageRange)
# address          [o] (?)
# edition          [o] (?)
# month            [o] (?)
# note             [o] (?)
# isbn             [o] (ISBN)

setClass("book_slots",
        slots = c(publisher = "publisher",
                  publicationPlace = "publicationPlace",
                  edition = "edition",
                  volume = "volume",
                  numberOfVolumes = "numberOfVolumes",
                  totalPages = "totalPages",
                  totalFigures = "totalFigures",
                  totalTables = "totalTables"
                  )
        )

setClass("book",
         contains = c("id_scope",
                      "resourceGroup",
                      "book_slots",
                      "referencesGroup"
                      )
         )

setAs("book",
      "XMLInternalElementNode",
      function(from) emlToS4(from)
      )

setAs("XMLInternalElementNode",
      "book",
      function(from) emlToS4(from)
      )


# Edited book (like book but see creator)

# A sequence of (
              # publisher	required
              # publicationPlace	optional
              # edition	optional
              # volume	optional
              # numberOfVolumes	optional
              # totalPages	optional
              # totalFigures	optional
              # totalTables	optional
              # ISBN	optional
              # creator (list editors here)
              # )

# bibtex book
# field [required/optional] (EML)

# author or editor [r] (?)
# title            [r] (?)
# publisher        [r] (journal)
# year             [r] (?)

# volume or number [o] (volume)
# series           [o] (? pageRange)
# address          [o] (?)
# edition          [o] (?)
# month            [o] (?)
# note             [o] (?)
# isbn             [o] (ISBN)

setClass("editedBook",
         contains = c("id_scope",
                      "resourceGroup",
                      "book_slots",
                      "referencesGroup"
                      )
         )

setAs("editedBook",
      "XMLInternalElementNode",
      function(from) emlToS4(from)
      )

setAs("XMLInternalElementNode",
      "editedBook",
      function(from) emlToS4(from)
      )

# Chapter
# Derived from: Book (by xs:extension)

# A sequence of (
               # chapterNumber	optional
               # editor	required	unbounded
               # bookTitle	required
               # pageRange	optional
               # )

# bibtex inbook
# field [required/optional] (EML)

# author or editor     [r] (?)
# title                [r] (?)
# chapter and/or pages [r] (?)
# publisher            [r] (journal)
# year                 [r] (?)

# volume or number     [o] (volume)
# series               [o] (? pageRange)
# type                 [o] (?)
# address              [o] (?)
# edition              [o] (?)
# month                [o] (?)
# note                 [o] (?)

setClass("chapter_slots",
         slots = c(chapterNumber = "chapterNumber",
                   editor = "editor",
                   bookTitle = "bookTitle",
                   pageRange = "pageRange"
                   )
         )

setClass("chapter",
         contains = c("id_scope",
                      "resourceGroup",
                      "book_slots",
                      "chapter_slots",
                      "referencesGroup"
                      )
         )

setAs("chapter",
      "XMLInternalElementNode",
      function(from) emlToS4(from)
      )

setAs("XMLInternalElementNode",
      "chapter",
      function(from) emlToS4(from)
      )

# Manuscript

# A sequence of (
              # institution	required	unbounded (from responsibleParty)
              # totalPages	optional
              # )

# bibtex unpublished

# field [required/optional] (EML)

# author [r] (?)
# title  [r] (?)
# note   [r] (?)

# year   [o] (?)
# month  [o] (?)

setClass("manuscript_slots",
         slots = c(institution = "institution",
                   totalPages = "totalPages"
                   )
         )

setClass("manuscript",
         contains = c("id_scope",
                      "resourceGroup",
                      "manuscript_slots",
                      "referencesGroup"
                      )
         )

setAs("manuscript",
      "XMLInternalElementNode",
      function(from) emlToS4(from)
      )

setAs("XMLInternalElementNode",
      "manuscript",
      function(from) emlToS4(from)
      )

# Thesis

# A sequence of (
               # degree	required
               # institution	required (from responsibleParty)
               # totalPages	optional
               # )


# bibtex phdthesis

# field [required/optional] (EML)

# author  [r] (?)
# title   [r] (?)
# school  [r] (?)
# year    [r] (?)

# type    [o] (?)
# address [o] (?)
# month   [o] (?)
# note    [o] (?)

setClass("thesis_slots",
         slots = c(degree = "degree",
                   institution = "institution",
                   totalPages = "totalPages"
                   )
         )

setClass("thesis",
         contains = c("id_scope",
                      "resourceGroup",
                      "thesis_slots",
                      "referencesGroup"
                      )
         )

setAs("thesis",
      "XMLInternalElementNode",
      function(from) emlToS4(from)
      )

setAs("XMLInternalElementNode",
      "thesis",
      function(from) emlToS4(from)
      )


# Conference proceedings
# Derived from: Chapter (by xs:extension)

# A sequence of (
               # conferenceName	        optional
               # conferenceDate	        optional
               # conferenceLocation	optional (from address)
               # )

# bibtex proceedings

# field [required/optional] (EML)

# title            [r] (?)
# year             [r] (?)

# editor           [o] (?)
# volume or number [o] (?)
# series           [o] (?)
# address          [o] (?)
# month            [o] (?)
# organization     [o] (?)
# publisher        [o] (?)
# note             [o] (?)

setClass("conference_proceedings_slots",
         slots = c(conferenceName = "conferenceName",
                   conferenceDate = "conferenceDate")
                   # conferenceLocation = "conferenceLocation" FIXME: This needs to come from address
         )

setClass("conferenceProceedings",
         contains = c("id_scope",
                      "resourceGroup",
                      "conference_proceedings_slots",
                      "referencesGroup"
                      )
         )

setAs("conferenceProceedings",
      "XMLInternalElementNode",
      function(from) emlToS4(from)
      )

setAs("XMLInternalElementNode",
      "conferenceProceedings",
      function(from) emlToS4(from)
      )


# Personal communication

# A sequence of (
               # publisher	        optional (from responsibleParty)
               # publicationPlace	optional
               # communicationType	optional
               # recipient	        optional unbounded (from responsibleParty)
               # )

# bibtex misc

# field [required/optional] (EML)

# author       [o] (?)
# title        [o] (?)
# howpublished [o] (?)
# month        [o] (?)
# year         [o] (?)
# note         [o] (?)

setClass("personal_communication_slots",
         slots = c(publisher = "publisher",
                   publicationPlace = "publicationPlace",
                   communicationType = "communicationType",
                   recipient = "recipient"
                   )
         )

setClass("personalCommunication",
         contains = c("id_scope",
                      "resourceGroup",
                      "personal_communication_slots",
                      "referencesGroup"
                      )
         )

setAs("personalCommunication",
      "XMLInternalElementNode",
      function(from) emlToS4(from)
      )

setAs("XMLInternalElementNode",
      "personalCommunication",
      function(from) emlToS4(from)
      )

# Map

# A sequence of (
               # publisher              optional (from responsibleParty)
               # edition	        optional
               # geographicCoverage	optional unbounded (from geographicCoverage)
               # scale	                optional
               # )

# bibtex misc

# field [required/optional] (EML)

# author       [o] (?)
# title        [o] (?)
# howpublished [o] (?)
# month        [o] (?)
# year         [o] (?)
# note         [o] (?)

setClass("map_slots",
         slots = c(publisher = "publisher",
                   edition = "edition",
                   geographicCoverage = "geographicCoverage",
                   scale = "scale"
                   )
         )

setClass("map",
         contains = c("id_scope",
                      "resourceGroup",
                      "map_slots",
                      "referencesGroup"
                      )
         )

setAs("map",
      "XMLInternalElementNode",
      function(from) emlToS4(from)
      )

setAs("XMLInternalElementNode",
      "map",
      function(from) emlToS4(from)
      )

# Audio visual

# A sequence of (
               # publisher	        required (from responsibleParty)
               # publicationPlace	optional unbounded
               # performer	        optional unbounded (from responsibleParty)
               # ISBN	                optional
               # )

# bibtex misc

# field [required/optional] (EML)

# author       [o] (?)
# title        [o] (?)
# howpublished [o] (?)
# month        [o] (?)
# year         [o] (?)
# note         [o] (?)

setClass("audio_visual_slots",
         slots = c(publisher = "publisher",
                   publicationPlace = "publicationPlace",
                   performer = "performer",
                   ISBN = "ISBN")
         )

setClass("audioVisual",
         contains = c("id_scope",
                      "resourceGroup",
                      "audio_visual_slots",
                      "referencesGroup"
                      )
         )


# Generic

# A sequence of (
               # publisher	        required (from responsibleParty)
               # volume	                optional
               # numberOfVolumes	optional
               # totalPages	        optional
               # totalFigures	        optional
               # totalTables	        optional
               # edition	        optional
               # originalPublication	optional
               # reprintEdition	        optional
               # reviewedItem	        optional
               # A choice of (
                            # ISBN	required
                            # OR
                            # ISSN	required
                            # )
               # )

# bibtex misc or book or?
# field [required/optional] (EML)
# ? ?

setClass("generic_slots",
         slots = c(publisher = "publisher",
                   volume = "volume",
                   numberOfVolumes = "numberOfVolumes",
                   totalPages = "totalPages",
                   totalFigures = "totalFigures",
                   totalTables = "totalTables",
                   edition = "edition",
                   originalPublication = "originalPublication", # fehlt
                   reprintEdition = "reprintEdition",  # fehlt
                   reviewdItem = "reviewdItem", # fehlt
                   ISBN = "ISBN",
                   ISSN = "ISSN"
                   )
         )

setClass("generic",
         contains = c("id_scope",
                      "resourceGroup",
                      "generic_slots",
                      "referencesGroup"
                      )
         )

setAs("generic",
      "XMLInternalElementNode",
      function(from) emlToS4(from)
      )

setAs("XMLInternalElementNode",
      "generic",
      function(from) emlToS4(from)
      )


# Top level classes rely on the classes above

setClass("citationType",
         slots = c(article = "article",
                   book = "book",
                   chapter = "chapter",
                   editedBook = "editedBook",
                   manuscript = "manuscript",
                   thesis = "thesis",
                   conferenceProceedings = "conferenceProceedings",
                   personalCommunication = "personalCommunication",
                   map = "map",
                   audioVisual = "audioVisual",
                   generic = "generic")
        )

setClass("literature",
         slots = c(citation = "citationType")
         )


# cite prototype

# setMethod("citation", "eml",
          # function(package, lib.loc, auto){
                # bib <- c(
                         # bibentry(package@citationType
                                  # )
                         # )
                # bib
                # }
          # )


# setClass("classificationSystem",
         # slots = c(classificationSystemCitation = "citation",
                   # classificationSystemModifications = "character"
                   # )
         # )

# setAs("XMLInternalElementNode",
      # "classificationSystem",
      # function(from) emlToS4(from)
      # )

# setAs("classificationSystem",
      # "XMLInternalElementNode",
      # function(from) S4Toeml(from)
      # )
