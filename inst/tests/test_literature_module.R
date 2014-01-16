context("Testing the literature module")

require(reml)

# Create litrature filds for reuse
a_creator = new("ListOfcreator", list(new("creator", individualName = new("individualName", givenName = "Claas-Thido", surName = "Pfaff")))) 
a_publisher = new("publisher", individualName = new("individualName", givenName = "Claas-Thido", surName = "Pfaff"))
an_editor = new("ListOfeditor", list(new("editor", individualName = new("individualName", givenName = "Claas-Thido", surName = "Pfaff")))) 

an_institution = new("ListOfinstitution", list(new("institution", organizationName = "University of Leipzig"), new("institution", organizationName = "University of Halle")))

a_conferenceName = "Some conference name"
a_conferenceDate = "19.11.2013"
a_conferenceLocation = new("address", deliveryPoint = "deliverty point", city = "city", administrativeArea = "state", postalCode = "1234567", country = "country")

an_additionalInfo = "Some additional information"

an_ISBN = "978-3-86680-192-9"  
a_title = "This is a generic reference title" 
a_bookTitle = "This is the title of a book"
a_journal = "Science"
a_publicationPlace = "Leipzig"  
a_pubDate = "19.11.2013"
an_edition = "5" 
an_issue = "1"
a_chapterNumber = "2"
a_volume = "1"
a_series = "2"
a_pageRange = "1-11"
the_totalPages = "365"
a_degree = "Dr."
a_communication_type = "email" 
a_note = "This is a generic reference note"

# Create R objects for reuse
a_person = person(given="Claas-Thido", family="Pfaff", email="test@test.com", role="cre")

## Test single fields
test_that("We can coerce a creator to a person", {
  expect_that(as(a_creator, "person"), is_a('person'))
})

test_that("We can coerce a publisher to a person", {
  expect_that(as(a_publisher, "person"), is_a('person'))
})

test_that("We can coerce a editor to a person", {
  expect_that(as(an_editor, "person"), is_a('person'))
})


test_that("We can coerce a person to creator", {
  expect_that(as(a_person, "creator"), is_a('creator'))
})

test_that("We can coerce a person to publisher", {
  expect_that(as(a_person, "publisher"), is_a('publisher'))
})

test_that("We can coerce a person to editor", {
  expect_that(as(a_person, "editor"), is_a('editor'))
})

## Test citation classes

# create an article
eml_citation = new("article")  
eml_citation@creator = a_creator 
eml_citation@title = a_title 
eml_citation@journal = a_journal 
eml_citation@pubDate = a_pubDate 
eml_citation@volume = a_volume 
eml_citation@issue = an_issue 
eml_citation@pageRange = a_pageRange 
an_article = eml_citation

test_that("We can coerce an article to bibentry", {
  expect_that(as(eml_citation, "bibentry"), is_a('bibentry')) 
})

test_that("We can coerce a bibentry to article", { 
  converted_eml_citation = as(eml_citation, "bibentry")
  expect_that(as(converted_eml_citation ,"article"), is_a('article')) 
}) 

test_that("We can coerce a article to xml", {
  expect_that(as(eml_citation, "XMLInternalElementNode"), is_a('XMLInternalElementNode'))
})

test_that("We can coerce xml to article", {
  converted_eml_citation =as(eml_citation, "XMLInternalElementNode")
  expect_that(as(converted_eml_citation, "article"), is_a('article'))
})


# create a book
eml_citation                  = new("book")
eml_citation@creator          = a_creator 
eml_citation@title            = a_title 
eml_citation@publisher        = a_publisher 
eml_citation@pubDate          = a_pubDate 
eml_citation@volume           = a_volume 
eml_citation@series           = a_series 
eml_citation@publicationPlace = a_publicationPlace 
eml_citation@edition          = an_edition
eml_citation@ISBN             = an_ISBN
a_book = eml_citation

test_that("We can coerce an book to bibentry", {
  expect_that(as(eml_citation, "bibentry"), is_a('bibentry')) 
})

test_that("We can coerce a bibentry to book", { 
  converted_eml_citation = as(eml_citation, "bibentry")
  expect_that(as(converted_eml_citation ,"book"), is_a('book')) 
}) 

test_that("We can coerce a book to xml", {
  expect_that(as(eml_citation, "XMLInternalElementNode"), is_a('XMLInternalElementNode'))
})

test_that("We can coerce xml to book", {
  converted_eml_citation =as(eml_citation, "XMLInternalElementNode")
  expect_that(as(converted_eml_citation, "book"), is_a('book'))
})

# create a chapter
eml_citation                 = new("chapter")
eml_citation@editor          = an_editor 
eml_citation@title            = a_title 
eml_citation@publisher        = a_publisher 
eml_citation@pubDate          = a_pubDate 
eml_citation@volume           = a_volume
eml_citation@series           = a_series
eml_citation@publicationPlace = a_publicationPlace 
eml_citation@edition          = an_edition
eml_citation@ISBN             = an_ISBN  
eml_citation@chapterNumber = a_chapterNumber
eml_citation@bookTitle = a_bookTitle
eml_citation@pageRange = a_pageRange
a_chapter = eml_citation

test_that("We can coerce an chapter to bibentry", {
  expect_that(as(eml_citation, "bibentry"), is_a('bibentry')) 
})

test_that("We can coerce a bibentry to chapter", { 
  converted_eml_citation = as(eml_citation, "bibentry")
  expect_that(as(converted_eml_citation ,"chapter"), is_a('chapter')) 
}) 

test_that("We can coerce a chapter to xml", {
  expect_that(as(eml_citation, "XMLInternalElementNode"), is_a('XMLInternalElementNode'))
})

test_that("We can coerce xml to chapter", {
  converted_eml_citation =as(eml_citation, "XMLInternalElementNode")
  expect_that(as(converted_eml_citation, "chapter"), is_a('chapter'))
})


# create edited book  
the_book_editor = a_creator

eml_citation                  = new("editedBook")
eml_citation@creator          = the_book_editor 
eml_citation@title            = a_title 
eml_citation@publisher        = a_publisher
eml_citation@pubDate          = a_pubDate
eml_citation@volume           = a_volume 
eml_citation@series           = a_series
eml_citation@publicationPlace = a_publicationPlace 
eml_citation@edition          = an_edition 
eml_citation@pubDate          = a_pubDate 
eml_citation@ISBN             = an_ISBN
an_editedBook = eml_citation

test_that("We can coerce an editedBook to bibentry", {
  expect_that(as(eml_citation, "bibentry"), is_a('bibentry')) 
})

test_that("We can coerce a bibentry to editedBook", { 
  converted_eml_citation = as(eml_citation, "bibentry")
  expect_that(as(converted_eml_citation ,"editedBook"), is_a('editedBook')) 
}) 

test_that("We can coerce a editedBook to xml", {
  expect_that(as(eml_citation, "XMLInternalElementNode"), is_a('XMLInternalElementNode'))
})

test_that("We can coerce xml to editedBook", {
  converted_eml_citation =as(eml_citation, "XMLInternalElementNode")
  expect_that(as(converted_eml_citation, "editedBook"), is_a('editedBook'))
})


# create new thesis
eml_citation                  = new("thesis")
eml_citation@creator          = a_creator 
eml_citation@institution      = an_institution
eml_citation@title            = a_title 
eml_citation@pubDate          = a_pubDate
eml_citation@totalPages       = the_totalPages
eml_citation@degree 	      = a_degree
a_thesis = eml_citation

test_that("We can coerce an thesis to bibentry", {
  expect_that(as(eml_citation, "bibentry"), is_a('bibentry')) 
})

test_that("We can coerce a bibentry to thesis", { 
  converted_eml_citation = as(eml_citation, "bibentry")
  expect_that(as(converted_eml_citation ,"thesis"), is_a('thesis')) 
}) 

test_that("We can coerce a thesis to xml", {
  expect_that(as(eml_citation, "XMLInternalElementNode"), is_a('XMLInternalElementNode'))
})

test_that("We can coerce xml to thesis", {
  converted_eml_citation =as(eml_citation, "XMLInternalElementNode")
  expect_that(as(converted_eml_citation, "thesis"), is_a('thesis'))
})

# create a manuscrip
eml_citation                  = new("manuscript")
eml_citation@creator          = a_creator 
eml_citation@title            = a_title 
eml_citation@pubDate          = a_pubDate
eml_citation@additionalInfo   = an_additionalInfo 
a_manuscript = eml_citation

test_that("We can coerce an manuscript to bibentry", {
  expect_that(as(eml_citation, "bibentry"), is_a('bibentry')) 
})

test_that("We can coerce a bibentry to manuscript", { 
  converted_eml_citation = as(eml_citation, "bibentry")
  expect_that(as(converted_eml_citation ,"manuscript"), is_a('manuscript')) 
}) 

test_that("We can coerce a manuscript to xml", {
  expect_that(as(eml_citation, "XMLInternalElementNode"), is_a('XMLInternalElementNode'))
})

test_that("We can coerce xml to manuscript", {
  converted_eml_citation =as(eml_citation, "XMLInternalElementNode")
  expect_that(as(converted_eml_citation, "manuscript"), is_a('manuscript'))
})


# create proceedings
eml_citation                  = new("conferenceProceedings")
eml_citation@title            = a_title
eml_citation@conferenceDate   = a_conferenceDate 
eml_citation@conferenceLocation = a_conferenceLocation 
eml_citation@conferenceName = a_conferenceName 
eml_citation@creator          = a_creator
a_conferenceProceedings = eml_citation 

test_that("We can coerce an conferenceProceedings to bibentry", {
  expect_that(as(eml_citation, "bibentry"), is_a('bibentry')) 
})

test_that("We can coerce a bibentry to conferenceProceedings", { 
  converted_eml_citation = as(eml_citation, "bibentry")
  expect_that(as(converted_eml_citation ,"conferenceProceedings"), is_a('conferenceProceedings')) 
}) 

test_that("We can coerce a conferenceProceedings to xml", {
  expect_that(as(eml_citation, "XMLInternalElementNode"), is_a('XMLInternalElementNode'))
})

test_that("We can coerce xml to conferenceProceedings", {
  converted_eml_citation =as(eml_citation, "XMLInternalElementNode")
  expect_that(as(converted_eml_citation, "conferenceProceedings"), is_a('conferenceProceedings'))
})

# create personal communication
eml_citation                = new("personalCommunication")
eml_citation@publisher      = a_publisher
eml_citation@creator        = a_creator
eml_citation@title          = a_title
eml_citation@communication  = a_communication_type
eml_citation@pubDate        = a_pubDate
eml_citation@additionalInfo = an_additionalInfo 
a_personalCommunication = eml_citation 

test_that("We can coerce an personalCommunication to bibentry", {
  expect_that(as(eml_citation, "bibentry"), is_a('bibentry')) 
})

test_that("We can coerce a bibentry to personalCommunication", { 
  converted_eml_citation = as(eml_citation, "bibentry")
  expect_that(as(converted_eml_citation ,"personalCommunication"), is_a('personalCommunication')) 
}) 

test_that("We can coerce a personalCommunication to xml", {
  expect_that(as(eml_citation, "XMLInternalElementNode"), is_a('XMLInternalElementNode'))
})

test_that("We can coerce xml to personalCommunication", {
  converted_eml_citation =as(eml_citation, "XMLInternalElementNode")
  expect_that(as(converted_eml_citation, "personalCommunication"), is_a('personalCommunication'))
}) 

# create a map
eml_citation                = new("map")
eml_citation@creator        = a_creator
eml_citation@title          = a_title
eml_citation@pubDate        = a_pubDate
eml_citation@additionalInfo = a_note
a_map = eml_citation

test_that("We can coerce an map to bibentry", {
  expect_that(as(eml_citation, "bibentry"), is_a('bibentry')) 
})

test_that("We can coerce a bibentry to map", { 
  converted_eml_citation = as(eml_citation, "bibentry")
  expect_that(as(converted_eml_citation ,"map"), is_a('map')) 
}) 

test_that("We can coerce a map to xml", {
  expect_that(as(eml_citation, "XMLInternalElementNode"), is_a('XMLInternalElementNode'))
})

test_that("We can coerce xml to map", {
  converted_eml_citation =as(eml_citation, "XMLInternalElementNode")
  expect_that(as(converted_eml_citation, "map"), is_a('map'))
}) 

# create a audioVisual
eml_citation                = new("audioVisual")
eml_citation@publisher      = a_publisher
eml_citation@creator        = a_creator
eml_citation@title          = a_title
eml_citation@pubDate        = a_pubDate
eml_citation@additionalInfo = a_note
a_audioVisual = eml_citation 

test_that("We can coerce an audioVisual to bibentry", {
  expect_that(as(eml_citation, "bibentry"), is_a('bibentry')) 
})

test_that("We can coerce a bibentry to audioVisual", { 
  converted_eml_citation = as(eml_citation, "bibentry")
  expect_that(as(converted_eml_citation ,"audioVisual"), is_a('audioVisual')) 
}) 

test_that("We can coerce a audioVisual to xml", {
  expect_that(as(eml_citation, "XMLInternalElementNode"), is_a('XMLInternalElementNode'))
})

test_that("We can coerce xml to audioVisual", {
  converted_eml_citation =as(eml_citation, "XMLInternalElementNode")
  expect_that(as(converted_eml_citation, "audioVisual"), is_a('audioVisual'))
}) 

# create a generic
eml_citation                = new("generic")
eml_citation@publisher      = a_publisher 
eml_citation@creator        = a_creator 
eml_citation@title          = a_title 
eml_citation@pubDate        = a_pubDate 
eml_citation@additionalInfo = a_note 
eml_citation@ISBN           = an_ISBN 
a_generic = eml_citation

test_that("We can coerce an generic to bibentry", {
  expect_that(as(eml_citation, "bibentry"), is_a('bibentry')) 
})

test_that("We can coerce a bibentry to generic", { 
  converted_eml_citation = as(eml_citation, "bibentry")
  expect_that(as(converted_eml_citation ,"generic"), is_a('generic')) 
}) 

test_that("We can coerce a generic to xml", {
  expect_that(as(eml_citation, "XMLInternalElementNode"), is_a('XMLInternalElementNode'))
})

test_that("We can coerce xml to generic", {
  converted_eml_citation =as(eml_citation, "XMLInternalElementNode")
  expect_that(as(converted_eml_citation, "generic"), is_a('generic'))
}) 

# test generic coercion from bibentry to eml citation

# conferenceProceedings, personalCommunication, map, audioVisual, generic 

test_that("We auto coerce article to bibentry", {
  expect_that(as(an_article, "bibentry"), is_a('bibentry'))
})  

test_that("We auto coerce book to bibentry", {
  expect_that(as(a_book, "bibentry"), is_a('bibentry'))
}) 

test_that("We auto coerce chapter to bibentry", {
  expect_that(as(a_chapter, "bibentry"), is_a('bibentry'))
}) 

test_that("We auto coerce editedBook to bibentry", {
  expect_that(as(an_editedBook, "bibentry"), is_a('bibentry'))
}) 

test_that("We auto coerce thesis to bibentry", {
  expect_that(as(a_thesis, "bibentry"), is_a('bibentry'))
})  

test_that("We auto coerce manuscript to bibentry", {
  expect_that(as(a_manuscript, "bibentry"), is_a('bibentry'))
}) 

test_that("We auto coerce conferenceProceedings to bibentry", {
  expect_that(as(a_conferenceProceedings, "bibentry"), is_a('bibentry'))
}) 

test_that("We auto coerce personalCommunication to bibentry", {
  expect_that(as(a_personalCommunication, "bibentry"), is_a('bibentry'))
})  

test_that("We auto coerce audioVisual to bibentry", {
  expect_that(as(an_audioVisual, "bibentry"), is_a('bibentry'))
}) 

test_that("We auto coerce generic to bibentry", {
  expect_that(as(a_generic, "bibentry"), is_a('bibentry'))
})  

# test special cases audio visual, map, personal communication  

a_personalCommunication_bibitem = as(a_personalCommunication, "bibentry")

test_that("We warn if we coerce a bibentry of personal communication to generic if we cannot check the right type of eml citation", {
  expect_that(as(a_personalCommunication_bibitem, "citation"), gives_warning())
}) 

a_map_bibitem = as(a_map, "bibentry")

test_that("We warn if we coerce a bibentry of map to generic if we cannot check the right type of eml citation", {
  expect_that(as(a_map_bibitem, "citation"), gives_warning())
}) 

a_audioVisual_bibitem = as(a_audioVisual, "bibentry")

test_that("We warn if we coerce a bibentry of personal communication to generic if we cannot check the right type of eml citation", {
  expect_that(as(a_audioVisual_bibitem, "citation"), gives_warning())
})  

# test the book and edited book switch

test_that("We automatically choose book if editor is not given", {
  a_book_bibitem = as(a_book, "bibentry")
  expect_that(as(a_book_bibitem, "citation"), is_a("book"))
})  

test_that("We automatically choose edited book if editor field is given", {
  a_book_bibitem = as(a_book, "bibentry")
  a_book_bibitem$editor = "Claas-Thido Pfaff"
  expect_that(as(a_book_bibitem, "citation"), is_a("editedBook"))
})  
