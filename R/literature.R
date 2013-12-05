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

##    Dependent classes
#' @include article.R
#' @include book.R
#' @include chapter.R
#' @include editedBook.R
#' @include manuscript.R
#' @include thesis.R
#' @include conferenceProceedings.R
#' @include personalCommunication.R
#' @include map.R
#' @include generic.R
#' @include audioVisual.R
#' @include generic.R

# they contain info about:

# litrature citation
  # title
  # abstract
  # keywords
  # contacts

# citation types:
# article.R
# book.R
# chapter.R
# editedBook.R
# manuscript.R
# thesis.R
# conferenceProceedings.R
# personalCommunication.R
# map.R
# audioVisual.R
# generic.R

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
         slots = c(totalPages = "character"))

setClass("totalFigures",
         slots = c(totalFigures = "character"))

setClass("publisher",
         slots = c(publisher = "character"))

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

# citation types

# Article
# A sequence of (
               # journal	required
               # volume	optional
               # issue	optional
               # pageRange	optional
               # publisher	optional
               # publicationPlace	optional
               # ISSN	optional
               # )

setClass("article",
         slots = c(journal = "journal",
                   volume = "volume",
                   issue = "issue",
                   pageRange = "pageRange",
                   publisher = "publisher",
                   publicationPlace = "publicationPlace",
                   ISSN = "ISSN")
         )

# Book
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
               # )

setClass("book",
        slots = c(publisher = "publisher", # comes from responsibleParty actually so reflect this here?
                  publicationPlace = "publicationPlace",
                  edition = "edition",
                  volume = "volume",
                  numberOfVolumes = "numberOfVolumes",
                  totalPages = "totalPages",
                  totalFigures = "totalFigures",
                  totalTables = "totalTables"
                  )
        )

# Chapter
# Derived from: Book (by xs:extension)
# A sequence of (
               # chapterNumber	optional
               # editor	required	unbounded
               # bookTitle	required
               # pageRange	optional
               # )

setClass("chapter", slots = c(chapterNumber = "chapterNumber",
                   editor = "editor",
                   bookTitle = "bookTitle",
                   pageRange = "pageRange"),
         contains = "book")



setClass("editedBook")

setClass("manuscript")
setClass("thesis")
setClass("conferenceProceedings")
setClass("personalCommunication")
setClass("map")
setClass("audioVisual")
setClass("generic")





setAs("XMLInternalElementNode", "citation",   function(from) emlToS4(from))
setAs("citation", "XMLInternalElementNode",   function(from) S4Toeml(from))




setClass("classificationSystem",
         slots = c(classificationSystemCitation = "citation",
                        classificationSystemModifications = "character"))
setAs("XMLInternalElementNode", "classificationSystem",   function(from) emlToS4(from))
setAs("classificationSystem", "XMLInternalElementNode",   function(from) S4Toeml(from))


new(literature)

chapter = "chapter",
editedBook = "editedBoo",
manuscript = "manuscript")

# just example
## Class defintiion
##    Dependent classes
#' @include temporalCoverage.R
#' @include geographicCoverage.R
#' @include taxonomicCoverage.R
#' @include referencesGroup.R
# setClass("coverage",
         # slots = c(id = "character",
# #                        system = "character",
# #                        scope = "character",
                        # geographicCoverage = "geographicCoverage",
                        # temporalCoverage = "temporalCoverage",
                        # taxonomicCoverage = "taxonomicCoverage"),
         # contains = "referencesGroup")
# setAs("XMLInternalElementNode", "coverage",   function(from) emlToS4(from))
# setAs("coverage", "XMLInternalElementNode",   function(from) S4Toeml(from))





