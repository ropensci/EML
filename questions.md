## Questions for Duncan

_This file contains a running list of questions I have for Duncan (or whomever), largely arising as I try to understand the S4 based approach to representing the schema and various puzzles that arise in the process._

- Why do I lose names when coercing between (named) character strings and lists (and vice versa)?  
 
- I set prototype for a slot, install package, remove prototype for that slot, reinstall package, prototype is still set! Huh? (Deleting the installed package location and the local namespace and then re-roxygening and installing seems to fix this).  
 
- What's up with "labels" on factors? They overwrite my levels and everything.  

- Best way to handle optional elements (when we'd rather not specify default values)?  Ideally would have something such that `addChildren(parent, class@empty_option)` would not do anything when the slot was truly empty.  
 
- "One or more", "Zero or more" everything needs a `ListOf` class.  Goodness, but this is annoying.  

- Related: Sometimes a list of elements has a parent node, e.g. `<attributeList>`, followed by `<attribute>` `<attribute>` , ... sometimes it doesn't.  Extra object associated with the first case?  
 
- File organization of S4 objects: do I need to define the elementary types first?  Avoid all the "class not defined" errors on installing package...
 
- Attributes: A bit annoying that the S4 representation we're using uses slots for attributes as well as node/values without indiciation of which is which, but I guess it's okay.  We could map them in S4 to a attr slot..
 
- Do we write into XML as a coercion method, `as("class", "XMLInternalNode", function(from){...` or 

- How do we handle coercion of S4 objects into S3 objects (and vice versa)?  Can we make S4 objects work in S3 functions?  What's the deal with `setOldClass` and `S3part`?  

- XML Schema (XSD I guess I could say) has notion of sharing a bunch of slots using entity-groups.  I guess we just put all members of the group in as seperate slots each time? (Simple enough when XMLSchema is generating the class definitions I guess).  

- Strategies for mixing XMLSchema generated class definitions and manual class definitions of schema objects?  (namespaces for classes)

- Common attributes for all nodes an easy way? For example, character / numeric types, in the schema can all have id attributes.  I suppose programmatic solution is to make every node a class? would we have `setClass('somenode', representation(title="eml:title"...` and then `setClass("eml:title", representation(title = "character", id = "character")`?  
