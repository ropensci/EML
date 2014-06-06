<!--
%\VignetteEngine{knitr}
%\VignetteIndexEntry{Advanced parsing of EML}
-->




In [Advanced parsing and manipulation of EML](https://github.com/ropensci/EML/blob/master/inst/doc/Advanced_parsing_of_EML.md), we

- Introduce how to access any EML element in R using the S4 subsetting mechanism
- Illustrate how EML metadata extraction can be applied across a collection of files 
- Illustrate how EML manipulation can be combined with queries across even larger distributed collections of EML data over the dataone network
- Demonstrate how to extract and manipulate semantic RDF triples from EML metadata
- Demonstrate merging of multiple datasets based on semantics


EML (the Ecological Metadata Language) is formatted using XML (eXtensible Markup Language) acording to a specified XML Schema.  XML uses a heirarchical or treed structure to represent information.  Different types of information are identified by name-value pairs.  Nodes specifiy names such as `<title>` or `<creator>` in angle brackets.  The value is enclosed between opening and closing elements, such as `<title>This is the title</title>`.  The heirarichal structure indicates components of the element, such as: 

```xml
<individualName>
  <givenName>John</givenName>
  <surName>Smith</surName>
</individualName>
```

Nodes can also specify information as attributes, such as `<individualName id=45>`, indicating the node has an `id` with the value `45`.  In EML attributes are rarely used for information other than identifiers on the nodes.  



```r
library(EML)
```


The EML package represents nodes defined in the EML schema as R objects using R's S4 object mechanism. We can create a new object corresponding to any node defined in the EML Schema using the `new()` function; such as:


```r
node <- new("individualName")
node
```

```
An object of class "individualName"
Slot "salutation":
character(0)

Slot "givenName":
character(0)

Slot "surName":
character(0)
```

Showing our object in the console reveals that it has three slots, `salutation`, `givenName`, and `surName`, each currently with the value of a length zero character string.  We can assign values to the slots using the S4 subsetting operator `@` (most R users may be more familiar with subsetting S3 objects or lists by using the `$` operator)


```r
node@givenName <- "John"
```

Alternatively, we can use the `slot` function: 


```r
slot(node, "givenName") <- "John"
```

Each of these operations can also be used (without the assignment operator `<-`) to access the value of the slot, e.g. 


```r
node@givenName
```

```
[1] "John"
```








