
# EML <img src="man/figures/logo.svg" align="right" alt="" width="120" />

[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://lifecycle.r-lib.org/articles/stages.html)
[![Build
Status](https://travis-ci.org/ropensci/EML.svg?branch=master)](https://travis-ci.org/ropensci/EML)
[![Windows build
status](https://ci.appveyor.com/api/projects/status/u2gw24yfkvxgny96?svg=true)](https://ci.appveyor.com/project/cboettig/eml)
[![codecov](https://codecov.io/gh/ropensci/EML/branch/master/graph/badge.svg)](https://codecov.io/gh/ropensci/EML)
[![CRAN
status](https://www.r-pkg.org/badges/version/EML)](https://cran.r-project.org/package=EML)
![downloads](http://cranlogs.r-pkg.org/badges/grand-total/RNeXML)
[![DOI](https://zenodo.org/badge/10894022.svg)](https://zenodo.org/badge/latestdoi/10894022)

<!-- README.md is generated from README.Rmd. Please edit that file -->

EML is a widely used metadata standard in the ecological and
environmental sciences. We strongly recommend that interested users
visit the [EML Homepage](https://eml.ecoinformatics.org/) for an
introduction and thorough documentation of the standard. Additionally,
the scientific article *[The New Bioinformatics: Integrating Ecological
Data from the Gene to the Biosphere (Jones et
al 2006)](https://doi.org/10.1146/annurev.ecolsys.37.091305.110031)*
provides an excellent introduction into the role EML plays in building
metadata-driven data repositories to address the needs of highly
heterogeneous data that cannot be easily reduced to a traditional
vertically integrated database. At this time, the `EML` R package
provides support for the serializing and parsing of all low-level EML
concepts, but still assumes some familiarity with the EML standard,
particularly for users seeking to create their own EML files. We hope to
add more higher-level functions which will make such familiarity less
essential in future development.

## Notes on the EML v2.0 Release

`EML` v2.0 is a complete re-write which aims to provide both a drop-in
replacement for the higher-level functions of the existing EML package
while also providing additional functionality. This new `EML` version
uses only simple and familiar list structures (S3 classes) instead of
the more cumbersome use of S4 found in the original `EML`. While the
higher-level functions are identical, this makes it easier to for most
users and developers to work with `eml` objects and also to write their
own functions for creating and manipulating EML objects. Under the hood,
`EML` relies on the [emld](https://github.com/ropensci/emld/) package,
which uses a Linked Data representation for EML. It is this approach
which lets us combine the simplicity of lists with the specificity
required by the XML schema.

This revision also supports the **[recently released EML 2.2.0
specification](https://eml.ecoinformatics.org/whats-new-in-eml-2-2-0.html)**.

# Creating EML

``` r
library(EML)
```

## A minimal valid EML document:

``` r
me <- list(individualName = list(givenName = "Carl", surName = "Boettiger"))
my_eml <- list(dataset = list(
              title = "A Minimal Valid EML Dataset",
              creator = me,
              contact = me)
            )


write_eml(my_eml, "ex.xml")
#> NULL
eml_validate("ex.xml")
#> [1] TRUE
#> attr(,"errors")
#> character(0)
```

## A Richer Example

Here we show the creation of a relatively complete EML document using
`EML`. This closely parallels the function calls shown in the original
EML [R-package
vignette](https://docs.ropensci.org/EML/articles/creating-EML.html).

## `set_*` methods

The original EML R package defines a set of higher-level `set_*` methods
to facilitate the creation of complex metadata structures. `EML`
provides these same methods, taking the same arguments for
`set_coverage`, `set_attributes`, `set_physical`, `set_methods` and
`set_textType`, as illustrated here:

### Coverage metadata

``` r
geographicDescription <- "Harvard Forest Greenhouse, Tom Swamp Tract (Harvard Forest)"
coverage <- 
  set_coverage(begin = '2012-06-01', end = '2013-12-31',
               sci_names = "Sarracenia purpurea",
               geographicDescription = geographicDescription,
               west = -122.44, east = -117.15, 
               north = 37.38, south = 30.00,
               altitudeMin = 160, altitudeMaximum = 330,
               altitudeUnits = "meter")
```

### Reading in text from Word and Markdown

We read in detailed methods written in a Word doc. This uses EML’s
docbook-style markup to preserve formatting of paragraphs, lists,
titles, and so forth. (This is a drop-in replacement for EML
`set_method()`)

``` r
methods_file <- system.file("examples/hf205-methods.docx", package = "EML")
methods <- set_methods(methods_file)
```

We can also read in text that uses Markdown for markup elements:

``` r
abstract_file <-  system.file("examples/hf205-abstract.md", package = "EML")
abstract <- set_TextType(abstract_file)
```

### Attribute Metadata from Tables

Attribute metadata can be verbose, and is often defined in separate
tables (e.g. separate Excel sheets or `.csv` files). Here we use
attribute metadata and factor definitions as given from `.csv` files.

``` r
attributes <- read.table(system.file("extdata/hf205_attributes.csv", package = "EML"))
factors <- read.table(system.file("extdata/hf205_factors.csv", package = "EML"))
attributeList <- 
  set_attributes(attributes, 
                 factors, 
                 col_classes = c("character", 
                                 "Date",
                                 "Date",
                                 "Date",
                                 "factor",
                                 "factor",
                                 "factor",
                                 "numeric"))
```

### Data file format

Though the `physical` metadata specifying the file format is extremely
flexible, the `set_physical` function provides defaults appropriate for
`.csv` files. DEVELOPER NOTE: ideally the `set_physical` method should
guess the appropriate metadata structure based on the file extension.

``` r
physical <- set_physical("hf205-01-TPexp1.csv")
```

## Generic construction

In the `EML` R package, objects for which there is no `set_` method are
constructed using the `new()` S4 constructor. This provided an easy way
to see the list of available slots. In `eml2`, all objects are just
lists, and so there is no need for special methods. We can create any
object directly by nesting lists with names corresponding to the EML
elements. Here we create a `keywordSet` from scratch:

``` r
keywordSet <- list(
    list(
        keywordThesaurus = "LTER controlled vocabulary",
        keyword = list("bacteria",
                    "carnivorous plants",
                    "genetics",
                    "thresholds")
        ),
    list(
        keywordThesaurus = "LTER core area",
        keyword =  list("populations", "inorganic nutrients", "disturbance")
        ),
    list(
        keywordThesaurus = "HFR default",
        keyword = list("Harvard Forest", "HFR", "LTER", "USA")
        ))
```

Of course, this assumes that we have some knowledge of what the possible
terms permitted in an EML keywordSet are\! Not so useful for novices. We
can get a preview of the elements that any object can take using the
`emld::template()` option, but this involves a two-part workflow.
Instead, `eml2` provides generic `construct` methods for all objects.

## Constructor methods

For instance, the function `eml$creator()` has function arguments
corresponding to each possible slot for a creator. This means we can
rely on *tab completion* (and/or autocomplete previews in RStudio) to
see what the possible options are. `eml$` functions exist for all
complex types. If `eml$` does not exist for an argument (e.g. there is
no `eml$givenName`), then the field takes a simple string argument.

### Creating parties (creator, contact, publisher)

``` r
aaron <- eml$creator(
  individualName = eml$individualName(
    givenName = "Aaron", 
    surName = "Ellison"),
  electronicMailAddress = "fakeaddress@email.com")
```

``` r
HF_address <- eml$address(
                  deliveryPoint = "324 North Main Street",
                  city = "Petersham",
                  administrativeArea = "MA",
                  postalCode = "01366",
                  country = "USA")
```

``` r
publisher <- eml$publisher(
                 organizationName = "Harvard Forest",
                 address = HF_address)
```

``` r
contact <- 
  list(
    individualName = aaron$individualName,
    electronicMailAddress = aaron$electronicMailAddress,
    address = HF_address,
    organizationName = "Harvard Forest",
    phone = "000-000-0000")
```

### Putting it all together

``` r
my_eml <- eml$eml(
           packageId = uuid::UUIDgenerate(),  
           system = "uuid",
           dataset = eml$dataset(
               title = "Thresholds and Tipping Points in a Sarracenia",
               creator = aaron,
               pubDate = "2012",
               intellectualRights = "http://www.lternet.edu/data/netpolicy.html.",
               abstract = abstract,
               keywordSet = keywordSet,
               coverage = coverage,
               contact = contact,
               methods = methods,
               dataTable = eml$dataTable(
                 entityName = "hf205-01-TPexp1.csv",
                 entityDescription = "tipping point experiment 1",
                 physical = physical,
                 attributeList = attributeList)
               ))
```

## Serialize and validate

We can also validate first and then serialize:

``` r
eml_validate(my_eml)
#> [1] TRUE
#> attr(,"errors")
#> character(0)
write_eml(my_eml, "eml.xml")
#> NULL
```

## Setting the version

EML will use the latest EML specification by default. To switch to a
different version, use `emld::eml_version()`

``` r
emld::eml_version("eml-2.1.1")
#> [1] "eml-2.1.1"
```

Switch back to the 2.2.0 release:

``` r
emld::eml_version("eml-2.2.0")
#> [1] "eml-2.2.0"
```
