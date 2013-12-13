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

#' The module includes
#'       eml-documentation, 
#'       eml-resource, 
#'       eml-coverage, 
#'       eml-party, 
#'       eml-access, 
#'       eml-project

#' Inclusion of superclass
#' @include resource.R
#' @include coverage.R
#' @include party.R

# Set rquired classes 
# =================================

# bibentry coercion
setClass("bibentry")


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
         slots = c(journal = "character",
                   volume = "character",
                   issue = "character",
                   pageRange = "character",
                   publisher = "ListOfpublisher",
                   publicationPlace = "character",
                   ISSN = "character"
                   )
         )

setClass("article",
         contains = c("id_scope",
                      "resourceGroup",
                      "article_slots",
                      "referencesGroup"
                      )
         )

# article xml <-> s4 coercion

setAs("article",
      "XMLInternalElementNode",
      function(from) S4Toeml(from)
      )

setAs("XMLInternalElementNode",
      "article",
      function(from) emlToS4(from)
      )

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

setAs("article", "bibentry", function(from){
      entry = bibentry(bibtype = class(from), 
                       author = as(from@creator, "person"),
                       title = from@title,
                       journal = from@journal,
                       year = from@pubDate, # FIXME: handle date properly and extract year 
                       volume = from@volume,
                       number = from@issue,
                       pages = from@pageRange,
                       month = from@pubDate, # FIXME: handle date properly and extract year
                       textVersion = NULL, 
                       header = paste("Citation based on eml", class(from)), 
                       footer = "---------------------------------------0")
      class(entry) = "bibentry"
      entry
      }
)

setAs("bibentry", "article", function(from){
      eml_citation = new("article")  
      eml_citation@creator = new("ListOfcreator", lapply(from$author, as, "creator")) 
      eml_citation@title = from$title
      eml_citation@journal = from$journal
      eml_citation@pubDate = paste(from$year, from$month, sep = "-") # FIXME: Needs to be handled properly to put together year and month 
      eml_citation@volume = from$volume
      eml_citation@issue = from$number
      eml_citation@pageRange = from$pages
      eml_citation 
     } 
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
        slots = c(publisher = "ListOfpublisher",
                  publicationPlace = "character",
                  edition = "character",
                  volume = "character",
                  numberOfVolumes = "character",
                  totalPages = "character",
                  totalFigures = "character",
                  totalTables = "character",
                  ISBN = "character"
                  )
        )

setClass("book",
         contains = c("id_scope",
                      "resourceGroup",
                      "book_slots",
                      "referencesGroup"
                      )
         )

# book coercion

setAs("book",
      "XMLInternalElementNode",
      function(from) S4Toeml(from)
      )

setAs("XMLInternalElementNode",
      "book",
      function(from) emlToS4(from)
      )

# bibtex book
# field [required/optional] (EML)

# author or editor [r] (? creator)
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

setAs("book", "bibentry", function(from){
      entry = bibentry(bibtype = class(from), 
                       # required
                       author = as(from@creator, "person"),   
                       title  = from@title, 
                       publisher = as(from@publisher, "person"),  
                       year = from@pubDate, # FIXME: handle date properly and extract year 
                       volume = from@volume, 
                       series = from@series,
                       address = from@publicationPlace,
                       edition = from@edition,
                       month = from@pubDate, # FIXME: handle date properly and extract year
                       isbn = from@ISBN,
                       textVersion = NULL, 
                       header = paste("Citation based on eml", class(from)), 
                       footer = "---------------------------------------0")
      class(entry) = "bibentry"
      entry
      }
)

setAs("bibentry", "book", function(from){
     eml_citation                  = new("book")
     eml_citation@creator          = new("ListOfcreator", lapply(from$author, as, "creator"))
     eml_citation@title            = from$title
     eml_citation@publisher        = new("ListOfpublisher", lapply(from$publisher, as, "publisher"))
     eml_citation@pubDate          = from$year
     eml_citation@volume           = from$volume
     eml_citation@series           = from$series
     eml_citation@publicationPlace = from$address
     eml_citation@edition          = from$edition
     eml_citation@pubDate          = from$month
     eml_citation@ISBN             = from$isbn
     eml_citation
     } 
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
         slots = c(chapterNumber = "character",
                   editor = "character",
                   bookTitle = "character",
                   pageRange = "character"
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
         slots = c(institution = "ListOfinstitution",
                   totalPages = "character"
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
         slots = c(degree = "character",
                   institution = "ListOfinstitution",
                   totalPages = "character"
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
         slots = c(conferenceName = "character",
                   conferenceDate = "character",
                   conferenceLocation = "address") 
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
         slots = c(publisher = "ListOfpublisher",
                   publicationPlace = "character",
                   communication = "character",
                   recipient = "ListOfrecipient"
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
         slots = c(publisher = "ListOfpublisher",
                   edition = "character",
                   geographicCoverage = "geographicCoverage",
                   scale = "character"
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
         slots = c(publisher = "ListOfpublisher",
                   publicationPlace = "character",
                   performer = "listOfperformer",
                   ISBN = "character")
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
         slots = c(publisher = "ListOfPublisher",
                   volume = "character",
                   numberOfVolumes = "character",
                   totalPages = "character",
                   totalFigures = "character",
                   totalTables = "character",
                   edition = "character",
                   originalPublication = "character",
                   reprintEdition = "character",
                   reviewedItem = "character",
                   ISBN = "character",
                   ISSN = "character"
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

# bibtex (cases then call appropriate function)
# setAs("eml", "bibentry", function(from){
# }


# literature 

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
