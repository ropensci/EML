## Seems we really lack a good, fast, generic way to find-and-replace arbitrary nodes in XML..

## should identify all ReferencesGroup elements, and replace them with copy of the
## node that they reference.
resolve_references <- function(eml){
  ## Ideally, just do this all in XML manipulation. Serialize to XML, substitute, and then re-parse.
  doc = XML::xmlParse(write_eml(eml))
  ## FIXME: Would need to do xmlRoot and then find all <references> recursively.  whoops.
  ## This is just a copy of the nodes; changing these values doesn't change `doc`
  refs <- XML::xpathApply(doc, "//references")

  replace <- lapply(refs, function(ref){
    id <- xmlValue(ref)
    nodes <- XML::xpathApply(doc, sprintf("//*[@id = '%s']", id))
  })

}
