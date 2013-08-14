# based on knitr functions for options

new_defaults = function(value = list()) {
  defaults = value

  get = function(name, default = FALSE) {
    if (default) defaults = value  # this is only a local version
    if (missing(name)) defaults else {
      if (length(name) == 1) defaults[[name]] else defaults[name]
    }
  }
  set = function(...) {
    dots = list(...)
    if (length(dots) == 0) return()
    if (is.null(names(dots)) && length(dots) == 1 && is.list(dots[[1]]))
      dots = dots[[1]]
    defaults <<- merge(dots)
    invisible(NULL)
  }
  merge = function(values) merge_list(defaults, values)
  restore = function(target = value) defaults <<- target

  list(get = get, set = set, merge = merge, restore = restore)
}

#' Default and current chunk options
#' @export
eml_config = new_defaults(list("default_rights" = "<a rel='license' 
                                               property='http://creativecommons.org/ns#license' 
                                               href='http://creativecommons.org/publicdomain/zero/1.0/'>CC0</a>", 
                        "contact_givenName" = character(0),
                        "contact_surName" = character(0),
                        "contact_email" = character(0)))

options(default_rights = "<a rel='license' property='http://creativecommons.org/ns#license' href='http://creativecommons.org/publicdomain/zero/1.0/'>CC0</a>")


#' Set aliases for chunk options
#'
#' We do not have to use the chunk option names given in \pkg{knitr}; we can set
#' aliases for them. The aliases is a named character vector; the names are
#' aliases and the elements in this vector are the real option names.
#' @param ... named arguments (argument names are aliases, and argument values
#'   are real chunk options)
#' @return NULL (\code{eml$get('aliases')} is modified as the side effect)
#' @export
set_aliases = function(...) {
  eml$set(aliases = c(...))
}


# merge elements of y into x with the same names
merge_list = function(x, y) {
  x[names(y)] = y
  x
}


