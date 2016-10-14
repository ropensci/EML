print_xml_structure <-
  function (x,
            prefix = 0,
            indent = 2,
            html = TRUE)
  {
    padding <- paste(rep(" ", prefix), collapse = "")
    type <- xml_type(x)
    if (type == "element") {
      attr <- xml_attrs(x)
      if (html) {
        html_attrs <- list()
        if ("name" %in% names(attr)) {
          html_attrs$name <- paste0("#", attr[["name"]])
          attr <- attr[setdiff(names(attr), "name")]
        }
        if ("type" %in% names(attr)) {
          html_attrs$class <- paste0(".", gsub(" ", ".",
                                               attr[["type"]]))
          attr <- attr[setdiff(names(attr), "type")]
        }
        attr_str <- paste(unlist(html_attrs), collapse = " ")
      }
      else {
        attr_str <- ""
      }
      if (length(attr) > 0) {
        attr_str <- paste0(attr_str, " [", paste0(names(attr),
                                                  collapse = ", "), "]")
      }
      node <- paste0("<", xml_name(x), attr_str, ">")
      cat(padding, node, "\n", sep = "")
      lapply(
        xml_contents(x),
        print_xml_structure,
        prefix = prefix +
          indent,
        indent = indent,
        html = html
      )
    }
    else {
      if (type != "text")
        cat(padding, "{", type, "}\n", sep = "")
    }
    NULL
  }
