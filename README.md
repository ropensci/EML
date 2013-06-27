reml
====

R package for reading, writing, integrating and publishing data using the Ecological Metadata Language (EML) format. 

* Author: Carl Boettiger
* License: [CC0](http://creativecommons.org/publicdomain/zero/1.0/)

Quick Start
===========

Install the R package:

<!-- r highlighting on github is broken, so we'll use ruby codeblocks -->

```ruby
install_github("reml", "ropensci")
```


Writing R data into EML
-----------------------


Configure general metadata you may want to reuse again and again through settings:

```ruby
 eml$set(givenName = "Carl", surName = "Boettiger", email = "cboettig@ropensci.org")
```

Consider some dataset as an R `data.frame`.  

```ruby
  dat = data.frame(river=c("SAC", "SAC", "AM"),
                        spp = c("king", "king", "ccho"),
                        stg = c("smolt", "parr", "smolt"),
                        ct =  c(293L, 410L, 210L))
```



Provide definitions for the columns.  These are usually just plain text definitions, though a URI to a semantic definition can be particularly powerful. See "Advanced Use" for details on adding richer information, such as the method used to collect the data or set the geographic, taxanomic, or temporal coverage of an individual column.   

```ruby
      col_metadata = c(river = "http://dbpedia.org/ontology/River",
                       spp = "http://dbpedia.org/ontology/Species",
                       stg = "Life history stage",
                       ct = "count")
```

Define the units used in each column.  For factors, this is a definition of the levels involved.  For numeric data, specify the units from [this list](http://knb.ecoinformatics.org/software/eml/eml-2.1.1/eml-unitTypeDefinitions.html#StandardUnitDictionary).  For dates, specify the format, (e.g. YYYY or MM-DD-YY). For character strings, a definition of the kind of string can be given, (e.g. species scientific name), otherwise the column description will be used.  

```ruby
      unit_metadata =
       list(river = c(SAC = "The Sacramento River", AM = "The American River"),
            spp = c(king = "King Salmon", ccho = "Coho Salmon"),
            stg = c(parr = "third life stage", smolt = "fourth life stage"),
            ct = "number")

```

The hard work is over, time to generate some EML.

```ruby
eml_write(dat, col_metadata, unit_metadata, file="my_eml_data.xml")
```

See the [EML generated](https://github.com/ropensci/eml/tree/master/inst/examples/my_eml_data.xml) by this example.

### Advanced Use

Yet to come.  See [Open issues in writing EML](https://github.com/ropensci/reml/issues?labels=write+eml&page=1&state=open)


Publish EML
-----------

In development.  See [Open issues in publishing EML](https://github.com/ropensci/reml/issues?labels=publish+eml&page=1&state=open)

Reading EML
-----------

In development.  See [Open issues in reading EML](https://github.com/ropensci/reml/issues?labels=read+eml&page=1&state=open)

Integrating Multiple EML files 
------------------------------

In development.  See [Open issues in integrating EML](https://github.com/ropensci/reml/issues?labels=integrate+eml&page=1&state=open)
