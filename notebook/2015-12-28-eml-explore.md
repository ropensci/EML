``` r
devtools::install_github(c("hadley/purrr", "ropensci/EML"))
```

``` r
library("EML")
library("purrr")
library("dplyr")
```

    ## 
    ## Attaching package: 'dplyr'
    ## 
    ## The following object is masked from 'package:purrr':
    ## 
    ##     order_by
    ## 
    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag
    ## 
    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
obj <- eml_read("http://harvardforest.fas.harvard.edu/data/eml/hf001.xml")
```

``` r
stuff <- obj@dataset@dataTable[[4]]@attributeList@attribute

stuff[[1]]
```

    ## attributeName: date
    ## attributeDefinition: date
    ## measurementScale:
    ##   dateTime:
    ##     formatString: YYYY-MM
    ## .attrs: '1184531853051'

R has summarized the output using the [YAML](https://en.wikipedia.org/wiki/YAML) format, which is a bit more human readable than the XML format that EML language uses. YAML uses a `key: value` structure, where the `key` corresponds to the name of a tag/element (or occassionally an XML attribute instead of an XML tag, but attributes are used rarely in EML, mostly just for ids) in the EML language, followed by its value. Some of these don't appear to have a value, like `attribute:`, but look closely and you'll see the next two keys are indented further. This means that an `attribute` tag consists of two child tags, `attributeName` and `attributeDefinition`. We can see this in the subsetting, as

``` r
slotNames(stuff[1])
```

    ## NULL

``` r
stuff[[1]]@attributeName
```

    ## [1] "date"

``` r
stuff[[1]]@attributeDefinition
```

    ## [1] "date"

So, we want to see all the `attributeName`s and `attributeDefinition`s for Table 4. We could just print `stuff`, but that is much to verbose since it has all that stuff about `measurementScale` etc that we aren't interested in right now. So, we use a little R scripting to extract just the information we want:

``` r
purrr::map_df(stuff, function(x) data.frame(column.name = x@attributeName, definition = x@attributeDefinition))
```

    ## Source: local data frame [29 x 2]
    ## 
    ##    column.name                                                  definition
    ##          (chr)                                                       (chr)
    ## 1         date                                                        date
    ## 2         airt         average air temperature. Average of daily averages.
    ## 3       f.airt                            flag for average air temperature
    ## 4      airtmax average maximum air temperature. Average of daily maximums.
    ## 5    f.airtmax                    flag for average maximum air temperature
    ## 6      airtmin average minimum air temperature. Average of daily minimums.
    ## 7    f.airtmin                    flag for average minimum air temperature
    ## 8      airtmmx extreme maximum air temperature. Maximum of daily maximums.
    ## 9    f.airtmmx                    flag for extreme maximum air temperature
    ## 10     airtmmn extreme minimum air temperature. Minimum of daily minimums.
    ## ..         ...                                                         ...

``` r
# Or identically with dplyr alone:
#dplyr::bind_rows(lapply(stuff, function(x) data.frame(column.name = x@attributeName, definition = x@attributeDefinition)))

do.call(rbind, lapply(stuff, function(x) data.frame(column.name = x@attributeName, definition = x@attributeDefinition)))
```

    ##             column.name
    ## attribute          date
    ## attribute1         airt
    ## attribute2       f.airt
    ## attribute3      airtmax
    ## attribute4    f.airtmax
    ## attribute5      airtmin
    ## attribute6    f.airtmin
    ## attribute7      airtmmx
    ## attribute8    f.airtmmx
    ## attribute9      airtmmn
    ## attribute10   f.airtmmn
    ## attribute11        prec
    ## attribute12      f.prec
    ## attribute13        slrt
    ## attribute14      f.slrt
    ## attribute15        part
    ## attribute16      f.part
    ## attribute17        netr
    ## attribute18      f.netr
    ## attribute19        wspd
    ## attribute20      f.wspd
    ## attribute21        wres
    ## attribute22      f.wres
    ## attribute23        wdir
    ## attribute24      f.wdir
    ## attribute25        gspd
    ## attribute26      f.gspd
    ## attribute27        s10t
    ## attribute28      f.s10t
    ##                                                                                                                                                           definition
    ## attribute                                                                                                                                                       date
    ## attribute1                                                                                                       average air temperature. Average of daily averages.
    ## attribute2                                                                                                                          flag for average air temperature
    ## attribute3                                                                                               average maximum air temperature. Average of daily maximums.
    ## attribute4                                                                                                                  flag for average maximum air temperature
    ## attribute5                                                                                               average minimum air temperature. Average of daily minimums.
    ## attribute6                                                                                                                  flag for average minimum air temperature
    ## attribute7                                                                                               extreme maximum air temperature. Maximum of daily maximums.
    ## attribute8                                                                                                                  flag for extreme maximum air temperature
    ## attribute9                                                                                               extreme minimum air temperature. Minimum of daily minimums.
    ## attribute10                                                                                                                 flag for extreme minimum air temperature
    ## attribute11                                                                             total precipitation. Includes water equivalent of snow. Sum of daily totals.
    ## attribute12                                                                                                                                   flag for precipitation
    ## attribute13                                                                                           average total global solar radiation. Average of daily totals.
    ## attribute14                                                                                                            flag for average total global solar radiation
    ## attribute15                                                                              average total photosynthetically active radiation. Average of daily totals.
    ## attribute16                                                                                               flag for average total photosynthetically active radiation
    ## attribute17 average net radiation. Includes short and long wave. Corrected for wind speeds above 5 m/s using Cambell Scientific equation. Average of daily averages.
    ## attribute18                                                                                                                           flag for average net radiation
    ## attribute19                                                                                         average horizontal scalar wind speed. Average of daily averages.
    ## attribute20                                                                                                             flag for average horizonal scalar wind speed
    ## attribute21                                                                        Average horizontal resultant vector wind speed. Vector average of daily averages.
    ## attribute22                                                                                                   flag for average horizonal resultant vector wind speed
    ## attribute23                                 average horizontal vector wind direction. Measured in degrees clockwise from true north. Vector average of daily values.
    ## attribute24                                                                                                         flag for average horizonal vector wind direction
    ## attribute25                                                                                                   extreme maximum gust speed. Maximum of daily maximums.
    ## attribute26                                                                                                                      flag for extreme maximum gust speed
    ## attribute27                                                                                       average soil temperature at 10cm depth. Average of daily averages.
    ## attribute28                                                                                                                        flag for average soil temperature

This creates a `data.frame` with two columns: the name of every column in Table 4, and a description of what each of those 29 columns contains. Similarly we can create a `data.frame` that summarizes all of the tables in the dataset:

``` r
purrr::map_df(obj@dataset@dataTable, function(dt) 
  data.frame(table.id = dt@id,
             table.description = dt@entityDescription))
```

    ## Source: local data frame [11 x 2]
    ## 
    ##    table.id              table.description
    ##       (chr)                          (chr)
    ## 1  hf001-01                    station log
    ## 2  hf001-02     annual (metric) since 2002
    ## 3  hf001-03    annual (english) since 2002
    ## 4  hf001-04    monthly (metric) since 2001
    ## 5  hf001-05   monthly (english) since 2001
    ## 6  hf001-06      daily (metric) since 2001
    ## 7  hf001-07     daily (english) since 2001
    ## 8  hf001-08      hourly (metric) 2001-2004
    ## 9  hf001-09     hourly (english) 2001-2004
    ## 10 hf001-10  15-minute (metric) since 2005
    ## 11 hf001-11 15-minute (english) since 2005

and we can also combine this information directly with the `data.frame` describing the attributes of each table:

``` r
df <-
purrr::map_df(obj@dataset@dataTable, function(dt) 
  data.frame(table.id = dt@id,
             table.description = dt@entityDescription, 
             purrr::map_df(dt@attributeList@attribute, function(x) 
               data.frame(column.name = x@attributeName, column.definition = x@attributeDefinition))))
```

    ## Warning in data.frame(table.id = dt@id, table.description =
    ## dt@entityDescription, : row names were found from a short variable and have
    ## been discarded

    ## Warning in data.frame(table.id = dt@id, table.description =
    ## dt@entityDescription, : row names were found from a short variable and have
    ## been discarded

    ## Warning in data.frame(table.id = dt@id, table.description =
    ## dt@entityDescription, : row names were found from a short variable and have
    ## been discarded

    ## Warning in data.frame(table.id = dt@id, table.description =
    ## dt@entityDescription, : row names were found from a short variable and have
    ## been discarded

    ## Warning in data.frame(table.id = dt@id, table.description =
    ## dt@entityDescription, : row names were found from a short variable and have
    ## been discarded

    ## Warning in data.frame(table.id = dt@id, table.description =
    ## dt@entityDescription, : row names were found from a short variable and have
    ## been discarded

    ## Warning in data.frame(table.id = dt@id, table.description =
    ## dt@entityDescription, : row names were found from a short variable and have
    ## been discarded

    ## Warning in data.frame(table.id = dt@id, table.description =
    ## dt@entityDescription, : row names were found from a short variable and have
    ## been discarded

    ## Warning in data.frame(table.id = dt@id, table.description =
    ## dt@entityDescription, : row names were found from a short variable and have
    ## been discarded

    ## Warning in data.frame(table.id = dt@id, table.description =
    ## dt@entityDescription, : row names were found from a short variable and have
    ## been discarded

    ## Warning in data.frame(table.id = dt@id, table.description =
    ## dt@entityDescription, : row names were found from a short variable and have
    ## been discarded

``` r
df
```

    ## Source: local data frame [330 x 4]
    ## 
    ##    table.id          table.description column.name
    ##       (chr)                      (chr)       (chr)
    ## 1  hf001-01                station log        date
    ## 2  hf001-01                station log       notes
    ## 3  hf001-02 annual (metric) since 2002        date
    ## 4  hf001-02 annual (metric) since 2002        airt
    ## 5  hf001-02 annual (metric) since 2002      f.airt
    ## 6  hf001-02 annual (metric) since 2002     airtmax
    ## 7  hf001-02 annual (metric) since 2002   f.airtmax
    ## 8  hf001-02 annual (metric) since 2002     airtmin
    ## 9  hf001-02 annual (metric) since 2002   f.airtmin
    ## 10 hf001-02 annual (metric) since 2002     airtmmx
    ## ..      ...                        ...         ...
    ## Variables not shown: column.definition (chr)

This permits us to use typical R manipulations to quickly search this metadata, for instance, to identify which tables contain information about, say, the extreme maximum air temperature over monthly intervals:

``` r
df %>% filter(grepl("extreme maximum air temperature", column.definition), grepl("monthly", table.description))
```

    ## Source: local data frame [4 x 4]
    ## 
    ##   table.id            table.description column.name
    ##      (chr)                        (chr)       (chr)
    ## 1 hf001-04  monthly (metric) since 2001     airtmmx
    ## 2 hf001-04  monthly (metric) since 2001   f.airtmmx
    ## 3 hf001-05 monthly (english) since 2001     airtmmx
    ## 4 hf001-05 monthly (english) since 2001   f.airtmmx
    ## Variables not shown: column.definition (chr)
