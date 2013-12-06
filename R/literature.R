# TODO:
# o check that citation file has not been included somewhere if so change to literature file here.
# o check that all fields are correct down to the atomic ones
# o check that superclass are included properly
# o create validity functions (really necessary?)
# o create conversion (for which functions)


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
#' @include responsibleparty.R
#' @include geographicCoverage.R
#' @include dataset.R


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

setClass("editedBook",
         contains = c("id_scope",
                      "resourceGroup",
                      "book_slots",
                      "referencesGroup")
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


# Manuscript

# A sequence of (
              # institution	required	unbounded (from responsibleParty)
              # totalPages	optional
              # )

setClass("manuscript_slots",
         slots = c(institution = "institution",
                   totalPages = "totalPages")
         )

setClass("manuscript",
         contains = c("id_scope",
                      "resourceGroup",
                      "manuscript_slots",
                      "referencesGroup"
                      )
         )


# Thesis

# A sequence of (
               # degree	required
               # institution	required (from responsibleParty)
               # totalPages	optional
               # )

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
                   # conferenceLocation = "conferenceLocation" FIXME: This needs to come from address
         )

setClass("conferenceProceedings",
         contains = c("id_scope",
                      "resourceGroup",
                      "conference_proceedings_slots",
                      "referencesGroup"
                      )
         )


# Personal communication

# A sequence of (
               # publisher	optional (from responsibleParty)
               # publicationPlace	optional
               # communicationType	optional
               # recipient	optional	unbounded (from responsibleParty)
               # )

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


# Map

# A sequence of (
               # publisher optional (from responsibleParty)
               # edition	optional
               # geographicCoverage	optional	unbounded (from geographicCoverage)
               # scale	optional
               # )

setClass("map_slots",
         slots = c(publisher = "publisher",
                   edition = "edition",
                   geographicCoverage = "geographicCoverage",
                   scale = "scale")
         )

setClass("map",
         contains = c("id_scope",
                      "resourceGroup",
                      "map_slots",
                      "referencesGroup"
                      )
         )


# Audio visual

# A sequence of (
               # publisher	required (from responsibleParty)
               # publicationPlace	optional	unbounded
               # performer	optional	unbounded (from responsibleParty)
               # ISBN	optional
               # )

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
                   ISSN = "ISSN")
         )

setClass("generic",
         contains = c("id_scope",
                      "resourceGroup",
                      "generic_slots",
                      "referencesGroup"
                      )
         )

# Top most classes rely on the classes above

setClass("literature",
         slots = c(citation = "citation") # FIXME: this needs to be base on R internal citation
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

setAs("XMLInternalElementNode",
      "citation",
      function(from) emlToS4(from)
      )

setAs("citation",
      "XMLInternalElementNode",
      function(from) S4Toeml(from)
      )

setClass("classificationSystem",
         slots = c(classificationSystemCitation = "citation",
                   classificationSystemModifications = "character"
                   )
         )

setAs("XMLInternalElementNode",
      "classificationSystem",
      function(from) emlToS4(from)
      )

setAs("classificationSystem",
      "XMLInternalElementNode",
      function(from) S4Toeml(from)
      )
