<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Travis-CI Build Status](https://travis-ci.org/ropensci/EML.svg?branch=master)](https://travis-ci.org/ropensci/EML) [![codecov.io](https://codecov.io/github/ropensci/EML/coverage.svg?branch=master)](https://codecov.io/github/ropensci/EML?branch=master) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/ropensci/EML?branch=master&svg=true)](https://ci.appveyor.com/project/ropensci/EML) [![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/EML)](https://cran.r-project.org/package=EML) [![CRAN RStudio mirror downloads](http://cranlogs.r-pkg.org/badges/EML)](https://CRAN.R-project.org/package=EML) [![Github Stars](https://img.shields.io/github/stars/ropensci/EML.svg?style=social&label=Github)](https://github.com/ropensci/EML) [![DOI](https://zenodo.org/badge/10894022.svg)](https://zenodo.org/badge/latestdoi/10894022)

EML: The Ecological Metadata Language Standard
==============================================

EML is a widely used metadata standard in the ecological and environmental sciences. We strongly recommend that interested users visit the [EML Homepage](https://knb.ecoinformatics.org/#external//emlparser/docs/index.html) for an introduction and thorough documentation of the standard. Additionally, the scientific article *[The New Bioinformatics: Integrating Ecological Data from the Gene to the Biosphere (Jones et al 2006)](http://doi.org/10.1146/annurev.ecolsys.37.091305.110031)* provides an excellent introduction into the role EML plays in building metadata-driven data repositories to address the needs of highly hetergenous data that cannot be easily reduced to a traditional vertically integrated database. At this time, the `EML` R package provides support for the serializing and parsing of all low-level EML concepts, but still assumes some familiarity with the EML standard, particularly for users seeking to create their own EML files. We hope to add more higher-level functions which will make such familiarity less essential in future development.

*Note*: The `EML` R package is work in progress. Please see the Issues tracker in this repository for details about current issues and development milestonds.

Installation
------------

You can install the current development version from rOpenSci using:

``` r
install.packages("EML", repos = c("http://packages.ropensci.org", "https://cran.rstudio.com"))
```

or install directly from GitHub (after installing the `devtools` package from CRAN):

``` r
devtools::install_github("ropensci/EML")
```

Quickstart
----------

Load the package and read in an EML file:

``` r
library("EML")
f <- system.file("xsd/test/eml.xml", package = "EML")
eml <- read_eml(f)
```

This creates a native R object called `eml`. Although this is an "S4 object" type, it uses a "show" method which displays in an XML-like layout for convenience:

``` r
eml
#> <eml packageId="eml.1.1" system="knb" xsi:schemaLocation="eml://ecoinformatics.org/eml-2.1.1 eml.xsd">
#>   <dataset>
#>     <title>Sample dataset Description</title>
#>     <creator id="23445" scope="document">
#>       <individualName>
#>         <surName>Smith</surName>
#>       </individualName>
#>     </creator>
#>     <creator id="23446" scope="document">
#>       <individualName>
#>         <surName>Smith</surName>
#>       </individualName>
#>     </creator>
#>     <additionalInfo>
#>       <para>My comments go here.</para>
#>     </additionalInfo>
#>     <intellectualRights>
#>       <section>
#>         <para>Anyone can use it.</para>
#>       </section>
#>     </intellectualRights>
#>     <distribution>
#>       <online>
#>         <connectionDefinition scope="document">
#>           <schemeName system="CAP">sde</schemeName>
#>           <description>
#>             <para>The SDE scheme used at CAP LTER</para>
#>           </description>
#>           <parameterDefinition>
#>             <name>hostname</name>
#>             <definition>The host</definition>
#>             <defaultValue>mohave.asu.edu</defaultValue>
#>           </parameterDefinition>
#>           <parameterDefinition>
#>             <name>databaseName</name>
#>             <definition>The name of the database or catalog</definition>
#>           </parameterDefinition>
#>           <parameterDefinition>
#>             <name>owner</name>
#>             <definition>The owner catalog</definition>
#>             <defaultValue>dbo</defaultValue>
#>           </parameterDefinition>
#>         </connectionDefinition>
#>       </online>
#>     </distribution>
#>     <purpose>
#>       <para>Provide data to the whole world.</para>
#>     </purpose>
#>     <contact>
#>       <individualName>
#>         <surName>Johnson</surName>
#>       </individualName>
#>     </contact>
#>     <contact>
#>       <references>23445</references>
#>     </contact>
#>   </dataset>
#> </eml>
```

Validation helps ensure that an EML file can be accurately interpreted by any computer program designed to read EML. We can validate any EML against the official schema:

``` r
# An EML document with no validation errors
eml_validate(eml)
#> [1] TRUE
#> attr(,"errors")
#> character(0)

# An EML document with validation errors
invalid_eml <- system.file("xsd/test/example-eml-invalid.xml", package = "EML")

eml_validate(invalid_eml)
#> [1] FALSE
#> attr(,"errors")
#> [1] "Element 'creator': This element is not expected. Expected is one of ( references, alternateIdentifier, shortName, title )."
```

Write out as EML:

``` r
write_eml(eml, "example.xml")
```

Reading EML files
-----------------

Please see the vignette, [Parsing EML](https://github.com/ropensci/EML/blob/master/vignettes/parsing-EML.Rmd) for a more thorough introduction to reading EML files and extracting relevant metadata.

Creating EML files
------------------

Please see the vignette, [Creating EML](https://github.com/ropensci/EML/blob/master/vignettes/creating-EML.Rmd) for a proper introduction to creating your own EML files.

Working with custom units
-------------------------

Users may occassionally need to define custom unit types that EML does not know about. Please see the vignette, [Working with units](https://github.com/ropensci/EML/blob/master/vignettes/working-with-units.Rmd) for an overview of how units work in EML, how to view the standard unit library, and how to access and define custom units and custom unit types.

Archiving, Sharing, and Publishing EML
--------------------------------------

One of the chief advantages of using EML to manage your own data is the improved ability to search all of your data files, e.g. for the ones that have the particular measurements you need on the particular location or species of interest, and be able to share this data either publicly or securely with select collaborators. To do so, you will need to upload your EML file and data to a scientific metadata repository that understands EML. The vignette, [metadata repositories](https://github.com/ropensci/EML/blob/master/vignettes/metadata-repositories.Rmd) describes how to do this.

Developer notes
---------------

### Creating EML class definitions

Class definitions (`classes.R`) and methods (`methods.R`) are created programmatically. From the root of the package, run: `source("inst/create-package/create_package.R")`.

### Meta

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
