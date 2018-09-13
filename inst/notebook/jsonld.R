library(jsonld)
library(magrittr)

eml <-
  '{
  "@context": {"eml": "http://eml.org/"},
  "eml:coverage": {
    "eml:geographicCoverage": {
      "eml:geographicDescription": "Northwest Oregon",
        "eml:boundingCoordinates": {
        "eml:westBoundingCoordinate": "-124.07",
        "eml:eastBoundingCoordinate": "-123.22",
        "eml:northBoundingCoordinate": "45.53",
        "eml:southBoundingCoordinate": "44.47"
        }
      }
    }
  }'
jsonld_expand(eml) %>% jsonld_compact('{"@context": {"eml": "http://eml.org/"}}')

frame <- '
{
  "@context": {
    "eml": "http://eml.org/"
  },
  "eml:geographicCoverage": {
      "@explicit": "true",
      "eml:geographicDescription": {}
  }
}
'
jsonld_frame(eml, frame) %>% jsonld_compact('{"@context": {"eml": "http://eml.org/"}}')

x <-
'{"@context": {
  "coverage": "x:coverage",
  "geographicCoverage": "x:geographicCoverage",
  "geographicDescription": "x:geographicDescription"
},
"coverage": {
"geographicCoverage": {
"geographicDescription": "Northwest Oregon"
}
}
}'

f <- '{
  "@explicit": "true",
  "geographicCoverage": {
    "@explicit": "true",
    "geographicDescription": {}
  }
}'

jsonld_frame(x,f) %>%
jsonld_compact('{"@context": {
  "coverage": "x:coverage",
  "geographicCoverage": "x:geographicCoverage",
  "geographicDescription": "x:geographicDescription"
}}')



eml <-
'{
"@context": {"schema": "http://schema.org",
             "coverage": "schema:dataset"
             "geographicCoverage": "schema:spatialCoverage",
             "geographicDescription": "schema:description"
             },
"coverage": {
"geographicCoverage": {
"geographicDescription": "Northwest Oregon"
}
}
}'
jsonld_expand(eml) %>% jsonld_compact(
'{
"@context": {
  "eml": "http://eml.org/",
  "schema": "http://schema.org/",
  "eml:geographicDescription": "schema:description"
}}')

frame <- '
{
"@context": {
"eml": "http://eml.org/"
},
"eml:geographicCoverage": {
"@explicit": "true",
"eml:geographicDescription": {}
}
}
'
jsonld_frame(eml, frame) %>% jsonld_compact('{"@context": {"eml": "http://eml.org/"}}')







frame <-
'{
  "@context": {
    "schema": "http://schema.org/",
    "eml": "http://eml.org/",
    "eml:geographicCoverage": "schema:spatialCoverage"
  },
  "schema:spatialCoverage": {
    "schema:description": "eml:geographicDescription",
    "schema:geo": {
      "schema:box": {"eml:westBoundingCoordinate": "@value"}
    }
  }
}'

jsonld_frame(eml, frame)

