library(reml)
## Define the data and metadata
dat = data.set(spp   = c("king",  "ccho"),
               temp    = c(24,   20),
               col.defs = c("Species common name",
                            "temperature at which maximum growth occurs"),
               unit.defs = list(c(king = "King Salmon", 
                                  ccho = "Coho Salmon"),
                                c(unit = "celsius", precision=1)))

## Define the semantics
require(XML)
rdfa <- newXMLNode("subject", 
                        attrs=c(about="http://example.org#1838"), 
                        namespaceDefinitions = c(o="http://oboe-core#"), 
                        .children = list(
             newXMLNode("meta", attrs = c(property="o:entity", content="Water", datatype="xsd:string")),
             newXMLNode("meta", attrs = c(property="o:characteristic", content="Temperature", datatype="xsd:string")),
             newXMLNode("meta", attrs = c(property="o:unit", content="Celsius", datatype="xsd:string"))
            ))

## clean up this interaface for adding additionalMetadata! 
eml <- eml(dat,          
           creator="Carl Boettiger <cboettig@ropensci.org>", 
           additionalMetadata = new("ListOfadditionalMetadata", 
                                   list(new("additionalMetadata", 
                                            metadata = new("metadata", rdfa)))))

eml_write(eml, file = "test.xml")


## Explore the eml directly -- some functions could help here.  
eml <- read.eml("test.xml")
class(eml@additionalMetadata[[1]]@metadata) # it's XML!
## treat as an xmlDoc, e.g. for XPath
meta <- xmlDoc(eml@additionalMetadata[[1]]@metadata)
xpathSApply(meta, "//meta[@property='o:unit']", xmlAttrs)
free(meta) # free external pointers...

## Extract the RDF
library(httr)
response <- POST("http://rdf-translator.appspot.com/convert/rdfa/xml/content", 
                  body = list(content = upload_file('test.xml')))
doc <- content(response, "parsed", "text/xml")

## Explore RDF with XPath -- NOTE this is an RDF file, not the same as `meta` XML above!!  Note the simpler xpath:
xpathSApply(doc, "//o:unit", xmlValue)

## Explore RDF with SPARQL
library(rrdf)
saveXML(doc, "rdf.xml") # load.rdf requires external file currently...
rdf <- load.rdf("rdf.xml") 
## Make a (dumb) sparql query 
out <- sparql.rdf(rdf, "SELECT ?unit WHERE { ?x <http://oboe-core#unit> ?unit}")


## clean up.  
unlink('test.xml')



