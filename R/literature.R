# TODO:
# o check that all fields are correct down to the atomic ones
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

#' The module includes: 
#' eml-documentation, eml-resource, eml-coverage, eml-party, eml-access, eml-project

#' Inclusion of superclass
#' @include resource.R
#' @include coverage.R
#' @include party.R


# Atomic classes for citation types
# =================================

setClass("journal",
         slots = c(journal = "character")
         )

setAs("journal",
      "XMLInternalElementNode",
      function(from) S4Toeml(from)
      )

setAs("XMLInternalElementNode",
      "journal",
      function(from) emlToS4(from)
      )


setClass("volume",
         slots = c(volume = "character")
         )

setAs("volume",
      "XMLInternalElementNode",
      function(from) S4Toeml(from)
      )

setAs("XMLInternalElementNode",
      "volume",
      function(from) emlToS4(from)
      )


setClass("numberOfVolumes",
         slots = c(numberOfVolumes = "character")
         )

setAs("numberOfVolumes",
      "XMLInternalElementNode",
      function(from) S4Toeml(from)
      )

setAs("XMLInternalElementNode",
      "numberOfVolumes",
      function(from) emlToS4(from)
      )


setClass("issue",
         slots = c(issue = "character")
         )

setAs("issue",
      "XMLInternalElementNode",
      function(from) S4Toeml(from)
      )

setAs("XMLInternalElementNode",
      "issue",
      function(from) emlToS4(from)
      )


setClass("pageRange",
         slots = c(pageRange = "character")
         )

setAs("pageRange",
      "XMLInternalElementNode",
      function(from) S4Toeml(from)
      )

setAs("XMLInternalElementNode",
      "pageRange",
      function(from) emlToS4(from)
      )


setClass("totalPages",
         slots = c(totalPages = "character")
         )

setAs("totalPages",
      "XMLInternalElementNode",
      function(from) S4Toeml(from)
      )

setAs("XMLInternalElementNode",
      "totalPages",
      function(from) emlToS4(from)
      )


setClass("totalTables",
         slots = c(totalTables = "character")
         )

setAs("totalPages",
      "XMLInternalElementNode",
      function(from) S4Toeml(from)
      )

setAs("XMLInternalElementNode",
      "totalPages",
      function(from) emlToS4(from)
      )


setClass("totalFigures",
         slots = c(totalFigures = "character")
         )

setAs("totalFigures",
      "XMLInternalElementNode",
      function(from) S4Toeml(from)
      )

setAs("XMLInternalElementNode",
      "totalFigures",
      function(from) emlToS4(from)
      )


# already defined in  dataset.R
# setClass("publisher",
         # slots = c(publisher = "responsibleParty"))


setClass("institution",
         slots = c(institution = "responsibleParty")
         )

setAs("institution",
      "XMLInternalElementNode",
      function(from) S4Toeml(from)
      )

setAs("XMLInternalElementNode",
      "institution",
      function(from) emlToS4(from)
      )


setClass("publicationPlace",
         slots = c(publicationPlace = "character")
         )

setAs("publicationPlace",
      "XMLInternalElementNode",
      function(from) S4Toeml(from)
      )

setAs("XMLInternalElementNode",
      "publicationPlace",
      function(from) emlToS4(from)
      )


setClass("ISSN",
         slots = c(ISSN = "character")
         )

setAs("ISSN",
      "XMLInternalElementNode",
      function(from) S4Toeml(from)
      )

setAs("XMLInternalElementNode",
      "ISSN",
      function(from) emlToS4(from)
      )


setClass("ISBN",
         slots = c(ISBN = "character")
         )

setAs("ISBN",
      "XMLInternalElementNode",
      function(from) S4Toeml(from)
      )

setAs("XMLInternalElementNode",
      "ISBN",
      function(from) emlToS4(from)
      )


setClass("edition",
         slots = c(edition = "character")
         )

setAs("edition",
      "XMLInternalElementNode",
      function(from) S4Toeml(from)
      )

setAs("XMLInternalElementNode",
      "edition",
      function(from) emlToS4(from)
      )


setClass("chapterNumber",
         slots = c(chapterNumber = "character")
         )

setAs("chapterNumber",
      "XMLInternalElementNode",
      function(from) S4Toeml(from)
      )

setAs("XMLInternalElementNode",
      "chapterNumber",
      function(from) emlToS4(from)
      )


setClass("editor",
         slots = c(editor = "character")
        )

setAs("editor",
      "XMLInternalElementNode",
      function(from) S4Toeml(from)
      )

setAs("XMLInternalElementNode",
      "editor",
      function(from) emlToS4(from)
      )


setClass("bookTitle",
         slots = c(bookTitle = "character")
         )

setAs("bookTitle",
      "XMLInternalElementNode",
      function(from) S4Toeml(from)
      )

setAs("XMLInternalElementNode",
      "bookTitle",
      function(from) emlToS4(from)
      )


setClass("degree",
         slots = c(degree = "character")
         )

setAs("degree",
      "XMLInternalElementNode",
      function(from) S4Toeml(from)
      )

setAs("XMLInternalElementNode",
      "degree",
      function(from) emlToS4(from)
      )


setClass("conferenceName",
         slots = c(conferenceName = "character")
         )

setAs("conferenceName",
      "XMLInternalElementNode",
      function(from) S4Toeml(from)
      )

setAs("conferenceName",
      "edition",
      function(from) emlToS4(from)
      )


setClass("conferenceDate",
         slots = c(conferenceDate = "character")
         )

setAs("conferenceDate",
      "XMLInternalElementNode",
      function(from) S4Toeml(from)
      )

setAs("conferenceDate",
      "edition",
      function(from) emlToS4(from)
      )


setClass("communication",
         slots = c(communication = "character")
         )

setAs("communication",
      "XMLInternalElementNode",
      function(from) S4Toeml(from)
      )

setAs("XMLInternalElementNode",
      "communication",
      function(from) emlToS4(from)
      )


setClass("reference",
         slots = c(reference = "character")
         )

setAs("reference",
      "XMLInternalElementNode",
      function(from) S4Toeml(from)
      )

setAs("XMLInternalElementNode",
      "reference",
      function(from) emlToS4(from)
      )

setClass("scale",
         slots = c(scale = "geographicCoverage")
         )

setAs("scale",
      "XMLInternalElementNode",
      function(from) S4Toeml(from)
      )

setAs("XMLInternalElementNode",
      "scale",
      function(from) emlToS4(from)
      )


setClass("performer",
         slots = c(performer = "responsibleParty")
         )

setAs("performer",
      "XMLInternalElementNode",
      function(from) S4Toeml(from)
      )

setAs("XMLInternalElementNode",
      "performer",
      function(from) emlToS4(from)
      )


setClass("originalPublication",
         slots = c(originalPublication = "character")
         )

setAs("originalPublication",
      "XMLInternalElementNode",
      function(from) S4Toeml(from)
      )

setAs("XMLInternalElementNode",
      "originalPublication",
      function(from) emlToS4(from)
      )


setClass("reprintEdition",
         slots = c(reprintEdition = "character")
         )

setAs("reprintEdition",
      "XMLInternalElementNode",
      function(from) S4Toeml(from)
      )

setAs("reprintEdition",
      "edition",
      function(from) emlToS4(from)
      )


setClass("reviewdItem",
         slots = c(reviewdItem = "character")
         )

setAs("reviewdItem",
      "XMLInternalElementNode",
      function(from) S4Toeml(from)
      )

setAs("XMLInternalElementNode",
      "reviewdItem",
      function(from) emlToS4(from)
      )


setClass("recipient",
         slots = c(recipient = "responsibleParty")
         )

setAs("recipient",
      "XMLInternalElementNode",
      function(from) S4Toeml(from)
      )

setAs("XMLInternalElementNode",
      "recipient",
      function(from) emlToS4(from)
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
      function(from) S4Toeml(from)
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
# month   [o] (? pubDate)
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
      function(from) S4Toeml(from)
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
      function(from) S4Toeml(from)
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
      function(from) S4Toeml(from)
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
      function(from) S4Toeml(from)
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
      function(from) S4Toeml(from)
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
      function(from) S4Toeml(from)
      )

setAs("XMLInternalElementNode",
      "conferenceProceedings",
      function(from) emlToS4(from)
      )


# Personal communication

# A sequence of (
               # publisher	        optional (from responsibleParty)
               # publicationPlace	optional
               # communication	optional
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
                   communication = "communication",
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
      function(from) S4Toeml(from)
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
      function(from) S4Toeml(from)
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

# audio visual coercion 

setAs("audioVisual",
      "XMLInternalElementNode",
      function(from) S4Toeml(from)
      )

setAs("XMLInternalElementNode",
      "audioVisual",
      function(from) emlToS4(from)
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
      function(from) S4Toeml(from)
      )

setAs("XMLInternalElementNode",
      "generic",
      function(from) emlToS4(from)
      )


# Top level classes rely on the classes above
# ============================================

# citation

setClass("citation",
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

# citation coercion

setAs("citation",
      "XMLInternalElementNode",
      function(from) S4Toeml(from)
      )

setAs("XMLInternalElementNode",
      "citation",
      function(from) emlToS4(from)
      )

# literature

setAs("citation",
      "XMLInternalElementNode",
      function(from) S4Toeml(from)
      )

setAs("XMLInternalElementNode",
      "citation",
      function(from) emlToS4(from)
      )


setAs("citation",
      "XMLInternalElementNode",
      function(from) S4Toeml(from)
      )

setAs("XMLInternalElementNode",
      "citation",
      function(from) emlToS4(from)
      )


setClass("literature",
        slots = c(citation = "citation")
         )

# literature coercion

setAs("literature",
      "XMLInternalElementNode",
      function(from) S4Toeml(from)
      )

setAs("XMLInternalElementNode",
      "literature",
      function(from) emlToS4(from)
      )

# cite prototypes

# setMethod("bibentry", "citation",
          # function(package, lib.loc, auto){
                # bib <- c(
                         # bibentry(package@citation
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
