# TODO: 
# o integrate the module wherever it can occur: Done but FIXME: missing in project module because not there yet

# o grep CitationType *.xsd
#     eml-literature.xsd:    <xs:complexType name = "CitationType"                                                                                   >
#     eml.xsd:               <xs:element     name = "citation"                     type = "cit:CitationType"                                         >
#     eml-attribute.xsd:     <xs:element     name = "citation"                     type = "cit:CitationType"                                         >
#     eml-coverage.xsd:      <xs:element     name = "timeScaleCitation"            type = "cit:CitationType" minOccurs = "0" maxOccurs = "unbounded" >
#     eml-coverage.xsd:      <xs:element     name = "classificationSystemCitation" type = "cit:CitationType"                                         >
#     eml-coverage.xsd:      <xs:element     name = "identificationReference"      type = "cit:CitationType" minOccurs = "0" maxOccurs = "unbounded" >
#     eml-literature.xsd:    <xs:element     name = "citation"                     type = "CitationType"                                             >
#     eml-methods.xsd:       <xs:element     name = "citation"                     type = "cit:CitationType" minOccurs = "0" maxOccurs = "unbounded" >
#     eml-methods.xsd:       <xs:element     name = "citation"                     type = "cit:CitationType"                                         >
#     eml-physical.xsd:      <xs:element     name = "citation"                     type = "cit:CitationType" minOccurs = "0"                         >
#     eml-project.xsd:       <xs:element     name = "citation"                     type = "cit:CitationType" minOccurs = "0" maxOccurs = "unbounded" >
#     eml-project.xsd:       <xs:element     name = "citation"                     type = "cit:CitationType" minOccurs = "0"                         >
#     eml-project.xsd:       <xs:element     name = "citation"                     type = "cit:CitationType" minOccurs = "0"                         >

# o write convenient user functions to extract citations (eml_get)
# o handle dates properly so month and year can be extracted in here (where to place? use in pubDate)

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
#' @include baseAttributes.R
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
               # volume	        optional
               # issue	        optional
               # pageRange	optional
               # publisher	optional (from responsibleParty)
               # publicationPlace       optional
               # ISSN	        optional
               # )

# article setup

setClass("article_slots",
         slots = c(journal = "character",
                   volume = "character",
                   issue = "character",
                   pageRange = "character",
                   publisher = "publisher",
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
        slots = c(publisher = "publisher",
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
     eml_citation@creator          = new("ListOfcreator", lapply(from$author, as, "creator")) # FIXME: The latex fields can be author or editor
     eml_citation@title            = from$title
     eml_citation@publisher        = as(person(from$publisher), "publisher")
     eml_citation@pubDate          = paste(from$year, from$month, sep = "-")
     eml_citation@volume           = from$volume
     eml_citation@series           = from$series
     eml_citation@publicationPlace = from$address
     eml_citation@edition          = from$edition
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

setClass("editedBook",
         contains = c("id_scope",
                      "resourceGroup",
                      "book_slots",  
                      "referencesGroup"
                      )
         )

# edited book coercion

setAs("editedBook",
      "XMLInternalElementNode",
      function(from) S4Toeml(from)
      )

setAs("XMLInternalElementNode",
      "editedBook",
      function(from) emlToS4(from)
      )

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

setAs("editedBook", "bibentry", function(from){
      entry = bibentry(bibtype = "Book", 
                       editor = as(from@creator, "person"),   
                       title  = from@title, 
                       publisher = as(from@publisher, "person"),  
                       year = from@pubDate, # FIXME: handle date properly and extract year 
                       volume = from@volume, 
                       series = from@series,
                       address = from@publicationPlace,
                       edition = from@edition,
                       month = from@pubDate, # FIXME: handle date properly and extract month
                       isbn = from@ISBN,
                       textVersion = NULL, 
                       header = paste("Citation based on eml", class(from)), 
                       footer = "---------------------------------------0")
      class(entry) = "bibentry"
      entry
      }
)

setAs("bibentry", "editedBook", function(from){
     eml_citation                  = new("editedBook")
     eml_citation@creator           = new("ListOfcreator", lapply(from$editor, as, "creator")) 
     eml_citation@title            = from$title
     eml_citation@publisher        = as(person(from$publisher), "publisher")
     eml_citation@pubDate          = paste(from$year, from$month, sep = "-")
     eml_citation@volume           = from$volume
     eml_citation@series           = from$series
     eml_citation@publicationPlace = from$address
     eml_citation@edition          = from$edition
     eml_citation@ISBN             = from$isbn
     eml_citation
     } 
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
         slots = c(chapterNumber = "character",
                   editor = "ListOfeditor",
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

# chapter coercions

setAs("chapter",
      "XMLInternalElementNode",
      function(from) S4Toeml(from)
      )

setAs("XMLInternalElementNode",
      "chapter",
      function(from) emlToS4(from)
      )

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

setAs("chapter", "bibentry", function(from){
      entry = bibentry(bibtype = "InBook", 
                       editor = as(from@editor, "person"),   
                       title  = from@title, 
                       publisher = as(from@publisher, "person"),  
                       chapter = from@pageRange, # Not exaclty right bu field required 
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

setAs("bibentry", "chapter", function(from){
     eml_citation                  = new("chapter")
     eml_citation@editor           = new("ListOfeditor", lapply(from$editor, as, "editor"))
     eml_citation@title            = from$title
     eml_citation@publisher        = as(person(from$publisher), "publisher")
     eml_citation@pubDate          = paste(from$year, from$month, sep = "-")
     eml_citation@volume           = from$volume
     eml_citation@series           = from$series
     eml_citation@publicationPlace = from$address
     eml_citation@edition          = from$edition
     eml_citation@ISBN             = from$isbn
     eml_citation
     } 
)

# Manuscript

# A sequence of (
              # institution	required	unbounded (from responsibleParty)
              # totalPages	optional
              # )

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

# coercions manuscript

setAs("manuscript",
      "XMLInternalElementNode",
      function(from) S4Toeml(from)
      )

setAs("XMLInternalElementNode",
      "manuscript",
      function(from) emlToS4(from)
      )

# bibtex unpublished
# field [required/optional] (EML)

# author [r] (creator)
# title  [r] (title)
# note   [r] (additionalInfo)

# year   [o] (pubDate)
# month  [o] (pubDate)

setAs("manuscript", "bibentry", function(from){
      entry = bibentry(bibtype = "unpublished", 
                       # required
                       author = as(from@creator, "person"),   
                       title  = from@title,  
                       # The note is quired for unpublished and is not written if character(0)
                       note = if(identical(from@additionalInfo, character(0))){"-"} else {from@additionalInfo}, 
                       # optional
                       year = from@pubDate, # FIXME: handle date properly and extract year 
                       month = from@pubDate, # FIXME: handle date properly and extract month
                       textVersion = NULL, 
                       header = paste("Citation based on eml", class(from)), 
                       footer = "---------------------------------------0")
      class(entry) = "bibentry"
      entry
      }
)

setAs("bibentry", "manuscript", function(from){
     eml_citation                  = new("manuscript")
     eml_citation@creator          = new("ListOfcreator", lapply(from$author, as, "creator"))
     eml_citation@title            = from$title
     eml_citation@additionalInfo   = from$note
     eml_citation@pubDate          = paste(from$year, from$month, sep = "-")
     eml_citation@institution      = new("ListOfinstitution")
     eml_citation
     } 
)

# Thesis

# A sequence of (
               # degree	required
               # institution	required (from responsibleParty)
               # totalPages	optional
               # )

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

# thesis coercions

setAs("thesis",
      "XMLInternalElementNode",
      function(from) S4Toeml(from)
      )

setAs("XMLInternalElementNode",
      "thesis",
      function(from) emlToS4(from)
      )

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

setAs("thesis", "bibentry", function(from){
      entry = bibentry(bibtype = "phdthesis", 
                       # required
                       author = as(from@creator, "person"), 
                       title  = from@title, 
                       school = paste(unlist(lapply(from@institution, function(x)  slot(x,"organizationName"))), collapse = ", "),
                       year = from@pubDate, # FIXME: handle date properly and extract year 
                       # optional
                       type = from@degree,
                       # address = as(from@institution, "address") # FIXME: write coercion? But no good way back from this entry to an eml address
                       month = from@pubDate, # FIXME: handle date properly and extract month
                       textVersion = NULL, 
                       header = paste("Citation based on eml", class(from)), 
                       footer = "---------------------------------------0")
      class(entry) = "bibentry"
      entry
      }
)

setAs("bibentry", "thesis", function(from){
     eml_citation                  = new("thesis")
     # required
     eml_citation@degree           = from$type
     eml_citation@institution      = new("ListOfinstitution", lapply(unlist(strsplit(from$school, ",")), function(organization) new("institution", organizationName = organization)))
     eml_citation@creator          = new("ListOfcreator", lapply(from$author, as, "creator"))
     # optional + more
     eml_citation@title            = from$title 
     eml_citation@pubDate          = paste(from$year, from$month, sep = "-") # FIXME: Handle dates properly
     eml_citation
     } 
)


# Conference proceedings
# Derived from: Chapter (by xs:extension)

# A sequence of (
               # conferenceName	        optional
               # conferenceDate	        optional
               # conferenceLocation	optional (from address)
               # )

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

# conference proceedings coercions

setAs("conferenceProceedings",
      "XMLInternalElementNode",
      function(from) S4Toeml(from)
      )

setAs("XMLInternalElementNode",
      "conferenceProceedings",
      function(from) emlToS4(from)
      )

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

setAs("conferenceProceedings", "bibentry", function(from){
      entry = bibentry(bibtype = "proceedings", 
                       # required
                       title  = from@title, 
                       year = from@conferenceDate, # FIXME: handle date properly and extract year 
                       address = as(from@conferenceLocation, "character"),
                       month = from@conferenceDate,
                       organization = from@conferenceName,
                       textVersion = NULL, 
                       header = paste("Citation based on eml", class(from)), 
                       footer = "---------------------------------------0")
      class(entry) = "bibentry"
      entry
      }
)

setAs("bibentry", "conferenceProceedings", function(from){
     eml_citation                      = new("conferenceProceedings")
     eml_citation@title                = from$title
     eml_citation@conferenceDate       = paste(from$year, from$month, sep = "-") # FIXME: handle date properly
     # eml_citation@conferenceLocation = from$adddress # FIXME: extract address from string? no good way
     eml_citation@conferenceName       = from$organization
     eml_citation
     } 
)

# Personal communication

# A sequence of (
               # publisher	        optional (from responsibleParty)
               # publicationPlace	optional
               # communication	optional
               # recipient	        optional unbounded (from responsibleParty)
               # )

setClass("personal_communication_slots",
         slots = c(publisher = "publisher",
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

# personal communication coercions

setAs("personalCommunication",
      "XMLInternalElementNode",
      function(from) S4Toeml(from)
      )

setAs("XMLInternalElementNode",
      "personalCommunication",
      function(from) emlToS4(from)
      )

# bibtex misc
# field [required/optional] (EML)
# author       [o] (creator)
# title        [o] (title)
# howpublished [o] (publisher) questionable
# month        [o] (pubDate)
# year         [o] (pubDate)
# note         [o] (additionalinfo)

setAs("personalCommunication", "bibentry", function(from){
      entry = bibentry(bibtype = "misc", 
                       author = as(from@creator, "person"),
                       title  = from@title, 
                       month = from@pubDate,
                       year = from@pubDate,
                       note = from@additionalInfo, 
                       textVersion = NULL, 
                       header = paste("Citation based on eml", class(from)), 
                       footer = "---------------------------------------0")
      class(entry) = "bibentry"
      entry
      }
)

setAs("bibentry", "personalCommunication", function(from){
     eml_citation                      = new("personalCommunication")
     eml_citation@creator              = new("ListOfcreator", lapply(from$author, as, "creator"))
     eml_citation@title                = from$title
     eml_citation@pubDate              = paste(from$year, from$month, sep = "-")
     eml_citation@additionalInfo       = from$note
     # eml_citation@publisher           
     # eml_citation@publicationPlace     
     # eml_citation@recipient
     # eml_citation@communication
     eml_citation
     } 
)

# Map

# A sequence of (
               # publisher              optional (from responsibleParty)
               # edition	        optional
               # geographicCoverage	optional unbounded (from geographicCoverage)
               # scale	                optional
               # )

setClass("map_slots",
         slots = c(publisher = "publisher",
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

# map coercions

setAs("map",
      "XMLInternalElementNode",
      function(from) S4Toeml(from)
      )

setAs("XMLInternalElementNode",
      "map",
      function(from) emlToS4(from)
      )

# bibtex misc
# field [required/optional] (EML)
# author       [o] (creator)
# title        [o] (title)
# howpublished [o] (?)
# month        [o] (pubDate)
# year         [o] (pubDate)
# note         [o] (additionalInfo)

setAs("map", "bibentry", function(from){
      entry = bibentry(bibtype = "misc", 
                       author = as(from@creator, "person"),
                       title  = from@title, 
                       month = from@pubDate,
                       year = from@pubDate,
                       note = from@additionalInfo, 
                       textVersion = NULL, 
                       header = paste("Citation based on eml", class(from)), 
                       footer = "---------------------------------------0")
      class(entry) = "bibentry"
      entry
      }
)

setAs("bibentry", "map", function(from){
     eml_citation                      = new("map")
     eml_citation@creator              = new("ListOfcreator", lapply(from$author, as, "creator"))
     eml_citation@title                = from$title
     eml_citation@pubDate              = paste(from$year, from$month, sep = "-")
     eml_citation@additionalInfo       = from$note
     # publisher              optional (from responsibleParty)
     # edition	        optional
     # geographicCoverage	optional unbounded (from geographicCoverage)
     # scale	                optional
     eml_citation
     } 
)


# Audio visual

# A sequence of (
               # publisher	        required (from responsibleParty)
               # publicationPlace	optional unbounded
               # performer	        optional unbounded (from responsibleParty)
               # ISBN	                optional
               # )

setClass("audio_visual_slots",
         slots = c(publisher = "publisher",
                   publicationPlace = "character",
                   performer = "ListOfperformer",
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

# bibtex misc
# field [required/optional] (EML)
# author       [o] (creator)
# title        [o] (title)
# howpublished [o] (?)
# month        [o] (pubDate)
# year         [o] (pubDate)
# note         [o] (additionalinfo)

setAs("audioVisual", "bibentry", function(from){
      entry = bibentry(bibtype = "misc", 
                       author = as(from@creator, "person"),
                       title  = from@title, 
                       month = from@pubDate,
                       year = from@pubDate,
                       note = from@additionalInfo, 
                       textVersion = NULL, 
                       header = paste("Citation based on eml", class(from)), 
                       footer = "---------------------------------------0")
      class(entry) = "bibentry"
      entry
      }
)

setAs("bibentry", "audioVisual", function(from){
     eml_citation                      = new("audioVisual")
     eml_citation@publisher	       = new("publisher")
     eml_citation@creator              = new("ListOfcreator", lapply(from$author, as, "creator"))
     eml_citation@title                = from$title
     eml_citation@pubDate              = paste(from$year, from$month, sep = "-")
     eml_citation@additionalInfo       = from$note
     # publicationPlace	optional unbounded
     # performer	        optional unbounded (from responsibleParty)
     # ISBN	                optional
     eml_citation
     } 
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

setClass("generic_slots",
         slots = c(publisher = "publisher",
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

# generic coercions

setAs("generic",
      "XMLInternalElementNode",
      function(from) S4Toeml(from)
      )

setAs("XMLInternalElementNode",
      "generic",
      function(from) emlToS4(from)
      )

# bibtex misc
# field [required/optional] (EML)
# author       [o] (creator)
# title        [o] (title)
# howpublished [o] (?)
# month        [o] (pubDate)
# year         [o] (pubDate)
# note         [o] (additionalInfo)

setAs("generic", "bibentry", function(from){
      entry = bibentry(bibtype = "misc", 
                       author = as(from@creator, "person"),
                       title  = from@title, 
                       month = from@pubDate,
                       year = from@pubDate,
                       note = from@additionalInfo, 
                       textVersion = NULL, 
                       header = paste("Citation based on eml", class(from)), 
                       footer = "---------------------------------------0")
      class(entry) = "bibentry"
      entry
      }
)

setAs("bibentry", "generic", function(from){
     eml_citation                      = new("generic")
     eml_citation@publisher	       = new("publisher")
     eml_citation@creator              = new("ListOfcreator", lapply(from$author, as, "creator"))
     eml_citation@title                = from$title
     eml_citation@pubDate              = paste(from$year, from$month, sep = "-")
     eml_citation@additionalInfo       = from$note
     eml_citation@ISBN                 = ""
     eml_citation
     } 
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

# generic bibentry coercion to eml citations
setAs("bibentry",
      "citation",
      function(from){ 
           type <- from$bibtype

           if(type == "Book"){
                if(!is.null(from$editor))
                     type <- "editedBook" 
           }

           if(type == "InBook"){
                type <- "chapter"
           }

           if(type == "Unpublished"){
                type <- "manuscript"
           }

           if(type == "PhdThesis"){
                type <- "thesis"
           }

           if(type == "Proceedings"){
                type <- "conferenceProceedings" 
           }

           if(type == "Misc"){
                type <- "generic" 
                warning("Cannot determine the right citation type automatically. Coerced to eml generic citation type!")
           }

           switch(type,
                  Article = as(from, "article"),
                  Book = as(from, "book"),
                  editedBook = as(from, "editedBook"),
                  chapter = as(from, "chapter"),
                  manuscript = as(from, "manuscript"),
                  thesis = as(from, "thesis"), 
                  conferenceProceedings = as(from, "conferenceProceedings"),
                  generic = as(from, "generic")
                  )
      }
)


setClass("ListOfcitation", contains="list")

#' concatenate
#' 
#' concatenate
#' @param x,... citations to concatenate
#' @param recursive Needed for compatibility with generic, otherwise ignored
#' @rdname class-citation
setMethod("c", signature("citation"), function(x, ..., recursive = FALSE) new("ListOfcitation", list(x, ...)))

# literature 

setClass("literature",
        slots = c(citation = "ListOfcitation")
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
