## R Puzzles 

_This file contains a running list of questions I have for @duncantl or whomever, largely arising as I try to understand the S4 based approach to representing the schema and various puzzles that arise in the process._

- [ ]  Why do I lose names when coercing between (named) character strings and lists (and vice versa)? (try `as(list(a=1, b=2), "character")`)
 
- [ ]  I set prototype for a slot, install package, remove prototype for that slot, reinstall package, prototype is still set! Huh? (Deleting the installed package location and the local namespace and then re-roxygening and installing seems to fix this).  
 
- [ ]  What's up with "labels" on factors? They overwrite my levels and everything.  

- [ ]  Best way to handle optional elements (when we'd rather not specify default values)?  Ideally would have something such that `addChildren(parent, class@empty_option)` would not do anything when the slot was truly empty.  
 
- [ ]  "One or more", "Zero or more" everything needs a `ListOf` class.  Goodness, but this is annoying.  

- [ ]  Related: In the schema, sometimes a list of elements has a parent node, e.g. `<attributeList>`, followed by `<attribute>` `<attribute>` , ... sometimes it doesn't.  Does it make sense to write an extra object class associated with the first case (e.g. class for attributeList?)?  
 
- [ ]  Stategies for file organization when defining S4 objects?  Do I need to define the elementary types first?  How do I avoid all the "class not defined" errors on installing package?
 
- [ ]  Attributes: A bit annoying that the S4 representation we're using uses slots for attributes as well as node/values without indiciation of which is which, but I guess it's okay.  We could map them in S4 to a attr slot..
 
- [ ]  Do we write into XML as a coercion method, `setAs("class", "XMLInternalNode", function(from){...` or with some other kind of function?  

- [ ]  How do we handle coercion of S4 objects into S3 objects (and vice versa)?  Can we make S4 objects work in S3 functions?  What's the deal with `setOldClass` and `S3part`?  

- [ ]  XML Schema (XSD I guess I could say) has notion of sharing a bunch of slots using entity-groups.  I guess we just put all members of the group in as seperate slots each time? (Simple enough when XMLSchema is generating the class definitions I guess).  

Answer: Just use `contains` in the `setClass` definition

- [ ]  Strategies for mixing XMLSchema generated class definitions and manual class definitions of schema objects?  (namespaces for classes)

- [ ]  Coercion to promote types or better to explicitly call new?  

Answer: Using "new", we must know the slot name corresponding to the type.  Coercion allows us to specify the type, e.g.

```
setAs("eml:nominal", "eml:measurementScale", function(from) new("eml:measurementScale", nominal = from))
setAs("eml:ordinal", "eml:measurementScale", function(from) new("eml:measurementScale", ordinal = from))
```

can be used with `as(from[[3]], from[[4]])`, reading the class name from a varaible instead of hardwiring the slot name. The coercion methods take care of mapping the class names to the appropriate slot names.  


- [ ]  Common attributes for all nodes an easy way? For example, character / numeric types, in the schema can all have id attributes.  I suppose programmatic solution is to make every node a class? would we have `setClass('somenode', representation(title="eml:title"...` and then `setClass("eml:title", representation(title = "character", id = "character")`?  
