eml_namespaces = c(eml = "//ecoinformatics.org/eml-2.1.1", 
                   ds = "//ecoinformatics.org/dataset-2.1.1",
                   xs = "http://www.w3.org/2001/XMLSchema",
                   xsi = "http://www.w3.org/2001/XMLSchema-instance",
                   stmml = "http://www.xml-cml.org/schema/stmml-1.1")

setClass("eml",
         representation(packageId   = "character", 
                        system      = "character", 
                        namespaces  = "character",
                        dataset     = "dataset",
                        additionalMetadata = "additionalMetadata"),
          prototype = prototype(packageId = paste(sep='', "urn:uuid:", uuid::UUIDgenerate()),
                                system = 'uuid',
                                namespaces = eml_namespaces))
setAs("XMLInternalElementNode", "eml", function(from) emlToS4(from))

