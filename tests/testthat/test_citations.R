context("citations")

test_that("we can write EML to bibtex and vice versa", {

library("bibtex"); library("EML"); library("RefManageR"); # get a citation from a crossref query
  a_citation =  ReadCrossRef(query = 'Boettiger early warning', limit = 1, year="2013")

# library("rcrossref") 
# a_citation = cr_cn("10.1098/rspb.2013.1372", 'bibentry')

# Format the citation for EML and write to file
  eml_write(citation = a_citation, file="example.xml")

# That gives us a valid EML file containing a single (top-level) citation.  
# We can extract citation data from EML files and turn it into BibTeX:
  eml <- eml_read("example.xml")

# Extract the citation and convert to R's native citation format
  bib <- as(eml@citation, "bibentry") 
  write.bib(bib, "example.bib")

  expect_is(bib, "bibentry")  
    
unlink("example.xml")
unlink("example.bib")

})
