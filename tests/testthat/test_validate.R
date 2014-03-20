context("external validator")


test_that("External validator works using RHTMLForms", {
  ff = getHTMLFormDescription("http://knb.ecoinformatics.org/emlparser/")
#eml_validate = createFunction(ff[[2]], reader = processValidationResponse) # failing...

# printing eml_validate to include as source code below currently
# loses the class information on the .formDescription default value
# and that causes checkFormArgs to complain.

  library(XML)
  library(EML)
## A case that should validate
  txt = saveXML(xmlParse("http://knb.ecoinformatics.org/emlparser/eml-sample.xml"))
  o = eml_validate(txt)
#hdoc = htmlParse(o)
#xpathSApply(hdoc, "//h2")


## A case that should fail validation
  sampleDoc = xmlParse("http://knb.ecoinformatics.org/emlparser/eml-sample.xml")
  r = xmlRoot(sampleDoc)
  newXMLNode("garbage", parent = r)
  newXMLNode("otherNonsense", parent = r)

  o = eml_validate(saveXML(sampleDoc))

## 

#hdoc = htmlParse(o)
#xpathSApply(hdoc, "//h2")

})
