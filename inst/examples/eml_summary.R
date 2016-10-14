setMethod("summary", signature = "dataTable", function(dt) {
  attr <- get_attributes(dt)$attributes
  ## Drop all-NA columns
  attr <- attr[sapply(attr, function(x)
    ! all(is.na(x)))]

  cat(
    paste0(
      "EntityName: ",
      dt@entityName,
      "\n",
      "ObjectName: ",
      dt@physical[[1]]@objectName,
      "\n",
      "EntityDescription: ",
      dt@entityDescription,
      "\n",
      "EntityType: Delimited Text File, ",
      "sep = ",
      dt@physical[[1]]@dataFormat@textFormat@simpleDelimited@fieldDelimiter,
      "escape = ",
      dt@physical[[1]]@dataFormat@textFormat@simpleDelimited@literalCharacter,
      "quote = ",
      dt@physical[[1]]@dataFormat@textFormat@simpleDelimited@quoteCharacter
    ),
    "\n\n",
    head(attr)
  )
})
