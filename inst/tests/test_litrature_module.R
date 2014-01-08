context("Testing the litrature module")

require(reml)

# Create litrature filds for reuse
a_creator = new("ListOfcreator", list(new("creator", individualName = new("individualName", givenName = "Claas-Thido", surName="Pfaff")))) 
a_publisher = new("publisher", individualName = new("individualName", givenName = "Test"))

a_publicationPlace = "Leipzig" 
an_ISBN = "978-3-86680-192-9"  
a_title = "The Article Title" 
a_journal = "Science"
a_pubDate = "19.11.2013"
an_edition = "5" 
an_issue = "1"
a_volume = "1"
a_series = "2"
a_pageRange = "1-11"

# Create R objects for reuse
a_person = person(given="Claas-Thido", family="Pfaff", email="test@test.com", role="cre")

## Test single fields
test_that("We can coerce a creator to a person", {
  expect_that(as(a_creator, "person"), is_a('person'))
})

test_that("We can coerce a publisher to a person", {
  expect_that(as(a_publisher, "person"), is_a('person'))
})

test_that("We can coerce a person to creator", {
  expect_that(as(a_person, "creator"), is_a('creator'))
})

test_that("We can coerce a person to publisher", {
  expect_that(as(a_person, "publisher"), is_a('publisher'))
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
  expect_that(as(eml_citation, "bibentry"), is_a('bibentry')) 
}) 

test_that("We can coerce a article to xml", {
  expect_that(as(eml_citation, "XMLInternalElementNode"), is_a('XMLInternalElementNode'))
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
  expect_that(as(eml_citation, "bibentry"), is_a('bibentry')) 
}) 

test_that("We can coerce a book to xml", {
  expect_that(as(eml_citation, "XMLInternalElementNode"), is_a('XMLInternalElementNode'))
})




