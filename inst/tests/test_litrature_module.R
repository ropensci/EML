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
a_title = "This is a normal title" 
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
