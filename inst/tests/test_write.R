context("write")

test_that("We can parse XML written by reml",{

  dat = data.frame(river=c("SAC", "SAC", "AM"),
                        spp = c("king", "king", "ccho"),
                        stg = c("smolt", "parr", "smolt"),
                        ct =  c(293L, 410L, 210L))
  col_metadata = c(river = "http://dbpedia.org/ontology/River",
                   spp = "http://dbpedia.org/ontology/Species",
                   stg = "Life history stage",
                   ct = "count")
  unit_metadata =
     list(river = c(SAC = "The Sacramento River", AM = "The American River"),
          spp = c(king = "King Salmon", ccho = "Coho Salmon"),
          stg = c(parr = "third life stage", smolt = "fourth life stage"),
          ct = "number")

  eml_write(dat, col_metadata, unit_metadata, file="my_eml_data.xml")

  require(XML)
  doc <- xmlParse("my_eml_data.xml")

  expect_that(class(doc), equals(c("XMLInternalDocument", "XMLAbstractDocument")))
})



test_that("Column names written into EML match those given", {
  dat = data.frame(river=c("SAC", "SAC", "AM"),
                        spp = c("king", "king", "ccho"),
                        stg = c("smolt", "parr", "smolt"),
                        ct =  c(293L, 410L, 210L))
  col_metadata = c(river = "http://dbpedia.org/ontology/River",
                   spp = "http://dbpedia.org/ontology/Species",
                   stg = "Life history stage",
                   ct = "count")
  unit_metadata =
     list(river = c(SAC = "The Sacramento River", AM = "The American River"),
          spp = c(king = "King Salmon", ccho = "Coho Salmon"),
          stg = c(parr = "third life stage", smolt = "fourth life stage"),
          ct = "number")

  eml_write(dat, col_metadata, unit_metadata, file="my_eml_data.xml")

  require(XML)
  doc <- xmlParse("my_eml_data.xml")
  csv_xpath <- "//physical[.//simpleDelimited[fieldDelimiter = ',']]/parent::dataTable"
  colNames <- xpathSApply(doc, paste0(csv_xpath, "/attributeList/attribute/attributeName"), xmlValue)

  expect_that(colNames, equals(names(dat)))
})
