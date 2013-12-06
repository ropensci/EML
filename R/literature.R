# TODO:

# check that citation file has not been included somewhere if so change to
# litrature file here.

# check that all fields are correct down to the atomic ones

# check that superclasses are included properly





#' The eml-literature module contains information that describes literature
#' resources. It is intended to provide overview information about the
#' literature citation, including title, abstract, keywords, and contacts.
#' Citation types follow the conventions laid out by EndNote, and there is an
#' attempt to represent a compatible subset of the EndNote citation types.
#' These citation types include: article, book, chapter, edited book,
#' manuscript, report, thesis, conference proceedings, personal communication,
#' map, generic, audio visual, and presentation. The "generic" citation type
#' would be used when one of the other types will not work (cite eml
#' documentatoin)).

## Dependent classes (atm all in one file but when separated then include)
#' @include article.R
#' @include book.R
#' @include chapter.R
#' @include editedBook.R
#' @include manuscript.R
#' @include thesis.R
#' @include conferenceProceedings.R
#' @include personalCommunication.R
#' @include map.R
#' @include audioVisual.R
#' @include generic.R

# Inclusion of superclasses
#' @include responsibleparty.R
#' @include geographicCoverage.R

# citation types:
# article
# book
# chapter
# editedBook
# manuscript
# thesis
# conferenceProceedings
# personalCommunication
# map
# audioVisual
# generic

# atomic classes used in citation types
setClass("journal",
         slots = c(journal = "character"))

setClass("volume",
         slots = c(volume = "character"))

setClass("numberOfVolumes",
         slots = c(numberOfVolumes = "character"))

setClass("issue",
         slots = c(issue = "character"))

setClass("pageRange",
         slots = c(pageRange = "character"))

setClass("totalPages",
         slots = c(totalPages = "character"))

setClass("totalTables",
         slots = c(totalTables = "character"))

setClass("totalFigures",
         slots = c(totalFigures = "character"))

# setClass("publisher",
         # slots = c(publisher = "character"))

setClass("publicationPlace",
         slots = c(publicationPlace = "character"))

setClass("ISSN",
         slots = c(ISSN = "character"))

setClass("ISBN",
         slots = c(ISBN = "character"))

setClass("edition",
         slots = c(edition = "character"))

setClass("chapterNumber",
         slots = c(chapterNumber = "character"))

setClass("editor",
         slots = c(editor = "character"))

setClass("bookTitle",
         slots = c(bookTitle = "character"))

setClass("degree",
         slots = c(degree = "character"))

setClass("conferenceName",
         slots = c(conferenceName = "character"))

setClass("conferenceDate",
         slots = c(conferenceDate = "character"))

setClass("communicationType",
         slots = c(communicationType = "character"))

setClass("referenceType",
         slots = c(referenceType = "character"))

# citation types

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

setClass("article_slots",
         slots = c(journal = "journal",
                   volume = "volume",
                   issue = "issue",
                   pageRange = "pageRange",
                   publisher = "publisher",
                   publicationPlace = "publicationPlace",
                   ISSN = "ISSN")
         )

setClass("article",
         contains = c("resourceGroup",
                      "article_slots")
         )

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

setClass("book_slots",
        slots = c(publisher = "publisher", # FIXME: comes from responsibleParty
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
         contains = c("resourceGroup",
                      "book_slots")
         )

# Edited book (like book but see creator)
# A sequence of ( publisher	required
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

setClass("editedBook",
        contains = c("resourceGroup",
                     "book_slots")
        )


# Chapter
# Derived from: Book (by xs:extension)
# A sequence of (
               # chapterNumber	optional
               # editor	required	unbounded
               # bookTitle	required
               # pageRange	optional
               # )

setClass("chapter_slots",
         slots = c(chapterNumber = "chapterNumber",
                   bookTitle = "bookTitle",
                   editor = "editor",
                   pageRange = "pageRange")
         )
setClass("chapter",
         contains = c("resourceGroup",
                      "book_slots",
                      "chapter_slots")
         )


# Manuscript
# A sequence of (
              # institution	required	unbounded (from responsibleParty)
              # totalPages	optional
              # )

setClass("manuscript_slots",
         total_pages = "totalPages"
          )
setClass("manuscript",
         contains = c("resourceGroup",
                      "responsibleParty",
                      "manuscript_slots")
         )

# Thesis
# A sequence of (
               # degree	required
               # institution	required (from responsibleParty)
               # totalPages	optional
               # )

setClass("thesis_slots",
         slots = c(degree = "degree")
         )

setClass("thesis",
         contains = c("resourceGroup",
                      "responsibleParty",
                      "thesis_slots")
         )

# Conference proceedings
# Derived from: Chapter (by xs:extension)
# A sequence of (
               # conferenceName	optional
               # conferenceDate	optional
               # conferenceLocation	optional (from address)
               # )

setClass("conference_proceedings_slots",
         slots = c(conferenceName = "conferenceName",
                   conferenceDate = "conferenceDate")
         )

setClass("conferenceProceedings",
         contains = c("resourceGroup",
                      "conference_proceedings_slots")
         ) # FIXME: should also contain conferencLocation from address (from where to include?)

# Personal communication
# A sequence of (
               # publisher	optional (from responsibleParty)
               # publicationPlace	optional
               # communicationType	optional
               # recipient	optional	unbounded (from responsibleParty)
               # )

setClass("personal_communication_slots",
         slots = c(publicationPlace = "publicationPlace",
                   communicationType = "communicationType"
                   )

setClass("personalCommunication",
        contains = c("resourceGroup",
                     "responsibleParty",
                     "personal_communication_slots")
        )


# Map
# A sequence of (
               # publisher optional (from responsibleParty)
               # edition	optional
               # geographicCoverage	optional	unbounded (from geographicCoverage)
               # scale	optional
               # )

setClass("map_slots",
         slots = c(edition = "edition",
                   scale = "scale")
         )

setClass("map",
         contains = c("resourceGroup",
                      "responsibleParty",
                      "geographicCoverage",
                      "map_slots")
         )


# Audio visual
# A sequence of (
               # publisher	required (from responsibleParty)
               # publicationPlace	optional	unbounded
               # performer	optional	unbounded (from responsibleParty)
               # ISBN	optional
               # )

setClass("audio_visual_slots",
         slots = c(publicationPlace = "publicationPlace",
                   ISBN = "ISBN")
         )

setClass("audioVisual",
         contains = c("resourceGroup",
                      "responsibleParty",
                      "audio_visual_slots")
         )

# Gneric
# A sequence of (
               # publisher	required (from responsibleParty)
               # volume	optional
               # numberOfVolumes	optional
               # totalPages	optional
               # totalFigures	optional
               # totalTables	optional
               # edition	optional
               # originalPublication	optional
               # reprintEdition	optional
               # reviewedItem	optional
               # A choice of (
                            # ISBN	required
                            # OR
                            # ISSN	required
                            # )
               # )

setClass("generic_slots",
         slots = c(publisher = "responsibleParty",
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
                   ISSN = "ISSN")

         )

setClass("generic",
         contains = c("resourceGroup",
                      "generic_slots")
         )

# Top most classes rely on the classes above

setClass("literature",
         slots = c(citation = "citation") # this needs to be base on R internal citation?
         )

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

setAs("XMLInternalElementNode", "citation",   function(from) emlToS4(from))
setAs("citation", "XMLInternalElementNode",   function(from) S4Toeml(from))

setClass("classificationSystem",
         slots = c(classificationSystemCitation = "citation",
                        classificationSystemModifications = "character"))
setAs("XMLInternalElementNode", "classificationSystem",   function(from) emlToS4(from))
setAs("classificationSystem", "XMLInternalElementNode",   function(from) S4Toeml(from))
