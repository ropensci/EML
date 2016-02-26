<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Travis-CI Build Status](https://travis-ci.org/cboettig/EML.svg?branch=master)](https://travis-ci.org/cboettig/EML)

EML
====

*Note*: `EML` is work in progress. Please see the Issues tracker in this repository for details about current issues and development milestonds.

Installation
------------

`EML` has not yet been released. Please install from GitHub after installing the `devtools` package (from CRAN):

``` r
devtools::install_github("cboettig/EML")
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

Validate EML against the official schema

``` r
eml_validate(eml)
#> $status
#> [1] 0
#> 
#> $errors
#> list()
#> attr(,"class")
#> [1] "XMLStructuredErrorList"
#> 
#> attr(,"class")
#> [1] "XMLSchemaValidationResults"
```

Write out as EML:

``` r
write_eml(eml, "example.xml")
#> [1] "example.xml"
```

Manipulating EML objects
------------------------

Eventually `EML` will provide constructor and extract methods to create and extract common metadata sections from convenient R stuctures (e.g. `data.frames` with unit metadata, common R classes like `Person`, `bibtype`). For now, the only method to access and modify EML is to use the standard S4 subsetting and constructor methods.

Our current example does not have a publication date. Let's add one:

``` r
eml@dataset@ResourceGroup@pubDate <- new("pubDate", "2016")
```

Note that we use the constructor method `new()` to create an object.

### Working with repeating elements

Developer notes
---------------

### Creating EML class definitions

Class definitions (`classes.R`) and methods (`methods.R`) are created programmatically. From the root of the package, run: `source("inst/create-package/create_package.R")`.
