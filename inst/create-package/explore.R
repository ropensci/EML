

shrink <- function(l) {
  l[sapply(l, length) > 0]
}
#
#
all <- paste0("inst/xsd/", collate)


all %>% map(function(x) {
  xsd = read_xml(x)
  xml_find_all(xsd, "//xs:sequence[@maxOccurs]", ns)
}) %>% shrink()

## Prove xs:all is never used:
all %>% map(function(x) {
  xsd = read_xml(x)
  xml_find_all(xsd, "//xs:complexType/xs:all", ns)
}) %>% shrink()

star <- "[child::xs:choice | child::xs:sequence]"

## All complex types that have a child either a choice or sequence
all %>% map(function(x) {
  xsd = read_xml(x)

  xml_find_all(xsd, paste0("//xs:complexType", star), ns)
}) %>%
  shrink()

## complexType/choice
## all xs:choice or xs:sequence with parent who is xs:complexType/xs:choice
all %>% map(function(x) {
  xsd = read_xml(x)

  xml_find_all(xsd, paste0("//xs:complexType", star, "/*", star), ns)
}) %>%
  shrink()

## complexType/choice/choice
## Depth 2.  all xs:choice or xs:sequence whose parent is also xs:choice/seq whose parent is complexType
all %>% map(function(x) {
  xsd = read_xml(x)

  xml_find_all(xsd,
               paste0("//xs:complexType", star, "/*", star, "/*", star),
               ns)
}) %>%
  shrink()

## complexType/choice/choice/choice
all %>% map(function(x) {
  xsd = read_xml(x)

  xml_find_all(xsd,
               paste0("//xs:complexType", star, "/*", star, "/*", star, "/*", star),
               ns)
}) %>%
  shrink()
