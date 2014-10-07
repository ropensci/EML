#' eml online validation tool
#' 
#' Programmatic interface to the online parsing tool https://knb.ecoinformatics.org/emlparser/parse
#' @param eml path to an eml file or text of eml file
#' @param ... additional arguments to formQuery
#' @param schema_only logical, use schema-only validation tests. 
#'  will also be used as the fallback mechanism if RHTMLForms is unavailable.  
#' @return Two logicals indicating if we pass schema validation tests and id/referencing tests.  
#' @details More detailed testing against the schema can be performed using the xmlSchemaValidate
#'   function from the XML package, which will report information on exactly what lines fail the 
#'   test, if any.  However, this performs only the first of the two checks provided by the online
#'   tool, which also checks that all referenced internal ids (describes nodes) correspond to matching ids.  
#' 
#'   This function requires an internet connection.
#' @import RCurl
#' @import XML
#' @author Duncan Temple Lang
#' @export
eml_validate <-
function (eml = "", 
          ..., 
          schema_only = FALSE) 
{

          ## Should be part of the function arguments, but plays havoc with silly roxygen at this time...
          .url = "https://knb.ecoinformatics.org/emlparser/parse"
          .reader = processValidationResponse 
          .formDescription = structure(list(formAttributes = 
                                            structure(c("post", 
                                                        "https://knb.ecoinformatics.org/emlparser/parse"), 
                                                      .Names = c("method", "action"), class = "HTMLFormAttributes"),
                                            elements = 
                                            structure(list(action = structure(list(name = "action", 
                                                                                   value = "textparse"), 
                                                                              .Names = c("name", "value"), 
                                                                              class = c("HTMLHiddenElement", "HTMLFormElement")), 
                                                           doctext = structure(list(name = "doctext", 
                                                                                    nodeAttributes = 
                                                                                    structure(c("doctext", "65", "15"), 
                                                                                              .Names = c("name", "cols", "rows")), 
                                                                                    defaultValue = ""), 
                                                                               .Names = c("name", "nodeAttributes", "defaultValue"),
                                                                               class = c("HTMLTextAreaElement", "HTMLFormElement"))),
                                                      .Names = c("action", "doctext"), 
                                                      class = "HTMLFormElementsList"), 
                                            url = structure("https://knb.ecoinformatics.org/emlparser/parse", 
                                                            .Names = "action")), 
                                       .Names = c("formAttributes", "elements", "url"), 
                                       class = "HTMLFormDescription") 
          .opts = structure(list(referer = "https://knb.ecoinformatics.org/emlparser/parse"), 
                            .Names = "referer")
          style = "POST" 
          .curl = getCurlHandle()
          .cleanArgs = NULL
## attempt to use XMLSchemaValidate here if RHTMLForms isn't available?  

  doctext <- saveXML(xmlParse(eml)) # xmlParse will take text or filename equally happily.  We need text.  


  # CRAN will WARN since RHTMLForms isn't on CRAN (and hence not on the SUGGESTS list).  Well, let it, because
  # that is just stupid. 
  success <- TRUE
  if(!schema_only)
    success <- require("RHTMLForms", character.only = TRUE, quietly = TRUE)

  

  if(!success | schema_only){
    message("Performing XML Schema validation only.\n
            Install RHTMLForms to provide additional EML-specific tests.")

    ## Use the Github copy since installing the xsd files makes package > 1 MB.  
    out <- xmlSchemaValidate("http://ropensci.github.io/EML/eml.xsd", doctext)
#    out <- xmlSchemaValidate(system.file("xsd", "eml.xsd", package="EML"), doctext)



    if(out$status == 0) 
      TRUE
    else 
      out$errors
#      stop("RHTMLForms package must be installed to use this function.  Visit http://www.omegahat.org for more")
  } else { 



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
}

processValidationResponse =
function(txt, doc = htmlParse(txt, asText = TRUE))
{
  ans = xpathSApply(doc, "//h2 | //h4", xmlValue)
  tmp = strsplit(ans, ": ")
  ans = structure(gsub("\\.$", "", sapply(tmp, `[`, 2)),
                  names = sapply(tmp, `[`, 1))

  status = ans == "Passed"

  if(!all(status)) {
     nodes = getNodeSet(doc, "//h2 | //h4")[!status]
     msgs = lapply(nodes, function(node) {
                     tmp = getNodeSet(node, "./following-sibling::*")
                     i = sapply(tmp, xmlName) == "hr"
                     sapply(tmp[2:(which(i) - 1)], xmlValue)
                   })
     structure(msgs, names = names(ans)[!status])
  } else
     status
  
}



