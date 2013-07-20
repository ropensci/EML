if(FALSE) {
library(RHTMLForms)
ff = getHTMLFormDescription("http://knb.ecoinformatics.org/emlparser/")
eml_validate = createFunction(ff[[2]], reader = processValidationResponse)

# printing eml_validate to include as source code below currently
# loses the class information on the .formDescription default value
# and that causes checkFormArgs to complain.

library(XML)
txt = saveXML(xmlParse("http://knb.ecoinformatics.org/emlparser/eml-sample.xml"))
o = eml_validate(txt)
#hdoc = htmlParse(o)
#xpathSApply(hdoc, "//h2")

sampleDoc = xmlParse("http://knb.ecoinformatics.org/emlparser/eml-sample.xml")
r = xmlRoot(sampleDoc)
newXMLNode("garbage", parent = r)
newXMLNode("otherNonsense", parent = r)

o = eml_validate(saveXML(sampleDoc))
#hdoc = htmlParse(o)
#xpathSApply(hdoc, "//h2")
}

eml_validate <-
function (doctext = "", .url = "http://knb.ecoinformatics.org/emlparser/parse", 
    ..., .reader = processValidationResponse, .formDescription = structure(list(formAttributes = structure(c("post", "http://knb.ecoinformatics.org/emlparser/parse"
), .Names = c("method", "action"), class = "HTMLFormAttributes"), 
    elements = structure(list(action = structure(list(name = "action", 
        value = "textparse"), .Names = c("name", "value"), class = c("HTMLHiddenElement", 
    "HTMLFormElement")), doctext = structure(list(name = "doctext", 
        nodeAttributes = structure(c("doctext", "65", "15"), .Names = c("name", 
        "cols", "rows")), defaultValue = ""), .Names = c("name", 
    "nodeAttributes", "defaultValue"), class = c("HTMLTextAreaElement", 
    "HTMLFormElement"))), .Names = c("action", "doctext"), class = "HTMLFormElementsList"), 
    url = structure("http://knb.ecoinformatics.org/emlparser/parse", .Names = "action")), .Names = c("formAttributes", 
           "elements", "url"), class = "HTMLFormDescription"), 
    .opts = structure(list(referer = "http://knb.ecoinformatics.org/emlparser/parse"), 
        .Names = "referer"), style = "POST", .curl = getCurlHandle(), 
    .cleanArgs = NULL) 
{
    library(RHTMLForms)
    library(RCurl)
    args = list(doctext = doctext)
    if (!length(.url)) 
        stop("no url supplied")
    ans = formQuery(args, .url, .formDescription, ..., .opts = .opts, 
        .addSubmit = TRUE, curl = .curl, .extraArgs = c(), style = style, 
        .cleanArgs = .cleanArgs)
    if (!is.null(.reader) && is.function(.reader)) {
        if (!inherits(.reader, "AsIs")) 
            ans = .reader(ans)
        else {
            if (inherits(.reader, "HTMLParseHandlerGenerator")) 
                .reader = .reader()
            ans = htmlTreeParse(ans, asText = TRUE, handlers = .reader)
            if (inherits(ans, "HTMLParseHandler")) 
                ans = ans$value()
        }
    }
    ans
}

processValidationResponse =
function(txt, doc = htmlParse(txt, asText = TRUE))
{
  ans = xpathSApply(doc, "//h2", xmlValue)
  tmp = strsplit(ans, ": ")
  ans = structure(gsub("\\.$", "", sapply(tmp, `[`, 2)),
                  names = sapply(tmp, `[`, 1))

  status = ans == "Passed"

  if(!all(status)) {
     nodes = getNodeSet(doc, "//h2")[!status]
     msgs = lapply(nodes, function(node) {
                     tmp = getNodeSet(node, "./following-sibling::*")
                     i = sapply(tmp, xmlName) == "hr"
                     sapply(tmp[2:(which(i) - 1)], xmlValue)
                   })
     structure(msgs, names = names(ans)[!status])
  } else
     status
  
}
