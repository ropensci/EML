
In [Advanced writing of EML](), we construct richer EML files, including:

- Constructing more complete lists of authors, publishers and contact.
- Summarizing the geographic, temporal, and taxonomic coverage of the dataset
- Reading in pages of methods descriptions from a Word document
- Adding arbitrary additional metadata
- Indicating the canonical citation to the paper that should be acknowledged when the data is re-used.  
- Conversion between EML and other metadata formats, such as NCBII and ISO standards.

In so doing we will take a more modular approach that will allow us to build up our metadata from reusable components, while also providing a more fine-grained control over the resulting output fields and files.  




### Overview of the EML heirarchy

A basic knowledge of the components of an EML metadata file is essential to being able to take full advantage of the language. While more complete information can be found in the official schema documentation, here we provide a general overview of commonly used metadata elements most relevant to describing data tables.  

This schematic shows each of the metadata elements we will generate.  Most these elements have sub-components (e.g. a 'publisher' may have a name, address, and so forth) which are not shown for simplicity.  Other optional fields we will not be generating in this example are also not shown.   

```yaml
- eml
  - dataset
    - creator
    - contact
    - publisher
    - title
    - pubDate
    - keywords
    - abstract 
    - intellectualRights
    - methods
    - coverage
    - dataTable
      - physical
      - attributeList
  - additionalMetadata
```

The EML R package allows us to assemble these pieces bit by bit, allowing us to work either from the top down or bottom up.  

Our `data.set` object captures all of the information required to generate the `dataTable` element: the `data.frame`, which will be written to an external CSV file descibed by the `physical` node, and the `attributeList`, containing the column and unit metadata descriptions.  



### Creating hf205.xml

In this example, we will use R to re-generate the EML metadata originally published by [Ellison _et al_ (2012)]() through the Harvard Forest Long Term Ecological Research Center.  <!-- The original metadata file was created in association with the publication in PNAS based on a Microsoft Word document template that Harvard Forest provides to the academic researchers.  Metadata from this template is then read off by hand and an EML file is generated using a combination of a commercial XML editing platform (Oxygen) for commonly used higher-level elements, and the Java platform `Morpho` provided by the EML development team for lower level attribute metadata. -->


```r
library(reml)
```



We begin by reading in the CSV file providing the raw data that is to be annotated.  A copy of this file is distributed for demonstration purposes as part of the R package.  


```r
dat <- read.csv(system.file("examples", "hf205-01-TPexp1.csv", package="reml"))
```


As in our [Basic tutorial](), essential metadata describes the columns and units used in the CSV file.  



```r
col.defs <- c("run.num" = "which run number (=block). Range: 1 - 6. (integer)",
              "year" = "year, 2012",
              "day" = "Julian day. Range: 170 - 209.",
              "hour.min" = "hour and minute of observation. Range 1 - 2400 (integer)",
              "i.flag" =  "is variable Real, Interpolated or Bad (character/factor)",
              "variable" = "what variable being measured in what treatment (character/factor).",
              "value.i" = "value of measured variable for run.num on year/day/hour.min.")
```





```r
unit.defs = list("which run number", 
                 "YYYY",
                 "DDD",
                 "hhmm", 
                 c(R = "real", I = "interpolated", B = "bad"),
                 c(control = "no prey added", 
                   low = "0.125 mg prey added ml-1 d-1",
                   med.low = "0,25 mg prey added ml-1 d-1",    # ERROR 
                   med.high = "0.5 mg prey added ml-1 d-1",
                   high = "1.0 mg prey added ml-1 d-1",
                   air.temp = "air temperature measured just above all plants (1 thermocouple)",
                   water.temp = "water temperature measured within each pitcher",
                   par = "photosynthetic active radiation (PAR) measured just above all plants (1 sensor)"),
                 c(control = "% dissolved oxygen",
                   low = "% dissolved oxygen",
                   med.low = "% dissolved oxygen",
                   med.high = "% dissolved oxygen",
                   high  = "% dissolved oxygen",
                   air.temp = "degrees C",
                   water.temp = "degrees C",
                   par = "micromoles m-1 s-1"))
```



We attach this essential metadata directly to the `data.frame` to make a `data.set` object (a data.frame with basic metadata).  



```r
dat <- data.set(dat, col.defs = col.defs, unit.defs = unit.defs)
```


Rather than write this out directly to an EML file with `eml_write` like we did in the basic example, we'll first assemble more metadata information.  

As a _metadata_ format, we do not encode the actual data file itself into the EML object.  Instead, the data is written out using some existing standard file format, which is merely _described by_ the EML file. The leading recommendation for exchanging and preserving tabular data is to use a plain text csv (comma separated values) file.  The function `eml_dataTable` will write out the data frame to a csv file, linking the filename to the metadata. We can optionally provide other information, such as description and name for the output file (if none is provided the unique id generated for this element will be used).  



```r
dataTable <- reml:::eml_dataTable(dat, 
                           description = "Metadata documentation for S1.csv", 
                           file = "S1.csv")
```


CSV file conventions can differ across platforms and continents. To remove any ambiguity, EML explicitly describes how the csv file is constructed (noting that it is actually comma delimited as the name implies and not tab delimited, and noting other details such as the number of rows, the character used to indicate and end of a row, and so forth).  Because R is writing the csv file itself after all, it already knows all of these details and we are able to automatically fill out this section of the metadata.  This information is summarized in the `dataTable@physical` element.  




One of the primary benefits in constructing EML in a scripted language such as R rather than in a GUI interface such as `morpho` is the ability to easily save and reuse components.  Here is an EML component that Harvard Forest will use a lot: it's address


```r
HF_address <- new("address", 
                  deliveryPoint = "324 North Main Street",
                  city = "Petersham",
                  administrativeArea = "MA",
                  postalCode = "01366",
                  country = "USA") 
```


We use the `new` function to construct an object of class `address`.  This R object has "slots" corresponding to each of the elements that makes up an address in EML.  We can define the values for these slots all at once as shown, or we can add and edit them after the object is created by using R's S4 subsetting operator, `@`.  For instance, we could change the street address with: `HF_address@deliveryPoint <- "some new address"`. (Some users might find the equivalent notation, `slot(HF_address, "deliveryPoint") <- "some new address"` to be more intuitive).  We need not specify any additional values when first calling `new("address")`, and we can use `slotNames(HF_address)` to see a list of possible fields.  

This element is now available for reuse as we create other metadata.  For instance, we will define the publisher of the data by providing a name and an address:


```r
publisher <- new("publisher", 
    organizationName = "Harvard Forest",
    address = HF_address)
```


Note that the `address` slot is not simply a text field, but is in fact an `address` S4 object we created above.  This object preserves the structure defined by the EML schema, which ensures that software programs can consistently interpret the values we write into the metadata file.  


We can reuse data formats native to R as well.  For instance, R comes with an inherent notion of a "person" as something with a given name, a family name, an email address, and so forth.  R recognizes a string written like this: 



```r
aaron <- as.person("Aaron Ellison <fakeaddress@email.com>")
```


can be interpreted as person's first and last name and email address.  The EML R package also recognizes this syntax, and can coerce this into the various 'person' or 'responsibleParty' roles defined in the EML schema.  Here we construct a contact node using coercion (the `as` function) from the `person` object


```r
contact <- as(aaron, "contact")
contact@address = HF_address
contact@organizationName = "Harvard Forest"
contact@phone = "000-000-0000"
```


We could have entered each slot manually using `new("contact")` as we did for the above elemnts. 

Multiple individuals can be listed as the creator (author) of data.  Here we use coercion (`as`) to turn strings into creator nodes, and then use R's concatenate operator, `c`, to combine them. 


```r
creator <- c(as("Aaron Ellison", "creator"), as("Nicholas Gotelli", "creator"))
```



Yet another way to create person objects is to use the helper function `eml_person`.  This function recongnizes the plain-text string conventions already used by R's person objects (or the person objects themselves, see ?person).   Here we add other researchers as contributors to the data.  The `eml_person` function automatically decides whether to return a `contact`, `creator` list, or `associatedParty`, based on the additional information provided (such as an email address in angle braces, contributor role in square brackets).  


```r
other_researchers <- eml_person("Benjamin Baiser [ctb]", "Jennifer Sirota [ctb]") # creates a 'ListOfassociatedParty' (roles != cre)
```


Again, we could just as well have created these nodes using any of the other mechanisms shown above.  


Some metadata is just a string: 


```r
pubDate <- "2012" 
title <- "Thresholds and Tipping Points in a Sarracenia Microecosystem at Harvard Forest since 2012"
```


When metadata fields have more complicated types, the package provides constructor functions to help build these elements succinctly.  For instance, while we could add our keyword sets manually using only `new`:


```r
keys <-
  c(new("keywordSet", 
      keywordThesaurus = "LTER controlled vocabulary",
      keyword = c(new("keyword", keyword="bacteria"), new("keyword", keyword="carnivorous plants"), ...)
    ),
   new("keywordSet", 
      keywordThesaurus = "LTER core area",
      keyword = ...) 
```


and so forth, it is more compact to use the provided constructor function:


```r
keys <- eml_keyword(list("LTER controlled vocabulary" = c("bacteria", "carnivorous plants", "genetics", "thresholds"),
                                     "LTER core area" = c("populations", "inorganic nutrients", "disturbance"),
                                        "HFR default" = c("Harvard Forest", "HFR", "LTER", "USA")))
```


A similar situation arises with describing the coverage metadata element. 

```r
coverage <- eml_coverage(scientific_names = "Sarracenia purpurea", 
                         dates            = c('2012-06-01', '2013-12-31'),
                         geographic_description = "Harvard Forest Greenhouse, Tom Swamp Tract (Harvard Forest)", 
                         NSEWbox          = c( 42.55,  42.42, -72.1, -72.29, 160, 330))
```


In this case, the helper function supports only the more common types of coverage, such as listing taxonomic coverage at the species name rather than higher taxonomic level, or providing only calendar dates instead of, say, geological epochs.  For these alternative constructions, users will call the `new` constructors directly, see `?temporalCoverage`, `?taxonomicCoverage` and related functions for details.  


The remaining metadata provided in hf205.xml consists primarily of text blocks.  We might write small text blocks directly into our script:  


```r
abstract <- "The primary goal of this project is to determine
  experimentally the amount of lead time required to prevent a state
  change. To achieve this goal, we will (1) experimentally induce state
  changes in a natural aquatic ecosystem - the Sarracenia microecosystem;
  (2) use proteomic analysis to identify potential indicators of states
  and state changes; and (3) test whether we can forestall state changes
  by experimentally intervening in the system. This work uses state-of-the
  art molecular tools to identify early warning indicators in the field
  of aerobic to anaerobic state changes driven by nutrient enrichment
  in an aquatic ecosystem. The study tests two general hypotheses: (1)
  proteomic biomarkers can function as reliable indicators of impending
  state changes and may give early warning before increasing variances
  and statistical flickering of monitored variables; and (2) well-timed
  intervention based on proteomic biomarkers can avert future state changes
  in ecological systems."  
```


or read them in from some externa plain text file such as `abstract <- readLines("abstract.txt")`.  


```r
rights <- "This dataset is released to the public and may be freely
  downloaded. Please keep the designated Contact person informed of any
  plans to use the dataset. Consultation or collaboration with the original
  investigators is strongly encouraged. Publications and data products
  that make use of the dataset must include proper acknowledgement. For
  more information on LTER Network data access and use policies, please
  see: http://www.lternet.edu/data/netpolicy.html."
```



For larger blocks of text we might rather write these Word.  We can read them in from there, with the help of a few additional R packages.   


```r
library(RWordXML)
library(XML)
f2 <- wordDoc(system.file("examples", "methods.docx", package="reml"))
doc <- f2[[getDocument(f2)]]
txt <- xpathSApply(doc, "//w:t", xmlValue)
## FIXME add <title> <section> and <para> blocking back: 
method_description <- paste(txt, collapse = "\n\n") 
```


We can then construct a methods node containing this text as the description: 


```r
methods <- new("methods")
methods@methodsStep@description <- method_description
```



One of the simplest ways and most powerful ways to generate EML metadata is to resuse a section from an existing EML file directly.  


```r
hf205 <- eml_read(system.file("examples", "hf205.xml", package="reml"))
additionalMetadata <- hf205@additionalMetadata # extracted from previous eml file
```


We now have all of the elements we wished to define for the `dataset` metadata. We can assemble them into a `datset` node as follows:



```r
dataset <- new("dataset", 
                title = title,
                creator = creator,
                contact = contact,
                pubDate = pubDate,
                associatedParty = other_researchers,
                keywordSet = keys,
                coverage = coverage,
                methods = methods,
                dataTable = c(dataTable))
```


Note that because a `dataset` can have multiple dataTable elements, we use the same concatenate notation illustrated earlier, `c(dataTable)`, even though only one element is provided.  This lets R known that the resulting object is a `ListOfdataTable`, not an individual `dataTable` file.  This convention should be followed whenever assigning a value to a slot that can take more than one element of that name.  


With most of the metadata now in place, we can construct the top-level element:  



```r
eml <- new("eml", 
            dataset = dataset,
            additionalMetadata = additionalMetadata)
```


This call automatically adds a few additional bits of information, such as a unique identifier `packageId` for the metadata file.  This `eml` object we have just created now has the complete R representation of the EML data.  This is the same class of object returned by `eml_read`, and consequently we can use all of the read methods provided to explore or manipulate it.  

Finally we are ready to write out our EML object to an XML file. 


```r
eml_write(eml, "hf205_from_reml.xml")
```

```
[1] "<eml:eml xmlns:eml=\"eml://ecoinformatics.org/eml-2.1.1\" xmlns:ds=\"eml://ecoinformatics.org/dataset-2.1.1\" xmlns:xs=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:stmml=\"http://www.xml-cml.org/schema/stmml-1.1\" packageId=\"urn:uuid:2534c35a-2b9a-492c-865e-c22b0f536891\" system=\"uuid\" scope=\"system\">\n  <dataset>\n    <title>Thresholds and Tipping Points in a Sarracenia Microecosystem at Harvard Forest since 2012</title>\n    <creator>\n      <individualName>\n        <givenName>Aaron</givenName>\n        <surName>Ellison</surName>\n      </individualName>\n    </creator>\n    <creator>\n      <individualName>\n        <givenName>Nicholas</givenName>\n        <surName>Gotelli</surName>\n      </individualName>\n    </creator>\n    <associatedParty>\n      <individualName>\n        <givenName>Benjamin</givenName>\n        <surName>Baiser</surName>\n      </individualName>\n      <role>ctb</role>\n    </associatedParty>\n    <associatedParty>\n      <individualName>\n        <givenName>Jennifer</givenName>\n        <surName>Sirota</surName>\n      </individualName>\n      <role>ctb</role>\n    </associatedParty>\n    <pubDate>2012</pubDate>\n    <keywordSet>\n      <keyword>bacteria</keyword>\n      <keyword>carnivorous plants</keyword>\n      <keyword>genetics</keyword>\n      <keyword>thresholds</keyword>\n      <keywordThesaurus>LTER controlled vocabulary</keywordThesaurus>\n    </keywordSet>\n    <keywordSet>\n      <keyword>populations</keyword>\n      <keyword>inorganic nutrients</keyword>\n      <keyword>disturbance</keyword>\n      <keywordThesaurus>LTER core area</keywordThesaurus>\n    </keywordSet>\n    <keywordSet>\n      <keyword>Harvard Forest</keyword>\n      <keyword>HFR</keyword>\n      <keyword>LTER</keyword>\n      <keyword>USA</keyword>\n      <keywordThesaurus>HFR default</keywordThesaurus>\n    </keywordSet>\n    <intellectualRights>&lt;a rel='license' property='http://creativecommons.org/ns#license' href='http://creativecommons.org/publicdomain/zero/1.0/'&gt;CC0&lt;/a&gt;</intellectualRights>\n    <coverage>\n      <geographicCoverage>\n        <geographicDescription>Harvard Forest Greenhouse, Tom Swamp Tract (Harvard Forest)</geographicDescription>\n        <boundingCoordinates>\n          <westBoundingCoordinate>-72.29</westBoundingCoordinate>\n          <eastBoundingCoordinate>-72.1</eastBoundingCoordinate>\n          <northBoundingCoordinate>42.55</northBoundingCoordinate>\n          <southBoundingCoordinate>42.42</southBoundingCoordinate>\n          <boundingAltitudes>\n            <altitudeMinimum>160</altitudeMinimum>\n            <altitudeMaximum>330</altitudeMaximum>\n            <altitudeUnits>meter</altitudeUnits>\n          </boundingAltitudes>\n        </boundingCoordinates>\n      </geographicCoverage>\n      <temporalCoverage>\n        <rangeOfDates>\n          <beginDate>\n            <calendarDate>2012-06-01</calendarDate>\n          </beginDate>\n          <endDate>\n            <calendarDate>2013-12-31</calendarDate>\n          </endDate>\n        </rangeOfDates>\n      </temporalCoverage>\n      <taxonomicCoverage>\n        <taxonomicClassification>\n          <taxonRankName>genus</taxonRankName>\n          <taxonRankValue>Sarracenia</taxonRankValue>\n          <taxonomicClassification>\n            <taxonRankName>species</taxonRankName>\n            <taxonRankValue>purpurea</taxonRankValue>\n          </taxonomicClassification>\n        </taxonomicClassification>\n      </taxonomicCoverage>\n    </coverage>\n    <contact>\n      <individualName>\n        <givenName>Aaron</givenName>\n        <surName>Ellison</surName>\n      </individualName>\n      <organizationName>Harvard Forest</organizationName>\n      <address>\n        <deliveryPoint>324 North Main Street</deliveryPoint>\n        <city>Petersham</city>\n        <administrativeArea>MA</administrativeArea>\n        <postalCode>01366</postalCode>\n        <country>USA</country>\n      </address>\n      <phone>000-000-0000</phone>\n      <electronicMailAddress>fakeaddress@email.com</electronicMailAddress>\n    </contact>\n    <methods>\n      <methodStep>\n        <description>G\n\neneral Protocols\n\n1. Field methods. All experiments will be carried out in the greenhouse at Harvard Forest. We have developed an instrumentation system that allows us to collect continuous dissolved [O2] measurements: dedicated micro-probes (DO-166MT; Lazar Research Laboratories: http://www.shelfscientific.com/) connected to multiplexers and data loggers (AM16/32B multiplexer, CR-1000 datalogger and control system [Campbell Scientific: http://www.cambellsci.com]). The initial ecosystem composition in all experimental plants will be standardized by seeding each pitcher with a 10-ml inoculum of liquid collected from pitchers growing at Tom Swamp.  In all experiments, prey will be supplied to pitchers as standardized aliquots of dried and finely ground bald-faced hornets (Dolichovespula maculata; Hymenoptera: Vespidae), which we collect in quantity throughout New England. Both hornets and ants (the latter are the dominant prey of S. purpurea) are hymenoptera, and have nearly identical C:N ratios (hornets: 3.97; common bog-dwelling ants [Tapinoma sessile and Myrmica lobifrons]: 3.37), but on average hornets have greater than 100 times the dry mass of these ants, and are easier to collect and process as a standardized food source. Additions of prey, either as large \"pulses\" or chronic \"presses\" are analogous to the enrichment and eutrophication that occur in aquatic \"green\" food webs in which phytoplankton abundance is boosted through addition of limiting nutrients. In \"brown\" food webs such as the Sarracenia microecosystem, detritus - not primary production - is at the base of the web, and our treatments boost this material as would happen through increases in arthropod prey capture78 or through nitrogen-enriched precipitation.\n\nProteomic analysis. Proteomic profiles of microbial communities are determined after separating the microbial fraction from the pitcher fluid, prey, and other detritus. The microbial \"pellet\" is subjected to SDS-PAGE (sodium dodecyl sulfate polyacrylamide gel) electrophoresis; bands are cut out and digested in-gel with trypsin. Tryptic peptides are subjected to LC-MS/MS (liquid chromatography tandem mass spectrometry) for peptide and protein identification. Absolute abundance of peptides and proteins are quantified using AQUA (Absolute QUAntification) analysis109.\n\n            \n\nSpecific Experiments\n\nExperiment #1. Effects of nutrient enrichment on state changes and [O2] profiles. This experiment alters nutrient enrichment rates to characterize the [O2] profile and the transition to the anaerobic state. The experimental design is a one-way layout with 5 treatment groups: one control (no enrichment) and 4 enrichment levels (0.125, 0.25, 0.5, 1.0 mg prey added ml-1 d-1). One plant is assigned to each treatment group, and the entire set is replicated 6 times over successive weeks. [O2] is monitored continuously for 4 days to characterize state changes and tipping points under different enrichment rates. This experiment tracks a continuous [O2] profile but does not include proteomic analysis. The purpose of Experiment #1 is to identify an enrichment rate E that generates a long pre-tipping period before transition time T to the anaerobic state. This enrichment rate will be used in Experiments #2 - #4.\n\nExperiment #2. Identification of early intervention time and characterization of aerobic and anaerobic proteomes. This experiment will use the single enrichment rate E determined from Experiment #1 and impose different intervention times I at which nutrient enrichment will be terminated. Thus, this experiment will identify the latest time I* at which it is possible to intervene and stop the transition to the anaerobic state by halting enrichment. The [O2] profile will again be monitored continuously over 10 days to measure the state of the system. From Experiment #1, the transition time T to the anaerobic state with no intervention will be known. We will use one control group (no prey addition) and ten levels of intervention time (all with the same enrichment rate E) as a proportion of T (0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0). Six plants will be assigned randomly to each of the 11 treatments in a randomized one-way layout and [O2] profiles will be monitored continuously. In addition to the [O2] profiles, we will also characterize the protein profiles of aerobic and anaerobic pitchers in all 11 treatment groups at the end of the experiment.\n\nAfter the plants are harvested, we will create proteomic profiles of the predominantly bacterial portion (centrifuged pellet) of the pitcher fluid from each plant, as described in General Protocols. Thus, 66 separate pellet-fraction samples will be analyzed by SDS-PAGE. After examining the SDS-PAGE profiles, approximately ten proteins that show dynamic patterns consistent with state change and five that do not change will be cut from the gel, subjected to in-gel tryptic digestion and a portion of the tryptic peptides will be analyzed by LC-MS/MS. Using these data, we will choose three identified peptides from each protein for peptide synthesis such that each synthesized peptide contains stable isotope labels (AQUA peptides) to distinguish them by mass from the native peptides. We will then quantify all 45 of the native peptides from the original samples using a known amount of each AQUA peptide spiked into the tryptic digest. The AQUA analysis of proteins that do not show changes will be used for normalization between samples. These data will be used to independently identify the current state of the system and forecast the time-to-transition.\n\nWe will use Sequest searches for initial identification of peptides; relevant scores including Xcorr and Delta Cn values will be given for each peptide. Other peptides will be identified by de novo sequencing using PepNovo; all PepNovo scores will likewise be given including any N- or C-terminal gaps. Mass error in ppm will be reported for each precursor ion. We will use standard multivariate analysis to search for distinctive proteomic profiles114 that characterize aerobic and anaerobic ecosystems, as well as ecosystems that developed with and without inputs of photosynthetic O2 and plant metabolites.\n\nExperiment #3. Identification of diagnostic proteins. Using Experiments #1 and 2, we will have identified an enrichment rate E with a long pre-tipping period and an intervention time I* before which mitigation and termination of enrichment will prevent eutrophication. Experiment #3 will characterize the mean and variance of the protein profile before and after I*. We are especially interested in identifying proteins that increase rapidly in abundance (or variance) well before the onset of flickering in [O2] and before the transition time T from the aerobic to the anaerobic state.\n\nA cohort of 100 plants all will be fed at rate E (determined from Experiment #1), with intervention time I* determined from Experiment #2, although no intervention will be used in this \"press\" experiment so that we can contrast proteins before and after the state change. At seven times before I* and three times after I*, we will harvest 10 randomly chosen plants. At each prescribed harvest time, we will measure [O2] and collect samples from each plant for proteomic screening using both SDS-PAGE and AQUA analysis. This experiment will identify proteins that rise quickly in abundance during the pre- I* period and can be used as early indicators of a future tipping point. Because different plants will be harvested at each time period, this is a one-way ANOVA design, with pre-and post- I* a priori contrasts. A randomization test will be used to determine whether variances in protein expression differ through time. During these analyses we will use the data from the AQUA peptides and from known amounts of protein standards, such as bovine serum albumin, to approximate the amount of protein in a given coomassie-stained SDS-PAGE gel band. The reason for doing this is to provide a fast \"real-time\" assay based just on expression in the SDS-PAGE. This rapid assay will be used in Experiment #4.\n\nExperiment # 4. Proof-of-application. This experiment will provide a benchmark test of our methods and their ability to correctly identify tipping points. A cohort of 100 plants will each be fitted with [O2] probes and started on the enrichment regime. Two times per day, we will collect 3 plants each, pool their contents, and conduct a rapid screen in the lab with SDS-PAGE for the diagnostic proteins that were identified in Experiment #3. We will use the protein expression in the gel to delineate an \"early\" and a \"late\" mitigation strategy. As soon as diagnostic proteins measured in the SDS-gels are at abundances that signal we are at 0.5\303\227I* - approximately one-half of the way to the latest intervention time - we will randomly select one third of the remaining plants for mitigation and termination of enrichment (the \"early\" mitigation strategy). We will continue to harvest plants from the remainder of the cohort and monitor proteins. As soon as diagnostic proteins signal we are at 0.75 times I*, we will randomly select one half of the remaining plants for mitigation and termination of enrichment (the \"late\" mitigation strategy). The remaining plants (approximately one sixth to one third of the original cohort) will continue to be enriched. We will monitor [O2] in all 3 groups (no-mitigation control, early mitigation, late mitigation) until all plants reach a new [O2] equilibrium. If the protein markers are successful, the proportion of food webs that remain aerobic will be significantly higher in the two mitigation treatments than in the no-mitigation control.</description>\n      </methodStep>\n    </methods>\n    <dataTable id=\"urn:uuid:630d879f-bd35-449e-9a39-7141a136bc45\" system=\"uuid\" scope=\"system\">\n      <entityName>S1.csv</entityName>\n      <entityDescription>Metadata documentation for S1.csv</entityDescription>\n      <physical>\n        <objectName>S1.csv</objectName>\n        <size>8943320</size>\n        <characterEncoding>en_US.UTF-8</characterEncoding>\n        <dataFormat>\n          <textFormat>\n            <numHeaderLines>1</numHeaderLines>\n            <numFooterLines>0</numFooterLines>\n            <recordDelimiter>\\r\\n</recordDelimiter>\n            <attributeOrientation>column</attributeOrientation>\n            <simpleDelimited>\n              <fieldDelimiter>,</fieldDelimiter>\n            </simpleDelimited>\n          </textFormat>\n        </dataFormat>\n      </physical>\n      <attributeList>\n        <attribute>\n          <attributeName>run.num</attributeName>\n          <attributeDefinition>which run number (=block). Range: 1 - 6. (integer)</attributeDefinition>\n          <measurementScale>\n            <ratio>\n              <unit>\n                <standardUnit>which run number</standardUnit>\n              </unit>\n              <numericDomain>\n                <numberType>real</numberType>\n              </numericDomain>\n            </ratio>\n          </measurementScale>\n        </attribute>\n        <attribute>\n          <attributeName>year</attributeName>\n          <attributeDefinition>year, 2012</attributeDefinition>\n          <measurementScale>\n            <ratio>\n              <unit>\n                <standardUnit>YYYY</standardUnit>\n              </unit>\n              <numericDomain>\n                <numberType>real</numberType>\n              </numericDomain>\n            </ratio>\n          </measurementScale>\n        </attribute>\n        <attribute>\n          <attributeName>day</attributeName>\n          <attributeDefinition>Julian day. Range: 170 - 209.</attributeDefinition>\n          <measurementScale>\n            <ratio>\n              <unit>\n                <standardUnit>DDD</standardUnit>\n              </unit>\n              <numericDomain>\n                <numberType>real</numberType>\n              </numericDomain>\n            </ratio>\n          </measurementScale>\n        </attribute>\n        <attribute>\n          <attributeName>hour.min</attributeName>\n          <attributeDefinition>hour and minute of observation. Range 1 - 2400 (integer)</attributeDefinition>\n          <measurementScale>\n            <ratio>\n              <unit>\n                <standardUnit>hhmm</standardUnit>\n              </unit>\n              <numericDomain>\n                <numberType>real</numberType>\n              </numericDomain>\n            </ratio>\n          </measurementScale>\n        </attribute>\n        <attribute>\n          <attributeName>i.flag</attributeName>\n          <attributeDefinition>is variable Real, Interpolated or Bad (character/factor)</attributeDefinition>\n          <measurementScale>\n            <nominal>\n              <nonNumericDomain>\n                <enumeratedDomain>\n                  <codeDefinition>\n                    <code>R</code>\n                    <definition>real</definition>\n                  </codeDefinition>\n                  <codeDefinition>\n                    <code>I</code>\n                    <definition>interpolated</definition>\n                  </codeDefinition>\n                  <codeDefinition>\n                    <code>B</code>\n                    <definition>bad</definition>\n                  </codeDefinition>\n                </enumeratedDomain>\n              </nonNumericDomain>\n            </nominal>\n          </measurementScale>\n        </attribute>\n        <attribute>\n          <attributeName>variable</attributeName>\n          <attributeDefinition>what variable being measured in what treatment (character/factor).</attributeDefinition>\n          <measurementScale>\n            <nominal>\n              <nonNumericDomain>\n                <enumeratedDomain>\n                  <codeDefinition>\n                    <code>control</code>\n                    <definition>no prey added</definition>\n                  </codeDefinition>\n                  <codeDefinition>\n                    <code>low</code>\n                    <definition>0.125 mg prey added ml-1 d-1</definition>\n                  </codeDefinition>\n                  <codeDefinition>\n                    <code>med.low</code>\n                    <definition>0,25 mg prey added ml-1 d-1</definition>\n                  </codeDefinition>\n                  <codeDefinition>\n                    <code>med.high</code>\n                    <definition>0.5 mg prey added ml-1 d-1</definition>\n                  </codeDefinition>\n                  <codeDefinition>\n                    <code>high</code>\n                    <definition>1.0 mg prey added ml-1 d-1</definition>\n                  </codeDefinition>\n                  <codeDefinition>\n                    <code>air.temp</code>\n                    <definition>air temperature measured just above all plants (1 thermocouple)</definition>\n                  </codeDefinition>\n                  <codeDefinition>\n                    <code>water.temp</code>\n                    <definition>water temperature measured within each pitcher</definition>\n                  </codeDefinition>\n                  <codeDefinition>\n                    <code>par</code>\n                    <definition>photosynthetic active radiation (PAR) measured just above all plants (1 sensor)</definition>\n                  </codeDefinition>\n                </enumeratedDomain>\n              </nonNumericDomain>\n            </nominal>\n          </measurementScale>\n        </attribute>\n        <attribute>\n          <attributeName>value.i</attributeName>\n          <attributeDefinition>value of measured variable for run.num on year/day/hour.min.</attributeDefinition>\n          <measurementScale>\n            <ratio>\n              <unit>\n                <standardUnit>% dissolved oxygen</standardUnit>\n              </unit>\n              <numericDomain>\n                <numberType>real</numberType>\n              </numericDomain>\n            </ratio>\n          </measurementScale>\n        </attribute>\n      </attributeList>\n      <caseSensitive>yes</caseSensitive>\n      <numberOfRecords>279224</numberOfRecords>\n    </dataTable>\n  </dataset>\n  <additionalMetadata>\n    <metadata>\n      <metadata>\n        <additionalClassifications>\n          <status>ongoing</status>\n          <researchTopic>community</researchTopic>\n          <studyType>short-term measurement</studyType>\n          <studyType>modeling</studyType>\n        </additionalClassifications>\n      </metadata>\n    </metadata>\n  </additionalMetadata>\n  <additionalMetadata>\n    <metadata>\n      <metadata>\n        <additionalLinks>\n          <url name=\"Ecophysiology of Carnivorous Plants Worldwide 1980-2011\">http://harvardforest.fas.harvard.edu:8080/exist/xquery/data.xq?id=hf168</url>\n          <url name=\"Effects of Prey Availability on Sarracenia Physiology at Harvard Forest 2005\">http://harvardforest.fas.harvard.edu:8080/exist/xquery/data.xq?id=hf109</url>\n          <url name=\"Food Web of Sarracenia Purpurea in United States and Canada since 1999\">http://harvardforest.fas.harvard.edu:8080/exist/xquery/data.xq?id=hf193</url>\n          <url name=\"Thresholds and Regime Shifts at Four LTER Sites (CCE, JRN, PAL, SBC) 1951-2009\">http://harvardforest.fas.harvard.edu:8080/exist/xquery/data.xq?id=hf170</url>\n          <url name=\"Nitrogen Cycling Dynamics in Sarracenia Purpurea at Harvard Forest 2004-2005\">http://harvardforest.fas.harvard.edu:8080/exist/xquery/data.xq?id=hf096</url>\n          <url name=\"Organic and Inorganic Nitrogen Uptake by Sarracenia Purpurea at Harvard Forest and Fort Albany ON 2007\">http://harvardforest.fas.harvard.edu:8080/exist/xquery/data.xq?id=hf146</url>\n          <url name=\"Prey Capture by Carnivorous Plants Worldwide 1923-2007\">http://harvardforest.fas.harvard.edu:8080/exist/xquery/data.xq?id=hf111</url>\n          <url name=\"Sarracenia Purpurea Prey Capture at Harvard Forest 2008\">http://harvardforest.fas.harvard.edu:8080/exist/xquery/data.xq?id=hf114</url>\n          <url name=\"Allochthonous Nutrients in the Sarracenia Microecosystem at Harvard Forest 2005-2007\">http://harvardforest.fas.harvard.edu:8080/exist/xquery/data.xq?id=hf098</url>\n        </additionalLinks>\n      </metadata>\n    </metadata>\n  </additionalMetadata>\n</eml:eml>"
```


When we used the `eml_write()` function for the first time in the [Basic tutorial](), we simply passed a `data.set` object.  Internally the function made the remaining calls to `new("dataTable")`, `new("dataset")`, and `new("eml")` for us.  This time, the `eml_write` function can recognize that this is already an `eml` object, which it immediately converts to the XML representation and writes out as a file.  (If no file name is provided, the XML text will be returned to the console).  


As before, we can now validate our EML document to ensure all the information has been formatted correctly:


```r
eml_validate("hf205_from_reml.xml")
```

```

Enter a frame number, or 0 to exit   

 1: knit("Advanced_writing_of_EML.Rmd")
 2: process_file(text, output)
 3: withCallingHandlers(if (tangle) process_tangle(group) else process_gro
 4: process_group(group)
 5: process_group.block(group)
 6: call_block(x)
 7: block_exec(params)
 8: in_dir(opts_knit$get("root.dir") %n% input_dir(), evaluate(code, envir
 9: evaluate(code, envir = env, new_device = FALSE, keep_warning = !isFALS
10: evaluate_call(expr, parsed$src[[i]], envir = envir, enclos = enclos, d
11: handle(ev <- withCallingHandlers(withVisible(eval(call, envir, enclos)
12: try(f, silent = TRUE)
13: tryCatch(expr, error = function(e) {
    call <- conditionCall(e)
    if
14: tryCatchList(expr, classes, parentenv, handlers)
15: tryCatchOne(expr, names, parentenv, handlers[[1]])
16: doTryCatch(return(expr), name, parentenv, handler)
17: withCallingHandlers(withVisible(eval(call, envir, enclos)), warning = 
18: withVisible(eval(call, envir, enclos))
19: eval(call, envir, enclos)
20: eval(expr, envir, enclos)
21: <text>#1: eml_validate("hf205_from_reml.xml")
22: saveXML(xmlParse(eml))
23: xmlParse(eml)
24: (if (isHTML) warning else stop)(e)
```

```
Error: error in evaluating the argument 'doc' in selecting a method for function 'saveXML': Error: XML content does not seem to be XML: 'hf205_from_reml.xml'
```


While it is difficult to create invalid EML using the constructor functions, it is not impossible so it never hurts to check.  



As illustrated in the basic tutorial, we can now publish this file automatically to a central repository such as the KNB.   






